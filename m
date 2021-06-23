Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BB3B1978
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFWMBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhFWMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:01:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:58:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q14so3084895eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Cr3FOxDCKFbZ45/SASs869fm2FT51Wxo7xPbqs8/OQ=;
        b=gldfewNMLkyVBMH/zlJu9aDAy2GDCrb6OuSVrhBktnKvPzf2RNRk4cI1/bOCodlS10
         3AaBKFrRULbImPzl78pRU2+0ZIzXteZASDPO6XkfLJKEf2FpPxXHOiAJEBCEd+zFb2lf
         R73DARnSiIkrpdW/FKTDnZhibzpFxEfy/7fFmuja4LzRTdCTxLLz5Rnc89dCnGEAooSS
         PudcjMDNYaO47DVWY5SzHxXqQqJ458XxBW390dDsDgQWEVwt4cFyX0PeCtaMkLev7fkz
         EZrJb88MnzFG2UUgo6QGFNt031UsJJ8PoZpR5xPo5wvuM9Pzb7Ych5z1D0jQJYmyiVyl
         e3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9Cr3FOxDCKFbZ45/SASs869fm2FT51Wxo7xPbqs8/OQ=;
        b=S/wYrj1D3op6eW7N3Zl6xJJpWKQoC9jdXanQASs4nnZoEi5N66MJYTaH2+30GMR2pW
         1wiZ9iVZPYNnbuCW0Nmi93afcZRedRyaN3s8ak7VaBIiBZHOwBRAYKmxYIIuN/Z1fLge
         7lEHcPZhDEnAbLm/uzuq/Zm7wQZdVu2NMRXKa2FZIOTExx/+mJAwAL6H6lDTU2B1h4We
         5v7+6BziQ0AV6aa0UMCegq4fLfVAEbWA6BYcZzgIcKq/zmIuLqJgYd/a3BYZs6/IyCKG
         7UmVYhQp27YzsirkjXbCPdzmIZ/1wkZRLO/NVuLZOkmqZE+8KtW2ScsQlDHXnIajieXE
         ZkLg==
X-Gm-Message-State: AOAM5321T2XX0AKAtEFgjUoyIIK11hNps+CBNtrxL9EqkQTUZjr3buZY
        vb4UGZRafCLakYxfhkTvJtUIwAaWvQVRcrRm
X-Google-Smtp-Source: ABdhPJzTGMoHx9VJNXaGAsxn/RTBQDeIVE7k0dF3mEuxYY5UUpBNGpCkhps+zH/xoatqoGTgVqX46Q==
X-Received: by 2002:a05:6402:3138:: with SMTP id dd24mr11675698edb.92.1624449522943;
        Wed, 23 Jun 2021 04:58:42 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id i10sm6252318edt.25.2021.06.23.04.58.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 04:58:42 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: xilinx-nwl: Enable the clock through CCF
Date:   Wed, 23 Jun 2021 13:58:41 +0200
Message-Id: <dbc0ab2e109111ca814e73abb30a1dda5d333dbe.1624449519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyun Kwon <hyun.kwon@xilinx.com>

Simply enable clocks. There is no remove function that's why
this should be enough for simple operation.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8689311c5ef6..3afd4f89ba77 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -6,6 +6,7 @@
  * (C) Copyright 2014 - 2015, Xilinx, Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -169,6 +170,7 @@ struct nwl_pcie {
 	u8 last_busno;
 	struct nwl_msi msi;
 	struct irq_domain *legacy_irq_domain;
+	struct clk *clk;
 	raw_spinlock_t leg_mask_lock;
 };
 
@@ -823,6 +825,11 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk))
+		return PTR_ERR(pcie->clk);
+	clk_prepare_enable(pcie->clk);
+
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
 		dev_err(dev, "HW Initialization failed\n");
-- 
2.32.0

