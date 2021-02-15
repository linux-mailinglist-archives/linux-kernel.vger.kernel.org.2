Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775531B92B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBOM0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBOMUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:20:19 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE76CC061786;
        Mon, 15 Feb 2021 04:19:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A5E794257F;
        Mon, 15 Feb 2021 12:19:33 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/25] dt-bindings: display: Add apple,simple-framebuffer
Date:   Mon, 15 Feb 2021 21:17:12 +0900
Message-Id: <20210215121713.57687-25-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs run firmware that sets up a simplefb-compatible framebuffer
for us. Add a compatible for it, and two missing supported formats.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index eaf8c54fcf50..c2499a7906f5 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -54,6 +54,7 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,simple-framebuffer
           - allwinner,simple-framebuffer
           - amlogic,simple-framebuffer
       - const: simple-framebuffer
@@ -84,9 +85,13 @@ properties:
       Format of the framebuffer:
         * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
         * `r5g6b5` - 16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b
+        * `x2r10g10b10` - 32-bit pixels, d[29:20]=r, d[19:10]=g, d[9:0]=b
+        * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
     enum:
       - a8b8g8r8
       - r5g6b5
+      - x2r10g10b10
+      - x8r8g8b8
 
   display:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.30.0

