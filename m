Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5C40D4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhIPIpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:45:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:59804 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235219AbhIPIpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:45:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="222557457"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="222557457"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 01:44:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="516703015"
Received: from ipoconno-mobl3.ger.corp.intel.com (HELO [10.213.234.111]) ([10.213.234.111])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 01:44:27 -0700
Subject: Re: 5.15-rc1 i915 blank screen booting on ThinkPads
To:     Hugh Dickins <hughd@google.com>, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
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
References: <9e1a6f3b-5e64-be91-ba54-9b5d135ef638@google.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <9e4c1c68-8d1e-ee2c-99bf-320046130775@linux.intel.com>
Date:   Thu, 16 Sep 2021 09:44:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e1a6f3b-5e64-be91-ba54-9b5d135ef638@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 16/09/2021 05:37, Hugh Dickins wrote:
> Two Lenovo ThinkPads, old T420s (2011), newer X1 Carbon 5th gen (2017):
> i915 working fine on both up to 5.14, but blank screens booting 5.15-rc1,
> kernel crashed in some way.

T420s could be SandyBridge and X1 Carbon KabyLake.

> I wanted to say what i915 generations these are, but don't know where
> to look - I don't see it in dmesg, even when DRM_I915_DEBUG enabled.
> 
> Possibly relevant: builtin kernels, CONFIG_MODULES off, no initrd.
> 
> On the older laptop:
> 
> First bisection showed first bad commit
> 41e5c17ebfc2 "drm/i915/guc/slpc: Sysfs hooks for SLPC"
> 
> But reverting that still crashed boot with blank screen (and
> reverting the two related commits after it made no difference).
> 
> Second bisection, starting from 5.15-rc1 bad and 41e5c17ebfc2 "good",
> but patching it out each time before building, showed first bad commit
> 3ffe82d701a4 "drm/i915/xehp: handle new steering options"
> 
> That one did not revert cleanly from 5.15-rc1, but reverting
> 927dfdd09d8c "drm/i915/dg2: Add SQIDI steering" then
> 1705f22c86fb "drm/i915/dg2: Update steering tables" then
> 768fe28dd3dc "drm/i915/xehpsdv: Define steering tables" then
> 3ffe82d701a4 "drm/i915/xehp: handle new steering options"
> worked (there was one very easy fixup needed somewhere).
> 
> And 5.15-rc1 with those five reversions boots and runs fine...
> on that older laptop.  But reverting those from the kernel on the
> newer laptop did not help at all, still booting with blank screen
> (or no more lines shown after the switch from VGA).  Put them back.

Bisect results sound suspicious since the steering patches do not come 
into play on SandyBridge.

> On the newer laptop, bisection showed first bad commit
> 62eaf0ae217d "drm/i915/guc: Support request cancellation"
> 
> And 5.15-rc1 with that reverted boots and runs fine on the newer.
But not on the older laptop?

Given bisect points to this, it may be worth trying to build both 
kernels with CONFIG_DRM_I915_REQUEST_TIMEOUT=0 (no reverts) to see what 
happens. But first the logs which I'll ask next.

> I am hoping that there will be some i915 fixups to come in a later rc!
> May be nothing more than uninitialized variables or NULL pointers.
> You'll probably want more info from me: please ask, but I'm slow.

Kernel logs with drm.debug=0xe, with the broken black screen state, 
would probably answer a lot of questions if you could gather it from 
both machines?

Regards,

Tvrtko
