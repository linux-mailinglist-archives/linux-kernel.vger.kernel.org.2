Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907643FE78B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhIBCVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:21:17 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:2736 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhIBCVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:21:16 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1821xAlN068910;
        Thu, 2 Sep 2021 09:59:10 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Sep
 2021 10:18:15 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <lee.jones@linaro.org>, <osk@google.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Add UART routing compatible string
Date:   Thu, 2 Sep 2021 10:18:14 +0800
Message-ID: <20210902021817.17506-2-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1821xAlN068910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string and the device tree description for the
Aspeed AST25xx/AST26xx UART routing control.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../devicetree/bindings/mfd/aspeed-lpc.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 936aa108eab4..45d44f812e5e 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -155,3 +155,25 @@ lpc_reset: reset-controller@98 {
         reg = <0x98 0x4>;
         #reset-cells = <1>;
 };
+
+UART routing control
+--------------------
+
+The UART routing control manages the RX muxes among the UART controllers
+and the I/O pins. This is typicall used for the Serial-Over-Lan (SOL)
+service.
+
+Required properties:
+
+ - compatible:		One of:
+			"aspeed,ast2500-uart-routing";
+			"aspeed,ast2600-uart-routing";
+
+ - reg:			offset and length of the IP in the LPC memory region
+
+Example:
+
+uart_routing: uart-routing@98 {
+	compatible = "aspeed,ast2600-uart-routing";
+	reg = <0x98 0x8>;
+};
-- 
2.17.1

