Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823D8392FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhE0Njw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236544AbhE0Njs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:39:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57A946128D;
        Thu, 27 May 2021 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622122695;
        bh=qPZ1x1XVS5Kd7ldhmHgHLcpQ8by7e+3P3K8AswG85cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdbZKBeuHlMCqIGBH04CzsjfU94agKoOPiJ/FX8nOFgOmtsFZodcV+cx4vmXnFq21
         59dzOpaGNH/KWolV+JQWasVM2lBRF+liohcJsduIN83vsutSa/tgRJsa37a0mXEULl
         AkCSTOuIH/Pxhg+M4T322/c7EhUxvUBM0NJO1ukKt9m3qpAfd+dNTQmWwfjgOxMjGD
         IkYO8LUIawu3kLQ6px6Uuqr1CLF04mcgzpCWG/7x3wKAOTxxBCKGXEWA2IXuNZpkaU
         XZIHUgZzY9+9M5mqz+B1/JGm+cgIlMwGBe+OyN1aOkIJCDL0ZV+3nbJGN5lILPIy9y
         RPcxt8Q5Qsq1A==
Date:   Thu, 27 May 2021 16:38:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Message-ID: <YK+gv0vDfLVD7Sqp@kernel.org>
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic>
 <YK53kWHb4cPeeHsd@kernel.org>
 <YK6QFLUoPZ7btQfH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK6QFLUoPZ7btQfH@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:14:44PM +0200, Borislav Petkov wrote:
> On Wed, May 26, 2021 at 07:30:09PM +0300, Mike Rapoport wrote:
> > We can restore that behaviour, but it feels like cheating to me. We let
> > user say "Hey, don't touch low memory at all", even though we know we must
> > use at least some of it. And then we sneak in an allocation under 640K
> > despite user's request not to use it.
> 
> Sure but how are we going to tell the user that if we don't sneak that
> allocation, we won't boot at all. I believe user would kinda like the
> box to boot still, no? :-)
> 
> Yeah, you have that now:
> 
> +         Note, that a part of the low memory range is still required for
> +         kernel to boot properly.
> 
> but then why is 512 ok? And why was 640K the upper limit?

Well 640K is well known memory limit :)
And 512k is the closest power of 2 which still leaves plenty of space for
the trampoline.
 
> Looking at:
> 
> d0cd7425fab7 ("x86, bios: By default, reserve the low 64K for all BIOSes")
> 
> and reading that bugzilla
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=16661
> 
> it sounds like it is the amount of memory where BIOS could put crap in.
> 
> Long story short, we reserve the first 64K by default so if someone
> reserves the total range of 640K the early code could probably say
> something like
> 
> "adjusting upper reserve limit to X for the real-time trampoline"
> 
> when the upper limit is too high so that a trampoline can't fit...
> 
> Which is basically what your solution does...
> 
> But then the previous behavior used to work everywhere so if it is only
> cheating, I don't mind doing that as long as boxes keep on booting.
> 
> Or am I missing an aspect?

Another aspect IMHO is that making things explicit would reduce the amount
of hidden dependencies and in the end make x86::setup_arch() less fragile.

I'm looking now also at:

5bc653b73182 ("x86/efi: Allocate a trampoline if needed in efi_free_boot_services()")

that retries the allocation of trampoline when we free EFI services, so
there is also could be a conflict between reserve_real_mode() and
reserve_bios_regions() in case EBDA is too low.

So what we have is
- BIOSes that corrupt low memory
- EBDA of unknown size that can be as low as 128k, so we reserve everything
  from EBDA start to 640k because we don't trust BIOSes to report EBDA size 
  properly
- Real mode blob of about 20-30k that must live in the first 640k
- Build time setting to reserve Xk (4K <= X <= 640k) with the default set
  to 64k
- Command line option to reserve Yk (4K <= Y <= 640k), this takes precedence
  over the build time option.
- A late fallback that uses memory freed from EFI data to place real mode
  trampoline there

It seems to me that we can drop both  build time and run time options
entirely, reserve 64k early to avoid having trampoline there and then
always reserve everything below 640k after reserve_real_mode().

The late fallback for systems that have most of low memory busy with
BIOS/EFI will remain intact as it does not do memblock allocation anyway.

-- 
Sincerely yours,
Mike.
