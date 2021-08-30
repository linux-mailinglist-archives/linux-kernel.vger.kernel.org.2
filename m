Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE25F3FBEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhH3WN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:13:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbhH3WN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:13:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630361551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D6uP0jH77Cf5U+rQ18KicmniIM74e6euw6V8hH0Ls/0=;
        b=JpAbK37n7YhosWebfCKIRWKQUqdRVURN6rhEl+5xLKL3SFGgYfuhPSfnx45nySVquVYJwV
        GGQp3kBmnBDVG75vFgPpl5jMtCw8OyyBrQ6EwuPE7RFWlqi0+LiPBGS20HnDwPG2sp4wfJ
        DhKTumJvDc6zPn67p9TX8fCcKspvGqnVAwHey90LXdGl7BL3q010IVx5wyh36e3n1/y50q
        3Dg53GjRPzfAKrHu4xTnK28NSiToRAv8keuKDq26H0Om3w5MthuLhy4rtzKn9nPGF2Fzu0
        jkTdGTJ2OpXWiCor7gJ/offOiav0SN1JA1XTJYFM2auN3EEQjsfjkhZRhva+8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630361551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D6uP0jH77Cf5U+rQ18KicmniIM74e6euw6V8hH0Ls/0=;
        b=Zy/WzVRXoM8cSmmug6Q878ykEtxx5G5daNuSM9YF4rZDgGpaD6+7VRABdDtoyJ4/lA60/6
        69dPWiEmkOd4IMDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <YS1OE6FRi4ZwEF8j@zeniv-ca.linux.org.uk>
 <CAHk-=wh57tMaJxcH=kWE4xdKLjayKSDEVvMwHG4fKZ5tUHF6mg@mail.gmail.com>
Date:   Tue, 31 Aug 2021 00:12:30 +0200
Message-ID: <87o89efupd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 15:00, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 2:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> There's a place where we care about #PF vs. #MC (see upthread)...
>
> Interestingly (or perhaps not), that case is a problem case in general
> for "fault_in_pages_readable()".
>
> That function will only access data every PAGE_SIZE bytes, but if we
> have other exceptions that can happen at a cacheline granularity, the
> whole "retry after faulting pages in" may fail.
>
> So that kind of
>
>  - try to copy from user space
>
>  - if that fails, do fault_in_pages_readable() and retry
>
> loop can loop forever.
>
> restore_fpregs_from_user() is odd and special in trying to deal with
> it by looking at the error code. I'm n ot convinced it's the right
> thing to do, since it just means that all the other places we do this
> can be problematic.

It's not only about #MC. *RSTOR can also trigger #GP in case that the
user buffer contains garbage and we clearly don't want to loop forever
on that either.

Thanks,

        tglx
