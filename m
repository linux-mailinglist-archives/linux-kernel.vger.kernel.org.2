Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61D53127BC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 22:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBGV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 16:57:39 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:47654 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBGV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 16:57:33 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 48246AF2E92; Sun,  7 Feb 2021 22:56:51 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ipack: Fail earlier for drivers without probe function
Date:   Sun,  7 Feb 2021 22:55:55 +0100
Message-Id: <20210207215556.96371-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A driver without a probe function isn't useful as it can never be used.
Let registering such a driver fail already instead of failing every
binding.

This is only cosmetic as there is no ipack driver without a probe function.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/ipack/ipack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
index 9267a85fee18..eabc4d08792a 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -64,9 +64,6 @@ static int ipack_bus_probe(struct device *device)
 	struct ipack_device *dev = to_ipack_dev(device);
 	struct ipack_driver *drv = to_ipack_driver(device->driver);
 
-	if (!drv->ops->probe)
-		return -EINVAL;
-
 	return drv->ops->probe(dev);
 }
 
@@ -252,6 +249,9 @@ EXPORT_SYMBOL_GPL(ipack_bus_unregister);
 int ipack_driver_register(struct ipack_driver *edrv, struct module *owner,
 			  const char *name)
 {
+	if (!edrv->ops->probe)
+		return -EINVAL;
+
 	edrv->driver.owner = owner;
 	edrv->driver.name = name;
 	edrv->driver.bus = &ipack_bus_type;

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.29.2

