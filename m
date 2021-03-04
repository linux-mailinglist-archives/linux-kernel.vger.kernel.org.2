Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761E332DA48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhCDTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhCDTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:22:22 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:21:41 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p10so13771440ils.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=R5uvdWP3IXyJRb9GkUi22skzm53AYXgUrSMSuvQhHNE=;
        b=J7EvIFn/UA7xzd5lnEBk2jqfskkcsSLAGRWrLw6IyvKIhdqCzXcbkvLB6N7EsV4JFC
         3ZGrGucBMdsEj6Mcvzz14S/LaOzQn8QgtGFATtprYxQLiP4H2/9/F3XnoRzVu0lDNvAe
         DlZyOrDz41O1tRISMYjGFetCK+7cytGC5F9hUN4MgYmjd9Y2MmZTrsBqExwMWa7OTXan
         HAlvMYZifZXkdBw01nwRePO7Mp6aOzYPG+BpIepGtxoRrBdJ9gkD1+kVjD2xxAXurt4b
         pnPlgaZyIvAzogPGXWq8j2+5t16ohare32L7NW+GWtvwiQ+9YkC/eP7KmocUvpwmXvhZ
         AKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=R5uvdWP3IXyJRb9GkUi22skzm53AYXgUrSMSuvQhHNE=;
        b=EhX1exVapzFdpxKQEUAzdoeRJXRZM9tSucZ6RocHIcwmU8khvVLZcTmi6jJaZA2KQJ
         6Ots++w0XbhWeX33tyYh0P1LkA9AwfkUr5IxOVs/YGejvasAOshy3a2TJwhORHcQE8Bz
         vzgRgBvKUlRJaBxmR3rUHfeSx2foO96+OEQepNH8Fn/Tig0ay9ZJl1ZCg7c6lxR3WQnd
         h8oTlqy0UeD4R9l0dG5dT/aftD70eTYpBQYIVREo3sFWNzBU4Nv/jmtD9ntLjeS/5fWw
         G4Xk5x0O7N5H0efl7K9LWbnb7vdGhTT6RiHVBYgTxHu/i8oKsVQMRMTUuJYBU6S5Sytt
         D/BA==
X-Gm-Message-State: AOAM533o12REDbmph7B+JMk36+oxDvg4rWxZKOOTGLroa3eFVB5ts0iU
        HkHvmFhr0z9Y7VEqAQ8NgxcvmZtGbr3p/emRDLk=
X-Google-Smtp-Source: ABdhPJxFFZeMGka7A0ThckmzlKneMtP94EVDxnzXfu2Tnw+2EmKiCGTyl+GiSM0Q5gEeWusBD4HuIBLBkp/n2J8nRoU=
X-Received: by 2002:a92:444e:: with SMTP id a14mr5157873ilm.215.1614885700730;
 Thu, 04 Mar 2021 11:21:40 -0800 (PST)
MIME-Version: 1.0
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
 <20210303224653.2579656-1-joshdon@google.com> <CAKwvOdmijctJfM3gNfwEVjaQyp3LZkhnAwgsT7EBhsSBJyfLAA@mail.gmail.com>
 <CA+icZUUw0T2NpTcN4witbzYr1L7dF=rHKWq14ji_426G02QoEw@mail.gmail.com>
In-Reply-To: <CA+icZUUw0T2NpTcN4witbzYr1L7dF=rHKWq14ji_426G02QoEw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Mar 2021 20:21:03 +0100
Message-ID: <CA+icZUVkvoAzpq383taD1Xg9F80odV-XfiTJCLF7x_b=_tGdXQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Optimize __calc_delta.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Bill Wendling <morbo@google.com>
Content-Type: multipart/mixed; boundary="0000000000008c030c05bcbae088"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008c030c05bcbae088
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 4, 2021 at 7:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Mar 4, 2021 at 6:34 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Wed, Mar 3, 2021 at 2:48 PM Josh Don <joshdon@google.com> wrote:
> > >
> > > From: Clement Courbet <courbet@google.com>
> > >
> > > A significant portion of __calc_delta time is spent in the loop
> > > shifting a u64 by 32 bits. Use `fls` instead of iterating.
> > >
> > > This is ~7x faster on benchmarks.
> > >
> > > The generic `fls` implementation (`generic_fls`) is still ~4x faster
> > > than the loop.
> > > Architectures that have a better implementation will make use of it. =
For
> > > example, on X86 we get an additional factor 2 in speed without dedica=
ted
> > > implementation.
> > >
> > > On gcc, the asm versions of `fls` are about the same speed as the
> > > builtin. On clang, the versions that use fls are more than twice as
> > > slow as the builtin. This is because the way the `fls` function is
> > > written, clang puts the value in memory:
> > > https://godbolt.org/z/EfMbYe. This bug is filed at
> > > https://bugs.llvm.org/show_bug.cgi?id=3D49406.
> >
> > Hi Josh, Thanks for helping get this patch across the finish line.
> > Would you mind updating the commit message to point to
> > https://bugs.llvm.org/show_bug.cgi?id=3D20197?
> >
> > >
> > > ```
> > > name                                   cpu/op
> > > BM_Calc<__calc_delta_loop>             9.57ms =C2=B112%
> > > BM_Calc<__calc_delta_generic_fls>      2.36ms =C2=B113%
> > > BM_Calc<__calc_delta_asm_fls>          2.45ms =C2=B113%
> > > BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms =C2=B112%
> > > BM_Calc<__calc_delta_asm_fls64>        2.46ms =C2=B113%
> > > BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms =C2=B115%
> > > BM_Calc<__calc_delta_builtin>          1.32ms =C2=B111%
> > > ```
> > >
> > > Signed-off-by: Clement Courbet <courbet@google.com>
> > > Signed-off-by: Josh Don <joshdon@google.com>
> > > ---
> > >  kernel/sched/fair.c  | 19 +++++++++++--------
> > >  kernel/sched/sched.h |  1 +
> > >  2 files changed, 12 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 8a8bd7b13634..a691371960ae 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -229,22 +229,25 @@ static void __update_inv_weight(struct load_wei=
ght *lw)
> > >  static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct=
 load_weight *lw)
> > >  {
> > >         u64 fact =3D scale_load_down(weight);
> > > +       u32 fact_hi =3D (u32)(fact >> 32);
> > >         int shift =3D WMULT_SHIFT;
> > > +       int fs;
> > >
> > >         __update_inv_weight(lw);
> > >
> > > -       if (unlikely(fact >> 32)) {
> > > -               while (fact >> 32) {
> > > -                       fact >>=3D 1;
> > > -                       shift--;
> > > -               }
> > > +       if (unlikely(fact_hi)) {
> > > +               fs =3D fls(fact_hi);
> > > +               shift -=3D fs;
> > > +               fact >>=3D fs;
> > >         }
> > >
> > >         fact =3D mul_u32_u32(fact, lw->inv_weight);
> > >
> > > -       while (fact >> 32) {
> > > -               fact >>=3D 1;
> > > -               shift--;
> > > +       fact_hi =3D (u32)(fact >> 32);
> > > +       if (fact_hi) {
> > > +               fs =3D fls(fact_hi);
> > > +               shift -=3D fs;
> > > +               fact >>=3D fs;
> > >         }
> > >
> > >         return mul_u64_u32_shr(delta_exec, fact, shift);
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 10a1522b1e30..714af71cf983 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -36,6 +36,7 @@
> > >  #include <uapi/linux/sched/types.h>
> > >
> > >  #include <linux/binfmts.h>
> > > +#include <linux/bitops.h>
> >
> > This hunk of the patch is curious.  I assume that bitops.h is needed
> > for fls(); if so, why not #include it in kernel/sched/fair.c?
> > Otherwise this potentially hurts compile time for all TUs that include
> > kernel/sched/sched.h.
> >
>
> I have v2 as-is in my custom patchset and booted right now on bare metal.
>
> As Nick points out moving the include makes sense to me.
> We have a lot of include at the wrong places increasing build-time.
>

I tried with the attached patch.

$ LC_ALL=3DC ll kernel/sched/fair.o
-rw-r--r-- 1 dileks dileks 1.2M Mar  4 20:11 kernel/sched/fair.o

- Sedat -

--0000000000008c030c05bcbae088
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-sched-fair-Move-include-after-__calc_delta-optimizat.patch"
Content-Disposition: attachment; 
	filename="0001-sched-fair-Move-include-after-__calc_delta-optimizat.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klv969x50>
X-Attachment-Id: f_klv969x50

RnJvbSBhZmQ0NWNkNzhjMjE5NjBjNmU5MzcwMjFmMDk1ZTVmOGY1MWZlZjdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDQgTWFyIDIwMjEgMjA6MDU6MzAgKzAxMDAKU3ViamVjdDogW1BBVENIXSBzY2hl
ZC9mYWlyOiBNb3ZlIGluY2x1ZGUgYWZ0ZXIgX19jYWxjX2RlbHRhIG9wdGltaXphdGlvbgogY2hh
bmdlCgpTaWduZWQtb2ZmLWJ5OiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgot
LS0KIGtlcm5lbC9zY2hlZC9mYWlyLmMgIHwgMiArKwoga2VybmVsL3NjaGVkL3NjaGVkLmggfCAx
IC0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMKaW5kZXgg
NWZkYTE3NTFmYmQxLi5iOWYxMGFlOTJlM2YgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zY2hlZC9mYWly
LmMKKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYwpAQCAtMjAsNiArMjAsOCBAQAogICogIEFkYXB0
aXZlIHNjaGVkdWxpbmcgZ3JhbnVsYXJpdHksIG1hdGggZW5oYW5jZW1lbnRzIGJ5IFBldGVyIFpp
amxzdHJhCiAgKiAgQ29weXJpZ2h0IChDKSAyMDA3IFJlZCBIYXQsIEluYy4sIFBldGVyIFppamxz
dHJhCiAgKi8KKyNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4KKwogI2luY2x1ZGUgInNjaGVkLmgi
CiAKIC8qCmRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvc2NoZWQuaCBiL2tlcm5lbC9zY2hlZC9z
Y2hlZC5oCmluZGV4IDcxNGFmNzFjZjk4My4uMTBhMTUyMmIxZTMwIDEwMDY0NAotLS0gYS9rZXJu
ZWwvc2NoZWQvc2NoZWQuaAorKysgYi9rZXJuZWwvc2NoZWQvc2NoZWQuaApAQCAtMzYsNyArMzYs
NiBAQAogI2luY2x1ZGUgPHVhcGkvbGludXgvc2NoZWQvdHlwZXMuaD4KIAogI2luY2x1ZGUgPGxp
bnV4L2JpbmZtdHMuaD4KLSNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4KICNpbmNsdWRlIDxsaW51
eC9ibGtkZXYuaD4KICNpbmNsdWRlIDxsaW51eC9jb21wYXQuaD4KICNpbmNsdWRlIDxsaW51eC9j
b250ZXh0X3RyYWNraW5nLmg+Ci0tIAoyLjMwLjEKCg==
--0000000000008c030c05bcbae088--
