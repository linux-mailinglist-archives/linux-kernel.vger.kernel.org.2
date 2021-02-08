Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB1313F47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhBHTkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbhBHSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:03:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB9C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 10:01:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i5so4566wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s1sQMKmA5X4b0lhaDVUuKBYgKx/IDMprYcIvq92de4=;
        b=L3IgZ7BE8UKYs5RN65jeJ5VyW1p1R3WssltervwC6FLLvOnOEFrY2xAFKjnITTdgkB
         KDLyfDFvKateRh4yZtt+XaAqvBJiDzrEKP25V7lH/T5cEKnmcAaLQ5HBH9ro6BzqHNRU
         NKYhPboaEv1MbqrNu0wxE+RgiNRaVfwaY6WjdX/NAiMPtYKEENSGv/+SKSqd+OlutZkw
         4OwYLg/jyuqY1h548ESf3tqrLU7MJVQvpVp8ik1b+NNwFcth30Xk2ALLJIqwbT2OI/9W
         B7niNfhg8hgm2QjBD6EeS1eKK3vYOGIN11CL4gWJ0mCvhDE3xqWBcyO7LyVas0ep17NY
         bDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s1sQMKmA5X4b0lhaDVUuKBYgKx/IDMprYcIvq92de4=;
        b=XaOrIr3bT4x8E0U9tzsuMksdgbgIISaY0SGUuS+mg33rpbehov+5GCxfIg0fh8+c/F
         ebdlQG1E+5atfXNomGFDf9tQrXrvH8oo7upxXFue/RbgHEAKb+3VSV7WBkuvbbbMD6ik
         1NR3X6ye+BBgqw0zrfpgiFRurlR+I4wFIg4341NlTVf05pt4Kae6qi6VKnVq1U/WhxVz
         1U9oNINmCLlRcz68ieuUXeH2FUDKtYNixOEiTUPCxXwzIalDEaxYu0vyXcJhgKjEL5Ww
         QXirnoSGBtoa/sVgy66zAABB0ppBFP2kTpLnANz3cbqVHbW+zYo5LnXSglW5cLn1x0vF
         MuGQ==
X-Gm-Message-State: AOAM531s9Yc+DtnHv9d3BI1CMmYb6HgqpFemCfA41g6Q+iz+Zy4+5NeA
        1NmwxEJ7qWpCFgbmsYVXWl71WQ==
X-Google-Smtp-Source: ABdhPJxCZi8H1CydVhCZfqpCFVFhs9A4rb4nG+DOMBKxnKEbl3LV8R30QFkuR1U+WZjKFHv9VJp9kw==
X-Received: by 2002:a1c:67c4:: with SMTP id b187mr15837322wmc.17.1612807315064;
        Mon, 08 Feb 2021 10:01:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l2sm21194937wmq.17.2021.02.08.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:01:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/7] ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
Date:   Mon,  8 Feb 2021 18:01:03 +0000
Message-Id: <20210208180109.518-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210208180109.518-1-srinivas.kandagatla@linaro.org>
References: <20210208180109.518-1-srinivas.kandagatla@linaro.org>
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

