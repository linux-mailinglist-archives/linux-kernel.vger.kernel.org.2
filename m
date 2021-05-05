Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9458374985
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhEEUiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhEEUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:38:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C464C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:37:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leOHL-0001jU-RQ; Wed, 05 May 2021 22:37:55 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leOHK-0007Zr-Tc; Wed, 05 May 2021 22:37:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] intel_th: Remove an unused exit point from intel_th_remove()
Date:   Wed,  5 May 2021 22:37:48 +0200
Message-Id: <20210505203748.200499-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

As described in the added comment device_for_each_child never returns
a non-zero value. So remove the corresponding error check.

This simplifies the quest to make struct bus_type::remove() return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwtracing/intel_th/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 24d0c974bfd5..4bf025ef2031 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -100,16 +100,18 @@ static int intel_th_remove(struct device *dev)
 	struct intel_th_driver *thdrv = to_intel_th_driver(dev->driver);
 	struct intel_th_device *thdev = to_intel_th_device(dev);
 	struct intel_th_device *hub = to_intel_th_hub(thdev);
-	int err;
 
 	if (thdev->type == INTEL_TH_SWITCH) {
 		struct intel_th *th = to_intel_th(hub);
 		int i, lowest;
 
-		/* disconnect outputs */
-		err = device_for_each_child(dev, thdev, intel_th_child_remove);
-		if (err)
-			return err;
+		/*
+		 * disconnect outputs
+		 *
+		 * intel_th_child_remove returns 0 unconditionally, so there is
+		 * no need to check the return value of device_for_each_child.
+		 */
+		device_for_each_child(dev, thdev, intel_th_child_remove);
 
 		/*
 		 * Remove outputs, that is, hub's children: they are created

base-commit: d665ea6ea86c785760ee4bad4543dab3267ad074
-- 
2.30.2

