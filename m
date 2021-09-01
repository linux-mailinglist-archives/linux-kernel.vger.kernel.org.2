Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB13FD466
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbhIAH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:28:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhIAH2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:28:08 -0400
Received: from zn.tnic (p200300ec2f0f3000ff66408ba4c79392.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3000:ff66:408b:a4c7:9392])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF9E61EC051E;
        Wed,  1 Sep 2021 09:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630481226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6p6hxtBn8gLHMzkoO0aM3iXU0A8QRJ+1AexPaqoZxP0=;
        b=aBEpLFUNgs+kBXiS5AwC0yCDqg3DN5FnxwBqH+NRcVcw9mCi+OgzOhfIcxF7YLFtgHqzBB
        /fuOcdGMdcS1AvVMZWNi9ynkGYuss7WmbFwInv158Vm0/mXEThvDpMrIC1SUmiBWgadeie
        6YjaXvPwXGSZkOzqi3eC5A9KxMVwtYE=
Date:   Wed, 1 Sep 2021 09:27:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS8rbA239gXOT6R6@zn.tnic>
References: <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
 <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
 <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
 <87zgsye9kn.ffs@tglx>
 <YS3cskpK9Uoq3Wc4@zn.tnic>
 <20210831183921.GA1687448@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831183921.GA1687448@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:39:21AM -0700, Luck, Tony wrote:
> You can imagine all you want. And if your imagination is based
> on experiences with very old systems like Haswell (launched in 2015)
> then you'd be right to be skeptical of firmware capabilities.

I wish it were only Haswell boxes. Do you remember how many times I've
talked to you in the past about boxes with broken einj? I don't think
they were all Haswell but I haven't kept track.

> Turn off eMCA in BIOS to avoid this.

I'll try. That is, provided there even is such an option.

> The injection controls in the memory controller can only be accessed
> in SMM mode. Some paranoia there that some ring0 attack could inject
> errors at random intervals causing major costs to diagnose and replace
> "failing" DIMMs. So documentation wouldn't help Linux because it just
> can't twiddle the necessary bits in the h/w.

Yah, that's why this thing needs a BIOS switch which controls injection.
And probably they do that already.

> Downsides of ACPI/EINJ today:
> 1) Availability on production machines. It is always disabled by default
> in BIOS.

That's ok.

> OEMs may not provide a setup option to turn it on (or may have deleted
> the code to support it completely).

Yeah, that's practically the same thing I'm complaining about - einj is
just as useless as before in that case.

> Intel's pre-production servers always have the code, and the setup
> option to enable.

Except that only you and a couple of partners have access to such
boxes. I guess tglx has too and if so that at least answers his initial
complaint about not having an injection method to test kernel code.

> 2) Doesn't inject to 3D-Xpoint (that has its own injection method, but
> it is annoying to have to juggle two methods).

I guess that doesn't matter for our use case of wanting to test the MCE
code, provided one can at least inject somewhere.

> 3) Hard/impossible to inject into SGX memory (because BIOS is untrusted
> and isn't allowed to do a store to push the poison data to DDR).

Oh well.

So, I really wanna believe you that injection capability has improved
but until I see it with my own eyes, I will remain very much sceptical.
And considering how firmware and OEMs are at play here, sceptical is
just the right stance.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
