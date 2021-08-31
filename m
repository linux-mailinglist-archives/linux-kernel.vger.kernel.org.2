Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2A3FC006
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhHaAfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhHaAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:35:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC60C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:34:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630370057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZF4qqQnXb/4fSz0lBZGHElW/Uyy8YkIOQytsRHW6+k=;
        b=yOXWRULFixb9/mm7cCn8uA2k5YsqwZgtvjzdB62PJr0F4l+IkZJO/07MseFxRmjFYSr0zD
        1L5I2RalahplPpQ++se590p7+Q2+fbO74UB8+Dt6AiwayEXY1e9pscWFMsf2uD+/Al1a7W
        75sSsTrLQAaLxyOAQMoNSbcmc71kCf+wfLlgbEnN856FfIgGLZ1VX1H8XZ/IxCRaj8PqkV
        jspBgZJK7can8sDycaX7upxiMjBcWvypAXoScZ+rs3Cn7YGDwTQdcCRVbySF7S34gxShdu
        c2EGVNFjyOsZicT44b8jL4J/QW2ue3gWG4U3KgbpQTbgCKjAS828E2hVoz05MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630370057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZF4qqQnXb/4fSz0lBZGHElW/Uyy8YkIOQytsRHW6+k=;
        b=Ux4gK+XR2ZQTXd+vDDYfy2PjJMsi95WdlHmtdH7Y9p0wlfaydaexVp5jhebYEOigDjHN87
        Dop4TGzKtaFh3rBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
 <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
Date:   Tue, 31 Aug 2021 02:34:16 +0200
Message-ID: <87zgsye9kn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Mon, Aug 30 2021 at 15:00, Linus Torvalds wrote:
> But since the Intel machine check stuff is so misdesigned and doesn't
> work on any normal machines, most people can't test any of this, none
> of this matters, and it's only broken on those "serious enterprise
> machines" setups that people think are better, but are actually just
> almost entirely untested and thus don't work right.

what's worse is that even if you have access to such a machine, there is
no documented way to do proper hardware based error injection.

The injection mechanism which claims to do hardware error injection in
arch/x86/kernel/cpu/mce/inject.c is a farce:

All it does is to "prepare" the MSRs with some fake error values and
raising #MC via int 18 afterwards in the hope that the previously
prepared MSR values are still valid. Great way to test stuff by setting
the MSR to the expected failure value and then raising the exception in
software.

NHM had a documented mechanism to inject at least ECC failures at the
hardware level, but with the later memory controllers this ended up in
the documentation black hole along with all the other undocumented real
HW injection mechanisms which allow actual testing of this stuff.

The HW injection mechanisms definitely exist, but without documentation
they are useless. Intel still thinks that the secrecy around that stuff
is valuable and they can get away with those untestable mechanisms even
for their endeavours in the safety critical space.

It's pretty much the same approach as security through obscurity, but in
the safety case that's even more hillarious.

Though we all know what the 'S' in INTEL stands for... I used to be
Security, but nowadays it's Security _and_ Safety.

Thanks,

        tglx





