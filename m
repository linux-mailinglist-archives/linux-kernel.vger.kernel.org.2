Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9499438802
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJXJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhJXJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:46:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC6C061767
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:43:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id i5so5856674pla.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lqm98wEFYJSr54W/wNfWgM+OWyfT9zNKGkY/snl5uHg=;
        b=TlcuVmmnJYhlSjtz2sWfeqC0pHcK97U/MkU/2q94d5vDNKKj1yTUUtlnmUgmgYIhES
         1wjP2NpZ7tNvFk4I5qDTnoZQWtdaqnTJbSE8pxjHeH3XlMzVjV3vxg0bS+eKhKzYJboO
         Xc6zTZ7dlziDgWJsW7DgRtlWdAlTsoPV7tab+x4wTmNZ08xv7iV5/ThSGlQhw8nALCF8
         zvWr/VcvmOqP8ce8xQh7db8HQvPdMRPCPEOfj69Xw0DVRoMY+srKe/7NVPwn3a6+l8l2
         CePm/HjaMxSGxeao2ASsNVNucP1cuJzEcAMWOXiBXe5OoBYBl3wAZsQweV+vj7NfCJ3w
         8uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lqm98wEFYJSr54W/wNfWgM+OWyfT9zNKGkY/snl5uHg=;
        b=1ipLY42s69CJ6ix+0LUzuoYnOYreZ6lUVHHY0mZEnJQJlXAKmdDKLOVzQfR1NslNca
         OaYEls95ADH6RKRAe7JoNnvq4V+OFyNWgn2a8RksMDVaJaFtRqQDBSqbuHuWgpJkpyww
         wmbdSFZ74kIoAkAjSRyb2SDdipsJfTEGtPf3HNv53UjPzVUVFh4BItWOgWK8VewtOUhj
         DEk0sOZPfwGnIWkx89drJldmlbArpJYGkaGKdqX82OFP3ZSg40abu1iFEHooytKQ7Qt1
         mHG4P39tHpSskxpouBVuCW4OYR2XKUNRgsYAeiIYMtYycNWsoINzWGZwvZnNxkZtSohx
         ZNsA==
X-Gm-Message-State: AOAM5317CqC5tPyo0l6VCn8SCeWjTTghrs2i0oa7oCRJ3IdcujlRxXNZ
        aYkdhbXn43lS43b8uUOwbqxtgLiuFcVijx73
X-Google-Smtp-Source: ABdhPJyiey9Yydyrsr3LNLq9tQqCFFJuBfLGyiF5iUoGYbMc5sKz2Cefd+gB7j5JKsIwhdqePVtEnw==
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr10106348pjd.227.1635068620020;
        Sun, 24 Oct 2021 02:43:40 -0700 (PDT)
Received: from lxb-server.lan ([2403:18c0:2:7e::1926:817])
        by smtp.gmail.com with ESMTPSA id p16sm17636619pfh.97.2021.10.24.02.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 02:43:39 -0700 (PDT)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
X-Google-Original-From: Yunhao Tian <t123yh@outlook.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yunhao Tian <t123yh.xyz@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ASoC: dt-bindings: rockchip: add spdifrx bindings
Date:   Sun, 24 Oct 2021 17:43:16 +0800
Message-Id: <20211024094317.1641949-3-t123yh@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024094317.1641949-1-t123yh@outlook.com>
References: <20211024094317.1641949-1-t123yh@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunhao Tian <t123yh.xyz@gmail.com>

This adds the YAML bindings for the Rockchip S/PDIF receiver driver.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 .../bindings/sound/rockchip-spdifrx.yaml      | 80 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml
new file mode 100644
index 000000000000..fcbbc3e8786a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/rockchip-spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SPDIF Receiver
+
+description:
+  The SPDIF receiver block allows the processor to
+  receive digital audio via a coaxial cable or a fibre cable.
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3308-spdifrx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for SPDIF bus
+      - description: clock for SPDIF controller
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: hclk
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: spdifrx-m
+
+  power-domains:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3308-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spdif_rx: spdif-rx@ff3b0000 {
+      #sound-dai-cells = <0>;
+      compatible = "rockchip,rk3308-spdifrx";
+      reg = <0x0 0xff3b0000 0x0 0x1000>;
+      interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_SPDIF_RX>, <&cru HCLK_SPDIFRX>;
+      clock-names = "mclk", "hclk";
+      dmas = <&dmac1 14>;
+      dma-names = "rx";
+      resets = <&cru SRST_SPDIFRX_M>;
+      reset-names = "spdifrx-m";
+      status = "disabled";
+    };
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index a2bee2166a39..82e0fa37c5b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15985,6 +15985,7 @@ M:	Yunhao Tian <t123yh.xyz@gmail.com>
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml
 F:	sound/soc/rockchip/rockchip_spdifrx.*
 
 ROCKCHIP VIDEO DECODER DRIVER
 M:	Ezequiel Garcia <ezequiel@collabora.com>
-- 
2.25.1

