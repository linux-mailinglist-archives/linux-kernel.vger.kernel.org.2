Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76A640F6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbhIQLvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242157AbhIQLv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:51:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B9F461248;
        Fri, 17 Sep 2021 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631879404;
        bh=F+Bb0lcRPTSWghJbArRjnUckU6IKw5B96b0qVtK/W6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRFlLvy083MBGkjWdsTKj2odXXRp41oCBam2JTASf7oUCwYx7ny7Pop7BNAHfhG8D
         w8FpUrslDAl6DKEg3FGZ58zojg2+b54e+W2cg095bjOWa96bwtYY8Nhshj9Bkumu09
         mKJqUsLoWLssRbft4Pen7PptMrKLeYBZfhPVEvF8t21gykCoFHwkDejI+Yl5sdNx+5
         66N1qc8VhJGJVVXcBwU++eD1HiXrykyaF4HXJ+XON2HeQqe5J8XMwmut80EdC7FMnB
         gx2Vb2Dzemv8u+gOuMMxNoRQW5LH1tGRUsqO0GOIRrAtITt+f7EFc5MKR99lZBQ2lr
         ryVsI8D4VgrbQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mRCNa-0001Rd-2e; Fri, 17 Sep 2021 13:50:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/6] ipack: ipoctal: rename tty-driver pointer
Date:   Fri, 17 Sep 2021 13:46:22 +0200
Message-Id: <20210917114622.5412-7-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917114622.5412-1-johan@kernel.org>
References: <20210917114622.5412-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name "tty" is typically used for pointers to struct tty_struct.

Rename the tty-driver pointer used during registration to something more
apt to improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/ipack/devices/ipoctal.c | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index c709861198e5..20d2b9ec1227 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -276,7 +276,7 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 {
 	int res;
 	int i;
-	struct tty_driver *tty;
+	struct tty_driver *drv;
 	struct ipoctal_channel *channel;
 	struct ipack_region *region;
 	void __iomem *addr;
@@ -359,38 +359,38 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	/* Register the TTY device */
 
 	/* Each IP-OCTAL channel is a TTY port */
-	tty = tty_alloc_driver(NR_CHANNELS, TTY_DRIVER_REAL_RAW |
+	drv = tty_alloc_driver(NR_CHANNELS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV);
-	if (IS_ERR(tty))
-		return PTR_ERR(tty);
+	if (IS_ERR(drv))
+		return PTR_ERR(drv);
 
 	/* Fill struct tty_driver with ipoctal data */
-	tty->owner = THIS_MODULE;
-	tty->driver_name = KBUILD_MODNAME;
-	tty->name = kasprintf(GFP_KERNEL, KBUILD_MODNAME ".%d.%d.", bus_nr, slot);
-	if (!tty->name) {
+	drv->owner = THIS_MODULE;
+	drv->driver_name = KBUILD_MODNAME;
+	drv->name = kasprintf(GFP_KERNEL, KBUILD_MODNAME ".%d.%d.", bus_nr, slot);
+	if (!drv->name) {
 		res = -ENOMEM;
 		goto err_put_driver;
 	}
-	tty->major = 0;
-
-	tty->minor_start = 0;
-	tty->type = TTY_DRIVER_TYPE_SERIAL;
-	tty->subtype = SERIAL_TYPE_NORMAL;
-	tty->init_termios = tty_std_termios;
-	tty->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	tty->init_termios.c_ispeed = 9600;
-	tty->init_termios.c_ospeed = 9600;
-
-	tty_set_operations(tty, &ipoctal_fops);
-	res = tty_register_driver(tty);
+	drv->major = 0;
+
+	drv->minor_start = 0;
+	drv->type = TTY_DRIVER_TYPE_SERIAL;
+	drv->subtype = SERIAL_TYPE_NORMAL;
+	drv->init_termios = tty_std_termios;
+	drv->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	drv->init_termios.c_ispeed = 9600;
+	drv->init_termios.c_ospeed = 9600;
+
+	tty_set_operations(drv, &ipoctal_fops);
+	res = tty_register_driver(drv);
 	if (res) {
 		dev_err(&ipoctal->dev->dev, "Can't register tty driver.\n");
 		goto err_free_name;
 	}
 
 	/* Save struct tty_driver for use it when uninstalling the device */
-	ipoctal->tty_drv = tty;
+	ipoctal->tty_drv = drv;
 
 	for (i = 0; i < NR_CHANNELS; i++) {
 		struct device *tty_dev;
@@ -407,7 +407,7 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 		spin_lock_init(&channel->lock);
 		channel->pointer_read = 0;
 		channel->pointer_write = 0;
-		tty_dev = tty_port_register_device_attr(&channel->tty_port, tty,
+		tty_dev = tty_port_register_device_attr(&channel->tty_port, drv,
 							i, NULL, channel, NULL);
 		if (IS_ERR(tty_dev)) {
 			dev_err(&ipoctal->dev->dev, "Failed to register tty device.\n");
@@ -429,9 +429,9 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	return 0;
 
 err_free_name:
-	kfree(tty->name);
+	kfree(drv->name);
 err_put_driver:
-	tty_driver_kref_put(tty);
+	tty_driver_kref_put(drv);
 
 	return res;
 }
-- 
2.32.0

