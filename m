Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDC453BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhKPV4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:56:17 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:48824 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhKPV4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:56:15 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id BF8EB261AE5;
        Tue, 16 Nov 2021 22:53:16 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
Date:   Tue, 16 Nov 2021 22:53:14 +0100
Message-Id: <20211116215315.22528-2-j@jannau.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211116215315.22528-1-j@jannau.net>
References: <20211116215315.22528-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces compatible strings for both 2021 Apple iMac M1 devices:

* apple,j456 - iMac (24-inch, 4x USB-C, M1, 2021)
* apple,j457 - iMac (24-inch, 2x USB-C, M1, 2021)

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 1e772c85206c..1416ed3a5623 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -12,12 +12,12 @@ maintainers:
 description: |
   ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".
 
-  This currently includes devices based on the "M1" SoC, starting with the
-  three Mac models released in late 2020:
+  This currently includes devices based on the "M1" SoC:
 
   - Mac mini (M1, 2020)
   - MacBook Pro (13-inch, M1, 2020)
   - MacBook Air (M1, 2020)
+  - iMac (24-inch 2021)
 
   The compatible property should follow this format:
 
@@ -56,6 +56,8 @@ properties:
               - apple,j274 # Mac mini (M1, 2020)
               - apple,j293 # MacBook Pro (13-inch, M1, 2020)
               - apple,j313 # MacBook Air (M1, 2020)
+              - apple,j456 # iMac (24-inch, 4x USB-C, M1, 2021)
+              - apple,j457 # iMac (24-inch, 2x USB-C, M1, 2021)
           - const: apple,t8103
           - const: apple,arm-platform
 
-- 
2.33.1

