Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5259836C421
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhD0Kft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:35:49 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60807 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhD0KeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:34:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619519603; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oH1oYniAqSDMIKhFPaHssEXlcSQIe5vDLRgliZ+9o70=; b=kXHNNycEPt+rvsl3nZtUfQsUQom82RbfLH1Xhj+cLZchNTohzyW5hzAt6hG74p0ltZttcYKL
 NPDdgmeNS/7+Ha19g4W/KgLaxBjRzrPrBZV7m2EMC71JAFrqxBvxPVzOL2j3avYs23KygohC
 mYRCWF0xXhOstMPTgtg9ogU9YkA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6087e873f34440a9d4621f8c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 10:33:23
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3215C2E87E; Tue, 27 Apr 2021 10:33:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36A77C4160D;
        Tue, 27 Apr 2021 10:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36A77C4160D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/6] Add support for DISP/VIDEO/GPU CCs for SC7280
Date:   Tue, 27 Apr 2021 16:03:04 +0530
Message-Id: <1619519590-3019-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for display, video & graphics clock controllers on SC7280
along with the bindings for each of the clock controllers.

[v2]
 * Use the .hws instead of clk_parent_data when the whole array is
   clk_hw pointers for all the clock drivers.

[v1]
 * Documentation binding for DISP, GPU, VIDEO clock controller for SC7280.
 * Add the DISP, GPU, VIDEO clock drivers for SC7280.

Taniya Das (6):
  dt-bindings: clock: Add SC7280 DISPCC clock binding
  clk: qcom: Add display clock controller driver for SC7280
  dt-bindings: clock: Add SC7280 GPUCC clock binding
  clk: qcom: Add graphics clock controller driver for SC7280
  dt-bindings: clock: Add SC7280 VideoCC clock binding
  clk: qcom: Add video clock controller driver for SC7280

 .../devicetree/bindings/clock/qcom,gpucc.yaml      |   4 +-
 .../bindings/clock/qcom,sc7280-dispcc.yaml         |  94 +++
 .../devicetree/bindings/clock/qcom,videocc.yaml    |   4 +-
 drivers/clk/qcom/Kconfig                           |  25 +
 drivers/clk/qcom/Makefile                          |   3 +
 drivers/clk/qcom/dispcc-sc7280.c                   | 908 +++++++++++++++++++++
 drivers/clk/qcom/gpucc-sc7280.c                    | 491 +++++++++++
 drivers/clk/qcom/videocc-sc7280.c                  | 372 +++++++++
 include/dt-bindings/clock/qcom,dispcc-sc7280.h     |  55 ++
 include/dt-bindings/clock/qcom,gpucc-sc7280.h      |  35 +
 include/dt-bindings/clock/qcom,videocc-sc7280.h    |  27 +
 11 files changed, 2016 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
 create mode 100644 drivers/clk/qcom/dispcc-sc7280.c
 create mode 100644 drivers/clk/qcom/gpucc-sc7280.c
 create mode 100644 drivers/clk/qcom/videocc-sc7280.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sc7280.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

