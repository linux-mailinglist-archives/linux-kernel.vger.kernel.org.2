Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91A73F4A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhHWLw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbhHWLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:52:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD8C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:51:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j2so5576476pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkJF9gL3DFUvt3rlo/nzGGGMNzuUgKnkhv0UlxkwGu4=;
        b=Ofv1R2i1a5c2X/aAvS+lwWJysrrhDQlsLsZC27I36yxS+YLRscajlqrdz9/afYz9O7
         fCuKKu1MjWnuk+m0WLbOipx0H2lrn1J0tuiO6Et8yhm1qm5qy8mHtOCHEGYWTYAVbJNa
         Re/4jzeHogLm3ZL+cSFsldwFtWJUtlCWlbbkX7AAcR8XF+OjZ1FouwgnYIBIJwg6EjiI
         w7fI/CG6PMGbPsQBFdutM55vliglUH24BFbtKT6JEc6ky20gyLBzz2bGVycFF0vwUIY4
         PbqBH6NDmjn9N053v2w25XS7cP0AZZO9d8/nWYDyT8byaAwycXn9Jotx7hkBtdSh6wsx
         5M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkJF9gL3DFUvt3rlo/nzGGGMNzuUgKnkhv0UlxkwGu4=;
        b=c/yWUEES5hOzpuY+E4FH3yVsJsJZtsivcWoZ6Mvr4Ganq+u6bA1jZQcRgake0asWsw
         2M2T7KGTRpxrFEBoHoNei1qhiPdDEIdn8seXJjw0S++I9a0cfnwmCwtRwuCeSTwhHyFx
         Baat0Kj/xTtWt44AhK8pCAlYjY724EHDcODLND3IhI2LzG2hvA+wI5mJey8GTZqnW7IH
         9PUUrLElU/MUcP7ve8LvbyZa5tZH1UUWsJtrFNCjOCzVol3lczxLHb/3WZj5ypnwOR1R
         8bJbjITcJt7t+9x5mToviio9ap5hxWy8UdNL9rW4tLq6lINEMYOFzI5hJCu3a1wceqEi
         DJow==
X-Gm-Message-State: AOAM532tOHJbs4naOEHLOg9INyN1jBeCQnUGMGki3n9CTWuT53d45jnK
        qXZLciHvZh9JJIK+gz03DTFg9Q==
X-Google-Smtp-Source: ABdhPJwdocfiEf11B5CvUDIZH1FHjE4IEAZiQMZg6/TK1SySDNCgg1m7Jyl+2hK5CJTNJQNDnT2FqA==
X-Received: by 2002:a17:902:6b4a:b0:132:803c:3ec with SMTP id g10-20020a1709026b4a00b00132803c03ecmr9492652plt.81.1629719501275;
        Mon, 23 Aug 2021 04:51:41 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id z19sm15985426pfn.94.2021.08.23.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:51:41 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 2/2] dt-bindngs: display: panel: Add BOE tv110c9m-ll3 panel bindings
Date:   Mon, 23 Aug 2021 19:51:25 +0800
Message-Id: <20210823115125.1070257-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823115125.1070257-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210823115125.1070257-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for boe tv110c9m-ll3 panel.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 .../display/panel/boe,tv110c9m-ll3.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
new file mode 100644
index 000000000000..85969441d572
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,tv110c9m-ll3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOE TV110C9M-LL3 DSI Display Panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Sam Ravnborg <sam@ravnborg.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+        # BOE TV110C9M-LL3 10.95" WUXGA TFT LCD panel
+      - boe,tv110c9m-ll3
+        # INX HJ110IZ-01A 10.95" WUXGA TFT LCD panel
+      - inx,hj110iz-01a
+
+  reg:
+    description: the virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: a GPIO spec for the enable pin
+
+  pp1800-supply:
+    description: core voltage supply
+
+  pp3300-supply:
+    description: core voltage supply
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  backlight:
+    description: phandle of the backlight device attached to the panel
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - pp1800-supply
+  - pp3300-supply
+  - avdd-supply
+  - avee-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "boe,tv110c9m-ll3";
+            reg = <0>;
+            enable-gpios = <&tlmm 76 GPIO_ACTIVE_HIGH>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&vdd_reset_1800>;
+            avdd-supply = <&avdd_lcd>;
+            avee-supply = <&avee_lcd>;
+            pp1800-supply = <&v1p8_mipi>;
+            pp3300-supply = <&pp3300_dx_edp>;
+            backlight = <&backlight>;
+            status = "okay";
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1

