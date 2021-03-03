Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FDA32BDFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbhCCQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:49:54 -0500
Received: from z11.mailgun.us ([104.130.96.11]:46109 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236727AbhCCMVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:21:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614774065; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=arIjeh1oJBbBzDIaWsXKQ4a2CukVItpaCqWDSq2ybZo=; b=hKTIctznD4mtD8U+IQa0RhKuJg65iAKXegHywZIBJIvFzkiA+pa0RrAzjnkej0uLMvGfjATT
 2XSjesuP+w8xaS/X4QwKFOmkiA9ufZ7vaF/K++CthDghl+PZApl3SXqyUMVrnEJebduF7HXc
 1kp+LUM0tDNz96f/xQyLYkWw8aE=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 603f7f2f4fd7814d5f40594c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 12:21:03
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BDDABC433ED; Wed,  3 Mar 2021 12:21:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D18BBC433CA;
        Wed,  3 Mar 2021 12:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D18BBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 00/14] Add binding updates and DT files for SC7280 SoC
Date:   Wed,  3 Mar 2021 17:47:44 +0530
Message-Id: <1614773878-8058-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a few minor binding updates and base device tree
files (to boot to shell) for SC7280 SoC and the IDP board using this SoC.

Maulik Shah (3):
  arm64: dts: qcom: sc7280: Add RSC and PDC devices
  arm64: dts: qcom: Add reserved memory for fw
  arm64: dts: qcom: sc7280: Add cpuidle states

Rajendra Nayak (6):
  dt-bindings: arm: qcom: Document sc7280 SoC and board
  dt-bindings: firmware: scm: Add sc7280 support
  arm64: dts: sc7280: Add basic dts/dtsi files for sc7280 soc
  dt-bindings: qcom,pdc: Add compatible for sc7280
  arm64: dts: qcom: SC7280: Add rpmhcc clock controller node
  arm64: dts: qcom: sc7280: Add rpmh power-domain node

Sai Prakash Ranjan (4):
  dt-bindings: arm-smmu: Add compatible for SC7280 SoC
  arm64: dts: qcom: sc7280: Add device node for APPS SMMU
  dt-bindings: watchdog: Add compatible for SC7280 SoC
  arm64: dts: qcom: sc7280: Add APSS watchdog node

satya priya (1):
  arm64: dts: qcom: sc7280: Add SPMI PMIC arbiter device for SC7280

 Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
 .../devicetree/bindings/firmware/qcom,scm.txt      |   1 +
 .../bindings/interrupt-controller/qcom,pdc.txt     |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dts            |  47 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 609 +++++++++++++++++++++
 8 files changed, 667 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

