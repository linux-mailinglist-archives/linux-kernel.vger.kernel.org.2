Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA332BBEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358932AbhCCNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:18:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:62141 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357077AbhCCIR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:17:26 -0500
IronPort-SDR: PQULdhaIckK/7t69uRbc68UNTb5FwiduS4t7Kcgp0PvHlxaeXIay/ugR6if1TdQ6M3GoJFe7VF
 YvOeczNcYN9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="272136727"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="272136727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:15:30 -0800
IronPort-SDR: Jl1gDOt18Yx3Wc3FOkcfIFLNuc3RejNsIXAn65v97ohTHqhTMI8M/7DjMCF88L5gQLcyzhIZ1W
 ZKMMVTPRr2mQ==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383900135"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:15:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHMfD-009afi-Vm; Wed, 03 Mar 2021 10:15:23 +0200
Date:   Wed, 3 Mar 2021 10:15:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: Revert "Constify static struct resource"
Message-ID: <YD9Fm2qOf7ABYjZK@smile.fi.intel.com>
References: <20210302234710.74455-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302234710.74455-1-rikard.falkeborn@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 12:47:10AM +0100, Rikard Falkeborn wrote:
> Andy noted that constification of some static resource structs in

(If you wish, you may use Reported-by:, I'm fine with either way)

> intel_quark_i2c_gpio.c were incorrect. It turns out there is another
> change from the same series that is also incorrect in stmpe.c.
> These structures are modified at init and can not be made const.
> 
> This reverts commit 8d7b3a6dac4eae22c58b0853696cbd256966741b.

I recommend to add a comment in the code as I did so nobody (okay, who reads
the comments) will change that again.

Thanks!

> Fixes: 8d7b3a6dac4e ("mfd: stmpe: Constify static struct resource")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> I went through the series and this was the only additional issue I
> found. Sorry about that.
> 
>  drivers/mfd/stmpe.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 90f3292230c9..1aee3b3253fc 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -312,7 +312,7 @@ EXPORT_SYMBOL_GPL(stmpe_set_altfunc);
>   * GPIO (all variants)
>   */
>  
> -static const struct resource stmpe_gpio_resources[] = {
> +static struct resource stmpe_gpio_resources[] = {
>  	/* Start and end filled dynamically */
>  	{
>  		.flags	= IORESOURCE_IRQ,
> @@ -336,7 +336,7 @@ static const struct mfd_cell stmpe_gpio_cell_noirq = {
>   * Keypad (1601, 2401, 2403)
>   */
>  
> -static const struct resource stmpe_keypad_resources[] = {
> +static struct resource stmpe_keypad_resources[] = {
>  	{
>  		.name	= "KEYPAD",
>  		.flags	= IORESOURCE_IRQ,
> @@ -357,7 +357,7 @@ static const struct mfd_cell stmpe_keypad_cell = {
>  /*
>   * PWM (1601, 2401, 2403)
>   */
> -static const struct resource stmpe_pwm_resources[] = {
> +static struct resource stmpe_pwm_resources[] = {
>  	{
>  		.name	= "PWM0",
>  		.flags	= IORESOURCE_IRQ,
> @@ -445,7 +445,7 @@ static struct stmpe_variant_info stmpe801_noirq = {
>   * Touchscreen (STMPE811 or STMPE610)
>   */
>  
> -static const struct resource stmpe_ts_resources[] = {
> +static struct resource stmpe_ts_resources[] = {
>  	{
>  		.name	= "TOUCH_DET",
>  		.flags	= IORESOURCE_IRQ,
> @@ -467,7 +467,7 @@ static const struct mfd_cell stmpe_ts_cell = {
>   * ADC (STMPE811)
>   */
>  
> -static const struct resource stmpe_adc_resources[] = {
> +static struct resource stmpe_adc_resources[] = {
>  	{
>  		.name	= "STMPE_TEMP_SENS",
>  		.flags	= IORESOURCE_IRQ,
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


