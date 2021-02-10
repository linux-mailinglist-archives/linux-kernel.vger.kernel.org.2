Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49777315D92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhBJCxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhBJCwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:52:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D2C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 18:51:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u143so326460pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 18:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKEUl/8BfdEmVEI/D43kxjMasV/xJ4YnCz8a7+JpFhc=;
        b=IBIh8xct6WRtScFuZLWzPcHM+PoI1PpgUCgwUTBvQvEqhAZoFWkqIxcFJJPVevvxEh
         PrXiuDjPNYndkjzIAZsR+gzH7fOvREb+b8MkxBFZg/cm7WS2FSwtXD+2s6JnYKMGaX86
         KDyxRPYLhOPjcy9qR2bZP/dvdyY1h5Re2TXtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKEUl/8BfdEmVEI/D43kxjMasV/xJ4YnCz8a7+JpFhc=;
        b=B5rQdE1bRLAFRj/5Qgree7puH1Ad055fUkuYbDA/Hp16u3hPJwulJgSXInukqLmLGN
         HqYZOwoe/WYG1qyX1lY70Wt/iHBS8g8s1izMTGywL8Ols02YroG4wrFz+Ao1ehJqzj3i
         nRY03K7kOsS1R7y5fU6UorFYNEt/jiiIGrBS8BUkd/xgal1gAeUK0Sbq43LFDaV6Ry9w
         NikR8VTfAS6P6DsYQ9nEHPCvD8x0qkHa6ab4I0gfyP4LO2cvDx09EkmxvTeV5qLFY4oz
         hVlScCTQ694xTTpkhZVD0owM2dGWiRZVlL7BNvfiVUV1NnX3HBfUUklU55J3sDL2DRLt
         idBQ==
X-Gm-Message-State: AOAM5320GqJKdmcSaOjD+aMLlfE/5ETUIGNgc1eBQXQ+V4QYhZkSYY17
        IbWaRRJPP2TtD7moLUVDLOtgp8ztbMgZTw==
X-Google-Smtp-Source: ABdhPJywq/KHYRUMJS5Zqj5wsuxUsCZ0TCxuxb69ieXMemxFr/Zq3R2wB91+m3pbu/9HEYDi8nqG2g==
X-Received: by 2002:a62:3247:0:b029:1dc:5a62:c367 with SMTP id y68-20020a6232470000b02901dc5a62c367mr1095093pfy.3.1612925507153;
        Tue, 09 Feb 2021 18:51:47 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:58e2:748e:a316:9823])
        by smtp.gmail.com with ESMTPSA id r13sm139420pfc.198.2021.02.09.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:51:46 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v5 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Date:   Tue,  9 Feb 2021 18:51:41 -0800
Message-Id: <20210210025142.3609708-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210025142.3609708-1-swboyd@chromium.org>
References: <20210210025142.3609708-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cros ECs support a front proximity MKBP event via
'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
a node that is a child of the main cros_ec device node. Devices that
have this ability will describe this in firmware.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v4:
 * Reduced example in iio binding and moved to mfd
 * Dropped unevaluatedProperties

 .../google,cros-ec-mkbp-proximity.yaml        | 37 +++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |  7 ++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
new file mode 100644
index 000000000000..099b4be927d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC MKBP Proximity Sensor
+
+maintainers:
+  - Stephen Boyd <swboyd@chromium.org>
+  - Benson Leung <bleung@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  Google's ChromeOS EC sometimes has the ability to detect user proximity.
+  This is implemented on the EC as near/far logic and exposed to the OS
+  via an MKBP switch bit.
+
+properties:
+  compatible:
+    const: google,cros-ec-mkbp-proximity
+
+  label:
+    description: Name for proximity sensor
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    proximity {
+      compatible = "google,cros-ec-mkbp-proximity";
+      label = "proximity-wifi-lte";
+    };
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 76bf16ee27ec..4dfa70a013ae 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -94,6 +94,9 @@ properties:
   keyboard-controller:
     $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
 
+  proximity:
+    $ref: "/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#"
+
   codecs:
     type: object
     additionalProperties: false
@@ -180,6 +183,10 @@ examples:
             interrupts = <99 0>;
             interrupt-parent = <&gpio7>;
             spi-max-frequency = <5000000>;
+
+            proximity {
+                    compatible = "google,cros-ec-mkbp-proximity";
+            };
         };
     };
 
-- 
https://chromeos.dev

