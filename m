Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73E33A90F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCOA0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 14 Mar 2021 20:26:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:64617 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCOA0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:26:48 -0400
IronPort-SDR: w+xhGnV6XvTsKN+kybJpaMtExD8ia8n19bjsVVm36CF04YXPllM8wq/dlmUxs85QZsw18E0klR
 cEta2MA806OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="189067394"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="189067394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 17:26:45 -0700
IronPort-SDR: 9DVmnjlN1p4IGm4ofi0a3TP0kElvhd3ur8V2MduTxMFjmCCMBVYbpXVs0luDz1oe/KeoFWB7px
 /JlTq9ra2a6A==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="405016735"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 17:26:42 -0700
Date:   Mon, 15 Mar 2021 08:25:57 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     dillon.minfei@gmail.com, robh+dt@kernel.org,
        alexandre.torgue@foss.st.com, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v2 6/8] ARM: dts: stm32: add support for art-pi board
 based on stm32h750xbh6
Message-ID: <20210315002557.GL219708@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1615530274-31422-7-git-send-email-dillon.minfei@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on stm32/stm32-next]
[also build test WARNING on robh/for-next soc/for-next v5.12-rc2 next-20210312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/dillon-minfei-gmail-com/ARM-STM32-add-art-pi-stm32h750xbh6-board-support/20210312-142805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"dtcheck warnings: (new ones prefixed by >>)"
>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: soc: pin-controller: {'type': 'object'} is not allowed for {'#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 1476526080, 12288]], 'interrupt-parent': [[22]], 'st,syscfg': [[28, 8]], 'pins-are-numbered': True, 'compatible': ['st,stm32h750-pinctrl'], 'gpio@58020000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[0, 1024]], 'clocks': [[2, 86]], 'st,bank-name': ['GPIOA'], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'phandle': [[10]]}, 'gpio@58020400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[1024, 1024]], 'clocks': [[2, 85]], 'st,bank-name': ['GPIOB'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[2048, 1024]], 'clocks': [[2, 84]], 'st,bank-name': ['GPIOC'], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'phandle': [[6]]}, 'gpio@58020c00': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': 
 [[3072, 1024]], 'clocks': [[2, 83]], 'st,bank-name': ['GPIOD'], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'phandle': [[4]]}, 'gpio@58021000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[4096, 1024]], 'clocks': [[2, 82]], 'st,bank-name': ['GPIOE'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[5120, 1024]], 'clocks': [[2, 81]], 'st,bank-name': ['GPIOF'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[6144, 1024]], 'clocks': [[2, 80]], 'st,bank-name': ['GPIOG'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021c00': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[7168, 1024]], 'clocks': [[2, 79]], 'st,bank-name': ['GPIOH'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[8192, 1
 024]], 'clocks': [[2, 78]], 'st,bank-name': ['GPIOI'], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'phandle': [[7]]}, 'gpio@58022400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[9216, 1024]], 'clocks': [[2, 77]], 'st,bank-name': ['GPIOJ'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[10240, 1024]], 'clocks': [[2, 76]], 'st,bank-name': ['GPIOK'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'i2c1-0': {'pins': {'pinmux': [[5637], [5893]], 'bias-disable': True, 'drive-open-drain': True, 'slew-rate': [[0]]}}, 'rmii-0': {'phandle': [[29]], 'pins': {'pinmux': [[27404], [27916], [27660], [9228], [9484], [1804], [8460], [524], [268]], 'slew-rate': [[2]]}}, 'sdmmc1-b4-0': {'phandle': [[14]], 'pins': {'pinmux': [[10253], [10509], [10765], [11021], [11277], [12813]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}}, 'sdmmc1-b4-od-0': {'phandle': [[15
 ]], 'pins1': {'pinmux': [[10253], [10509], [10765], [11021], [11277]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}, 'pins2': {'pinmux': [[12813]], 'slew-rate': [[3]], 'drive-open-drain': True, 'bias-disable': True}}, 'sdmmc1-b4-sleep-0': {'phandle': [[16]], 'pins': {'pinmux': [[10257], [10513], [10769], [11025], [11281], [12817]]}}, 'sdmmc2-b4-0': {'phandle': [[18]], 'pins': {'pinmux': [[7690], [7946], [4874], [5130], [13836], [14092]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}}, 'sdmmc2-b4-od-0': {'phandle': [[19]], 'pins1': {'pinmux': [[7690], [7946], [4874], [5130], [13836]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}, 'pins2': {'pinmux': [[14092]], 'slew-rate': [[3]], 'drive-open-drain': True, 'bias-disable': True}}, 'sdmmc2-b4-sleep-0': {'phandle': [[20]], 'pins': {'pinmux': [[7697], [7953], [4881], [5137], [13841], [14097]]}}, 'sdmmc1-dir-0': {'pins1': {'pinmux': [[9737], [9993], [6408]], 'slew-rate': [[3]
 ], 'drive-push-pull': True, 'bias-pull-up': True}, 'pins2': {'pinmux': [[6152]], 'bias-pull-up': True}}, 'sdmmc1-dir-sleep-0': {'pins': {'pinmux': [[9745], [10001], [6417], [6161]]}}, 'usart1-0': {'pins1': {'pinmux': [[7685]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[7941]], 'bias-disable': True}}, 'usart2-0': {'phandle': [[3]], 'pins1': {'pinmux': [[13576]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[13832]], 'bias-disable': True}}, 'usart3-0': {'pins1': {'pinmux': [[6664]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[6920]], 'bias-disable': True}}, 'uart4-0': {'phandle': [[8]], 'pins1': {'pinmux': [[9]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[35081]], 'bias-disable': True}}, 'usbotg-hs-0': {'pins': {'pinmux': [[29707], [35595], [8203], [1291], [779], [4107], [4363], [6667], [6923], [7179], [
 7435], [5387]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[2]]}}, 'spi1-0': {'phandle': [[9]], 'pins1': {'pinmux': [[1286], [5382]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[2]]}, 'pins2': {'pinmux': [[26886]], 'bias-disable': True}}}
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: soc: 'i2c@40005C00', 'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/serial/st,stm32-uart.yaml

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
