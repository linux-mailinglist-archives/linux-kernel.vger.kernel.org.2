Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35331CDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhBPQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:11:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:31327 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhBPQL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:11:27 -0500
IronPort-SDR: WUpvkNpQt70tY7W8iFjBHFo6cBojplwATU+g8OKTJBARLtv0zJ8J1REU4UYUipZJrYC5TcTl5r
 4Sh4/gfRKuPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118571"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:06 -0800
IronPort-SDR: MTa9uZTDMh1di0DSXzTM9oLHAJ1UNRaJaSKQ2cbSH8uWP+6Z/r+9kcxFYxVBt3wLb+ns/FJtu+
 jKDno47CC1+A==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336670"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:04 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: [PATCH v1 05/12] gna: initialize mmu
Date:   Tue, 16 Feb 2021 17:05:18 +0100
Message-Id: <20210216160525.5028-6-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

Setup mmu in the driver with a new memory component.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/gna/gna_device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index f962c7e1e5e9..d6a6d3cab570 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -23,6 +23,16 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	bld_reg = gna_reg_read(gna_priv->bar0.mem_addr, GNA_MMIO_IBUFFS);
 	gna_priv->hw_info.in_buf_s = bld_reg & GENMASK(7, 0);
 
+	if (gna_mmu_alloc(gna_priv)) {
+		dev_err(&gna_priv->dev, "gna mmu allocation failed\n");
+		return -EFAULT;
+	}
+	dev_dbg(&pcidev->dev, "maximum memory size %llu num pd %d\n",
+		gna_priv->info.max_hw_mem, gna_priv->info.num_pagetables);
+	dev_dbg(&pcidev->dev, "desc rsvd size %d mmu vamax size %d\n",
+		gna_priv->info.desc_info.rsvd_size,
+		gna_priv->info.desc_info.mmu_info.vamax_size);
+
 	mutex_init(&gna_priv->mmu_lock);
 
 	idr_init(&gna_priv->memory_idr);
@@ -35,6 +45,7 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 static void gna_dev_deinit(struct gna_private *gna_priv)
 {
 	idr_destroy(&gna_priv->memory_idr);
+	gna_mmu_free(gna_priv);
 	pci_set_drvdata(gna_priv->pdev, NULL);
 }
 
-- 
2.28.0

