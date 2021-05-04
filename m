Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9701A3731A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEDUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:52:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:52895 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhEDUwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:52:09 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 144Kp9pY019879;
        Tue, 4 May 2021 22:51:09 +0200
Date:   Tue, 4 May 2021 22:51:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Vladislav K. Valtchev" <vladislav.valtchev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org,
        linux-toolchains@vger.kernel.org
Subject: Re: GCC, unaligned access and UB in the Linux kernel
Message-ID: <20210504205109.GA19716@1wt.eu>
References: <c8fa8ea79ffaa5c87dac9ea16e12088c94a35faf.camel@gmail.com>
 <877dkekzj8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dkekzj8.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, May 04, 2021 at 10:35:39PM +0200, Florian Weimer wrote:
> > [1] If aliasing is involved, even with -fno-strict-aliasing, unaligned access
> > WILL break some code, today. Check the following example:
> >
> >    int h(int *p, int *q){
> >      *p = 1;
> >      *q = 1;
> >      return *p;
> >    }
> >
> >    typedef __attribute__((__may_alias__)) int I;
> >
> >    I k(I *p, I *q){
> >      *p = 1;
> >      *q = 1;
> >      return *p;
> >    }
> >
> > Starting from GCC 8.1, both h() and k() will always return 1, when compiled with
> > -O2, even with -fno-strict-aliasing.
> >
> > [2] Some SIMD instructions have alignment requirements that recent compilers
> > might just start to assume to be true, in my current understanding. In general,
> > SIMD instructions can be emitted automatically by the compiler because of auto-
> > vectorization. But, fortunately, that *cannot* happen in the kernel because we
> > build with -fno-mmx, -fno-sse, -fno-avx etc.
> 
> Cc:ing linux-toolchains.
> 
> __attribute__ ((aligned (1))) can be used to reduce alignment, similar
> to attribute packed on structs.  If that doesn't work for partially
> overlapping accesses, that's probably a compiler bug.

Indeed, for me it fixes the example above with gcc-8.4:

Before:
0000000000000020 <k>:
  20:   c7 07 01 00 00 00       movl   $0x1,(%rdi)
  26:   b8 01 00 00 00          mov    $0x1,%eax
  2b:   c7 06 01 00 00 00       movl   $0x1,(%rsi)
  31:   c3                      retq   

After:
0000000000000020 <k>:
  20:   c7 07 01 00 00 00       movl   $0x1,(%rdi)
  26:   c7 06 01 00 00 00       movl   $0x1,(%rsi)
  2c:   8b 07                   mov    (%rdi),%eax
  2e:   c3                      retq   

That's good to know :-)

Willy
