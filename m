Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A963948A0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhE1WYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 18:24:22 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40559 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhE1WYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 18:24:21 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BBAE1200002;
        Fri, 28 May 2021 22:22:44 +0000 (UTC)
Date:   Sat, 29 May 2021 00:22:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: drivers/rtc/rtc-mxc_v2.c:361 mxc_rtc_probe() warn: 'pdata->clk'
 not released on lines: 341,354,361.
Message-ID: <YLFtNLS+6qVqgCgg@piout.net>
References: <202105252102.h5r94CF9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105252102.h5r94CF9-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 25/05/2021 16:16:15+0300, Dan Carpenter wrote:
> Hi Alexandre,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a050a6d2b7e80ca52b2f4141eaf3420d201b72b3
> commit: 0020868f2a7037e87d6b3b196526de2fb885830d rtc: mxc{,_v2}: enable COMPILE_TEST
> config: microblaze-randconfig-m031-20210525 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/rtc/rtc-mxc_v2.c:361 mxc_rtc_probe() warn: 'pdata->clk' not released on lines: 341,354,361.
> 
> vim +361 drivers/rtc/rtc-mxc_v2.c
> 
> 83c880f79e88cc Patrick Bruenn      2017-12-18  279  static int mxc_rtc_probe(struct platform_device *pdev)
> 83c880f79e88cc Patrick Bruenn      2017-12-18  280  {
> 83c880f79e88cc Patrick Bruenn      2017-12-18  281  	struct mxc_rtc_data *pdata;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  282  	void __iomem *ioaddr;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  283  	int ret = 0;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  284  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  285  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  286  	if (!pdata)
> 83c880f79e88cc Patrick Bruenn      2017-12-18  287  		return -ENOMEM;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  288  
> 874532cdeefefa Anson Huang         2019-07-17  289  	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  290  	if (IS_ERR(pdata->ioaddr))
> 83c880f79e88cc Patrick Bruenn      2017-12-18  291  		return PTR_ERR(pdata->ioaddr);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  292  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  293  	ioaddr = pdata->ioaddr;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  294  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  295  	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  296  	if (IS_ERR(pdata->clk)) {
> 83c880f79e88cc Patrick Bruenn      2017-12-18  297  		dev_err(&pdev->dev, "unable to get rtc clock!\n");
> 83c880f79e88cc Patrick Bruenn      2017-12-18  298  		return PTR_ERR(pdata->clk);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  299  	}
> 83c880f79e88cc Patrick Bruenn      2017-12-18  300  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  301  	spin_lock_init(&pdata->lock);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  302  	pdata->irq = platform_get_irq(pdev, 0);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  303  	if (pdata->irq < 0)
> 83c880f79e88cc Patrick Bruenn      2017-12-18  304  		return pdata->irq;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  305  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  306  	device_init_wakeup(&pdev->dev, 1);
> fbc5ee9a6955e6 Anson Huang         2019-04-11  307  	ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
> fbc5ee9a6955e6 Anson Huang         2019-04-11  308  	if (ret)
> fbc5ee9a6955e6 Anson Huang         2019-04-11  309  		dev_err(&pdev->dev, "failed to enable irq wake\n");
> 83c880f79e88cc Patrick Bruenn      2017-12-18  310  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  311  	ret = clk_prepare_enable(pdata->clk);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  312  	if (ret)
> 83c880f79e88cc Patrick Bruenn      2017-12-18  313  		return ret;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  314  	/* initialize glitch detect */
> 83c880f79e88cc Patrick Bruenn      2017-12-18  315  	writel(SRTC_LPPDR_INIT, ioaddr + SRTC_LPPDR);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  316  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  317  	/* clear lp interrupt status */
> 83c880f79e88cc Patrick Bruenn      2017-12-18  318  	writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  319  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  320  	/* move out of init state */
> 83c880f79e88cc Patrick Bruenn      2017-12-18  321  	writel((SRTC_LPCR_IE | SRTC_LPCR_NSA), ioaddr + SRTC_LPCR);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  322  	ret = mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_IES);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  323  	if (ret) {
> 83c880f79e88cc Patrick Bruenn      2017-12-18  324  		dev_err(&pdev->dev, "Timeout waiting for SRTC_LPSR_IES\n");
> 83c880f79e88cc Patrick Bruenn      2017-12-18  325  		clk_disable_unprepare(pdata->clk);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  326  		return ret;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  327  	}
> 83c880f79e88cc Patrick Bruenn      2017-12-18  328  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  329  	/* move out of non-valid state */
> 83c880f79e88cc Patrick Bruenn      2017-12-18  330  	writel((SRTC_LPCR_IE | SRTC_LPCR_NVE | SRTC_LPCR_NSA |
> 83c880f79e88cc Patrick Bruenn      2017-12-18  331  		SRTC_LPCR_EN_LP), ioaddr + SRTC_LPCR);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  332  	ret = mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_NVES);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  333  	if (ret) {
> 83c880f79e88cc Patrick Bruenn      2017-12-18  334  		dev_err(&pdev->dev, "Timeout waiting for SRTC_LPSR_NVES\n");
> 83c880f79e88cc Patrick Bruenn      2017-12-18  335  		clk_disable_unprepare(pdata->clk);
>                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 83c880f79e88cc Patrick Bruenn      2017-12-18  336  		return ret;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  337  	}
> 83c880f79e88cc Patrick Bruenn      2017-12-18  338  
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  339  	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  340  	if (IS_ERR(pdata->rtc))
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  341  		return PTR_ERR(pdata->rtc);
> 
> clk_disable_unprepare(pdata->clk);

That one needs to be fixed.

> 
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  342  
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  343  	pdata->rtc->ops = &mxc_rtc_ops;
> 95fbfa14b431d4 Alexandre Belloni   2018-05-19  344  	pdata->rtc->range_max = U32_MAX;
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  345  
> 83c880f79e88cc Patrick Bruenn      2017-12-18  346  	clk_disable(pdata->clk);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  347  	platform_set_drvdata(pdev, pdata);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  348  	ret =
> 83c880f79e88cc Patrick Bruenn      2017-12-18  349  	    devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt, 0,
> 83c880f79e88cc Patrick Bruenn      2017-12-18  350  			     pdev->name, &pdev->dev);
> 83c880f79e88cc Patrick Bruenn      2017-12-18  351  	if (ret < 0) {
> 83c880f79e88cc Patrick Bruenn      2017-12-18  352  		dev_err(&pdev->dev, "interrupt not available.\n");
> 83c880f79e88cc Patrick Bruenn      2017-12-18  353  		clk_unprepare(pdata->clk);
> 
> Should these be clk_disable_unprepare()?  I don't know.  Please tell
> me the rules on this if the warning is wrong.  I also haven't looked up
> exactly why this warning is displayed, I would have expected
> clk_unprepare() to silence it.

clk_unprepare here is right because there is an unconditional
clk_disable on line 346. I guess smatch needs to learn that clk_disable
followed by clk_unprepare is the same as clk_disable_unprepare and I
guess also for clk_prepare_enable/clk_prepare/clk_enable

> 
> 83c880f79e88cc Patrick Bruenn      2017-12-18  354  		return ret;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  355  	}
> 83c880f79e88cc Patrick Bruenn      2017-12-18  356  
> fdcfd854333be5 Bartosz Golaszewski 2020-11-09  357  	ret = devm_rtc_register_device(pdata->rtc);
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19  358  	if (ret < 0)
> 83c880f79e88cc Patrick Bruenn      2017-12-18  359  		clk_unprepare(pdata->clk);
> 
> Same.
> 

Ditto

> 83c880f79e88cc Patrick Bruenn      2017-12-18  360  
> 5490a1e018a4b4 Alexandre Belloni   2018-05-19 @361  	return ret;
> 83c880f79e88cc Patrick Bruenn      2017-12-18  362  }
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
