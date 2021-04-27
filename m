Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA13F36C578
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhD0Lok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:44:40 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:39884 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhD0Loj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:44:39 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FV0K70vqXz2Tf6;
        Tue, 27 Apr 2021 13:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619523835;
        bh=IZcnfQ6CgXTBAgvjaUPyN1vA4boGqLo0EvUWEcb9U6g=;
        h=Subject:From:To:Cc:Date;
        b=pCwv/djdWkn5/1LNMKEe1+RXus3UZ/MajHiyb4TK/K56gADuvJiZUjbRUXM5rU+kM
         aST+Z5QXRwQuX6SStz4Svzk3ExoIZxXA1Ebzv9L+Ly/e0q2KANEl0LAntpJA94wENF
         dU2mu8SJVC9Zswbii7vGR/j6SNiaHQor5TD9NHHs=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FV0K70nl3zTbSqM;
        Tue, 27 Apr 2021 13:43:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AdLptnJ0iltf; Tue, 27 Apr 2021 13:43:54 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Tue, 27 Apr 2021 13:43:27 +0200 (CEST)
Message-ID: <1502946c760b1aae3ad9cffcf4ea3b9f37206585.camel@t-2.net>
Subject: [PATCH 2/2] Removed unnecessary TTY ioctl callback
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Apr 2021 13:43:26 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns-out, that TIOCCONS is completely handled in tty_io.c, so
the current local ioctl callback is of no real use.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 drivers/char/ttyprintk.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 6f616cb7c..99364edf2 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -109,7 +109,6 @@ static int tpk_write(struct tty_struct *tty,
 	unsigned long flags;
 	int ret;
 
-
 	/* exclusive use of tpk_printk within this tty */
 	spin_lock_irqsave(&tpkp->spinlock, flags);
 	ret = tpk_printk(buf, count);
@@ -126,27 +125,6 @@ static int tpk_write_room(struct tty_struct *tty)
 	return TPK_MAX_ROOM;
 }
 
-/*
- * TTY operations ioctl function.
- */
-static int tpk_ioctl(struct tty_struct *tty,
-			unsigned int cmd, unsigned long arg)
-{
-	struct ttyprintk_port *tpkp = tty->driver_data;
-
-	if (!tpkp)
-		return -EINVAL;
-
-	switch (cmd) {
-	/* Stop TIOCCONS */
-	case TIOCCONS:
-		return -EOPNOTSUPP;
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
 /*
  * TTY operations hangup function.
  */
@@ -176,7 +154,6 @@ static const struct tty_operations ttyprintk_ops = {
 	.close = tpk_close,
 	.write = tpk_write,
 	.write_room = tpk_write_room,
-	.ioctl = tpk_ioctl,
 	.hangup = tpk_hangup,
 };
 
-- 
2.17.1


