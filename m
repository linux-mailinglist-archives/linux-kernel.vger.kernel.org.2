Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5EF3DBEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhG3TK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhG3TK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:10:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E131C061796
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:10:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu6-00068f-Mc; Fri, 30 Jul 2021 21:10:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu5-0005yk-UY; Fri, 30 Jul 2021 21:10:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m9Xu5-0007KV-To; Fri, 30 Jul 2021 21:10:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Finn Thain <fthain@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 1/4] nubus: Simplify check in remove callback
Date:   Fri, 30 Jul 2021 21:10:32 +0200
Message-Id: <20210730191035.1455248-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
References: <20210730191035.1455248-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=TjLBJt0QGxFmp7SpMOjzQEIkuFPLuMwSswChhiWQZSU=; m=qsAB52XGlHgDkCXw/bmGf7NdcrsOl5sRO45qYx4/rUE=; p=Y7UBaaGsszQzvtKk/Xj3uSk938y5pFeeoLuZiSQOfmc=; g=c25b7253ee9694e5d77118adf90c05984d48eb27
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEETp4ACgkQwfwUeK3K7An4rgf/S7c 9q0QjNEdQrzp5+trJO4rJhJvFza/BMJNIfMteBrYj63Rvc/8lQfiNOiL5VhAfUWxqyy3SljCxtU5h yUDAMFJFAEgEDg3XbsblQQu6zTRFvXGFaE0OePb7xJZL185iEvKGTOuAvDTnBjNQZLQ6hRI46xeOA VzY3OX6mM9MsvhhZhqzcTFdEkVew3Z5k57DZh3/hZoL+yW6XVHI/Ts9B511w7AQv9Ot31dJvezdB5 rf8vUazcJndbUXS0QmO19+BSXRWJmq3zPI9/EmOZPxJmyoojgbFbFRq9g8dpKq5brnR/So6U+CEY0 lEZ6ueTbBJmoSRawU1V2qC3BOtCn6PA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core only calls a remove callback when the device was
successfully bound (aka probed) before. So dev->driver is never NULL and
the respective check can just be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/nubus/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index d9d04f27f89b..17fad660032c 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -33,7 +33,7 @@ static void nubus_device_remove(struct device *dev)
 {
 	struct nubus_driver *ndrv = to_nubus_driver(dev->driver);
 
-	if (dev->driver && ndrv->remove)
+	if (ndrv->remove)
 		ndrv->remove(to_nubus_board(dev));
 }
 
-- 
2.30.2

