Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B3316277
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBJJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhBJJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:35:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF47C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:32:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m13so1612386wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4A5Uf4Os6WPGl/YWHkNN/4TU8yF2iW13SGgEG1fF60=;
        b=adzTDDLthXXtZaBFlQRqslziLqKvZsWzA05hRdVadOeTo6a4itsepNDCfhBKcm4H/d
         /DHljJo5F31vdH5ia0X5PLamOixs+5hhp/6a6397c75pPKBj6S4BmzlntJEBzDLi2cvk
         E8Z+u8DzS/lBmK7VCxK5wC1p3rbavEHTa69WtDtFURWm2iGvyxElBXNYOBdzRzkFJ8gp
         cQueylBc9+j4cxgCk/ehqkHYHSaslLtxN6jP0L0Jk5wA4Hmx7k91yzcosxBfvnzdAvdl
         6VU9/m/zncoR4GnNw1ZTqR3uCnJkC/5fhy/ZT8MT6hoJhR5+SzGoP0peI0s/iKj7xtrj
         TSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4A5Uf4Os6WPGl/YWHkNN/4TU8yF2iW13SGgEG1fF60=;
        b=tITEi6w7kEdoTmIxe8P1MTiv9zRManZl1mN4rjeoeRLYB3Pz5Zee+cPHitXQ0jlzzp
         ilrUiR+7wN+wdSZS79OtvLnvp0Kc+nBIX+ILeIQmIY7F2Hh7lUVAFevScJS7QPceurtx
         u4HPxFezgGCPzvRLmfdowBa2IdvWuZOO8tn1SmxASRLUSR7UA8yRsPHU+Vlz3wMavr7m
         c8b8CkmrY5WsHHIAqpMktZem9sDh5h3fMVMr5mpGH7mfRkJPK44f3YHdKF3QXcAsTkxd
         YrfMZ7wU2o3LtPYXYrC01lMRiuOahXCUIPsFPBaBmoEoI4JyhOaByNK7cquwPMqBQDIo
         +brg==
X-Gm-Message-State: AOAM532u0nRiCz6GR5T/gLTcqflnOONAP5qcQQHm66GYNrR2huoFC/ez
        aYln8LXyOK/+canIvxOko8wOhg==
X-Google-Smtp-Source: ABdhPJwh53VbXv1w+xpdN/qRQno7PAQqQ65fFnPwfNieIO4vpJ9+3vDNvUXnu1JZhnq87887ExdDmA==
X-Received: by 2002:adf:fc88:: with SMTP id g8mr2503989wrr.259.1612949548930;
        Wed, 10 Feb 2021 01:32:28 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t2sm2150583wru.53.2021.02.10.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 01:32:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 5/7] ASoC: qcom: dt-bindings: add bindings for lpass tx macro codec
Date:   Wed, 10 Feb 2021 09:30:53 +0000
Message-Id: <20210210093055.18350-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210210093055.18350-1-srinivas.kandagatla@linaro.org>
References: <20210210093055.18350-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is for LPASS has internal codec TX macro which is
for connecting with Soundwire TX codecs like WCD938x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
new file mode 100644
index 000000000000..6b5ca02ccce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,lpass-tx-macro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPASS(Low Power Audio Subsystem) TX Macro audio codec DT bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,sm8250-lpass-tx-macro
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
+  qcom,dmic-sample-rate:
+    description: dmic sample rate
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+    codec@3220000 {
+      compatible = "qcom,sm8250-lpass-tx-macro";
+      reg = <0x3220000 0x1000>;
+      #sound-dai-cells = <1>;
+      #clock-cells = <0>;
+      clocks = <&aoncc 0>,
+               <&aoncc 1>,
+               <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+               <&vamacro>;
+      clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
+      clock-output-names = "mclk";
+      qcom,dmic-sample-rate = <600000>;
+    };
-- 
2.21.0

