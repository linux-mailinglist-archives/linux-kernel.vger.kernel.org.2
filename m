Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8673817B2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhEOKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 06:41:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhEOKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 06:41:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAeH6h013002;
        Sat, 15 May 2021 10:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wgpDe72+bmkX8RQA6RHECjnfxaubTjVrB3X3YvYzXD8=;
 b=W6zKoJ6t0neBJgOfa2hcb7dW8cKpv51l5D50ohBtPlW0+Gs1zj8Cwx0zOmut2LPXP4aG
 cKNDiDpW3NqcDFXp2GeFQOUME0RR447AJDn04q1qc4DF4aFhgUijzUjLRv0lVSh8VPXG
 xoBc+4mszYoJB1EZZiB91FaQSZ/yr3L2siwpeycWnplUTJbIiaK/KoGWDFibhJuCLnU0
 b36bPyzRZakmJse8J7swU3qCEmUYOIg0qZki3/zEZ+KFpCcAdjsIE2kUl/eU0v8NNq/x
 oks33bh1/XkYqusElWAPi/0u/lQIsSsYE4f1ErQnpGhE33dX6Z7bJ/w2tq7dNDL1wldc zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38j6xn8a7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:40:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FAYtVB056535;
        Sat, 15 May 2021 10:40:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j641h9kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:40:16 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14FAeGfP074093;
        Sat, 15 May 2021 10:40:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38j641h9kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 10:40:16 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14FAe7IL017540;
        Sat, 15 May 2021 10:40:15 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 May 2021 03:40:06 -0700
Date:   Sat, 15 May 2021 13:40:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/nand/raw/intel-nand-controller.c:683 ebu_nand_probe()
 warn: 'ebu_host->clk' not released on lines: 644.
Message-ID: <202105150822.OE5z5WCY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: V4CWdC4SRoGd_HVRZgi2qCvgLA1b1Qss
X-Proofpoint-ORIG-GUID: V4CWdC4SRoGd_HVRZgi2qCvgLA1b1Qss
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105150075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25a1298726e97b9d25379986f5d54d9e62ad6e93
commit: 0b1039f016e8a37c779a4aee362cb2100ebb1cfd mtd: rawnand: Add NAND controller support on Intel LGM SoC
config: arm-randconfig-m031-20210515 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/mtd/nand/raw/intel-nand-controller.c:683 ebu_nand_probe() warn: 'ebu_host->clk' not released on lines: 644.

vim +683 drivers/mtd/nand/raw/intel-nand-controller.c

0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  577  static int ebu_nand_probe(struct platform_device *pdev)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  578  {
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  579  	struct device *dev = &pdev->dev;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  580  	struct ebu_nand_controller *ebu_host;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  581  	struct nand_chip *nand;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  582  	struct mtd_info *mtd = NULL;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  583  	struct resource *res;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  584  	char *resname;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  585  	int ret;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  586  	u32 cs;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  587  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  588  	ebu_host = devm_kzalloc(dev, sizeof(*ebu_host), GFP_KERNEL);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  589  	if (!ebu_host)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  590  		return -ENOMEM;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  591  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  592  	ebu_host->dev = dev;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  593  	nand_controller_init(&ebu_host->controller);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  594  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  595  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ebunand");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  596  	ebu_host->ebu = devm_ioremap_resource(&pdev->dev, res);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  597  	if (IS_ERR(ebu_host->ebu))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  598  		return PTR_ERR(ebu_host->ebu);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  599  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  600  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsnand");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  601  	ebu_host->hsnand = devm_ioremap_resource(&pdev->dev, res);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  602  	if (IS_ERR(ebu_host->hsnand))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  603  		return PTR_ERR(ebu_host->hsnand);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  604  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  605  	ret = device_property_read_u32(dev, "reg", &cs);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  606  	if (ret) {
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  607  		dev_err(dev, "failed to get chip select: %d\n", ret);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  608  		return ret;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  609  	}
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  610  	ebu_host->cs_num = cs;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  611  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  612  	resname = devm_kasprintf(dev, GFP_KERNEL, "nand_cs%d", cs);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  613  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, resname);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  614  	ebu_host->cs[cs].chipaddr = devm_ioremap_resource(dev, res);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  615  	ebu_host->cs[cs].nand_pa = res->start;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  616  	if (IS_ERR(ebu_host->cs[cs].chipaddr))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  617  		return PTR_ERR(ebu_host->cs[cs].chipaddr);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  618  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  619  	ebu_host->clk = devm_clk_get(dev, NULL);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  620  	if (IS_ERR(ebu_host->clk))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  621  		return dev_err_probe(dev, PTR_ERR(ebu_host->clk),
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  622  				     "failed to get clock\n");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  623  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  624  	ret = clk_prepare_enable(ebu_host->clk);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  625  	if (ret) {
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  626  		dev_err(dev, "failed to enable clock: %d\n", ret);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  627  		return ret;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  628  	}
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  629  	ebu_host->clk_rate = clk_get_rate(ebu_host->clk);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  630  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  631  	ebu_host->dma_tx = dma_request_chan(dev, "tx");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  632  	if (IS_ERR(ebu_host->dma_tx))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  633  		return dev_err_probe(dev, PTR_ERR(ebu_host->dma_tx),
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  634  				     "failed to request DMA tx chan!.\n");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  635  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  636  	ebu_host->dma_rx = dma_request_chan(dev, "rx");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  637  	if (IS_ERR(ebu_host->dma_rx))
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  638  		return dev_err_probe(dev, PTR_ERR(ebu_host->dma_rx),
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  639  				     "failed to request DMA rx chan!.\n");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  640  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  641  	resname = devm_kasprintf(dev, GFP_KERNEL, "addr_sel%d", cs);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  642  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, resname);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  643  	if (!res)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  644  		return -EINVAL;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  645  	ebu_host->cs[cs].addr_sel = res->start;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  646  	writel(ebu_host->cs[cs].addr_sel | EBU_ADDR_MASK(5) | EBU_ADDR_SEL_REGEN,
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  647  	       ebu_host->ebu + EBU_ADDR_SEL(cs));
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  648  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  649  	nand_set_flash_node(&ebu_host->chip, dev->of_node);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  650  	if (!mtd->name) {
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  651  		dev_err(ebu_host->dev, "NAND label property is mandatory\n");
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  652  		return -EINVAL;

goto to cleanup code?

0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  653  	}
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  654  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  655  	mtd = nand_to_mtd(&ebu_host->chip);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  656  	mtd->dev.parent = dev;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  657  	ebu_host->dev = dev;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  658  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  659  	platform_set_drvdata(pdev, ebu_host);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  660  	nand_set_controller_data(&ebu_host->chip, ebu_host);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  661  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  662  	nand = &ebu_host->chip;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  663  	nand->controller = &ebu_host->controller;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  664  	nand->controller->ops = &ebu_nand_controller_ops;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  665  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  666  	/* Scan to find existence of the device */
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  667  	ret = nand_scan(&ebu_host->chip, 1);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  668  	if (ret)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  669  		goto err_cleanup_dma;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  670  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  671  	ret = mtd_device_register(mtd, NULL, 0);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  672  	if (ret)
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  673  		goto err_clean_nand;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  674  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  675  	return 0;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  676  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  677  err_clean_nand:
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  678  	nand_cleanup(&ebu_host->chip);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  679  err_cleanup_dma:
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  680  	ebu_dma_cleanup(ebu_host);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  681  	clk_disable_unprepare(ebu_host->clk);
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  682  
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10 @683  	return ret;
0b1039f016e8a3 Ramuthevar Vadivel Murugan 2020-11-10  684  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

