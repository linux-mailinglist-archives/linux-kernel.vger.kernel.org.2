Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185283DBEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhG3TLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhG3TK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:10:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963AC061799
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:10:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu7-00068n-0J; Fri, 30 Jul 2021 21:10:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu6-0005yt-GC; Fri, 30 Jul 2021 21:10:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu6-0007L0-FS; Fri, 30 Jul 2021 21:10:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 4/4] zorro: Drop useless (and hardly used) .driver member in struct zorro_dev
Date:   Fri, 30 Jul 2021 21:10:35 +0200
Message-Id: <20210730191035.1455248-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=pmjSFJgiGq+U+H3CBWUtkP58VVEoLG7cpjdWHdR3CZ8=; m=FwdYfuXhIdRMPqSe3OwjYngIShcXM10vmffUOUO3sq8=; p=BqkauY1Zj1byJtFkCzSN5UR2hPpa5BAO6PtAQB2p6Aw=; g=c7bb075638575448decef685c2188fa5a39a619a
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEETqgACgkQwfwUeK3K7Alv2ggAnkL HrzmiL+TmZP0QiWw2CkEMmEvBNZJ4Sjm+RSSLfd6BtkYNkWy5czU1iIDfSMs8UHfuTQ94NASPdyeM hWmDVFTeKEDzn5UlEk5y2e8W4wiY9y4ARv6xR2BVWwaZmjhgd3oEr0Ve+8Jy78HSnAT1+B1tsvcsn Mx1LjRhxB2GxJoQF5cwEcqiNE/5lnGt6YcHDydbJSQTcG2tkZXKHFmducgGEBfZpCIlyAllLTPMbW p6AUMexqpx9/eH2cWp699/xGGeMkX/lG/9UAKX7AzJ6uzmidT6ssI78aXAfjEa9ZZsNdnEy+YiPam SygG3WmdvPkK80TOVrMeOdeUhZivPpA==
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

