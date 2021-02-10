Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2B316CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhBJRc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:32:57 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:34908 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhBJRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:30:33 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Patrice Chotard <patrice.chotard@st.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 07/10] arm: dts: stih407-family: Harmonize DWC USB3 DT nodes name
Date:   Wed, 10 Feb 2021 20:28:47 +0300
Message-ID: <20210210172850.20849-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20210210172850.20849-1-Sergey.Semin@baikalelectronics.ru>
References: <20210210172850.20849-1-Sergey.Semin@baikalelectronics.ru>
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
named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 23a1746f3baa..2352f76b5a69 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -681,7 +681,7 @@ st_dwc3: dwc3@8f94000 {
 
 			status = "disabled";
 
-			dwc3: dwc3@9900000 {
+			dwc3: usb@9900000 {
 				compatible	= "snps,dwc3";
 				reg		= <0x09900000 0x100000>;
 				interrupts	= <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.30.0

