Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69A3C8400
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhGNLnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbhGNLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:43:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B4C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:40:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n11so1352643plc.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yyUS8t31cKqvw5DoqN9PIZycxPq1uskR9MDa2Ni3Aec=;
        b=Pq4gZXCFYLDjGDfUtxIOaow0QXrcR3Pv1tV9I0/aK++LfP3MjqyHs1jnYA82u6tWOs
         xb/TR85T/0G+fV7zO+27ibm0ZuzSnk3PSG7REXZT2hT8fC1fpzw7w6vg+n/EZLrTMrY3
         rQohrM/I+fgFXgP9fxVj3MwLfabyxZYjSeO7ZzABU8VDA0QROI5kNUCqSH2TmS0NqYCY
         8+PSoisVRkIREzIg7Slmr2rbn4SRbLg8Ubn/36pBeviyNJglRGlHWIEkIi9r250kVFzR
         aygxVBzsub/VVbeGoKzvvo8WKhln4QXhEMb+9uq8mw45e3L0CW3ytxf123b1CWafRzMa
         r0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yyUS8t31cKqvw5DoqN9PIZycxPq1uskR9MDa2Ni3Aec=;
        b=HwX0QKf4ZVjh3D22a9WQ+ZnNj7T7lJfRFcMJeVmc+u33gZ3H4y9LEhh7Z1kkj8bK9f
         z7PLd7Rn6hXJXfekAt/4gxFyb6ZiBTneNKf3wScKR3vxQSmGtiy1xwxPasMGNYQHxCI7
         klRL7SoAMfU7XXdcQrQejwH2w0xoSDKi/LnL3b4EUq29jWO5Gt9g3hS8xL2vzHlrOW5l
         IXowN7TyRoadZielTGyE5lTrJ5/xYaewRKFvDZEk2BXzlYiTnKxf+3X02iBHfF0VBSow
         J6g4QUo9IM5fLvaP1OdlxZESdLHtxGq5N4wb16U/JZbQqEfovP1ikrzoGuxPF9z8VK76
         4P4Q==
X-Gm-Message-State: AOAM532RH5rwqIdLc9aPd6TR8Po2rvtZYB+7rF7cPSm+nAJjlwSvkjfe
        g3xVRGH7oBKpCL8IICkRZQ8qeg==
X-Google-Smtp-Source: ABdhPJz5jWZHVkciRR7sUsbqJ34y1n/TslfC+AkDBDsyHKF9eXQucvzkd6lyxnhhb5j1+lldvd8JCQ==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr3468344pjq.86.1626262811098;
        Wed, 14 Jul 2021 04:40:11 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id w69sm2601002pfc.58.2021.07.14.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:40:10 -0700 (PDT)
Date:   Wed, 14 Jul 2021 17:10:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714114008.kohvyz57fvrd7syu@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
 <20210714022630.d7vrazygmbooflcf@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714022630.d7vrazygmbooflcf@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 07:56, Viresh Kumar wrote:
> I agree that even if the device is discoverable at runtime, we should
> still have some sort of stuff in DT to distinguish the devices, and
> "virtio,deviceDID" sounds good enough for that, considering that we
> already do it for USB, etc.
> 
> And I am fine with both the ways, a new node or just using the parent
> node. So whatever you guys decide is fine.

I tried to write and see what it would look like after using the
existing nodes for mmio/pci and here is what I got.  (I couldn't find
any virtio-pci bindings and so stayed away from adding any reference
to it here).

Does that look better ?

-- 
viresh

-------------------------8<-------------------------
diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index d46597028cf1..324b810e51a5 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -15,7 +15,8 @@ title: virtio memory mapped devices
 
 properties:
   compatible:
-    const: virtio,mmio
+    contains:
+      const: virtio,mmio
 
   reg:
     maxItems: 1
@@ -36,7 +37,7 @@ title: virtio memory mapped devices
   - reg
   - interrupts
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
new file mode 100644
index 000000000000..9cfe090ea65f
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/virtio-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio device bindings
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+description:
+  These bindings are applicable to virtio devices irrespective of the bus they
+  are bound to, like mmio or pci.
+
+allOf:
+  - $ref: /schemas/virtio/mmio.yaml#
+
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+select:
+  properties:
+    compatible:
+      contains:
+        pattern: '^virtio,[0-9]+$'
+  required:
+    - compatible
+
+properties:
+  compatible:
+    contains:
+      oneOf:
+        - items:
+          - const: virtio,mmio
+          - pattern: '^virtio,[0-9]+$'
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    i2c: i2c-virtio@3000 {
+        compatible = "virtio,mmio", "virtio,34";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
new file mode 100644
index 000000000000..8115ba794557
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio GPIO controller
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+allOf:
+  - $ref: /schemas/gpio/gpio.yaml#
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - virtio,41
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: virtio,mmio
+        - const: virtio,41
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - gpio-controller
+  - "#gpio-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gpio: gpio-virtio@3000 {
+        compatible = "virtio,mmio", "virtio,41";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..43e9910920d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio I2C Adapter
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - virtio,34
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: virtio,mmio
+        - const: virtio,34
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c: i2c-virtio@3000 {
+        compatible = "virtio,mmio", "virtio,34";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@1c {
+            compatible = "dynaimage,al3320a";
+            reg = <0x20>;
+        };
+    };
+
+...
