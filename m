Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23C239E079
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhFGPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:32:27 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33327 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhFGPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:32:18 -0400
Received: by mail-wr1-f42.google.com with SMTP id a20so18164577wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
        b=vbXNC70ULxFFKb2gCHU+vvjhZgISGdWZ3B66ixqhsf3LWTQMUe7MN2fQfMQKBczDXu
         AJBltuf8DLQxCUEAsnoWbQdbRUt4598NJViyUyLY9ix8uAAr/UVBfqmLkAH9VxhdYhYN
         Lu2bVDSLdhPMRtHQE+RKUkId0BYQfrmEGwuWbvzw81oEnSQgJThgttlyZhgfsLwGOcOH
         HV7FWiLS4GpkrY7mvM1TAJepNBjVw6ngc/1dxB7E1Nz4E7/XJvKQtBtl2pa4vLvXXF0P
         DjpFuOHy4iDUubcbpAYQWWVrzyqMC6+V6pEQSJclbIohaBv8Am7+5Nkvhas4TMjeDeng
         E5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
        b=SYL5EJs/D3UF37Zt3n1PXzAdGyrUIfR4ByDAeQ5hsYWDwYxGBUjX15iLaOzdLK/eqt
         s27qgxrMDvU3yekCaaX882MRwq+Tbltt1HibGXSLbKHlrLEmFl3z6cV25qxMLaNKFCRX
         ZxUq5T0gK+wSyU+AG+2CCkUYRoGnxHICZe0BsxSGP9/XuHpYRF3QGJOc51aAjLDXSPa8
         icWDqNf5SjE2Ug0/DK25sIBLdcKx8JrbXXHrAb14wXWv+NzW+NepC3kF8XK6YXcXF3/V
         ze55/VvgpHz3h0mXh7lNMPuOVShh1h1tctPXcDz5evCgztDEfFq3nA19w9rWP3uitrJY
         V6IQ==
X-Gm-Message-State: AOAM533Bnlh8dyLV/0BOEKiYROTLgaLAEaOoayKABUg58ATGvdol276k
        B9mZG8R9MQvtR12ZuWX5mSl4TQ==
X-Google-Smtp-Source: ABdhPJyihoRf0jBti0BaOD0KEen6Y1OrOVBSTVZrojU+gBnh4nUMuKYPhsE3C1kCmUHxfCUoA6+v/A==
X-Received: by 2002:adf:de91:: with SMTP id w17mr17979866wrl.352.1623079753520;
        Mon, 07 Jun 2021 08:29:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q3sm16370170wrr.43.2021.06.07.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:29:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, robh@kernel.org,
        devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 10/13] ASoC: qcom: dt-bindings: add bindings for Proxy Resource Manager
Date:   Mon,  7 Jun 2021 16:28:33 +0100
Message-Id: <20210607152836.17154-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings support for Qualcomm Proxy Resource Manager
service in Audio DSP.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6prm.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
new file mode 100644
index 000000000000..6f14146c1ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6prm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Q6 Proxy Resource Manager
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Proxy Resource Manager module is core module used to manage
+  core dsp resources like clocks
+
+properties:
+  compatible:
+    const: qcom,q6prm
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gprservice@2 {
+          compatible = "qcom,q6prm";
+          reg = <2>;
+          #clock-cells = <2>;
+       };
+    };
-- 
2.21.0

