Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E572340D597
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhIPJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235160AbhIPJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:10:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0125F60F93;
        Thu, 16 Sep 2021 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783373;
        bh=aVfsrAoPBPm3coDtX7qouVYko5lvAFm1LHfu7NPpcGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MneUb0wyDDhB+jVjJDBgKLy9ijrzyLgrNSegUd6/ufKx2wmAO77YL8v1W7Ik0xdcu
         4kcQiXhxthJmd4+/P0YKZRygro6d9sojkrXTR8Gaja+JSCcb3r14aRIlhK6xhphcfK
         qhbs0IdIZmoR9gBA+I2tNMHb6bCZc6MqwwZeuqcolYjGaNZxL3uWnXOZagZWVh9sns
         U3PWs9FQpVTaifKmtsAkRDOKLj7KOgFlYDvJqD3T+JUYBxhB+SZ/zBs7/5KbHCVe3I
         ahEtu6Hs6WXeX5OzurOobc3oH1U32Gfu1KZxQ+MkTp5e3qXuV7eZ2mmeOeooyBfxIA
         CyUVnQXowSVKA==
Date:   Thu, 16 Sep 2021 12:09:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/setup: call early_reserve_memory() earlier
Message-ID: <YUMJx2ckLlWKi3VF@kernel.org>
References: <20210914094108.22482-1-jgross@suse.com>
 <b15fa98e-f9a8-abac-2d16-83c29dafc517@suse.com>
 <6cdc71dc-c26d-5c59-b7dd-0eb47ab9c861@suse.com>
 <YUHSRKubsGT2Jvur@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUHSRKubsGT2Jvur@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 01:00:20PM +0200, Borislav Petkov wrote:
> You forgot to Cc Mike, lemme add him.
> 
> And drop stable@ too.
> 
> On Tue, Sep 14, 2021 at 01:06:22PM +0200, Juergen Gross wrote:
> > On 14.09.21 12:03, Jan Beulich wrote:
> > > On 14.09.2021 11:41, Juergen Gross wrote:
> > > > Commit a799c2bd29d19c565 ("x86/setup: Consolidate early memory
> > > > reservations") introduced early_reserve_memory() to do all needed
> > > > initial memblock_reserve() calls in one function. Unfortunately the
> > > > call of early_reserve_memory() is done too late for Xen dom0, as in
> > > > some cases a Xen hook called by e820__memory_setup() will need those
> > > > memory reservations to have happened already.
> > > > 
> > > > Move the call of early_reserve_memory() to the beginning of
> > > > setup_arch() in order to avoid such problems.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a799c2bd29d19c565 ("x86/setup: Consolidate early memory reservations")
> > > > Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > ---
> > > >   arch/x86/kernel/setup.c | 24 ++++++++++++------------
> > > >   1 file changed, 12 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index 79f164141116..f369c51ec580 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -757,6 +757,18 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
> > > >   void __init setup_arch(char **cmdline_p)
> > > >   {
> > > > +	/*
> > > > +	 * Do some memory reservations *before* memory is added to
> > > > +	 * memblock, so memblock allocations won't overwrite it.
> > > > +	 * Do it after early param, so we could get (unlikely) panic from
> > > > +	 * serial.
> > > 
> > > Hmm, this part of the comment is not only stale now, but gets actively
> > > undermined. No idea how likely such a panic() would be, and hence how
> > > relevant it is to retain this particular property.
> > 
> > Ah, right.
> > 
> > The alternative would be to split it up again. Let's let the x86
> > maintainers decide which way is the better one.

I think the first sentence about reserving memory before memblock
allocations are possible is important and I think we should keep it.

With that

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> > 
> > 
> > Juergen
> > 
> > > 
> > > Jan
> > > 
> > > > +	 * After this point everything still needed from the boot loader or
> > > > +	 * firmware or kernel text should be early reserved or marked not
> > > > +	 * RAM in e820. All other memory is free game.
> > > > +	 */
> > > > +	early_reserve_memory();
> > > > +
> > > >   #ifdef CONFIG_X86_32
> > > >   	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
> > > > @@ -876,18 +888,6 @@ void __init setup_arch(char **cmdline_p)
> > > >   	parse_early_param();
> > > > -	/*
> > > > -	 * Do some memory reservations *before* memory is added to
> > > > -	 * memblock, so memblock allocations won't overwrite it.
> > > > -	 * Do it after early param, so we could get (unlikely) panic from
> > > > -	 * serial.
> > > > -	 *
> > > > -	 * After this point everything still needed from the boot loader or
> > > > -	 * firmware or kernel text should be early reserved or marked not
> > > > -	 * RAM in e820. All other memory is free game.
> > > > -	 */
> > > > -	early_reserve_memory();
> > > > -
> > > >   #ifdef CONFIG_MEMORY_HOTPLUG
> > > >   	/*
> > > >   	 * Memory used by the kernel cannot be hot-removed because Linux
> > > > 
> > > 
> > 
> 
> 
> 
> 
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Sincerely yours,
Mike.
