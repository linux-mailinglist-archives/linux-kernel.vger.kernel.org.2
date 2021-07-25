Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA653D4B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 06:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGYDWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 23:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhGYDV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 23:21:57 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139ABC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:02:28 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o185so6790927oih.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJd/jugeN2YjgUvOBixRk7jqpX0of5iUQEXFzXCzPhs=;
        b=B4QCSkS/3XujHlHjUdtVPxFCSmVQO8G5YjMdMPuRNTnWiMywbaU3uKskrYy2ZZrFsR
         4VLbUak5CnlEiexnGvgxfBvfM/aZ4fFAFaIGIHRfWtvLkG8iaigdThd+pl8TJY9EWsdI
         IaUt8tn6TapTa/CIs1Z/nJqdCl6HT0TKe5rfQBM1Fj4wF/CeDLeZIaIr+eYU/tJ2/PLV
         BkaBPO5w5AbtZrjw/1xF62BCoc2oVwJsvAMXA259XrPkQssO9f5x3kztQ9xgI/F4/yRq
         7Ugu9Vj7LBujNombnQN710uRx7It5DQcXy14705lK2gpLzn7gLyGvi8aWcF1KiozGhPI
         HqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJd/jugeN2YjgUvOBixRk7jqpX0of5iUQEXFzXCzPhs=;
        b=rsZhRYdNwKb8kzNBDMR72PSSo3z2oz7qcJcuclsvxADI1k8wfNuAdWKT93mpeY5x1K
         ec3KTCcWVjMVrZYTFmU504MtMrbMgWPuahU3vN4iDuuflYeIgyXw9cs7ROqHIp7BTky5
         XW/BcIHHpx/uqh24whxYEutie5BwPwFzITTnTI5mQmT2aBkx0uRVi/QfXyn+ai3xWyZE
         5PGjtr05PX8vJUMucdfkt+n3qxj88gPy4OHa3lWmtvuFrQmqqg5Sjc7ZC606k/y6Dz70
         OpUFCxKBUKX9Zjgtt8Rbv9aYYQIdaGzTLU7LsaXZypwqn+xmZQgqkFzjIGuLk4Ha2rbM
         ZygQ==
X-Gm-Message-State: AOAM530yuIl+KwQjJFjIV5S8T3CU79hCIsjgd3vKdCV94wosNxXgOy3B
        lHUSLQctIMrA2IPvdsjyECCgwQ==
X-Google-Smtp-Source: ABdhPJyJ5mXGrUKX4FgCbfR/6UxKLXQZuB9R36iswQ9T71dP85NJ4RP/gPM9CokS7jOKNtPPD08a/w==
X-Received: by 2002:aca:5a04:: with SMTP id o4mr7357553oib.33.1627185747406;
        Sat, 24 Jul 2021 21:02:27 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q20sm872910otv.50.2021.07.24.21.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 21:02:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: qcom: Split init and enable for 1.9.0 and 2.7.0
Date:   Sat, 24 Jul 2021 21:00:37 -0700
Message-Id: <20210725040038.3966348-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210725040038.3966348-1-bjorn.andersson@linaro.org>
References: <20210725040038.3966348-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the sc8180x platform the "msi" interrupt often fires before init has
a chance to enable the clocks that are necessary for the interrupt
handler to access the hardware.

Split out the resource enablement and disablement into the newly
introduce enable/disable resource operations, to ensure that the
necessary resources are enabled when needed.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a64a126de2b..8adcbb718832 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1173,12 +1173,11 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 	return PTR_ERR_OR_ZERO(res->pipe_clk);
 }
 
-static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
+static int qcom_pcie_enable_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u32 val;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
@@ -1211,6 +1210,20 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		goto err_disable_clocks;
 	}
 
+	return 0;
+
+err_disable_clocks:
+	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
+
+	return ret;
+}
+
+static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
+{
+	u32 val;
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PCIE20_PARF_DEVICE_TYPE);
 
@@ -1238,15 +1251,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	}
 
 	return 0;
-err_disable_clocks:
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
-err_disable_regulators:
-	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
-
-	return ret;
 }
 
-static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
+static void qcom_pcie_disable_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
 
@@ -1465,8 +1472,9 @@ static const struct qcom_pcie_ops ops_2_3_3 = {
 /* Qcom IP rev.: 2.7.0	Synopsys IP rev.: 4.30a */
 static const struct qcom_pcie_ops ops_2_7_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.enable_resources = qcom_pcie_enable_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
-	.deinit = qcom_pcie_deinit_2_7_0,
+	.disable_resources = qcom_pcie_disable_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
@@ -1475,8 +1483,9 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 /* Qcom IP rev.: 1.9.0 */
 static const struct qcom_pcie_ops ops_1_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.enable_resources = qcom_pcie_enable_2_7_0,
 	.init = qcom_pcie_init_2_7_0,
-	.deinit = qcom_pcie_deinit_2_7_0,
+	.disable_resources = qcom_pcie_disable_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
-- 
2.29.2

