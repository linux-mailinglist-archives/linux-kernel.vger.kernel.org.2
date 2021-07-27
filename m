Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB13D70DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhG0II5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhG0IIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:08:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB24EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 01:08:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8w-0006lW-S3; Tue, 27 Jul 2021 10:08:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8w-0005tH-A9; Tue, 27 Jul 2021 10:08:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8v-0004Fq-8c; Tue, 27 Jul 2021 10:08:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 5/5] zorro: Drop useless (and hardly used) .driver member in struct zorro_dev
Date:   Tue, 27 Jul 2021 10:08:40 +0200
Message-Id: <20210727080840.3550927-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=pmjSFJgiGq+U+H3CBWUtkP58VVEoLG7cpjdWHdR3CZ8=; m=FwdYfuXhIdRMPqSe3OwjYngIShcXM10vmffUOUO3sq8=; p=BqkauY1Zj1byJtFkCzSN5UR2hPpa5BAO6PtAQB2p6Aw=; g=c7bb075638575448decef685c2188fa5a39a619a
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD/vwQACgkQwfwUeK3K7AmePwgAoB0 IKrE425l9kWjEDl2CeZ2DInBPaXKelIVEboXvwPIHD+6knLc/ZcMHNytzj7U0lMF8A/DpKJkvMMRN gz121NWVcw3ryUhcjV3HMeemF4XTnPvvOpvyfNagoR3AP6veBX05ndPazKW/k0QzrLemi2mACC8/4 JcVkX+zFcoAZCkh35NBuuvanB/+VmHo3APHJlAqfbVW/C4W4cirvD3BfXL5yKYHKYhguzipZecXyE TWrPYgqAy6rhaxrwYmI7s+p9OF7eMlL5YkvjiqDHi0ruX5kvH6S98PhaPGdz8U49ODVA5/BXCKv+v FHrinA7VbnvRuKq2nSB1CPE7Cz/qikg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only actual use is to check in zorro_device_probe() that the device
isn't already bound. The driver core already ensures this however so the
check can go away which allows to drop the then assigned-only member
from struct zorro_dev.

If the value was indeed needed somewhere it can always be calculated by

	to_zorro_driver(z->dev.driver)

.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/zorro/zorro-driver.c | 7 ++-----
 include/linux/zorro.h        | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index ab06c9ce2c78..96f068830549 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -47,16 +47,14 @@ static int zorro_device_probe(struct device *dev)
 	struct zorro_driver *drv = to_zorro_driver(dev->driver);
 	struct zorro_dev *z = to_zorro_dev(dev);
 
-	if (!z->driver && drv->probe) {
+	if (drv->probe) {
 		const struct zorro_device_id *id;
 
 		id = zorro_match_device(drv->id_table, z);
 		if (id)
 			error = drv->probe(z, id);
-		if (error >= 0) {
-			z->driver = drv;
+		if (error >= 0)
 			error = 0;
-		}
 	}
 	return error;
 }
@@ -69,7 +67,6 @@ static void zorro_device_remove(struct device *dev)
 
 	if (drv->remove)
 		drv->remove(z);
-	z->driver = NULL;
 }
 
 
diff --git a/include/linux/zorro.h b/include/linux/zorro.h
index e2e4de188d84..db7416ed6057 100644
--- a/include/linux/zorro.h
+++ b/include/linux/zorro.h
@@ -29,7 +29,6 @@
 struct zorro_dev {
     struct ExpansionRom rom;
     zorro_id id;
-    struct zorro_driver *driver;	/* which driver has allocated this device */
     struct device dev;			/* Generic device interface */
     u16 slotaddr;
     u16 slotsize;
-- 
2.30.2

