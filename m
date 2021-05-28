Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09D394454
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhE1OnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhE1OnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:43:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:41:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e8e00d6a866fcf7197725.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:d6a8:66fc:f719:7725])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAB5E1EC056D;
        Fri, 28 May 2021 16:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622212906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uAb+kHRjxNwR2MPKE4B203s8wVuUkqC3DTmz/XimwzU=;
        b=F+/yKSQQJiNdc21euAgys4F02wyOKPVdB1h8CAT9RqVK34A0ES2/C/aLgURHnR27HFEuaS
        ekfK0nhCIUYqswVrFJWM/iVuxCJHsBV2ltlo8oMcZXYdLKzLorpO9uoPgsYXWeC2GCPPLg
        VDuaOY/GF7rCg4oLhQtO/ZEfL+VxDdA=
Date:   Fri, 28 May 2021 16:41:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
Message-ID: <YLEBJM0HbQkuDdqV@zn.tnic>
References: <20210526081100.12239-1-rppt@kernel.org>
 <YK4LGUDWXJWOp7IR@zn.tnic>
 <YK53kWHb4cPeeHsd@kernel.org>
 <YK6QFLUoPZ7btQfH@zn.tnic>
 <YK+gv0vDfLVD7Sqp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YK+gv0vDfLVD7Sqp@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:38:07PM +0300, Mike Rapoport wrote:
> Well 640K is well known memory limit :)

Yah, that I remember - was just wondering why but I guess it was out of
caution to cover all that a BIOS *could* touch, see hpa's reply.

> Another aspect IMHO is that making things explicit would reduce the amount
> of hidden dependencies and in the end make x86::setup_arch() less fragile.

Hohumm.

> I'm looking now also at:
> 
> 5bc653b73182 ("x86/efi: Allocate a trampoline if needed in efi_free_boot_services()")
> 
> that retries the allocation of trampoline when we free EFI services, so
> there is also could be a conflict between reserve_real_mode() and
> reserve_bios_regions() in case EBDA is too low.
> 
> So what we have is
> - BIOSes that corrupt low memory
> - EBDA of unknown size that can be as low as 128k, so we reserve everything
>   from EBDA start to 640k because we don't trust BIOSes to report EBDA size 
>   properly
> - Real mode blob of about 20-30k that must live in the first 640k
> - Build time setting to reserve Xk (4K <= X <= 640k) with the default set
>   to 64k
> - Command line option to reserve Yk (4K <= Y <= 640k), this takes precedence
>   over the build time option.
> - A late fallback that uses memory freed from EFI data to place real mode
>   trampoline there
> 
> It seems to me that we can drop both  build time and run time options
> entirely, reserve 64k early to avoid having trampoline there and then
> always reserve everything below 640k after reserve_real_mode().
> 
> The late fallback for systems that have most of low memory busy with
> BIOS/EFI will remain intact as it does not do memblock allocation anyway.

Yah, I certainly like the simplification. The first 640K seem to be a
minefield anyway and to quote from that bugzilla again:

https://bugzilla.kernel.org/show_bug.cgi?id=16661#c2

"As far as I know, Windows 7 actually reserves all memory below 1 MiB to
avoid BIOS bugs."

so yeah, I think we should do that. But pls put that justification above
in the commit message so that we know why we did it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
