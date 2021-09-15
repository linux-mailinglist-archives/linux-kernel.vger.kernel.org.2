Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529FE40C40E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhIOLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhIOLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:01:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C423C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:00:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d07000c3d48728178681f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:700:c3d:4872:8178:681f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F7E51EC0493;
        Wed, 15 Sep 2021 13:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631703626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhruTfx6a1vn9bJbkqwEzxTY41J4MJGsLlefXt9yGLg=;
        b=AoZxQDh0ovGCZp36TVoMqssSPPir4S4CLUTje3ga2Sl4kb+jKndFyxzIQAdJXNZ2UdIJ6s
        kfLUqWGA4EkHlLtO7vdZeGBKfn+T4gB2KoAzSvk/LcfcYioMbDg/OWsjZTxwkOGmMUGJ43
        XiSdKkF3s8/MlzVxKAN0eN5YeTY07vg=
Date:   Wed, 15 Sep 2021 13:00:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] x86/setup: call early_reserve_memory() earlier
Message-ID: <YUHSRKubsGT2Jvur@zn.tnic>
References: <20210914094108.22482-1-jgross@suse.com>
 <b15fa98e-f9a8-abac-2d16-83c29dafc517@suse.com>
 <6cdc71dc-c26d-5c59-b7dd-0eb47ab9c861@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cdc71dc-c26d-5c59-b7dd-0eb47ab9c861@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to Cc Mike, lemme add him.

And drop stable@ too.

On Tue, Sep 14, 2021 at 01:06:22PM +0200, Juergen Gross wrote:
> On 14.09.21 12:03, Jan Beulich wrote:
> > On 14.09.2021 11:41, Juergen Gross wrote:
> > > Commit a799c2bd29d19c565 ("x86/setup: Consolidate early memory
> > > reservations") introduced early_reserve_memory() to do all needed
> > > initial memblock_reserve() calls in one function. Unfortunately the
> > > call of early_reserve_memory() is done too late for Xen dom0, as in
> > > some cases a Xen hook called by e820__memory_setup() will need those
> > > memory reservations to have happened already.
> > > 
> > > Move the call of early_reserve_memory() to the beginning of
> > > setup_arch() in order to avoid such problems.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: a799c2bd29d19c565 ("x86/setup: Consolidate early memory reservations")
> > > Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   arch/x86/kernel/setup.c | 24 ++++++++++++------------
> > >   1 file changed, 12 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > index 79f164141116..f369c51ec580 100644
> > > --- a/arch/x86/kernel/setup.c
> > > +++ b/arch/x86/kernel/setup.c
> > > @@ -757,6 +757,18 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
> > >   void __init setup_arch(char **cmdline_p)
> > >   {
> > > +	/*
> > > +	 * Do some memory reservations *before* memory is added to
> > > +	 * memblock, so memblock allocations won't overwrite it.
> > > +	 * Do it after early param, so we could get (unlikely) panic from
> > > +	 * serial.
> > 
> > Hmm, this part of the comment is not only stale now, but gets actively
> > undermined. No idea how likely such a panic() would be, and hence how
> > relevant it is to retain this particular property.
> 
> Ah, right.
> 
> The alternative would be to split it up again. Let's let the x86
> maintainers decide which way is the better one.
> 
> 
> Juergen
> 
> > 
> > Jan
> > 
> > > +	 * After this point everything still needed from the boot loader or
> > > +	 * firmware or kernel text should be early reserved or marked not
> > > +	 * RAM in e820. All other memory is free game.
> > > +	 */
> > > +	early_reserve_memory();
> > > +
> > >   #ifdef CONFIG_X86_32
> > >   	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
> > > @@ -876,18 +888,6 @@ void __init setup_arch(char **cmdline_p)
> > >   	parse_early_param();
> > > -	/*
> > > -	 * Do some memory reservations *before* memory is added to
> > > -	 * memblock, so memblock allocations won't overwrite it.
> > > -	 * Do it after early param, so we could get (unlikely) panic from
> > > -	 * serial.
> > > -	 *
> > > -	 * After this point everything still needed from the boot loader or
> > > -	 * firmware or kernel text should be early reserved or marked not
> > > -	 * RAM in e820. All other memory is free game.
> > > -	 */
> > > -	early_reserve_memory();
> > > -
> > >   #ifdef CONFIG_MEMORY_HOTPLUG
> > >   	/*
> > >   	 * Memory used by the kernel cannot be hot-removed because Linux
> > > 
> > 
> 






-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
