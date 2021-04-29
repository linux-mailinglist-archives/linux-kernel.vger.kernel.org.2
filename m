Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2430436EEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhD2RbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:31:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhD2RbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:31:08 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619717420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJXR4fZocDkKMWOTk0WbWX3KyU7z/uvQ2BToeyDE0J0=;
        b=sxlmnOuK4F4AKbqCwQgs+xzYpDADkjnmEgPURKfN5pKpAVHaPUUSso/e39yxqJfpyzykVX
        EQzWkMrClj3KshP8ZyTcMvq9MU/l/LiHbN+Bc5OCf72wU/JJo/q3PKlDMsT688txB2Sa5I
        I9N1U8NTtrwtacjVXCGvNtV1fSq96IKiSaBQpyPLL7kXK/kgfAUj5Nky5pOaeziOthCjAM
        hHLgWcwLwOyC0be8G4G3UmVAL3GMNaP+5DXkMpK24JWFNc0uupwz5FvsDlk5UPsDj/8eDg
        CmObxwJNP7umr6hEKBJ6o+M8SXv29u2vkxhHWc5sZJ2DdFXi/BgMFeNqzZpUDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619717420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJXR4fZocDkKMWOTk0WbWX3KyU7z/uvQ2BToeyDE0J0=;
        b=oU64b9nqn9EXj4yLPLJAt8trILyWXnWUbBxnrIePnbfipXSO9TrpdVX2NQXuRM1vgeIQKd
        ZbISUqqKNESz2GBA==
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d: WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
In-Reply-To: <20210429142641.GU975577@paulmck-ThinkPad-P17-Gen-1>
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de> <87a6pimt1f.ffs@nanos.tec.linutronix.de> <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1> <878s517axu.ffs@nanos.tec.linutronix.de> <20210429142641.GU975577@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 29 Apr 2021 19:30:20 +0200
Message-ID: <87lf91f177.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Thu, Apr 29 2021 at 07:26, Paul E. McKenney wrote:
> On Thu, Apr 29, 2021 at 10:27:09AM +0200, Thomas Gleixner wrote:
>> > Or are you saying that the checks should be in the host OS rather than
>> > in the guests?
>> 
>> Yes. That's where it belongs. The host has to make sure that TSC is usable
>> otherwise it should tell the guest not to use it. Anything else is
>> wishful thinking and never reliable.
>
> Thank you for the confirmation.  I will look into this.

So the guest might need at least some basic sanity checking unless we
declare that hypervisors are always working correctly :)

Which is admittedly more likely than making the same assumption about
BIOS and hardware.

>> > In addition, breakage due to age and environmentals is possible, and if
>> > you have enough hardware, probable.  In which case it would be good to
>> > get a notification so that the system in question can be dealt with.
>> 
>> Are you trying to find a problem for a solution again?
>
> We really do see this thing trigger. > I am trying to get rid of one
> class of false positives that might be afflicting us.  Along the way,
> I am thinking aloud about what might be the cause of any remaining
> skew reports that might trigger in the future.

Fair enough. Admittedly this has at least entertainment value :)

>> Well, you might then also build safety nets for interrupts, exceptions
>> and if you go fully paranoid for every single CPU instruction. :)
>
> Fair, and I doubt that looking at failure data across a large fleet of
> systems has done anything to reduce my level of paranoia.  ;-)

You should have known better than opening Pandoras box.

>> Sure. If you have a seperate module then you can add module params to it
>> obviously. But you don't need any of the muck in the actual watchdog
>> code because the watchdog::read() function in that module will simply
>> handle the delay injection. Hmm?
>
> OK, first let me make sure I understand what you are suggesting.
>
> The idea is to leave the watchdog code in kernel/time/clocksource.c,
> but to move the fault injection into kernel/time/clocksourcefault.c or
> some such.  In this new file, new clocksource structures are created that
> use some existing timebase/clocksource under the covers.  These then
> inject delays based on module parameters (one senstive to CPU number,
> the other unconditional).  They register these clocksources using the
> normal interfaces, and verify that they are eventually marked unstable
> when the fault-injection parameters warrant it.  This is combined with
> the usual checking of the console log.
>
> Or am I missing your point?

That's what I meant.

Thanks,

        tglx
