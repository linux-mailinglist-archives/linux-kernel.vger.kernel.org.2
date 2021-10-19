Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25092433DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhJSRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJSRmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:42:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C59E161355;
        Tue, 19 Oct 2021 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634665238;
        bh=CmkDVF4O9DMzn3vmYEeic/chg5gWAxEK0NpetX5xAgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBo0vktcw0U8GURxAuDOJliOjqa1JqTXkSp2AFYLzOzqq5aWyeBYAQWsXBUCMTTog
         Rjq9ISOlFMfpojsmXmhCr3eT0lfjvDRksstB2U5F1ypuvPbYsVoH1O/88CERD5JNel
         lw1VE0P+X1JgIBkXzp/4FhhUS/sOQ21mL5SpYP5HnSpLfjK6fswf6mpZ3mpFsBz08a
         CqgqQlY/RD687qQySBFS5NSlqQOArudqL3fqxP7v98TDorukMUGGD53u7lmrl14ZzM
         ifkbYKlmUKhAxJC0UTNlgVVVvtFNJ19Dm4qPqopFgGUOeo56Rt3HpnBlaHPOyZcdCj
         jis2eLJr7WQOA==
Date:   Tue, 19 Oct 2021 10:40:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] regulator: lp872x: fix enum conversion warning
Message-ID: <YW8DEXD1bjW73coE@archlinux-ax161>
References: <20211019153851.509626-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019153851.509626-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 05:38:43PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns that the argument to devm_gpiod_get_optional()
> is the wrong type:
> 
> drivers/regulator/lp872x.c:689:57: error: implicit conversion from enumeration type 'enum lp872x_dvs_state' to different enumeration type 'enum gpiod_flags' [-Werror,-Wenum-conversion]
>         dvs->gpio = devm_gpiod_get_optional(lp->dev, "ti,dvs", pinstate);
>                     ~~~~~~~~~~~~~~~~~~~~~~~                    ^~~~~~~~
> 
> The enum value is specifcally chosen to be the same here, but
> the compiler only sees the mismatched types. This could be
> worked around using another ?: expression, but it seems easiest
> to replace the assignment with a macro.
> 
> Fixes: 72bf80cf09c4 ("regulator: lp872x: replacing legacy gpio interface for gpiod")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I sent basically the same patch but I also eliminated DSV_{LOW,HIGH}
in favor of the GPIOD flags outright:

https://lore.kernel.org/r/20211019004335.193492-1-nathan@kernel.org/

Either one works so I do not really care which one gets merged.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/regulator/lp872x.c       | 6 +++---
>  include/linux/regulator/lp872x.h | 8 +++-----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
> index 1dba5dbcd461..61412ebc8d8d 100644
> --- a/drivers/regulator/lp872x.c
> +++ b/drivers/regulator/lp872x.c
> @@ -103,7 +103,7 @@ struct lp872x {
>  	enum lp872x_id chipid;
>  	struct lp872x_platform_data *pdata;
>  	int num_regulators;
> -	enum lp872x_dvs_state dvs_pin;
> +	enum gpiod_flags dvs_pin;
>  };
>  
>  /* LP8720/LP8725 shared voltage table for LDOs */
> @@ -251,7 +251,7 @@ static int lp872x_regulator_enable_time(struct regulator_dev *rdev)
>  static void lp872x_set_dvs(struct lp872x *lp, enum lp872x_dvs_sel dvs_sel,
>  			struct gpio_desc *gpio)
>  {
> -	enum lp872x_dvs_state state;
> +	enum gpiod_flags state;
>  
>  	state = dvs_sel == SEL_V1 ? DVS_HIGH : DVS_LOW;
>  	gpiod_set_value(gpio, state);
> @@ -675,7 +675,7 @@ static const struct regulator_desc lp8725_regulator_desc[] = {
>  static int lp872x_init_dvs(struct lp872x *lp)
>  {
>  	struct lp872x_dvs *dvs = lp->pdata ? lp->pdata->dvs : NULL;
> -	enum lp872x_dvs_state pinstate;
> +	enum gpiod_flags pinstate;
>  	u8 mask[] = { LP8720_EXT_DVS_M, LP8725_DVS1_M | LP8725_DVS2_M };
>  	u8 default_dvs_mode[] = { LP8720_DEFAULT_DVS, LP8725_DEFAULT_DVS };
>  
> diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator/lp872x.h
> index 8e7e0343c6e1..5b94fe38fc78 100644
> --- a/include/linux/regulator/lp872x.h
> +++ b/include/linux/regulator/lp872x.h
> @@ -40,10 +40,8 @@ enum lp872x_regulator_id {
>  	LP872X_ID_MAX,
>  };
>  
> -enum lp872x_dvs_state {
> -	DVS_LOW  = GPIOD_OUT_LOW,
> -	DVS_HIGH = GPIOD_OUT_HIGH,
> -};
> +#define	DVS_LOW				GPIOD_OUT_LOW
> +#define	DVS_HIGH			GPIOD_OUT_HIGH
>  
>  enum lp872x_dvs_sel {
>  	SEL_V1,
> @@ -59,7 +57,7 @@ enum lp872x_dvs_sel {
>  struct lp872x_dvs {
>  	struct gpio_desc *gpio;
>  	enum lp872x_dvs_sel vsel;
> -	enum lp872x_dvs_state init_state;
> +	enum gpiod_flags init_state;
>  };
>  
>  /**
> -- 
> 2.29.2
> 
