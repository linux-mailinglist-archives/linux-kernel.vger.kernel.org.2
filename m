Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4373442E45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:39:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:55667 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhKBMj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:39:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="212005621"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="212005621"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 05:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="489093829"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 05:36:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mht1J-0030RO-DB;
        Tue, 02 Nov 2021 14:36:05 +0200
Date:   Tue, 2 Nov 2021 14:36:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] string: uninline memcpy_and_pad
Message-ID: <YYEwtb31IYjbus1U@smile.fi.intel.com>
References: <20211102043024.449478-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102043024.449478-1-linux@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 09:30:24PM -0700, Guenter Roeck wrote:
> When building m68k:allmodconfig, recent versions of gcc generate the
> following error if the length of UTS_RELEASE is less than 8 bytes.
> 
> In function 'memcpy_and_pad',
>     inlined from 'nvmet_execute_disc_identify' at
>     	drivers/nvme/target/discovery.c:268:2:
> arch/m68k/include/asm/string.h:72:25: error:
> 	'__builtin_memcpy' reading 8 bytes from a region of size 7
> 
> Discussions around the problem suggest that this only happens if an
> architecture does not provide strlen(), if -ffreestanding is provided as
> compiler option, and if CONFIG_FORTIFY_SOURCE=n. All of this is the case
> for m68k. The exact reasons are unknown, but seem to be related to the
> ability of the compiler to evaluate the return value of strlen() and
> the resulting execution flow in memcpy_and_pad(). It would be possible
> to work around the problem by using sizeof(UTS_RELEASE) instead of
> strlen(UTS_RELEASE), but that would only postpone the problem until the
> function is called in a similar way. Uninline memcpy_and_pad() instead
> to solve the problem for good.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  include/linux/string.h | 19 ++-----------------
>  lib/string.c           | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 5e96d656be7a..d68097b4f600 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -262,23 +262,8 @@ void __write_overflow(void) __compiletime_error("detected write beyond size of o
>  #include <linux/fortify-string.h>
>  #endif
>  
> -/**
> - * memcpy_and_pad - Copy one buffer to another with padding
> - * @dest: Where to copy to
> - * @dest_len: The destination buffer size
> - * @src: Where to copy from
> - * @count: The number of bytes to copy
> - * @pad: Character to use for padding if space is left in destination.
> - */
> -static inline void memcpy_and_pad(void *dest, size_t dest_len,
> -				  const void *src, size_t count, int pad)
> -{
> -	if (dest_len > count) {
> -		memcpy(dest, src, count);
> -		memset(dest + count, pad,  dest_len - count);
> -	} else
> -		memcpy(dest, src, dest_len);
> -}
> +void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> +		    int pad);
>  
>  /**
>   * str_has_prefix - Test if a string has a given prefix
> diff --git a/lib/string.c b/lib/string.c
> index b2de45a581f4..ff13d6d77a05 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -1165,3 +1165,22 @@ void fortify_panic(const char *name)
>  	BUG();
>  }
>  EXPORT_SYMBOL(fortify_panic);
> +
> +/**
> + * memcpy_and_pad - Copy one buffer to another with padding
> + * @dest: Where to copy to
> + * @dest_len: The destination buffer size
> + * @src: Where to copy from
> + * @count: The number of bytes to copy
> + * @pad: Character to use for padding if space is left in destination.
> + */
> +void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> +		    int pad)
> +{
> +	if (dest_len > count) {
> +		memcpy(dest, src, count);
> +		memset(dest + count, pad,  dest_len - count);
> +	} else
> +		memcpy(dest, src, dest_len);
> +}
> +EXPORT_SYMBOL(memcpy_and_pad);
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


