Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC931CDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhBPQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:11:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:31316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhBPQLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:11:10 -0500
IronPort-SDR: OeJcOXnrtMjBQ3fYpvCrCp49g8SNUao9g+oaaQQDDpAdTBRn515sX1N+UKrUUfsoCp7p+LVR+e
 UnqxGDkZ8tOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118498"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:01 -0800
IronPort-SDR: s0RaILNxhblE5wzIo9O/GIfFgjyDDk2ug2vYR/0LQuE+QAF7ejtbBcLTh7Wu6VcQ2QOOXQ73X9
 Wu9YUx84Veow==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336645"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:07:58 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 03/12] gna: read hardware info in the driver
Date:   Tue, 16 Feb 2021 17:05:16 +0100
Message-Id: <20210216160525.5028-4-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Get the hardware information from register MMIO_IBUFFS

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/gna/gna_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index a6ef7e790e9e..869507594f9e 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -6,10 +6,13 @@
 
 #include "gna_device.h"
 #include "gna_driver.h"
+#include "gna_hw.h"
 
 static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
+	u32 bld_reg;
+
 	pci_set_drvdata(pcidev, gna_priv);
 
 	gna_priv->parent = &pcidev->dev;
@@ -17,6 +20,9 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	gna_priv->info = *(struct gna_drv_info *)pci_id->driver_data;
 	gna_priv->drv_priv = &gna_drv_priv;
 
+	bld_reg = gna_reg_read(gna_priv->bar0.mem_addr, GNA_MMIO_IBUFFS);
+	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
+
 	return 0;
 }
 
-- 
2.28.0

