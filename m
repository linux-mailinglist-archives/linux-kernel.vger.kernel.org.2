Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51E73077DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhA1OVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhA1OUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:20:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5805C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:19:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so5567966wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s1sQMKmA5X4b0lhaDVUuKBYgKx/IDMprYcIvq92de4=;
        b=I9vxJn/1Ck4iP8t6coN1ZOIjPhSLezBeAAAS9ehzuUmjGKMEXA3fWU7U0vAwJX/gXN
         +oqWM4aU24qPDxv4ZJf/4WPyimDFaAKc1PeEm9pD8wY++AIttSyIFovhY6iI6xL50o85
         Y25DgXuisgkciQiFDHYol1jrJrOle6w8mSIgOZfwMglkJM3ffY0J/w5LpJnOBBro3QsL
         9qXtGqg81IrdNX30Ww018hT2j4JbAZy2KcGeCCUkLfa1MyUdIsxGluATXUULuVFZqxOo
         RXbDNWeIF3EGccYB/tfb5zFBodWkA0XG3uCyVkS04nt09iL7lfUcaCbVrwVU5Vaav9zD
         zSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s1sQMKmA5X4b0lhaDVUuKBYgKx/IDMprYcIvq92de4=;
        b=MAz4q+zjQaNsfMLTHxXPO3+VSOiQfysKoKrZ1GVEMvZ0aO66Ysc0VhLlYdsWCCkGGD
         JAo/ltDFkermbUSv74wpkuwbweVy1VVgGGAt5F23TglS0Py4RWwZG0hTsa3tq9l1jSUO
         fpxU6w34lfowBjRzeRmaxhp6/1gnCDlNqlkaL6idb4un2qovnQCdVWjOSjST6kxKsTQU
         OgPR4L0IIwvM903enH/6z76Y9WdtD9ZSHN5J9ZFSSPw+ycc5snri5ie0Eok7RBwvLXS9
         EQ9JoFYacPtw2harJAduu0nWS9DV4HzTnEqHcZJ274qHSePrmhtbbPLjfcs3suotAxTb
         F7wg==
X-Gm-Message-State: AOAM533E1B4gCSNuEkDISQ/2sA1LxFTX4wpjUKQikXeJY489sUZ7joIJ
        bUCxZ0NTeevpms19qiVLihYqpw==
X-Google-Smtp-Source: ABdhPJyPrFZX+5pwRIKZPPeQK4A4jUwO3uipEsTKpcC6jWj0kzsQuyrY2QTQVfd+Xskfj8KzzUznLw==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr16095837wrp.422.1611843595619;
        Thu, 28 Jan 2021 06:19:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d9sm7257096wrq.74.2021.01.28.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 06:19:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
Date:   Thu, 28 Jan 2021 14:19:23 +0000
Message-Id: <20210128141929.26573-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210128141929.26573-1-srinivas.kandagatla@linaro.org>
References: <20210128141929.26573-1-srinivas.kandagatla@linaro.org>
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

