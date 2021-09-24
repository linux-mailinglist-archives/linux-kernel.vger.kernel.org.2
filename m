Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15E416E72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbhIXJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:05:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:18064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245055AbhIXJFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:05:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211109815"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="211109815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 02:03:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="551509027"
Received: from sambroox-mobl.ger.corp.intel.com (HELO [10.213.245.2]) ([10.213.245.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 02:03:54 -0700
Subject: Re: [Intel-gfx] [patch 07/11] drm/i915/pmu: Use hrtimer_forward_now()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20210923153311.225307347@linutronix.de>
 <20210923153339.808080761@linutronix.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <c459f1ec-446e-317e-2835-4e9dbef44f64@linux.intel.com>
Date:   Fri, 24 Sep 2021 10:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923153339.808080761@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/09/2021 17:04, Thomas Gleixner wrote:
> hrtimer_forward() is about to be removed from the public
> interfaces. Replace it with hrtimer_forward_now() which provides the same
> functionality.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -439,7 +439,7 @@ static enum hrtimer_restart i915_sample(
>   	engines_sample(gt, period_ns);
>   	frequency_sample(gt, period_ns);
>   
> -	hrtimer_forward(hrtimer, now, ns_to_ktime(PERIOD));
> +	hrtimer_forward_now(hrtimer, ns_to_ktime(PERIOD));
>   
>   	return HRTIMER_RESTART;
>   }
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko
