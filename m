Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA06B37F63B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEMLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:03:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:45141 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232940AbhEMLCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:20 -0400
IronPort-SDR: poBYz2QKiyXRmgSDNuZgIUyT3hSDVvCbEKDDf1dcl0x5lboSnJH/WtZ/YWnY/saObQLZ+E9/rv
 Sl7jI9Y527gA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048298"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048298"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:07 -0700
IronPort-SDR: oRrRNuMNPtq/+ZrkwyvS/ajAnIZybwfvicLx4XPNkqaaa3Durn/yvWi8qiBaIqoGX1iOxIn0yh
 Y14QTp808c2w==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984040"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:05 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: [PATCH v3 05/14] intel_gna: initialize mmu
Date:   Thu, 13 May 2021 13:00:31 +0200
Message-Id: <20210513110040.2268-6-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Setup mmu in the driver with a new memory component.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-Developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index ed7d3c0223df..50cac8139dcc 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -59,6 +59,18 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	bld_reg = gna_reg_read(gna_priv, GNA_MMIO_IBUFFS);
 	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 
+	ret = gna_mmu_alloc(gna_priv);
+	if (ret) {
+		dev_err(parent, "mmu allocation failed\n");
+		return ret;
+
+	}
+	dev_dbg(parent, "maximum memory size %llu num pd %d\n",
+		gna_priv->info.max_hw_mem, gna_priv->info.num_pagetables);
+	dev_dbg(parent, "desc rsvd size %d mmu vamax size %d\n",
+		gna_priv->info.desc_info.rsvd_size,
+		gna_priv->info.desc_info.mmu_info.vamax_size);
+
 	mutex_init(&gna_priv->mmu_lock);
 
 	idr_init(&gna_priv->memory_idr);
-- 
2.28.0

