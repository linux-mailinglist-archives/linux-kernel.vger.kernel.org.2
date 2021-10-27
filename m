Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24F43CA39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbhJ0NAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbhJ0NAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:00:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D590C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:58:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id br18so2309805qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iZIEhrM5Xg4JMkN+j+ydaHItGi0m/Y15lfuP7u4Lxr0=;
        b=nH0DKYQFwd9lTsJcaWkuTZvQ6JuIQa7MJ/YR44rR4T+pDKuu8TvSlmmDoQK8tAvmIz
         9cTuOWvGUBIUgWAGbESd0mBpnmto2gYZgVNFFWkeQAo2c5z+fpJLii4kpi7IQnbX8dqm
         tq+Gp43GYTrTXIGe/jqDAR19THGU0DjVaZpymqxTEJmB+FaWWkED+LxjsCJ5n3NBCVhN
         S6AV11Q4S0aLCQ9w+tpUlwiAY+sd3l1EIbX8IY2FrB7t5ivolXcOm01ZKdpyYrDQDBKk
         UcA0gpOplD9A0gGrQwzlsMGSDeLcf5o6M6ZZxO7cOZo4IwtYU54DdpKMy2yEEHQ7d3pX
         /z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=iZIEhrM5Xg4JMkN+j+ydaHItGi0m/Y15lfuP7u4Lxr0=;
        b=05KDoKxYY51gg0abS2HLoFO7lJqsXyWhCOYXwkf1CCt2breII6EfPC6mjg7z2qz8XP
         EuHXVkT1u4JfWFobqnCCbfX+u259w9mIXemrSlgsBcC+JvjZcla0MxycxZs93YwD17nn
         JLUcI8FY6+guRqtcZtzTW9ZJ8jZ5pE2Poi6764V0G8W+i302M3MsW0D+1GIHPAPPy9S/
         4kZ2338ekrFfiW03r9xUZsuzuZ0vL0vhUFABjchUl0p+eVO4EB99sk2SvV/SblxVYQc8
         lv9cy0nvj8Va7QcXGYLONLJaFeP9/nWFeP6LrRI8roRhe7I1pyvDK/Wc9F0yKjJAy2Zd
         gTNw==
X-Gm-Message-State: AOAM530d3SSUznVkM0fBXbz84BAYywcSmwQblAgNGwKuPue65toNUOjE
        1wNiR/ALQqMp5seHJbFpJVc6/qQjXgPy
X-Google-Smtp-Source: ABdhPJxAplQVToUab2rh+aoWt0sbS4SpO8Yf+M4Wcr6jSnCrGc2v5oShu7WFk7SV329UmwgzFBrhTQ==
X-Received: by 2002:a37:bd01:: with SMTP id n1mr24119608qkf.274.1635339504150;
        Wed, 27 Oct 2021 05:58:24 -0700 (PDT)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id h13sm2578923qko.27.2021.10.27.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:58:22 -0700 (PDT)
Date:   Wed, 27 Oct 2021 08:58:20 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Message-ID: <YXlM7Ipsrz0bgv47@bruce.bluespec.com>
Mail-Followup-To: Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <YVRp5uWFGQrwBpgf@bruce.bluespec.com>
 <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com>
 <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
 <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
 <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
 <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
 <YXbZtTR7TBHvdqck@bruce.bluespec.com>
 <CAHCEeh++tAWVkhg7uEeWGdwp6UDWqShxn8ACWMvApCkiGfgZgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEeh++tAWVkhg7uEeWGdwp6UDWqShxn8ACWMvApCkiGfgZgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 12:44:31PM +0800, Greentime Hu wrote:
> Darius Rad <darius@bluespec.com> 於 2021年10月26日 週二 上午12:22寫道：
> >
> > On Mon, Oct 25, 2021 at 12:47:49PM +0800, Greentime Hu wrote:
> > > Darius Rad <darius@bluespec.com> 於 2021年10月22日 週五 下午6:40寫道：
> > > >
> > > > On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > > > > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > > > > > Hello Darius,
> > > > > > >
> > > > > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > > > > >
> > > > > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月29日 週三 下午9:28寫道：
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> > > > > > > > > > > >
> > > > > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > > > > This patch adds task switch support for vector. It supports partial lazy
> > > > > > > > > > > > > save and restore mechanism. It also supports all lengths of vlen.
> > > > > > >
> > > > > > > [ ... ]
> > > > > > >
> > > > > > > > > > > > So this will unconditionally enable vector instructions, and allocate
> > > > > > > > > > > > memory for vector state, for all processes, regardless of whether vector
> > > > > > > > > > > > instructions are used?
> > > > > > > > > > >
> > > > > > > > > > > Yes, it will enable vector if has_vector() is true. The reason that we
> > > > > > > > > > > choose to enable and allocate memory for user space program is because
> > > > > > > > > > > we also implement some common functions in the glibc such as memcpy
> > > > > > > > > > > vector version and it is called very often by every process. So that
> > > > > > > > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > > > > > > > would like to use vector by default. If we disable it by default and
> > > > > > > > > > > make it trigger the illegal instruction, that might be a burden since
> > > > > > > > > > > almost every process will use vector glibc memcpy or something like
> > > > > > > > > > > that.
> > > > > > > > > >
> > > > > > > > > > Do you have any evidence to support the assertion that almost every process
> > > > > > > > > > would use vector operations?  One could easily argue that the converse is
> > > > > > > > > > true: no existing software uses the vector extension now, so most likely a
> > > > > > > > > > process will not be using it.
> > > > > > > > >
> > > > > > > > > Glibc ustreaming is just starting so you didn't see software using the
> > > > > > > > > vector extension now and this patchset is testing based on those
> > > > > > > > > optimized glibc too. Vincent Chen is working on the glibc vector
> > > > > > > > > support upstreaming and we will also upstream the vector version glibc
> > > > > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will
> > > > > > > > > see platform with vector support can use vector version mem* and str*
> > > > > > > > > functions automatically based on ifunc and platform without vector
> > > > > > > > > will use the original one automatically. These could be done to select
> > > > > > > > > the correct optimized glibc functions by ifunc mechanism.
> > > > > > >
> > > > > > > In your reply, I noticed that you didn't address Greentime's response
> > > > > > > here.  But this looks like the key issue.  If common library functions are
> > > > > > > vector-accelerated, wouldn't it make sense that almost every process would
> > > > > > > wind up using vector instructions?  And thus there wouldn't be much point
> > > > > > > to skipping the vector context memory allocation?
> > > > > > >
> > > > > >
> > > > > > This issue was addressed in the thread regarding Intel AMX I linked to in a
> > > > > > previous message.  I don't agree that this is the key issue; it is one of a
> > > > > > number of issues.  What if I don't want to take the potential
> > > > > > power/frequency hit for the vector unit for a workload that, at best, uses
> > > > > > it for the occasional memcpy?  What if the allocation fails, how will that
> > > > >
> > > > > Hi Darius,
> > > > > The memcpy function seems not to be occasionally used in the programs
> > > > > because many functions in Glibc use memcpy() to complete the memory
> > > > > copy. I use the following simple case as an example.
> > > > > test.c
> > > > > void main(void) {
> > > > >     return;
> > > > > }
> > > > > Then, we compile it by "gcc test.c -o a.out" and execute it. In the
> > > > > execution, the memcpy() has been called unexpectedly. It is because
> > > > > many libc initialized functions will be executed before entering the
> > > > > user-defined main function. One of the example is __libc_setup_tls(),
> > > > > which is called by __libc_start_main(). The __libc_setup_tls() will
> > > > > use memcpy() during the process of creating the Dynamic Thread Vector
> > > > > (DTV).
> > > > >
> > > > > Therefore, I think the memcpy() is widely used in most programs.
> > > > >
> > > >
> > > > You're missing my point.  Not every (any?) program spends a majority of the
> > > > time doing memcpy(), and even if a program did, all of my points are still
> > > > valid.
> > > >
> > > > Please read the discussion in the thread I referenced and the questions in
> > > > my prior message.
> > > >
> > >
> > > Hi Darius,
> > >
> > > As I mentioned before, we want to treat vector ISA like a general ISA
> > > instead of a specific IP. User program should be able to use it
> > > transparently just like FPU.
> > > It seems that the use case you want is asking user to use vector like
> > > a specific IP, user program should ask kernel before they use it and
> > > that is not what we want to do in this patchset.
> > >
> >
> > Hi Greentime,
> >
> > Right.
> >
> > But beyond what I want to do or what you want to do, is what *should* Linux
> > do?  I have attempted to provide evidence to support my position.  You have
> > not responded to or addressed the majority of my questions, which is
> > concerning to me.
> 
> Hi Darius,
> 
> What is your majority questions?
> 

1. How will memory allocation failures for context state memory be reported
to user space?

2. How will a system administrator (i.e., the user) be able to effectively
manage a system where the vector unit, which could have a considerable area
and/or power impact to the system, has one or more of the following
properties:

  a. A single vector unit shared among two or more harts,

  b. Additional power consumption when the vector unit is enabled and idle
versus not being enabled at all,

  c. For a system which supports variable operating frequency, a reduction
in the maximum frequency when the vector unit is enabled, and/or

  d. The inability to enter low power states and/or delays to low power
states transitions when the vector unit is enabled.

3. You contend that the RISC-V V-extension resembles ARM SVE/SVE2, at least
more than Intel AMX.  I do not agree, but nevertheless, why then does this
patchset not behave similar to SVE?  On arm64, SVE is only enabled and
memory is only allocated on first use, *not* unconditionally for all tasks.

// darius

