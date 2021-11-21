Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9845869C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 22:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhKUVsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 16:48:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:8919 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhKUVsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 16:48:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="221912351"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; 
   d="scan'208";a="221912351"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 13:45:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; 
   d="scan'208";a="456060389"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2021 13:45:01 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moudw-0007AO-IO; Sun, 21 Nov 2021 21:45:00 +0000
Date:   Mon, 22 Nov 2021 05:44:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: dtbs_check: arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml:
 usb@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match
 any of the regexes: 'pinctrl-[0-9]+'
Message-ID: <202111220524.xi5j8vz7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   923dcc5eb0c111eccd51cc7ce1658537e3c38b25
commit: 80e73332ee829cd55d86272b7d3d4d5f0fc4c4ff dt-bindings: mstar: Add binding details for mstar,smpctrl
date:   12 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: 'ranges' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: '#address-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: '#size-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: usb@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: leds: 'system', 'wlan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 164, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 113, in check_trees
       self.check_subtree(dt, subtree, "/", "/", filename)
     File "/usr/local/bin/dt-validate", line 104, in check_subtree
--
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   	arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'boolean'
   		True was expected
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'null'
   	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: usb@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
>> arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: leds: '5ghz', 'system', 'usb', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: leds: '5ghz' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie0_leds: '2ghz' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie0_leds: '2ghz' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
--
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   	arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'boolean'
   		True was expected
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'null'
   	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: usb@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
>> arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: leds: '2ghz', '5ghz', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: leds: '2ghz', '5ghz' do not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 164, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 113, in check_trees

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
