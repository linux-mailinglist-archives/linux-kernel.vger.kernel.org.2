Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92933A9D10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhFPONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFPON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:13:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF044C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:11:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c9so2870334wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aE0w1uO3QVDTTrk8Nc8bPJabv5EcddLgbrDTqRajB2A=;
        b=eMDInb1B5qVL0q8lgoCc7i8Cnh36v23UeL2sMjwtaKmgVyxASSfueEMjruLjEiT691
         a4mZ6tYL0QcwSOSkQCTKcgFqW0gbRNdecH4C5ONBr+9SopRkjm8ZjZw8vIiUJi8ardVb
         Ln1Ibgn4S8BIOQN/gXnqt9Jj9tN+5GYWIGF/CKFJd+VkVw7njLDSA+/dwIZx1fc7+eKe
         BEsHef+QFC1YX5VxYxmXbFAAUQN8pe/PWUVrAoO/+5TLE8Eri8zlpoDggqpFl2Yw2t2s
         QYkpmxJO7ptB80iA+ghtyVDbnAXEYF/AwEjNGuNy8YY3tAjwkL1PH32Bj41wbIDLWlqD
         GknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aE0w1uO3QVDTTrk8Nc8bPJabv5EcddLgbrDTqRajB2A=;
        b=T0vYhNbfmkdJcUo6K6P24L/G6c/AiIj3tckSwQ5Lq6JyAzyBT93WH2c2rnKRU2MuC0
         QJT45t5WMxgUY+fnz2HeHe1Zz7TqiNtwUggcGIlV6/8IwudIxzrGYT/12fhskba0KBE/
         p0vvEO6WSoEGXd2i+sd1CmqBN/qbJXBnhHc0UK9XKSN7PYQxip/QIn8Yp/cTQAxGwBAe
         F/FCgTGp23WqYP4J/rwkRJkdmDvzcliZtwpU2Paxq9Jh1OjG5I2k7MCYi3MLDOloImF9
         GjN4CAxGWJ453KblmoUYYlQ6JCevJ1ebniBvEY/de3CWDdOTgsntw6+aDUYYeYN+hygQ
         M74w==
X-Gm-Message-State: AOAM5314uj5TbrMiHSUQqAIPBE617QQ2FQP0LXSVPR8+FAgVrJ4kRhCy
        eGynuAbWwTdSK6kkQ0pLvt8BHQ==
X-Google-Smtp-Source: ABdhPJwFueHcCoJnHzqBztCyWLRoMNfG6eE+JFDi+ZoSffloB3C63Rm+FxtcSAo7JOZFBIK2ZZ/ZWA==
X-Received: by 2002:adf:b64a:: with SMTP id i10mr5677516wre.169.1623852681204;
        Wed, 16 Jun 2021 07:11:21 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:9df7:76e5:7e94:bf1e])
        by smtp.gmail.com with ESMTPSA id g83sm1968375wma.10.2021.06.16.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:11:20 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [RFC v1 00/11] Qcom SM8350 DispCC & VideoCC
Date:   Wed, 16 Jun 2021 16:10:56 +0200
Message-Id: <20210616141107.291430-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not merge, this series has yet to be properly tested. Work is in
progress for sm8350 display driver support, which will test this series
properly.

This series implements display clock controller (dispcc) & video
clock controller (videocc) support for the Qcom SM8350 SOC.

In order to support these new clock controllers, some changes to the
alpha plls are required. These changes add support to the Lucid 5LPE PLLs.

Robert Foss (11):
  clk: qcom: common: Add runtime init/suspend/resume
  clk: qcom: rcg2: Add support for flags
  clk: qcom: clk-alpha-pll: Fix typo in comment
  clk: qcom: clk-alpha-pll: Add configuration support for LUCID 5LPE
  dt-bindings: clock: Add QCOM SM8350 display clock bindings
  clk: qcom: Add display clock controller driver for SM8350
  dt-bindings: clock: Add SM8350 QCOM video clock bindings
  clk: qcom: Add video clock controller driver for SM8350
  arm64: dts: qcom: sm8350: Power up dispcc & videocc on sm8350 by MMCX
    regulator
  arm64: dts: qcom: sm8350: Add videocc DT node
  arm64: dts: qcom: sm8350: Add dispcc DT node

 .../bindings/clock/qcom,dispcc-sm8x50.yaml    |    6 +-
 .../bindings/clock/qcom,videocc.yaml          |    2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   46 +
 drivers/clk/qcom/Kconfig                      |   18 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/clk-alpha-pll.c              |    5 +-
 drivers/clk/qcom/clk-alpha-pll.h              |    5 +
 drivers/clk/qcom/clk-rcg.h                    |    4 +
 drivers/clk/qcom/clk-rcg2.c                   |    3 +
 drivers/clk/qcom/common.c                     |   92 ++
 drivers/clk/qcom/common.h                     |    6 +
 drivers/clk/qcom/dispcc-sm8350.c              | 1402 +++++++++++++++++
 drivers/clk/qcom/videocc-sm8350.c             |  593 +++++++
 .../dt-bindings/clock/qcom,dispcc-sm8350.h    |   77 +
 .../dt-bindings/clock/qcom,videocc-sm8350.h   |   44 +
 15 files changed, 2302 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/qcom/dispcc-sm8350.c
 create mode 100644 drivers/clk/qcom/videocc-sm8350.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8350.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8350.h

-- 
2.30.2

