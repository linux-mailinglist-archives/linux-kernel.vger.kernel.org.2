Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38F443AB68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhJZErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhJZErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:47:06 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB236C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:44:43 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id v2so8695812qve.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MNji5ahy4ZJGV0BX3SfNctlXhA6hshHAxWuWdfCnyuM=;
        b=lSGCPIFe9CLClmpv6PmhdoiPw0jJlA1Y7TbWgVoEDB6sgCIW+f7e/UtDb+u0x2DwlQ
         u+et0I8SJcHaiCQr+BRju7q8BJs/V17zodovMbHU74SYALgwqwJnKpvWzfiRt83bphvX
         vVGl+FNjEmd038kIIV1tzJB6gF9/lUQWdnUqpiAlW639ZfXSTGiJW72VqT8k6bGxFxyS
         UnWV/hTs0aYeJn9lCa+jyPwqtXjwbpYi67uKGMFLK4oPm4GanBw0h0kV1sNp6ogtzTMT
         vKHy8gDYUhhsywhxwja0QzznHqcLVFGZpN2YqIjSCJa7vLjPLy+AdWXeH0uul/COcqej
         caFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MNji5ahy4ZJGV0BX3SfNctlXhA6hshHAxWuWdfCnyuM=;
        b=oNByI5NFGibADhGSuZHyGmOFFKVAp6tE55F/5Ace5xmte36eWpEhLL/Ecd5zbdJ6k0
         uzuKU1yQose3wyePatCnGefkkXuxUqYG1o7Ej6IhQI0JFX5p0TBQabxtnRhy8HhJW7Jq
         b2PvaN5Fo494rbWeKLfgtoGPdfAk5KyckTq8vKFnNtHyo6UX3Zf2kX6Dn6KQemSURqOY
         dcHRnJ//yiw9vQp2iqsZTQJdpGHmJAhGYKQBq95MQ581L8Gh5+mcxpkFKT0ll13+/MZg
         2cNA0DcItVe938T6bhzdMy+78xINlWD6TJtx/S4SXDhWqk9o/aL8+SQbtX1nFrO9bZpX
         F/oQ==
X-Gm-Message-State: AOAM532GSeN0CfHvCCtsv7PHMiDwPUiZUtbmL/3j3OLPSdnEx0T8mbRD
        Jc1wT36wDfHRYx47n3aQfFzYzgS0XhsKa/dtdJcslQ==
X-Google-Smtp-Source: ABdhPJzhFIVGE/9JVvzTkU10Vh4qqk2Dcd8BD2ZQgfV2wv0uEl0MR6r6A3waRPVxyjeuxGNTnk/8aoIz4V3Do2PXAiU=
X-Received: by 2002:a05:6214:29c9:: with SMTP id gh9mr20451134qvb.50.1635223482667;
 Mon, 25 Oct 2021 21:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
 <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com> <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com> <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
 <YXKVLtT2U2g3JDrm@bruce.bluespec.com> <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
 <YXbZtTR7TBHvdqck@bruce.bluespec.com>
In-Reply-To: <YXbZtTR7TBHvdqck@bruce.bluespec.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 26 Oct 2021 12:44:31 +0800
Message-ID: <CAHCEeh++tAWVkhg7uEeWGdwp6UDWqShxn8ACWMvApCkiGfgZgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8826=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Oct 25, 2021 at 12:47:49PM +0800, Greentime Hu wrote:
> > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > > > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wr=
ote:
> > > > >
> > > > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > > > > Hello Darius,
> > > > > >
> > > > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > > > >
> > > > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=
=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wr=
ote:
> > > > > > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=
=B49=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > > > This patch adds task switch support for vector. It =
supports partial lazy
> > > > > > > > > > > > save and restore mechanism. It also supports all le=
ngths of vlen.
> > > > > >
> > > > > > [ ... ]
> > > > > >
> > > > > > > > > > > So this will unconditionally enable vector instructio=
ns, and allocate
> > > > > > > > > > > memory for vector state, for all processes, regardles=
s of whether vector
> > > > > > > > > > > instructions are used?
> > > > > > > > > >
> > > > > > > > > > Yes, it will enable vector if has_vector() is true. The=
 reason that we
> > > > > > > > > > choose to enable and allocate memory for user space pro=
gram is because
> > > > > > > > > > we also implement some common functions in the glibc su=
ch as memcpy
> > > > > > > > > > vector version and it is called very often by every pro=
cess. So that
> > > > > > > > > > we assume if the user program is running in a CPU with =
vector ISA
> > > > > > > > > > would like to use vector by default. If we disable it b=
y default and
> > > > > > > > > > make it trigger the illegal instruction, that might be =
a burden since
> > > > > > > > > > almost every process will use vector glibc memcpy or so=
mething like
> > > > > > > > > > that.
> > > > > > > > >
> > > > > > > > > Do you have any evidence to support the assertion that al=
most every process
> > > > > > > > > would use vector operations?  One could easily argue that=
 the converse is
> > > > > > > > > true: no existing software uses the vector extension now,=
 so most likely a
> > > > > > > > > process will not be using it.
> > > > > > > >
> > > > > > > > Glibc ustreaming is just starting so you didn't see softwar=
e using the
> > > > > > > > vector extension now and this patchset is testing based on =
those
> > > > > > > > optimized glibc too. Vincent Chen is working on the glibc v=
ector
> > > > > > > > support upstreaming and we will also upstream the vector ve=
rsion glibc
> > > > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Th=
en we will
> > > > > > > > see platform with vector support can use vector version mem=
* and str*
> > > > > > > > functions automatically based on ifunc and platform without=
 vector
> > > > > > > > will use the original one automatically. These could be don=
e to select
> > > > > > > > the correct optimized glibc functions by ifunc mechanism.
> > > > > >
> > > > > > In your reply, I noticed that you didn't address Greentime's re=
sponse
> > > > > > here.  But this looks like the key issue.  If common library fu=
nctions are
> > > > > > vector-accelerated, wouldn't it make sense that almost every pr=
ocess would
> > > > > > wind up using vector instructions?  And thus there wouldn't be =
much point
> > > > > > to skipping the vector context memory allocation?
> > > > > >
> > > > >
> > > > > This issue was addressed in the thread regarding Intel AMX I link=
ed to in a
> > > > > previous message.  I don't agree that this is the key issue; it i=
s one of a
> > > > > number of issues.  What if I don't want to take the potential
> > > > > power/frequency hit for the vector unit for a workload that, at b=
est, uses
> > > > > it for the occasional memcpy?  What if the allocation fails, how =
will that
> > > >
> > > > Hi Darius,
> > > > The memcpy function seems not to be occasionally used in the progra=
ms
> > > > because many functions in Glibc use memcpy() to complete the memory
> > > > copy. I use the following simple case as an example.
> > > > test.c
> > > > void main(void) {
> > > >     return;
> > > > }
> > > > Then, we compile it by "gcc test.c -o a.out" and execute it. In the
> > > > execution, the memcpy() has been called unexpectedly. It is because
> > > > many libc initialized functions will be executed before entering th=
e
> > > > user-defined main function. One of the example is __libc_setup_tls(=
),
> > > > which is called by __libc_start_main(). The __libc_setup_tls() will
> > > > use memcpy() during the process of creating the Dynamic Thread Vect=
or
> > > > (DTV).
> > > >
> > > > Therefore, I think the memcpy() is widely used in most programs.
> > > >
> > >
> > > You're missing my point.  Not every (any?) program spends a majority =
of the
> > > time doing memcpy(), and even if a program did, all of my points are =
still
> > > valid.
> > >
> > > Please read the discussion in the thread I referenced and the questio=
ns in
> > > my prior message.
> > >
> >
> > Hi Darius,
> >
> > As I mentioned before, we want to treat vector ISA like a general ISA
> > instead of a specific IP. User program should be able to use it
> > transparently just like FPU.
> > It seems that the use case you want is asking user to use vector like
> > a specific IP, user program should ask kernel before they use it and
> > that is not what we want to do in this patchset.
> >
>
> Hi Greentime,
>
> Right.
>
> But beyond what I want to do or what you want to do, is what *should* Lin=
ux
> do?  I have attempted to provide evidence to support my position.  You ha=
ve
> not responded to or addressed the majority of my questions, which is
> concerning to me.

Hi Darius,

What is your majority questions?
