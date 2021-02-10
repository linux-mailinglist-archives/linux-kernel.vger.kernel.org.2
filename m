Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431C2316EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhBJSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:39:54 -0500
Received: from so15.mailgun.net ([198.61.254.15]:14931 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234128AbhBJS1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:27:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612981622; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DuJjfUOSWbb8R6sL1V63EJTTzGJiXIR2A5jOHDImBdY=; b=VX0MqsI7m81mtqNx6NHPiwJjoGTZuULDzqkyhBEqlsvzDYqxCDqDm5pPU7+Dqv1jow55do6T
 Q/cuVzIVVmqikleed8B/XE6DyBBQl42KZaiIra/Hn2NI2/lIIu4h/KD+l0GKeI0q5/JYBvPl
 TBGlzcGIYl7vHb8V9slMEncnwJU=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 602425573919dfb455b1251b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 18:26:31
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3D19C43462; Wed, 10 Feb 2021 18:26:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A71C6C433CA;
        Wed, 10 Feb 2021 18:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A71C6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] Add Global Clock controller (GCC) driver for SC7280
Date:   Wed, 10 Feb 2021 23:56:17 +0530
Message-Id: <1612981579-17391-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for Global Clock controller for SC7280 and also update
device tree bindings for the various clocks supported in the clock controller.

[v2]
 * Add UFS phy rx/tx symbol clocks in bindings.
 * Remove protected-clocks node & description.
 * Add support for extra clocks for QSPI/WPSS/MSS/LPASS/PCIE clocks.
 * Update the floor rcg ops for SDCC/QSPI clock.
 * Add comment for cpuss critical clocks.

[v1]
 * Documentation binding for GCC clock for SC7280.
 * GCC clock driver for SC7280.

Taniya Das (2):
  dt-bindings: clock: Add SC7280 GCC clock binding
  clk: qcom: Add Global Clock controller (GCC) driver for SC7280

 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |   92 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-sc7280.c                      | 3603 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc7280.h        |  226 ++
 5 files changed, 3931 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
 create mode 100644 drivers/clk/qcom/gcc-sc7280.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7280.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

