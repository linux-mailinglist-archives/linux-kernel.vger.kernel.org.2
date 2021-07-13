Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7343C745F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhGMQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGMQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:23:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0503C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:20:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l4-20020a0ce8440000b02902d89f797d08so13802303qvo.17
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=HlZhn8bTk7Pd8D2oO7XiM4H58gYs+uOuZUkKviKIe5c=;
        b=lEeIFPCbZcEdLqOlxsw0keXyepK2TwJ+pvFcQgkeb5yCsCNrj1FUavWgGzJow0Dq+T
         X/DVvLiu6lIGGg2eo49DV5QV35qv6D+5YZmEdhz4ofvT31fNHeX8Dr+KGQAt7Lcf/rnm
         t94uQY+wWlF75KQlaGYuqwTCdE4cUSL2cyASo4zi0kujXLF0domFlzelG+a33rnuKH0n
         2Hi2h+U6i6YCUXTLippwJMLP/oC89zXYiD7/FOUA08KEnHf0h50KAI+n48DC6PRvm/xg
         DB5LkyFOwQThOURkX3sPo5PbPVeMU6JtwwkETYKWdxwZjmUjyWWaWLc6ItkqtQ3cBE9B
         S1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=HlZhn8bTk7Pd8D2oO7XiM4H58gYs+uOuZUkKviKIe5c=;
        b=bvf7ZGYOtVRgBzTfAhmfSdi1dldxLTNXHq2K+tEw//WqOylkf2Fsh7LmkaslsniCtq
         2Mgg63j2QjQLe0jX/tcC/9RPd6xvuVNodSlrOlfakYjqYkFxrxn5DY0Kw1K01PDgnvYg
         4fIjNSII3cg/uqn1vnzg90aiafimKCEDlkbHg/V1fBVjS4+9SMCJRnMi9jKac4bjGk9U
         AYnhocKLEO7TWk8eDvhc8Q9ahaLd9QqNYklHPdLoBUN10aeyrVa2kDTl1AD7JGw6SmZW
         7t8i7nOXjwqgEJ/vDDhQqzSiSdiQu+pjh5rHnZ1FzdUZdmrF9qtHPd0y9S62FIs0TNcN
         XAyA==
X-Gm-Message-State: AOAM531G2yfx7vyvOY+5X37unJtdtLDG3b72exUNhWI6Iyjzi9yqDNyI
        En4O9XSnZOlV4Rm3kbe8h+Ull84HKodcVKqQFg==
X-Google-Smtp-Source: ABdhPJwJwl1gRPx7HaxMVEbUQEMwr3jFEiYvlA0zbxFpgeI1hiPNTyGYNiacGzlsWjvdarKrouD6D1O8cvZHwKfmdQ==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:9e49:: with SMTP id
 z9mr5562386qve.52.1626193214017; Tue, 13 Jul 2021 09:20:14 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:20:04 +0000
Message-Id: <20210713162008.1056986-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] procfs: Prevent unpriveleged processes accessing fdinfo dir
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     hridya@google.com, surenb@google.com, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, torvalds@linux-foundation.org,
        christian.koenig@amd.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file permissions on the fdinfo dir from were changed from
S_IRUSR|S_IXUSR to S_IRUGO|S_IXUGO, and a PTRACE_MODE_READ check was
added for opening the fdinfo files [1]. However, the ptrace permission
check was not added to the directory, allowing anyone to get the open FD
numbers by reading the fdinfo directory.

Add the missing ptrace permission check for opening the fdinfo directory.

[1] https://lkml.kernel.org/r/20210308170651.919148-1-kaleshsingh@google.com

Fixes: 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
v1 of this patch was posted at:
https://lore.kernel.org/r/20210708155647.44208-1-kaleshsingh@google.com/

Changes in v2:
 - Drop the ptrace checks from read and lseek ops. The problem of accessing
   already opened files after a suid exec is pre-existing and not unique to
   fdinfo. Needs to be addressed separately in a more generic way.

 fs/proc/fd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 172c86270b31..913bef0d2a36 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -72,7 +72,7 @@ static int seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int seq_fdinfo_open(struct inode *inode, struct file *file)
+static int proc_fdinfo_access_allowed(struct inode *inode)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -86,6 +86,16 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 	if (!allowed)
 		return -EACCES;
 
+	return 0;
+}
+
+static int seq_fdinfo_open(struct inode *inode, struct file *file)
+{
+	int ret = proc_fdinfo_access_allowed(inode);
+
+	if (ret)
+		return ret;
+
 	return single_open(file, seq_show, inode);
 }
 
@@ -348,12 +358,23 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 				  proc_fdinfo_instantiate);
 }
 
+static int proc_open_fdinfo(struct inode *inode, struct file *file)
+{
+	int ret = proc_fdinfo_access_allowed(inode);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
 	.setattr	= proc_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
+	.open		= proc_open_fdinfo,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,

base-commit: 7fef2edf7cc753b51f7ccc74993971b0a9c81eca
-- 
2.32.0.93.g670b81a890-goog

