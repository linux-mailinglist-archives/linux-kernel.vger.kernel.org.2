Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B589439AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhJYPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:46:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:5202 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhJYPqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:46:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="315885621"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="315885621"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 08:42:38 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="446684809"
Received: from dscaswel-mobl2.ger.corp.intel.com (HELO [10.213.242.254]) ([10.213.242.254])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 08:42:29 -0700
Subject: Re: [PATCH] drm/i915: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Matthew Brost <matthew.brost@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20211025113316.24424-1-wanjiabing@vivo.com>
From:   Matthew Auld <matthew.auld@intel.com>
Message-ID: <58331d3d-c3e3-0e82-eb7a-469c6e72d7a7@intel.com>
Date:   Mon, 25 Oct 2021 16:42:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211025113316.24424-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2021 12:32, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:3117:15-22: WARNING:
> ERR_CAST can be used with eb->requests[i].
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Pushed to drm-intel-gt-next. Thanks.

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 4d7da07442f2..eb2dcaf78d08 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -3114,7 +3114,7 @@ eb_requests_create(struct i915_execbuffer *eb, struct dma_fence *in_fence,
>   		/* Allocate a request for this batch buffer nice and early. */
>   		eb->requests[i] = i915_request_create(eb_find_context(eb, i));
>   		if (IS_ERR(eb->requests[i])) {
> -			out_fence = ERR_PTR(PTR_ERR(eb->requests[i]));
> +			out_fence = ERR_CAST(eb->requests[i]);
>   			eb->requests[i] = NULL;
>   			return out_fence;
>   		}
> 
