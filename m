Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B2840D748
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhIPKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:19:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:52280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234839AbhIPKTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:19:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286218069"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="286218069"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 03:17:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="553778537"
Received: from djustese-mobl.ger.corp.intel.com (HELO localhost) ([10.249.34.120])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 03:17:52 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Sujaritha Sundaresan <sujaritha.sundaresan@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: 5.15-rc1 i915 blank screen booting on ThinkPads
In-Reply-To: <9e4c1c68-8d1e-ee2c-99bf-320046130775@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <9e1a6f3b-5e64-be91-ba54-9b5d135ef638@google.com> <9e4c1c68-8d1e-ee2c-99bf-320046130775@linux.intel.com>
Date:   Thu, 16 Sep 2021 13:17:49 +0300
Message-ID: <87mtocx1rm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> Hi,
>
> On 16/09/2021 05:37, Hugh Dickins wrote:
>> Two Lenovo ThinkPads, old T420s (2011), newer X1 Carbon 5th gen (2017):
>> i915 working fine on both up to 5.14, but blank screens booting 5.15-rc1,
>> kernel crashed in some way.
>
> T420s could be SandyBridge and X1 Carbon KabyLake.
>
>> I wanted to say what i915 generations these are, but don't know where
>> to look - I don't see it in dmesg, even when DRM_I915_DEBUG enabled.
>> 
>> Possibly relevant: builtin kernels, CONFIG_MODULES off, no initrd.
>> 
>> On the older laptop:
>> 
>> First bisection showed first bad commit
>> 41e5c17ebfc2 "drm/i915/guc/slpc: Sysfs hooks for SLPC"
>> 
>> But reverting that still crashed boot with blank screen (and
>> reverting the two related commits after it made no difference).
>> 
>> Second bisection, starting from 5.15-rc1 bad and 41e5c17ebfc2 "good",
>> but patching it out each time before building, showed first bad commit
>> 3ffe82d701a4 "drm/i915/xehp: handle new steering options"
>> 
>> That one did not revert cleanly from 5.15-rc1, but reverting
>> 927dfdd09d8c "drm/i915/dg2: Add SQIDI steering" then
>> 1705f22c86fb "drm/i915/dg2: Update steering tables" then
>> 768fe28dd3dc "drm/i915/xehpsdv: Define steering tables" then
>> 3ffe82d701a4 "drm/i915/xehp: handle new steering options"
>> worked (there was one very easy fixup needed somewhere).
>> 
>> And 5.15-rc1 with those five reversions boots and runs fine...
>> on that older laptop.  But reverting those from the kernel on the
>> newer laptop did not help at all, still booting with blank screen
>> (or no more lines shown after the switch from VGA).  Put them back.
>
> Bisect results sound suspicious since the steering patches do not come 
> into play on SandyBridge.
>
>> On the newer laptop, bisection showed first bad commit
>> 62eaf0ae217d "drm/i915/guc: Support request cancellation"
>> 
>> And 5.15-rc1 with that reverted boots and runs fine on the newer.
> But not on the older laptop?
>
> Given bisect points to this, it may be worth trying to build both 
> kernels with CONFIG_DRM_I915_REQUEST_TIMEOUT=0 (no reverts) to see what 
> happens. But first the logs which I'll ask next.
>
>> I am hoping that there will be some i915 fixups to come in a later rc!
>> May be nothing more than uninitialized variables or NULL pointers.
>> You'll probably want more info from me: please ask, but I'm slow.
>
> Kernel logs with drm.debug=0xe, with the broken black screen state, 
> would probably answer a lot of questions if you could gather it from 
> both machines?

And for that, I think it's best to file separate bugs at [1] and attach
the logs there. It helps keep the info in one place. Thanks.

BR,
Jani.


[1] https://gitlab.freedesktop.org/drm/intel/issues/new


>
> Regards,
>
> Tvrtko

-- 
Jani Nikula, Intel Open Source Graphics Center
