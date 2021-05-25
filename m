Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AED3901F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhEYNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:18:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44074 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233023AbhEYNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:18:06 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PDCCJ5012400;
        Tue, 25 May 2021 13:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XJAuq/OZuDtD7zY176Gtakirbi9h8vTGRw3NrLyKKAc=;
 b=K78kHnO/E4S4o6cHA3DKnCtEv5GaE38L6k6FpHFVykUE50aBZDvSl1VWe8qLxPAYIIeJ
 tMkAKsGzJZWQe9zVlhdOUacKrrF4AjuEerlcFopQSODvNZ7iWOmaLIGSV+bzp0+gDI1I
 eVd4rR65oQyRXQLPen7aJVKVOCFdBy/sc5U8e8OuHpgA0tN71tCzMiMRsl4WkzyoILxh
 QZN3lo5nZx7wql0YgT/Ig+lxVzvdd5JfZxTYVPZlP4AO0fJqtPUNZq3OtUlR4NtcwOq+
 n/i1n207AFSdegJdbU2m6JajeKdzDL+RXBl9iRE+cmlRuZ72WnHjRnlqr6QIIW5Q39F2 QQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38qxvxrpdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:16:30 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14PDGUI0165794;
        Tue, 25 May 2021 13:16:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38reh9uyvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:16:30 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14PDGTm5165686;
        Tue, 25 May 2021 13:16:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38reh9uytq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:16:29 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14PDGM4n007740;
        Tue, 25 May 2021 13:16:23 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 May 2021 06:16:22 -0700
Date:   Tue, 25 May 2021 16:16:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: drivers/rtc/rtc-mxc_v2.c:361 mxc_rtc_probe() warn: 'pdata->clk' not
 released on lines: 341,354,361.
Message-ID: <202105252102.h5r94CF9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 0-G2PBt5MgWOzirwLbYOKmZuqkxkd_tb
X-Proofpoint-ORIG-GUID: 0-G2PBt5MgWOzirwLbYOKmZuqkxkd_tb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a050a6d2b7e80ca52b2f4141eaf3420d201b72b3
commit: 0020868f2a7037e87d6b3b196526de2fb885830d rtc: mxc{,_v2}: enable COMPILE_TEST
config: microblaze-randconfig-m031-20210525 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/rtc/rtc-mxc_v2.c:361 mxc_rtc_probe() warn: 'pdata->clk' not released on lines: 341,354,361.

vim +361 drivers/rtc/rtc-mxc_v2.c

83c880f79e88cc Patrick Bruenn      2017-12-18  279  static int mxc_rtc_probe(struct platform_device *pdev)
83c880f79e88cc Patrick Bruenn      2017-12-18  280  {
83c880f79e88cc Patrick Bruenn      2017-12-18  281  	struct mxc_rtc_data *pdata;
83c880f79e88cc Patrick Bruenn      2017-12-18  282  	void __iomem *ioaddr;
83c880f79e88cc Patrick Bruenn      2017-12-18  283  	int ret = 0;
83c880f79e88cc Patrick Bruenn      2017-12-18  284  
83c880f79e88cc Patrick Bruenn      2017-12-18  285  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
83c880f79e88cc Patrick Bruenn      2017-12-18  286  	if (!pdata)
83c880f79e88cc Patrick Bruenn      2017-12-18  287  		return -ENOMEM;
83c880f79e88cc Patrick Bruenn      2017-12-18  288  
874532cdeefefa Anson Huang         2019-07-17  289  	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
83c880f79e88cc Patrick Bruenn      2017-12-18  290  	if (IS_ERR(pdata->ioaddr))
83c880f79e88cc Patrick Bruenn      2017-12-18  291  		return PTR_ERR(pdata->ioaddr);
83c880f79e88cc Patrick Bruenn      2017-12-18  292  
83c880f79e88cc Patrick Bruenn      2017-12-18  293  	ioaddr = pdata->ioaddr;
83c880f79e88cc Patrick Bruenn      2017-12-18  294  
83c880f79e88cc Patrick Bruenn      2017-12-18  295  	pdata->clk = devm_clk_get(&pdev->dev, NULL);
83c880f79e88cc Patrick Bruenn      2017-12-18  296  	if (IS_ERR(pdata->clk)) {
83c880f79e88cc Patrick Bruenn      2017-12-18  297  		dev_err(&pdev->dev, "unable to get rtc clock!\n");
83c880f79e88cc Patrick Bruenn      2017-12-18  298  		return PTR_ERR(pdata->clk);
83c880f79e88cc Patrick Bruenn      2017-12-18  299  	}
83c880f79e88cc Patrick Bruenn      2017-12-18  300  
83c880f79e88cc Patrick Bruenn      2017-12-18  301  	spin_lock_init(&pdata->lock);
83c880f79e88cc Patrick Bruenn      2017-12-18  302  	pdata->irq = platform_get_irq(pdev, 0);
83c880f79e88cc Patrick Bruenn      2017-12-18  303  	if (pdata->irq < 0)
83c880f79e88cc Patrick Bruenn      2017-12-18  304  		return pdata->irq;
83c880f79e88cc Patrick Bruenn      2017-12-18  305  
83c880f79e88cc Patrick Bruenn      2017-12-18  306  	device_init_wakeup(&pdev->dev, 1);
fbc5ee9a6955e6 Anson Huang         2019-04-11  307  	ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
fbc5ee9a6955e6 Anson Huang         2019-04-11  308  	if (ret)
fbc5ee9a6955e6 Anson Huang         2019-04-11  309  		dev_err(&pdev->dev, "failed to enable irq wake\n");
83c880f79e88cc Patrick Bruenn      2017-12-18  310  
83c880f79e88cc Patrick Bruenn      2017-12-18  311  	ret = clk_prepare_enable(pdata->clk);
83c880f79e88cc Patrick Bruenn      2017-12-18  312  	if (ret)
83c880f79e88cc Patrick Bruenn      2017-12-18  313  		return ret;
83c880f79e88cc Patrick Bruenn      2017-12-18  314  	/* initialize glitch detect */
83c880f79e88cc Patrick Bruenn      2017-12-18  315  	writel(SRTC_LPPDR_INIT, ioaddr + SRTC_LPPDR);
83c880f79e88cc Patrick Bruenn      2017-12-18  316  
83c880f79e88cc Patrick Bruenn      2017-12-18  317  	/* clear lp interrupt status */
83c880f79e88cc Patrick Bruenn      2017-12-18  318  	writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
83c880f79e88cc Patrick Bruenn      2017-12-18  319  
83c880f79e88cc Patrick Bruenn      2017-12-18  320  	/* move out of init state */
83c880f79e88cc Patrick Bruenn      2017-12-18  321  	writel((SRTC_LPCR_IE | SRTC_LPCR_NSA), ioaddr + SRTC_LPCR);
83c880f79e88cc Patrick Bruenn      2017-12-18  322  	ret = mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_IES);
83c880f79e88cc Patrick Bruenn      2017-12-18  323  	if (ret) {
83c880f79e88cc Patrick Bruenn      2017-12-18  324  		dev_err(&pdev->dev, "Timeout waiting for SRTC_LPSR_IES\n");
83c880f79e88cc Patrick Bruenn      2017-12-18  325  		clk_disable_unprepare(pdata->clk);
83c880f79e88cc Patrick Bruenn      2017-12-18  326  		return ret;
83c880f79e88cc Patrick Bruenn      2017-12-18  327  	}
83c880f79e88cc Patrick Bruenn      2017-12-18  328  
83c880f79e88cc Patrick Bruenn      2017-12-18  329  	/* move out of non-valid state */
83c880f79e88cc Patrick Bruenn      2017-12-18  330  	writel((SRTC_LPCR_IE | SRTC_LPCR_NVE | SRTC_LPCR_NSA |
83c880f79e88cc Patrick Bruenn      2017-12-18  331  		SRTC_LPCR_EN_LP), ioaddr + SRTC_LPCR);
83c880f79e88cc Patrick Bruenn      2017-12-18  332  	ret = mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_NVES);
83c880f79e88cc Patrick Bruenn      2017-12-18  333  	if (ret) {
83c880f79e88cc Patrick Bruenn      2017-12-18  334  		dev_err(&pdev->dev, "Timeout waiting for SRTC_LPSR_NVES\n");
83c880f79e88cc Patrick Bruenn      2017-12-18  335  		clk_disable_unprepare(pdata->clk);
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

83c880f79e88cc Patrick Bruenn      2017-12-18  336  		return ret;
83c880f79e88cc Patrick Bruenn      2017-12-18  337  	}
83c880f79e88cc Patrick Bruenn      2017-12-18  338  
5490a1e018a4b4 Alexandre Belloni   2018-05-19  339  	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
5490a1e018a4b4 Alexandre Belloni   2018-05-19  340  	if (IS_ERR(pdata->rtc))
5490a1e018a4b4 Alexandre Belloni   2018-05-19  341  		return PTR_ERR(pdata->rtc);

clk_disable_unprepare(pdata->clk);

5490a1e018a4b4 Alexandre Belloni   2018-05-19  342  
5490a1e018a4b4 Alexandre Belloni   2018-05-19  343  	pdata->rtc->ops = &mxc_rtc_ops;
95fbfa14b431d4 Alexandre Belloni   2018-05-19  344  	pdata->rtc->range_max = U32_MAX;
5490a1e018a4b4 Alexandre Belloni   2018-05-19  345  
83c880f79e88cc Patrick Bruenn      2017-12-18  346  	clk_disable(pdata->clk);
83c880f79e88cc Patrick Bruenn      2017-12-18  347  	platform_set_drvdata(pdev, pdata);
83c880f79e88cc Patrick Bruenn      2017-12-18  348  	ret =
83c880f79e88cc Patrick Bruenn      2017-12-18  349  	    devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt, 0,
83c880f79e88cc Patrick Bruenn      2017-12-18  350  			     pdev->name, &pdev->dev);
83c880f79e88cc Patrick Bruenn      2017-12-18  351  	if (ret < 0) {
83c880f79e88cc Patrick Bruenn      2017-12-18  352  		dev_err(&pdev->dev, "interrupt not available.\n");
83c880f79e88cc Patrick Bruenn      2017-12-18  353  		clk_unprepare(pdata->clk);

Should these be clk_disable_unprepare()?  I don't know.  Please tell
me the rules on this if the warning is wrong.  I also haven't looked up
exactly why this warning is displayed, I would have expected
clk_unprepare() to silence it.

83c880f79e88cc Patrick Bruenn      2017-12-18  354  		return ret;
83c880f79e88cc Patrick Bruenn      2017-12-18  355  	}
83c880f79e88cc Patrick Bruenn      2017-12-18  356  
fdcfd854333be5 Bartosz Golaszewski 2020-11-09  357  	ret = devm_rtc_register_device(pdata->rtc);
5490a1e018a4b4 Alexandre Belloni   2018-05-19  358  	if (ret < 0)
83c880f79e88cc Patrick Bruenn      2017-12-18  359  		clk_unprepare(pdata->clk);

Same.

83c880f79e88cc Patrick Bruenn      2017-12-18  360  
5490a1e018a4b4 Alexandre Belloni   2018-05-19 @361  	return ret;
83c880f79e88cc Patrick Bruenn      2017-12-18  362  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

