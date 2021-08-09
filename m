Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D33E4438
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhHIKxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233254AbhHIKxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC1716023D;
        Mon,  9 Aug 2021 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628506363;
        bh=eC5/ptDREwdD+Mi5IQ60r27+kT5wy5bRZnE+psxz7s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBkRRgmLfRcjEB2tTXpETlkjSBkuUoq2zHM7UIdOyaRqtqwwPGzQfEwK0LktKgT1L
         GadNmtMDJ/YSSalSVnfX9n/F4ZUBDctKpAdg6W4hMwpn8LFcxvZnVxYqPaScFxdyMB
         57wFPZXwQhRvgg33G0lCN6ztK02ryRPOPchikZn4TIXuVpNH8SquSVfmqfr028gQUy
         4Sqy9MCam8FLRxlz5rbzXORFscm8HQ9gklK1jw1PxLFOwR1OzpP5J4hCMGjqZgvvkQ
         rP7k2REVJ33TIZa3HVkb7wdxdRo1aamgLKSe0NVrUWR+3Splygt16YYElZB6ndkU2S
         2hSxXCn4TYsvw==
Date:   Mon, 9 Aug 2021 11:52:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        mark.rutland@arm.com
Subject: Re: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20210809105238.GA5693@willie-the-truck>
References: <20210806135331.GA2951@willie-the-truck>
 <CAHk-=whNiAtCUqeCAcq+GKjmOXFfLCYA84TpeeL2085c+BdmQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNiAtCUqeCAcq+GKjmOXFfLCYA84TpeeL2085c+BdmQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[+Mark]

On Fri, Aug 06, 2021 at 11:40:33AM -0700, Linus Torvalds wrote:
> On Fri, Aug 6, 2021 at 6:53 AM Will Deacon <will@kernel.org> wrote:
> >
> > Please pull these arm64 fixes for -rc5. It's all pretty minor but the
> > main fix is sorting out how we deal with return values from 32-bit system
> > calls as audit expects error codes to be sign-extended to 64 bits
> 
> I've pulled this, but that change looks _really_ odd.

Cheers, and yes it does. We're stuck in the middle of the architecture,
the compat ABI and internal kernel expectations. More below.

> First you seem to intentionally *zero-extend* the error value when you
> actually set it in pt_regs, and then you sign-extend them when reading
> them.
> 
> So the rules seem entirely arbitrary: oen place says "upper 32 bits
> need to be clear" and another place says "upper 32 bits need to be
> sign-extended".
> 
> Why this insanity? Why not make the rule be that the upper 32 bits are
> always just sign-extended?

There are a few things which collide here:

The architecture doesn't guarantee that the upper 32-bits of a 64-bit
general purpose register are preserved across an exception return to a
32-bit task. They _might_ be left intact, but it's up to the CPU whether
you get the value you wrote or all zeroes if you read those bits after
taking an exception back to 64-bit state. Consequently, we can't
expose 64-bit registers for 32-bit tasks via ptrace() as the
resulting behaviour is going to vary based on how the hardware feels.
Maybe we could sign-extend everything on exception entry, but that would
necessitate many more syscall wrappers for compat tasks than we currently
have so we could truncate pointer arguments back down to 32 bits.

Instead, we currently handle this by (a) treating the registers of a 32-bit
task as 32 bits (hence the zero extension when writing the value in
syscall_set_return_value()) and (b) explicitly clearing the upper bits of
x0 on exception entry from a 32-bit task in case we previously leaked a
negative syscall return value in there.

The problem then is that some in-kernel users (e.g. audit and some parts of
ptrace which abstract the syscall return value away from the register state)
_do_ want to see sign-extended syscall return arguments in order to match
against error codes (see is_syscall_success()). So we end up in a situation
where we need to sign-extend the return value for those, whilst leaving the
zero-extended version in the actual pt_regs structure.

It's ugly and subtle because the sky doesn't tend to fall in if you get
it wrong. As you can see, we're still fixing it.

Will
