Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C3363292
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhDQWjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhDQWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 18:39:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A7C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 15:39:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618699154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5sXavjPCFd/ZFOTvM8k2uhVeaJKPcnBNpPVYu832dU=;
        b=bVojwiVqxwYpf9tnvK95m6gImImm87OqoE+yJ542df9XMqoe/UXqONOgj1Y3rrI8et3VAf
        2P0sl+YNs6d08q0XDaApiHn5FAavwhvRWLc0TOUx10IU29Pzp2g+XmwYCxZ/SGo9bIZcVD
        MtWGFqPzwR0hJKzq5GR+rDsi8f49QMklFcyhTr6sj+ZZHKtQ023krpQTw3R7LT2Cjl9SDr
        RJTF15OTJLwbhfR8h4tqt94wAsisZttwjWfKsAAa+FgryAHHlrmeneblHQzfbGFNgUE058
        3SEsubUxTXvTevwNqC8gZuyQuJosNf6ba7pfjn/JsOWG2cEjBXc46WRbSr5Mgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618699154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5sXavjPCFd/ZFOTvM8k2uhVeaJKPcnBNpPVYu832dU=;
        b=+frV6F/7u2pP162MVrjtmLlgQLLCJ2Vi35USbVH/QbHh/V8esJ0adzZWhGNgsCX676QVGt
        xfb9BJSfrLszIaBA==
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix set apic mode from x2apic enabled bit patch
In-Reply-To: <20210415220626.223955-1-mike.travis@hpe.com>
References: <20210415220626.223955-1-mike.travis@hpe.com>
Date:   Sun, 18 Apr 2021 00:39:13 +0200
Message-ID: <87k0p0sfhq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike!

On Thu, Apr 15 2021 at 17:06, Mike Travis wrote:

I'm slowly getting tired of the fact that every patch coming from you
fails to comply with the minimal requirements of the documented
procedures.

$subject: [PATCH] Fix set apic mode from x2apic enabled bit patch

Documentation clearly states, that there has to be a subsystem
prefix. It's not rocket science to figure it out:

# git log arch/x86/kernel/apic/x2apic_uv_x.c

gives you a pretty good hint that the prefix should be:

 x86/platform/uv:

It's not that hard and it's not optional.

Also what the heck means:

     Fix set apic mode from x2apic enabled bit patch

Again documentation is very clear about what the subject line, aka git
shortlog of a patch should look like.

This sentence is just word salad and does not give any clue of what this
is about. Even you wont be able to decode this 3 month from now. Simply
because it's word salad.

I don't care what kind of standards you have @hpe, but I very much care
about the standards of the kernel.

> Do not set uv_system_type for hubless UV systems as it tricks the
> is_uv_system function into thinking it's a UV hubbed system and includes
> a UV HUB RTC.  This causes UV RTC init to panic on UV hubless systems.

And yet more word salad. Can you please describe the precise technical
problem and not use metaphors of functions which are thinking?

Aside of that this does not describe the change at all. The change is:

> -		early_set_apic_mode();

but your changelog blurbs about "thinking it's an UV hubbed system".

How the heck can this make sense for someone who is not part of the @hpe
universe mindset?

> Fixes: 41e2da9b5e67 ("x86/platform/uv: Use x2apic enabled bit as set by BIOS to indicate APIC mode")
>
> [41e2da9b5e67 was accepted into tip x86/platform branch but not yet
> pulled into the linus tree.]

Truly useful. The only value of that information is that the maintainer
has to manualy remove it because it's irrelevant for the final commit
message of the change which ends up on top of that commit in that
branch. You can stick this into the section below '---' if you think
it's helpful, but then maintainers and tools can just ignore it.

TBH, it's not helpful at all because tooling already tells us that
41e2da9b5e67 is not in Linus tree and only queued in tip x86/platform.

Commit SHAs are supposed to be unique for a reason...

> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>

The value of these reviewed-by tags is close to zero because they are
just documenting that the change is ok at the @hpe universe level...

> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 2e99605f9a05..68ef9abc91f7 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -413,9 +413,8 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
>  		else
>  			uv_hubless_system |= 0x8;
>  
> -		/* Copy OEM Table ID and set APIC Mode */
> +		/* Copy OEM Table ID */
>  		uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
> -		early_set_apic_mode();

So the patch itself tells me more about what's going on than the
changelog:

  Setting up the APIC mode at this place is wrong.

But it does not tell me WHY. Neither does the changelog because of
useless word salad...

If you can't come up with something sensible anytime soon before the
merge window opens then I'm simply going to revert 41e2da9b5e67 and you
can try again for the next cycle.

Thanks,

        tglx

