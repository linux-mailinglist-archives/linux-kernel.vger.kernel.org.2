Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5C382BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhEQMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:21:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:50784 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhEQMVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:21:37 -0400
IronPort-SDR: WzfGpjvbEmMHun6JTw4CjbMIgC/jwlgwmoKyIKCVwtlwYNOwmuFsnLavhBDJvbDnNpnwMth7fv
 M+CRz0ZFaEEw==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="200140133"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200140133"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:20:20 -0700
IronPort-SDR: 6pnzSxpd+irkx6hVA8PLbHwm74+J0qIQ18rjOeX+k0cHfZJAB+31kAY9ovfxim6RRlP1I1FA+5
 AgnTt/u9x1ng==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="438897497"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:20:18 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1licEK-00CjRi-Dc; Mon, 17 May 2021 15:20:16 +0300
Date:   Mon, 17 May 2021 15:20:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/1] ata: Replace inclusion of kernel.h by bits.h in
 the header
Message-ID: <YKJfgDKetSV6OQxm@smile.fi.intel.com>
References: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 06:34:56PM +0300, Andy Shevchenko wrote:
> ata.h uses BIT() macro, hence bits.h must be included. Otherwise
> there is no need to have kernel.h included, I do not see any
> direct users of it in ata.h. Hence replace inclusion of kernel.h.

Jens, can we now apply this one?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: replaced kernel.h by bits.h (lkp), tested allmod/yesconfig on x86_64 (Jens)
>  include/linux/ata.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 6e67aded28f8..1b44f40c7700 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -13,7 +13,7 @@
>  #ifndef __LINUX_ATA_H__
>  #define __LINUX_ATA_H__
>  
> -#include <linux/kernel.h>
> +#include <linux/bits.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


