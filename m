Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD833A910
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCOA0t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 14 Mar 2021 20:26:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:60739 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCOA0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:26:17 -0400
IronPort-SDR: xxXRRsUuZYtH6Mka80StG704pNy+ZaOcXn6grYwybcnUr91gyLan/LDhEu6+pq7VUlxpG8+6G/
 /geaussnQpLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="188380280"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="188380280"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 17:26:15 -0700
IronPort-SDR: DfHHtIEfWfVO3bUUp225APrZc9AqrgyF49fk7Lz0Eb2W28FgpFl0aE1ih2tIqXjJ0znoR2q+d4
 kvmvXpzsniCg==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="411662432"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 17:26:11 -0700
Date:   Mon, 15 Mar 2021 08:25:26 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     dillon.minfei@gmail.com, robh+dt@kernel.org,
        alexandre.torgue@foss.st.com, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v2 4/8] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi
 to support stm32h750
Message-ID: <20210315002526.GK219708@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1615530274-31422-5-git-send-email-dillon.minfei@gmail.com>
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
:::::: branch date: 17 hours ago
:::::: commit date: 17 hours ago
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"dtcheck warnings: (new ones prefixed by >>)"
>> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller: {'type': 'object'} is not allowed for {'#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 1476526080, 12288]], 'interrupt-parent': [[17]], 'st,syscfg': [[23, 8]], 'pins-are-numbered': True, 'compatible': ['st,stm32h743-pinctrl'], 'gpio@58020000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[0, 1024]], 'clocks': [[2, 86]], 'st,bank-name': ['GPIOA'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[1024, 1024]], 'clocks': [[2, 85]], 'st,bank-name': ['GPIOB'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[2048, 1024]], 'clocks': [[2, 84]], 'st,bank-name': ['GPIOC'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020c00': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[3072, 1024]], 'clocks': [[2, 83]], 's
 t,bank-name': ['GPIOD'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[4096, 1024]], 'clocks': [[2, 82]], 'st,bank-name': ['GPIOE'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[5120, 1024]], 'clocks': [[2, 81]], 'st,bank-name': ['GPIOF'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[6144, 1024]], 'clocks': [[2, 80]], 'st,bank-name': ['GPIOG'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021c00': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[7168, 1024]], 'clocks': [[2, 79]], 'st,bank-name': ['GPIOH'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[8192, 1024]], 'clocks': [[2, 78]], 'st,bank-name': ['GPIOI'], 'i
 nterrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[9216, 1024]], 'clocks': [[2, 77]], 'st,bank-name': ['GPIOJ'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[10240, 1024]], 'clocks': [[2, 76]], 'st,bank-name': ['GPIOK'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'i2c1-0': {'phandle': [[3]], 'pins': {'pinmux': [[5637], [5893]], 'bias-disable': True, 'drive-open-drain': True, 'slew-rate': [[0]]}}, 'rmii-0': {'phandle': [[24]], 'pins': {'pinmux': [[27404], [27916], [27660], [9228], [9484], [1804], [8460], [524], [268]], 'slew-rate': [[2]]}}, 'sdmmc1-b4-0': {'phandle': [[11]], 'pins': {'pinmux': [[10253], [10509], [10765], [11021], [11277], [12813]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}}, 'sdmmc1-b4-od-0': {'phandle': [[13]], 'pins1': {'pinmux': [[10253], [10509], [10765], [1102
 1], [11277]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}, 'pins2': {'pinmux': [[12813]], 'slew-rate': [[3]], 'drive-open-drain': True, 'bias-disable': True}}, 'sdmmc1-b4-sleep-0': {'phandle': [[14]], 'pins': {'pinmux': [[10257], [10513], [10769], [11025], [11281], [12817]]}}, 'sdmmc1-dir-0': {'phandle': [[12]], 'pins1': {'pinmux': [[9737], [9993], [6408]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-pull-up': True}, 'pins2': {'pinmux': [[6152]], 'bias-pull-up': True}}, 'sdmmc1-dir-sleep-0': {'phandle': [[15]], 'pins': {'pinmux': [[9745], [10001], [6417], [6161]]}}, 'usart1-0': {'phandle': [[4]], 'pins1': {'pinmux': [[7685]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[7941]], 'bias-disable': True}}, 'usart2-0': {'pins1': {'pinmux': [[13576]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[13832]], 'bias-disable': True}}, 'usbotg-hs-0': {'phandle': [[9]], 'pins': {'
 pinmux': [[29707], [35595], [8203], [1291], [779], [4107], [4363], [6667], [6923], [7179], [7435], [5387]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[2]]}}}
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: 'i2c@40005C00', 'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
--
>> arch/arm/boot/dts/stm32h743i-disco.dt.yaml: soc: pin-controller: {'type': 'object'} is not allowed for {'#address-cells': [[1]], '#size-cells': [[1]], 'ranges': [[0, 1476526080, 12288]], 'interrupt-parent': [[11]], 'st,syscfg': [[17, 8]], 'pins-are-numbered': True, 'compatible': ['st,stm32h743-pinctrl'], 'gpio@58020000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[0, 1024]], 'clocks': [[2, 86]], 'st,bank-name': ['GPIOA'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[1024, 1024]], 'clocks': [[2, 85]], 'st,bank-name': ['GPIOB'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[2048, 1024]], 'clocks': [[2, 84]], 'st,bank-name': ['GPIOC'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58020c00': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[3072, 1024]], 'clocks': [[2, 83]], '
 st,bank-name': ['GPIOD'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[4096, 1024]], 'clocks': [[2, 82]], 'st,bank-name': ['GPIOE'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[5120, 1024]], 'clocks': [[2, 81]], 'st,bank-name': ['GPIOF'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[6144, 1024]], 'clocks': [[2, 80]], 'st,bank-name': ['GPIOG'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58021c00': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[7168, 1024]], 'clocks': [[2, 79]], 'st,bank-name': ['GPIOH'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022000': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[8192, 1024]], 'clocks': [[2, 78]], 'st,bank-name': ['GPIOI'], '
 interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022400': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[9216, 1024]], 'clocks': [[2, 77]], 'st,bank-name': ['GPIOJ'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'gpio@58022800': {'gpio-controller': True, '#gpio-cells': [[2]], 'reg': [[10240, 1024]], 'clocks': [[2, 76]], 'st,bank-name': ['GPIOK'], 'interrupt-controller': True, '#interrupt-cells': [[2]]}, 'i2c1-0': {'pins': {'pinmux': [[5637], [5893]], 'bias-disable': True, 'drive-open-drain': True, 'slew-rate': [[0]]}}, 'rmii-0': {'phandle': [[18]], 'pins': {'pinmux': [[27404], [27916], [27660], [9228], [9484], [1804], [8460], [524], [268]], 'slew-rate': [[2]]}}, 'sdmmc1-b4-0': {'phandle': [[7]], 'pins': {'pinmux': [[10253], [10509], [10765], [11021], [11277], [12813]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}}, 'sdmmc1-b4-od-0': {'phandle': [[8]], 'pins1': {'pinmux': [[10253], [10509], [10765], [11021], [11277]], 'slew
 -rate': [[3]], 'drive-push-pull': True, 'bias-disable': True}, 'pins2': {'pinmux': [[12813]], 'slew-rate': [[3]], 'drive-open-drain': True, 'bias-disable': True}}, 'sdmmc1-b4-sleep-0': {'phandle': [[9]], 'pins': {'pinmux': [[10257], [10513], [10769], [11025], [11281], [12817]]}}, 'sdmmc1-dir-0': {'pins1': {'pinmux': [[9737], [9993], [6408]], 'slew-rate': [[3]], 'drive-push-pull': True, 'bias-pull-up': True}, 'pins2': {'pinmux': [[6152]], 'bias-pull-up': True}}, 'sdmmc1-dir-sleep-0': {'pins': {'pinmux': [[9745], [10001], [6417], [6161]]}}, 'usart1-0': {'pins1': {'pinmux': [[7685]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[7941]], 'bias-disable': True}}, 'usart2-0': {'phandle': [[3]], 'pins1': {'pinmux': [[13576]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[0]]}, 'pins2': {'pinmux': [[13832]], 'bias-disable': True}}, 'usbotg-hs-0': {'pins': {'pinmux': [[29707], [35595], [8203], [1291], [779], [4107], [4363], [6667], [
 6923], [7179], [7435], [5387]], 'bias-disable': True, 'drive-push-pull': True, 'slew-rate': [[2]]}}}
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/stm32h743i-disco.dt.yaml: soc: 'i2c@40005C00', 'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
