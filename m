Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA1241BFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbhI2HQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244552AbhI2HQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:16:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28A47613C8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632899678;
        bh=TnpDtXknsRF0daBXX4GMjJz7UmGs/ymzeHvpGkHnyv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LahBLs8sIBo5PN4S6snz7eYLoWY83DHuRzYiO0CxpJOteRFD2EWNXybN1O+x8N/lt
         DDaSzV8PgNI7c44PoGvZDw2sKeQjier4f7Yx3x1JCH2dQibG8hwMdU2smthDilz5+E
         BGBRLPwqZLbgHw4ZSCi9ZNErCVy1qNWVrBzB/5hZmmPahXXY0US1+C3VXFIXxMYO01
         J2GYkCrT0mg6pkbcvgvcS4C5YkBURAxC13MdlY0/ZFPSoTjFdZtjd5yqKGg2kjeuwz
         Rr5mnu5vUVvqbDC1QVooqDzYR385ZuEE7chnLAHjvKwpoSga3guP6+s4ZyL0NNXq0A
         YuusZzU87BHIQ==
Received: by mail-lf1-f47.google.com with SMTP id e15so6636558lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 00:14:38 -0700 (PDT)
X-Gm-Message-State: AOAM533pDsu/4fZ1S6/Ew9cQmn0zPf6ePC3R32sbUVlUHv5V41zmV175
        SvM5x8RLOOMj4hp8Bqx2YGKYHHBhjPJ4/M4gyBI=
X-Google-Smtp-Source: ABdhPJxETJdGuJR/uydblIRqAEZFEoAQqaRtWzs6B/JQXYxmdfes4L7TNmrf22LuVt+MCbAvNzyMUJb+WoEQFzVh7iM=
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr4435158ljj.527.1632899676475;
 Wed, 29 Sep 2021 00:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com> <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
In-Reply-To: <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Sep 2021 00:14:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
Message-ID: <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 9:20 AM Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/28/21 6:24 AM, Song Liu wrote:
> > On Fri, Sep 24, 2021 at 12:12 AM Rongwei Wang
> > <rongwei.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 9/24/21 10:43 AM, Andrew Morton wrote:
> >>> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.a=
libaba.com> wrote:
> >>>
> >>>>
> >>>>
> >>>>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> w=
rote:
> >>>>>
> >>>>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> >>>>>> Transparent huge page has supported read-only non-shmem files. The=
 file-
> >>>>>> backed THP is collapsed by khugepaged and truncated when written (=
for
> >>>>>> shared libraries).
> >>>>>>
> >>>>>> However, there is race in two possible places.
> >>>>>>
> >>>>>> 1) multiple writers truncate the same page cache concurrently;
> >>>>>> 2) collapse_file rolls back when writer truncates the page cache;
> >>>>>
> >>>>> As I've said before, the bug here is that somehow there is a writab=
le fd
> >>>>> to a file with THPs.  That's what we need to track down and fix.
> >>>> Hi, Matthew
> >>>> I am not sure get your means. We know =E2=80=9Cmm, thp: relax the VM=
_DENYWRITE constraint on file-backed THPs"
> >>>> Introduced file-backed THPs for DSO. It is possible {very rarely} fo=
r DSO to be opened in writeable way.
> >>>>
> >>>> ...
> >>>>
> >>>>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.=
org/
> >>>> All in all, what you mean is that we should solve this race at the s=
ource?
> >>>
> >>> Matthew is being pretty clear here: we shouldn't be permitting
> >>> userspace to get a writeable fd for a thp-backed file.
> >>>
> >>> Why are we permitting the DSO to be opened writeably?  If there's a
> >>> legitimate case for doing this then presumably "mm, thp: relax the
> >> There is a use case to stress file-backed THP within attachment.
> >> I test this case in a system which has enabled CONFIG_READ_ONLY_THP_FO=
R_FS:
> >>
> >> $ gcc -Wall -g -o stress_madvise_dso stress_madvise_dso.c
> >> $ ulimit -s unlimited
> >> $ ./stress_madvise_dso 10000 <libtest.so>
> >>
> >> the meaning of above parameters:
> >> 10000: the max test time;
> >> <libtest.so>: the DSO that will been mapped into file-backed THP by
> >> madvise. It recommended that the text segment of DSO to be tested is
> >> greater than 2M.
> >>
> >> The crash will been triggered at once in the latest kernel. And this
> >> case also can used to trigger the bug that mentioned in our another pa=
tch.
> >
> > Hmm.. I am not able to use the repro program to crash the system. Not
> > sure what I did wrong.
> >
> Hi
> I have tried to check my test case again. Can you make sure the DSO that
> you test have THP mapping?
>
> If you are willing to try again, I can send my libtest.c which is used
> to test by myself (actually, it shouldn't be target DSO problem).
>
> Thanks very much!
> > OTOH, does it make sense to block writes within khugepaged, like:
> >
> > diff --git i/mm/khugepaged.c w/mm/khugepaged.c
> > index 045cc579f724e..ad7c41ec15027 100644
> > --- i/mm/khugepaged.c
> > +++ w/mm/khugepaged.c
> > @@ -51,6 +51,7 @@ enum scan_result {
> >          SCAN_CGROUP_CHARGE_FAIL,
> >          SCAN_TRUNCATED,
> >          SCAN_PAGE_HAS_PRIVATE,
> > +       SCAN_BUSY_WRITE,
> >   };
> >
> >   #define CREATE_TRACE_POINTS
> > @@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm,
> >          /* Only allocate from the target node */
> >          gfp =3D alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> >
> > +       if (deny_write_access(file)) {
> > +               result =3D SCAN_BUSY_WRITE;
> > +               return;
> > +       }
> > +
> This can indeed avoid some possible races from source.
>
> But, I am thinking about whether this will lead to DDoS attack?
> I remember the reason of DSO has ignored MAP_DENYWRITE in kernel
> is that DDoS attack. In addition, 'deny_write_access' will change
> the behavior, such as user will get 'Text file busy' during
> collapse_file. I am not sure whether the behavior changing is acceptable
> in user space.
>
> If it is acceptable, I am very willing to fix the races like your way.

I guess we should not let the write get ETXTBUSY for khugepaged work.

I am getting some segfault on stress_madvise_dso. And it doesn't really
generate the bug stack in my vm (qemu-system-x86_64). Is there an newer
version of it?

Thanks,
Song
