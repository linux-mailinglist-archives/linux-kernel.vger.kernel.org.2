Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4C354FD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhDFJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhDFJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:26:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD3C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:26:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p10so2017551pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N3Ofv7Rek7cgGq9uaGjBnpEgWWaqpn6QcKrofIPEUwg=;
        b=HdpsD23ddU5o3+4Q3um01ArRXSBgFQCSf9fvg0Onusd7OTlW31mKWwVVtn9hRdNbl7
         NEL9XGb2EkF9EOtE4b3xKHdHa14BxAMMsBSHQLWu+kzl76nN+46LooziNw0id3gYtSgg
         3h+BFA7ULzSJJSZbS35OUhL5tfdzSKlyJcg1UJN8sW6TtnXtsqfKPeoTXGotlIgxbhon
         TCllR7Y0G6lrpPbffWItio84nYZ7tzm5HZcOgYzvTyRr3lhmMV2AHjCz/tK8jxyI0if2
         Ad7Nxiv9JBJvzh5D9XPCXCMs2vKpJI2V1WMUU2loiSOYonbSQS2NbSlPAZUsHRK/B1Nd
         bMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3Ofv7Rek7cgGq9uaGjBnpEgWWaqpn6QcKrofIPEUwg=;
        b=f7vO2nkmOQs7mLIdQkj7a9gPCkcv2DTKvO8RM2isLSd05Qo4Hwn9V/Mvmd99Hhsc+z
         rf4Ez6o2Rs27awz4o4gRRuXXU5MGZlaR3Kh5R8q6QxPgRxVroWx3sDpLDAQWrldqVjzd
         e8a9TANPBvuLq3MvhK5nrOHoJOu7YM04irE1m42+PVzRIrRna8419sgp5WtWeNu7U5cO
         CFOwS6WAgrWASt+DT8w3GSgdi3Y7MaEig/ibVwfipdRWcPrh+V9Wh2IxXU0/bcEwup64
         fFgdoD6Co6iEeNygex1uFI1C3yJkXwEyR0zBobeRZYRBTM5gYKrt5W7dYaA2ZvLuyPcV
         6PdA==
X-Gm-Message-State: AOAM532bWnUBSPkDx0hwH58dnNg9MrASDBaK2LUtcliP73/d/iP04eef
        Y4+ZEeE7PXxhRA4GbVycHbTBPA==
X-Google-Smtp-Source: ABdhPJzMuJPf8f4/IXZ9RS34Yy4BurTWBeHq615uq0YF1SvUR0UA0RpYGBc1YO+y3qX187XTl+JQlg==
X-Received: by 2002:a17:90a:7b85:: with SMTP id z5mr1861348pjc.39.1617701209420;
        Tue, 06 Apr 2021 02:26:49 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w7sm13685589pff.208.2021.04.06.02.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:26:48 -0700 (PDT)
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
Subject: [PATCH v5 2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
Date:   Tue,  6 Apr 2021 17:26:30 +0800
Message-Id: <20210406092634.50465-3-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406092634.50465-1-greentime.hu@sifive.com>
References: <20210406092634.50465-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use reset-simple in this patch so that pcie driver can use
devm_reset_control_get() to get this reset data structure and use
reset_control_deassert() to deassert pcie_power_up_rst_n.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sifive/Kconfig       |  2 ++
 drivers/clk/sifive/sifive-prci.c | 13 +++++++++++++
 drivers/clk/sifive/sifive-prci.h |  4 ++++
 drivers/reset/Kconfig            |  1 +
 4 files changed, 20 insertions(+)

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 1c14eb20c066..9132c3c4aa86 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -10,6 +10,8 @@ if CLK_SIFIVE
 
 config CLK_SIFIVE_PRCI
 	bool "PRCI driver for SiFive SoCs"
+	select RESET_CONTROLLER
+	select RESET_SIMPLE
 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
 	help
 	  Supports the Power Reset Clock interface (PRCI) IP block found in
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 8fdba5da2902..0704fddba6b9 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -583,6 +583,19 @@ static int sifive_prci_probe(struct platform_device *pdev)
 	if (IS_ERR(pd->va))
 		return PTR_ERR(pd->va);
 
+	pd->reset.rcdev.owner = THIS_MODULE;
+	pd->reset.rcdev.nr_resets = PRCI_RST_NR;
+	pd->reset.rcdev.ops = &reset_simple_ops;
+	pd->reset.rcdev.of_node = pdev->dev.of_node;
+	pd->reset.active_low = true;
+	pd->reset.membase = pd->va + PRCI_DEVICESRESETREG_OFFSET;
+	spin_lock_init(&pd->reset.lock);
+
+	r = devm_reset_controller_register(&pdev->dev, &pd->reset.rcdev);
+	if (r) {
+		dev_err(dev, "could not register reset controller: %d\n", r);
+		return r;
+	}
 	r = __prci_register_clocks(dev, pd, desc);
 	if (r) {
 		dev_err(dev, "could not register clocks: %d\n", r);
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 022c67cf053c..91658a88af4e 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -11,6 +11,7 @@
 
 #include <linux/clk/analogbits-wrpll-cln28hpc.h>
 #include <linux/clk-provider.h>
+#include <linux/reset/reset-simple.h>
 #include <linux/platform_device.h>
 
 /*
@@ -121,6 +122,8 @@
 #define PRCI_DEVICESRESETREG_CHIPLINK_RST_N_MASK			\
 		(0x1 << PRCI_DEVICESRESETREG_CHIPLINK_RST_N_SHIFT)
 
+#define PRCI_RST_NR						7
+
 /* CLKMUXSTATUSREG */
 #define PRCI_CLKMUXSTATUSREG_OFFSET				0x2c
 #define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT		1
@@ -221,6 +224,7 @@
  */
 struct __prci_data {
 	void __iomem *va;
+	struct reset_simple_data reset;
 	struct clk_hw_onecell_data hw_clks;
 };
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 71ab75a46491..d0f5d0afc240 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -187,6 +187,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
+	   - SiFive FU740 SoCs
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
-- 
2.30.2

