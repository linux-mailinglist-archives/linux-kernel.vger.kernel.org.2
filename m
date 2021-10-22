Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2853E4375A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJVKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJVKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:43:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288BC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:40:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id k29so2155099qve.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sUVjp8ylZZVSdfkE1WPLfIZTKc+gVGNAh/eKy9l2f8A=;
        b=BqkJ/dhwTBmp2BOeOgHLCnxzSAVykRsIWMhm8Hs+vm2yxtc0TQfa2DvmoFWsBrUT60
         XJsSHQ23WjE2nN7xkVOgI7rq34K3Ao9w7tygPYZZmEI3L7L3Zxn73qPwuOwUxgdLJtmP
         /UXqnfieObs9ucNqHx1B5ULpnGgS0JzqwwMjRl65266+Ngv3PhWjeW6NrEsXwnmKMSwI
         XJtPmtRKAmvhwfd3ib+S1eDZDOTFuEVzJbtLlZppiNrjYgIpjwN0fogEVllsAHfxAwjF
         /Ufo+alPYEFgUMHASM9ETDBnMYC+LXdlMYx2KjxzNrlTwdX1SHL7zFdm8Tmk+kxaPuHi
         pEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=sUVjp8ylZZVSdfkE1WPLfIZTKc+gVGNAh/eKy9l2f8A=;
        b=jP/YaTx7BDss9UVEqrsOKZ+aQeMaI5DHMiQcXjRlym98Q9CEXFM1HHDYkjPCAhIuEl
         U6ob9bdK5VdI7f5ifY81+Ph3gT0zdJgotGyw0tmOWNyBltQLzGreiQtbQ0/LxV4L9Nfb
         DtJxWoF0BuunltaeTRh3WlyuLf7nqRJSUSqm5K0vSybUOp5x2kzo7hL2clZZQFsG4Mqd
         9goXfgOHxchT7BZfHYcUswRBWln0Yn3GazrELCOKzoV8TJzYQhriY1xGzZOPxqanGlyd
         f320SE+nYcT9JoPqc7FC7JV9Bz49/r/gfo6+L0vBTx3At4R9b4L6tRn1fXxVWalHxo2O
         MGHQ==
X-Gm-Message-State: AOAM5337ZYYLqu7TOwuT7vsNsJkFoOTx5bChGaAIBMXWfJiKrjiONNjo
        V+qvnoKSDmGLMH4/ewFVcljf
X-Google-Smtp-Source: ABdhPJxSmVzGUzviEqV3mXU210bnW76vIBwtO040YCDRErzisjptsK6wp4mcgfwVGWptW68yO+zHQw==
X-Received: by 2002:a05:6214:e41:: with SMTP id o1mr11046829qvc.0.1634899249145;
        Fri, 22 Oct 2021 03:40:49 -0700 (PDT)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id g1sm3877775qkd.89.2021.10.22.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:40:48 -0700 (PDT)
Date:   Fri, 22 Oct 2021 06:40:46 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Message-ID: <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
Mail-Followup-To: Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
 <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
 <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com>
 <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com>
 <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
 <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
> >
> > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > Hello Darius,
> > >
> > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > >
> > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > Darius Rad <darius@bluespec.com> 於 2021年9月29日 週三 下午9:28寫道：
> > > > > >
> > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> > > > > > > >
> > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > This patch adds task switch support for vector. It supports partial lazy
> > > > > > > > > save and restore mechanism. It also supports all lengths of vlen.
> > >
> > > [ ... ]
> > >
> > > > > > > > So this will unconditionally enable vector instructions, and allocate
> > > > > > > > memory for vector state, for all processes, regardless of whether vector
> > > > > > > > instructions are used?
> > > > > > >
> > > > > > > Yes, it will enable vector if has_vector() is true. The reason that we
> > > > > > > choose to enable and allocate memory for user space program is because
> > > > > > > we also implement some common functions in the glibc such as memcpy
> > > > > > > vector version and it is called very often by every process. So that
> > > > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > > > would like to use vector by default. If we disable it by default and
> > > > > > > make it trigger the illegal instruction, that might be a burden since
> > > > > > > almost every process will use vector glibc memcpy or something like
> > > > > > > that.
> > > > > >
> > > > > > Do you have any evidence to support the assertion that almost every process
> > > > > > would use vector operations?  One could easily argue that the converse is
> > > > > > true: no existing software uses the vector extension now, so most likely a
> > > > > > process will not be using it.
> > > > >
> > > > > Glibc ustreaming is just starting so you didn't see software using the
> > > > > vector extension now and this patchset is testing based on those
> > > > > optimized glibc too. Vincent Chen is working on the glibc vector
> > > > > support upstreaming and we will also upstream the vector version glibc
> > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will
> > > > > see platform with vector support can use vector version mem* and str*
> > > > > functions automatically based on ifunc and platform without vector
> > > > > will use the original one automatically. These could be done to select
> > > > > the correct optimized glibc functions by ifunc mechanism.
> > >
> > > In your reply, I noticed that you didn't address Greentime's response
> > > here.  But this looks like the key issue.  If common library functions are
> > > vector-accelerated, wouldn't it make sense that almost every process would
> > > wind up using vector instructions?  And thus there wouldn't be much point
> > > to skipping the vector context memory allocation?
> > >
> >
> > This issue was addressed in the thread regarding Intel AMX I linked to in a
> > previous message.  I don't agree that this is the key issue; it is one of a
> > number of issues.  What if I don't want to take the potential
> > power/frequency hit for the vector unit for a workload that, at best, uses
> > it for the occasional memcpy?  What if the allocation fails, how will that
> 
> Hi Darius,
> The memcpy function seems not to be occasionally used in the programs
> because many functions in Glibc use memcpy() to complete the memory
> copy. I use the following simple case as an example.
> test.c
> void main(void) {
>     return;
> }
> Then, we compile it by "gcc test.c -o a.out" and execute it. In the
> execution, the memcpy() has been called unexpectedly. It is because
> many libc initialized functions will be executed before entering the
> user-defined main function. One of the example is __libc_setup_tls(),
> which is called by __libc_start_main(). The __libc_setup_tls() will
> use memcpy() during the process of creating the Dynamic Thread Vector
> (DTV).
> 
> Therefore, I think the memcpy() is widely used in most programs.
> 

You're missing my point.  Not every (any?) program spends a majority of the
time doing memcpy(), and even if a program did, all of my points are still
valid.

Please read the discussion in the thread I referenced and the questions in
my prior message.

> > get reported to user space (hint: not well)?  According to Greentime,
> > RISC-V vector is similar to ARM SVE, which allocates memory for context
> > state on first use and not unconditionally for all processes.
> >
