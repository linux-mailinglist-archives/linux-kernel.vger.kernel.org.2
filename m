Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A4380383
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhENGFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:05:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58848 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhENGFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:05:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E5suTS012672;
        Fri, 14 May 2021 06:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5zsoaccx4ky+r+wBHL03V8CRmxxW8jJUfpknnAxp3mE=;
 b=pEpAXV/pVc7tiko5aWDTBEltv0X2or5z4sppqG4wYi1zHX2E/qh+CpbK1QXXCWmzGuBU
 mbxWTRnCwOln/66agkT+3d+2SU5iW6fQSmKuXsdyEdipTaLHLxTWnLXlS2txkR2TxAdO
 vVn7+h6XOBjzm/3uDw0SyljfvUWMHYT1GX4XMc2Ttil9yzyEzguPxVOlETzOsJ1kkrJS
 rmRirD+7EqjanhzaQpdAdQFngnEuxatX9wmGq4YiaKjXlxRq+4RslMOD2F0ndfKf6gOo
 yN3cwXwRZCWrsUt5V2XG+JorWs7r2Y57ozTySRKstQWLh4qUO/y3MFdnIuYK2Catyprb Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38gpnukdw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 06:04:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E5tooV027226;
        Fri, 14 May 2021 06:04:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38gpq2sbgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 06:04:29 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14E61Hxc040074;
        Fri, 14 May 2021 06:04:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38gpq2sbg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 06:04:28 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14E64MOQ009761;
        Fri, 14 May 2021 06:04:23 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 May 2021 23:04:22 -0700
Date:   Fri, 14 May 2021 09:04:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Neil Armstrong <narmstrong@baylibre.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c:393
 phy_meson_axg_mipi_dphy_probe() warn: 'priv->clk' not released on lines:
 386.
Message-ID: <202105140611.0pGD90Qg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: _SC9nsA3qTaUKHngX8pKMQfb8qoQIKR4
X-Proofpoint-GUID: _SC9nsA3qTaUKHngX8pKMQfb8qoQIKR4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   315d99318179b9cd5077ccc9f7f26a164c9fa998
commit: 76aefb221146dbe0de124f566329c76d5dcf118a phy: amlogic: Add AXG MIPI D-PHY driver
config: powerpc-randconfig-m031-20210513 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c:393 phy_meson_axg_mipi_dphy_probe() warn: 'priv->clk' not released on lines: 386.

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
76aefb221146db Neil Armstrong 2020-11-16  373  	if (ret)
76aefb221146db Neil Armstrong 2020-11-16  374  		return ret;
76aefb221146db Neil Armstrong 2020-11-16  375  
76aefb221146db Neil Armstrong 2020-11-16  376  	ret = reset_control_deassert(priv->reset);
76aefb221146db Neil Armstrong 2020-11-16  377  	if (ret)
76aefb221146db Neil Armstrong 2020-11-16  378  		return ret;
76aefb221146db Neil Armstrong 2020-11-16  379  
76aefb221146db Neil Armstrong 2020-11-16  380  	phy = devm_phy_create(dev, NULL, &phy_meson_axg_mipi_dphy_ops);
76aefb221146db Neil Armstrong 2020-11-16  381  	if (IS_ERR(phy)) {
76aefb221146db Neil Armstrong 2020-11-16  382  		ret = PTR_ERR(phy);
76aefb221146db Neil Armstrong 2020-11-16  383  		if (ret != -EPROBE_DEFER)
76aefb221146db Neil Armstrong 2020-11-16  384  			dev_err(dev, "failed to create PHY\n");
76aefb221146db Neil Armstrong 2020-11-16  385  
76aefb221146db Neil Armstrong 2020-11-16  386  		return ret;

Should we disable unprepare the clk?  I don't know, btw.  It seems like
a lot of people don't bother with that.

76aefb221146db Neil Armstrong 2020-11-16  387  	}
76aefb221146db Neil Armstrong 2020-11-16  388  
76aefb221146db Neil Armstrong 2020-11-16  389  	phy_set_drvdata(phy, priv);
76aefb221146db Neil Armstrong 2020-11-16  390  
76aefb221146db Neil Armstrong 2020-11-16  391  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);

Same if devm_of_phy_provider_register() fails I guess.

76aefb221146db Neil Armstrong 2020-11-16  392  
76aefb221146db Neil Armstrong 2020-11-16 @393  	return PTR_ERR_OR_ZERO(phy_provider);
76aefb221146db Neil Armstrong 2020-11-16  394  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

