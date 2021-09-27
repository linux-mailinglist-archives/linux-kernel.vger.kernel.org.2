Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4FC41A19D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhI0WAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:00:13 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:56455 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbhI0WAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:00:11 -0400
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 285CF1F88D;
        Mon, 27 Sep 2021 23:58:30 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Global Clock Controller driver for MSM8976/56
Date:   Mon, 27 Sep 2021 23:58:26 +0200
Message-Id: <20210927215828.52357-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Global Clock Controller (GCC) driver for MSM8956, MSM8976
and APQ variants and it has been tested on two Sony phones featuring the
Qualcomm MSM8956 SoC.

In addition to GCC this driver is also responsible for providing MDSS
and GFX3D clocks which reside in the same register space.

SoMainline is dedicated to getting their long-awaited msm8976 support,
including the Xperia X, X Compact and if feasible also the Xperia Touch
projector (APQ8056) slowly but steadily upstreamed.

Changes since v3:
- Set the enable_mask of gcc_apss_ahb_clk and gcc_apss_axi_clk to BIT 14
  and 13 respectively instead of overlapping gcc_crypto_ahb_clk's BIT 0.

Changes since v2:
- Rebased on v5.14;
- Various minor cleanups (lowercase hex, const where appropriate,
  removal of unused enum constants);
- Fixed XOR confusion in probe;
- All remnants of global clock name dependencies are removed, all
  inter-driver dependencies must be fully specified in DT;
- Added proper dt-bindings yaml validation, listing the required clocks;
- Moved dt-bindings header to the dt-bindings patch.

Changes since v1:
- Rebased onto linux-next 20191015
- Fixed platform driver name (qcom,gcc-8976 => gcc-msm8976)
- Splitted changes to dt-bindings to a separate commit

AngeloGioacchino Del Regno (1):
  clk: qcom: Add MSM8976/56 Global Clock Controller (GCC) driver

Marijn Suijten (1):
  dt-bindings: clk: qcom: Document MSM8976 Global Clock Controller

 .../bindings/clock/qcom,gcc-msm8976.yaml      |   90 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-msm8976.c                | 4154 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8976.h  |  240 +
 5 files changed, 4493 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
 create mode 100644 drivers/clk/qcom/gcc-msm8976.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8976.h

--
2.33.0

