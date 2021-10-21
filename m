Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5C435809
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 03:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJUBDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 21:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 21:03:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D9DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 18:01:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so10411579otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 18:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/Anyro1utHkFdCbdStAnb8uXkCW4crr28fE7Heb+fl4=;
        b=Amtjbon3DnMOGs5EEeBpR6/lkN9fxfctIJORUjFOEw7wv2hqLfR1rU9zt4iwMBryDg
         ow+HqCTeKYqFCx12RN8FIbgdXX6tRDnBmJN7l4lyppD2TGJ4aB/Wp4Zb0fmlbwbBNaTD
         EyvVw/oQBXfa9db+xSQQXPbfjELvgUKfjLeuEOwSdl+2xPI+TCobbk0sGTzj9Itj57mS
         yplzHqLExBKFQcUYDszJckKixkrtKxsimewwAHaGs8jo2SuSZSTs7oyheYBMuT4pvKfk
         Pv6ES0MwOJXBW5Jue4Z6jGYG5Ha+voXXq5TZJuywq0pLto6Qe3OfiQR7scpSFBN0P2ZR
         ytig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/Anyro1utHkFdCbdStAnb8uXkCW4crr28fE7Heb+fl4=;
        b=CHMf087u2GFXWxGYmJyHRhFsaC0caic0jpO9+5A6uapliM5PHbCGXdhU10Cj22Odhg
         emhNJ3nf94NtNA5SqOqRcItpxcjlCjpEJxHnYg+hfvqs30PAGd7f2r/iLQOJoIGGFeBS
         3J4y1eOXgamcg98toRzZC+myatHWkY70gVSn6RmsVF2bIBO4iSl7x6+P6akDAmj8mOlr
         l8BgDj8dIK62h05WBBPP372xVZaUepfxtK5h9zcJhud0LUOXxljbYZIP1dLORBFW7IxC
         K00wZRzJ2tve273+zJPq8Bau9t0TsNFycwf5GWuHwfA8WQ/ttgVhlW2LoChe6ePeEeEj
         DwLw==
X-Gm-Message-State: AOAM530VI033UMSwKSg8EKUw7yFse4uq2NX0uOBod+fhs58Dhagj1G9U
        NsvpVfjDVEk2t8fxIVXjm61yFA==
X-Google-Smtp-Source: ABdhPJyOpc0Y/V7bNHLEaCEilxZ9yA1fSwUnP604hwHoUhi+XgICyd19Vqo6H4iUhzN1yRXLAcwYDA==
X-Received: by 2002:a9d:728d:: with SMTP id t13mr2114142otj.66.1634778092733;
        Wed, 20 Oct 2021 18:01:32 -0700 (PDT)
Received: from localhost ([2601:8c4:0:32f::a60])
        by smtp.gmail.com with ESMTPSA id r23sm756370otg.71.2021.10.20.18.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 18:01:31 -0700 (PDT)
Date:   Wed, 20 Oct 2021 18:01:31 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     Darius Rad <darius@bluespec.com>
cc:     Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
In-Reply-To: <YVxZspMO7rAvtMBS@bruce.bluespec.com>
Message-ID: <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com> <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com> <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com> <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com> <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com> <YVxZspMO7rAvtMBS@bruce.bluespec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1340494379-1634778091=:93269"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1340494379-1634778091=:93269
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Darius,

On Tue, 5 Oct 2021, Darius Rad wrote:

> On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > Darius Rad <darius@bluespec.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=881=
3=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:21=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > This patch adds task switch support for vector. It supports par=
tial lazy
> > > > > > save and restore mechanism. It also supports all lengths of vle=
n.

[ ... ]

> > > > > So this will unconditionally enable vector instructions, and allo=
cate
> > > > > memory for vector state, for all processes, regardless of whether=
 vector
> > > > > instructions are used?
> > > >
> > > > Yes, it will enable vector if has_vector() is true. The reason that=
 we
> > > > choose to enable and allocate memory for user space program is beca=
use
> > > > we also implement some common functions in the glibc such as memcpy
> > > > vector version and it is called very often by every process. So tha=
t
> > > > we assume if the user program is running in a CPU with vector ISA
> > > > would like to use vector by default. If we disable it by default an=
d
> > > > make it trigger the illegal instruction, that might be a burden sin=
ce
> > > > almost every process will use vector glibc memcpy or something like
> > > > that.
> > >
> > > Do you have any evidence to support the assertion that almost every p=
rocess
> > > would use vector operations?  One could easily argue that the convers=
e is
> > > true: no existing software uses the vector extension now, so most lik=
ely a
> > > process will not be using it.
> >=20
> > Glibc ustreaming is just starting so you didn't see software using the=
=20
> > vector extension now and this patchset is testing based on those=20
> > optimized glibc too. Vincent Chen is working on the glibc vector=20
> > support upstreaming and we will also upstream the vector version glibc=
=20
> > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will=
=20
> > see platform with vector support can use vector version mem* and str*=
=20
> > functions automatically based on ifunc and platform without vector=20
> > will use the original one automatically. These could be done to select=
=20
> > the correct optimized glibc functions by ifunc mechanism.

In your reply, I noticed that you didn't address Greentime's response=20
here.  But this looks like the key issue.  If common library functions are=
=20
vector-accelerated, wouldn't it make sense that almost every process would=
=20
wind up using vector instructions?  And thus there wouldn't be much point=
=20
to skipping the vector context memory allocation?


- Paul
--8323329-1340494379-1634778091=:93269--
