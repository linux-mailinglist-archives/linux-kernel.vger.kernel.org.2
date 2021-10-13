Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7390C42C0F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhJMNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhJMNI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:08:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:06:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1208001796bb6dc2170571.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:800:1796:bb6d:c217:571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 694211EC051F;
        Wed, 13 Oct 2021 15:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634130384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=egY9QUF07zQ6Z/mPU007YdsMlu+rccDJH0kcmGGMAqw=;
        b=epCKqhKWt0fObx4ny2nGQEQ82jtFMLd/WCTDKd7mCI+NlyI3mY9rwJV1UDhonaP+a2GoYC
        YMirwmE6szRI2VTVfBghKg7iCO64atp7DGqmKSOkjkSRD5yCyRB/BQ1RvEt9CkgxYzo90w
        ecHTSzPnulfDuAUz8rhdeO/YxsMdnF0=
Date:   Wed, 13 Oct 2021 15:06:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Michael Matz <matz@suse.de>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <YWbZz7gHBV18QJC3@zn.tnic>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
 <20211013125142.GD5485@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013125142.GD5485@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:51:42PM +0200, Willy Tarreau wrote:
> > > "Figure 3.4: Register Usage" is not the answer, if it were, nolibc.h
> > > would be broken as it is missing "rdi", "rsi", "rdx" in the clobber list.
> > 
> > It is not about what happens in practice but what the contract is:
> > syscall argument registers can potentially get clobbered and userspace
> > should treat them as such. Because if the kernel decides to actually
> > clobber them for whatever reason and some userspace thing thinks
> > otherwise, then it is the userspace thing's problem as it doesn't adhere
> > to the well known ABI.
> 
> I agree and that's why my question was about that authoritative doc, to
> know the contract (since this one will not change under our feet). But
> according to the doc you pointed, here the contract for syscalls is that
> only rcx and r11 are clobbered (and rax gets the result). If so, I'm
> personally fine with this.

Well, I guess that doc could probably state explicitly that argument
registers are callee-clobbered.

The way I'm reading that doc is, as already pasted:

"The Linux AMD64 kernel uses internally the same calling conventions as
user-level applications (see section 3.2.3 for details).

...

The interface between the C library and the Linux kernel is the same as
for the user-level applications with the following differences:

The kernel interface uses %rdi , %rsi , %rdx , %r10 , %r8 and %r9."

So, calling conventions in the kernel are the same as for user-level
apps with the register difference. And argument registers are
callee-clobbered.

Now, when you look at section 3.2.3 Parameter Passing and scroll to
Figure 3.4: Register Usage, it'll give you the info that those argument
registers are not callee-saved.

They appear to be but that's not in the contract. Which means that they
can *potentially* get clobbered. The stress being on "potentially".

And just to make sure I'm reading this correctly, I've asked one of the
authors of that document (CCed) and he confirmed what I'm stating above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
