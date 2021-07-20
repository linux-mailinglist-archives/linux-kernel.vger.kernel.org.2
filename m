Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9AE3CF45C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbhGTFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:35:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:40633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238336AbhGTFcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:32:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="198385648"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="198385648"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 23:12:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="414569029"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2021 23:12:30 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5izV-00004j-Ln; Tue, 20 Jul 2021 06:12:29 +0000
Date:   Tue, 20 Jul 2021 13:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     dillon.minfei@gmail.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
Message-ID: <202107201305.FPUQWvWk-lkp@intel.com>
References: <1626430843-23823-2-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626430843-23823-2-git-send-email-dillon.minfei@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v5.14-rc2 next-20210719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/dillon-minfei-gmail-com/Add-ilitek-ili9341-panel-driver/20210718-103113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
compiler: arm-linux-gnueabi-gcc (GCC) 10.3.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /interrupt-controller@e000e100: failed to match any schema with compatible: ['arm,armv7m-nvic']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /timer@e000e010: failed to match any schema with compatible: ['arm,armv7m-systick']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/i2c@40005c00/stmpe811@41: failed to match any schema with compatible: ['st,stmpe811']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/i2c@40005c00/stmpe811@41/stmpe_touchscreen: failed to match any schema with compatible: ['st,stmpe-ts']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml: l3gd20@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible: ['st,sf-tc240t-9370-t'] is too short
   	From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/crc@40023000: failed to match any schema with compatible: ['st,stm32f4-crc']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f42xx-rcc', 'st,stm32-rcc']
   arch/arm/boot/dts/stm32f429-disco.dt.yaml:0:0: /soc/rcc@40023800: failed to match any schema with compatible: ['st,stm32f42xx-rcc', 'st,stm32-rcc']

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
