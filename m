Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16D83071D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhA1ImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhA1Ilh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:41:37 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9B1C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:40:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o7so3846923pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObnRw+UwieoHw5e283GbHz774WubLDbRFDgtC/jAPyM=;
        b=ZbwKx9ek06554ZjIa76NgqqDZ6YawaI0v367sDg45ccv7tchvKEciOKr07GuZeEVXm
         cYi2B4+LabGQcNTWYVeR/jtx2ZMHCQP+53mpTC1XfhbPKXa4noOUrYZs9ziNlm94KaYN
         9wsMF/Eqoz7WH+4nUYaGM94IjdsgZJMy7nGt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObnRw+UwieoHw5e283GbHz774WubLDbRFDgtC/jAPyM=;
        b=sa+rUoOnonlgXcnd121yhnoI8mppZVl8P/QFvjkF5c3gywmaTttP1JiSxk6AAnDtVK
         VPCV4JtIvXX2kGoM6KuGehgpejXPAxcUnjJ1OaiqjbAEzWYe+t8gbepcUsk8OtSe1n0F
         ++z1gupFm0GXU1w4aHG8Mp0cYCzKChT4HLcmOAijMCnkKGkDNGM7yP18DktIWoVPrqCe
         TRMUuvxOQZlKXEBGhSbOy9BhL7zGWDbBeRUy3pol0p+P6G8IhZhW/1PBhw0kTAyqTgDk
         6kELi9rFG3K2oTre1/8fN4KB11zmdYPEtmEcbkdnqRxjtnQ5ggOt2kv47SY6RoGjzs6e
         kkkw==
X-Gm-Message-State: AOAM5317BCN1UpfGRWmYbcMvFpuMbN5RT5aNx09pn0juUWne/s3RD0Ik
        y1RL9w583lfvzzupl9A40Ua/aA==
X-Google-Smtp-Source: ABdhPJxcS1SEeMZhYeszPxfpDT7lIOhORsQWrdlWcS7FnoBFUApULusKLFQQw7C2YUA/uoec7asrCw==
X-Received: by 2002:a63:2214:: with SMTP id i20mr15168549pgi.189.1611823216259;
        Thu, 28 Jan 2021 00:40:16 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:304c:5453:303a:8268])
        by smtp.gmail.com with ESMTPSA id y22sm4951757pfr.163.2021.01.28.00.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:40:15 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Date:   Thu, 28 Jan 2021 00:40:10 -0800
Message-Id: <20210128084011.3270281-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128084011.3270281-1-swboyd@chromium.org>
References: <20210128084011.3270281-1-swboyd@chromium.org>
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2:
 * None

Changes from v1:
 * Added additionalProperties
 * Included proximity in cros-ec yaml

 .../google,cros-ec-mkbp-proximity.yaml        | 38 +++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |  3 ++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
new file mode 100644
index 000000000000..c3141c2be286
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
@@ -0,0 +1,38 @@
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
+unevaluatedProperties: false
+additionalProperties: false
+
+examples:
+  - |
+    proximity {
+        compatible = "google,cros-ec-mkbp-proximity";
+        label = "proximity-wifi-lte";
+    };
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 76bf16ee27ec..479a9f15de32 100644
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
-- 
https://chromeos.dev

