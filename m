Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56793583CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhDHMwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231717AbhDHMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0005A61132;
        Thu,  8 Apr 2021 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886322;
        bh=wK0qF8mN/FNMrnpzruZZyssHrGyWckxYANmTf/5BrCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCFxg3bKIV8OERgjG3R8bQVyutO6wgJMgSMhAXasfgcN8815G7a5y8sI6rODuncnc
         g5O7g1iE0L54Ks0WdQDc+L3DAMxPgkoiEs3r5ubuF8eisZRWFXoUyTfGJq3dBqUsIC
         NHh8MxhVBJKXGPqMU/FIa1P8uKS2U0L4uHHrSpt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 03/13] tty: remove tty_err()
Date:   Thu,  8 Apr 2021 14:51:24 +0200
Message-Id: <20210408125134.3016837-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 2 users of tty_err() and replace it with calls to dev_err()
which provides more information about the tty that has the error and
uses the standard formatting logic.

Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_tty.c  | 2 +-
 drivers/tty/tty.h    | 1 -
 drivers/tty/tty_io.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ff1b3154ba0c..dbe208342258 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1483,7 +1483,7 @@ n_tty_receive_char_flagged(struct tty_struct *tty, unsigned char c, char flag)
 		n_tty_receive_overrun(tty);
 		break;
 	default:
-		tty_err(tty, "unknown flag %d\n", flag);
+		dev_err(tty->dev, "unknown flag %d\n", flag);
 		break;
 	}
 }
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 75624d7d84ae..eda037c48317 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -12,7 +12,6 @@
 #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
 #define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
 #define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
-#define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
 
 #define tty_info_ratelimited(tty, f, ...) \
 		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c95f72085cdb..f8b96f3674af 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1124,7 +1124,7 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 			return -EIO;
 	/* Short term debug to catch buggy drivers */
 	if (tty->ops->write_room == NULL)
-		tty_err(tty, "missing write_room method\n");
+		dev_err(tty->dev, "missing write_room method\n");
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return hung_up_tty_write(iocb, from);
-- 
2.31.1

