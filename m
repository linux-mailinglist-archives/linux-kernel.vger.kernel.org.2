Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73EC31FCE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBSQOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:14:10 -0500
Received: from foss.arm.com ([217.140.110.172]:39596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSQOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:14:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82305ED1;
        Fri, 19 Feb 2021 08:13:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.45.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718DE3F73B;
        Fri, 19 Feb 2021 08:13:18 -0800 (PST)
Date:   Fri, 19 Feb 2021 16:13:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org,
        tglx@linutronix.de, will@kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 0/8] arm64: Support FIQ controller registration
Message-ID: <20210219161315.GB78721@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <d714eee3-2746-d607-622c-184eadb480a1@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d714eee3-2746-d607-622c-184eadb480a1@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 12:41:01AM +0900, Hector Martin wrote:
> Hi Mark,
> 
> Thanks for tackling this side of the problem!

No problem -- I have a vested interest in the arm64 exception management
code lookin the way I expect/prefer! ;)

> On 19/02/2021 20.38, Mark Rutland wrote:

> > I'm hoping that we can somehow queue the first 6 patches of this series as a
> > base for the M1 support. With that we can either cherry-pick a later version of
> > the DAIF.IF patch here, or the M1 support series can take the FIQ handling
> > patch. I've pushed the series out to my arm64/fiq branch [4] on kernel.org,
> > atop v5.11.
> 
> Looks good! I cherry picked my updated version of the DAIF.IF patch into
> your series at [1] (3322522d), and then rebased the M1 series on top of it
> (with the change to use set_handle_fiq(), minus all the other obsoleted FIQ
> stuff) at [2]. It all boots and works as expected.
> 
> I think it makes sense for you to take the DAIF.IF patch, as it goes along
> with this series. Then we can base the M1 series off of it. 

Sure; that works for me!

> If you think that works, I can send it off as a one-off reply to the
> version in this series and we can review it here if you want, or
> otherwise feel free to cherry-pick it into a v2 (CC as appropriate).

If you could do a one-off reply, that'd be fantastic -- that way
lore.kernel.org will archive it and it gives people a chance to provide
any tags or comments before the next respin of the whole series.

> If this all makes sense, the v3 of the M1 series will then be based off of
> this patchset as in [2], and I'll link to your tree in the cover letter so
> others know where to apply it.

As a heads-up, I'm currently treating my arm64/fiq branch as unstable
(and I've already applied a typo fix since this posting), but I can tag
versions of that to make it possible to refer to a specific version.

I'll make sure to do that once I fold in the new DAIF.[IF] patch, since
I assume that's the first version worth noting as a base.

> Arnd (CCed) is going to be merging that one via the SoC tree, so as
> long as we coordinate a stable base once everything is reviewed and
> ready to merge, I believe it should all work out fine on the way up.

That sounds about right to me.

I think the first step is for Marc and I to figure out how the core IRQ
bits go in (some of that might be an fix early in the current v5.12
cycle), and I'd expect to have a stable branch atop somewhere between
v5.12-rc1 and v5.12-rc4. For context, usually the arm64 core bits get
based on the previous rc3/rc4.

Thanks,
Mark.

> Just for completeness, the current DAIF.IF patch in the context of the
> original series is at [3] (4dd6330f), in case that's useful to someone for
> some reason (since there were conflicts due to the refactoring happening
> before it, it changed a bit).
> 
> [1] https://github.com/AsahiLinux/linux/tree/fiq
> [2] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v3
> [3] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v2.5
> 
> -- 
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub
