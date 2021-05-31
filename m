Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA10395E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhEaNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:54:48 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:9582 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhEaNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622468095; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AcChp3Fj2lhwkAli4aO/ks3Gto0C5aqkma5tKwo3iXZ4Hfqysq5C4vjobnNlMqdEUt
    zGh90Dgydr6951KdnmZd6F1VeCnU92vDyTfFXoW9oTPdXtF9T3nXMJWKZrrQ6IoS8v5L
    A+/u8+S+QtqLPbAnX37Kiv39NDheASwz3Wa9LD8yP6UfRwanaHa8n9a5HI/lLQ2sW/P4
    vUOIn7a76AgUjHsJVH67u21dLHPLJjToLnL7cdTpl2LR50Pv4Yt/TieDue+vcPMCRBIz
    Xv6vPWBZS43VsxmRc8qc4AIQ8gWqh2UaccBReKqlHzsqtc5oDiEl04GOKfuO97WjVgr0
    jAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468095;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ja+Dyqh1Z6Ju11L3zE36ZgR2UU7d8g6j7i6GUDH+quk=;
    b=NEQysCAF1gGz4pSz+3eiqy/1/9OoT4nxHx4+GQix6noiEoTP9IX1xrRLYTz7uPcf+L
    +KcMyBKbWbFZ6WatO3FtsnY40I3x42JTKpGy8oI0OFXr6CxQJvJDkCbheWjn7hqmu7Nq
    toh7jR71UrZPePLfBsglPpXQs6WtN1cbofZsJv9hzSipfnFfhoiTPUJB4k4wee5zW5Ke
    CxVmJ+FyIAoXhtJDDkNZGWVzPmlyTJzEG+m3tmqKyW9Jy6YBhZl19AAJGKzyqB7kFkuF
    rE3LJHH3A4ed2YYFSLWBCSFHTAyRgiXP1s8xIfFJLtO8UKwQpundtMiMsaANj+rtWbfK
    /TIA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622468095;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ja+Dyqh1Z6Ju11L3zE36ZgR2UU7d8g6j7i6GUDH+quk=;
    b=jDGDdorsm7QkOfGExZ4PgbzS9NGySW2jWZ9IhxSKxy5NggIGJjNyPgb+Lp2BKJneUx
    dITP4emgw5KqXZdwr92T6xaRAGXinonyMSQ3deVK+lG3VaQGcGxu57JZH4Vo0K7YQd90
    utSn1m5XS5YukyfJ3u5HAa0/Ii2zlrR5WXfAXRctwGIMLpuYW1SAIeED1MiUwxTe5HWf
    9mf6k90t6XMhug0RyQPEhSMTC37JwWu7fbFqrwWiTwTIGy0nDRtYCIcp0dGG1GTRDeHR
    ix1auwU8fCPzUD3VVeegkw66cMpZKhtTy6bJPxKDPPSejsxyKD23JOKGLeZ5F9gbFysk
    qWgg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526Kcak="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4VDYtKxB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 31 May 2021 15:34:55 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 4/6] dt-bindings: extcon: sm5502: Convert to DT schema
Date:   Mon, 31 May 2021 15:34:36 +0200
Message-Id: <20210531133438.3511-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531133438.3511-1-stephan@gerhold.net>
References: <20210531133438.3511-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the extcon-sm5502 device tree bindings to DT schema.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/extcon/extcon-sm5502.txt         | 21 --------
 .../extcon/siliconmitus,sm5502-muic.yaml      | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-sm5502.txt b/Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
deleted file mode 100644
index fc3888e09549..000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-
-* SM5502 MUIC (Micro-USB Interface Controller) device
-
-The Silicon Mitus SM5502 is a MUIC (Micro-USB Interface Controller) device
-which can detect the state of external accessory when external accessory is
-attached or detached and button is pressed or released. It is interfaced to
-the host controller using an I2C interface.
-
-Required properties:
-- compatible: Should be "siliconmitus,sm5502-muic"
-- reg: Specifies the I2C slave address of the MUIC block. It should be 0x25
-- interrupts: Interrupt specifiers for detection interrupt sources.
-
-Example:
-
-	sm5502@25 {
-		compatible = "siliconmitus,sm5502-muic";
-		interrupt-parent = <&gpx1>;
-		interrupts = <5 0>;
-		reg = <0x25>;
-	};
diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
new file mode 100644
index 000000000000..0432b0502e0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/siliconmitus,sm5502-muic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SM5502 MUIC (Micro-USB Interface Controller) device
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+
+description:
+  The Silicon Mitus SM5502 is a MUIC (Micro-USB Interface Controller) device
+  which can detect the state of external accessory when external accessory is
+  attached or detached and button is pressed or released. It is interfaced to
+  the host controller using an I2C interface.
+
+properties:
+  compatible:
+    enum:
+      - siliconmitus,sm5502-muic
+
+  reg:
+    maxItems: 1
+    description: I2C slave address of the device. Usually 0x25 for SM5502.
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        extcon@25 {
+                compatible = "siliconmitus,sm5502-muic";
+                reg = <0x25>;
+                interrupt-parent = <&msmgpio>;
+                interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.31.1

