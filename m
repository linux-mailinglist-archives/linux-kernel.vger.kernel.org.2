Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F367E359D73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhDILbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:31:10 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49582 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhDILay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:30:54 -0400
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-usb@vger.kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v8 5/7] arm64: dts: apm: Harmonize DWC USB3 DT nodes name
Date:   Fri, 9 Apr 2021 14:30:26 +0300
Message-ID: <20210409113029.7144-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20210409113029.7144-1-Sergey.Semin@baikalelectronics.ru>
References: <20210409113029.7144-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the DWC USB3 bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
named despite of the warning comment about possible backward
compatibility issues.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 4 ++--
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index a83c82c50e29..832dd85b00bd 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -597,8 +597,8 @@ serial0: serial@10600000 {
 			interrupts = <0x0 0x4c 0x4>;
 		};
 
-		/* Do not change dwusb name, coded for backward compatibility */
-		usb0: dwusb@19000000 {
+		/* Node-name might need to be coded as dwusb for backward compatibility */
+		usb0: usb@19000000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg =  <0x0 0x19000000 0x0 0x100000>;
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 0f37e77f5459..1520a945b7f9 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -923,8 +923,8 @@ sata3: sata@1a800000 {
 			phy-names = "sata-phy";
 		};
 
-		/* Do not change dwusb name, coded for backward compatibility */
-		usb0: dwusb@19000000 {
+		/* Node-name might need to be coded as dwusb for backward compatibility */
+		usb0: usb@19000000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg =  <0x0 0x19000000 0x0 0x100000>;
@@ -933,7 +933,7 @@ usb0: dwusb@19000000 {
 			dr_mode = "host";
 		};
 
-		usb1: dwusb@19800000 {
+		usb1: usb@19800000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg =  <0x0 0x19800000 0x0 0x100000>;
-- 
2.30.1

