Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDB3D5003
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGYULC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 16:11:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:5391 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGYULB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 16:11:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="297697905"
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="scan'208";a="297697905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 13:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; 
   d="scan'208";a="661625964"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2021 13:51:25 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7l5p-0004pg-09; Sun, 25 Jul 2021 20:51:25 +0000
Date:   Mon, 26 Jul 2021 04:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [robh:for-next 14/20] dtbs_check:
 arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: reg-names:1:
 'phy' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt',
 'ctrl', 'parf', 'cfg', 'link', 'ulreg', 'smu', 'mpu']
Message-ID: <202107260438.nNc5jlvF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
head:   3747c2b2f6ce8b5a195645259b06d5ffcb4e0a1d
commit: 17c1b16340f08607be8b0d4f1376e32ea6cca437 [14/20] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
compiler: arm-linux-gnueabi-gcc (GCC) 10.3.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/artpec6-devboard.dt.yaml:0:0: /clkctrl@f8000000: failed to match any schema with compatible: ['axis,artpec6-clkctrl']
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: ranges: 'oneOf' conditional failed, one must be fixed:
   	arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[2164260864, 0, 0, 3221233664, 0, 65536, 2181038080, 0, 3221299200, 3221299200, 0, 536797184]] is not of type 'boolean'
   		True was expected
   		[[2164260864, 0, 0, 3221233664, 0, 65536, 2181038080, 0, 3221299200, 3221299200, 0, 536797184]] is not of type 'null'
   	[2164260864, 0, 0, 3221233664, 0, 65536, 2181038080, 0, 3221299200, 3221299200, 0, 536797184] is too long
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: reg: [[4161077248, 8192, 4161011712, 4096, 3221225472, 8192]] is too short
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: reg-names:1: 'phy' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt', 'ctrl', 'parf', 'cfg', 'link', 'ulreg', 'smu', 'mpu']
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: ranges: 'oneOf' conditional failed, one must be fixed:
   	arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie@f8050000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[2164260864, 0, 0, 3221233664, 0, 65536, 2181038080, 0, 3221299200, 3221299200, 0, 536797184]] is not of type 'boolean'
   		True was expected
   		[[2164260864, 0, 0, 3221233664, 0, 65536, 2181038080, 0, 3221299200, 3221299200, 0, 536797184]] is not of type 'null'
   	[2164260864, 0, 0, 3221233664, 0, 65536, 2181038080, 0, 3221299200, 3221299200, 0, 536797184] is too long
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml:0:0: /pcie@f8050000: failed to match any schema with compatible: ['axis,artpec6-pcie', 'snps,dw-pcie']
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie_ep@f8050000: $nodename:0: 'pcie_ep@f8050000' does not match '^pcie?@'
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie_ep@f8050000: reg: [[4161077248, 8192, 4161081344, 8192, 4161011712, 4096, 3221225472, 536870912]] is too short
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie_ep@f8050000: reg-names:2: 'phy' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt', 'ctrl', 'parf', 'cfg', 'link', 'ulreg', 'smu', 'mpu']
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> arch/arm/boot/dts/artpec6-devboard.dt.yaml: pcie_ep@f8050000: reg-names:3: 'addr_space' is not one of ['dbi', 'dbi2', 'config', 'atu', 'app', 'elbi', 'mgmt', 'ctrl', 'parf', 'cfg', 'link', 'ulreg', 'smu', 'mpu']
   	From schema: Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml:0:0: /pcie_ep@f8050000: failed to match any schema with compatible: ['axis,artpec6-pcie-ep', 'snps,dw-pcie']
   arch/arm/boot/dts/artpec6-devboard.dt.yaml:0:0: /pinctrl@f801d000: failed to match any schema with compatible: ['axis,artpec6-pinctrl']
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: amba@0: $nodename:0: 'amba@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml:0:0: /amba@0/crypto@f4264000: failed to match any schema with compatible: ['axis,artpec6-crypto']
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: dma@f8019000: interrupt-names: ['error', 'ch0', 'ch1', 'ch2', 'ch3', 'ch4', 'ch5', 'ch6', 'ch7', 'ch8', 'ch9', 'ch10', 'ch12', 'ch12', 'ch13', 'ch14', 'ch15'] has non-unique elements
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/interrupts.yaml
   arch/arm/boot/dts/artpec6-devboard.dt.yaml:0:0: /amba@0/dma@f8019000: failed to match any schema with compatible: ['renesas,nbpfaxi64dmac8b16']
   arch/arm/boot/dts/artpec6-devboard.dt.yaml: dma@f8019400: interrupt-names: ['error', 'ch0', 'ch1', 'ch2', 'ch3', 'ch4', 'ch5', 'ch6', 'ch7', 'ch8', 'ch9', 'ch10', 'ch12', 'ch12', 'ch13', 'ch14', 'ch15'] has non-unique elements

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
