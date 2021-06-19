Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030643AD9AE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhFSKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:53:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:27675 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232783AbhFSKxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:53:12 -0400
IronPort-SDR: neleyHUv0P0UpCfuQepCDBbOCWwZZfRRXoT3/WX8kA1H8EyaeVBDe2bUTNzN+nEZ6xOudMwVip
 MUA2BoDwBAaw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="267807102"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="267807102"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 03:51:01 -0700
IronPort-SDR: +Epd2JPzuQKVgIZ28P0AmJve4W21BtVRQil8JAZ4x25NaABZ5IMUN+kLfhxQCqkPHUVErydyTP
 YarFheC0k7yQ==
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="554979339"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 03:50:55 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1luYYs-003nwu-RM; Sat, 19 Jun 2021 13:50:50 +0300
Date:   Sat, 19 Jun 2021 13:50:50 +0300
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
Subject: Re: [PATCH 1/3] include/linux: move for_each_bit() macros from
 bitops.h to find.h
Message-ID: <YM3MCrveAlIa1TES@smile.fi.intel.com>
References: <20210618195735.55933-1-yury.norov@gmail.com>
 <20210618195735.55933-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618195735.55933-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:57:33PM -0700, Yury Norov wrote:
> for_each_bit() macros depend on find_bit() machinery, and so the
> proper place for them is the find.h header.

Fine with me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/bitops.h | 34 ----------------------------------
>  include/linux/find.h   | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 26bf15e6cd35..31ae1ae1a974 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -31,40 +31,6 @@ extern unsigned long __sw_hweight64(__u64 w);
>   */
>  #include <asm/bitops.h>
>  
> -#define for_each_set_bit(bit, addr, size) \
> -	for ((bit) = find_first_bit((addr), (size));		\
> -	     (bit) < (size);					\
> -	     (bit) = find_next_bit((addr), (size), (bit) + 1))
> -
> -/* same as for_each_set_bit() but use bit as value to start with */
> -#define for_each_set_bit_from(bit, addr, size) \
> -	for ((bit) = find_next_bit((addr), (size), (bit));	\
> -	     (bit) < (size);					\
> -	     (bit) = find_next_bit((addr), (size), (bit) + 1))
> -
> -#define for_each_clear_bit(bit, addr, size) \
> -	for ((bit) = find_first_zero_bit((addr), (size));	\
> -	     (bit) < (size);					\
> -	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
> -
> -/* same as for_each_clear_bit() but use bit as value to start with */
> -#define for_each_clear_bit_from(bit, addr, size) \
> -	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
> -	     (bit) < (size);					\
> -	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
> -
> -/**
> - * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
> - * @start: bit offset to start search and to store the current iteration offset
> - * @clump: location to store copy of current 8-bit clump
> - * @bits: bitmap address to base the search on
> - * @size: bitmap size in number of bits
> - */
> -#define for_each_set_clump8(start, clump, bits, size) \
> -	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> -	     (start) < (size); \
> -	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> -
>  static inline int get_bitmask_order(unsigned int count)
>  {
>  	int order;
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 6048f8c97418..4500e8ab93e2 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -279,4 +279,38 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>  #error "Please fix <asm/byteorder.h>"
>  #endif
>  
> +#define for_each_set_bit(bit, addr, size) \
> +	for ((bit) = find_first_bit((addr), (size));		\
> +	     (bit) < (size);					\
> +	     (bit) = find_next_bit((addr), (size), (bit) + 1))
> +
> +/* same as for_each_set_bit() but use bit as value to start with */
> +#define for_each_set_bit_from(bit, addr, size) \
> +	for ((bit) = find_next_bit((addr), (size), (bit));	\
> +	     (bit) < (size);					\
> +	     (bit) = find_next_bit((addr), (size), (bit) + 1))
> +
> +#define for_each_clear_bit(bit, addr, size) \
> +	for ((bit) = find_first_zero_bit((addr), (size));	\
> +	     (bit) < (size);					\
> +	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
> +
> +/* same as for_each_clear_bit() but use bit as value to start with */
> +#define for_each_clear_bit_from(bit, addr, size) \
> +	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
> +	     (bit) < (size);					\
> +	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
> +
> +/**
> + * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
> + * @start: bit offset to start search and to store the current iteration offset
> + * @clump: location to store copy of current 8-bit clump
> + * @bits: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + */
> +#define for_each_set_clump8(start, clump, bits, size) \
> +	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> +	     (start) < (size); \
> +	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> +
>  #endif /*__LINUX_FIND_H_ */
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


