Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC3354FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhDFJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhDFJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:26:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E71C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:26:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s21so7601666pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9aauEj0ZznO9LzKslz62xYfWSRsY7rwUuiLDdRfB74=;
        b=fjWJDRbldFVlvO4zkZJQyJKIRAAbm80Vl9BjmTAzp94b2Gbj1V4ZMJvd+h2myJySEu
         Bn0hrzUlDR+MSaUMVED0H1qEVOgQCB2J5ofzTRRSdAXp/Uj1qUqkWtBIqaycypvIdVoD
         lGp4ouOgXnx9DWlnOOaMxWGjFbmQQ/J1XjPassnAs5RFWj5axewls+T+BBCl7cXIrOgy
         jJdbwez6Q/9ZLHZFNatV+BfDJeLiAyJn3AqIJB+wx4Tefk+d/OV2JijgfHF8dDkWuPcZ
         sfaaBvGxMDZpEWa3a59lxCPV7n/M28thc6yGsfjD/pWM04Dxeslmf7R9LJ4IwdNm+IR3
         srOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9aauEj0ZznO9LzKslz62xYfWSRsY7rwUuiLDdRfB74=;
        b=pOlWCE7AyTxZ8qd2XW6PH9pLobwliJkNWD2GTF/m7KgjulDlv9GDMsdd0q+noSx4W8
         gbYbXcOQX784LMQUgUtXz21wKFVpDTO41YkPhp/sLfn7S7paWviHDLEvmFGKP7sDMroI
         GTdc5MJoOxU1xhPG+DAFEgkVRfO5pK55K9in1vTwp6vPBcvSPwowkpyM+S5Bl9TeejV6
         TSQWh4riAereVhOjNAw4PvI/2UXdsClXk5+EQ2HHkEeq/YpSekI7z/oQwBs+1QKQEKHX
         AyeLN+b195P3QNkAwDVxRBpyn77Io4AiYuppAaoXRpeDGzrxmb3HdwowBDzfSv+Aousm
         8Kqw==
X-Gm-Message-State: AOAM530lXplwzI/6NDakHIVTLC3MSADNlp1k1nasaSnRboUNZVmUud3o
        rCL7LhoMkm2ctO+8sHgb22gx8g==
X-Google-Smtp-Source: ABdhPJwg9APLF5QDj3ZWbb0zY8K+pD55HInxwlo7zs4IjEZ+8gAm316DirXcyzUK4NPF9AlzQvnsiA==
X-Received: by 2002:a17:90a:1d08:: with SMTP id c8mr3675584pjd.139.1617701201659;
        Tue, 06 Apr 2021 02:26:41 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w7sm13685589pff.208.2021.04.06.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:26:41 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, paul.walmsley@sifive.com, hes@sifive.com,
        erik.danie@sifive.com, zong.li@sifive.com, bhelgaas@google.com,
        robh+dt@kernel.org, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
Date:   Tue,  6 Apr 2021 17:26:28 +0800
Message-Id: <20210406092634.50465-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes SiFive FU740 PCIe host controller driver. We also
add pcie_aux clock and pcie_power_on_reset controller to prci driver for
PCIe driver to use it.

This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
v5.11 Linux kernel.

Changes in v5:
 - Fix typo in comments
 - Keep comments style consistent
 - Refine some error handling codes
 - Remove unneeded header file including
 - Merge fu740_pcie_ltssm_enable implementation to fu740_pcie_start_link

Changes in v4:
 - Fix Wunused-but-set-variable warning in prci driver

Changes in v3:
 - Remove items that has been defined
 - Refine format of sifive,fu740-pcie.yaml
 - Replace perstn-gpios with the common one
 - Change DBI mapping space to 2GB from 4GB
 - Refine drivers/reset/Kconfig

Changes in v2:
 - Refine codes based on reviewers' feedback
 - Remove define and use the common one
 - Replace __raw_writel with writel_relaxed
 - Split fu740_phyregreadwrite to write function
 - Use readl_poll_timeout in stead of while loop checking
 - Use dwc common codes
 - Use gpio descriptors and the gpiod_* api.
 - Replace devm_ioremap_resource with devm_platform_ioremap_resource_byname
 - Replace devm_reset_control_get with devm_reset_control_get_exclusive
 - Add more comments for delay and sleep
 - Remove "phy ? x : y" expressions
 - Refine code logic to remove possible infinite loop
 - Replace magic number with meaningful define
 - Remove fu740_pcie_pm_ops
 - Use builtin_platform_driver

Greentime Hu (5):
  clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
  clk: sifive: Use reset-simple in prci driver for PCIe driver
  MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
  dt-bindings: PCI: Add SiFive FU740 PCIe host controller
  riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC

Paul Walmsley (1):
  PCI: fu740: Add SiFive FU740 PCIe host controller driver

 .../bindings/pci/sifive,fu740-pcie.yaml       | 113 +++++++
 MAINTAINERS                                   |   8 +
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  33 ++
 drivers/clk/sifive/Kconfig                    |   2 +
 drivers/clk/sifive/fu740-prci.c               |  11 +
 drivers/clk/sifive/fu740-prci.h               |   2 +-
 drivers/clk/sifive/sifive-prci.c              |  54 +++
 drivers/clk/sifive/sifive-prci.h              |  13 +
 drivers/pci/controller/dwc/Kconfig            |   9 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c       | 308 ++++++++++++++++++
 drivers/reset/Kconfig                         |   1 +
 include/dt-bindings/clock/sifive-fu740-prci.h |   1 +
 13 files changed, 555 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-fu740.c

-- 
2.30.2

