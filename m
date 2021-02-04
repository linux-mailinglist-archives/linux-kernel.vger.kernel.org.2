Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0130FEA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBDUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBDUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:41:43 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59828C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:41:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5148342842;
        Thu,  4 Feb 2021 20:40:26 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Hector Martin <marcan@marcan.st>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 06/18] dt-bindings: serial: samsung: Add AAPL,s5l-uart compatible
Date:   Fri,  5 Feb 2021 05:39:39 +0900
Message-Id: <20210204203951.52105-7-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204203951.52105-1-marcan@marcan.st>
References: <20210204203951.52105-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple mobile devices originally used Samsung SoCs (starting with the
S5L8900), and their current in-house SoCs continue to use compatible
UART peripherals. We'll call this UART variant AAPL,s5l-uart.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 21ee627b2ced..40409b31f4dc 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/serial/samsung_uart.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Samsung S3C, S5P and Exynos SoC UART Controller
+title: Samsung S3C, S5P, Exynos, and S5L (Apple SoC) SoC UART Controller
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -19,6 +19,7 @@ properties:
   compatible:
     items:
       - enum:
+          - AAPL,s5l-uart
           - samsung,s3c2410-uart
           - samsung,s3c2412-uart
           - samsung,s3c2440-uart
@@ -96,6 +97,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - AAPL,s5l-uart
               - samsung,exynos4210-uart
     then:
       properties:
-- 
2.30.0

