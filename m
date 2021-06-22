Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2B3B0558
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhFVM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:59:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8124 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231236AbhFVM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:59:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MClR1P025456;
        Tue, 22 Jun 2021 12:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=S/uGZRhyFZsoHqz7LEjw9yEJBAGbkOOvywd3Z5k4yXk=;
 b=WJGoZGto1QZPVQ+aJ3iF7pGEJcrUqlgMrdr09bcoBtQe4U4VVpqzOW5kWrIVqwWCn7u8
 U3mxv9ER6e+vFbUXxBsE93pd+AtCN4d8tXnNABPY2GKr0mO547JYDvNz5jeUjoKxElIY
 c39/qUf+rzUU2Z8Ncznr5bB3XuyhBrZkeih5KqJhZEtD033JNvAaeZmQ8v3KlKbv0PSk
 8i0+lDHi0mUp/EJ7dkr7Un7L8HWyAX+VcsW5R+WQB9AdUp3K8lsB+LzSp85NgxCbZ8UL
 0mdUByv1eOgMVTscCfGQXsywTZn4JAx7zplMO8y1nU+2/qMJYQdcINfPTciaACD79nk1 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvu34x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 12:57:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MCpCor085082;
        Tue, 22 Jun 2021 12:57:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3995pw82r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 12:57:15 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15MCvFTK108628;
        Tue, 22 Jun 2021 12:57:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3995pw82qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 12:57:14 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15MCvBBV001407;
        Tue, 22 Jun 2021 12:57:11 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 05:57:10 -0700
Date:   Tue, 22 Jun 2021 15:57:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Neil Armstrong <narmstrong@baylibre.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c:393
 phy_meson_axg_mipi_dphy_probe() warn: 'priv->clk' not released on lines:
 386,393.
Message-ID: <202106222029.VUDexGpd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Qtqpvg3liO5u11lkG2A7wmtiwkZxMnWm
X-Proofpoint-GUID: Qtqpvg3liO5u11lkG2A7wmtiwkZxMnWm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a96bfed64c8986d6404e553f18203cae1f5ac7e6
commit: 76aefb221146dbe0de124f566329c76d5dcf118a phy: amlogic: Add AXG MIPI D-PHY driver
config: powerpc64-randconfig-m031-20210622 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c:393 phy_meson_axg_mipi_dphy_probe() warn: 'priv->clk' not released on lines: 386,393.

vim +393 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c

76aefb221146db Neil Armstrong 2020-11-16  333  static int phy_meson_axg_mipi_dphy_probe(struct platform_device *pdev)
76aefb221146db Neil Armstrong 2020-11-16  334  {
76aefb221146db Neil Armstrong 2020-11-16  335  	struct device *dev = &pdev->dev;
76aefb221146db Neil Armstrong 2020-11-16  336  	struct phy_provider *phy_provider;
76aefb221146db Neil Armstrong 2020-11-16  337  	struct resource *res;
76aefb221146db Neil Armstrong 2020-11-16  338  	struct phy_meson_axg_mipi_dphy_priv *priv;
76aefb221146db Neil Armstrong 2020-11-16  339  	struct phy *phy;
76aefb221146db Neil Armstrong 2020-11-16  340  	void __iomem *base;
76aefb221146db Neil Armstrong 2020-11-16  341  	int ret;
76aefb221146db Neil Armstrong 2020-11-16  342  
76aefb221146db Neil Armstrong 2020-11-16  343  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
76aefb221146db Neil Armstrong 2020-11-16  344  	if (!priv)
76aefb221146db Neil Armstrong 2020-11-16  345  		return -ENOMEM;
76aefb221146db Neil Armstrong 2020-11-16  346  
76aefb221146db Neil Armstrong 2020-11-16  347  	priv->dev = dev;
76aefb221146db Neil Armstrong 2020-11-16  348  	platform_set_drvdata(pdev, priv);
76aefb221146db Neil Armstrong 2020-11-16  349  
76aefb221146db Neil Armstrong 2020-11-16  350  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
76aefb221146db Neil Armstrong 2020-11-16  351  	base = devm_ioremap_resource(dev, res);
76aefb221146db Neil Armstrong 2020-11-16  352  	if (IS_ERR(base))
76aefb221146db Neil Armstrong 2020-11-16  353  		return PTR_ERR(base);
76aefb221146db Neil Armstrong 2020-11-16  354  
76aefb221146db Neil Armstrong 2020-11-16  355  	priv->regmap = devm_regmap_init_mmio(dev, base,
76aefb221146db Neil Armstrong 2020-11-16  356  					&phy_meson_axg_mipi_dphy_regmap_conf);
76aefb221146db Neil Armstrong 2020-11-16  357  	if (IS_ERR(priv->regmap))
76aefb221146db Neil Armstrong 2020-11-16  358  		return PTR_ERR(priv->regmap);
76aefb221146db Neil Armstrong 2020-11-16  359  
76aefb221146db Neil Armstrong 2020-11-16  360  	priv->clk = devm_clk_get(dev, "pclk");
76aefb221146db Neil Armstrong 2020-11-16  361  	if (IS_ERR(priv->clk))
76aefb221146db Neil Armstrong 2020-11-16  362  		return PTR_ERR(priv->clk);
76aefb221146db Neil Armstrong 2020-11-16  363  
76aefb221146db Neil Armstrong 2020-11-16  364  	priv->reset = devm_reset_control_get(dev, "phy");
76aefb221146db Neil Armstrong 2020-11-16  365  	if (IS_ERR(priv->reset))
76aefb221146db Neil Armstrong 2020-11-16  366  		return PTR_ERR(priv->reset);
76aefb221146db Neil Armstrong 2020-11-16  367  
76aefb221146db Neil Armstrong 2020-11-16  368  	priv->analog = devm_phy_get(dev, "analog");
76aefb221146db Neil Armstrong 2020-11-16  369  	if (IS_ERR(priv->analog))
76aefb221146db Neil Armstrong 2020-11-16  370  		return PTR_ERR(priv->analog);
76aefb221146db Neil Armstrong 2020-11-16  371  
76aefb221146db Neil Armstrong 2020-11-16  372  	ret = clk_prepare_enable(priv->clk);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Is this worth unwinding if we hit an error later on?  I doubt it really
matters.  #StaticCheckerProblems

76aefb221146db Neil Armstrong 2020-11-16  373  	if (ret)
76aefb221146db Neil Armstrong 2020-11-16  374  		return ret;
76aefb221146db Neil Armstrong 2020-11-16  375  
76aefb221146db Neil Armstrong 2020-11-16  376  	ret = reset_control_deassert(priv->reset);
76aefb221146db Neil Armstrong 2020-11-16  377  	if (ret)
76aefb221146db Neil Armstrong 2020-11-16  378  		return ret;
                                                        ^^^^^^^^^^

76aefb221146db Neil Armstrong 2020-11-16  379  
76aefb221146db Neil Armstrong 2020-11-16  380  	phy = devm_phy_create(dev, NULL, &phy_meson_axg_mipi_dphy_ops);
76aefb221146db Neil Armstrong 2020-11-16  381  	if (IS_ERR(phy)) {
76aefb221146db Neil Armstrong 2020-11-16  382  		ret = PTR_ERR(phy);
76aefb221146db Neil Armstrong 2020-11-16  383  		if (ret != -EPROBE_DEFER)
76aefb221146db Neil Armstrong 2020-11-16  384  			dev_err(dev, "failed to create PHY\n");
76aefb221146db Neil Armstrong 2020-11-16  385  
76aefb221146db Neil Armstrong 2020-11-16  386  		return ret;
76aefb221146db Neil Armstrong 2020-11-16  387  	}
76aefb221146db Neil Armstrong 2020-11-16  388  
76aefb221146db Neil Armstrong 2020-11-16  389  	phy_set_drvdata(phy, priv);
76aefb221146db Neil Armstrong 2020-11-16  390  
76aefb221146db Neil Armstrong 2020-11-16  391  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
76aefb221146db Neil Armstrong 2020-11-16  392  
76aefb221146db Neil Armstrong 2020-11-16 @393  	return PTR_ERR_OR_ZERO(phy_provider);
76aefb221146db Neil Armstrong 2020-11-16  394  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

