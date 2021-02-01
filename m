Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3209030A37B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhBAImK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 03:42:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:61525 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhBAImJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:42:09 -0500
IronPort-SDR: DFMCP1IVjXeJZxszkwuTab0loXnD0hI/hyiN14BRMPKC9jvWBxwDkPgEgU87sxZUzD+RrP5f/R
 //U9z+wx43MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="199544195"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="199544195"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 00:41:27 -0800
IronPort-SDR: D3F9IwH0PrxoCa/YmhD9O1i17haxEnaYFO7foNRaM3WtDszJ5pUmn4ZUnwn9oQdLU2cxuC14kX
 Hlve2jY67RoQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369331898"
Received: from wehmschu-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 00:41:24 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] drm/i915: Avoid comma separated statements
In-Reply-To: <719e0f14852d132a6649dbd5791fca17f251cb8e.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1598331148.git.joe@perches.com> <d687691df8f9978c7b2362c18d77a16b49be76b0.1598331148.git.joe@perches.com> <719e0f14852d132a6649dbd5791fca17f251cb8e.camel@perches.com>
Date:   Mon, 01 Feb 2021 10:41:21 +0200
Message-ID: <875z3ci3im.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021, Joe Perches <joe@perches.com> wrote:
> On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
>> Use semicolons and braces.
>
> Ping?

Seems to have fallen between the cracks.

The first two hunks have been fixed, the last two are still there. Care
to respin and rebase against drm-tip (or linux-next) please?

BR,
Jani.

>
>> Signed-off-by: Joe Perches <joe@perches.com>
>> ---
>>  drivers/gpu/drm/i915/gt/gen8_ppgtt.c           | 8 +++++---
>>  drivers/gpu/drm/i915/gt/intel_gt_requests.c    | 6 ++++--
>>  drivers/gpu/drm/i915/gt/selftest_workarounds.c | 6 ++++--
>>  drivers/gpu/drm/i915/intel_runtime_pm.c        | 6 ++++--
>>  4 files changed, 17 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
>> index 699125928272..114c13285ff1 100644
>> --- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
>> +++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
>> @@ -323,10 +323,12 @@ static int __gen8_ppgtt_alloc(struct i915_address_space * const vm,
>>  			}
>>  
>> 
>>  			spin_lock(&pd->lock);
>> -			if (likely(!pd->entry[idx]))
>> +			if (likely(!pd->entry[idx])) {
>>  				set_pd_entry(pd, idx, pt);
>> -			else
>> -				alloc = pt, pt = pd->entry[idx];
>> +			} else {
>> +				alloc = pt;
>> +				pt = pd->entry[idx];
>> +			}
>>  		}
>>  
>> 
>>  		if (lvl) {
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> index 66fcbf9d0fdd..54408d0b5e6e 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
>> @@ -139,8 +139,10 @@ long intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout)
>>  	LIST_HEAD(free);
>>  
>> 
>>  	interruptible = true;
>> -	if (unlikely(timeout < 0))
>> -		timeout = -timeout, interruptible = false;
>> +	if (unlikely(timeout < 0)) {
>> +		timeout = -timeout;
>> +		interruptible = false;
>> +	}
>>  
>> 
>>  	flush_submission(gt, timeout); /* kick the ksoftirqd tasklets */
>>  	spin_lock(&timelines->lock);
>> diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
>> index febc9e6692ba..3e4cbeed20bd 100644
>> --- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
>> +++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
>> @@ -521,8 +521,10 @@ static int check_dirty_whitelist(struct intel_context *ce)
>>  
>> 
>>  		srm = MI_STORE_REGISTER_MEM;
>>  		lrm = MI_LOAD_REGISTER_MEM;
>> -		if (INTEL_GEN(engine->i915) >= 8)
>> -			lrm++, srm++;
>> +		if (INTEL_GEN(engine->i915) >= 8) {
>> +			lrm++;
>> +			srm++;
>> +		}
>>  
>> 
>>  		pr_debug("%s: Writing garbage to %x\n",
>>  			 engine->name, reg);
>> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
>> index 153ca9e65382..f498f1c80755 100644
>> --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
>> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
>> @@ -201,8 +201,10 @@ __print_intel_runtime_pm_wakeref(struct drm_printer *p,
>>  		unsigned long rep;
>>  
>> 
>>  		rep = 1;
>> -		while (i + 1 < dbg->count && dbg->owners[i + 1] == stack)
>> -			rep++, i++;
>> +		while (i + 1 < dbg->count && dbg->owners[i + 1] == stack) {
>> +			rep++;
>> +			i++;
>> +		}
>>  		__print_depot_stack(stack, buf, PAGE_SIZE, 2);
>>  		drm_printf(p, "Wakeref x%lu taken at:\n%s", rep, buf);
>>  	}
>
>

-- 
Jani Nikula, Intel Open Source Graphics Center
