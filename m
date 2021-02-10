Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4513160A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBJIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhBJIIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:08:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b3so1407985wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADCBKNEvDCsXJjSVMo0gh3Ha9p8ktO5jYuFtRysBMF0=;
        b=YQjWY+hxJxeD56cqq89+O+y3MDwbuTakyQLYHodtIrzbPq8PcNsRLO5z6jEf4udjmu
         9ipNyIapLAnvb6vdPjQRv7+BS25p3zD57IpUiX8gYoEp5j7iIfoASJnaTevZ+VY/cq1U
         ZZ24OOieq/HVm2ngAm56Gwx9bRCOakIGJ+raObziF0qDxw8VNQKr7JdSmpCY3YXy/1aQ
         BGtVGf4fxV8sqHgyv3Yx1IYvR3REvuwY0OcN1tSmZmXJo43fJnUfNAR1+72iEAC0328K
         lRNmzIyQfGkI9im1sO2OwzfnfVhvlcXNjqPSNOIhriQ82XHP6cm9OWv6RIl/TiHG8nMP
         yhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADCBKNEvDCsXJjSVMo0gh3Ha9p8ktO5jYuFtRysBMF0=;
        b=beWDpQ8SN8lZQACSh3F0/rzMajYee9HmSnE0K66AwVrVBbzkJtvMH3Vvt1ozGS1E9U
         SN6EAlcupM3anEk10ojCLs/nNrf2X4YQ5WXBeVDP7idvke5qrw+yvy8SzGbxU+tz/7zD
         DKwGjE2Cb+f0f8eNHzvMbTZd1n7o9DubRByZJ+zgutLqdA/WXBBJJacmuOHRcekolFoY
         kCRljMTmTRA7WYI71ABPMCT81Mw1ncFtEtpkpOsRqB17VKcrUpICRRR9DH704cg7iYDp
         OnPkSxZRnNneFy9UTTm4xZVPwB/8qEKGy+sdRin9FuQPypYzdPh8x8filq4SLTGOAhDc
         +HsQ==
X-Gm-Message-State: AOAM531X6rGyzcwzit0LW3BWoZeUAQyoaD+DCuB8WjJGs6ti4TQXz/HA
        NY5foa4mj9zGaPLgS7hiUkZ4+g==
X-Google-Smtp-Source: ABdhPJxN7qsejNz3LbGpff6S3f17fETxX5jUqtrZgVWo2AQppiLn4e8WrPCGMJlCsA22dd/fAqA/IQ==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr2171896wrb.205.1612944463308;
        Wed, 10 Feb 2021 00:07:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:d403:f5fa:8912:cba5])
        by smtp.gmail.com with ESMTPSA id c18sm12856597wmk.0.2021.02.10.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:07:42 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, kishon@ti.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
Date:   Wed, 10 Feb 2021 09:07:35 +0100
Message-Id: <20210210080736.771803-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210080736.771803-1-narmstrong@baylibre.com>
References: <20210210080736.771803-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This Analog D-PHY works with a separate Digital MIPI D-PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
new file mode 100644
index 000000000000..14bb8d78a860
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic G12A MIPI analog PHY
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  compatible:
+    const: amlogic,g12a-mipi-dphy-analog
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@0 {
+          compatible = "amlogic,g12a-mipi-dphy-analog";
+          #phy-cells = <0>;
+          reg = <0>;
+    };
-- 
2.25.1

