Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D97B38ACD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbhETLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:42 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:9021 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241478AbhETL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509958; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kgtEbhr4OPZfh3xyLyj8TtSVTz+m2R51PCDuT0+OnwYsRH794ekSwe2UtH+f9A5fxm
    rLCY+xwoENnaBCqACqI634nrKOtVAVPvHbXiicraKLS4IlMMALYHVcK0lW/qlxaVUjs+
    mR6gu7nRTLkMuWZFoHLDbbSw0inVyHeaiiUevUE4/VZn9t2RAQhjbUHv2paRuC5KILgr
    MGkAIG9zxixpaPokw1E4yJymKTY3EsLncFZfweX4YJ4aj+GLNa4Rs0C/gOkRKflPuhbd
    egrIrtnIBtgjeT7ct6YAqGMov5n2wonTI5DZ8MtM6GjSSwwS4YdZGKaZn6YjpJxHVO8s
    TCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509958;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ja+Dyqh1Z6Ju11L3zE36ZgR2UU7d8g6j7i6GUDH+quk=;
    b=rv5PJzVPlktJhImPBjsrcFC0T39VK4t3E9R0CrCgQ1pjAhqhNGFCT2Y6QWggB9Wd6c
    NIqc9KkbOx7TAv07sAcnRs8i1iXp/8+kRT1bevZx+twsMqodhwCX8Ve80wsU01AYmvA0
    y9hiHOgWBiFdSAZq9Ei8OYXnrxEMeHJmlk/GyeAZtSXfXjZmo1fSeZLyR9TBmjbFbwnI
    6axM3gAHdkgz+8BPuqQ6N7OqspW65LJ5Fi4ki49u7ZKPmFC/HKavOpJnP/PCy3g+QtBX
    a9L9UdM1nMCfRGw66mD6ue+gHbR9B987EI+3Rz3f1kkn7M7bHQkoRoThnHcoGsgGBH2U
    fY9A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509958;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ja+Dyqh1Z6Ju11L3zE36ZgR2UU7d8g6j7i6GUDH+quk=;
    b=Y+PMpJY/PwStsGVv+it4bK+Ja5DYD/U1Fnzt/vpg9lcBPAxQeZPs5AyMX5PsBdZZD+
    88F6Q8FZOscynNRsSh2VJkYrEE0/n0kPrODchdT+pTtw8IYTFcrvlB33dFrSXm2wEM25
    56GShHPHToThF8h3buqm3X3UFBrswTAxU229oEHuEgcmoAuqxvqks1ZYy+ST9Qb5H8CF
    oQ3cUwWHBDoEs5Wezzha40BTQ4he4RNQFyVkXCyyp0nBH/91jnEbcZasJ7mnCdx5c0RE
    y9NQOtj28mrDwWz2Coc9aUsiYQ6VRMOFGPXlULC67DLkMTq4vFOXy2cXzRjPn5eNlHsy
    eYzw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPw22W
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/6] dt-bindings: extcon: sm5502: Convert to DT schema
Date:   Thu, 20 May 2021 13:23:32 +0200
Message-Id: <20210520112334.129556-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112334.129556-1-stephan@gerhold.net>
References: <20210520112334.129556-1-stephan@gerhold.net>
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

