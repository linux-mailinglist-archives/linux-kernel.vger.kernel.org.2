Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC132E60E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCEKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:19:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:35166 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhCEKSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:18:37 -0500
IronPort-SDR: L/1vhPBaTYb9Q5iBNT4bIZJu+WwqvS7AAIZieZIWRlFFlwMRfK1bPQK1ETiSoiWznvnGHktqOy
 GotTFuTv+PPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="175246151"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="175246151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 02:18:36 -0800
IronPort-SDR: WWc9C3FxVSf9WalrZTEPUKZssB4unKhpo9fXKPA2/ab2PH4KOwIAqukM+KCAiTat61SUL21f7g
 WLK58LpPz8kQ==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="507951556"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 02:18:34 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lI7XU-00A60q-40; Fri, 05 Mar 2021 12:18:32 +0200
Date:   Fri, 5 Mar 2021 12:18:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: stmpe: Revert "Constify static struct resource"
Message-ID: <YEIFeJQvyyYRYm+W@smile.fi.intel.com>
References: <20210304230709.3217-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304230709.3217-1-rikard.falkeborn@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 12:07:09AM +0100, Rikard Falkeborn wrote:
> In stmpe_devices_init(), the start and end field of these structs are
> modified, so they can not be const. Add a comment to those structs that
> lacked it to reduce the risk that this happens again.
> 
> This reverts commit 8d7b3a6dac4eae22c58b0853696cbd256966741b.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 8d7b3a6dac4e ("mfd: stmpe: Constify static struct resource")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Changes
> V1-V2: Add comments to the structs that they are dynamically modified
>        Rewrite commit message.
> 
> V1: https://lore.kernel.org/lkml/20210302234710.74455-1-rikard.falkeborn@gmail.com/
> 
>  drivers/mfd/stmpe.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 90f3292230c9..1dd39483e7c1 100644
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
> @@ -336,7 +336,8 @@ static const struct mfd_cell stmpe_gpio_cell_noirq = {
>   * Keypad (1601, 2401, 2403)
>   */
>  
> -static const struct resource stmpe_keypad_resources[] = {
> +static struct resource stmpe_keypad_resources[] = {
> +	/* Start and end filled dynamically */
>  	{
>  		.name	= "KEYPAD",
>  		.flags	= IORESOURCE_IRQ,
> @@ -357,7 +358,8 @@ static const struct mfd_cell stmpe_keypad_cell = {
>  /*
>   * PWM (1601, 2401, 2403)
>   */
> -static const struct resource stmpe_pwm_resources[] = {
> +static struct resource stmpe_pwm_resources[] = {
> +	/* Start and end filled dynamically */
>  	{
>  		.name	= "PWM0",
>  		.flags	= IORESOURCE_IRQ,
> @@ -445,7 +447,8 @@ static struct stmpe_variant_info stmpe801_noirq = {
>   * Touchscreen (STMPE811 or STMPE610)
>   */
>  
> -static const struct resource stmpe_ts_resources[] = {
> +static struct resource stmpe_ts_resources[] = {
> +	/* Start and end filled dynamically */
>  	{
>  		.name	= "TOUCH_DET",
>  		.flags	= IORESOURCE_IRQ,
> @@ -467,7 +470,8 @@ static const struct mfd_cell stmpe_ts_cell = {
>   * ADC (STMPE811)
>   */
>  
> -static const struct resource stmpe_adc_resources[] = {
> +static struct resource stmpe_adc_resources[] = {
> +	/* Start and end filled dynamically */
>  	{
>  		.name	= "STMPE_TEMP_SENS",
>  		.flags	= IORESOURCE_IRQ,
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


