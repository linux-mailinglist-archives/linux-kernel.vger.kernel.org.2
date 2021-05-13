Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3AD37F639
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEMLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:03:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:45133 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232320AbhEMLCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:02:16 -0400
IronPort-SDR: U/BXwl/hh83/5ILD+pjaeGMUsEV7+ipqZME6MVNivp3jEiNnLT37juvF5lUa1LY29Vt1Y0zdIP
 kGjpuapnRDzw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048276"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:02 -0700
IronPort-SDR: /jUSWvsBR/ZzeILd2CcLHSaBvVx/xVbYBpr+1Uzg4fYexL71YsjmEgCbWH5zRgUTpOmMuDcgzc
 twcaaXriCYpQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625983828"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:00:59 -0700
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
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v3 03/14] intel_gna: read hardware info in the driver
Date:   Thu, 13 May 2021 13:00:29 +0200
Message-Id: <20210513110040.2268-4-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
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
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/device.c | 4 ++++
 drivers/misc/intel/gna/device.h | 1 +
 drivers/misc/intel/gna/hw.h     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index 8722935d26bf..45b4b6df64ef 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -21,6 +21,7 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	static atomic_t dev_last_idx = ATOMIC_INIT(-1);
 	struct gna_private *gna_priv;
 	const char *dev_misc_name;
+	u32 bld_reg;
 	int ret;
 
 	gna_priv = devm_kzalloc(parent, sizeof(*gna_priv), GFP_KERNEL);
@@ -48,6 +49,9 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 		}
 	}
 
+	bld_reg = gna_reg_read(gna_priv, GNA_MMIO_IBUFFS);
+	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
+
 	return 0;
 }
 
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index a188f482a273..057dec0e1983 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -24,6 +24,7 @@ struct gna_private {
 	/* device related resources */
 	void __iomem *iobase;
 	struct gna_dev_info info;
+	struct gna_hw_info hw_info;
 };
 
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase);
diff --git a/drivers/misc/intel/gna/hw.h b/drivers/misc/intel/gna/hw.h
index f9c0566cbe60..f61792f9dd52 100644
--- a/drivers/misc/intel/gna/hw.h
+++ b/drivers/misc/intel/gna/hw.h
@@ -47,6 +47,10 @@ struct gna_desc_info {
 	struct gna_mmu_info mmu_info;
 };
 
+struct gna_hw_info {
+	u8 in_buf_s;
+};
+
 struct gna_dev_info {
 	u32 hwid;
 	u32 num_pagetables;
-- 
2.28.0

