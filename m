Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891A30C8B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhBBR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:58:18 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36811 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbhBBRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:55:23 -0500
Received: by mail-oi1-f169.google.com with SMTP id d18so23712767oic.3;
        Tue, 02 Feb 2021 09:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTCXVmitXXn3fQmPZHNdgxN+Fe/Yj7/HlyhpJQ2WZf4=;
        b=FWHD49kWXuQwdGObI2Fc1QUo6TxM5R4aEyTUMpNnC2wIQe2y1zBOmVfxXUpBM1lxqk
         y2BFGFgiMAsoQ6dC5PhO98pM2GhBqFfqAeOBQ4TrXVfEjI9aygh3NMTDl7t4sDzaoQq6
         O7pfFKRUdVmZcKbZC7ed3gCLT4+vJAizbb1+uY+zKJ+bDl38gLv39pbIKjwdKdnaMypi
         AvltH77hFz1KFdyh9N+XLDy8sineqsFP66FtWpvB8VNafWQvSATwzgsoOWmEHVzokEo5
         3OGkM15BC0rsw8wZFkoAZjxmKIIJwdC7k4MpSL+LGUPcrcsHVvqKJS5mhtTUBo5gaHFH
         iFKg==
X-Gm-Message-State: AOAM532mcBcediqvXx5npj/LbWsLLUyVPhZkpWuIWf3vVE5yUayuYBE3
        ASACfZ11fMIHATZofd6tvIg0/jQNMw==
X-Google-Smtp-Source: ABdhPJwFc8pZEisPntEJbdAIBt64U/p0hsPlXbKd+sDd+pH6sxG9akObhxAMWdg0hBPjE8jQ8PD0rQ==
X-Received: by 2002:aca:c30a:: with SMTP id t10mr3670240oif.178.1612288481607;
        Tue, 02 Feb 2021 09:54:41 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id l7sm6552otr.81.2021.02.02.09.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:54:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: generic-ehci: Add missing compatible strings
Date:   Tue,  2 Feb 2021 11:54:38 -0600
Message-Id: <20210202175439.3904060-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic EHCI binding needs to document all the specific compatible
strings so we can track undocumented compatible strings. Add all the
compatible strings from in tree users.

Turns out we also have the generic 'usb-ehci' compatible which is pretty
much the same binding and the correct one for the example, so let's add it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/generic-ehci.yaml | 51 +++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 247ef00381ea..6816de7dfc00 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -24,8 +24,53 @@ allOf:
 
 properties:
   compatible:
-    contains:
-      const: generic-ehci
+    oneOf:
+      - items:
+          - enum:
+              - allwinner,sun4i-a10-ehci
+              - allwinner,sun50i-a64-ehci
+              - allwinner,sun50i-h6-ehci
+              - allwinner,sun5i-a13-ehci
+              - allwinner,sun6i-a31-ehci
+              - allwinner,sun7i-a20-ehci
+              - allwinner,sun8i-a23-ehci
+              - allwinner,sun8i-h3-ehci
+              - allwinner,sun8i-r40-ehci
+              - allwinner,sun9i-a80-ehci
+              - aspeed,ast2400-ehci
+              - aspeed,ast2500-ehci
+              - aspeed,ast2600-ehci
+              - brcm,bcm3384-ehci
+              - brcm,bcm63268-ehci
+              - brcm,bcm6328-ehci
+              - brcm,bcm6358-ehci
+              - brcm,bcm6362-ehci
+              - brcm,bcm6368-ehci
+              - brcm,bcm7125-ehci
+              - brcm,bcm7346-ehci
+              - brcm,bcm7358-ehci
+              - brcm,bcm7360-ehci
+              - brcm,bcm7362-ehci
+              - brcm,bcm7420-ehci
+              - brcm,bcm7425-ehci
+              - brcm,bcm7435-ehci
+              - ibm,476gtr-ehci
+              - nxp,lpc1850-ehci
+              - qca,ar7100-ehci
+              - snps,hsdk-v1.0-ehci
+              - socionext,uniphier-ehci
+          - const: generic-ehci
+      - items:
+          - enum:
+              - cavium,octeon-6335-ehci
+              - ibm,usb-ehci-440epx
+              - ibm,usb-ehci-460ex
+              - nintendo,hollywood-usb-ehci
+              - st,spear600-ehci
+          - const: usb-ehci
+      - enum:
+          - generic-ehci
+          - usb-ehci
 
   reg:
     minItems: 1
@@ -101,7 +146,7 @@ additionalProperties: false
 examples:
   - |
     usb@e0000300 {
-        compatible = "ibm,usb-ehci-440epx", "generic-ehci";
+        compatible = "ibm,usb-ehci-440epx", "usb-ehci";
         interrupt-parent = <&UIC0>;
         interrupts = <0x1a 4>;
         reg = <0xe0000300 90>, <0xe0000390 70>;
-- 
2.27.0

