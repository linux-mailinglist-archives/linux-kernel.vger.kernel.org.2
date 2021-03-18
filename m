Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDC340058
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhCRHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhCRHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:39:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17810C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:39:53 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lMnFw-0008LU-QZ; Thu, 18 Mar 2021 08:39:44 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lMnFv-0003QY-3D; Thu, 18 Mar 2021 08:39:43 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel@pengutronix.de, stable@kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] driver core: clear deferred probe reason on probe retry
Date:   Thu, 18 Mar 2021 08:39:19 +0100
Message-Id: <20210318073921.13093-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When retrying a deferred probe, any old defer reason string should be
discarded. Otherwise, if probe is deferred again at a different spot,
but without setting a message, a now incorrect probe reason will remain.

This was observed with the i.MX I2C driver, which ultimately failed
to probe due to lack of the GPIO driver. The probe defer for GPIO
doesn't record a message, but a previous probe defer to clock_get did.
This had the effect that /sys/kernel/debug/devices_deferred listed
a misleading probe deferral reason.

Cc: stable@kernel.org
Fixes: d090b70ede02 ("driver core: add deferring probe reason to devices_deferred property")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/base/dd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..e2cf3b29123e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -97,6 +97,9 @@ static void deferred_probe_work_func(struct work_struct *work)
 
 		get_device(dev);
 
+		kfree(dev->p->deferred_probe_reason);
+		dev->p->deferred_probe_reason = NULL;
+
 		/*
 		 * Drop the mutex while probing each device; the probe path may
 		 * manipulate the deferred list
-- 
2.29.2

