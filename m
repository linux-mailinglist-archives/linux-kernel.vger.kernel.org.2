Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583FB433232
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhJSJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:28:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:3071 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234519AbhJSJ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:28:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="208568821"
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="208568821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 02:26:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,384,1624345200"; 
   d="scan'208";a="574104083"
Received: from cdonoghx-mobl1.ger.corp.intel.com (HELO [10.213.194.99]) ([10.213.194.99])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 02:26:39 -0700
Subject: Re: [PATCH] remove duplicate include in mock_region.c
To:     cgel.zte@gmail.com, jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch,
        thomas.hellstrom@linux.intel.com, chris@chris-wilson.co.uk,
        maarten.lankhorst@linux.intel.com, ran.jianping@zte.com.cn,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211019090205.1003458-1-ran.jianping@zte.com.cn>
From:   Matthew Auld <matthew.auld@intel.com>
Message-ID: <130dcbfd-ee6d-0d9a-602f-1aaca1229099@intel.com>
Date:   Tue, 19 Oct 2021 10:26:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211019090205.1003458-1-ran.jianping@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 10:02, cgel.zte@gmail.com wrote:
> From: Ran Jianping <ran.jianping@zte.com.cn>
> 
> 'drm/ttm/ttm_placement.h' included in
> 'drivers/gpu/drm/i915/selftests/mock_region.c' is duplicated.
> It is also included on the 9 line.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>

Commit tile should ideally be prefixed with 'drm/i915:'.

Can fix up when pushing though. Thanks,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/i915/selftests/mock_region.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/mock_region.c b/drivers/gpu/drm/i915/selftests/mock_region.c
> index efa86dffe3c6..75793008c4ef 100644
> --- a/drivers/gpu/drm/i915/selftests/mock_region.c
> +++ b/drivers/gpu/drm/i915/selftests/mock_region.c
> @@ -6,8 +6,6 @@
>   #include <drm/ttm/ttm_placement.h>
>   #include <linux/scatterlist.h>
>   
> -#include <drm/ttm/ttm_placement.h>
> -
>   #include "gem/i915_gem_region.h"
>   #include "intel_memory_region.h"
>   #include "intel_region_ttm.h"
> 
