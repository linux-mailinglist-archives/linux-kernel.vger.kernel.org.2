Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC941CAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbhI2RBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344809AbhI2RBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A36DD61462
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632934791;
        bh=EM1oXwkdc2lgGvdOkjq5hSe3UNtKYKWdDP9Ix+9b/d8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f9Eg02YREiHs9+AdY2ZpeuRGLnZV48f6GND3ljqh8puIc2nxefDL5C5SPVGzLF0hR
         io4/uuJfqYCZuPlKMVl3cFXo20eZx/n2vsh3y27Db2Ww0JoKs7ylM6IU71tH945CC7
         8cofs5YTVVkI17NkDWfoUq653na5HI25Y1lpaEJ7tbkMZzbhWKqKkx+Xw0LT9lPo+f
         qwHc5AnOHiGkktP09leBlm4T/+PnIcM/FoZsFOiksQQvIit9+ueqDXcz/VBXH5VLcs
         t29SOOHt86P6+/yWDOlorUmCPhbg6XrtYqypZfHVCD8+21zz8hf6+z5jvm0PdQxTUh
         u0SJBr3BzXstg==
Received: by mail-lf1-f45.google.com with SMTP id i25so13556005lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:59:51 -0700 (PDT)
X-Gm-Message-State: AOAM532mGHOG7AKX2aSk2xduZOzz2Ki5ed5TYxAtTJ4oi+MmhzValfU9
        B8QCGcbbJyfCT2uFFbJZa2uZT4iOq/pyc8+60T8=
X-Google-Smtp-Source: ABdhPJw7hQ1nuxxV8XvyPSjdABcYtydwuRR3hMTfgc+jtUjuq++mjj2jboz18aXRR16M79QbHWzcj6v8qymZOr/YAIs=
X-Received: by 2002:a2e:321a:: with SMTP id y26mr1031724ljy.234.1632934789801;
 Wed, 29 Sep 2021 09:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com> <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com> <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
In-Reply-To: <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 29 Sep 2021 09:59:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
Message-ID: <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
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

On Wed, Sep 29, 2021 at 12:50 AM Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/29/21 3:14 PM, Song Liu wrote:
> > On Tue, Sep 28, 2021 at 9:20 AM Rongwei Wang
> > <rongwei.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 9/28/21 6:24 AM, Song Liu wrote:
> >>> On Fri, Sep 24, 2021 at 12:12 AM Rongwei Wang
> >>> <rongwei.wang@linux.alibaba.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 9/24/21 10:43 AM, Andrew Morton wrote:
> >>>>> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux=
.alibaba.com> wrote:
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org>=
 wrote:
> >>>>>>>
> >>>>>>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> >>>>>>>> Transparent huge page has supported read-only non-shmem files. T=
he file-
> >>>>>>>> backed THP is collapsed by khugepaged and truncated when written=
 (for
> >>>>>>>> shared libraries).
> >>>>>>>>
> >>>>>>>> However, there is race in two possible places.
> >>>>>>>>
> >>>>>>>> 1) multiple writers truncate the same page cache concurrently;
> >>>>>>>> 2) collapse_file rolls back when writer truncates the page cache=
;
> >>>>>>>
> >>>>>>> As I've said before, the bug here is that somehow there is a writ=
able fd
> >>>>>>> to a file with THPs.  That's what we need to track down and fix.
> >>>>>> Hi, Matthew
> >>>>>> I am not sure get your means. We know =E2=80=9Cmm, thp: relax the =
VM_DENYWRITE constraint on file-backed THPs"
> >>>>>> Introduced file-backed THPs for DSO. It is possible {very rarely} =
for DSO to be opened in writeable way.
> >>>>>>
> >>>>>> ...
> >>>>>>
> >>>>>>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradea=
d.org/
> >>>>>> All in all, what you mean is that we should solve this race at the=
 source?
> >>>>>
> >>>>> Matthew is being pretty clear here: we shouldn't be permitting
> >>>>> userspace to get a writeable fd for a thp-backed file.
> >>>>>
> >>>>> Why are we permitting the DSO to be opened writeably?  If there's a
> >>>>> legitimate case for doing this then presumably "mm, thp: relax the
> >>>> There is a use case to stress file-backed THP within attachment.
> >>>> I test this case in a system which has enabled CONFIG_READ_ONLY_THP_=
FOR_FS:
> >>>>
> >>>> $ gcc -Wall -g -o stress_madvise_dso stress_madvise_dso.c
> >>>> $ ulimit -s unlimited
> >>>> $ ./stress_madvise_dso 10000 <libtest.so>
> >>>>
> >>>> the meaning of above parameters:
> >>>> 10000: the max test time;
> >>>> <libtest.so>: the DSO that will been mapped into file-backed THP by
> >>>> madvise. It recommended that the text segment of DSO to be tested is
> >>>> greater than 2M.
> >>>>
> >>>> The crash will been triggered at once in the latest kernel. And this
> >>>> case also can used to trigger the bug that mentioned in our another =
patch.
> >>>
> >>> Hmm.. I am not able to use the repro program to crash the system. Not
> >>> sure what I did wrong.
> >>>
> >> Hi
> >> I have tried to check my test case again. Can you make sure the DSO th=
at
> >> you test have THP mapping?
> >>
> >> If you are willing to try again, I can send my libtest.c which is used
> >> to test by myself (actually, it shouldn't be target DSO problem).
> >>
> >> Thanks very much!
> >>> OTOH, does it make sense to block writes within khugepaged, like:
> >>>
> >>> diff --git i/mm/khugepaged.c w/mm/khugepaged.c
> >>> index 045cc579f724e..ad7c41ec15027 100644
> >>> --- i/mm/khugepaged.c
> >>> +++ w/mm/khugepaged.c
> >>> @@ -51,6 +51,7 @@ enum scan_result {
> >>>           SCAN_CGROUP_CHARGE_FAIL,
> >>>           SCAN_TRUNCATED,
> >>>           SCAN_PAGE_HAS_PRIVATE,
> >>> +       SCAN_BUSY_WRITE,
> >>>    };
> >>>
> >>>    #define CREATE_TRACE_POINTS
> >>> @@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm=
,
> >>>           /* Only allocate from the target node */
> >>>           gfp =3D alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNOD=
E;
> >>>
> >>> +       if (deny_write_access(file)) {
> >>> +               result =3D SCAN_BUSY_WRITE;
> >>> +               return;
> >>> +       }
> >>> +
> >> This can indeed avoid some possible races from source.
> >>
> >> But, I am thinking about whether this will lead to DDoS attack?
> >> I remember the reason of DSO has ignored MAP_DENYWRITE in kernel
> >> is that DDoS attack. In addition, 'deny_write_access' will change
> >> the behavior, such as user will get 'Text file busy' during
> >> collapse_file. I am not sure whether the behavior changing is acceptab=
le
> >> in user space.
> >>
> >> If it is acceptable, I am very willing to fix the races like your way.
> >
> > I guess we should not let the write get ETXTBUSY for khugepaged work.
> >
> > I am getting some segfault on stress_madvise_dso. And it doesn't really
> > generate the bug stack in my vm (qemu-system-x86_64). Is there an newer
> Hi, I can sure I am not update the stress_madvise_dso.c.
>
> My test environment is vm (qemu-system-aarch64, 32 cores). And I can
> think of the following possibilities:
>
> (1) in thread_read()
>
> printf("read %s\n", dso_path);
> d =3D open(dso_path, O_RDONLY);
> /* The start addr must be alignment with 2M */
> void *p =3D mmap((void *)0x40000dc00000UL, 0x800000, PROT_READ |
> PROT_EXEC,MAP_PRIVATE, fd, 0);
> if (p =3D=3D MAP_FAILED) {
>         perror("mmap");
>         goto out;
> }
>
> 0x40000dc00000 is random setting by myself. I am not sure this address
> is available in your vm.
>
> (2) in thread_write()
> int fd =3D open(dso_path, O_RDWR);
> p =3D mmap(NULL, 0x800000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> if (p =3D=3D MAP_FAILED) {
>         perror("mmap");
>          goto out; /* fail */
> }
>
> because of I am sure the DSO is bigger than 0x800000, so directly map
> the DSO using 0x800000. Maybe I had use '-z max-page-size=3D0x200000' to
> compile the DSO? likes:
> $ gcc -z max-page-size=3D0x200000 -o libtest.so -shared libtest.o
>
> If you don't mind, you can send the segment fault log to me. And I will
> find x86 environment to test.

I fixed the segfault with
1. malloc buf (as it is too big for stack) in thread_read
2. reduce memcpy() size in thread_read.

Now, I am able to crash the system on
    find_lock_entries () {
     ...
       VM_BUG_ON_PAGE(page->index !=3D xas.xa_index, page);
    }
I guess it is related. I will test more.

Thanks,
Song
