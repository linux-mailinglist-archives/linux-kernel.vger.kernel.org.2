Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D804229CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhJEOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235750AbhJEOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:00:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE88561074;
        Tue,  5 Oct 2021 13:58:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxe-0055e7-0Z; Tue, 05 Oct 2021 09:58:26 -0400
Message-ID: <20211005135825.861518453@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 02/27] kprobes: Use helper to parse boolean input from userspace
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punitagrawal@gmail.com>

The "enabled" file provides a debugfs interface to arm / disarm
kprobes in the kernel. In order to parse the buffer containing the
values written from userspace, the callback manually parses the user
input to convert it to a boolean value.

As taking a string value from userspace and converting it to boolean
is a common operation, a helper kstrtobool_from_user() is already
available in the kernel. Update the callback to use the common helper
to parse the write buffer from userspace.

Link: https://lkml.kernel.org/r/163163032637.489837.10678039554832855327.stgit@devnote2

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1cf8bca1ea86..26fc9904c3b1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2770,30 +2770,14 @@ static ssize_t read_enabled_file_bool(struct file *file,
 static ssize_t write_enabled_file_bool(struct file *file,
 	       const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	char buf[32];
-	size_t buf_size;
-	int ret = 0;
-
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
+	bool enable;
+	int ret;
 
-	buf[buf_size] = '\0';
-	switch (buf[0]) {
-	case 'y':
-	case 'Y':
-	case '1':
-		ret = arm_all_kprobes();
-		break;
-	case 'n':
-	case 'N':
-	case '0':
-		ret = disarm_all_kprobes();
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
 
+	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
 	if (ret)
 		return ret;
 
-- 
2.32.0
