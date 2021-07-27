Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFF3D748D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhG0Lsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:48:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:7460 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231822AbhG0Lsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:48:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="210535988"
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="210535988"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 04:48:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="498457132"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 04:48:48 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m8LZi-0016oq-7b; Tue, 27 Jul 2021 14:48:42 +0300
Date:   Tue, 27 Jul 2021 14:48:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH v1 1/1] bitmap.h: add const modifier to
 bitmap_next_[set/clear]_region() argument
Message-ID: <YP/ymvrd1zV7z6rF@smile.fi.intel.com>
References: <20210727094441.9815-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727094441.9815-1-andrea.merello@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:44:41AM +0200, Andrea Merello wrote:
> Those two functions don't modify the bitmap, so their bitmap argument
> should be const. This patch add this.

Constification is always a good thing. No objections from me,
although Yuri is doing something with them in one of his patch series.

Yuri, do you have a public repo / branch that people can base their changes to
bitmap stuff against of?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  include/linux/bitmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index a36cfcec4e77..ea4a8f1a2545 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -458,7 +458,7 @@ static inline void bitmap_replace(unsigned long *dst,
>  		__bitmap_replace(dst, old, new, mask, nbits);
>  }
>  
> -static inline void bitmap_next_clear_region(unsigned long *bitmap,
> +static inline void bitmap_next_clear_region(const unsigned long *bitmap,
>  					    unsigned int *rs, unsigned int *re,
>  					    unsigned int end)
>  {
> @@ -466,7 +466,7 @@ static inline void bitmap_next_clear_region(unsigned long *bitmap,
>  	*re = find_next_bit(bitmap, end, *rs + 1);
>  }
>  
> -static inline void bitmap_next_set_region(unsigned long *bitmap,
> +static inline void bitmap_next_set_region(const unsigned long *bitmap,
>  					  unsigned int *rs, unsigned int *re,
>  					  unsigned int end)
>  {
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


