Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AC45EFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377849AbhKZOfC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 09:35:02 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:39435 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348370AbhKZOdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:33:00 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6C2FD20000C;
        Fri, 26 Nov 2021 14:29:43 +0000 (UTC)
Date:   Fri, 26 Nov 2021 15:29:42 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: dtbs_check: arch/arm/boot/dts/am437x-cm-t43.dt.yaml: tsc:
 'ti,coordinate-readouts' is a required property
Message-ID: <20211126152942.42d3b814@xps13>
In-Reply-To: <202111210737.L4TuykRK-lkp@intel.com>
References: <202111210737.L4TuykRK-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

lkp@intel.com wrote on Sun, 21 Nov 2021 07:05:42 +0800:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
> commit: 8c4838a8ae9392d2e94e15ffc76642ee1a0defe7 dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
> date:   4 weeks ago
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce: make ARCH=arm dtbs_check

FYI I've resent the three DTS patches on top of the big 48-patches
series which were not applied at the time of v5.16-rc1:
https://lore.kernel.org/linux-devicetree/20211126142413.354770-1-miquel.raynal@bootlin.com/T/#mac2848a0815183eb39e1cd2e1883b7e0c81efd70
This short series should fix the additional errors reported here.

Cheers,
Miquèl

> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> dtcheck warnings: (new ones prefixed by >>)
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@7000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000/i2c@0/tps65218@24: failed to match any schema with compatible: ['ti,tps65218']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml: at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'
>    	From schema: Documentation/devicetree/bindings/eeprom/at24.yaml
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
> >> arch/arm/boot/dts/am437x-cm-t43.dt.yaml: tsc: 'ti,coordinate-readouts' is a required property  
>    	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> >> arch/arm/boot/dts/am437x-cm-t43.dt.yaml: tsc: 'ti,coordiante-readouts' does not match any of the regexes: 'pinctrl-[0-9]+'  
>    	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000/tscadc@0/adc: failed to match any schema with compatible: ['ti,am3359-adc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml: scm@0: $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>    	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml: scm@0: clockdomains: {} should not be valid under {'type': 'object'}
>    	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am4-scm', 'simple-bus']
>    arch/arm/boot/dts/am437x-cm-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0/pinmux@800: failed to match any schema with compatible: ['ti,am437-padconf', 'pinctrl-single']
> --
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@7000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@9000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000: failed to match any schema with compatible: ['ti,sysc-omap2', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@b000/i2c@0/tps65218@24: failed to match any schema with compatible: ['ti,tps65218']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'
>    	From schema: Documentation/devicetree/bindings/eeprom/at24.yaml
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
> >> arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: tsc: 'ti,coordinate-readouts' is a required property  
>    	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> >> arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: tsc: 'ti,coordiante-readouts' does not match any of the regexes: 'pinctrl-[0-9]+'  
>    	From schema: Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@d000/tscadc@0/adc: failed to match any schema with compatible: ['ti,am3359-adc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000: failed to match any schema with compatible: ['ti,sysc-omap4', 'ti,sysc']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: scm@0: $nodename:0: 'scm@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>    	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml: scm@0: clockdomains: {} should not be valid under {'type': 'object'}
>    	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0: failed to match any schema with compatible: ['ti,am4-scm', 'simple-bus']
>    arch/arm/boot/dts/am437x-sbc-t43.dt.yaml:0:0: /ocp@44000000/interconnect@44c00000/segment@200000/target-module@10000/scm@0/pinmux@800: failed to match any schema with compatible: ['ti,am437-padconf', 'pinctrl-single']
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
