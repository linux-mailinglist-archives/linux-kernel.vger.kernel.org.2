Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972F2379E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhEKEUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhEKEUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:20:39 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF24C061343
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:19:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so6259033otg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkLav7gNUppKdJ+DoniFp4kT3jxFpGfqc/qshk+XJwk=;
        b=GyxOEtoYfY/Jjwq9hBqkQDYnAdS0Ne3YiGuUi52B0GNwy1+X733pGjofh1dONUsfgf
         Yrg4htTm3enGHyPUuyXgIb5viMuOSCT9mLV+jwem1Nwpd788/DZQp6WnyPJohy0PChMb
         2IVItI690P/rZ4YRM1szGF5KrKU+4fsbM9DASSV95uDXtPk5eTHd2rZC/faMFVWzbWse
         6WUIk0+thlJapsO46mLZEQbkG5Sup1l/m7jzNckh/PWHq6aVZSKXcI0bo28q+DysBTyw
         PM7Dg5MJ43jj6WFulBmHTZbw8TyTQe3x/zqhfYkPxLvFjMKA12S3VwooE0hfgDfF0n6Q
         /lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkLav7gNUppKdJ+DoniFp4kT3jxFpGfqc/qshk+XJwk=;
        b=CeNPQcXMfozzY6pOhXfSOMnjwx/OxLUy4d15Q38RFadrl0VQQS+Ym3Xq0wabbw2lnp
         CBSe/dxPF8zDQth68QkfGmPobN5miAqPJBEYDs1SjK52+UjjxUPssdQMA3UhuG1FayLv
         lF0oly95X/IwH08OHq2TbCsm9oOexCk4kXYMle0tMyFneZKz4mhYSn/9c+F8N1NLoLpc
         CezuDRRwvRj+Ha6Wzi7umkKGjU383NMyhNf8DioKUztS1L6iqOKgfJpLEnaQT80aBV5p
         pVpz9ctMPnBlXV03fACnqCxXpeFy0EKgZs1kF/pYmfYGOgHyIw7/uhwgsNcl64iYTpfG
         8N3w==
X-Gm-Message-State: AOAM532vNPAND7S280Re/XG3CTFR3k2DKWKCvLfGuiB2OT2CkScVejPH
        MAZn/3UJrCljxnnA85F725lNfg==
X-Google-Smtp-Source: ABdhPJwEBKQNKqYfa9/Do97FyvXS0Vej+xDddykDlgsCGjc+FKR00Wtppqg/G5Tj6FCapfUR9LR+PQ==
X-Received: by 2002:a9d:6949:: with SMTP id p9mr4238470oto.125.1620706773292;
        Mon, 10 May 2021 21:19:33 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:e623:42c1:10df:adff:fec2:f1d])
        by smtp.gmail.com with ESMTPSA id w15sm810721oiw.34.2021.05.10.21.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:19:32 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, sbillaka@codeaurora.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: phy: Introduce Qualcomm eDP/DP PHY binding
Date:   Mon, 10 May 2021 23:19:29 -0500
Message-Id: <20210511041930.592483-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a binding for the eDP/DP PHY hardware block found in several
different Qualcomm platforms.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/phy/qcom,edp-phy.yaml | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
new file mode 100644
index 000000000000..c258e4f7e332
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm DP/eDP PHY
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm DP/eDP PHY is found in a number of Qualcomm platform and
+  provides the physical interface for DisplayPort and Embedded Display Port.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8180x-dp-phy
+      - qcom,sc8180x-edp-phy
+
+  reg:
+    items:
+      - description: PHY base register block
+      - description: tx0 register block
+      - description: tx1 register block
+      - description: PLL register block
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg_ahb
+
+  "#clock-cells":
+    const: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@aec2a00 {
+      compatible = "qcom,sc8180x-edp-phy";
+      reg = <0x0aec2a00 0x1c0>,
+            <0x0aec2200 0xa0>,
+            <0x0aec2600 0xa0>,
+            <0x0aec2000 0x19c>;
+
+      clocks = <&dispcc 0>, <&dispcc 1>;
+      clock-names = "aux", "cfg_ahb";
+
+      #clock-cells = <1>;
+      #phy-cells = <0>;
+    };
+...
-- 
2.29.2

