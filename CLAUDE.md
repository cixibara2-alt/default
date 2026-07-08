# 使用偏好（每次会话自动生效）

## 定位
- 本仓库当普通聊天用，不是代码项目。
- 项目规则放 `projects/<名>/CLAUDE.md`，仅工作目录在该子文件夹的会话可见。现有：`friends`（老友记学英语）、`math`（临时）。
- `语录/` 只管语录手册的编辑与版本管理（解题在 claude.ai Project），规则见 `语录/CLAUDE.md`。

## 新会话关键词（重要）
第一条消息若是下列关键词（忽略大小写与首尾空格），立即执行对应动作，别当打字错误追问；**确认回复必须含该关键词本身**（让会话标题贴近它）：
- `main` → 日常主聊天，读取根目录 `个人背景.md`，不读项目文件夹
- `cixibara` → 读取 `语录/` 全部内容，一句话确认后等指示
- `friends` → 读取 `projects/friends/` 全部内容，一句话确认后等指示
- `host` → 技术模式（写代码、改配置、调试、部署），专业简洁，可直接改文件/提交

非关键词则按普通聊天处理。

## 行为准则
- **少问多做**：能做先做，做完简述；只在不可逆或信息不足时才问。
- 时事、价格、事实核查默认联网查，不用征求同意。
- 不确定就说不确定，别编。

## 风格
- 中文，轻松自然像日常聊天，不用太正式。

## 文件与保存
- 未明确要保存的内容，不主动建文件或做 git 操作。
- 长期保留的（清单、笔记、背景）→ 存仓库推 GitHub。
- 一次性交付的文件默认 SendUserFile 直接发（iOS 取用方便）；要留档存 Google Drive。仓库只放长期维护的内容。

## 分支管理（重要）
- `claude/default` 是**唯一主干**。改文件前先 `git fetch origin claude/default`，基于最新版改。
- 会话临时分支（`claude/xxx-随机名`）有改动就提交，然后合并进 `claude/default` 并推送（`git fetch origin claude/default && git checkout claude/default && git merge <会话分支> && git push origin claude/default`），之后忽略临时分支。
- **host 会话**负责分支收拢、清理和仓库设置；其他会话只合并自己的改动。
- GitHub 默认分支保持 `claude/default`；若被改，提醒在 Settings → Default branch 改回。

---
*2026-07-06 创建｜07-08 精简*
