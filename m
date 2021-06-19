Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A455A3AD9B3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhFSK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:57:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:3545 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhFSK5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:57:31 -0400
IronPort-SDR: dX8WIhEAY/MtAANsbC+k2RxUdvT94isk1YFziDtVCpPK7V6JwGrWlcQJJH3K6soWWThhO+Q7SK
 y5MKE5MgiXUA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206484203"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="206484203"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 03:55:20 -0700
IronPort-SDR: shIIIg1/X9y9YzjyUD4diASIuTOccwffi+cXRobJIdn5PTiaDhYgW62q3GSmj5H/kfj4fRXWjk
 9a8+0jkpK1KQ==
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="443814730"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 03:55:15 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1luYd4-003nzI-M1; Sat, 19 Jun 2021 13:55:10 +0300
Date:   Sat, 19 Jun 2021 13:55:10 +0300
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
Message-ID: <YM3NDrgF3znR+/4z@smile.fi.intel.com>
References: <20210618195735.55933-1-yury.norov@gmail.com>
 <20210618195735.55933-4-yury.norov@gmail.com>
 <YM3L1kciMw7zqhUp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM3L1kciMw7zqhUp@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2021 at 01:49:58PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 18, 2021 at 12:57:35PM -0700, Yury Norov wrote:
> > A couple of kernel functions call for_each_*_bit_from() with start
> > bit equal to 0. Replace them with for_each_*_bit().
> > 
> > No functional changes, but might improve on readability.
> 
> ...
> 
> > --- a/drivers/hwmon/ltc2992.c
> > +++ b/drivers/hwmon/ltc2992.c
> > @@ -248,8 +248,7 @@ static int ltc2992_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
> >  
> >  	gpio_status = reg;
> >  
> > -	gpio_nr = 0;
> > -	for_each_set_bit_from(gpio_nr, mask, LTC2992_GPIO_NR) {
> > +	for_each_set_bit(gpio_nr, mask, LTC2992_GPIO_NR) {
> >  		if (test_bit(LTC2992_GPIO_BIT(gpio_nr), &gpio_status))
> >  			set_bit(gpio_nr, bits);
> >  	}
> 
> I would replace the entire loop by bitmap_replace() call.
> 
> Something like
> 	bitmap_replace(bits, bits, &gpio_status, mask, LTC2992_GPIO_NR);

Okay, it wouldn't work directly because it involves LTC2992_GPIO_BIT()
macro. So, it rather some kind of bitmap_remap().

-- 
With Best Regards,
Andy Shevchenko


