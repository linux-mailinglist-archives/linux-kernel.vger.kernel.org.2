Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590C541AB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhI1JAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:00:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:26857 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239623AbhI1JAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:00:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288313469"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="gz'50?scan'50,208,50";a="288313469"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 01:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="gz'50?scan'50,208,50";a="707761607"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2021 01:58:59 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mV8x0-000107-Et; Tue, 28 Sep 2021 08:58:58 +0000
Date:   Tue, 28 Sep 2021 16:58:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type
 'enum imx_dma_type' from 'const void *'
Message-ID: <202109281604.C3FIJpUM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0513e464f9007b70b96740271a948ca5ab6e7dd7
commit: 0ab785c894e618587e83bb67e8a8e96649868ad1 dmaengine: imx-dma: Remove unused .id_table
date:   10 months ago
config: arm64-randconfig-r016-20210927 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ab785c894e618587e83bb67e8a8e96649868ad1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0ab785c894e618587e83bb67e8a8e96649868ad1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1048 drivers/dma/imx-dma.c

  1035	
  1036	static int __init imxdma_probe(struct platform_device *pdev)
  1037	{
  1038		struct imxdma_engine *imxdma;
  1039		struct resource *res;
  1040		int ret, i;
  1041		int irq, irq_err;
  1042	
  1043		imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
  1044		if (!imxdma)
  1045			return -ENOMEM;
  1046	
  1047		imxdma->dev = &pdev->dev;
> 1048		imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
  1049	
  1050		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1051		imxdma->base = devm_ioremap_resource(&pdev->dev, res);
  1052		if (IS_ERR(imxdma->base))
  1053			return PTR_ERR(imxdma->base);
  1054	
  1055		irq = platform_get_irq(pdev, 0);
  1056		if (irq < 0)
  1057			return irq;
  1058	
  1059		imxdma->dma_ipg = devm_clk_get(&pdev->dev, "ipg");
  1060		if (IS_ERR(imxdma->dma_ipg))
  1061			return PTR_ERR(imxdma->dma_ipg);
  1062	
  1063		imxdma->dma_ahb = devm_clk_get(&pdev->dev, "ahb");
  1064		if (IS_ERR(imxdma->dma_ahb))
  1065			return PTR_ERR(imxdma->dma_ahb);
  1066	
  1067		ret = clk_prepare_enable(imxdma->dma_ipg);
  1068		if (ret)
  1069			return ret;
  1070		ret = clk_prepare_enable(imxdma->dma_ahb);
  1071		if (ret)
  1072			goto disable_dma_ipg_clk;
  1073	
  1074		/* reset DMA module */
  1075		imx_dmav1_writel(imxdma, DCR_DRST, DMA_DCR);
  1076	
  1077		if (is_imx1_dma(imxdma)) {
  1078			ret = devm_request_irq(&pdev->dev, irq,
  1079					       dma_irq_handler, 0, "DMA", imxdma);
  1080			if (ret) {
  1081				dev_warn(imxdma->dev, "Can't register IRQ for DMA\n");
  1082				goto disable_dma_ahb_clk;
  1083			}
  1084			imxdma->irq = irq;
  1085	
  1086			irq_err = platform_get_irq(pdev, 1);
  1087			if (irq_err < 0) {
  1088				ret = irq_err;
  1089				goto disable_dma_ahb_clk;
  1090			}
  1091	
  1092			ret = devm_request_irq(&pdev->dev, irq_err,
  1093					       imxdma_err_handler, 0, "DMA", imxdma);
  1094			if (ret) {
  1095				dev_warn(imxdma->dev, "Can't register ERRIRQ for DMA\n");
  1096				goto disable_dma_ahb_clk;
  1097			}
  1098			imxdma->irq_err = irq_err;
  1099		}
  1100	
  1101		/* enable DMA module */
  1102		imx_dmav1_writel(imxdma, DCR_DEN, DMA_DCR);
  1103	
  1104		/* clear all interrupts */
  1105		imx_dmav1_writel(imxdma, (1 << IMX_DMA_CHANNELS) - 1, DMA_DISR);
  1106	
  1107		/* disable interrupts */
  1108		imx_dmav1_writel(imxdma, (1 << IMX_DMA_CHANNELS) - 1, DMA_DIMR);
  1109	
  1110		INIT_LIST_HEAD(&imxdma->dma_device.channels);
  1111	
  1112		dma_cap_set(DMA_SLAVE, imxdma->dma_device.cap_mask);
  1113		dma_cap_set(DMA_CYCLIC, imxdma->dma_device.cap_mask);
  1114		dma_cap_set(DMA_MEMCPY, imxdma->dma_device.cap_mask);
  1115		dma_cap_set(DMA_INTERLEAVE, imxdma->dma_device.cap_mask);
  1116	
  1117		/* Initialize 2D global parameters */
  1118		for (i = 0; i < IMX_DMA_2D_SLOTS; i++)
  1119			imxdma->slots_2d[i].count = 0;
  1120	
  1121		spin_lock_init(&imxdma->lock);
  1122	
  1123		/* Initialize channel parameters */
  1124		for (i = 0; i < IMX_DMA_CHANNELS; i++) {
  1125			struct imxdma_channel *imxdmac = &imxdma->channel[i];
  1126	
  1127			if (!is_imx1_dma(imxdma)) {
  1128				ret = devm_request_irq(&pdev->dev, irq + i,
  1129						dma_irq_handler, 0, "DMA", imxdma);
  1130				if (ret) {
  1131					dev_warn(imxdma->dev, "Can't register IRQ %d "
  1132						 "for DMA channel %d\n",
  1133						 irq + i, i);
  1134					goto disable_dma_ahb_clk;
  1135				}
  1136	
  1137				imxdmac->irq = irq + i;
  1138				timer_setup(&imxdmac->watchdog, imxdma_watchdog, 0);
  1139			}
  1140	
  1141			imxdmac->imxdma = imxdma;
  1142	
  1143			INIT_LIST_HEAD(&imxdmac->ld_queue);
  1144			INIT_LIST_HEAD(&imxdmac->ld_free);
  1145			INIT_LIST_HEAD(&imxdmac->ld_active);
  1146	
  1147			tasklet_setup(&imxdmac->dma_tasklet, imxdma_tasklet);
  1148			imxdmac->chan.device = &imxdma->dma_device;
  1149			dma_cookie_init(&imxdmac->chan);
  1150			imxdmac->channel = i;
  1151	
  1152			/* Add the channel to the DMAC list */
  1153			list_add_tail(&imxdmac->chan.device_node,
  1154				      &imxdma->dma_device.channels);
  1155		}
  1156	
  1157		imxdma->dma_device.dev = &pdev->dev;
  1158	
  1159		imxdma->dma_device.device_alloc_chan_resources = imxdma_alloc_chan_resources;
  1160		imxdma->dma_device.device_free_chan_resources = imxdma_free_chan_resources;
  1161		imxdma->dma_device.device_tx_status = imxdma_tx_status;
  1162		imxdma->dma_device.device_prep_slave_sg = imxdma_prep_slave_sg;
  1163		imxdma->dma_device.device_prep_dma_cyclic = imxdma_prep_dma_cyclic;
  1164		imxdma->dma_device.device_prep_dma_memcpy = imxdma_prep_dma_memcpy;
  1165		imxdma->dma_device.device_prep_interleaved_dma = imxdma_prep_dma_interleaved;
  1166		imxdma->dma_device.device_config = imxdma_config;
  1167		imxdma->dma_device.device_terminate_all = imxdma_terminate_all;
  1168		imxdma->dma_device.device_issue_pending = imxdma_issue_pending;
  1169	
  1170		platform_set_drvdata(pdev, imxdma);
  1171	
  1172		imxdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
  1173		dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
  1174	
  1175		ret = dma_async_device_register(&imxdma->dma_device);
  1176		if (ret) {
  1177			dev_err(&pdev->dev, "unable to register\n");
  1178			goto disable_dma_ahb_clk;
  1179		}
  1180	
  1181		if (pdev->dev.of_node) {
  1182			ret = of_dma_controller_register(pdev->dev.of_node,
  1183					imxdma_xlate, imxdma);
  1184			if (ret) {
  1185				dev_err(&pdev->dev, "unable to register of_dma_controller\n");
  1186				goto err_of_dma_controller;
  1187			}
  1188		}
  1189	
  1190		return 0;
  1191	
  1192	err_of_dma_controller:
  1193		dma_async_device_unregister(&imxdma->dma_device);
  1194	disable_dma_ahb_clk:
  1195		clk_disable_unprepare(imxdma->dma_ahb);
  1196	disable_dma_ipg_clk:
  1197		clk_disable_unprepare(imxdma->dma_ipg);
  1198		return ret;
  1199	}
  1200	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9uHbOqZAh8bAMU1SxCu8WbZW6v8BDUnD0eETAgA=

--RnlQjJ0d97Da+TV1--
