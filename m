Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3808C403070
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbhIGVp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhIGVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:45:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08657C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:44:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631051090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwEZtV7RNOJuPxbuiITPhai/MjvLXo//N0i32GiO8mU=;
        b=M/OHaJx1pKcT3n4jR+KCXYB3okYGuGq8Vl6E+rxgV9p2JbsSpMZ2y5KEEzpwl9N3SbbDJT
        aBb6oKsfllJbUpq/5ortDi+Hf0u27sD+BpQX/yYfBbT5dTumaYkCLo9T3bSRJ/rm1EVaUS
        QQgYo/BOxJ55pGAceoAWD8Vn5IPDB8MCU+lER0yGj6x0/D09HnY5AzzLcvv8S/dyd1wCnG
        4u1frEUSOLw/W3TQfigHufiVWew3iVIVKNQHiMkfZ4Xq+kJ5kpibHVAsZdJ7fnUXgKIRX4
        SZGAwcOZkGv7gBXQYkyhRNN3/aO9J2SJVVgme6x9KpCClLamrGsL15aS0TNjUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631051090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwEZtV7RNOJuPxbuiITPhai/MjvLXo//N0i32GiO8mU=;
        b=hveSaZWdychyDPfALDh8HDY2213lIIoq0tX7f/ND6CAFF+7CMzIzuZ1mvA/qw5XognJbzL
        UhBMJzdSASa1C1Aw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: Re: [patch V2.1 05/20] x86/extable: Rework the exception table
 mechanics
In-Reply-To: <CAHk-=wjBRQeSROGjfRDY-wRuFfa=NVo57xLeHD2Dv1v0Ra+RLg@mail.gmail.com>
References: <20210907200722.067068005@linutronix.de>
 <20210907200848.528317169@linutronix.de>
 <CAHk-=wjBRQeSROGjfRDY-wRuFfa=NVo57xLeHD2Dv1v0Ra+RLg@mail.gmail.com>
Date:   Tue, 07 Sep 2021 23:44:49 +0200
Message-ID: <87y28883hq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Tue, Sep 07 2021 at 13:37, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Rework the exception fixup mechanics by storing a fixup type number instead
>> of the handler address and invoke the proper handler for each fixup
>> type. Also teach the extable sort to leave the type field alone.
>
> I see why you do this, but it does make the exception handlers less
> flexible. It used to be that you could just make up any exception
> handler without having to inform some centralized place about it.
>
> But I guess that's also a downside, and maybe we don't want the extra
> flexibility.
>
> The bpf case was an example where somebody was able to add their own
> specialized handler, and didn't need to serialize with anybody else.

Yes, I'm aware of that downside. OTOH, the need for special handlers is
rare and not something which happens every other day. Being able to have
more fine granular types without adding a zoo of new handlers seems to
be more useful to me.

> So I don't hate this, I'm just ambivalent about it. On the one hand I
> like the more strict format, on the other hand it's kind of sad.

Yes, but one thing I learned in almost 20 years of maintainership is
that being strict about stuff is absolutely not the worst choice. People
tend to be think that their problem is special - most of the time for
the very wrong reasons - and just add magic crap left and right because
they can. Making the rules more strict forces them to think at least a
bit harder - most of the time with the wrong outcome which is especially
true for out of tree crap, sigh...

> The other reaction I have is that the handler type is now wasteful and
> pointless. I think you could make it be about which *section* the
> exception thing is in, and not need that extra ".long" argument to
> hold a couple of bits of data.
>
> So _ASM_EXTABLE_TYPE() could instead do something like this:
>
>   # define _ASM_EXTABLE_TYPE(from, to, type)                     \
>           .pushsection "__ex_table." #type ,"a" ;                         \
>           .balign 4 ;                                             \
>           .long (from) - . ;                                      \
>           .long (to) - . ;                                        \
>           .popsection
>
> and we'd not have any 'type' field in there at all, because the type
> would be determined by the section is is in.
>
> Hmm?

I actually thought about that, but then I looked at the total extable
storage size of about 6k with a distro config build which in turn made
my lazy alter ego decide that spending the time necessary to teach all
the related code about subsections is better spent for my woodworking
projects and garden fountain experiments.

Thanks,

        tglx
