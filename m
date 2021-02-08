Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1FA3139CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhBHQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhBHPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:15:20 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C1C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:14:40 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id p30so38786qva.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=KABW1PbKP87UHlmwOVcrjPZPD/KiH4IFW6HwyHI8HLw=;
        b=kr+DrTDoxze6WtQfMls46jXxBjSG77mJ9I1UggF24KPM+dYnraeCGycYUpkq5gsGgm
         kibQqpuTfoxap6xotSDDdjpoPXvOJ1uun8NEjyD5+5IiUD7/BJO6OqLvmC95JUGQeKRc
         Is5YDrVr7KcJBN9mWP70aj6FTRyqFnn3R/fcb+5Ej2GzftP6YNCnJ29pVF1IUe7yKwlp
         DcG/ZR178QIbXKx9La6i8tMFzDJCzyxe8Z/idbEQO1a1u8Z7uJ+KDIkTeBIG0Ed8d9lt
         XfIGNBE/xM6N0E4LMJJyLh1i4ozo3BOhm2HkWhamdubJR3jueoQaw/a8czMNAVycDwXS
         wKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=KABW1PbKP87UHlmwOVcrjPZPD/KiH4IFW6HwyHI8HLw=;
        b=n6Od3m7wm5yZIms0j+G6zHZEpdFUok81cbM7jhn1jm5X6qku/Nmg69/YZrjvuSpkCE
         /29WjaUdqOnftvr7ZZHsq87KfC7jdIMnIK6nOYG/ywTS7fDs8LaJXKZnOSxSttgOPsfb
         BERwIPug11UTE6LK2ihFaKAqSlOyc9BeWh+g9P6eIfO/PNe+i92zj4J6My16H3SGLEWW
         /Mgb/3YX4PNQYm7ZHNc870V8/WvaxQMfQWS1n0og612ae2cBvkS6URzWUGpAFpf3le8j
         WtwdeAdJsjCXmYzikcHAcCMOXFMbpwv4q5wXri7imCzYL2/m6263sbaSOSYVRrAz+vI+
         FYbg==
X-Gm-Message-State: AOAM532bTOImDlBVth1ExrmEDCx7sRjJe/OEDocQRN6OFm0a6AMIqTRs
        ywPM7ixifkmz9h48FVOhd6cTtd9C/ttoPu06lQ==
X-Google-Smtp-Source: ABdhPJzuXaTRTgc+EAuykmBzD3iqNY/rHmUzDcRcTAMRZk6QDJfaHi7NSpPJJ27dJ73RTtDxK542lXuw7axQ6iUCkw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:1904:: with SMTP id
 er4mr16277873qvb.56.1612797279931; Mon, 08 Feb 2021 07:14:39 -0800 (PST)
Date:   Mon,  8 Feb 2021 15:14:27 +0000
Message-Id: <20210208151437.1357458-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        willy@infradead.org, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Anand K Mistry <amistry@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android captures per-process system memory state when certain low memory
events (e.g a foreground app kill) occur, to identify potential memory
hoggers. In order to measure how much memory a process actually consumes,
it is necessary to include the DMA buffer sizes for that process in the
memory accounting. Since the handle to DMA buffers are raw FDs, it is
important to be able to identify which processes have FD references to
a DMA buffer.

Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
/proc/<pid>/fdinfo -- both are only readable by the process owner,
as follows:
  1. Do a readlink on each FD.
  2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
  3. stat the file to get the dmabuf inode number.
  4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.

Accessing other processes' fdinfo requires root privileges. This limits
the use of the interface to debugging environments and is not suitable
for production builds.  Granting root privileges even to a system process
increases the attack surface and is highly undesirable.

Since fdinfo doesn't permit reading process memory and manipulating
process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v2:
  - Update patch description

 fs/proc/base.c |  4 ++--
 fs/proc/fd.c   | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..a37f9de7103f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3160,7 +3160,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	DIR("task",       S_IRUGO|S_IXUGO, proc_task_inode_operations, proc_task_operations),
 	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
 	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
-	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
+	DIR("fdinfo",     S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
 	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
@@ -3504,7 +3504,7 @@ static const struct inode_operations proc_tid_comm_inode_operations = {
  */
 static const struct pid_entry tid_base_stuff[] = {
 	DIR("fd",        S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
-	DIR("fdinfo",    S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
+	DIR("fdinfo",    S_IRUGO|S_IXUGO, proc_fdinfo_inode_operations, proc_fdinfo_operations),
 	DIR("ns",	 S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
 #ifdef CONFIG_NET
 	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index cb51763ed554..585e213301f9 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -6,6 +6,7 @@
 #include <linux/fdtable.h>
 #include <linux/namei.h>
 #include <linux/pid.h>
+#include <linux/ptrace.h>
 #include <linux/security.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
@@ -72,6 +73,18 @@ static int seq_show(struct seq_file *m, void *v)
 
 static int seq_fdinfo_open(struct inode *inode, struct file *file)
 {
+	bool allowed = false;
+	struct task_struct *task = get_proc_task(inode);
+
+	if (!task)
+		return -ESRCH;
+
+	allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+	put_task_struct(task);
+
+	if (!allowed)
+		return -EACCES;
+
 	return single_open(file, seq_show, inode);
 }
 
@@ -307,7 +320,7 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUSR);
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFREG | S_IRUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-- 
2.30.0.478.g8a0d178c01-goog

