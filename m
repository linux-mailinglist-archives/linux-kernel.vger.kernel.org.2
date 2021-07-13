Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73523C6B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhGMHnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhGMHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:43:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227CCC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:40:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1j-0003y1-4j; Tue, 13 Jul 2021 09:40:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1h-0006Q1-QE; Tue, 13 Jul 2021 09:40:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1h-0000vh-PH; Tue, 13 Jul 2021 09:40:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 3/5] s390/ccwgroup: Drop if with an always false condition
Date:   Tue, 13 Jul 2021 09:40:12 +0200
Message-Id: <20210713074014.684791-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713074014.684791-1-u.kleine-koenig@pengutronix.de>
References: <20210713074014.684791-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=72HAwW1ge0SaWF88KqTqoq0HiIxYHEA9VDa9pzFS5e8=; m=mnRcCYX4Soun6UkRo/vF3OKbvkroGEUnmAV+HlocHj8=; p=l/VUm/c+DmIdVO+6MJuUdAI6l1YC3XF2DMW0Cfqol+o=; g=f55f0fa1ad1e2a674f85b460588b66f70eaabd61
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDtQzsACgkQwfwUeK3K7AmcmwgAnkT cYRBTBw8fmtt/T5Hqo7TnYjhTn3xGElsbvwXNlEZZtlb07eiXwM5gTX7XkLrxZLdFxzvvKB1gQr3c f3aZHIrxdxFjti0ktTfzM5kdQX9Qid3uHozGyJMxdbD2PEOEDYh+w0BDo8FyJsNYfwiLmyTbKzKHN wkFoDaX5rqQZGwEXADGjdA76yxv26zIUBtx2yQyWgAbMwk2OcVEFxRW/ddPMyGEgTpyNmrDjQrUWz xaKau85Mq/z+svqzFSCht5SYVmi3mzMrIuySvqWvz4jmHmHZ5VEbZCI5McuW99V/KG//TBftwqD84 Qcn9Pd8fGoAjKIMo4YPNCBRQ41bKMTQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core only calls a bus remove callback when there is a driver.
So dev->driver is never NULL and the check can safely be removed.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/s390/cio/ccwgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 9748165e08e9..a6aeab1ea0ae 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -444,8 +444,6 @@ static int ccwgroup_remove(struct device *dev)
 	struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
 	struct ccwgroup_driver *gdrv = to_ccwgroupdrv(dev->driver);
 
-	if (!dev->driver)
-		return 0;
 	if (gdrv->remove)
 		gdrv->remove(gdev);
 
-- 
2.30.2

