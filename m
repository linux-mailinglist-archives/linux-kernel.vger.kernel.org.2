Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7807B3B33D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFXQXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhFXQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:23:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE817C061756;
        Thu, 24 Jun 2021 09:21:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gn32so10485580ejc.2;
        Thu, 24 Jun 2021 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZoEaJeij2CjQ38SedyVevTWFQALRHJHQ48oG5DEREuE=;
        b=NPhcwXUypwt+/5f6w4gVqMcUtxw+jCaeLBptMwwA4U0ON7mImgJ5cGGAVRPxLnW/Y3
         oU77IrjilSL8Bn9IX3UJYShVsqd8cZqO5CraafPRCajpcfKt0/7zzWqgONLd70JOOyzn
         1EeY24huaGzC0TmrAwvkHdxmJ65IqA+WJlxk9ofzs+ojHv7OQVNYfNkeHlR8DtDMuoHZ
         0QEoFu73MYlMMzmx1mOMmWmdLu8WAapar+crHCCyeJtbov3pjGGxPlUrFfSd1a7ur3Yv
         4NfvOCcCvKDiUNIQDIptxDAYhA0bAW0bkAkmrJeY3yDCr90I33cmETkhn/PYLrj20ekq
         3eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZoEaJeij2CjQ38SedyVevTWFQALRHJHQ48oG5DEREuE=;
        b=XISCXU8MKk4oEc1Agmz5zTgln+AxcTLPW6wC8huydhLxbRpvWLkQ7d1R6mScIXcIKh
         5x508CrtSOh1YKzUnp7qJ5g8VLfvCg5d2i+HiMMh+MI0fl4qhQscAbSc5grKkk4CoVvn
         3AwTl8nFPPin3WuhT9MdA0w9ioAD3Bb9ru1RLKMrNlhTlzwCSFkVuLkbFwtmtdSx5K68
         bHB6/Kdw4vAtHVCOkGWHA1KSZMBkP/ym66Mc1Cp/g2SXCCd9aObmkIJbraqPzJEAaxXK
         weXDHe21g5CWj+ma48MXBMqu3jL5CS8cqn6l23tkE2yerhHFO199QBm831JMeub+qgE+
         mmHw==
X-Gm-Message-State: AOAM531qPdP2xYQ1XPP/ZfsbfoWviGIahhlgf71GmFIMaxlTr3gv/TfJ
        MjZAGeoGk0DI5Na0vkG75o8=
X-Google-Smtp-Source: ABdhPJyWConNpcqnRPV0RUtZ5Ucq1s8Ro2fg26AcHFL62HggGS6J32KWDOy8uuJhhifCbWakT3yynQ==
X-Received: by 2002:a17:907:da4:: with SMTP id go36mr5999414ejc.21.1624551688346;
        Thu, 24 Jun 2021 09:21:28 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id p18sm1332832edu.8.2021.06.24.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:21:28 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: add starfive,jh7100-temp bindings
Date:   Thu, 24 Jun 2021 18:21:07 +0200
Message-Id: <20210624162108.832518-2-esmil@mailme.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624162108.832518-1-esmil@mailme.dk>
References: <20210624162108.832518-1-esmil@mailme.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add bindings for the temperature sensor on the StarFive JH7100 SoC.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../bindings/hwmon/starfive,jh7100-temp.yaml  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml b/Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
new file mode 100644
index 000000000000..5ca52c08d142
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/starfive,jh7100-temp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7100 Temperature Sensor
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+
+description: |
+  StarFive Technology Co. JH7100 embedded temperature sensor
+
+properties:
+  compatible:
+    enum:
+      - starfive,jh7100-temp
+
+  reg:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    tmon: tmon@124a0000 {
+        compatible = "starfive,jh7100-temp";
+        reg = <0x124a0000 0x10000>;
+        #thermal-sensor-cells = <0>;
+        interrupts = <122>;
+    };
-- 
2.32.0

