Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBE437091
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhJVDyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 23:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhJVDya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 23:54:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEAAC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:52:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c4so2127638pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jB4c/2WPucaW8Lf8osk4eSvo0aNrofmjsRvTABiqQPo=;
        b=LtIJY0mVcktq/K8n8jD1hAyDbe+vE/PqmplXMmbX5IOb0lmI6GVfRL4yU2DfDWnoMj
         DknuJ9nOcFnNCdEsQ8v+AI/ADQOxdi2quUws/lG3QRS46kEI59bjKCmokrqcmsAbpyB5
         7zPmjMqSxyOh8UyMK2DTyNGgM6SboQSVIrOj4mJYKZndfF9ADEx/dieuWh0wzSCEgL19
         lZ7KtYCH9Y4yF8DIRyUDiS1AClm9AsoSfwgnO4d3CZ8rTcjJ8LeqNpd0bphekAay8I/K
         6UodN69jKnHtQTtg7P3CV/RigKiXCwQsReuU3iDCVUMPd59kv/6pz8tEugj4HXMUI171
         CsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jB4c/2WPucaW8Lf8osk4eSvo0aNrofmjsRvTABiqQPo=;
        b=DLCaAaPQvPfmCQxcEio/irSiPeu0eBvVCjSvK3mEosB746tCfU1pgQJaHLZgzoaB3Y
         /IMmN+BOe+JwvVg92Bc1pmAIu4m/Dklsem5mPqV8qYcj6I706oJ7wvtul3hPFnHr37+4
         24J8kLijPRwwGqSXHxkRYcTzEfJmDfrr3gOT9BUbEXZPc0T0hfrm8/LKYSwRcUgN+qtT
         Q9BxD0tYdCIp5XlaB3F0a0TaSrWYg7gyqkMBWnkIGFDQiV92eLdnETzLE1bI5qag0e3M
         IXVwQ7JrsWSb+J6FVeCiKSiJU61oyF4mAcn7cgmayFIxx6T2SMRO/80h+FXFbYcbvZlf
         2xfw==
X-Gm-Message-State: AOAM530QBdZW89UqlFFUjTwoQySaB/XFoaL6uGUhmCJO9xcQZhMOmyph
        GpF9Lv1QxYb0v8cDAXkaidcvgnuB/glBfkwac/nWDQ==
X-Google-Smtp-Source: ABdhPJwl6IbsmHIfwLXxmFOrMkQLKXBEf1/u7iU5nh6SrMTTbOH8xvt1BQiKP2uLra10uOfIUJen5EGSa9UWcYazEKk=
X-Received: by 2002:a05:6a00:14d4:b0:44c:cdfa:f8f1 with SMTP id
 w20-20020a056a0014d400b0044ccdfaf8f1mr9722632pfu.58.1634874732777; Thu, 21
 Oct 2021 20:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com> <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
In-Reply-To: <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Fri, 22 Oct 2021 11:52:01 +0800
Message-ID: <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
>
> On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > Hello Darius,
> >
> > On Tue, 5 Oct 2021, Darius Rad wrote:
> >
> > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > This patch adds task switch support for vector. It supports=
 partial lazy
> > > > > > > > save and restore mechanism. It also supports all lengths of=
 vlen.
> >
> > [ ... ]
> >
> > > > > > > So this will unconditionally enable vector instructions, and =
allocate
> > > > > > > memory for vector state, for all processes, regardless of whe=
ther vector
> > > > > > > instructions are used?
> > > > > >
> > > > > > Yes, it will enable vector if has_vector() is true. The reason =
that we
> > > > > > choose to enable and allocate memory for user space program is =
because
> > > > > > we also implement some common functions in the glibc such as me=
mcpy
> > > > > > vector version and it is called very often by every process. So=
 that
> > > > > > we assume if the user program is running in a CPU with vector I=
SA
> > > > > > would like to use vector by default. If we disable it by defaul=
t and
> > > > > > make it trigger the illegal instruction, that might be a burden=
 since
> > > > > > almost every process will use vector glibc memcpy or something =
like
> > > > > > that.
> > > > >
> > > > > Do you have any evidence to support the assertion that almost eve=
ry process
> > > > > would use vector operations?  One could easily argue that the con=
verse is
> > > > > true: no existing software uses the vector extension now, so most=
 likely a
> > > > > process will not be using it.
> > > >
> > > > Glibc ustreaming is just starting so you didn't see software using =
the
> > > > vector extension now and this patchset is testing based on those
> > > > optimized glibc too. Vincent Chen is working on the glibc vector
> > > > support upstreaming and we will also upstream the vector version gl=
ibc
> > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we wi=
ll
> > > > see platform with vector support can use vector version mem* and st=
r*
> > > > functions automatically based on ifunc and platform without vector
> > > > will use the original one automatically. These could be done to sel=
ect
> > > > the correct optimized glibc functions by ifunc mechanism.
> >
> > In your reply, I noticed that you didn't address Greentime's response
> > here.  But this looks like the key issue.  If common library functions =
are
> > vector-accelerated, wouldn't it make sense that almost every process wo=
uld
> > wind up using vector instructions?  And thus there wouldn't be much poi=
nt
> > to skipping the vector context memory allocation?
> >
>
> This issue was addressed in the thread regarding Intel AMX I linked to in=
 a
> previous message.  I don't agree that this is the key issue; it is one of=
 a
> number of issues.  What if I don't want to take the potential
> power/frequency hit for the vector unit for a workload that, at best, use=
s
> it for the occasional memcpy?  What if the allocation fails, how will tha=
t

Hi Darius,
The memcpy function seems not to be occasionally used in the programs
because many functions in Glibc use memcpy() to complete the memory
copy. I use the following simple case as an example.
test.c
void main(void) {
    return;
}
Then, we compile it by "gcc test.c -o a.out" and execute it. In the
execution, the memcpy() has been called unexpectedly. It is because
many libc initialized functions will be executed before entering the
user-defined main function. One of the example is __libc_setup_tls(),
which is called by __libc_start_main(). The __libc_setup_tls() will
use memcpy() during the process of creating the Dynamic Thread Vector
(DTV).

Therefore, I think the memcpy() is widely used in most programs.

> get reported to user space (hint: not well)?  According to Greentime,
> RISC-V vector is similar to ARM SVE, which allocates memory for context
> state on first use and not unconditionally for all processes.
>
> // darius
>
