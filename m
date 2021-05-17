Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E4382BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbhEQMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:21:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:59408 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236959AbhEQMVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:21:10 -0400
IronPort-SDR: xUTosvTPsxTk8750q+NlvMbsxmZqgdHJxBp5ce/wSdYeiQyEWocwokpCrt9Wt0HqdBInFAureT
 EGb9M0juHzXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="221485515"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="221485515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:19:54 -0700
IronPort-SDR: q/zFyVzLXvK1icaN8gE3gFsrnTn7S7TJdPU2qKKyVxduJ2z7MnPya7Api0DC4igUXOz0SxSJQP
 PFYJ255XC/kg==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="540408297"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:19:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1licDt-00CjRQ-Md; Mon, 17 May 2021 15:19:49 +0300
Date:   Mon, 17 May 2021 15:19:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 1/1] drm/i915: Include only needed headers in ascii85.h
Message-ID: <YKJfZXn3P/ZdslRP@smile.fi.intel.com>
References: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:23:37PM +0300, Andy Shevchenko wrote:
> The ascii85.h is user of exactly two headers, i.e. math.h and types.h.
> There is no need to carry on entire kernel.h.

It seems DRM has strict rules about what's going thru DRM tree and this one,
while being used only for DRM drivers and been originated as i915 code, in a
stale position right now.

Who can take it, please? (It's Rb by Jani)

I Cc'ed this to Andrew, if he is okay to expedite it, and to Rob, who is the
committer of the original move patch.

Personally to me DRM seems the best match, but... see above.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/ascii85.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ascii85.h b/include/linux/ascii85.h
> index 4cc40201273e..83ad775ad0aa 100644
> --- a/include/linux/ascii85.h
> +++ b/include/linux/ascii85.h
> @@ -8,7 +8,8 @@
>  #ifndef _ASCII85_H_
>  #define _ASCII85_H_
>  
> -#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/types.h>
>  
>  #define ASCII85_BUFSZ 6
>  
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


