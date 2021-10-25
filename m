Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E9438E89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhJYEuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJYEuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:50:20 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140D8C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:47:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i1so9248334qtr.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9vIGns6HWNaeMTx5QFOvtKRFjcyLZxTuKzW3UfeG5fM=;
        b=D6QNTF/zk0bip2RuvympyqYQd9K2Kc6FbpUN+oKPwKL03BReSL8ljtXOxTnZCz4Vml
         9aJOK+qaYEGp6rlycY4n6wmZ0rb6jBTj1n5z4xPNLcX5xB3B78Z1eVzJUmO1VXedN65v
         kQLgB9U2dwiLEnClgV4fwGdU+pIt7tNl36uUb9LUF9CxY9LvKSFnLcITtZsPXQqK1qNB
         2KEm+pGGh8/4NAXrsvhn/5ufvptpU/aO5Lg/8hjyvpvFSu+mYNUGSupFQMZT5Q/s6INJ
         KnFXJBIzMhjDy/15Vzz3PRKbQxLl9471HDsB25zfmCqx4Volq3Yx4ltrM81nSlt0+YaN
         UFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9vIGns6HWNaeMTx5QFOvtKRFjcyLZxTuKzW3UfeG5fM=;
        b=7qGjAdu4tUiY7C/21rj4fSaE3B1EAUBdqgNxcY3uqezTIL3skpWUAXNCYQXa4oZmjv
         gnnKr+EF7sNHPju6/R3hQRXRw5hnIp0AYoiEmDi9nQnVv2brFJG6bbKdBFKdv4uXquzI
         X3hDGBwUvzSoCIViITvH5km0jTcySn+vtZjaMw+r8eMDX8Y0IXOWy+gQ1WnVZnExICgu
         HhUnbTyVtCjdIBoDPEKghaC4YaEkFtUJSZot+XW1Z0FwrtLQpK8MQ8oSovEDpyT1Bpkc
         Z674vG81o9R+YsVLSnxJ6WKpROLakOzm1AvOliq3HAUNeIh10PNM1VNpVKsm1CzCvDdD
         b39A==
X-Gm-Message-State: AOAM531c4WxCqLD6sc/hlsFTzF43XvU7eJWWtwD2/uQk6IlMiBwtcA+w
        6Ofi5x5aQ3bNQNd/XxQakdBno3shCQEKlG3dhulU5g==
X-Google-Smtp-Source: ABdhPJzbp2dyXamMc+L3kqxWrRPbRdHfMsTKvv5Xrp/i7Hu2hcx1orNKQKCCbp35BpF5BTN83GUrPFbz2ljZgwVKIUI=
X-Received: by 2002:a05:622a:1010:: with SMTP id d16mr15797662qte.70.1635137278261;
 Sun, 24 Oct 2021 21:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com> <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
 <YXFGAqTzHMeQA+R+@bruce.bluespec.com> <CABvJ_xjMyZ3HDLinMvY88HtKywb=cwhQNOOCZYTEeL407Gyz2A@mail.gmail.com>
 <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
In-Reply-To: <YXKVLtT2U2g3JDrm@bruce.bluespec.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 25 Oct 2021 12:47:49 +0800
Message-ID: <CAHCEehKpA=d1phuAM1tdeyrp-CYQRmFxGTpvuJqWNMjRCMpWfw@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
To:     Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8822=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Oct 22, 2021 at 11:52:01AM +0800, Vincent Chen wrote:
> > On Thu, Oct 21, 2021 at 6:50 PM Darius Rad <darius@bluespec.com> wrote:
> > >
> > > On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> > > > Hello Darius,
> > > >
> > > > On Tue, 5 Oct 2021, Darius Rad wrote:
> > > >
> > > > > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=
=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > > > > This patch adds task switch support for vector. It supp=
orts partial lazy
> > > > > > > > > > save and restore mechanism. It also supports all length=
s of vlen.
> > > >
> > > > [ ... ]
> > > >
> > > > > > > > > So this will unconditionally enable vector instructions, =
and allocate
> > > > > > > > > memory for vector state, for all processes, regardless of=
 whether vector
> > > > > > > > > instructions are used?
> > > > > > > >
> > > > > > > > Yes, it will enable vector if has_vector() is true. The rea=
son that we
> > > > > > > > choose to enable and allocate memory for user space program=
 is because
> > > > > > > > we also implement some common functions in the glibc such a=
s memcpy
> > > > > > > > vector version and it is called very often by every process=
. So that
> > > > > > > > we assume if the user program is running in a CPU with vect=
or ISA
> > > > > > > > would like to use vector by default. If we disable it by de=
fault and
> > > > > > > > make it trigger the illegal instruction, that might be a bu=
rden since
> > > > > > > > almost every process will use vector glibc memcpy or someth=
ing like
> > > > > > > > that.
> > > > > > >
> > > > > > > Do you have any evidence to support the assertion that almost=
 every process
> > > > > > > would use vector operations?  One could easily argue that the=
 converse is
> > > > > > > true: no existing software uses the vector extension now, so =
most likely a
> > > > > > > process will not be using it.
> > > > > >
> > > > > > Glibc ustreaming is just starting so you didn't see software us=
ing the
> > > > > > vector extension now and this patchset is testing based on thos=
e
> > > > > > optimized glibc too. Vincent Chen is working on the glibc vecto=
r
> > > > > > support upstreaming and we will also upstream the vector versio=
n glibc
> > > > > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then w=
e will
> > > > > > see platform with vector support can use vector version mem* an=
d str*
> > > > > > functions automatically based on ifunc and platform without vec=
tor
> > > > > > will use the original one automatically. These could be done to=
 select
> > > > > > the correct optimized glibc functions by ifunc mechanism.
> > > >
> > > > In your reply, I noticed that you didn't address Greentime's respon=
se
> > > > here.  But this looks like the key issue.  If common library functi=
ons are
> > > > vector-accelerated, wouldn't it make sense that almost every proces=
s would
> > > > wind up using vector instructions?  And thus there wouldn't be much=
 point
> > > > to skipping the vector context memory allocation?
> > > >
> > >
> > > This issue was addressed in the thread regarding Intel AMX I linked t=
o in a
> > > previous message.  I don't agree that this is the key issue; it is on=
e of a
> > > number of issues.  What if I don't want to take the potential
> > > power/frequency hit for the vector unit for a workload that, at best,=
 uses
> > > it for the occasional memcpy?  What if the allocation fails, how will=
 that
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
> You're missing my point.  Not every (any?) program spends a majority of t=
he
> time doing memcpy(), and even if a program did, all of my points are stil=
l
> valid.
>
> Please read the discussion in the thread I referenced and the questions i=
n
> my prior message.
>

Hi Darius,

As I mentioned before, we want to treat vector ISA like a general ISA
instead of a specific IP. User program should be able to use it
transparently just like FPU.
It seems that the use case you want is asking user to use vector like
a specific IP, user program should ask kernel before they use it and
that is not what we want to do in this patchset.
