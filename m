Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52D73583CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhDHMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhDHMwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D84D661131;
        Thu,  8 Apr 2021 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886325;
        bh=Z8eCvPg57DOepyVIgLWqWFWWF8NgHq57aSbQYfH+jMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uafsZnnsvSw8CjPTp4JNLFiOI+S9P1YuKZRyS9flzUuAn/QgZ6PUJrQhfCpnEl7Pv
         hund2f9lWB/3BBDVPdNn0eb8XPIRNL+nerOxjl089OVt+vH+2u+Z7ZKFXy4b1JUbU2
         ZaRJrVQTAKkMReXmBjcreC5QL1dLJLkv8E5gEsPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 04/13] tty: remove tty_notice()
Date:   Thu,  8 Apr 2021 14:51:25 +0200
Message-Id: <20210408125134.3016837-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 3 users of tty_notice() and replace them with calls to
dev_notice() which provides more information about the tty that has the
error and uses the standard formatting logic.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty.h    | 1 -
 drivers/tty/tty_io.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index eda037c48317..0323bc2cd6ba 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -10,7 +10,6 @@
 	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
 
 #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-#define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
 #define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
 
 #define tty_info_ratelimited(tty, f, ...) \
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f8b96f3674af..0079ffd0cb9c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3059,7 +3059,7 @@ void __do_SAK(struct tty_struct *tty)
 	read_lock(&tasklist_lock);
 	/* Kill the entire session */
 	do_each_pid_task(session, PIDTYPE_SID, p) {
-		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
+		dev_notice(tty->dev, "SAK: killed process %d (%s): by session\n",
 			   task_pid_nr(p), p->comm);
 		group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 	} while_each_pid_task(session, PIDTYPE_SID, p);
@@ -3067,7 +3067,7 @@ void __do_SAK(struct tty_struct *tty)
 	/* Now kill any processes that happen to have the tty open */
 	do_each_thread(g, p) {
 		if (p->signal->tty == tty) {
-			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
+			dev_notice(tty->dev, "SAK: killed process %d (%s): by controlling tty\n",
 				   task_pid_nr(p), p->comm);
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 			continue;
@@ -3075,7 +3075,7 @@ void __do_SAK(struct tty_struct *tty)
 		task_lock(p);
 		i = iterate_fd(p->files, 0, this_tty, tty);
 		if (i != 0) {
-			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
+			dev_notice(tty->dev, "SAK: killed process %d (%s): by fd#%d\n",
 				   task_pid_nr(p), p->comm, i - 1);
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 		}
-- 
2.31.1

