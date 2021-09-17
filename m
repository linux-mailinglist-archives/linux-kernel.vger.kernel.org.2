Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0223A410181
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhIQWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:54:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:64310 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232149AbhIQWyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:54:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="222545056"
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="222545056"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 15:52:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,302,1624345200"; 
   d="scan'208";a="546662097"
Received: from unknown (HELO localhost) ([10.251.216.224])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 15:52:51 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Brost <matthew.brost@intel.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Sujaritha Sundaresan <sujaritha.sundaresan@intel.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: 5.15-rc1 i915 blank screen booting on ThinkPads
In-Reply-To: <20210917213032.GA34270@jons-linux-dev-box>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <9e1a6f3b-5e64-be91-ba54-9b5d135ef638@google.com> <9e4c1c68-8d1e-ee2c-99bf-320046130775@linux.intel.com> <87mtocx1rm.fsf@intel.com> <1f955bff-fd9e-d2ee-132a-f758add9e9cb@google.com> <20210917213032.GA34270@jons-linux-dev-box>
Date:   Sat, 18 Sep 2021 01:52:48 +0300
Message-ID: <87k0jevmpr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021, Matthew Brost <matthew.brost@intel.com> wrote:
> On Fri, Sep 17, 2021 at 02:26:48PM -0700, Hugh Dickins wrote:
>> On Thu, 16 Sep 2021, Jani Nikula wrote:
>> > On Thu, 16 Sep 2021, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
>> > > On 16/09/2021 05:37, Hugh Dickins wrote:
>> > >> Two Lenovo ThinkPads, old T420s (2011), newer X1 Carbon 5th gen (2017):
>> > >> i915 working fine on both up to 5.14, but blank screens booting 5.15-rc1,
>> > >> kernel crashed in some way.
>> ...
>> > > Kernel logs with drm.debug=0xe, with the broken black screen state, 
>> > > would probably answer a lot of questions if you could gather it from 
>> > > both machines?
>> > 
>> > And for that, I think it's best to file separate bugs at [1] and attach
>> > the logs there. It helps keep the info in one place. Thanks.
>> > 
>> > BR,
>> > Jani.
>> > 
>> > [1] https://gitlab.freedesktop.org/drm/intel/issues/new
>> 
>> Thanks for the quick replies: but of course, getting kernel logs was
>> the difficult part, this being bootup, with just a blank screen, and
>> no logging to disk at this stage.  I've never needed it before, but
>> netconsole to the rescue.
>> 
>> Problem then obvious, both machines now working,
>> please let me skip the bug reports, here's a patch:
>> 
>
> Thanks for finding / fixing this Hugh. I will post this patch in a way
> our CI system can understand.

Thanks indeed!

Matt, please get rid of the BUG_ON while at it, and make it a
WARN. Oopsing doesn't do anyone any good.

BR,
Jani.

>
> Matt 
>
>> [PATCH] drm/i915: fix blank screen booting crashes
>> 
>> 5.15-rc1 crashes with blank screen when booting up on two ThinkPads
>> using i915.  Bisections converge convincingly, but arrive at different
>> and surprising "culprits", none of them the actual culprit.
>> 
>> netconsole (with init_netconsole() hacked to call i915_init() when
>> logging has started, instead of by module_init()) tells the story:
>> 
>> kernel BUG at drivers/gpu/drm/i915/i915_sw_fence.c:245!
>> with RSI: ffffffff814d408b pointing to sw_fence_dummy_notify().
>> I've been building with CONFIG_CC_OPTIMIZE_FOR_SIZE=y, and that
>> function needs to be 4-byte aligned.
>> 
>> Fixes: 62eaf0ae217d ("drm/i915/guc: Support request cancellation")
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> ---
>> 
>>  drivers/gpu/drm/i915/gt/intel_context.c |    1 +
>>  1 file changed, 1 insertion(+)
>> 
>> --- a/drivers/gpu/drm/i915/gt/intel_context.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_context.c
>> @@ -362,6 +362,7 @@ static int __intel_context_active(struct
>>  	return 0;
>>  }
>>  
>> +__aligned(4)	/* Respect the I915_SW_FENCE_MASK */
>>  static int sw_fence_dummy_notify(struct i915_sw_fence *sf,
>>  				 enum i915_sw_fence_notify state)
>>  {

-- 
Jani Nikula, Intel Open Source Graphics Center
