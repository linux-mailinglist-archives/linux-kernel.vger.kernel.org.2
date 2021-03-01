Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86DC32760D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 03:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhCACRu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 28 Feb 2021 21:17:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2853 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhCACRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 21:17:46 -0500
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DpkNH0z2rz140Vj;
        Mon,  1 Mar 2021 10:14:23 +0800 (CST)
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.252]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0509.000;
 Mon, 1 Mar 2021 10:16:55 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: [Reoprt] Some compile warning on ppc dts
Thread-Topic: [Reoprt] Some compile warning on ppc dts
Thread-Index: AdcOQPNGmFy3U3BrTyOQctVQlk5NMQ==
Date:   Mon, 1 Mar 2021 02:16:55 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B50220CCBBE4@dggeml509-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

After run the following commands
make distclean
make allmodconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
make oldconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
make -j64 ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-

I get some warning:
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-280.4: Warning (pci_bridge): 
/pci@f0000d00: missing ranges for PCI bridg
e (or not a bridge)
arch/powerpc/boot/dts/o2dnt2.dtb: Warning (pci_device_bus_num): Failed 
prerequisite 'pci_bridge'
arch/powerpc/boot/dts/mpc5200b.dtsi:182.18-186.5: Warning 
(spi_bus_bridge): /soc5200@f0000000/psc@2000: node name f
or SPI buses should be 'spi'
   also defined at arch/powerpc/boot/dts/o2d.dtsi:32.12-43.5
arch/powerpc/boot/dts/o2dnt2.dtb: Warning (spi_bus_reg): Failed 
prerequisite 'spi_bus_bridge'
..

For the problem about "node name for SPI buses should be 'spi'":
Rename the psc@2000 to spi@2000 in arch/powerpc/boot/dts/o2d.dtsi can 
fix it.
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
index 6661955a2be4..cd3dc70cd72e 100644
--- a/arch/powerpc/boot/dts/o2d.dtsi
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -29,7 +29,7 @@ rtc@800 {
  >------>------->-------status = "disabled";
  >------>-------};
-
->------>-------psc@2000 {>----->-------// PSC1
+>------>-------spi@2000 {>----->-------// PSC1
  >------>------->-------compatible = 
"fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi";
  >------>------->-------#address-cells = <1>;
  >------>------->-------#size-cells = <0>;
---

For the problem about "missing ranges for PCI bridge (or not a bridge)":
Ranges should be add in arch/powerpc/boot/dts/mpc5200b.dtsi.
 >-------pci: pci@f0000d00 {
 >------->-------#interrupt-cells = <1>;
 >------->-------#size-cells = <2>;
 >------->-------#address-cells = <3>;
 >------->-------device_type = "pci";
 >------->-------compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
 >------->-------reg = <0xf0000d00 0x100>;
 >------->-------// interrupt-map-mask = need to add
 >------->-------// interrupt-map = need to add
 >------->-------clock-frequency = <0>; // From boot loader
 >------->-------interrupts = <2 8 0 2 9 0 2 10 0>;
 >------->-------bus-range = <0 0>;
 >------->-------// ranges = need to add
 >-------};
I think the ranges should be add by someone who knows the mpc5200 better.

Can anyone fix this?

-- 
Regards
Chen Jun
