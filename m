Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6923F8610
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbhHZLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbhHZLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:04:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B64C06179A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:03:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so1571532plx.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxvll67J3XpmADTGvnJ8QFA4/5rp+GwPgMrOnVdNvPo=;
        b=RMNgAF0BCNlgdvkP+UgS9c463NC4wc1kfJjxPt5iICLa828IZGrrnBm4tz0DebmFJ2
         LWHRuoGSUzZ7jbarQDkSl8/85XFL8yCXh/ClO3BcCtknFl23Y0lKczt4oSa+6vhs29a+
         cocWcZo8pZo1W44JIFfI8Av4lisIFU8emUqjiwTS7Y6RXJP7NEyFB7XGgGJDOJQ+SjJM
         ve/gHAI30gxnSSBJbe3QGa1NGW9/uR4/KPu5HvQl4FkuJA1u65ef8BlnOmioXJGQQqwP
         EkdrId7q0WiX0neBXfWTjvV5oDeJvzxEOq5/S+2ePCXHLdj88Qynmzh9jnd7OfWwlmgK
         RuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxvll67J3XpmADTGvnJ8QFA4/5rp+GwPgMrOnVdNvPo=;
        b=O3L8Bi6v4H7eii9BcBbu3JUFqlOUAQoB9wuHIO6xC6v/58l529oE+G2TsmZhThxRzl
         YXqWhK3OMwt3jOBhteYfNFSTLn7JgEHEMlTgVRqhyKF9bygVcHigng7DIhi6OIBSHpnj
         v14U31tVL2S/X4bpt95tybQRQ6P0r+8QZyv9IzQFbYoI+9/EUH94qggIi60RWABpF97Y
         zl6q1YgrNeQdrdFRqbfbqmKd04mVsm5ydAjW5kiRHn3/pGtIdrJTTHJPs5TBPvUeZwPz
         Lj7lt2hNWccLk5x8h4YQdXmrashDo4HUg1MH/R5tDjiDhaZBT+3prtYON/VWadYpTjdC
         pjCA==
X-Gm-Message-State: AOAM530gBj3AVQGpQ+3hXPCmTuihPDuV87fuw2n1Ll23LStuMZ9MhAID
        jDXLXFCopb6mQDa5nEtjq5+/Jw==
X-Google-Smtp-Source: ABdhPJw3V4LfqiuEcKFM38WlYz5CA23xYtM52p/p0VCQ2WFgXNQLy9SERQL6JEd62Y0IHjos5zfVcw==
X-Received: by 2002:a17:902:dcc9:b0:134:92c7:3cb6 with SMTP id t9-20020a170902dcc900b0013492c73cb6mr3207476pll.79.1629975808680;
        Thu, 26 Aug 2021 04:03:28 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id z12sm2655335pfe.79.2021.08.26.04.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 04:03:28 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v3 2/2] dt-bindngs: display: panel: Add BOE tv110c9m-ll3 panel bindings
Date:   Thu, 26 Aug 2021 19:03:11 +0800
Message-Id: <20210826110311.613396-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826110311.613396-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210826110311.613396-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for boe tv110c9m-ll3 panel.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 .../display/panel/boe,tv110c9m-ll3.yaml       | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
new file mode 100644
index 000000000000..0cf8b70c77f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
@@ -0,0 +1,81 @@
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

