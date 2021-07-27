Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84BD3D70DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhG0IIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbhG0IIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:08:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFEC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 01:08:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8v-0006l9-Kj; Tue, 27 Jul 2021 10:08:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8v-0005t2-3i; Tue, 27 Jul 2021 10:08:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8I8v-0004Fh-2v; Tue, 27 Jul 2021 10:08:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 4/5] zorro: Simplify remove callback
Date:   Tue, 27 Jul 2021 10:08:39 +0200
Message-Id: <20210727080840.3550927-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=2IHfhYKwbh9XCZ0XszehSQcpjlGMcK+XmwnHD2PqbFY=; m=9UHNse895G/vDh5P0mx6F6/J3P0ggUJrPURLuex7MUI=; p=NMbKzy49SX2G6O5rZrz4ze2ElKxz5AkSixdtDWWVYhQ=; g=6c0f3e7061faf1de64c915bdce3f6298646e583c
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD/vv8ACgkQwfwUeK3K7AkPpQgAjkb DBI8f2dvc9BfmEatLZwlL8CfwZ27PN1TUq4JzjNFbW0tMWFYc8X0R9+XwR8pxuYsL4F8h6zNmjK3B A9tJkUDfYwO8vBBIWMIHzXg8Tk3CbUpNTBTOg9bjzixxFVL4AMHTyiIFpVaroFvMhi8tOAFm7bKUl GJ3l4PQP+TDaEVa75U8gW/V5R75oF4josXqdmesL7/ueVC2g1HCb8XchLkwKV/M/aXyYCG7IIEjEp 4K7CPBrYZ6GTDhXP+6SsDoiF8g4Sbcfr/zpYz/9G8LsBMP0QNr3+A33SnQb0UwFrERzotF9HuQJWD Lt7v3G3GoMkyiRukkUCIc5ah3hYpFfQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core only calls a remove callback when the device was
successfully bound (aka probed) before. So dev->driver is never NULL.

(And even if it was NULL, to_zorro_driver(NULL) isn't ...)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/zorro/zorro-driver.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index c18524bb8b2a..ab06c9ce2c78 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -67,11 +67,9 @@ static void zorro_device_remove(struct device *dev)
 	struct zorro_dev *z = to_zorro_dev(dev);
 	struct zorro_driver *drv = to_zorro_driver(dev->driver);
 
-	if (drv) {
-		if (drv->remove)
-			drv->remove(z);
-		z->driver = NULL;
-	}
+	if (drv->remove)
+		drv->remove(z);
+	z->driver = NULL;
 }
 
 
-- 
2.30.2

