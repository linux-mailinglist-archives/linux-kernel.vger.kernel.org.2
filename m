Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFC377F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEJJVN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 May 2021 05:21:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:10075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJJVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:21:10 -0400
IronPort-SDR: LV0WIPCvG4pw1SppbAzrKwCoS0IYFaMBmwaAVGda92DrdPBNv5rAjzufDy0tsvht5ys1gIZzb2
 fxDZr1X9Y9eA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="186286574"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186286574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 02:20:05 -0700
IronPort-SDR: gcVciB9UplP1AQO1EwhP/KB2ZzQkYemqLuaTfs4Nk7sw2sRx7oIppYONZd5aF8K6+OTNHsrXEX
 h6VGGEgc+ZOQ==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="436061399"
Received: from solender-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 02:20:03 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: New warnings with gcc-11
In-Reply-To: <CAHk-=whJsh4FOcMQ+eDx=f4joa-CCH1pmYtrsw0H7L0HV_GhJg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com> <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com> <87bl9y50ok.fsf@intel.com> <CAHk-=whJsh4FOcMQ+eDx=f4joa-CCH1pmYtrsw0H7L0HV_GhJg@mail.gmail.com>
Date:   Mon, 10 May 2021 12:20:01 +0300
Message-ID: <874kfbvtby.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 May 2021, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I have heard nothing about this, and it remains the only warning from
> my allmodconfig build (I have another one for drm compiled with clang,
> but there I at least heard back that a fix exists).
>
> Since I am going to release rc1 tomorrow, and I don't want to release
> it with an ugly compiler warning, I took it upon myself to just fix
> the code:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fec4d42724a1bf3dcba52307e55375fdb967b852
>
> HOWEVER.
>
> That commit fixes the warning, and is at worst harmless. At best it
> fixes an access to random stack memory. But it does smell like
> somebody who actually knows how these arrays work should look at that
> code.
>
> IOW, maybe the code should actually have read 16 bytes from the Event
> Status Indicator? Maybe offset 10 was wrong? Maybe
> drm_dp_channel_eq_ok() should never have taken six bytes to begin
> with?
>
> It's a mystery, and I haven't heard anything otherwise, so there it is.

Fair enough. My bad for not getting this fixed.

The fix is harmless. drm_dp_channel_eq_ok() only ever accesses 3 bytes
instead of 6. I figure the DP_LINK_STATUS_SIZE (=6) is there because in
the normal case you'd read that much, and use a family of functions on
that data, some of which do access the full 6 bytes, some don't.

In our case, we use drm_dp_channel_eq_ok() to check 3 bytes of similarly
encoded data elsewhere in the DPCD address space, and the
DP_LINK_STATUS_SIZE is meaningless there.

The straightforward fix would be to replace
link_status[DP_LINK_STATUS_SIZE] with link_status[3], and that likely
needs changes in dp_link_status() and dp_get_lane_status() as well.


BR,
Jani.


>
>               Linus
>
> On Wed, Apr 28, 2021 at 12:27 AM Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> On Tue, 27 Apr 2021, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > I've updated to Fedora 34 on one of my machines, and it causes a lot
>> > of i915 warnings like
>> >
>> >   drivers/gpu/drm/i915/intel_pm.c: In function ‘ilk_setup_wm_latency’:
>> >   drivers/gpu/drm/i915/intel_pm.c:3059:9: note: referencing argument 3
>> > of type ‘const u16 *’ {aka ‘const short unsigned int *’}
>> >   drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
>> > ‘intel_print_wm_latency’
>> >
>> > and the reason is that gcc now seems to look at the argument array
>> > size more, and notices that
>>
>> Arnd Bergmann reported some of these a while back. I think we have some
>> of them fixed in our -next already, but not all. Thanks for the
>> reminder.

-- 
Jani Nikula, Intel Open Source Graphics Center
