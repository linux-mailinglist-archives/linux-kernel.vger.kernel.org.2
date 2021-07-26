Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7903D52A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGZELf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhGZELd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:11:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642EC061760
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:52:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b6so11252984pji.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
        b=ZNxdofEazuCanYJelkULP0+4OuqXw2vw2lLc6piV+972Mo2ZMLPaKvvgt0IeKeeOz4
         qfs1uZUtM4SK2si8JRoCdtymsO11GLCcE3dvHNw2RvTb81Op5nV3XSybxbruXjNV/k6U
         uiyQKL2dOkyLbTmCQBvIoJtmU76+bBYUQVsrfwV3/4etV2OplljWvUKFedVvS7S4tLz6
         qPuZ+xPD58dVHGWU4gnH8urTbFlJBUS+bsnPJyDWy308Hc2jbeOdFnFrxxxWDgIdduZj
         VPVm09fCKAnFZMjSZUk7opAUFtgLYbqIHx32jSDW934DBT3Vwqk5DlaMbp1F2DzXks5/
         bL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
        b=Obo9AN4WkbJxnOCBymyYq1NQIlpwG74NCvEGLB7bzd2c0XOwhO3x/laFeicT8c01Fa
         0Z33o7k7WdTwuNPa3myyQqhLKmQhOjBu1vWTfIwKcurTGzd2o4Jd4yW6VRqPiy+yN7w+
         Z/VzufvA/kAjgiwaISe/aRK/OQpPNOL9zZlU74XVEdUtulCK+cF9oiPZbO69LTaR6gtN
         qZ1x69sNuHRCbxFX/UzTZnWLdeZP2groLkJ/J5O2mXmVJEQxEE3sWFAluw04zSCmUo+C
         hF+aGH17u/v87aHApVtNtX+2YWbqi6KgPzQD4axOLDv2edHNWmlEyQ1WE7A0zeHeWa1A
         fDqw==
X-Gm-Message-State: AOAM533ETBj6C/DvrHJGZMDLda8qk9d8OWZTKgZ83Cu/wbHaUFB3UV0+
        kYKB5p9dFf8Akr2uhRPEeqHn3A==
X-Google-Smtp-Source: ABdhPJwh6XJFEYFMK7YevFdXoJw8PPRK9tlakcKK8pDpbEwvvOlo+Oz2Ts8NSM0+usN9h6aj3YsOuw==
X-Received: by 2002:aa7:9687:0:b029:337:3b49:df24 with SMTP id f7-20020aa796870000b02903373b49df24mr15887381pfk.35.1627275122181;
        Sun, 25 Jul 2021 21:52:02 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t26sm45725593pgu.35.2021.07.25.21.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:51:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio devices
Date:   Mon, 26 Jul 2021 10:21:41 +0530
Message-Id: <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627273794.git.viresh.kumar@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow virtio device sub-nodes to be added to the virtio mmio or pci
nodes. The compatible property for virtio device must be of format
"virtio,<DID>", where DID is virtio device ID in hexadecimal format.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/virtio/mmio.yaml      |  2 +-
 .../bindings/virtio/virtio-device.yaml        | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index d46597028cf1..1b91553f87c6 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -36,7 +36,7 @@ title: virtio memory mapped devices
   - reg
   - interrupts
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
new file mode 100644
index 000000000000..15cb6df8c98a
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
@@ -0,0 +1,47 @@
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
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+properties:
+  $nodename:
+    pattern: '^[a-z0-9]+-virtio(-[a-z0-9]+)?$'
+    description: |
+      Exactly one node describing the virtio device. The name of the node isn't
+      significant but its phandle can be used to by a user of the virtio device.
+
+  compatible:
+    pattern: "^virtio,[0-9a-f]+$"
+    description: Virtio device nodes.
+      "virtio,DID", where DID is the virtio device id. The textual
+      representation of DID shall be in lower case hexadecimal with leading
+      zeroes suppressed.
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <43>;
+
+        i2c-virtio {
+            compatible = "virtio,22";
+        };
+    };
+...
-- 
2.31.1.272.g89b43f80a514

