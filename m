Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B218541A53D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhI1CWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbhI1CV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:21:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2018C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:20:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y186so8259922pgd.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kg/GzF/sdW0p0vvfKH2R41tEISnLDtHPzxNdShxqvM8=;
        b=lnEiCT4W2Vt81xX2B3QBWSajzRS0BHhPdyPDg26pxACWSFyjBXtVsl46QeDm39PLvH
         6ddbtIh7sK2NOsWb9ER08iCoqfUFsHxRHOmoGH1lzsLvkUPn0u/n0UIQUvVWQlweW1RB
         wixpgeD/BVudgMhrgkqqxqq8SHWDqCX9glVYjOhHjVfCjjmeWuPMAVvRoxETd/DU1kq0
         xQZLQSTvD64o2x1RCjK4gq1pZfp6pVq11nYoNR0BvoeocH9QSvdal6ymhBlZaBp8OFUN
         a9+Nmn5xcitwz8WrFEUrTdtE/lE6p0ioEPmS7AjxGyE6F32q7+FNO5BL5o9xKUQ6C7cE
         Qv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kg/GzF/sdW0p0vvfKH2R41tEISnLDtHPzxNdShxqvM8=;
        b=vlLGJ5W2z5JTVbNvkPM3H19Oe5gOoh6PWQlfzjdi9eNINPwGNQEPdVVLBaLRcQP0Jd
         DVH/G6+OSTS3i76KyG010nd0XFpPxvcLIYcW4zgpgkR6A8wKx4u6CFyOOjxXYpAq9MUV
         Mv/DpJuwv5Y8nVT7wadDmtNA6P0IayxgjAs2aXKaX46VbInqet5j3tFQq3DsPiwBS65o
         9ONLpFDTjOrfxZRokT5m7vbUIAptB/wgHHaO2oM2PuFD2dROy3OPrNqWA2YrYKjJMS0q
         6+5dOTkXRa1Is/Cyo4oi1boFDj2b//8px2WQNa+/b6bu6n8jtdWIdYojcyLMdtozKE2o
         4Cow==
X-Gm-Message-State: AOAM531ziQvghZVXbnnm2SXmgKoyhMeNYk8SycltLrtl6rWfZw9oV1Ov
        QcXKYnzLD3IcxrMeQLBNzMzTvg==
X-Google-Smtp-Source: ABdhPJwm2OGAXCfz1pcfsnrhgPp8cc3IJ9EYc8O3kZGQEbShcjrda5y+PfksmciTxjhD3HIQPlBtgA==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr2429816pgu.82.1632795620400;
        Mon, 27 Sep 2021 19:20:20 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u12sm19178729pgi.21.2021.09.27.19.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:20:19 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/3] Add missing vdd-supply for QUSB2 PHY
Date:   Tue, 28 Sep 2021 10:19:59 +0800
Message-Id: <20210928022002.26286-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds missing vdd-supply for QUSB2 PHY which is required for
digital circuit.  The driver works right now likely because firmware
already sets it up.  Add it to bindings, driver and DTS that miss the
supply.

It should not cause problem for existing DTBs:
- SC7180, SDM630, SDM845 based platforms already specified vdd-supply
  in the DTBs.
- MSM8996 and MSM8998 platform DTBs miss vdd-supply, but dummy regulator
  will ensure QUSB2 PHY driver works as before on these platforms.

Changes for v2:
- Correct copy & paste error on vdd-supply name in bindings doc.


Shawn Guo (3):
  dt-bindings: phy: qcom,qusb2: Add missing vdd-supply
  phy: qcom-qusb2: Add missing vdd supply
  arm64: dts: qcom: Add missing vdd-supply for QUSB2 PHY

 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 6 ++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi              | 2 ++
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi    | 1 +
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi           | 1 +
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi      | 1 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c                     | 2 +-
 6 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.17.1

