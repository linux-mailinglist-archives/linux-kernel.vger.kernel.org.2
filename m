Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF430FEB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBDUok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:44:40 -0500
Received: from marcansoft.com ([212.63.210.85]:33350 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhBDUmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:42:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6805A42867;
        Thu,  4 Feb 2021 20:41:02 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 17/18] dt-bindings: display: add AAPL,simple-framebuffer
Date:   Fri,  5 Feb 2021 05:39:50 +0900
Message-Id: <20210204203951.52105-18-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
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
index eaf8c54fcf50..941c10f40ae5 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -54,6 +54,7 @@ properties:
   compatible:
     items:
       - enum:
+          - AAPL,simple-framebuffer
           - allwinner,simple-framebuffer
           - amlogic,simple-framebuffer
       - const: simple-framebuffer
@@ -84,9 +85,13 @@ properties:
       Format of the framebuffer:
         * `a8b8g8r8` - 32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r
         * `r5g6b5` - 16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b
+        * `x8r8g8b8` - 32-bit pixels, d[23:16]=r, d[15:8]=g, d[7:0]=b
+        * `x2r10g10b10` - 32-bit pixels, d[29:20]=r, d[19:10]=g, d[9:0]=b
     enum:
       - a8b8g8r8
       - r5g6b5
+      - x8r8g8b8
+      - x2r10g10b10
 
   display:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.30.0

