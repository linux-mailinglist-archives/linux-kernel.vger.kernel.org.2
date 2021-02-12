Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E344531A2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBLQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBLQjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:39:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3AFF64E7A;
        Fri, 12 Feb 2021 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613147951;
        bh=VCFu+ICSFQ6+KyDhepe9q2UWT8xP1wZdC0Z3C2QnV2o=;
        h=From:To:Subject:Date:From;
        b=XcrLLDbr7E8vW3u2MEuqUdTqUpMmloObWhedy2LtKZkn3y63fSI5W5oFbvn1ircA7
         8j2Z3nMcbjL6tyA9hiamE+mY4OWkrTdRk+c1/WharmO+xFjx9ilM+lhc/i/+WKqrlg
         q1MnuKDeTYbmq5V2070AUxzHF3ikpDAewM/KvpRukUrUVpu0HO0zGuEPCng0VF0BGu
         xquDbMOXipNJ60JVco6XPdMCWnnMhJHpPm2tgjd43DV2Y7lK7SElIAeG8/1Vk+74iO
         004bAMb2UqSR0r227mYL/Hu83OH6kV3bkYEjehui4xOGlbYAhMgVuGpel/dSv+kVnB
         am5vQr4q9EUgQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: serial: samsung: add DMA properties
Date:   Fri, 12 Feb 2021 17:39:04 +0100
Message-Id: <20210212163905.70171-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung SoC UART nodes have usually DMA so dtschema has to reflect
this to fix dtbs_check warnings like:

  arch/arm/boot/dts/exynos4210-smdkv310.dt.yaml: serial@13800000:
    'dma-names', 'dmas' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/serial/samsung_uart.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 21ee627b2ced..3e29b561223d 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -51,6 +51,16 @@ properties:
       - pattern: '^clk_uart_baud[0-3]$'
       - pattern: '^clk_uart_baud[0-3]$'
 
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
   interrupts:
     description: RX interrupt and optionally TX interrupt.
     minItems: 1
-- 
2.25.1

