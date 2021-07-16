Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B573CB3B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhGPIC7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jul 2021 04:02:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60603 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhGPIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:02:56 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 23726C0007;
        Fri, 16 Jul 2021 07:59:59 +0000 (UTC)
Date:   Fri, 16 Jul 2021 09:59:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/5] i3c: master: svc: add runtime pm support
Message-ID: <20210716095958.4e27d574@xps13>
In-Reply-To: <20210716073723.3490180-6-xiaoning.wang@nxp.com>
References: <20210716073723.3490180-1-xiaoning.wang@nxp.com>
        <20210716073723.3490180-6-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,


> @@ -1431,7 +1502,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  					 GFP_KERNEL);
>  	if (!master->ibi.slots) {
>  		ret = -ENOMEM;
> -		goto err_disable_sclk;
> +		goto rpm_disable;
>  	}
>  
>  	platform_set_drvdata(pdev, master);
> @@ -1442,18 +1513,17 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &svc_i3c_master_ops, false);
>  	if (ret)
> -		goto err_disable_sclk;
> +		goto rpm_disable;
>  
> -	return 0;
> -
> -err_disable_sclk:
> -	clk_disable_unprepare(master->sclk);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);
>  
> -err_disable_fclk:
> -	clk_disable_unprepare(master->fclk);
> +	return 0;
>  
> -err_disable_pclk:
> -	clk_disable_unprepare(master->pclk);

It's not clear to me why you drop the disable_*clk labels to move them
back in place? I would rather prefer to keep a clean error path.

> +rpm_disable:
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  
>  	return ret;
>  }
> @@ -1467,13 +1537,57 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
> +{
> +	struct svc_i3c_master *master = dev_get_drvdata(dev);
> +
>  	clk_disable_unprepare(master->pclk);
>  	clk_disable_unprepare(master->fclk);
>  	clk_disable_unprepare(master->sclk);
> +	pinctrl_pm_select_sleep_state(dev);
>  
>  	return 0;
>  }
>  
> +static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
> +{
> +	struct svc_i3c_master *master = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	pinctrl_pm_select_default_state(dev);
> +	ret = clk_prepare_enable(master->pclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(master->fclk);
> +	if (ret) {
> +		clk_disable_unprepare(master->pclk);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(master->sclk);
> +	if (ret) {
> +		clk_disable_unprepare(master->pclk);
> +		clk_disable_unprepare(master->fclk);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops svc_i3c_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				      pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(svc_i3c_runtime_suspend,
> +			   svc_i3c_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>  	{ .compatible = "silvaco,i3c-master" },
>  	{ /* sentinel */ },
> @@ -1485,6 +1599,7 @@ static struct platform_driver svc_i3c_master = {
>  	.driver = {
>  		.name = "silvaco-i3c-master",
>  		.of_match_table = svc_i3c_master_of_match_tbl,
> +		.pm = &svc_i3c_pm_ops,
>  	},
>  };
>  module_platform_driver(svc_i3c_master);

Thanks,
Miquèl
