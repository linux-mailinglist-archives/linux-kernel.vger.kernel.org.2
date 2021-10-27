Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5B43C992
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbhJ0M1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbhJ0M1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:27:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77609C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:24:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o204so3124168oih.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n3VljdrSouGIKoFzXdHaS2af1F8C8xn5Rnue9lc/jBY=;
        b=bLtN+j6EPt2JwqduCWTSI2aGF4E0c4y5L2O80ui7XhHbE4BbEE5bgaP8jxovP3ZfHC
         fwjQHuXSF3YWUvcibNQ6uk/IkUZv9wTomlj1b8y/uSZn6JBXQC0Jf0qZsZV7VBWCXm3g
         BPuRnAKyPgTWgnZp/IAeNEvHfIDVFDknuKQSrXDjoy9tJCYRrz5fQlgfaZDrVp5EzuF5
         CAvI3LzA38DSYM4ZWNK6G0joJHcPhEtWEldhprnXvuyhrXSiQnWa5sZEXfRyL/FSktSJ
         EbIPf+hg7NGyFXNoYA20GUi8ohuVCwxOeNlbDML0s6U+5a2QU+2I0MgOlYyIJzejySDm
         I7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n3VljdrSouGIKoFzXdHaS2af1F8C8xn5Rnue9lc/jBY=;
        b=PhW+1LSPEAzytCdas6O9xogorPSYUtOE35NCkQMbm73axdWvMsG6H9e7YzlQXl9dwL
         7ne1Qe8C+nmD//0xBc6JxEDeBdm5FG5amaw0GM+LofkWAaZDOXxTlnPkqifUyYzxzK0Y
         M56dMlT0cdgoTtmkWB9PNQxRfUXEdfinohuzRZeeQZwCXfqA0HmciOzwkoWwcECE7XU0
         8IuAkcXp23o+uVJTq/0G83au7ZY7MXvpHVmCsxIQvWyoGF55Lii6TQakBeuRgGAd4j5y
         Xqa2F4sc/fwZcLqJMJlqF/U8IQ56t/lFPH5kqOnKmqZic6gOl5dxL/DmHaQ5iIgBICdO
         YD/w==
X-Gm-Message-State: AOAM533RuMhaLAx33KevyoTaqcaze7O9Zqieuik4A98F4nVLN2zk46vq
        ip3T7T32kE/v/lDOPYnNO1X7cMx6FbzZkJMH7rZE3w==
X-Google-Smtp-Source: ABdhPJzJ98rYhpxX4CiSPrMd0VBuo6RnemqkvBk1HlHh9wqyUb+7XUEmqUIg8dMV96evpjc+NRqRt9WgK3A0QYnSvTk=
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr3331009oih.134.1635337479587;
 Wed, 27 Oct 2021 05:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <YXknxGFjvaB46d/p@Pauls-MacBook-Pro> <20211027121747.GI174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211027121747.GI174703@worktop.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 Oct 2021 14:24:27 +0200
Message-ID: <CANpmjNMr1V=rhx2=sOBDJKpE7Edws5wpemWqS6DEyn21dx=dnQ@mail.gmail.com>
Subject: Re: Potentially Broken Address Dependency via test_bit() When
 Compiling With Clang
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@in.tum.de>,
        paulmck@kernel.org, will@kernel.org, boqun.feng@gmail.com,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        charalampos.mainas@gmail.com, pramod.bhatotia@in.tum.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 14:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 12:19:48PM +0200, Paul Heidekr=C3=BCger wrote:
> > Hi all,
> >
> > For my bachelor thesis, I have been working on the infamous problem of
> > potentially broken dependency orderings in the Linux kernel. I'm being
> > advised by Marco Elver, Charalampos Mainas, Pramod Bhatotia (Cc'd).
>
> Nice! Great to see someone working on this!
>
> > For context, see:
> > https://linuxplumbersconf.org/event/7/contributions/821/attachments/598=
/1075/LPC_2020_--_Dependency_ordering.pdf
> >
> > Our approach consists of two LLVM compiler passes which annotate
> > dependencies in unoptimised intermediate representation (IR) and verify
> > the annotated dependencies in optimised IR. ATM, the passes only
> > recognise a subset of address dependencies - everything is still WIP ;-=
)
> >
> > We have been cross-compiling with a slightly modified version of
> > allyesconfig for arm64, and the passes have now found a case that we
> > would like to share with LKML for feedback: an address dependency being
> > broken (?) through compiler optimisations in
> > fs/afs/addr_list.c::afs_iterate_addresses().
> >
> > Address dependency in source code, lines 373 - 375 in fs/afs/addr_list.=
c:
> >
> > > [...]
> > >   index =3D READ_ONCE(ac->alist->preferred);
> > >   if (test_bit(index, &set))
> > >     goto selected;
> > > [...]
> >
> > where test_bit() expands to the following in
> > include/asm-generic/bitops/non-atomic.h, lines 115 - 122:
> >
> > > static __always_inline int
> > > arch_test_bit(unsigned int nr, const volatile unsigned long *addr)
> > > {
> > >   return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> > > }
> > > #define test_bit arch_test_bit
> >
> > The address dependency gets preserved in unoptimised IR since the virtu=
al register %33 transitively depends on %28:
> >
> > > %28 =3D load volatile i8, i8* %preferred, align 2, !annotation !15
> > > store i8 %28, i8* %tmp21, align 1
> > > %29 =3D load i8, i8* %tmp21, align 1
> > > %conv23 =3D zext i8 %29 to i32
> > > store i32 %conv23, i32* %index, align 4
> > > %30 =3D load i32, i32* %index, align 4
> > > store i32 %30, i32* %nr.addr.i, align 4
> > > store i64* %set, i64** %addr.addr.i, align 8
> > > %31 =3D load i64*, i64** %addr.addr.i, align 8
> > > %32 =3D load i32, i32* %nr.addr.i, align 4
> > > %div.i =3D udiv i32 %32, 64
> > > %idxprom.i =3D zext i32 %div.i to i64
> > > %arrayidx.i =3D getelementptr i64, i64* %31, i64 %idxprom.i
> > > %33 =3D load volatile i64, i64* %arrayidx.i, align 8, !annotation !16
> >
> > In optimised IR, there is no dependency between the two volatile loads
> > anymore:
> >
> > > %11 =3D load volatile i8, i8* %preferred, align 2, !annotation !19
> > > %conv25 =3D zext i8 %11 to i32
> > > %set.0. =3D load volatile i64, i64* %set, align 8
> >
> > Now, since @nr traces back to the READ_ONCE() to @index, does this make
> > the load from @addr in test_bit() address-dependent on that READ_ONCE()=
?
> > Should the load from @addr therefore be ordered against the READ_ONCE()=
?
>
> I would personally not consider this a dependend load. The result
> depends on two loads, but there is no actual ordering between them.
>
>   r1 =3D *x
>   r2 =3D *y
>   b =3D 1 & (r1 >> r2);
>
> (more or less)

Note that test_bit() does the load in terms of this: "...
addr[BIT_WORD(nr)] ..."
which means the address loaded does depend on 'nr'. And in the case
here 'nr' is a READ_ONCE()'d. From all the documentation we can find,
we think it's technically an addr-dep, albeit a pretty useless one.

I guess in this case nobody cares very much, because 'set' is on the
stack and not modified concurrently.

> A dependent load would be something where the address of the second load
> depends on the value of the first load, eg:
>
>   r1 =3D *x;
>   r2 =3D *(y + r1);
>
> typically derefencing or array accesses have this pattern. The canonical
> example being rcu_dereference(), and is the reason Paul Mckenney is
> arguing that pointers should carry dependecies; I'll let him refer to
> the many C language papers on this.
>
> Other examples, ones we're actually worried about the compiler breaking,
> are, for example, the array access as found in __ktime_get_fast_ns():
>
>         seq =3D READ_ONCE(tkf->seq);
>         tkr =3D tkf->base + (seq & 1);
>         now =3D tkr->...
>
> Here the dependency is on an integer (seq), and worse, only a single bit
> of it. If the compiler were this to transform into something like:
>
>         seq =3D READ_ONCE(tkf->seq)
>         if (seq & 1) {
>                 // use tkf->base[1]
>         } else {
>                 // use tkf->base[0]
>         }
>
> Then it would be broken, since the condition doesn't order the two loads
> and they can be re-ordered. Which in turn breaks the premise of the
> seqcount_latch construct -- see the comment that goes with
> raw_write_seqcount_latch() in seqlock.h.
>
> hth,
>
> ~Peter
>
