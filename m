Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB43B9D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGBIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:41:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhGBIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:41:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1628b9JU020313;
        Fri, 2 Jul 2021 08:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GCJNCAPE/C4HPBQlMd1xvmHi3MpVGgmCykVeGOLWUJY=;
 b=d5mUoFMmW+c53RKQDP7ClqRuys9hg5eap3mOJZNRZLMNpiNQUqYQNbuTvbH8TeGfqSSG
 5tO43KN7gJhxQStjNnf63CtMJHJSIWQMZtIqtLzXMxK47Tt6Y5CaovEZVs4+c3Ksoe9E
 gG03FDtDzNB6t3ZF7M4Xwvx38GH/ZQGI3HVOYIbmtS6XqkiayU1bCoMThxgphZlpCNIu
 MQFScC6/TTJO+rmWzYQs1Z8zh15mI0PfFBO/MxMg+c+EjZo2jjY6eB9fLAD3cGU7Agh5
 p7OOlpqMx9Rb68xjHF+K61pmSopILlvcC/s4qf3893qK+D8S+hP44jHLBh/7oP4Ex4qd bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq4yx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:38:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1628a4Li185724;
        Fri, 2 Jul 2021 08:38:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39dv2c9mp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:38:48 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1628clRf191627;
        Fri, 2 Jul 2021 08:38:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 39dv2c9mna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:38:47 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1628cjno012939;
        Fri, 2 Jul 2021 08:38:45 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jul 2021 01:38:44 -0700
Date:   Fri, 2 Jul 2021 11:38:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ansuel Smith <ansuelsmth@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/net/mdio/mdio-ipq8064.c:148 ipq8064_mdio_probe() warn:
 'base' not released on lines: 129,141.
Message-ID: <202107020352.XQTvqFIc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: gVC6Qtit2O3SLyisKsX_m9Pd2B7AHvNI
X-Proofpoint-GUID: gVC6Qtit2O3SLyisKsX_m9Pd2B7AHvNI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dbe69e43372212527abf48609aba7fc39a6daa27
commit: b097bea10215315e8ee17f88b4c1bbb521b1878c net: mdio: ipq8064: add regmap config to disable REGCACHE
config: i386-randconfig-m021-20210630 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/mdio/mdio-ipq8064.c:148 ipq8064_mdio_probe() warn: 'base' not released on lines: 129,141.

vim +/base +148 drivers/net/mdio/mdio-ipq8064.c

caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  110  static int
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  111  ipq8064_mdio_probe(struct platform_device *pdev)
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  112  {
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  113  	struct device_node *np = pdev->dev.of_node;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  114  	struct ipq8064_mdio *priv;
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  115  	struct resource res;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  116  	struct mii_bus *bus;
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  117  	void __iomem *base;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  118  	int ret;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  119  
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  120  	if (of_address_to_resource(np, 0, &res))
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  121  		return -ENOMEM;
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  122  
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  123  	base = ioremap(res.start, resource_size(&res));

Use devm_ioremap()

b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  124  	if (!base)
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  125  		return -ENOMEM;
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  126  
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  127  	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  128  	if (!bus)
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  129  		return -ENOMEM;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  130  
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  131  	bus->name = "ipq8064_mdio_bus";
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  132  	bus->read = ipq8064_mdio_read;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  133  	bus->write = ipq8064_mdio_write;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  134  	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(&pdev->dev));
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  135  	bus->parent = &pdev->dev;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  136  
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  137  	priv = bus->priv;
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  138  	priv->base = devm_regmap_init_mmio(&pdev->dev, base,
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  139  					   &ipq8064_mdio_regmap_config);
b097bea1021531 drivers/net/mdio/mdio-ipq8064.c Ansuel Smith 2021-05-14  140  	if (IS_ERR(priv->base))
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  141  		return PTR_ERR(priv->base);
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  142  
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  143  	ret = of_mdiobus_register(bus, np);
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  144  	if (ret)
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  145  		return ret;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  146  
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  147  	platform_set_drvdata(pdev, bus);
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04 @148  	return 0;
caaa71fac36ec8 drivers/net/phy/mdio-ipq8064.c  Ansuel Smith 2020-03-04  149  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

