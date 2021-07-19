Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBFA3CECFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348325AbhGSRkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355319AbhGSQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:36:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28397C09CE7E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:44:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r16so27302126ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwQ5WIYCU+Iw0FKCHUpemUOKm2/bld2/msmvptg5xQo=;
        b=LS9NBl4p0lof0NUwVXBpRejKAMayY3KAb9qd5S6zm+yblqlquYhOrdUY4SZfQmo4ya
         ay85BuSGLOjWveXYjTDrLRf0vsC2J+ec+hlh6Ol1AWXu0hSEILtRytK+TtdHDLW6IH3q
         a+bRO0I0/XYHqnUstI8Ych1ueWVauJpQvI0/jLJpW7D1xNqTlOSmmIqa6dU0FB1TKf3h
         92kj3574+H97vvNvMNiDoxC43hqhQN34rRwbtbTg2ZMEwoG71fDYgIZY8XtTJr5rDg0W
         S+e1n9sEF8/UY2KFLvHmRGWhbdkxL+B+6A6VFFxzBN+Y64FXtSCkbWJPrzfxsVZ9Q1no
         V4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwQ5WIYCU+Iw0FKCHUpemUOKm2/bld2/msmvptg5xQo=;
        b=VbS1eoY5X4T48szcF53GhtZxv3o7Ax7zLxxCTzSLnWxDPJCdQLlfTfzx2FVdRFzvE6
         LaYRd7JDumxOtJFoj9yGi0b65/EAo3etPga5iY2/9e21ngyq/XSHcQD0pz3cNcbi6wuD
         tK3Sv5EVVfP1DMgJZ80UJsopANvk0XZ6IfU/2LT/fj2lWmGiA0iTPO2nElPvSB9Z2wpm
         eEg61WEK8yRWjeyBQ4GmAf7wegleRlexVl5vZYy+muQRsduf1FJd8rUQ2uTRAVDY2OzL
         2GaOV86NFy5fsA+CX2ZJPNS8NWAFHv3MbzfV5EpR7cpVSL/CWnMGQTnMQBXzwBefhs+a
         m/Cg==
X-Gm-Message-State: AOAM531zbITCqQr0I0e2uZcR/WuGRXDmLrmgqUBGoCXOb0cj11M5L+yc
        zlw8H0tSZVR+aEPaJEd4zpUdqQ==
X-Google-Smtp-Source: ABdhPJz4RWfEM6/7kxVUqcXSf3tITVQ2PFomqMF6vQ1qfwkGAMyCQoKxRLRNgeJs96WSISiMczhVDQ==
X-Received: by 2002:a2e:9c19:: with SMTP id s25mr23852580lji.478.1626714317299;
        Mon, 19 Jul 2021 10:05:17 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:b7ea:7e3d:4f4b:921e:b1ff])
        by smtp.gmail.com with ESMTPSA id z8sm1330749lfh.119.2021.07.19.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:05:16 -0700 (PDT)
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: [PATCH v7 1/2] media: rc: meson-ir-tx: document device tree bindings
Date:   Mon, 19 Jul 2021 20:05:05 +0300
Message-Id: <20210719170506.13539-2-viktor.prutyanov@phystech.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210719170506.13539-1-viktor.prutyanov@phystech.edu>
References: <20210719170506.13539-1-viktor.prutyanov@phystech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding documentation for the IR transmitter
available in Amlogic Meson SoCs.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 changes in v7:
  - fifo-threshold property removed

 .../bindings/media/amlogic,meson-ir-tx.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml

diff --git a/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml b/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
new file mode 100644
index 000000000000..4432fea32650
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/amlogic,meson-ir-tx.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson IR transmitter
+
+maintainers:
+  - Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+
+description: |
+  Some Amlogic SoCs such as A311D and T950D4 have IR transmitter
+  (also called blaster) controller onboard. It is capable of
+  sending IR signals with arbitrary carrier frequency and duty cycle.
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,meson-ir-tx
+      - items:
+          - const: amlogic,meson-g12a-ir-tx
+          - const: amlogic,meson-ir-tx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: xtal
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/g12a-clkc.h>
+
+    ir@ff80014c {
+      compatible = "amlogic,meson-g12a-ir-tx", "amlogic,meson-ir-tx";
+      reg = <0xff80014c 0x10>;
+      interrupts = <0 198 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&clkc CLKID_CLK81>, <&xtal>;
+      clock-names = "sysclk", "xtal";
+    };
-- 
2.21.0

