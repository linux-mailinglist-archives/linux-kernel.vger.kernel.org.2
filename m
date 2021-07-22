Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009483D2168
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhGVJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhGVJQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:16:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C954C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:56:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e14so3848392plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFAzq1cRRdIrI+QwSGEpAIXO66croLV9YsUkTYMA32Q=;
        b=PsrOoWAkqh6dkfonRpDr/SK5Ku7QwJrkh6mKhluNLjg5DjbVNMFlGXZw4a7YGAkdZm
         UqZJ8F2/JN9Ph8FlGK0B9aVzABv+AR24uG84Bn1qAu8XaJ1M5OVR/QU/EQq6/M1+tNeM
         3i6uxRk5VLJvwL4DIigV3L50d0zf6f688z3RfxIgjWnMZ1eyHAREjpjPyJvNnZfwi5Qa
         Fa8EFUYBur8UmwAJnSel2XjzEGfUyx+qiIr3RbHM7qIShqzQMJpH4fyq/A4lRdKWhsvR
         bDrmM4NSQTn28JrQDtrJuFT+9dO59RUp8+HluBSYizWcrftarjvpZw7b7z/17eDM8Dmi
         cEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFAzq1cRRdIrI+QwSGEpAIXO66croLV9YsUkTYMA32Q=;
        b=CNTAQAeFP/FdL6gxmZThvnyHsL50xYwFIlFbqijtMNookb8R8+FnWpjA8cbZXvycWO
         TWonxbii7Zkp+VnIAohmvGaqFVFcInMFcnCwe5sLh2UZtmmSIlzETOe77tf3z9fAP76P
         KfYKjcSKfIxkls/iTYoohuedWY9bLHsM7WcWIXiiO/rDqyEWtMZh7V8U/fOCSKUzMMAm
         OUX+5MQqfC+vaRk/GcqtqrlY9nelQgju4KY4lnzl2FzAsodXy8b+eeCONM9D5Ld5eQsc
         2oG0KVTeiCUKiJLgY0nbJR42cjSPJ5XYC5PPUnPacNd+BnulmDs38oivs3lEEQZpB4LB
         2lrQ==
X-Gm-Message-State: AOAM533uzQbkVoiqTJgwwyi+/IUeoMRfmRd9XMGDcnmpy25siQmrKmGF
        IC14SlBzT9vyPYewCrENKsE/fQ==
X-Google-Smtp-Source: ABdhPJze27vHgBf6eiFDra5TYfTzpjUkBnln1aIygHD9XY8Tsdi4Y9Lf6xpc29kX3KftmTw+79L18w==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr39945553pjs.222.1626947815074;
        Thu, 22 Jul 2021 02:56:55 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id l10sm6274768pjg.11.2021.07.22.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:56:54 -0700 (PDT)
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
        virtualization@lists.linux-foundation.org,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH V2 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date:   Thu, 22 Jul 2021 15:26:40 +0530
Message-Id: <705f4426a17a395bf190ee6ed6c341ac25550f6b.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding for virtio I2C device, it is based on
virtio-device bindings.

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..0381d9065287
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
@@ -0,0 +1,51 @@
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
+description:
+  Virtio I2C device, see /schemas/virtio/virtio-device.yaml for more details.
+
+properties:
+  $nodename:
+    pattern: '^i2c-virtio(-[a-z0-9]+)?$'
+
+  compatible:
+    const: virtio,22
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        i2c-virtio {
+            compatible = "virtio,22";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            light-sensor@1c {
+                compatible = "dynaimage,al3320a";
+                reg = <0x20>;
+            };
+        };
+    };
+
+...
-- 
2.31.1.272.g89b43f80a514

