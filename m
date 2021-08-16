Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55C13ECEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhHPHAZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:00:25 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38637 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhHPHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:00:24 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 320F84000B;
        Mon, 16 Aug 2021 06:59:52 +0000 (UTC)
Date:   Mon, 16 Aug 2021 08:59:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 6/8] i3c: master: svc: add runtime pm support
Message-ID: <20210816085950.014401a7@xps13>
In-Reply-To: <20210809063645.2289988-7-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
        <20210809063645.2289988-7-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Mon,  9 Aug 2021 14:36:43
+0800:

> Add runtime pm support to dynamically manage the clock.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> ---
> V4:
>  - error path emit_stop only used in svc_i3c_master_do_daa() for one time, so
>    remove it. Or it needs another goto command at the end of the function to
>    skip it and to go to rpm_out.
> V3:
>  - restore the error path of probe function
>  - enable runtime pm just before i3c module reset
> V2: New patch in V2.
> ---
>  drivers/i3c/master/svc-i3c-master.c | 154 ++++++++++++++++++++++++----
>  1 file changed, 135 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 2a96b217cc78..5939e0936697 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -17,7 +17,9 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  
>  /* Master Mode Registers */
>  #define SVC_I3C_MCONFIG      0x000
> @@ -119,6 +121,7 @@
>  #define   SVC_MDYNADDR_ADDR(x) FIELD_PREP(GENMASK(7, 1), (x))
>  
>  #define SVC_I3C_MAX_DEVS 32
> +#define SVC_I3C_PM_TIMEOUT_MS 1000
>  
>  /* This parameter depends on the implementation and may be tuned */
>  #define SVC_I3C_FIFO_SIZE 16
> @@ -480,10 +483,20 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
>  	int ret;
>  
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev,
> +			"<%s> cannot resume i3c bus master, err: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
>  	/* Timings derivation */
>  	fclk_rate = clk_get_rate(master->fclk);
> -	if (!fclk_rate)
> -		return -EINVAL;
> +	if (!fclk_rate) {
> +		ret = -EINVAL;
> +		goto rpm_out;
> +	}
>  
>  	fclk_period_ns = DIV_ROUND_UP(1000000000, fclk_rate);
>  
> @@ -527,7 +540,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  		odstop = 1;
>  		break;
>  	default:
> -		return -EINVAL;
> +		goto rpm_out;
>  	}
>  
>  	reg = SVC_I3C_MCONFIG_MASTER_EN |
> @@ -545,7 +558,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  	/* Master core's registration */
>  	ret = i3c_master_get_free_addr(m, 0);
>  	if (ret < 0)
> -		return ret;
> +		goto rpm_out;
>  
>  	info.dyn_addr = ret;
>  
> @@ -554,21 +567,35 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
>  
>  	ret = i3c_master_set_info(&master->base, &info);
>  	if (ret)
> -		return ret;
> +		goto rpm_out;
>  
>  	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
>  
> -	return 0;
> +rpm_out:
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +
> +	return ret;
>  }
>  
>  static void svc_i3c_master_bus_cleanup(struct i3c_master_controller *m)
>  {
>  	struct svc_i3c_master *master = to_svc_i3c_master(m);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return;
> +	}
>  
>  	svc_i3c_master_disable_interrupts(master);
>  
>  	/* Disable master */
>  	writel(0, master->regs + SVC_I3C_MCONFIG);
> +
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
>  }
>  
>  static int svc_i3c_master_reserve_slot(struct svc_i3c_master *master)
> @@ -867,31 +894,36 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
>  	unsigned int dev_nb;
>  	int ret, i;
>  
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return ret;
> +	}
> +
>  	spin_lock_irqsave(&master->xferqueue.lock, flags);
>  	ret = svc_i3c_master_do_daa_locked(master, addrs, &dev_nb);
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
> -	if (ret)
> -		goto emit_stop;
> +	if (ret) {
> +		svc_i3c_master_emit_stop(master);
> +		svc_i3c_master_clear_merrwarn(master);
> +		goto rpm_out;
> +	}
>  
>  	/* Register all devices who participated to the core */
>  	for (i = 0; i < dev_nb; i++) {
>  		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
>  		if (ret)
> -			return ret;
> +			goto rpm_out;
>  	}
>  
>  	/* Configure IBI auto-rules */
>  	ret = svc_i3c_update_ibirules(master);
> -	if (ret) {
> +	if (ret)
>  		dev_err(master->dev, "Cannot handle such a list of devices");
> -		return ret;
> -	}
>  
> -	return 0;
> -
> -emit_stop:
> -	svc_i3c_master_emit_stop(master);
> -	svc_i3c_master_clear_merrwarn(master);
> +rpm_out:
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
>  
>  	return ret;
>  }
> @@ -1058,6 +1090,12 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
>  	if (!xfer)
>  		return;
>  
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return;
> +	}
> +
>  	svc_i3c_master_clear_merrwarn(master);
>  	svc_i3c_master_flush_fifo(master);
>  
> @@ -1072,6 +1110,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
>  			break;
>  	}
>  
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +
>  	xfer->ret = ret;
>  	complete(&xfer->comp);
>  
> @@ -1348,6 +1389,14 @@ static void svc_i3c_master_free_ibi(struct i3c_dev_desc *dev)
>  static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  {
>  	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct svc_i3c_master *master = to_svc_i3c_master(m);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(master->dev);
> +	if (ret < 0) {
> +		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
> +		return ret;
> +	}
>  
>  	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
>  }
> @@ -1355,8 +1404,15 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
>  static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
>  {
>  	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct svc_i3c_master *master = to_svc_i3c_master(m);
> +	int ret;
>  
> -	return i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
> +	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
> +
> +	pm_runtime_mark_last_busy(master->dev);
> +	pm_runtime_put_autosuspend(master->dev);
> +
> +	return ret;
>  }
>  
>  static void svc_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
> @@ -1455,16 +1511,31 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, master);
>  
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	svc_i3c_master_reset(master);
>  
>  	/* Register the master */
>  	ret = i3c_master_register(&master->base, &pdev->dev,
>  				  &svc_i3c_master_ops, false);
>  	if (ret)
> -		goto err_disable_sclk;
> +		goto rpm_disable;
> +
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
>  
> +rpm_disable:
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  err_disable_sclk:
>  	clk_disable_unprepare(master->sclk);
>  
> @@ -1486,13 +1557,57 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
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

Can you create svc_i3c_master_prepare_clks() with the current content
of the above helper, then, use that from _runtime_resume() and _probe()
to avoid copying these lines?

With this change you can add my 

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

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
> @@ -1504,6 +1619,7 @@ static struct platform_driver svc_i3c_master = {
>  	.driver = {
>  		.name = "silvaco-i3c-master",
>  		.of_match_table = svc_i3c_master_of_match_tbl,
> +		.pm = &svc_i3c_pm_ops,
>  	},
>  };
>  module_platform_driver(svc_i3c_master);


Thanks,
Miquèl
