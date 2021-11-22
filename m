Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCE458B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhKVJMp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Nov 2021 04:12:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:15206 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232383AbhKVJMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:12:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="215464340"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="215464340"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 01:09:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="456569866"
Received: from rmcdonax-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.217])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 01:09:24 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        cgel.zte@gmail.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yong yiran <yong.yiran@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: [PATCH linux-next] drm/i915/request: Remove unused variables
In-Reply-To: <80173779-5c91-a56e-6bac-ad4ff7c435f7@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211121101309.23577-1-yong.yiran@zte.com.cn>
 <80173779-5c91-a56e-6bac-ad4ff7c435f7@wanadoo.fr>
Date:   Mon, 22 Nov 2021 11:09:21 +0200
Message-ID: <87o86co8u6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> Le 21/11/2021 à 11:13, cgel.zte@gmail.com a écrit :
>> From: yong yiran <yong.yiran@zte.com.cn>
>> 
>> The clang_analyzer complains as follows:
>> drivers/gpu/drm/i915/i915_request.c:2119:2 warning:
>> Value stored to 'x' is never read
>> 
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>

The sender's Signed-off-by is missing.

>> ---
>>   drivers/gpu/drm/i915/i915_request.c | 3 ---
>>   1 file changed, 3 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
>> index 820a1f38b271..5e4420f461e9 100644
>> --- a/drivers/gpu/drm/i915/i915_request.c
>> +++ b/drivers/gpu/drm/i915/i915_request.c
>> @@ -2047,7 +2047,6 @@ void i915_request_show(struct drm_printer *m,
>>   {
>>   	const char *name = rq->fence.ops->get_timeline_name((struct dma_fence *)&rq->fence);
>>   	char buf[80] = "";
>> -	int x = 0;
>>   
>>   	/*
>>   	 * The prefix is used to show the queue status, for which we use
>> @@ -2079,8 +2078,6 @@ void i915_request_show(struct drm_printer *m,
>>   	 *      from the lists
>>   	 */
>>   
>> -	x = print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
>> -
>
> Seriously?

Basically I've started considering all of these patches as static
analyzer reports *only*. The "fixes" have often been completely wrong or
have missed the real issue and merely silenced the warning.

I really couldn't say anything about the "Zeal Robot" itself, but the
patches are giving it a bad reputation.


BR,
Jani.




>
> CJ
>
>
>>   	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
>>   		   prefix, indent, "                ",
>>   		   queue_status(rq),
>> 
>

-- 
Jani Nikula, Intel Open Source Graphics Center
