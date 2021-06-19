Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABD3AD9A8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhFSKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:52:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhFSKwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:52:19 -0400
IronPort-SDR: 4vrjSwFiE45UJoS+V324bGl1jppXjSuTjyWVIFSZGHhxvXWPv7X+xJXpjb2/5IozMmEtnRCoe9
 hTQu092OUAig==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206612084"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="206612084"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 03:50:07 -0700
IronPort-SDR: o8DFUIQ+V+2TuG58ZEr4r3C8CkDGqWu2uw95vEN7oxLjJ8oaxloSWHsXFVzcWwtJJIbqrt7cig
 dDphpiQ2jjXw==
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="622629219"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 03:50:02 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1luYY2-003nwB-1Z; Sat, 19 Jun 2021 13:49:58 +0300
Date:   Sat, 19 Jun 2021 13:49:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] Replace for_each_*_bit_from() with for_each_*_bit()
 where appropriate
Message-ID: <YM3L1kciMw7zqhUp@smile.fi.intel.com>
References: <20210618195735.55933-1-yury.norov@gmail.com>
 <20210618195735.55933-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618195735.55933-4-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:57:35PM -0700, Yury Norov wrote:
> A couple of kernel functions call for_each_*_bit_from() with start
> bit equal to 0. Replace them with for_each_*_bit().
> 
> No functional changes, but might improve on readability.

...

> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -248,8 +248,7 @@ static int ltc2992_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
>  
>  	gpio_status = reg;
>  
> -	gpio_nr = 0;
> -	for_each_set_bit_from(gpio_nr, mask, LTC2992_GPIO_NR) {
> +	for_each_set_bit(gpio_nr, mask, LTC2992_GPIO_NR) {
>  		if (test_bit(LTC2992_GPIO_BIT(gpio_nr), &gpio_status))
>  			set_bit(gpio_nr, bits);
>  	}

I would replace the entire loop by bitmap_replace() call.

Something like
	bitmap_replace(bits, bits, &gpio_status, mask, LTC2992_GPIO_NR);

(Good to split sometimes :-)

-- 
With Best Regards,
Andy Shevchenko


