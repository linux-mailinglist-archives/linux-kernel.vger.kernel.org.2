Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1742E1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJNTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:01:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20135 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhJNTBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:01:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634237952; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YdYae8FjvdwlIZUmd/70Jf7pQukNnaljep/EvzoyYRQ=; b=HIwnXIKv9f2viXLV77y3+ycsLa/ccVdmSO2Jdf05gWJ5d4E9kX0SBgWjeww9vqik8C4TB22s
 LI5Xv9B7XkUD+1nICl3EgZC8PG1ZpDEg4XCwxdH5NXcJbeNkOS843T+ncfigsaQ8dOLbE1RY
 hSmnO/48XaJ3w4ZABXtly7zR5eI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61687df8257f7c405a2c8e23 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Oct 2021 18:59:04
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8ABE7C4338F; Thu, 14 Oct 2021 18:59:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10FC0C4338F;
        Thu, 14 Oct 2021 18:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 10FC0C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vbadigan@codeaurora.org,
        kw@linux.com, bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Cc:     Prasad Malisetty <pmaliset@codeaurora.org>
Subject: [PATCH v1] PCI: qcom: Fix incorrect register offset in pcie init
Date:   Fri, 15 Oct 2021 00:28:49 +0530
Message-Id: <1634237929-25459-1-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pcie_init_2_7_0 one of the register writes using incorrect offset
as per the platform register definitions (PCIE_PARF_AXI_MSTR_WR_ADDR_HALT
offset value should be 0x1A8 instead 0x178).
Update the correct offset value for SDM845 platform.

fixes: ed8cc3b1 ("PCI: qcom: Add support for SDM845 PCIe controller")

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8a7a300..5bce152 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1230,9 +1230,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
+		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

