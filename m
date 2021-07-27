Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023563D6DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhG0FYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhG0FYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:24:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso2514085pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHUwfXrMCktpWTFh8tgPEYEudq0so6k6jsU7prpKKxM=;
        b=IUw/yKaT2Q1avrSaWO/Gu4k9VthmbqMHeBs5c8FGhtFdKAyTgXjTmNrLE5oim7W+Nz
         z2pGb2uJc57bBUq2TY0YF4ivQFhrWCWSAhVQ60/3uM8JhtbsdJ1zsKg327J9Fbp2qarn
         Dkz0bNo85bdqr0Gppo3GV1P0tU0IY6CSAv3oF3n0tml6DogIuCD0up0twu3esmt096yU
         l4DkTnFL226WUztDxN2hxLijlYeWHNtq+GMME0XKKICf8a8ajJ0b/v+RWeSBdMxePDPs
         yDne1HDTuUNw7sXtsK+66uPRpjqIpGS1IohIGIw9iIQzzuRcSk3O04WT6f0Y46tOBo4Q
         XB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHUwfXrMCktpWTFh8tgPEYEudq0so6k6jsU7prpKKxM=;
        b=JWlxmJj3mKLmx6iqYzQ4hGzeliR/XCNrUXk7h5ajeSIF3YiUNInGu9/cYpcm6kqesM
         ypQlJZbeaGQckDpKnVNtVEWLeCvJEztF/LZ2RAz3y90/kBlRlvC6NQ8cY2W3ayaRg4J+
         Z1yLXGQOhXkvs9wIx4QaKogkiBHRLf6f6gQyTMAQpbzNvaXoqeEgv8h72AhqeFbZKbzG
         QsC7J/yDbXAEAShuxkkXUz5y0e86ODMfRYKqvzSGATXD9cpQaTWrXrm0BWLt3RFYhID4
         M7YGRdmTpRUYf3Ad0W3b5z1pOPf7zZavEcmKE6lRZrG2wS4RKSXnLUsF1LWjteguxi/9
         IBmw==
X-Gm-Message-State: AOAM532zkNEODm1I2MtXQ/er9pP8jOB/ctqNGedKX4BQLzyIT5Yrb44A
        SIVqKiHbLOCYGZrG34KPTzRpaA==
X-Google-Smtp-Source: ABdhPJxC9KDHx+v2tl2AoWgFuDne8n7MbUIprrqPxQ66K7jIUhKfAYObHFAJ1+LulSKPVqbntsHnAA==
X-Received: by 2002:a63:550c:: with SMTP id j12mr21589541pgb.31.1627363449249;
        Mon, 26 Jul 2021 22:24:09 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id s193sm1917237pfc.183.2021.07.26.22.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:24:03 -0700 (PDT)
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
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org
Subject: [PATCH V4 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date:   Tue, 27 Jul 2021 10:53:49 +0530
Message-Id: <33c317b95097ce491845c697db1e8285e3ec1d41.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding for virtio I2C device, it is based on
virtio-device bindings.

Acked-by: Wolfram Sang <wsa@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..7d87ed855301
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
+    const: i2c
+
+  compatible:
+    const: virtio,device22
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
+        i2c {
+            compatible = "virtio,device22";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            light-sensor@20 {
+                compatible = "dynaimage,al3320a";
+                reg = <0x20>;
+            };
+        };
+    };
+
+...
-- 
2.31.1.272.g89b43f80a514

