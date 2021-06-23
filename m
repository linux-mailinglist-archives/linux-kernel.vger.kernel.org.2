Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3B3B1B09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFWNZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhFWNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:25:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C529CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:23:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i5so3507387eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sU2PjGEWCZ6p9REJDqxsU1/Bx6ufu3H69HOZKZG7O/o=;
        b=UCMvs7T6LglSDEVEHetpgrckvcGhBuq33yujZkz8EmBV08pEe8HxMFgrnzCmgBgaLn
         qc4ue3gpkOKavg5ZBg2DhvbWCSPemVD9NeyAXq8FB0CvpdRnCk645IfE9ROgK+EItULr
         1MdeK/XdD0fW6ZqdnSyJ4hc1yuvos/yvDwtlzwX+SN0WuW/UurttXyvtpv8zkzK1g7Wj
         21e9tjJdK2jNaUE7HeYJC8ygmmq5nUy57i3k/i1p8JhGU5gFqZdBi2tRWz34aJj7DtPy
         cSnp1yN+Cs5c0faZcdaxpQ7xb/0EkNtSTuk4d4iD0gXuis3HK12wTP9mvQeFEsWJ5ADt
         UDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sU2PjGEWCZ6p9REJDqxsU1/Bx6ufu3H69HOZKZG7O/o=;
        b=sFWz38vfFc+LDO2LkLkoDo7ezg0zXNdpZURfZCyMo72HjNDfodOghr9MOyPWHGKPO5
         +hedFJqQ+Pdg4JivjyqvZ4Bj6Zzhy55d2XRIU2+fReTa2CzbZQ71yhMzQs1MI8kWIgJv
         P4C78sM6zJwwLo98plrVtEL/hvixaz0KzLT0IPT3glBxwAmsxLJjvNi4dtoqIvmXOfHP
         hslGGcgcdJb2pmSrlyLB8BI+5rTmHvhogEH6syzRWYPt+C0CqSfT3Yl3wAnBQc6B5oSb
         3cWq2lS6ABdgt8GpvzFyM+bdAnWrNWEDrrsKumI+r/TJDY1HIs+rhc6AgLuBnZpTneu8
         /nDQ==
X-Gm-Message-State: AOAM530kKACJbCzU+aai0fAkUQrvv9mp35jXAGUgH8M6rpmGAnPlPBJ2
        t0z3rc20AHKjnbdB4cmpdRjw3dzPfRru+uss
X-Google-Smtp-Source: ABdhPJxBXwhpnsDk4vGkm1oHbYosJ1sYshqtefU8piT3JnF1ANjAmJQrE4ECvh7GlyGRtopnMwnl8g==
X-Received: by 2002:a05:6402:c03:: with SMTP id co3mr12380973edb.21.1624454615247;
        Wed, 23 Jun 2021 06:23:35 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id h20sm7090846ejl.7.2021.06.23.06.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 06:23:34 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        bharat.kumar.gogada@xilinx.com, kw@linux.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: xilinx-nwl: Enable the clock through CCF
Date:   Wed, 23 Jun 2021 15:23:30 +0200
Message-Id: <be603822953d0a815034a952b9c71bac642f22ae.1624454607.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1624454607.git.michal.simek@xilinx.com>
References: <cover.1624454607.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyun Kwon <hyun.kwon@xilinx.com>

Enable PCIE reference clock. There is no remove function that's why
this should be enough for simple operation.
Normally this clock is enabled by default by firmware but there are
usecases where this clock should be enabled by driver itself.
It is also good that clock user is recorded in clock framework.

Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Update commit message - reported by Krzysztof
- Check return value from clk_prepare_enable() - reported by Krzysztof

 drivers/pci/controller/pcie-xilinx-nwl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8689311c5ef6..67639f5a5e79 100644
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
 
@@ -823,6 +825,16 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	pcie->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->clk))
+		return PTR_ERR(pcie->clk);
+
+	err = clk_prepare_enable(pcie->clk);
+	if (err) {
+		dev_err(dev, "can't enable pcie ref clock\n");
+		return err;
+	}
+
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
 		dev_err(dev, "HW Initialization failed\n");
-- 
2.32.0

