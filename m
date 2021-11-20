Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA34580DF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhKTXJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:09:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:14745 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236806AbhKTXJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:09:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="234442282"
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="234442282"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 15:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="673630136"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2021 15:06:26 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moZRB-0006MS-CU; Sat, 20 Nov 2021 23:06:25 +0000
Date:   Sun, 21 Nov 2021 07:05:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: dtbs_check: arch/arm/boot/dts/am437x-cm-t43.dt.yaml: tsc:
 'ti,coordinate-readouts' is a required property
Message-ID: <202111210737.L4TuykRK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
commit: 8c4838a8ae9392d2e94e15ffc76642ee1a0defe7 dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
date:   4 weeks ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@7000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000/i2c@0/tps65218@24: failed to match any schema with compatible: ['ti,tps65218']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml: at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'
   	From schema: Documentation/devicetree/bindings/eeprom/at24.yaml
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>> arch/arm/boot/dts/am437x-cm-t43.dt.yaml: tsc: 'ti,coordinate-readouts' is a required property
   	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>> arch/arm/boot/dts/am437x-cm-t43.dt.yaml: tsc: 'ti,coordiante-readouts' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000/tscadc@0/adc: failed to match any schema with compatible: ['ti,am3359-adc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml: scm@0: $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml: scm@0: clockdomains: {} should not be valid under {'type': 'object'}
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am4-scm', 'simple-bus']
   arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0/pinmux@800: failed to match any schema with compatible: ['ti,am437-padconf', 'pinctrl-single']
--
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@7000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000/i2c@0/tps65218@24: failed to match any schema with compatible: ['ti,tps65218']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'
   	From schema: Documentation/devicetree/bindings/eeprom/at24.yaml
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>> arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: tsc: 'ti,coordinate-readouts' is a required property
   	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>> arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: tsc: 'ti,coordiante-readouts' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000/tscadc@0/adc: failed to match any schema with compatible: ['ti,am3359-adc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: scm@0: $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: scm@0: clockdomains: {} should not be valid under {'type': 'object'}
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am4-scm', 'simple-bus']
   arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0/pinmux@800: failed to match any schema with compatible: ['ti,am437-padconf', 'pinctrl-single']

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
