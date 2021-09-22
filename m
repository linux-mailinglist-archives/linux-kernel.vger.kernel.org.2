Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01962413F86
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhIVCjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhIVCjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D1D61184;
        Wed, 22 Sep 2021 02:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632278266;
        bh=VbdVnj2YHKrJ1F4mJdb4/092wxfGkS9kFWwgMIvJcow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAKNTFQ7fhi0qJgddSjilERZ65w4KRSyEeBVDrEnXsnQ8ZNoHpU+heZfpKraeB1xy
         MaI0DW1+HLdDFjRVmOjT8F7XAJhe27r6Ef0tc+dlq8oNS1FeQpI9Lh7tmDDxc/p1m0
         IpmDEZIuDGuu7zFXnrqbIB5sohHZg5ZaNb0kPvr0DgZBZO9G6pomyYh5hmHl4EL4aJ
         725KCD+cCjAVz63sL1Sp5JJkQoThgLD9X3/m8AudyxAkrTVHh33F08WliP29uORn0m
         JVkFhMIL016YU2MngZheXkdMJxoh0sb1R5yrOfIZwqY5Ulm8JVCDI1AYb3NK6a+gsR
         HJZHAkUd39ktg==
Date:   Wed, 22 Sep 2021 10:37:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com
Subject: Re: [PATCH v2] ARM: imx6: mask all interrupts before calling
 stby-poweroff sequence
Message-ID: <20210922023740.GD10217@dragon>
References: <20210817122500.31953-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817122500.31953-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 02:25:00PM +0200, Oleksij Rempel wrote:
> Any pending interrupt can prevent entering standby based power off state.
> To avoid it, mask all interrupts.
> 
> Fixes: 8148d2136002 ("ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/mach-imx/pm-imx6.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index 9244437cb1b9..63887ade411a 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -59,8 +59,11 @@
>  #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
>  #define MX6_MAX_MMDC_IO_NUM		33
>  
> +#define GIC_DIST_ENABLE_CLEAR		0x180
> +
>  static void __iomem *ccm_base;
>  static void __iomem *suspend_ocram_base;
> +static void __iomem *gic_raw_dist_base;
>  static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
>  
>  /*
> @@ -592,6 +595,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
>  static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>  					*socdata)
>  {
> +	struct device_node *np;
>  	struct regmap *gpr;
>  	int ret;
>  
> @@ -615,10 +619,29 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
>  	if (!IS_ERR(gpr))
>  		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,
>  				   IMX6Q_GPR1_GINT);
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
> +	gic_raw_dist_base = of_iomap(np, 0);
> +}
> +
> +static void imx_gic_mask_all(void)
> +{
> +	int i;
> +
> +	if (WARN_ON(!gic_raw_dist_base))
> +		return;
> +
> +	for (i = 0; i < 4; i++)
> +		writel_relaxed(~0, gic_raw_dist_base + GIC_DIST_ENABLE_CLEAR + 4 * i);

Is it possible to have a helper function in GIC driver, that we can
simply call into?

Shawn

>  }
>  
>  static void imx6_pm_stby_poweroff(void)
>  {
> +	/*
> +	 * A pending interrupt can prevent power off signal to be activated.
> +	 * So, mask all interrupts to avoid it.
> +	 */
> +	imx_gic_mask_all();
>  	imx6_set_lpm(STOP_POWER_OFF);
>  	imx6q_suspend_finish(0);
>  
> -- 
> 2.30.2
> 
