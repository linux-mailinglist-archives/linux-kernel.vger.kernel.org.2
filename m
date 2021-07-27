Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919323D6E03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhG0FYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhG0FYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:24:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FCC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e21so9979063pla.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ruqu7XRyeoHO5d3dL3cpXjWaNCM/mJSqSGYC+47F2jM=;
        b=OK5Eq5EaYOj7pmvubgA/5zHGMhwmsXjjVac7YqdjIyrJAuYnBWil+CUwlP04n+LrdT
         f5NKctWjool1sMCzalGRQvx6uWxHQeH0ophl0ANynHrmCxpgHGRQmAxEqwdIo+eT4KDQ
         WLDPo8iG6MTUXW1jAcwHZu0N2HmZNkGgfXq6CU1BwTjN11zZVyUjStSvUvZHsjxeBlmH
         NWp7U7o5qADjx99jjJCRKdgiwdXKD5RvwtZaDletZ4v0zzsCbg511OuTR4OoWLgk30Jq
         NfULFuLm1p74l06sdwm4e0TV5w1i1+ZVtfOSnHu/Y25TVbNzI1Zx4Y0bF3t2WzRxEdHx
         fNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ruqu7XRyeoHO5d3dL3cpXjWaNCM/mJSqSGYC+47F2jM=;
        b=kkAb3DzuVo/rN/BhqkWH+Oayn8fmrQv18rBXy9lSRl/frmZ9I08xu/YiEAECLsIzTN
         FkDfot9it1WTgUkIruMrmZByYJsqr8nRWoM5iGa9f52GaxOP4CFfDxDK6W3GdSAPDHAk
         VC6d25ASfK3UzoRzx7yAzwWgtREwg4C2J8XqQ1Bdy0g0X1Kg5MikLZW2xFV/kS2Er0Vh
         EOS28ickS3QX06t26hId7Vi99b3BnNbPr3PT9EwIr9KB1HatKKqn1ERfz/9VUw6uRW3R
         7GbxB5coM7xo58LNd9qJetRJDG7lrAIUkjoJzpSN6Uffl0aU8HgYU4XjvFk9JXnqJYe0
         WBBA==
X-Gm-Message-State: AOAM532JIsI+XKzRiQqZASVK9ZxkBFiXb3oforXUUJ+B7YcBHePRdbM2
        BLqzJxBvAKqDIg7HVumNjpFRXQ==
X-Google-Smtp-Source: ABdhPJxlr8ST+l2zqQmOHJ0yxqdkfMipSP8p24NTpOJ3+QodP4SrF5kCmLao8p6wsWQn0kOydjR5og==
X-Received: by 2002:a17:90b:ec5:: with SMTP id gz5mr5361661pjb.77.1627363457626;
        Mon, 26 Jul 2021 22:24:17 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c23sm1929324pfo.174.2021.07.26.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:24:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org
Subject: [PATCH V4 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Date:   Tue, 27 Jul 2021 10:53:50 +0530
Message-Id: <acf7402ef4aabc0ad6295c32846f2bef1cd9b56a.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding for virtio GPIO controller, it is based on
virtio-device bindings.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-virtio.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
new file mode 100644
index 000000000000..601d85754577
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -0,0 +1,59 @@
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
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+description:
+  Virtio GPIO controller, see /schemas/virtio/virtio-device.yaml for more
+  details.
+
+properties:
+  $nodename:
+    const: gpio
+
+  compatible:
+    const: virtio,device29
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
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        gpio {
+            compatible = "virtio,device29";
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
+
+...
-- 
2.31.1.272.g89b43f80a514

