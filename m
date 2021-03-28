Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD08634BF14
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 22:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhC1Uxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhC1UxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 16:53:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01555C0613B4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:53:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b4so15376175lfi.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNIkLx8kWVG86LAjUYYPlsmRiqizqzJr/3ZFoHl5bLc=;
        b=nizocnuhxK9FJQsPQ2jGwog3/BI7cJo7GHMoHImaEcvFpTear+V1cELbBEMmulTg//
         0O6HjUoht9AklDhWYQSjnBCpgSxe4nfIN7mIJ/cjKsB14n7fJ+2tFyaaU7MPZPsC4qh1
         hj5p2I3XdykhH4BlThBn9ICpzugo0UA5G68zJJSOF6vvc2LmzZAH2tJWZXu3Vtz9+Dhq
         HP5PUTQrNnV08CR/5GBG5oiiYUkVL5I2AFQQY9YK2ducykaZ669sSi7H777nnGCSZ/AP
         ksAWs4piWYjQXv3Xrdy94ZyTOZ814OFUOtJi3HpyfOWwBtL5rKLIfxBnGVAhKYZbWgkN
         e01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNIkLx8kWVG86LAjUYYPlsmRiqizqzJr/3ZFoHl5bLc=;
        b=CF0TEDs24fY+rarGsWsrwrMu4ck/SfWl8L/AGhFdgNnZ/EVJVIaymmt+/ReroQu9yx
         o72bB2SNHOyAZLHPKTBkzr8VCSAebm0yNzaLUmucjI7eG43taTTADftDdL1fc64pIM+S
         49Tq5tPiu56/emj9FENI6mgT/TKyvpSW8l3EjbClfNYD7KrLH+XdDopCrZwZVtM9FcoO
         O4KEp03SrUQ2YTLauENpQ8B4VkaraNIITpWbYU/ZcJ93h+mJedoz+T3IRQN6kTwjRP3d
         d3uCl3CrlLWgobV02jVDfwbvYx2JWMvoOWVrqJhRcGV+N8a9RlNz/iYhYkM6WSfUYWVr
         2WwQ==
X-Gm-Message-State: AOAM533meWZATq/sfxn42hT5lqMNdlvaJMQH2Dcv1Jul26PaIHcbaUxm
        8gd5MKhRDN1jl5BV0Ewnvm+soQ==
X-Google-Smtp-Source: ABdhPJxRC0L49librnZ8GVD31k7lt8ScZzJRF0Zm12wNGXnnL5ibSirBNTggSd0LTl440YlE99m9Wg==
X-Received: by 2002:a05:6512:328f:: with SMTP id p15mr14508474lfe.628.1616964783347;
        Sun, 28 Mar 2021 13:53:03 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j19sm1589788lfb.15.2021.03.28.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 13:53:02 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/7] dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3 compatibles back to qcom,qmp-phy.yaml
Date:   Sun, 28 Mar 2021 23:52:51 +0300
Message-Id: <20210328205257.3348866-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
References: <20210328205257.3348866-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 724fabf5df13 ("dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy
information") has support for DP part of USB3+DP combo PHYs. However
this change is not backwards compatible, placing additional requirements
onto qcom,sc7180-qmp-usb3-phy and qcom,sdm845-qmp-usb3-phy device nodes
(to include separate DP part, etc). However the aforementioned nodes do
not inclue DP part, they strictly follow the schema defined in the
qcom,qmp-phy.yaml file. Move those compatibles, leaving
qcom,qmp-usb3-dp-phy.yaml to describe only real "combo" USB3+DP device nodes.

Fixes: 724fabf5df13 ("dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information")
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml         | 2 ++
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 626447fee092..7808ec8bc712 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -25,11 +25,13 @@ properties:
       - qcom,msm8998-qmp-pcie-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,msm8998-qmp-usb3-phy
+      - qcom,sc7180-qmp-usb3-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8180x-qmp-usb3-phy
       - qcom,sdm845-qhp-pcie-phy
       - qcom,sdm845-qmp-pcie-phy
       - qcom,sdm845-qmp-ufs-phy
+      - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8150-qmp-usb3-phy
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 33974ad10afe..62c0179d1765 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -14,9 +14,7 @@ properties:
   compatible:
     enum:
       - qcom,sc7180-qmp-usb3-dp-phy
-      - qcom,sc7180-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-dp-phy
-      - qcom,sdm845-qmp-usb3-phy
   reg:
     items:
       - description: Address and length of PHY's USB serdes block.
-- 
2.30.2

