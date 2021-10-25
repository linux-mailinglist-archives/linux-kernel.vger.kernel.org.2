Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C103439B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhJYQYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhJYQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:24:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87233C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:22:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c28so10747220qtv.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hbJWWf4FCxKEG3z41+frjJKy4edqc7oi98ehb9FU6VM=;
        b=14ajX+lPb/EyUHnYs+euJOYIuL1yzSWFOEs8XuhcgDJn/G/c2FX+++CMUfe0rkIvHA
         HY9WNQcuStXcXD3ZuVUQdcQ330HlsUya/pCxxo+v5SacMSj0ZzU8ci+5tsEaQh7Js5xi
         HRd1fkD+S88jGDuzGJQcolQC+CtqCQpubMXj7oSU26cn+Xii/vjeg8Ye9XRh19QaBycC
         Xi8IG1Q9ymNbffP8gjnjoU4p7Z8cedmtA33KexFZnDf3M+V8QoASpzKJ1cLo1kFUn1s4
         44vUGYjNLYvni2HoCTIi7yD1Oxz6/nM102dnebit3f3eJIaspQIEWT0Vf3nP/cSeXUAq
         yv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=hbJWWf4FCxKEG3z41+frjJKy4edqc7oi98ehb9FU6VM=;
        b=HIB3DdwO4nTCNz4TQzmka79WeW4aS+zmlJd/hBanE0AzsMD1IHWZUeLlWTG07pmDqr
         5jGwZlOrdqekoJuOCaCWcNm+oSPlRAGWKCWKvaGo2TP1ffI7b7stRdqibUM8FgEEQtct
         yKuy5WCSKsIeBJ/W7NjuvZ18f6JqPVuGNNtMTXtgttbeTrWWotMct595nVh8/4TEhh/a
         M2uyH/UOhWvyE9bS+mWCPJChwzCe9FCVq9HN9dv1ungsCLZH2ZZPBqDq1uCRjG5f1v/n
         XlfyegoamuJcPbDWHAc8KA+eKciPPhH8/bQuy8+O7ailpm/V043NeFsGt91E+5SKEYkX
         /VZw==
X-Gm-Message-State: AOAM5335It0YT2eMjdnS5m1PpYrnmiYyqJ86KM52B3igIDY8tPHRY1I2
        638JXt5I8TWex/n/cXDR6UNT
X-Google-Smtp-Source: ABdhPJwu15xthVtruzXXDMRYWpUrz9Wa7XN1mAS+iMbgn8Qsj1+8cRAXRNCP3GFctpvfgTvPPFnWww==
X-Received: by 2002:a05:622a:1992:: with SMTP id u18mr19053107qtc.111.1635178936572;
        Mon, 25 Oct 2021 09:22:16 -0700 (PDT)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id t19sm8639143qtn.26.2021.10.25.09.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:22:15 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:22:13 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Message-ID: <YXbZtTR7TBHvdqck@bruce.bluespec.com>
Mail-Followup-To: Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
 <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com>
 <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com>
 <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
 <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
 <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
 <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:47:49PM +0800, Greentime Hu wrote:
> Darius Rad <darius@bluespec.com> 於 2021年10月22日 週五 下午6:40寫道：
> >
> > On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
> > > >
> > > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > > > Hello Darius,
> > > > >
> > > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > > >
> > > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月29日 週三 下午9:28寫道：
> > > > > > > >
> > > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> > > > > > > > > >
> > > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > > This patch adds task switch support for vector. It supports partial lazy
> > > > > > > > > > > save and restore mechanism. It also supports all lengths of vlen.
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > > > > > So this will unconditionally enable vector instructions, and allocate
> > > > > > > > > > memory for vector state, for all processes, regardless of whether vector
> > > > > > > > > > instructions are used?
> > > > > > > > >
> > > > > > > > > Yes, it will enable vector if has_vector() is true. The reason that we
> > > > > > > > > choose to enable and allocate memory for user space program is because
> > > > > > > > > we also implement some common functions in the glibc such as memcpy
> > > > > > > > > vector version and it is called very often by every process. So that
> > > > > > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > > > > > would like to use vector by default. If we disable it by default and
> > > > > > > > > make it trigger the illegal instruction, that might be a burden since
> > > > > > > > > almost every process will use vector glibc memcpy or something like
> > > > > > > > > that.
> > > > > > > >
> > > > > > > > Do you have any evidence to support the assertion that almost every process
> > > > > > > > would use vector operations?  One could easily argue that the converse is
> > > > > > > > true: no existing software uses the vector extension now, so most likely a
> > > > > > > > process will not be using it.
> > > > > > >
> > > > > > > Glibc ustreaming is just starting so you didn't see software using the
> > > > > > > vector extension now and this patchset is testing based on those
> > > > > > > optimized glibc too. Vincent Chen is working on the glibc vector
> > > > > > > support upstreaming and we will also upstream the vector version glibc
> > > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will
> > > > > > > see platform with vector support can use vector version mem* and str*
> > > > > > > functions automatically based on ifunc and platform without vector
> > > > > > > will use the original one automatically. These could be done to select
> > > > > > > the correct optimized glibc functions by ifunc mechanism.
> > > > >
> > > > > In your reply, I noticed that you didn't address Greentime's response
> > > > > here.  But this looks like the key issue.  If common library functions are
> > > > > vector-accelerated, wouldn't it make sense that almost every process would
> > > > > wind up using vector instructions?  And thus there wouldn't be much point
> > > > > to skipping the vector context memory allocation?
> > > > >
> > > >
> > > > This issue was addressed in the thread regarding Intel AMX I linked to in a
> > > > previous message.  I don't agree that this is the key issue; it is one of a
> > > > number of issues.  What if I don't want to take the potential
> > > > power/frequency hit for the vector unit for a workload that, at best, uses
> > > > it for the occasional memcpy?  What if the allocation fails, how will that
> > >
> > > Hi Darius,
> > > The memcpy function seems not to be occasionally used in the programs
> > > because many functions in Glibc use memcpy() to complete the memory
> > > copy. I use the following simple case as an example.
> > > test.c
> > > void main(void) {
> > >     return;
> > > }
> > > Then, we compile it by "gcc test.c -o a.out" and execute it. In the
> > > execution, the memcpy() has been called unexpectedly. It is because
> > > many libc initialized functions will be executed before entering the
> > > user-defined main function. One of the example is __libc_setup_tls(),
> > > which is called by __libc_start_main(). The __libc_setup_tls() will
> > > use memcpy() during the process of creating the Dynamic Thread Vector
> > > (DTV).
> > >
> > > Therefore, I think the memcpy() is widely used in most programs.
> > >
> >
> > You're missing my point.  Not every (any?) program spends a majority of the
> > time doing memcpy(), and even if a program did, all of my points are still
> > valid.
> >
> > Please read the discussion in the thread I referenced and the questions in
> > my prior message.
> >
> 
> Hi Darius,
> 
> As I mentioned before, we want to treat vector ISA like a general ISA
> instead of a specific IP. User program should be able to use it
> transparently just like FPU.
> It seems that the use case you want is asking user to use vector like
> a specific IP, user program should ask kernel before they use it and
> that is not what we want to do in this patchset.
> 

Hi Greentime,

Right.

But beyond what I want to do or what you want to do, is what *should* Linux
do?  I have attempted to provide evidence to support my position.  You have
not responded to or addressed the majority of my questions, which is
concerning to me.

// darius

