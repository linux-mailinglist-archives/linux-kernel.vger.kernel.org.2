Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BB03B09C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFVQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:04:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51770 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:03:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624377704; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=I+DsgpQsTCXfXWv24lYHbYTf2IfSS92QUXrBnvf+xV8=; b=LCmpfp82U0FPANwuGL5ujhl1wvAtxQ5kynShgNTD+Ws6xxahX76+JUfc8s7781qPXA5Kv2UG
 /HLpiakqNICV7u0ExGe3pAjIJ67JVVUPqqf2f+htnG1ESV3Ix11MjuMA6ErsSDHXcNeNPxzR
 uRmigOd0zQxTHIs8eRzo0OaqZrg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60d2094220bb88c60763067d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 16:01:06
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55F28C43145; Tue, 22 Jun 2021 16:01:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9F81C433F1;
        Tue, 22 Jun 2021 16:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9F81C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pmaliset@codeaurora.org
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, dianders@chromium.org, mka@chromium.org,
        sanm@codeaurora.org, Prasad Malisetty <pmaliset@codeaurora.org>
Subject: [PATCH v3 0/4] Add DT bindings and DT nodes for PCIe and PHY in SC7280
Date:   Tue, 22 Jun 2021 21:30:47 +0530
Message-Id: <1624377651-30604-1-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes PCIe support for qualcomm sc7280
which includes PCIe controller and PHY DT bindings.
The PCIe controller and PHYs are mostly comaptible with SM8250 SoC,
hence the existing pcie drivers are modified to add the support.

Changes in v3:
	* Changed pipe clock names in dt bindings as pipe_mux and phy_pipe.
	* Moved reset and NVMe GPIO pin configs into board specific file.
	* Updated pipe clk mux commit message.
	
Changes in v2:
	* Moved pcie pin control settings into IDP file.
	* Replaced pipe_clk_src with pipe_clk_mux in pcie driver 
	* Included pipe clk mux setting change set in this series

Prasad Malisetty (4):
  dt-bindings: pci: qcom: Document PCIe bindings for SC720
  arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
  arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
  PCIe: qcom: Add support to control pipe clk mux

 .../devicetree/bindings/pci/qcom,pcie.txt          |  17 +++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  38 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 125 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |  22 ++++
 4 files changed, 202 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

