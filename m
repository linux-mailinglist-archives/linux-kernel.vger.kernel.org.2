Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2906A3FC3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbhHaHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbhHaHjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:39:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:39:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2f00e5150ccccff88358.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2f00:e515:ccc:cff8:8358])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB5E11EC01A8;
        Tue, 31 Aug 2021 09:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630395535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hjLt7oa05/D8Vi9HscoubNiAV0wTmuAQox8ARWpSiIY=;
        b=q+oQsQkhF6llloRN/lL6fjmzuQo6pr0s+lUAv9DVi6aI5erpUIshxu/ToUciUCbTEw7kDS
        FB9nGDrqOwtCos04zzJX0WPGk2LmxetLA68EgYCaympNGsVNtKlXCW0mN2/l3VFVb4R1tr
        pmy5FcekqpXQ2eHEzhyQjDdLSd4M8MI=
Date:   Tue, 31 Aug 2021 09:39:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS3cskpK9Uoq3Wc4@zn.tnic>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
 <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
 <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
 <87zgsye9kn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgsye9kn.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 02:34:16AM +0200, Thomas Gleixner wrote:
> what's worse is that even if you have access to such a machine, there is
> no documented way to do proper hardware based error injection.

Oh brother, welcome to my nightmare :) How much time to do you have? We
haz cookies.

> The injection mechanism which claims to do hardware error injection in
> arch/x86/kernel/cpu/mce/inject.c is a farce:

No no, that's an *attempt* to have something which at least works on
the arch level, without having other "agents" involved. Just keep on
readin'...

> All it does is to "prepare" the MSRs with some fake error values and
> raising #MC via int 18 afterwards in the hope that the previously
> prepared MSR values are still valid.

What do you mean? Something might swoop in and overwrite them before the
INT? Bah, we can do some locking but it is not worth it.

> Great way to test stuff by setting the MSR to the expected failure
> value and then raising the exception in software.

No no, the great way to do error injection is the ACPI-spec'ed, firwmare
implemented

drivers/acpi/apei/einj.c

Yap, you heard me right, firmware. And when you hear firmware, you can
imagine how it all works in practice... Yeap, exactly.

We even wrote documentation what to do:

Documentation/firmware-guide/acpi/apei/einj.rst

But but, this is firmware so

- it is f*cking broken in all ways imaginable

- if it works, it doesn't support the error type which you wanna inject

- if it does, enterprise sh*t hw has added value crap which analyzes and
looks at hardware errors first</me rolls eyes, trying to remain serious>
so you might get the error report if you get lucky.

So right now wrt to RAS my approach is: don't let it get worse than it
is. Yap, that's called maintainer resignation.

And all those hw vendors can come at me with the fanciest feature ideas
- my reply is: you wanted to do it all in the BIOS. Go do that there
too.

> NHM had a documented mechanism to inject at least ECC failures at the
> hardware level, but with the later memory controllers this ended up in
> the documentation black hole along with all the other undocumented real
> HW injection mechanisms which allow actual testing of this stuff.
> 
> The HW injection mechanisms definitely exist, but without documentation
> they are useless. Intel still thinks that the secrecy around that stuff
> is valuable and they can get away with those untestable mechanisms even
> for their endeavours in the safety critical space.

My impression with error injection with hw people is just like what they
do with perf counters: it counts *something* right? You should be happy
that it does.

So yeah, hw error injection and RAS in general is a stinking pile of
doodoo. If I knew that then, I would've steered away from it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
