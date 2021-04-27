Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD336C025
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhD0HfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:35:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37615 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234894AbhD0HfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:35:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619508863; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/vb+5nJPnsVeqHtcAtJmc21hr+Vdx5Dj9AfSQkrVT4s=; b=s1TgfsBJQ0eSR16YtjimTY96ffomIhT77J5nKUAjd1kwpY73lbTZ4srQqw3PFccadox9jxho
 CV6Hx3auvy35xYFQVrASXGBQ6Jdq/UYbhJTERHkfqo4AV7BTTbGWmv09gdPwZV9oTsny7T3O
 /RcZG+CsVm6Vp4W3W+Wd2GCPJy4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6087be68215b831afbf70a5a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 07:34:00
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BDA7C43217; Tue, 27 Apr 2021 07:34:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9311C433D3;
        Tue, 27 Apr 2021 07:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9311C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, sboyd@kernel.org
Cc:     agross@kernel.org, mani@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/5] Enable miscellaneous hardware blocks to boot WPSS
Date:   Tue, 27 Apr 2021 13:03:39 +0530
Message-Id: <1619508824-14413-1-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables miscellaneous hardware blocks to boot Wireless
Processor Subsystem (WPSS) on SC7280 SoC.

V2:
 * place resets and num_resets adjacent to each other [Stephen]
 * drop incorrect useage of tcsr_mutex_regs [Bjorn]
 * Qualcomm is expected to drop master/slave naming from its mproc nodes
   in future SoCs.

Sibi Sankar (5):
  dt-bindings: mailbox: Add WPSS client index to IPCC
  dt-bindings: reset: aoss: Add AOSS reset controller binding
  dt-bindings: reset: pdc: Add PDC Global bindings
  reset: qcom: Add PDC Global reset signals for WPSS
  arm64: dts: qcom: sc7280: Add nodes to boot WPSS

 .../devicetree/bindings/reset/qcom,aoss-reset.yaml |   5 +
 .../devicetree/bindings/reset/qcom,pdc-global.yaml |   4 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 138 +++++++++++++++++++++
 drivers/reset/reset-qcom-pdc.c                     |  62 +++++++--
 include/dt-bindings/mailbox/qcom-ipcc.h            |   1 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |   2 +
 6 files changed, 201 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

