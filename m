Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A4316258
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhBJJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhBJJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:32:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDCAC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:32:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so1653860wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s1sQMKmA5X4b0lhaDVUuKBYgKx/IDMprYcIvq92de4=;
        b=TMEzTh9geMRRJWQhpTLw+8HJy+00LR7QXqD597quqbBxBvGS8e92GmYT8BsMeC7QiP
         4UB7NY3LAm6oGcMyNxvY6RXy+TvYiUGx7Pf8G4AnpyMwR3m1zhoJTZX7ZueuWlvZXCZj
         QKpFH4KuvP8/mBD508Iq2lajhbTYaBbEtPqFNFNfNxxAmOLvG0yvsLA0ITG9hngSyZgw
         u9k1XoPJW5oJOdLP76PCqpSmrWyGkki0JMk9a5j1Kr0L5CO7EvA/n4dOI8Su7FRqIURR
         gaXIsvIfGxgQ1fIjaiZaLGV8S+iN2U3eD2aBuGA5AQ5+9VRwhH2hjs5wr8xgxGKWSvXG
         VEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s1sQMKmA5X4b0lhaDVUuKBYgKx/IDMprYcIvq92de4=;
        b=YzYrbLZZYXzIfxCpkj1vI+YoFNrheQGbxD7lqW1VMsLzq6oYop2QX696H5fl4W9z7I
         WIt59KeNqNV4TLmfhrht0OIAfJSiMLMSiXCl/sj2HEuXGK0UiLU8/LFoMhG0ZSbDgdzh
         rOboDJ7stRlUo5eF7gNwsnTEznAlE8nmOfKDDzmX4QWacWaeEOwTnnwTzBcbrN46xdBt
         6iu1e1k0x6sBLsqSufSzOrd1EBgiY2bPIvam8IDA8JuRUq7BnpHM7VlGCpDo0O4WqYRB
         ENnLDaI2F6hYsbrq8AFXcLQHwVvs/N5tHailHv5ceo7nDCmbB4mwem6BmO7NifJ22Zwj
         pfHw==
X-Gm-Message-State: AOAM530cPSvd5IWULTThSdxV/aIlS7qcPPj+D4/zBbqdEw67I6RdDTdq
        EDbJvsOySWpZ8ptu+csncMMoJg==
X-Google-Smtp-Source: ABdhPJwQPgc2a9gC9tMHeDJPWYCiqQIfehTdTaUROF1aZjwatXDpjkqGFnDgxhV32vHXn2QqNioAwg==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr2645300wrs.72.1612949523910;
        Wed, 10 Feb 2021 01:32:03 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t2sm2150583wru.53.2021.02.10.01.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 01:32:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/7] ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
Date:   Wed, 10 Feb 2021 09:30:49 +0000
Message-Id: <20210210093055.18350-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210210093055.18350-1-srinivas.kandagatla@linaro.org>
References: <20210210093055.18350-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec RX macro which is
for connecting with SoundWire RX codecs like WCD938x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
new file mode 100644
index 000000000000..443d556caa69
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-rx-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) RX Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-rx-macro
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: npl
+      - const: macro
+      - const: dcodec
+      - const: fsgen
+
+  clock-output-names:
+    items:
+      - const: mclk
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    codec@3200000 {
+      compatible = "qcom,sm8250-lpass-rx-macro";
+      reg = <0x3200000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&audiocc 0>,
+               <&audiocc 1>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+    };
-- 
2.21.0

