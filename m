Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5A3D215F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhGVJQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGVJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:16:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B119CC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:56:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n11so3860061plc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
        b=rT0HWshXd8nGdtBqoZiI1S6Ws0VED0exTJOCWSfoURsHS8z0r1DP8kKfEqDzoWRlCk
         ZpyIVRq+7RxtvnBpF/zFFE08CrsMw0EhoJ8nRM8PVPIFOJnTWplPOoWfAKmDYHL4ujnR
         3qZlBy11EOkr7TNC6WkFIFv6XipygWZq0ACOPDtoAr+XVYhtSL04jKJm0PkgN42byHQy
         muaFvdyDV4bPBFwvtEIjNXV1HqZq2mXzlKkRLmkE3nLc2AXBt2V7XXKO2YmSQp4Fqn2O
         gZtBiljKKyxV6gOGkmJs1WN/00aAbmkNE/HBT/pch6yzRemSo64jG3TXfnuqM2Z39Dal
         zlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
        b=MbKZveRT44k47W5YdvNxhfHDfFL5roetjSUeOC2F/gWSgMBsHd0Avtby1eyKBIMRqf
         tc8/AWWfEa/5FLTkXBBWQLnLyvCocT3CRF6L6LgK+CASBB9JjBVGtMoR4885Vbc7WU26
         jdMtpl8kKLcmILuin5Lpr9wr+9GTHLdZP0UY8RiIiwH/oJ4HDCkUZ7i56tQIK2Yeo19X
         Fon3rL0AA46pdEE9mmgWOwLBQZU7L4XwP9M4v8Yv2FJadaLESUfHI8jGJt5RkSqquOV6
         aOYeu9WTViM7j2CYApNoWw/Onm7u4E6/qfSy3d/Tacm2dz6PtNlJrfPtJ2coTXNAPx5f
         yAjg==
X-Gm-Message-State: AOAM5303Xp/oaIgV1NUDnFr20SWAOYWl3i7Oc5mVJq3+YUK/ikjWvMdX
        VaUk7cDVPV49r67v7KfaB/kSlQ==
X-Google-Smtp-Source: ABdhPJzpK4LcdQ7DS4Wei+znEiWyuGaIxO/4odGAGPJsdCKZayHrfSHrgCHCp3fGr5RCDH5CY+jD2Q==
X-Received: by 2002:a17:90a:d598:: with SMTP id v24mr37859955pju.185.1626947812304;
        Thu, 22 Jul 2021 02:56:52 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id j21sm24845767pjz.26.2021.07.22.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:56:51 -0700 (PDT)
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
Subject: [PATCH V2 1/5] dt-bindings: virtio: Add binding for virtio devices
Date:   Thu, 22 Jul 2021 15:26:39 +0530
Message-Id: <fced2f2b9dcf3f32f16866d7d104f46171316396.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
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

