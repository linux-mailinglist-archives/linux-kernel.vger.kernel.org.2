Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3E32A7BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbhCBQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:29:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:45327 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578312AbhCBOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:09:47 -0500
IronPort-SDR: K7r4vHo9ApudH4zEEukB3puIxRhuMGy+5khM0RgdYivdrpbst9iGbjwVtAAHFQaTWJVUqLUUic
 Gw5sPbEqWRkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186875224"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186875224"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:56:32 -0800
IronPort-SDR: OJGfYUaLDyye6fn3rzxWDc8ycT00Vhy7np5QGWGX4X3uDEpklkU5+TEz28MGEMKjl7QzcJ2Pz9
 N7/rqB4Wl97g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406065322"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 05:56:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8209DF4; Tue,  2 Mar 2021 15:56:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 2/5] mfd: intel_quark_i2c_gpio: Unregister resources in reversed order
Date:   Tue,  2 Mar 2021 15:56:17 +0200
Message-Id: <20210302135620.89958-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ->remove() unregister resources in reversed order, i.e. MFD devices first
followed by I²C clock.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 124c0ee84169..db756b74195a 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -269,8 +269,8 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 
 static void intel_quark_mfd_remove(struct pci_dev *pdev)
 {
-	intel_quark_unregister_i2c_clk(&pdev->dev);
 	mfd_remove_devices(&pdev->dev);
+	intel_quark_unregister_i2c_clk(&pdev->dev);
 }
 
 static struct pci_driver intel_quark_mfd_driver = {
-- 
2.30.1

