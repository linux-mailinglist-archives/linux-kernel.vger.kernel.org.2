Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB12380380
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 07:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhENGAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:00:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhENGAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:00:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E5t95T012762;
        Fri, 14 May 2021 05:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=hAZswfUEfe0XxcbqKW4RMdnSihiGrFQqCbZfZFWymmM=;
 b=Z+3rtVhhHLJXgEzchV75UEXcoklru9w2yr3KHvQhNyhS418eciEGw+znWTxztua2pMfB
 3ncpJ0f5yeDCHBKdALrldJiEEWMiqn6hufNanmkBgp5T20BmBSvMnizyMHLOq7TKpdUZ
 JgS9U9TgzTETAoFJxPrQLjVcS4ZHv2IpvccxP4ICB7RGvYA0PaddMPwqNl2AaORYxWgS
 0IXVUDIfvp4+2py651/l9fMDm0h87aDbxMAe8gpKY/mYRmhdgpyPWxoTiAmXgWoyMQs1
 ZScjJeDyL09q9pmHcWSedHpaaw35LcB/eQnMACbq1u79qbFXbtFRCPZ2izvCW3xBsMgw Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38gpnukdjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 05:59:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14E5sqZB153935;
        Fri, 14 May 2021 05:59:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38gppdd5vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 05:59:07 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14E5x6qS175067;
        Fri, 14 May 2021 05:59:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38gppdd5vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 05:59:06 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14E5x4vT009011;
        Fri, 14 May 2021 05:59:04 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 May 2021 22:59:03 -0700
Date:   Fri, 14 May 2021 08:58:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: drivers/phy/mediatek/phy-mtk-tphy.c:955 mtk_phy_init() warn:
 'instance->da_ref_clk' not released on lines: 952.
Message-ID: <202105140401.k3v4vTpW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: W1ePOJ0wBaoLvILGjFH0GbukE-zdiF3j
X-Proofpoint-GUID: W1ePOJ0wBaoLvILGjFH0GbukE-zdiF3j
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   adc12a7407b28c0f257227a508db83ab00911b74
commit: 133552bf03edbe3892767a4b64c56e3bed746374 phy: Remove CONFIG_ARCH_* check for related subdir in Makefile
config: powerpc-randconfig-m031-20210513 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/phy/mediatek/phy-mtk-tphy.c:955 mtk_phy_init() warn: 'instance->da_ref_clk' not released on lines: 952.
drivers/phy/mediatek/phy-mtk-tphy.c:955 mtk_phy_init() warn: 'instance->ref_clk' not released on lines: 952.

vim +955 drivers/phy/mediatek/phy-mtk-tphy.c

cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  917  static int mtk_phy_init(struct phy *phy)
dc7f190fd51f5c drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2015-09-29  918  {
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  919  	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  920  	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
dc7f190fd51f5c drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2015-09-29  921  	int ret;
dc7f190fd51f5c drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2015-09-29  922  
15de15c6b45b87 drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2017-03-31  923  	ret = clk_prepare_enable(instance->ref_clk);
15de15c6b45b87 drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2017-03-31  924  	if (ret) {
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  925  		dev_err(tphy->dev, "failed to enable ref_clk\n");
15de15c6b45b87 drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2017-03-31  926  		return ret;
15de15c6b45b87 drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2017-03-31  927  	}
15de15c6b45b87 drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2017-03-31  928  
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  929  	ret = clk_prepare_enable(instance->da_ref_clk);
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  930  	if (ret) {
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  931  		dev_err(tphy->dev, "failed to enable da_ref\n");
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  932  		clk_disable_unprepare(instance->ref_clk);
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  933  		return ret;
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  934  	}
12d0c0bed3f473 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2020-02-11  935  
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  936  	switch (instance->type) {
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  937  	case PHY_TYPE_USB2:
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  938  		u2_phy_instance_init(tphy, instance);
8158e917d91cb0 drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2018-06-29  939  		u2_phy_props_set(tphy, instance);
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  940  		break;
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  941  	case PHY_TYPE_USB3:
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  942  		u3_phy_instance_init(tphy, instance);
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  943  		break;
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  944  	case PHY_TYPE_PCIE:
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  945  		pcie_phy_instance_init(tphy, instance);
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  946  		break;
4ab26cb66a8cb3 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  947  	case PHY_TYPE_SATA:
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  948  		sata_phy_instance_init(tphy, instance);
4ab26cb66a8cb3 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  949  		break;
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  950  	default:
cd4ec4b03dc15b drivers/phy/mediatek/phy-mtk-tphy.c Chunfeng Yun 2017-08-03  951  		dev_err(tphy->dev, "incompatible PHY type\n");
44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  952  		return -EINVAL;

clk_disable_unprepare()?

44a6d6ce6436a2 drivers/phy/phy-mt65xx-usb3.c       Ryder Lee    2017-08-03  953  	}
04466efca58f69 drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2017-03-31  954  
dc7f190fd51f5c drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2015-09-29 @955  	return 0;
dc7f190fd51f5c drivers/phy/phy-mt65xx-usb3.c       Chunfeng Yun 2015-09-29  956  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

