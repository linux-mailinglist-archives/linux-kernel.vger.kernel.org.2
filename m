Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5D3D52AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGZELl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhGZELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:11:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93733C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:52:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d1so2880351pll.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25stCq9hJ2wceSqg94GCYZ0IegUstb1Ha6+CpcC6mxE=;
        b=w3jI5G4dOmRLxP2MlxkQOM2/L+5kcH9M9Un+WZvOEFtFgbL1253v+O6A900H9pX1OR
         qw9GFzKgAHqsrSJv+xKzkMtnxu1u/k2FsfUMM1jvwQ7qiqwCBoEnT2kKN5BFtfFCrJrT
         zLaW0eb8OTIpMtSe7SRO+IeJrGQkCkhy0oq2jYpTMgEpeBMMX1acx7jWiBTtABkWiX09
         Naj0FNAJXC7dcbn4cIjgDHkKmWbDsYNlvr19r4z7ob4upxnluKGyAwX8INWrwqjTjOeW
         +xVP8Pg8xLAdzd55q5lvBBX9Vr/Nv+DCBhy7jd1sGD2JEonDcgIvAs5XUlq2VGQwP95Y
         AsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25stCq9hJ2wceSqg94GCYZ0IegUstb1Ha6+CpcC6mxE=;
        b=AET9ExOnZCMf4d30ZDDSxiY6U3uJ/9e0PC22ELfOKuGhWV1BBO4ZW7CqXscZ1Q9KRv
         jxTvPqJQJ8DQO4g7sRIqWMWdS3V4GjTuOxxPkLPt6p+pzV9x0s1Cb9n1Swe6csIwH7+P
         kG9rRyOuFnnEO5bTNdN97tvUG+xHQk2sUXopiHXW3+L9S9GALh0mg+gR081eM+LW8qqi
         jpdByMBhHfjiYR1gHp5JZMjgRjnkVpye5hs5EO6+YOs6x3011ddeAD9MPlPAw456D0x8
         b5oARh9UdkJONrISTi9nNcJ5X+g//IN3dy6QGmsBKF7kSiy3NQMxcxJFsxWTOJXrjlz/
         4cng==
X-Gm-Message-State: AOAM533jB07MxHO2hc8w2P3ehEIZ/DCAUCjwZm9I75aRSt6NdodxkviW
        uCXwqrk/11rTR80/Wer7ybJEbA==
X-Google-Smtp-Source: ABdhPJwNPhh3+pdzKQ+M8usE3bVyjxSjNPWjsz7M3m6jZ8gVABNHZmWDEQUzTbhje9b+6aWj/M6+jg==
X-Received: by 2002:a65:6a0d:: with SMTP id m13mr16774454pgu.356.1627275126102;
        Sun, 25 Jul 2021 21:52:06 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id q18sm41345108pfj.178.2021.07.25.21.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:52:04 -0700 (PDT)
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
Subject: [PATCH V3 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date:   Mon, 26 Jul 2021 10:21:42 +0530
Message-Id: <4182aff2d1437b30025f3d17d11e5fdc21845239.1627273794.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627273794.git.viresh.kumar@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding for virtio I2C device, it is based on
virtio-device bindings.

Acked-by: Wolfram Sang <wsa@kernel.org>
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

