Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE363350305
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhCaPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhCaPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:14:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2889C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:14:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i26so29589296lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szrnHwOMXqsq40OfwiBkaChIfbhw+vSJppKz2hMlXUk=;
        b=SDbgjo2E4CWkK9exdps6SOvJMvHfGv2yAP96YouU6KKUJs0uYAvlW2MOIjXz9ShUlk
         kzU0B9oTosK42j49NXJigkYjCQmI8WASV6J1LOaOp5A9tlJYPimbEWx6XMIrFC+7Lovg
         c/NXlVPOlDlLwy9C/jk2/MkLd2PLjO/RAn79RfvX9fp3m3zdnanvMWmuKKJGaZiKaf2V
         pgAxx4N9VA89ubrjgloFzhPlPucyM/nVEu/gC8XijuABjOgnZ1R6rGNkFPpyJeiaVypE
         WSY/C/u4Ze7sWhHWHznoPqspQz4O23NbUaK0BnDVviowKgaoev6aI/hvtgseE+FBhw5K
         r67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szrnHwOMXqsq40OfwiBkaChIfbhw+vSJppKz2hMlXUk=;
        b=rCkAEmBRb53TyO1va+2IvTOWCzJbwsN7Jswv949I/rDxi9AYzpDGCLakoiAMed2/vz
         Aet1eNICOJ0M0pBfAf40D9oEZIl/cG4caBvCI5lpe2g5/je2sdxYGtquMkxuvLgqRmbM
         KvmoDfYsrCOZsK4ulDuykkJlBzOwK9zP64FmKHA5GLgeIwqcgG42HKEC9ZjvatVAXI1m
         +JOK9sIBtstsZYwVz/GNLY9DfNBUExeif1vaCgz2aNxwq1oKUS3ybzpNs15bsvtGS1BV
         ItBqU/JhFsAu4QPRl4/9ytPtxPak/jsq2pPLqMvrHAo2319K2jnCElGqdDVlg6EjNwR+
         I1/w==
X-Gm-Message-State: AOAM53121b8XuxcMEt0ZLlNJ7P0wltIqo3GrJltzBqHFberIszmR/xaI
        uu6JHugcwnNXhYvWgQHSvtHz5g==
X-Google-Smtp-Source: ABdhPJx8wJimx8Bjx4vf436ecI3j1vwX+V9pniNN9LBrkbdu+/2+6Y39SPXzJGhsP6No69QnxUatzQ==
X-Received: by 2002:a05:6512:2097:: with SMTP id t23mr2393277lfr.21.1617203647130;
        Wed, 31 Mar 2021 08:14:07 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s29sm266586ljo.136.2021.03.31.08.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:14:06 -0700 (PDT)
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
Subject: [PATCH v6 1/7] dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3 compatibles back to qcom,qmp-phy.yaml
Date:   Wed, 31 Mar 2021 18:13:59 +0300
Message-Id: <20210331151405.3810133-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

