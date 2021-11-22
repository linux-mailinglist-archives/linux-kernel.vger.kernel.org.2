Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81A45980C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhKVXBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:01:20 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:60260 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhKVXBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:01:16 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id B43F5261B43;
        Mon, 22 Nov 2021 23:58:08 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
Date:   Mon, 22 Nov 2021 23:58:04 +0100
Message-Id: <20211122225807.8105-2-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122225807.8105-1-j@jannau.net>
References: <20211122225807.8105-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces compatible strings for both 2021 Apple iMac M1 devices:

* apple,j456 - iMac (24-inch, 4x USB-C, M1, 2021)
* apple,j457 - iMac (24-inch, 2x USB-C, M1, 2021)

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index 1e772c85206c..b23c8dc5a27d 100644
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
+  - iMac (24-inch, M1, 2021)
 
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
2.34.0

