Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D879745814A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 01:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhKUAMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 19:12:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:21790 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhKUAMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 19:12:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="234855287"
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="234855287"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 16:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="508428020"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2021 16:09:27 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moaQA-0006PX-Qt; Sun, 21 Nov 2021 00:09:26 +0000
Date:   Sun, 21 Nov 2021 08:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: dtbs_check: arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml:
 mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match
 '^([a-z][a-z0-9\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
Message-ID: <202111210808.2q4ncTEZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9539ba4308ad5bdca6cb41c7b73cbb9f796dcdd7
commit: a7b4dba9a71d64e07fbc9802bbc1eaad5494f071 dt-bindings: phy: exynos: add the samsung,exynos-pcie-phy binding
date:   12 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: 'ranges' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: '#address-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: pcie@2000: '#size-cells' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: ehci@4000: $nodename:0: 'ehci@4000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: ehci@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: ohci@d000: $nodename:0: 'ohci@d000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: ohci@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-1440.dt.yaml: leds: 'system', 'wlan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 164, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 113, in check_trees
       self.check_subtree(dt, subtree, "/", "/", filename)
     File "/usr/local/bin/dt-validate", line 104, in check_subtree
       self.check_subtree(tree, value, name, fullname + name, filename)
     File "/usr/local/bin/dt-validate", line 99, in check_subtree
--
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
>> 	arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'boolean'
   		True was expected
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'null'
   	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: ehci@4000: $nodename:0: 'ehci@4000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: ehci@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: ohci@d000: $nodename:0: 'ohci@d000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: ohci@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: leds: '5ghz', 'system' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: leds: '5ghz' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
>> arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: pcie0_leds: '2ghz' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm47189-luxul-xap-810.dt.yaml: pcie0_leds: '2ghz' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 164, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 113, in check_trees
       self.check_subtree(dt, subtree, "/", "/", filename)
     File "/usr/local/bin/dt-validate", line 104, in check_subtree
--
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>> arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
>> 	arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'boolean'
   		True was expected
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'null'
   	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: ehci@4000: $nodename:0: 'ehci@4000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: ehci@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: ohci@d000: $nodename:0: 'ohci@d000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: ohci@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
>> arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: leds: '5ghz', 'system', 'usb', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: leds: '5ghz' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
>> arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie0_leds: '2ghz' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm47189-tenda-ac9.dt.yaml: pcie0_leds: '2ghz' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 164, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 113, in check_trees
       self.check_subtree(dt, subtree, "/", "/", filename)
     File "/usr/local/bin/dt-validate", line 104, in check_subtree
--
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>> arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
>> 	arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: pcie@2000: ranges: 'oneOf' conditional failed, one must be fixed:
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'boolean'
   		True was expected
   		[[0, 0, 0, 0, 0, 1048576]] is not of type 'null'
   	0 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
>> arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: pcie@2000: 'device_type' is a required property
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/pci/pci-bus.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: ehci@4000: $nodename:0: 'ehci@4000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: ehci@4000: '#address-cells', '#size-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ehci.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: ohci@d000: $nodename:0: 'ohci@d000' does not match '^usb(@.*)?'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: ohci@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/usb/generic-ohci.yaml
>> arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: leds: '2ghz', '5ghz', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
   arch/arm/boot/dts/bcm947189acdbmr.dt.yaml: leds: '2ghz', '5ghz' do not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/dt-core.yaml
   schemas/input/input.yaml: ignoring, error in schema: properties: power-off-time-sec
   Traceback (most recent call last):
     File "/usr/local/bin/dt-validate", line 164, in <module>
       sg.check_trees(filename, testtree)
     File "/usr/local/bin/dt-validate", line 113, in check_trees
       self.check_subtree(dt, subtree, "/", "/", filename)
     File "/usr/local/bin/dt-validate", line 104, in check_subtree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
