Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76532A7B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579104AbhCBQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:28:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:59645 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572969AbhCBOIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:08:11 -0500
IronPort-SDR: olC7RJWeG6o9ulMDmBYREsZ+nza8kggSw8qdzB86nnNwPHfP2WTza1Jt5B9uKZm3HpcYusWi6m
 rNk1pDblC1NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250860922"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="250860922"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 05:56:32 -0800
IronPort-SDR: 0RhpvEB2fMWbDQzvmu6p5i+rHDSlpqq4oXjdSVrHioAqsQ9Ta6wgtXYEyHNIihGOEpEM0R/9RA
 VFl/IP2HQAOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="444754547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2021 05:56:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6DF9B13A; Tue,  2 Mar 2021 15:56:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 3/5] mfd: intel_quark_i2c_gpio: Remove unused struct device member
Date:   Tue,  2 Mar 2021 15:56:18 +0200
Message-Id: <20210302135620.89958-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device pointer in the custom structure is not used anywhere,
remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index db756b74195a..053780539175 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -45,7 +45,6 @@
 #define INTEL_QUARK_I2C_CLK_HZ	33000000
 
 struct intel_quark_mfd {
-	struct device		*dev;
 	struct clk		*i2c_clk;
 	struct clk_lookup	*i2c_clk_lookup;
 };
@@ -239,7 +238,6 @@ static int intel_quark_mfd_probe(struct pci_dev *pdev,
 	if (!quark_mfd)
 		return -ENOMEM;
 
-	quark_mfd->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, quark_mfd);
 
 	ret = intel_quark_register_i2c_clk(&pdev->dev);
-- 
2.30.1

