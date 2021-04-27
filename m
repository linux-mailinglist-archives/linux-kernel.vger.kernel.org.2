Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015F36C570
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhD0LmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhD0LmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:42:04 -0400
Received: from smtp-good-out-4.t-2.net (smtp-good-out-4.t-2.net [IPv6:2a01:260:1:4::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:41:21 -0700 (PDT)
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FV0G75TlYz2Tf6;
        Tue, 27 Apr 2021 13:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619523679;
        bh=yDAveNvUve6jxrXjv4kxvcwVWkJYIsNQGAVjolWaepk=;
        h=Subject:From:To:Cc:Date;
        b=x/xB7gGiA3bb7ELWE9BjsS+UEMGN+/QcXyOVu9Yt8V8l/NFHRAMKCl8u8ifLqHWNg
         0snqkR3W2P90Gz5pl8Dl8eeEqWarYl5m3Ze4sNpSVIrA6qCkBdEPUvghLtXX5og6AN
         p+d27JvpgZuQ2Vn4y0f1G+n3DjSqk2h1U4QZYHLo=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FV0G75MmJzTbSqM;
        Tue, 27 Apr 2021 13:41:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UoD-kfS1qygS; Tue, 27 Apr 2021 13:41:19 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Tue, 27 Apr 2021 13:40:51 +0200 (CEST)
Message-ID: <f236ea26520fbef176fefec2e06a43548f63fa9c.camel@t-2.net>
Subject: [PATCH 1/2] Add TTY port shutdown callback
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Apr 2021 13:40:51 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By adding the TTY port shutdown callback, the final buffer flush has
been moved from tpk_close() to tpk_port_shutdown(). This enables buffer
flush upon close and hangup as well. The change also removes the
specific 'buf == NULL' handling in tpk_printk(), which became useless.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 drivers/char/ttyprintk.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 93f5d11c8..6f616cb7c 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -54,11 +54,6 @@ static int tpk_printk(const unsigned char *buf, int count)
 {
 	int i = tpk_curr;
 
-	if (buf == NULL) {
-		tpk_flush();
-		return i;
-	}
-
 	for (i = 0; i < count; i++) {
 		if (tpk_curr >= TPK_STR_SIZE) {
 			/* end of tmp buffer reached: cut the message in two */
@@ -100,12 +95,6 @@ static int tpk_open(struct tty_struct *tty, struct file
*filp)
 static void tpk_close(struct tty_struct *tty, struct file *filp)
 {
 	struct ttyprintk_port *tpkp = tty->driver_data;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tpkp->spinlock, flags);
-	/* flush tpk_printk buffer */
-	tpk_printk(NULL, 0);
-	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
 }
@@ -168,6 +157,20 @@ static void tpk_hangup(struct tty_struct *tty)
 	tty_port_hangup(&tpkp->port);
 }
 
+/*
+ * TTY port operations shutdown function.
+ */
+static void tpk_port_shutdown(struct tty_port *tport)
+{
+	struct ttyprintk_port *tpkp =
+		container_of(tport, struct ttyprintk_port, port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&tpkp->spinlock, flags);
+	tpk_flush();
+	spin_unlock_irqrestore(&tpkp->spinlock, flags);
+}
+
 static const struct tty_operations ttyprintk_ops = {
 	.open = tpk_open,
 	.close = tpk_close,
@@ -177,7 +180,9 @@ static const struct tty_operations ttyprintk_ops = {
 	.hangup = tpk_hangup,
 };
 
-static const struct tty_port_operations null_ops = { };
+static const struct tty_port_operations tpk_port_ops = {
+	.shutdown = tpk_port_shutdown,
+};
 
 static struct tty_driver *ttyprintk_driver;
 
@@ -195,7 +200,7 @@ static int __init ttyprintk_init(void)
 		return PTR_ERR(ttyprintk_driver);
 
 	tty_port_init(&tpk_port.port);
-	tpk_port.port.ops = &null_ops;
+	tpk_port.port.ops = &tpk_port_ops;
 
 	ttyprintk_driver->driver_name = "ttyprintk";
 	ttyprintk_driver->name = "ttyprintk";
-- 
2.17.1


