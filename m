Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54332329741
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbhCAWgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhCARjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:39:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B59C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:38:53 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGmVP-0004Ij-Le; Mon, 01 Mar 2021 18:38:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGmVO-0003C2-Ul; Mon, 01 Mar 2021 18:38:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pcmcia: ds: Remove if with always false condition
Date:   Mon,  1 Mar 2021 18:38:47 +0100
Message-Id: <20210301173847.1679956-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia_device_remove() is only ever called by the driver core with
dev->driver pointing to a valid driver. (And even if dev->driver was
NULL, p_drv wouldn't be NULL as p_drv is assigned as follows:

	p_drv = to_pcmcia_drv(dev->driver);

and to_pcmcia_drv is a container_of operation on struct
pcmcia_driver::drv which isn't the first member in struct
pcmcia_driver.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pcmcia/ds.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 72114907c0e4..bb096a3b76aa 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -371,9 +371,6 @@ static int pcmcia_device_remove(struct device *dev)
 		pcmcia_card_remove(p_dev->socket, p_dev);
 
 	/* detach the "instance" */
-	if (!p_drv)
-		return 0;
-
 	if (p_drv->remove)
 		p_drv->remove(p_dev);
 
-- 
2.30.0

