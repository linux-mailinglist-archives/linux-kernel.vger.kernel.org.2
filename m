Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13B44B322
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbhKITYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbhKITYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:24:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A4C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:21:33 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j17so5810480qtx.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uNpI6k9ALW5jSd1R5xah2OJpaz/eLKtkzQ460q8jWkk=;
        b=5sndLaFGtfhn9c1FzosGnGT/aBUD2TSyd2sZADwoBCY11P1Y3mqa2qGEJEQ1/gE1au
         peBgpV7nI89Ra5hsLHxoCRXiJ86Xgt78sP+fzvkLyBhzIMxNDClm2OQ+RGh412G+Xk1P
         7JLbJKNiSDO9so/UMQu8Hi2bDhRslv/rv39ByMbmziH5agk1zoHQgErwNgZjWsHLX4Iu
         s0+bnHpODtHvH3XKW7XKYiVqHPCh13z2r2wr/nNVXwgG4qz6kE7ZQHICPapH94ZqIh/M
         T1j1ZNuajgI5wt/WNxMYeyu5766QMcqkj4chpTAu/BV2CuKOrjURnD+m/hGxtJo9dJLv
         hFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=uNpI6k9ALW5jSd1R5xah2OJpaz/eLKtkzQ460q8jWkk=;
        b=V01pOcYfS9MAlqGZhUuS/F5AKN+sX67GrVQiqU4fgxnCoG1JwOBKczjgE1F53A1qzc
         W3S7vv1LAWXTp0hOFv357WpTuwpMVdIK0OtoxrTJXS3udmSbAo4zGomXnJnjzasRNNsp
         LKQZm/988SX/yjubVS1Xoh4x0A06TZ9kkg5leONcT48rnVgxBjTSfqxx+goK0/v+L43/
         EVASIXEa8IwEG5EHOOhPdvZ05o8nm3Nhvc6wTevG9wKkvL6UAS34MPcxwXeOoNFg8hqK
         COXYormDb3nPZzWykT79/fp7TOqNjKr0MF8kbFSs6dbxq7IkHGHEI51UHmpER87mXSG0
         iBbA==
X-Gm-Message-State: AOAM533oU+MufGm/XkW9+DrQFJDNFKLsQsD6LRxaKlVaiI4Rrxheh/qD
        VlL98hxMMtD+byDZCMGPDp0j
X-Google-Smtp-Source: ABdhPJwVMHkjWL+b5aoloTzGHABZRQ0yeMxIvRdr/ApY+cdZQNVGlJV3SFXRFnzE5bIP9d42d7GQTA==
X-Received: by 2002:ac8:580b:: with SMTP id g11mr10911498qtg.272.1636485692171;
        Tue, 09 Nov 2021 11:21:32 -0800 (PST)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id de26sm9821560qkb.81.2021.11.09.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 11:21:28 -0800 (PST)
Date:   Tue, 9 Nov 2021 14:21:26 -0500
From:   Darius Rad <darius@bluespec.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Message-ID: <YYrKNmyn3OIOvhLN@bruce.bluespec.com>
Mail-Followup-To: Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <YVxZspMO7rAvtMBS@bruce.bluespec.com>
 <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
 <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
 <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
 <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
 <YXbZtTR7TBHvdqck@bruce.bluespec.com>
 <CAHCEeh++tAWVkhg7uEeWGdwp6UDWqShxn8ACWMvApCkiGfgZgQ@mail.gmail.com>
 <YXlM7Ipsrz0bgv47@bruce.bluespec.com>
 <CAHCEehJRGQwkVYiKTFh7r0sp=JnpTxdgy3CeVG=UYA2JMjqJRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEehJRGQwkVYiKTFh7r0sp=JnpTxdgy3CeVG=UYA2JMjqJRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:49:03PM +0800, Greentime Hu wrote:
> Darius Rad <darius@bluespec.com> 於 2021年10月27日 週三 下午8:58寫道：
> >
> > On Tue, Oct 26, 2021 at 12:44:31PM +0800, Greentime Hu wrote:
> > > Darius Rad <darius@bluespec.com> 於 2021年10月26日 週二 上午12:22寫道：
> > > >
> > > > On Mon, Oct 25, 2021 at 12:47:49PM +0800, Greentime Hu wrote:
> > > > > Darius Rad <darius@bluespec.com> 於 2021年10月22日 週五 下午6:40寫道：
> > > > > >
> > > > > > On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > > > > > > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > > > > > > > Hello Darius,
> > > > > > > > >
> > > > > > > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > > > > > > >
> > > > > > > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月29日 週三 下午9:28寫道：
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > > > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > > > > > > This patch adds task switch support for vector. It supports partial lazy
> > > > > > > > > > > > > > > save and restore mechanism. It also supports all lengths of vlen.
> > > > > > > > >
> > > > > > > > > [ ... ]
> > > > > > > > >
> > > > > > > > > > > > > > So this will unconditionally enable vector instructions, and allocate
> > > > > > > > > > > > > > memory for vector state, for all processes, regardless of whether vector
> > > > > > > > > > > > > > instructions are used?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, it will enable vector if has_vector() is true. The reason that we
> > > > > > > > > > > > > choose to enable and allocate memory for user space program is because
> > > > > > > > > > > > > we also implement some common functions in the glibc such as memcpy
> > > > > > > > > > > > > vector version and it is called very often by every process. So that
> > > > > > > > > > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > > > > > > > > > would like to use vector by default. If we disable it by default and
> > > > > > > > > > > > > make it trigger the illegal instruction, that might be a burden since
> > > > > > > > > > > > > almost every process will use vector glibc memcpy or something like
> > > > > > > > > > > > > that.
> > > > > > > > > > > >
> > > > > > > > > > > > Do you have any evidence to support the assertion that almost every process
> > > > > > > > > > > > would use vector operations?  One could easily argue that the converse is
> > > > > > > > > > > > true: no existing software uses the vector extension now, so most likely a
> > > > > > > > > > > > process will not be using it.
> > > > > > > > > > >
> > > > > > > > > > > Glibc ustreaming is just starting so you didn't see software using the
> > > > > > > > > > > vector extension now and this patchset is testing based on those
> > > > > > > > > > > optimized glibc too. Vincent Chen is working on the glibc vector
> > > > > > > > > > > support upstreaming and we will also upstream the vector version glibc
> > > > > > > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will
> > > > > > > > > > > see platform with vector support can use vector version mem* and str*
> > > > > > > > > > > functions automatically based on ifunc and platform without vector
> > > > > > > > > > > will use the original one automatically. These could be done to select
> > > > > > > > > > > the correct optimized glibc functions by ifunc mechanism.
> > > > > > > > >
> > > > > > > > > In your reply, I noticed that you didn't address Greentime's response
> > > > > > > > > here.  But this looks like the key issue.  If common library functions are
> > > > > > > > > vector-accelerated, wouldn't it make sense that almost every process would
> > > > > > > > > wind up using vector instructions?  And thus there wouldn't be much point
> > > > > > > > > to skipping the vector context memory allocation?
> > > > > > > > >
> > > > > > > >
> > > > > > > > This issue was addressed in the thread regarding Intel AMX I linked to in a
> > > > > > > > previous message.  I don't agree that this is the key issue; it is one of a
> > > > > > > > number of issues.  What if I don't want to take the potential
> > > > > > > > power/frequency hit for the vector unit for a workload that, at best, uses
> > > > > > > > it for the occasional memcpy?  What if the allocation fails, how will that
> > > > > > >
> > > > > > > Hi Darius,
> > > > > > > The memcpy function seems not to be occasionally used in the programs
> > > > > > > because many functions in Glibc use memcpy() to complete the memory
> > > > > > > copy. I use the following simple case as an example.
> > > > > > > test.c
> > > > > > > void main(void) {
> > > > > > >     return;
> > > > > > > }
> > > > > > > Then, we compile it by "gcc test.c -o a.out" and execute it. In the
> > > > > > > execution, the memcpy() has been called unexpectedly. It is because
> > > > > > > many libc initialized functions will be executed before entering the
> > > > > > > user-defined main function. One of the example is __libc_setup_tls(),
> > > > > > > which is called by __libc_start_main(). The __libc_setup_tls() will
> > > > > > > use memcpy() during the process of creating the Dynamic Thread Vector
> > > > > > > (DTV).
> > > > > > >
> > > > > > > Therefore, I think the memcpy() is widely used in most programs.
> > > > > > >
> > > > > >
> > > > > > You're missing my point.  Not every (any?) program spends a majority of the
> > > > > > time doing memcpy(), and even if a program did, all of my points are still
> > > > > > valid.
> > > > > >
> > > > > > Please read the discussion in the thread I referenced and the questions in
> > > > > > my prior message.
> > > > > >
> > > > >
> > > > > Hi Darius,
> > > > >
> > > > > As I mentioned before, we want to treat vector ISA like a general ISA
> > > > > instead of a specific IP. User program should be able to use it
> > > > > transparently just like FPU.
> > > > > It seems that the use case you want is asking user to use vector like
> > > > > a specific IP, user program should ask kernel before they use it and
> > > > > that is not what we want to do in this patchset.
> > > > >
> > > >
> > > > Hi Greentime,
> > > >
> > > > Right.
> > > >
> > > > But beyond what I want to do or what you want to do, is what *should* Linux
> > > > do?  I have attempted to provide evidence to support my position.  You have
> > > > not responded to or addressed the majority of my questions, which is
> > > > concerning to me.
> > >
> > > Hi Darius,
> > >
> > > What is your majority questions?
> > >
> >
> > 1. How will memory allocation failures for context state memory be reported
> > to user space?
> 
> it will return -ENOMEM for some cases or show the warning messages for
> some cases.
> We know it's not perfect, we should enhance that in the future, but
> let's take an example: 256 bits vector length system. 256 bits * 32
> registers /8 = 1KB.

When you say "show the warning message", I assume you mean the kernel will
log a message, which is not reported to user space.  User space will only
see a process unexpectedly die.

As you say, that is not great, and could be done better.  I would be
interested in knowing how you think that could be improved without needing
a user space API, or why it will be acceptable to break the user space API
later.

> 
> > 2. How will a system administrator (i.e., the user) be able to effectively
> > manage a system where the vector unit, which could have a considerable area
> > and/or power impact to the system, has one or more of the following
> > properties:
> 
> As I mentioned before,
> We would like to let user use vector transparently just like FPU or
> other extensions.
> If user knows that this system supports vector and user uses intrinsic
> functions or assembly codes or compiler generating vector codes, user
> can just use it just like FPU.
> If user doesn't know that whether this system support vector or not,
> user can just use the glibc or ifunc in his own libraries to detect
> vector support dynamically.
> 
> >   a. A single vector unit shared among two or more harts,
> >
> >   b. Additional power consumption when the vector unit is enabled and idle
> > versus not being enabled at all,
> >
> >   c. For a system which supports variable operating frequency, a reduction
> > in the maximum frequency when the vector unit is enabled, and/or
> >
> >   d. The inability to enter low power states and/or delays to low power
> > states transitions when the vector unit is enabled.
> 
> We also don't support this kind of system(a single vector unit shared
> among 2 or more harts) in this implementation. I'll add more
> assumptions in the next version patches.
> For the frequency or power issues, I'll also not treat them as a
> special case since we want to treat vector like an normal extension of
> ISA instead of a specific IP.

The problem is that it will likely be impossible to support such systems
without changing the user space API.

If you add an API along the lines of what I suggested, even if there is not
initially support to completely handle such systems, that support could be
added in the future without change to user space.

If such an API is not in place now, that support cannot be added without
breaking user space.

> 
> > 3. You contend that the RISC-V V-extension resembles ARM SVE/SVE2, at least
> > more than Intel AMX.  I do not agree, but nevertheless, why then does this
> > patchset not behave similar to SVE?  On arm64, SVE is only enabled and
> > memory is only allocated on first use, *not* unconditionally for all tasks.
> 
> As we mentioned before, almost every user space program will use glibc

As I mentioned before, I do not agree that every user space program *will*
use vector.

glibc is not the only C library used in Linux.

Whether such support as you are alluding to gets accepted to glibc also
remains to be seen.

> ld.so/libc.so and these libraries will use the vector version
> optimization porting in a system with vector support.
> That's why we don't let it trigger the first illegal instruction
> exception because vector registers will be used at very beginning of
> the program and the illegal instruction exception handling is also
> heavier because we need to go to M-mode first than S-mode which means
> we will need to save context and restore context twice in both M-mode
> and S-mode. Since the vstate will be allocated eventually, why not
> save these 2 context save/restore overhead in both M-mode and S-mode
> for handling this illegal instruction exception. And if the system
> doesn't support vector, glibc won't use the vector porting and the
> Linux kernel won't allocate vstate for every process too.

This is not convincing.  You are saying that a single illegal instruction
exception, for a process that actively desires to use vector instructions,
is more heavy weight than an unconditional allocation of up to 256 kiB per
process, even for those processes that do not use vector.

