Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB543B4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhJZPB1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 11:01:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37858 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233004AbhJZPB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:01:26 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mfNuj-0006FX-DV; Tue, 26 Oct 2021 16:58:57 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Date:   Tue, 26 Oct 2021 16:58:56 +0200
Message-ID: <1915012.4NSqcpqsIS@diego>
In-Reply-To: <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
References: <cover.1631121222.git.greentime.hu@sifive.com> <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com> <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darius,

Am Freitag, 22. Oktober 2021, 12:40:46 CEST schrieb Darius Rad:
> On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > > Hello Darius,
> > > >
> > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > >
> > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月29日 週三 下午9:28寫道：
> > > > > > >
> > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > > > Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> > > > > > > > >
> > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > This patch adds task switch support for vector. It supports partial lazy
> > > > > > > > > > save and restore mechanism. It also supports all lengths of vlen.
> > > >
> > > > [ ... ]
> > > >
> > > > > > > > > So this will unconditionally enable vector instructions, and allocate
> > > > > > > > > memory for vector state, for all processes, regardless of whether vector
> > > > > > > > > instructions are used?
> > > > > > > >
> > > > > > > > Yes, it will enable vector if has_vector() is true. The reason that we
> > > > > > > > choose to enable and allocate memory for user space program is because
> > > > > > > > we also implement some common functions in the glibc such as memcpy
> > > > > > > > vector version and it is called very often by every process. So that
> > > > > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > > > > would like to use vector by default. If we disable it by default and
> > > > > > > > make it trigger the illegal instruction, that might be a burden since
> > > > > > > > almost every process will use vector glibc memcpy or something like
> > > > > > > > that.
> > > > > > >
> > > > > > > Do you have any evidence to support the assertion that almost every process
> > > > > > > would use vector operations?  One could easily argue that the converse is
> > > > > > > true: no existing software uses the vector extension now, so most likely a
> > > > > > > process will not be using it.
> > > > > >
> > > > > > Glibc ustreaming is just starting so you didn't see software using the
> > > > > > vector extension now and this patchset is testing based on those
> > > > > > optimized glibc too. Vincent Chen is working on the glibc vector
> > > > > > support upstreaming and we will also upstream the vector version glibc
> > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will
> > > > > > see platform with vector support can use vector version mem* and str*
> > > > > > functions automatically based on ifunc and platform without vector
> > > > > > will use the original one automatically. These could be done to select
> > > > > > the correct optimized glibc functions by ifunc mechanism.
> > > >
> > > > In your reply, I noticed that you didn't address Greentime's response
> > > > here.  But this looks like the key issue.  If common library functions are
> > > > vector-accelerated, wouldn't it make sense that almost every process would
> > > > wind up using vector instructions?  And thus there wouldn't be much point
> > > > to skipping the vector context memory allocation?
> > > >
> > >
> > > This issue was addressed in the thread regarding Intel AMX I linked to in a
> > > previous message.  I don't agree that this is the key issue; it is one of a
> > > number of issues.  What if I don't want to take the potential
> > > power/frequency hit for the vector unit for a workload that, at best, uses
> > > it for the occasional memcpy?  What if the allocation fails, how will that
> > 
> > Hi Darius,
> > The memcpy function seems not to be occasionally used in the programs
> > because many functions in Glibc use memcpy() to complete the memory
> > copy. I use the following simple case as an example.
> > test.c
> > void main(void) {
> >     return;
> > }
> > Then, we compile it by "gcc test.c -o a.out" and execute it. In the
> > execution, the memcpy() has been called unexpectedly. It is because
> > many libc initialized functions will be executed before entering the
> > user-defined main function. One of the example is __libc_setup_tls(),
> > which is called by __libc_start_main(). The __libc_setup_tls() will
> > use memcpy() during the process of creating the Dynamic Thread Vector
> > (DTV).
> > 
> > Therefore, I think the memcpy() is widely used in most programs.
> > 
> 
> You're missing my point.  Not every (any?) program spends a majority of the
> time doing memcpy(), and even if a program did, all of my points are still
> valid.
> 
> Please read the discussion in the thread I referenced and the questions in
> my prior message.

for people reading along at home, do have a different link by chance?

I.e. the link to
	https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
is not a known message-id on lore.kernel.org it seems.


Thanks
Heiko

> > > get reported to user space (hint: not well)?  According to Greentime,
> > > RISC-V vector is similar to ARM SVE, which allocates memory for context
> > > state on first use and not unconditionally for all processes.
> > >
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 




