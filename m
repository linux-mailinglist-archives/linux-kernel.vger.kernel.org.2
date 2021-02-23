Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5874A322FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhBWRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:38:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:54395 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232989AbhBWRib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:38:31 -0500
IronPort-SDR: FUtT5FXlEXnoHLCOM8QU5AAlqnCwwetwEP6rcIE5Fyki3krrabdUxDj0D1q6eBchA0JvF+k2WW
 rEDgD/x9tiIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="181454027"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="gz'50?scan'50,208,50";a="181454027"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 09:37:47 -0800
IronPort-SDR: vJn1PCiH6TvDtsOjajQx0VDl9pd+O1GQHPejr+aE2fEZvjWQ6sm1qmbL7+58p32Co38SqmGwT3
 VSgM4ZvhnKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="gz'50?scan'50,208,50";a="364602549"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2021 09:37:42 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEbcz-0001Qk-TK; Tue, 23 Feb 2021 17:37:41 +0000
Date:   Wed, 24 Feb 2021 01:37:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 2/2] usb: host: ehci-platform: add ignore-oc DT support
Message-ID: <202102240136.RGUQqkhY-lkp@intel.com>
References: <20210223155005.21712-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223155005.21712-3-noltari@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "Álvaro,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v5.11 next-20210223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/lvaro-Fern-ndez-Rojas/usb-host-ehci-platform-add-ignore-oc-DT-support/20210223-235717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: m68k-randconfig-s031-20210223 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-229-g60c1f270-dirty
        # https://github.com/0day-ci/linux/commit/cb5cc55cab35476258f04e40cac0a9dd02271475
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review lvaro-Fern-ndez-Rojas/usb-host-ehci-platform-add-ignore-oc-DT-support/20210223-235717
        git checkout cb5cc55cab35476258f04e40cac0a9dd02271475
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/usb/host/ehci-platform.c:21:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_no.h:33:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      33 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:137:2: note: in expansion of macro 'BUG_ON'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:137:10: note: in expansion of macro 'virt_addr_valid'
     137 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/usb/host/ehci-platform.c: In function 'ehci_platform_probe':
>> drivers/usb/host/ehci-platform.c:290:8: error: 'struct ehci_hcd' has no member named 'ignore_oc'
     290 |    ehci->ignore_oc = 1;
         |        ^~


vim +290 drivers/usb/host/ehci-platform.c

   238	
   239	static int ehci_platform_probe(struct platform_device *dev)
   240	{
   241		struct usb_hcd *hcd;
   242		struct resource *res_mem;
   243		struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
   244		struct ehci_platform_priv *priv;
   245		struct ehci_hcd *ehci;
   246		int err, irq, clk = 0;
   247	
   248		if (usb_disabled())
   249			return -ENODEV;
   250	
   251		/*
   252		 * Use reasonable defaults so platforms don't have to provide these
   253		 * with DT probing on ARM.
   254		 */
   255		if (!pdata)
   256			pdata = &ehci_platform_defaults;
   257	
   258		err = dma_coerce_mask_and_coherent(&dev->dev,
   259			pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
   260		if (err) {
   261			dev_err(&dev->dev, "Error: DMA mask configuration failed\n");
   262			return err;
   263		}
   264	
   265		irq = platform_get_irq(dev, 0);
   266		if (irq < 0)
   267			return irq;
   268	
   269		hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
   270				     dev_name(&dev->dev));
   271		if (!hcd)
   272			return -ENOMEM;
   273	
   274		platform_set_drvdata(dev, hcd);
   275		dev->dev.platform_data = pdata;
   276		priv = hcd_to_ehci_priv(hcd);
   277		ehci = hcd_to_ehci(hcd);
   278	
   279		if (pdata == &ehci_platform_defaults && dev->dev.of_node) {
   280			if (of_property_read_bool(dev->dev.of_node, "big-endian-regs"))
   281				ehci->big_endian_mmio = 1;
   282	
   283			if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
   284				ehci->big_endian_desc = 1;
   285	
   286			if (of_property_read_bool(dev->dev.of_node, "big-endian"))
   287				ehci->big_endian_mmio = ehci->big_endian_desc = 1;
   288	
   289			if (of_property_read_bool(dev->dev.of_node, "ignore-oc"))
 > 290				ehci->ignore_oc = 1;
   291	
   292			if (of_property_read_bool(dev->dev.of_node,
   293						  "needs-reset-on-resume"))
   294				priv->reset_on_resume = true;
   295	
   296			if (of_property_read_bool(dev->dev.of_node,
   297						  "has-transaction-translator"))
   298				hcd->has_tt = 1;
   299	
   300			if (soc_device_match(quirk_poll_match))
   301				priv->quirk_poll = true;
   302	
   303			for (clk = 0; clk < EHCI_MAX_CLKS; clk++) {
   304				priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
   305				if (IS_ERR(priv->clks[clk])) {
   306					err = PTR_ERR(priv->clks[clk]);
   307					if (err == -EPROBE_DEFER)
   308						goto err_put_clks;
   309					priv->clks[clk] = NULL;
   310					break;
   311				}
   312			}
   313		}
   314	
   315		priv->rsts = devm_reset_control_array_get_optional_shared(&dev->dev);
   316		if (IS_ERR(priv->rsts)) {
   317			err = PTR_ERR(priv->rsts);
   318			goto err_put_clks;
   319		}
   320	
   321		err = reset_control_deassert(priv->rsts);
   322		if (err)
   323			goto err_put_clks;
   324	
   325		if (pdata->big_endian_desc)
   326			ehci->big_endian_desc = 1;
   327		if (pdata->big_endian_mmio)
   328			ehci->big_endian_mmio = 1;
   329		if (pdata->has_tt)
   330			hcd->has_tt = 1;
   331		if (pdata->reset_on_resume)
   332			priv->reset_on_resume = true;
   333	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--0OAP2g/MAC+5xKAE--
