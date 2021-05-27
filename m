Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27511392AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhE0Jdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:33:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39564 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbhE0Jda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:33:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14R9K4d8102959;
        Thu, 27 May 2021 09:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=xmmtTh9NAzb3KvzcT/9J42FKdrxOe6mwLDEj5kkQbvw=;
 b=ahE49E8P1tIo0c4mRRFx4dhzjZ8K3YuxKYjZ/iIRFXstdPERw1V4ALrzN/zUo/zKdQNV
 ks1pbK9GYYALh7JelQTji0ubhlx16ML1yl7S1F7EhmNpOyL2t1YR+WroIXnilBfiewwP
 S3rU1RXSEn6EcUxLg/+nGB3wtb9hCsqXtcFx+p3tpLRhz0gm7IyI5JwJ9i+EYf411J3F
 QT4R8HnFwPrDBwxpDfe/XYUizpB8wSozucqVAJMMsLsZAtzYqedLEpTXUTO5Lxe0/6W7
 kaApjuszjmKPtBubQ3FHDyA5pSBB3jWrEILDlURDl0m5vP5J8NYiuVm9pM0ZACoAwqWD pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38q3q933du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 09:31:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14R9LTWh098482;
        Thu, 27 May 2021 09:31:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38pq2w7s16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 09:31:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14R9RxP2111234;
        Thu, 27 May 2021 09:31:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38pq2w7s0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 09:31:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14R9Vp9x023294;
        Thu, 27 May 2021 09:31:51 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 May 2021 02:31:51 -0700
Date:   Thu, 27 May 2021 12:31:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn:
 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.
Message-ID: <202105271713.TLhpzN7N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: wFQorzRL-HC8qZhowWaRV-8teNUP9I4P
X-Proofpoint-ORIG-GUID: wFQorzRL-HC8qZhowWaRV-8teNUP9I4P
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d7c5303fbc8ac874ae3e597a5a0d3707dc0230b4
commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
config: s390-randconfig-m031-20210527 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn: 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.

vim +298 drivers/memory/fsl_ifc.c

cad5cef62a5a0c arch/powerpc/sysdev/fsl_ifc.c Greg Kroah-Hartman  2012-12-21  204  static int fsl_ifc_ctrl_probe(struct platform_device *dev)
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  205  {
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  206  	int ret = 0;
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  207  	int version, banks;
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  208  	void __iomem *addr;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  209  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  210  	dev_info(&dev->dev, "Freescale Integrated Flash Controller\n");
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  211  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  212  	fsl_ifc_ctrl_dev = kzalloc(sizeof(*fsl_ifc_ctrl_dev), GFP_KERNEL);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  213  	if (!fsl_ifc_ctrl_dev)
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  214  		return -ENOMEM;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  215  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  216  	dev_set_drvdata(&dev->dev, fsl_ifc_ctrl_dev);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  217  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  218  	/* IOMAP the entire IFC region */
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  219  	fsl_ifc_ctrl_dev->gregs = of_iomap(dev->dev.of_node, 0);
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  220  	if (!fsl_ifc_ctrl_dev->gregs) {
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  221  		dev_err(&dev->dev, "failed to get memory region\n");
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  222  		ret = -ENODEV;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  223  		goto err;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  224  	}
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  225  
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  226  	if (of_property_read_bool(dev->dev.of_node, "little-endian")) {
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  227  		fsl_ifc_ctrl_dev->little_endian = true;
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  228  		dev_dbg(&dev->dev, "IFC REGISTERS are LITTLE endian\n");
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  229  	} else {
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  230  		fsl_ifc_ctrl_dev->little_endian = false;
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  231  		dev_dbg(&dev->dev, "IFC REGISTERS are BIG endian\n");
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  232  	}
cf184dc2dd3384 drivers/memory/fsl_ifc.c      Jaiprakash Singh    2015-05-20  233  
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  234  	version = ifc_in32(&fsl_ifc_ctrl_dev->gregs->ifc_rev) &
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  235  			FSL_IFC_VERSION_MASK;
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  236  
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  237  	banks = (version == FSL_IFC_VERSION_1_0_0) ? 4 : 8;
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  238  	dev_info(&dev->dev, "IFC version %d.%d, %d banks\n",
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  239  		version >> 24, (version >> 16) & 0xf, banks);
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  240  
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  241  	fsl_ifc_ctrl_dev->version = version;
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  242  	fsl_ifc_ctrl_dev->banks = banks;
096916610f415e drivers/memory/fsl_ifc.c      Aaron Sierra        2014-08-26  243  
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  244  	addr = fsl_ifc_ctrl_dev->gregs;
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  245  	if (version >= FSL_IFC_VERSION_2_0_0)
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  246  		addr += PGOFFSET_64K;
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  247  	else
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  248  		addr += PGOFFSET_4K;
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  249  	fsl_ifc_ctrl_dev->rregs = addr;
7a654172161c8c drivers/memory/fsl_ifc.c      Raghav Dogra        2016-02-17  250  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  251  	/* get the Controller level irq */
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  252  	fsl_ifc_ctrl_dev->irq = irq_of_parse_and_map(dev->dev.of_node, 0);
ed4eeba7338bb1 drivers/memory/fsl_ifc.c      Raghav Dogra        2015-12-16  253  	if (fsl_ifc_ctrl_dev->irq == 0) {
a269ff3433f30d drivers/memory/fsl_ifc.c      Krzysztof Kozlowski 2020-07-24  254  		dev_err(&dev->dev, "failed to get irq resource for IFC\n");
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  255  		ret = -ENODEV;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  256  		goto err;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  257  	}
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  258  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  259  	/* get the nand machine irq */
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  260  	fsl_ifc_ctrl_dev->nand_irq =
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  261  			irq_of_parse_and_map(dev->dev.of_node, 1);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  262  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  263  	fsl_ifc_ctrl_dev->dev = &dev->dev;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  264  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  265  	ret = fsl_ifc_ctrl_init(fsl_ifc_ctrl_dev);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  266  	if (ret < 0)
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  267  		goto err;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  268  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  269  	init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  270  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  271  	ret = request_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_irq, IRQF_SHARED,
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  272  			  "fsl-ifc", fsl_ifc_ctrl_dev);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  273  	if (ret != 0) {
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  274  		dev_err(&dev->dev, "failed to install irq (%d)\n",
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  275  			fsl_ifc_ctrl_dev->irq);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  276  		goto err_irq;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  277  	}
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  278  
721c0705906e2b arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2012-09-13  279  	if (fsl_ifc_ctrl_dev->nand_irq) {
721c0705906e2b arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2012-09-13  280  		ret = request_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_nand_irq,
721c0705906e2b arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2012-09-13  281  				0, "fsl-ifc-nand", fsl_ifc_ctrl_dev);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  282  		if (ret != 0) {
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  283  			dev_err(&dev->dev, "failed to install irq (%d)\n",
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  284  				fsl_ifc_ctrl_dev->nand_irq);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  285  			goto err_nandirq;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  286  		}
721c0705906e2b arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2012-09-13  287  	}
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  288  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  289  	return 0;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  290  
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  291  err_nandirq:
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  292  	free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  293  	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  294  err_irq:
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  295  	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  296  	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  297  err:

Missing of_iounmap()

a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27 @298  	return ret;
a20cbdeffce247 arch/powerpc/sysdev/fsl_ifc.c Prabhakar Kushwaha  2011-12-27  299  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

