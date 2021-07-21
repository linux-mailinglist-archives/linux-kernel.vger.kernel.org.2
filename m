Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D13D0CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbhGUJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:46:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:10024 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238710AbhGUJiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:38:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211469738"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="211469738"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 03:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="432558915"
Received: from lkp-server01.sh.intel.com (HELO b8b92b2878b0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2021 03:18:25 -0700
Received: from kbuild by b8b92b2878b0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m69J2-0000J4-8E; Wed, 21 Jul 2021 10:18:24 +0000
Date:   Wed, 21 Jul 2021 18:17:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Apurva Nandan <a-nandan@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Apurva Nandan <a-nandan@ti.com>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nand: Convert to DT schema format
Message-ID: <202107211818.sbizhVdd-lkp@intel.com>
References: <20210718004125.733-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718004125.733-1-a-nandan@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Apurva,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes robh/for-next v5.14-rc2 next-20210720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Apurva-Nandan/dt-bindings-mtd-spi-nand-Convert-to-DT-schema-format/20210718-103130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
compiler: arm-linux-gnueabi-gcc (GCC) 10.3.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml: clock-controller@1800000: '#power-domain-cells' is a required property
   	From schema: Documentation/devicetree/bindings/clock/qcom,gcc.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/rng@22000: failed to match any schema with compatible: ['qcom,prng']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/pinctrl@1000000: failed to match any schema with compatible: ['qcom,ipq4019-pinctrl']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml: usb-power: $nodename:0: 'usb-power' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/gpio/gpio-hog.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/sdhci@7824900: failed to match any schema with compatible: ['qcom,sdhci-msm-v4']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/dma@7884000: failed to match any schema with compatible: ['qcom,bam-v1.7.0']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/spi@78b5000: failed to match any schema with compatible: ['qcom,spi-qup-v2.2.1']
>> arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml: nand@1: $nodename:0: 'nand@1' does not match '^flash(@.*)?$'
   	From schema: Documentation/devicetree/bindings/mtd/spi-nand.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/spi@78b6000: failed to match any schema with compatible: ['qcom,spi-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/i2c@78b7000: failed to match any schema with compatible: ['qcom,i2c-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/i2c@78b8000: failed to match any schema with compatible: ['qcom,i2c-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/dma@8e04000: failed to match any schema with compatible: ['qcom,bam-v1.7.0']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/crypto@8e3a000: failed to match any schema with compatible: ['qcom,crypto-v5.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/clock-controller@b088000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/clock-controller@b098000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/clock-controller@b0a8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dt.yaml:0:0: /soc/clock-controller@b0b8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
--
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml: clock-controller@1800000: '#power-domain-cells' is a required property
   	From schema: Documentation/devicetree/bindings/clock/qcom,gcc.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/rng@22000: failed to match any schema with compatible: ['qcom,prng']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/pinctrl@1000000: failed to match any schema with compatible: ['qcom,ipq4019-pinctrl']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml: usb-power: $nodename:0: 'usb-power' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/gpio/gpio-hog.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/sdhci@7824900: failed to match any schema with compatible: ['qcom,sdhci-msm-v4']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/dma@7884000: failed to match any schema with compatible: ['qcom,bam-v1.7.0']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/spi@78b5000: failed to match any schema with compatible: ['qcom,spi-qup-v2.2.1']
>> arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml: nand@1: $nodename:0: 'nand@1' does not match '^flash(@.*)?$'
   	From schema: Documentation/devicetree/bindings/mtd/spi-nand.yaml
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/spi@78b6000: failed to match any schema with compatible: ['qcom,spi-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/i2c@78b7000: failed to match any schema with compatible: ['qcom,i2c-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/i2c@78b8000: failed to match any schema with compatible: ['qcom,i2c-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/dma@8e04000: failed to match any schema with compatible: ['qcom,bam-v1.7.0']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/crypto@8e3a000: failed to match any schema with compatible: ['qcom,crypto-v5.1']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/clock-controller@b088000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/clock-controller@b098000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/clock-controller@b0a8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dt.yaml:0:0: /soc/clock-controller@b0b8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
--
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/reg.yaml
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml: soc: pci@40000000:reg:0: [1073741824, 3869, 1073745696, 168, 524288, 8192, 1074790400, 4096] is too long
   	From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/simple-bus.yaml
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml: clock-controller@1800000: '#power-domain-cells' is a required property
   	From schema: Documentation/devicetree/bindings/clock/qcom,gcc.yaml
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/rng@22000: failed to match any schema with compatible: ['qcom,prng']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/pinctrl@1000000: failed to match any schema with compatible: ['qcom,ipq4019-pinctrl']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/sdhci@7824900: failed to match any schema with compatible: ['qcom,sdhci-msm-v4']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/dma@7884000: failed to match any schema with compatible: ['qcom,bam-v1.7.0']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/spi@78b5000: failed to match any schema with compatible: ['qcom,spi-qup-v2.2.1']
>> arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml: spi-nand@1: $nodename:0: 'spi-nand@1' does not match '^flash(@.*)?$'
   	From schema: Documentation/devicetree/bindings/mtd/spi-nand.yaml
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/spi@78b6000: failed to match any schema with compatible: ['qcom,spi-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/i2c@78b7000: failed to match any schema with compatible: ['qcom,i2c-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/i2c@78b8000: failed to match any schema with compatible: ['qcom,i2c-qup-v2.2.1']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/dma@8e04000: failed to match any schema with compatible: ['qcom,bam-v1.7.0']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/crypto@8e3a000: failed to match any schema with compatible: ['qcom,crypto-v5.1']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/clock-controller@b088000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/clock-controller@b098000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/clock-controller@b0a8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
   arch/arm/boot/dts/qcom-ipq4018-jalapeno.dt.yaml:0:0: /soc/clock-controller@b0b8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
