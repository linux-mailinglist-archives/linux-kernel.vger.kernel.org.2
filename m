Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207BB40B533
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhINQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:48:17 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42124 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhINQsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:48:16 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 18EGksoH011021;
        Tue, 14 Sep 2021 18:46:54 +0200
Date:   Tue, 14 Sep 2021 18:46:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: how many memset(,0,) calls in kernel ?
Message-ID: <20210914164654.GC10488@1wt.eu>
References: <1c4a94df-fc2f-1bb2-8bce-2d71f9f1f5df@interlog.com>
 <20210912045608.GB16216@1wt.eu>
 <88976a40175c491fb5e3349f6686ad67@AcuMS.aculab.com>
 <20210913160945.GA2456@1wt.eu>
 <15cd0a8e72b3460db939060db25dd59a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cd0a8e72b3460db939060db25dd59a@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:23:40AM +0000, David Laight wrote:
> > The exact point is, here it's up to the compiler to decide thanks to
> > its builtin what it considers best for the target CPU. It already
> > knows the fixed size and the code is emitted accordingly. It may
> > very well be a call to the memset() function when the size is large
> > and a power of two because it knows alternate variants are available
> > for example.
> > 
> > The compiler might even decide to shrink that area if other bytes
> > are written just after the memset(), leaving only holes touched by
> > memset().
> 
> You might think the compiler will make sane choices for the target CPU.
> But it often makes a complete pig's breakfast of it.
> I'm pretty sure 6 'rep stos' is slower than 6 write an absolutely
> everything - with the possible exception of an 8088.

It can be suboptimal (especially with the moderate latencies required
for small areas), but my point is that in plenty of cases the memset()
call will be totally eliminated. Example:

The file:
  #include <string.h>

  int f(int a, int b)
  {
        struct {
                int n1;
                int n2;
                int n3;
                int n4;
        } s;

        memset(&s, 0, sizeof(s));

        s.n2 = a;
        s.n3 = b;

        return s.n1 + s.n2 + s.n3 + s.n4;
  }

gives:

  0000000000000000 <f>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      retq   

See ? The builtin allowed the compiler to *know* that these areas
were zeroes and could optimize them away. More importantly this
can save some reads from being performed, with the data being only
written into:

  #include <string.h>

  struct {
        int n1;
        int n2;
  } s;

  void f(int a, int b)
  {

        memset(&s, 0, sizeof(s));

        s.n1 |= a;
        s.n2 |= b;
  }

Gives:

  0000000000000000 <f>:
   0:   89 3d 00 00 00 00       mov    %edi,0x0(%rip)        # 6 <f+0x6>
   6:   89 35 00 00 00 00       mov    %esi,0x0(%rip)        # c <f+0xc>
   c:   c3                      retq   

See ? Just plain writes, no read-modify-write of the memory area.
If you'd call an external memset() function, you'd instantly lose
all these possibilities:

  0000000000000000 <f>:
   0:   55                      push   %rbp
   1:   ba 08 00 00 00          mov    $0x8,%edx
   6:   89 fd                   mov    %edi,%ebp
   8:   bf 00 00 00 00          mov    $0x0,%edi
   d:   53                      push   %rbx
   e:   89 f3                   mov    %esi,%ebx
  10:   31 f6                   xor    %esi,%esi
  12:   48 83 ec 08             sub    $0x8,%rsp
  16:   e8 00 00 00 00          callq  1b <f+0x1b>
  1b:   09 2d 00 00 00 00       or     %ebp,0x0(%rip)        # 21 <f+0x21>
  21:   09 1d 00 00 00 00       or     %ebx,0x0(%rip)        # 27 <f+0x27>
  27:   48 83 c4 08             add    $0x8,%rsp
  2b:   5b                      pop    %rbx
  2c:   5d                      pop    %rbp
  2d:   c3                      retq   

Thus the fact that the compiler has knowledge of the memset() is useful.

Willy
