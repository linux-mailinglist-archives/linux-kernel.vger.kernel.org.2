Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF13C879F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbhGNPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbhGNPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:34:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A29AC0613E4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so1690761wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
        b=agLBPgKG6NCQ7IVxrRVEplMT6waFwhNQPFhzQQpnpJKX7/YBMSJxK8w0vmN7DtVDGL
         n6ikaA3s1XieoJ4wRldmKO6pq8vcxxFdy8IS5k8GTYZzMzC+iKIUz673QMQaI8WmL9cZ
         hv2rjCDIlmlUxI4wLEsVn8lUOjIJugBtWJ6S4X1UsBmQM4Usmmy6uM++A73uREFhxFYd
         aFSNA+OW9gwsGk0HhsAlBlgQ3DRIlFuYyzyi6gDhUb+1/Erymzr82qHYGhfPHpJnB2dx
         u35VhguFMJxpiwV+YLjjbLR8WZ0BgLRIrGShF2Wvn25hY2xJVgDmnOKLaz0v/UjyFavT
         FeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idmBojPKMaEqXxTsPN9NMivz3VoeKNs2nUJ6x42cpzc=;
        b=HlFJLrxWPZfV8Q7s+dHtAkfDJYxmOzdINK7lfnLeAjj9+l9uTtcNqlhotWIlGyVg99
         4Ya8e1Xz/UZYlimGQUwL0cfiTvRppBBC8pNtDbBeTneibiydhzBy4ggw2gnB3v54V6Jv
         3/k+NfhkM6LS8Cz8kKanBpELQ3/6XTsavilPCqZNZhXo2kqqzFBtmRLxoS+lQFo9VUVO
         kdgPzF6IkxC3GxGvB3PiD+8RHhc4RVN2z+Ysk9lwqAHUUbqxcaU9qfZZKSRoIW04nGLW
         iICZzIetPneHdv5twkuyaNzZyYzdJXAzChJyIg634ZwPONH+ulOC4kfgYlQwaLBnItTj
         6ySg==
X-Gm-Message-State: AOAM532tbzFoWBEvr9UIkG63L0AItkadK3UeRIAskekoei8cPbatsR5D
        oVc7x+RtVLkWuhAaOK6S5amINg==
X-Google-Smtp-Source: ABdhPJyFR8qTlHqmBxq+Y/7qdiBh4rN3/klZm8ldzfOe2/EYYw/757jwvFtTjLXf6nZHKQSaQPgvpA==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr4732641wmd.179.1626276672854;
        Wed, 14 Jul 2021 08:31:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:31:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/16] ASoC: qcom: dt-bindings: add bindings for Proxy Resource Manager
Date:   Wed, 14 Jul 2021 16:30:34 +0100
Message-Id: <20210714153039.28373-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
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

