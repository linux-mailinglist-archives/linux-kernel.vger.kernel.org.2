Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072A035F993
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbhDNRNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:13:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:3013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233433AbhDNRNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:13:06 -0400
IronPort-SDR: 2PmhoVAwWOTQE0xI9e/8q64dsIY9t2swHHTc/CETmjbQb8RRpp6XuCAD9hOqU83GsaCjz6D/e2
 d2r91TZpjVIg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181811918"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181811918"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:12:45 -0700
IronPort-SDR: gyfisw2WbfZBLaum65VkszCJUaZs6T6OMlF/Vb0xQPdKFiVd+70jPbyYZcnVhexvkfM2LJUo1v
 j6uHr2M4mEwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="382427953"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2021 10:12:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/7] intel_th: Constify all drvdata references
Date:   Wed, 14 Apr 2021 20:12:47 +0300
Message-Id: <20210414171251.14672-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anything that deals with drvdata structures should leave them intact.
Reflect this in function signatures.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c     | 2 +-
 drivers/hwtracing/intel_th/intel_th.h | 6 +++---
 drivers/hwtracing/intel_th/pci.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index c9ac3dc65113..24d0c974bfd5 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -844,7 +844,7 @@ static irqreturn_t intel_th_irq(int irq, void *data)
  * @irq:	irq number
  */
 struct intel_th *
-intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
+intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 	       struct resource *devres, unsigned int ndevres)
 {
 	int err, r, nr_mmios = 0;
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 5fe694708b7a..05fa2dab37d1 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -74,7 +74,7 @@ struct intel_th_drvdata {
  */
 struct intel_th_device {
 	struct device		dev;
-	struct intel_th_drvdata *drvdata;
+	const struct intel_th_drvdata *drvdata;
 	struct resource		*resource;
 	unsigned int		num_resources;
 	unsigned int		type;
@@ -224,7 +224,7 @@ static inline struct intel_th *to_intel_th(struct intel_th_device *thdev)
 }
 
 struct intel_th *
-intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
+intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 	       struct resource *devres, unsigned int ndevres);
 void intel_th_free(struct intel_th *th);
 
@@ -272,7 +272,7 @@ struct intel_th {
 
 	struct intel_th_device	*thdev[TH_SUBDEVICE_MAX];
 	struct intel_th_device	*hub;
-	struct intel_th_drvdata	*drvdata;
+	const struct intel_th_drvdata	*drvdata;
 
 	struct resource		resource[TH_MMIO_END];
 	int			(*activate)(struct intel_th *);
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 251e75c9ba9d..759994055cb4 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -71,7 +71,7 @@ static void intel_th_pci_deactivate(struct intel_th *th)
 static int intel_th_pci_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
-	struct intel_th_drvdata *drvdata = (void *)id->driver_data;
+	const struct intel_th_drvdata *drvdata = (void *)id->driver_data;
 	struct resource resource[TH_MMIO_END + TH_NVEC_MAX] = {
 		[TH_MMIO_CONFIG]	= pdev->resource[TH_PCI_CONFIG_BAR],
 		[TH_MMIO_SW]		= pdev->resource[TH_PCI_STH_SW_BAR],
-- 
2.30.2

