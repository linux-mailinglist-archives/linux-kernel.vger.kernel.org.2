Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7263AE338
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFUGcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFUGb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:31:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3AC06175F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:29:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k6so12811006pfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MngqRxxEHl2ppcxz+/r0UlSDgAGtoX4UkbK2llRyjcc=;
        b=oSxSHYT+eynqd9qy7H1VRE5S8rO7PDdIGyCkbpZ7qZu0nWRHBcVr+NE3o3eQT5F3cL
         MpS2CjKCO7Dd7PSDsxpnZPTbeBQAc/qAlZM5hSnkVVp26Sr8XFXTvpGNWjjCYRmoxFkQ
         qndU79LzzhFyDmyHklDcRxAdadOTvcbCs4F3UlnpguJB9x4dzPBQO1yUNGEmCk4B9ed2
         7IXJ5VyfBJhKu2cNXkhnUhn91Cs1kkQmkqpn6zV082No9EoXSaWTMLo9nXlGh7rctoqu
         vAE/qLk9m5jQ1u2KbR2zmQRlU7me3tPr65wDVQiVxpv2GQT20zIrQ0FhhpR5LkIC/Ecq
         mzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MngqRxxEHl2ppcxz+/r0UlSDgAGtoX4UkbK2llRyjcc=;
        b=SbMMldGKa+LsdrfmuQjtUHRwh3B+YOhUKB/GAArIE7jxpGgsL69GB9gVKL37w01gqC
         hNwK6QFfU9B0Nu66eMWsnceB6eON1MCFwcrn472ioD30teOUeleZYn3tT6/dhlm/fT4H
         voGUgrcHUzu2uQmyrxSZBM0RZha6vSOYjh6/++yo65kSTptTWU3JMZFSaD7zhHb1ia7s
         e1yicuhkYEopzkPNEoJVVawIaOLLhsSJ9gZOqqUX8m8o5y4PWKznCc6lf/Kn7vP1zb09
         NDAhUuZlNNvusNW4AWrn+ux+IEUW9+tgESbJ2sO0oaQ46xXJ9kVcl4pNar4A8pxdRb3q
         Sz9Q==
X-Gm-Message-State: AOAM531kuUrcx6ouqxxbFWOWT3CQ8B2mOJroG5veP+VN/vb3ldvTVMk2
        v7SuDje73E3Vup2xZV52i0HbSg==
X-Google-Smtp-Source: ABdhPJwHuFs9pzSz4JS1faFxRvnZ6FD31/YEEBp/+vMDIFATaE0H/VU3lriAI4/3wgnQkW2aXdyh8Q==
X-Received: by 2002:a62:7885:0:b029:300:9a33:1720 with SMTP id t127-20020a6278850000b02903009a331720mr14193118pfc.68.1624256983750;
        Sun, 20 Jun 2021 23:29:43 -0700 (PDT)
Received: from localhost.localdomain ([240b:10:c9a0:ca00:61b8:26ec:dc30:8823])
        by smtp.gmail.com with ESMTPSA id j19sm15266018pgm.44.2021.06.20.23.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 23:29:43 -0700 (PDT)
From:   Tomohito Esaki <etom@igel.co.jp>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devlel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomohito Esaki <etom@igel.co.jp>
Subject: [PATH 3/4] dt-bindings: display: Add virtual DRM
Date:   Mon, 21 Jun 2021 15:27:41 +0900
Message-Id: <20210621062742.26073-4-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621062742.26073-1-etom@igel.co.jp>
References: <20210621062742.26073-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings documentation for virtual DRM.

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
---
 .../devicetree/bindings/display/vdrm.yaml     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/vdrm.yaml

diff --git a/Documentation/devicetree/bindings/display/vdrm.yaml b/Documentation/devicetree/bindings/display/vdrm.yaml
new file mode 100644
index 000000000000..6493bb0fc09f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/vdrm.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/vdrm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual DRM Device Tree Bindings
+
+description:
+  This document defines device tree properties virtual DRM. The initial
+  position, size and z-position of the plane used in the virtual DRM is
+  specified.
+  The current limitation is that these settings are applied to all crtc.
+
+properties:
+  compatible:
+    const: virt-drm
+
+patternProperties:
+  "^plane(@.*)?$":
+    description: Information of the planes used in virtual DRM
+    type: object
+
+    properties:
+      x:
+        type: int
+        description: x-coordinate of the left-top of the plane in pixels
+
+      y:
+        type: int
+        description: y-coordinate of the left-top of the plane in pixels
+
+      width:
+        type: int
+        description: width of the plane in pixels
+
+      height:
+        type: int
+	description: height of the plane in pixels
+
+      zpos:
+        type: int
+        description: z-position of the plane
+
+    required:
+      - x
+      - y
+      - width
+      - height
+      - zpos
+
+required:
+  - compatible
+  - "^plane(@.*)?$"
+
+examples:
+ - |
+   vdrm@0 {
+       compatible = "virt-drm";
+       plane@0 {
+           x = <200>;
+	   y = <100>;
+	   width = <800>;
+	   height = <600>;
+	   zpos = <1>;
+       };
+   };
-- 
2.25.1

