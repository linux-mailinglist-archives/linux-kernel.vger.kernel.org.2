Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC78B434BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJTNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhJTNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:09:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:07:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f11so2899574pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=cLHt1Q5LZV5kZERGaF5WFeq4nFIY0B4p1p8uZPXEb/E=;
        b=NeB1wz48puGnb+MMS/pk7h498WOtKopBnXwpEPOZuXpqFjYRxlsZppuF3Q3FbCRC+D
         l70YhD/l5Ky35Zbkm1yzqOu6i+pC3Nbix/LZCCcHU/fOIiW+Sl+te+R4Gx/uYjd+EdDR
         gJ+2Oe3yiTbxID5iiB/dQOf0wbguBfuL5KL/iPD/rDjzEMQetFH/B7U6JRKpVBIw+Rb/
         MQ3MD1EB0/YcUCqZgvmGVrJnx+wE7di5wmI8dzSlU4JMSpnrX7CPnlYLpiVeDmLbu4yk
         h5kD5D+gJ11Z8PcoeDpxzdMi/Oe3othHCYVZa8yEfkrVT3CJcgHwzSOrwWqHB4i3zUe8
         DbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=cLHt1Q5LZV5kZERGaF5WFeq4nFIY0B4p1p8uZPXEb/E=;
        b=g2gaGjlLms/LexqpozRF/97V86wYBh5892eZ9TnG74XnXZc4janRtHVJ0xFqXMJJT2
         /i2gbYX8J/9rp1PA4/TEI11pXOmuBSM0yT8qttSVY8w2ZBdqRrlUpWxLLk2UfGHoEqaX
         iGXN0yZC2tRfYzi8UX/4xTDkye29D7dre6KHRBLyt+qWhWtGh0QvA9SSXKryfID/1eqO
         5tMHIc6C0L387jGZV2mOUFF1O2LOfKhufjAyZQc5RGW3OL1qwg7wIYr4gKtoBqjpmJFo
         MtzLEZbBwMRD2gPGRfh0h3x8UpPLjlC4Ml83yQpn+a3TugjeHEskWlZeX62+a7YYirkw
         +/DA==
X-Gm-Message-State: AOAM530yQDGz9wMYl/HWwIfetIx74MLc1/UikbRbJtkWiqhXWCXstC03
        wlCrv1C/AO/nqO+rj6374j0ajg==
X-Google-Smtp-Source: ABdhPJykFU+IX6bdVX4DIL0QI08lOvBOF+umL/jmYbqQ6yMOrhzIgmCJJ+HllyDZ4dvVqEx7ZJxmUA==
X-Received: by 2002:a62:1d14:0:b0:44d:3b0b:d027 with SMTP id d20-20020a621d14000000b0044d3b0bd027mr6278328pfd.60.1634735224249;
        Wed, 20 Oct 2021 06:07:04 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q73sm2765784pfc.179.2021.10.20.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:07:03 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 02/10] dt-bindings: phy: qcom,qmp: IPQ6018 and IPQ8074 PCIe PHY require no supply
Date:   Wed, 20 Oct 2021 21:06:34 +0800
Message-Id: <20211020130634.26194-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929034253.24570-3-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qmp-phy driver suggests that 'vdda-phy-supply' and 'vdda-pll-supply'
are not required for IPQ6018 and IPQ8074 QMP PCIe PHY.  Update the
bindings to reflect it.

While at it, also correct the clock properies for IPQ8074 QMP PCIe PHY.
And as the result, 'qcom,ipq8074-qmp-pcie-phy' and
'qcom,ipq6018-qmp-pcie-phy' share the same clock, reset and supply
bindings.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Rebase to resolve conflict during applying.

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 55 +++++++++++--------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 99aa2d08dfcb..688a63ca1936 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -113,8 +113,6 @@ required:
   - clock-names
   - resets
   - reset-names
-  - vdda-phy-supply
-  - vdda-pll-supply
 
 additionalProperties: false
 
@@ -147,6 +145,9 @@ allOf:
           items:
             - const: phy
             - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -173,6 +174,9 @@ allOf:
           items:
             - const: phy
             - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -201,6 +205,9 @@ allOf:
             - const: phy
             - const: common
             - const: cfg
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -230,6 +237,9 @@ allOf:
           items:
             - const: phy
             - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -250,6 +260,9 @@ allOf:
         reset-names:
           items:
             - const: ufsphy
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -275,34 +288,16 @@ allOf:
         reset-names:
           items:
             - const: ufsphy
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,ipq8074-qmp-pcie-phy
-    then:
-      properties:
-        clocks:
-          items:
-            - description: pipe clk.
-        clock-names:
-          items:
-            - const: pipe_clk
-        resets:
-          items:
-            - description: reset of phy block.
-            - description: phy common block reset.
-        reset-names:
-          items:
-            - const: phy
-            - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
           contains:
             enum:
               - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-pcie-phy
     then:
       properties:
         clocks:
@@ -353,6 +348,9 @@ allOf:
         reset-names:
           items:
             - const: phy
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -384,6 +382,9 @@ allOf:
           items:
             - const: phy
             - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -411,6 +412,9 @@ allOf:
           items:
             - const: phy
             - const: common
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
   - if:
       properties:
         compatible:
@@ -437,6 +441,9 @@ allOf:
           items:
             - const: phy_phy
             - const: phy
+      required:
+        - vdda-phy-supply
+        - vdda-pll-supply
 
 examples:
   - |
-- 
2.17.1

