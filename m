Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120CA3D52AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhGZELn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 00:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGZELk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 00:11:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D65C061765
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:52:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n10so2480385plc.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=muwPPr/wH77yClDsFJrEFYw3n7hGXGW3QcFllPO0brU=;
        b=ycpwrBVDwGd3Ld3v1W5tGdLHkVB1bJPYN1wrP6W6KB0X3EJPQBADk6S/2yCJy6YoIb
         CMjXIMA7JeZJrWSHKQIeMbTDlKhkex5g3KPI99HW0FUzbflO2F8JG/DSxOvg3Vr9oMx5
         +3FJjFdZbbzEvubq3LP0cjPPk43QYpjvukKxiqn3TQZoyQF72iOSJYLR/+gT7+tNMxES
         EzOMkKRg48/0AcFriy2csYJHtgUtDVH+ZMJ5R5K4mDm5kuuPJ/b8B639fKzbd10hCmTD
         zwOyEwPH0mmxUadbtLGlt0JD1DI9QBKl8jEfeGZPXdE3CgVRdrJIRizl1hhyN4xs9QdV
         nwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muwPPr/wH77yClDsFJrEFYw3n7hGXGW3QcFllPO0brU=;
        b=q4/UciDNNXBiboU+kPeM+eSIx3X3wk4k24XOPce0uiMbxBu48UR6HZQzKdiWSGIypq
         /Z4e2JaDLWNFB69j44jL6CUCLufee1kWeJ7Pz7sRqEifMsG/dml2WNEYOOg1iJrWOHlg
         QT/9gaNV+RhD3zNRCKQM1bLF73FlC8ToVoSnBZ6T7WvKHoSeHGo7vGniIt1Jl5sftKSW
         GcHSXwFhWKjxD9HpGRtEpRMFjRqIfyqIdr9THVETgoCjIMno5Ik8Bk1AGyMlFhxz3PH4
         vzKJU4KkppIR01p1Mp3E51XdeqL5Bo7R4NMRjOvdO5VN7JLZlTlds/Ssz6jp/c7S0zp2
         8p6g==
X-Gm-Message-State: AOAM532KInctlRZdpMEZvSG5ZM+PGK54wmI9HueYtRrWIoREj9Z6mZGw
        n/7ANYsdrasuTGnQg6+NvIaaqw==
X-Google-Smtp-Source: ABdhPJywYWAbpqqkEOa/qttwkvPQCjhdQ454v7qZzG2V+o1+YfpG93FpHj+tl77I79vdxChXD9nrXA==
X-Received: by 2002:a17:902:9046:b029:12c:e88:429c with SMTP id w6-20020a1709029046b029012c0e88429cmr5300973plz.77.1627275128984;
        Sun, 25 Jul 2021 21:52:08 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z5sm16448583pgz.77.2021.07.25.21.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:52:08 -0700 (PDT)
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
        linux-gpio@vger.kernel.org
Subject: [PATCH V3 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Date:   Mon, 26 Jul 2021 10:21:43 +0530
Message-Id: <605b87ce93b9a528810a5857984bfe6b913d5e73.1627273794.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627273794.git.viresh.kumar@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding for virtio GPIO controller, it is based on
virtio-device bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-virtio.yaml | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
new file mode 100644
index 000000000000..96108cfb7a08
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -0,0 +1,60 @@
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
+description:
+  Virtio GPIO controller, see /schemas/virtio/virtio-device.yaml for more
+  details.
+
+properties:
+  $nodename:
+    pattern: '^gpio-virtio(-[a-z0-9]+)?$'
+
+  compatible:
+    const: virtio,29
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
+        gpio: gpio-virtio {
+            compatible = "virtio,29";
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

