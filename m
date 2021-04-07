Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6149E356C7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352363AbhDGMq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:46:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:3067 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235035AbhDGMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:46:56 -0400
IronPort-SDR: dEqmLSK0N9cznX5fL/uO3CIp+F433jR7OhgbUBvIo7h3VrMUGyg7Xq3DNxjmet2ycR+oh9HDtK
 DBaYBLhywqmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="213688637"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="213688637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 05:46:45 -0700
IronPort-SDR: WnUqqWXZL7oCyhW0EIInumpJdSfewC5ZnwxSWTxF1srzHQgl/wlwEVB4Kh7Jasr13leAQjiV4B
 JfixiK8CSWug==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="415256731"
Received: from shochwel-mobl.ger.corp.intel.com (HELO localhost) ([10.249.33.133])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 05:46:42 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 1/1] drm/i915: Include only needed headers in ascii85.h
In-Reply-To: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
Date:   Wed, 07 Apr 2021 15:46:37 +0300
Message-ID: <87h7kijm8i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> The ascii85.h is user of exactly two headers, i.e. math.h and types.h.
> There is no need to carry on entire kernel.h.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

That's hardly drm/i915 specific!

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

But who's going to pick it up and, hopefully, change the subject prefix
to ascii85 or something?

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

-- 
Jani Nikula, Intel Open Source Graphics Center
