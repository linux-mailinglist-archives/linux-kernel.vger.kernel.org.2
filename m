Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98833900D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhCLOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLOaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:30:25 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5599C061574;
        Fri, 12 Mar 2021 06:30:25 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y20so7591305iot.4;
        Fri, 12 Mar 2021 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=bNzo0mP1z+kgGJWfz5V13ZKR8DScWigpAogXUXJ5OSY=;
        b=bOqFZw0W6Ugb15PSmW3R3vpCVh5x5QpzVTK1Ze0YMf7RdHcOGNmgDjORazJoC9fu9L
         9XlDXozk/ZTSeS5sS8iemw86G7sQEww8eJR2vPcqFbdjOOMoplRJN07PmYGVBl61U7zm
         tf93n7WtKHkoWdthTQ3OtYtwL02CZuyNUmbu0nRKQDXyYNgSvY6pEAwwJbn2izwjvluY
         YH6rDS2iUDxM+dycBltpSg1J2Bui75Xp5ZsnNUW/b3yyA7skjggXhBv8DWfClsnLuHTb
         BWMEd2N0FFVL9ziE8opKweo+ITVUs2zTcM4OkYlCyQhPOF4njHY1LJANsYtBNvSHaz7h
         aeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bNzo0mP1z+kgGJWfz5V13ZKR8DScWigpAogXUXJ5OSY=;
        b=qL6Wwoz5Bu+wReQih/LQJaheU5v+SRJGqW3dZ37G4zwklokI43s8Cio2zatmrNWhZG
         S8w7A+TYvz3DYF2uT/bjbKAxsgSyuNeVO//zfKakpKkcFArVYOXOpAKUVGl59F3WdNuq
         cY7/TovFc4VaBbpRSpNl6RDXxbjrLmQgWc+ibZrVKChMyKhTPajInm+ZhXPWdK57psCL
         0TcyHWV2cJhkMiBw73vw3kRKvn0hNh9PT5LepqRS7/1XgMLTtcMGOC0EbDj91rLJbdqp
         Kg1NFw8oseGPktid+QOZfz+WNgA70yGmo5l+nIqH5/koDvPkYDM9M6JIl+NTnFKhQ5OE
         mBIg==
X-Gm-Message-State: AOAM531axZz6figtavDH0m2aJGzLhhcI9uWzbxMo8AJDqvB2aMIqna8Z
        sa83VFXLxVK8oyR2+H0tCWhzLsNUQNDes4sOjkg=
X-Google-Smtp-Source: ABdhPJzm55SroQSLZZJvgViDQN51cbkbYI/HmsvkQWywLGSMPqV+soC9KOotglSJGt51A5RRt2RTeBdw5XkyxBvimQs=
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr10285247ioj.156.1615559425121;
 Fri, 12 Mar 2021 06:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org>
In-Reply-To: <20210312113253.305040674@infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Mar 2021 15:29:48 +0100
Message-ID: <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 1:00 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi!
>
> A while ago Steve complained about x86 being weird for having different NOPs [1]
>
> Having cursed the same thing before, I figured it was time to look at the NOP
> situation.
>
> 32bit simply isn't a performance target anymore, so all we need is a set of
> NOPs that works on all.
>
> x86_64 has two main NOP variants, NOPL and prefix NOP. NOPL was introduced by
> P6 and is architecturally mandated for x86_64. However, some uarchs made the
> choice to limit NOPL decoding to a single port, which obviously limits NOPL
> throughput. Other uarchs have (severe) decoding penalties for excessive (>~3)
> prefixes, hobbling prefix NOP throughput.
>
> But the thing is, all the modern uarchs can handle both without issue; that is
> AMD K10 (2007) and later and Intel Ivy Bridge (2012) and later. The only
> exception is Atom, which has the prefix penalty.
>
> Since ultimate performance of a 10 year old chip (Intel Sandy Bridge, 2011) is
> simply irrelevant today, remove variable NOPs and use NOPL.
>

Hi Peter,

I am an Intel SandyBridge power user and want the ultimate performance
on my hardware.

What does this change exactly mean to/for me?

I got this laptop as the last gift for my birthday in 2012 from my mother.
She died the same year.
So, this is a bit sentimental hardware for me.

It's amazing what this laptop all was involved in.
10+ years of LLVM/Clang for Linux-kernel and Linux graphics stack.
Worked in a Ubuntu/precise 12.04 LTS WUBI (installation) environment -
5 years (full LTS period) long!
How many Linux-kernel bugs got reported and/or fixed...
Debian/stretch...Debian/bullseye with no fresh installation. Rolling release.

I remember my decision in March 2012 not to choose that Asus notebook
with the first hardware-revision of IvyBridge and bought
conservatively a SandyBridge Gen. 2 Samsung notebook.

It's a pity to see no or restricted/limited Vulkan support.

If you are not concerned - life goes on for you.

It's like being white colored not understanding what "Black Lives
Matter" really means.
If people use or talk about white/black listings then allow/deny lists.
Or being a female software developer having a 10-15% less salary
because you are not male - in the same department!
This week we had our 100th anniversary of International Women's Day.
I am not black - I am male - I am not concerned - Live goes on?

Again, this machine is able to do fast Linux-kernel builds with an
adapted Debian Linux v5.10 kernel-config.
If you do NOT use Debian's LLVM/Clang - means build a selfmade
stage1-only LLVM toolchain (saves ~1 hour of build-time) - or a
ThinLTO+PGO optimized LLVM toolchain (saves again ~1 hour of
build-time).
Latest Linus Git plus With Clang-CFI took me today approx. 04:20
[hh:mm] with a selfmade stage1-only LLVM toolchain version 12.0.0-rc3.
Again, this is amazing.

What I wanna try to say is:
This is old hardware but you can - if you are a smart enough -
optimize your builds.

On the other hand I can understand dropping support for XXX whatever hardware...
Where is the limit(ation):
Support 10 years or 7 years old hardware?

Sorry, I am a bit concerned that this is the beginning - or a backdoor
? - to drop (optimized) Intel SandyBridge support.

So, what do I need to do - to have "ultimate performance" back for
SandyBridge with your patchset :-)?

Yes, you are right: Life goes on.

Regards,
- Sedat -


> This gives us deterministic NOPs and restores sanity.
>
>
>
> [1] https://lkml.kernel.org/r/20210302105827.3403656c@gandalf.local.home
>
