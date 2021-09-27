Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC41341A2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhI0W0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237444AbhI0W0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D79B661058
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632781499;
        bh=TyKEhPGij+CGTbxdLG5vYotUYB4WHx9ib8bzmK1W8v4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bf+EOvNdmkZ32sSz5ALoF7qIusFlbGALBf8935PjknFf/SHPszFTX0YkCyxt38X1A
         pbG+dpt+FGsS0Y7aMTSz5hC/PuIYikOSOUj7UKtvcAVnji+UiC5BHC9gqFg5SHUF4s
         SECd94rStr7A1XuWeVlrjpiL+D+kEAGPM7iJdcyDXigExE8Z56bo6KcTM/UXYLQB5L
         QgFTQOF49SyKxSXl8mVSX1fYyM3ilqigdGosIRixRjnKgiG8luh7gnVQAwGudFi4rE
         6cnQJjmlDSHiO2TKleEB5WphAeR1M6MsVGR3HTX6WDhNpaYPBhn6XDywCmh2434oHb
         e6oL7b15x1Ufg==
Received: by mail-lf1-f49.google.com with SMTP id x27so84072194lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:24:59 -0700 (PDT)
X-Gm-Message-State: AOAM531PjYTt9edssNIUMZWkDDaiVOrKHZOvdyjeSIJvQshAHUBqLaE0
        oT1xOj1n4RKqmabU2Pg5A/kt8TiUlCawtjECPfI=
X-Google-Smtp-Source: ABdhPJwf8HSgziRuGH35BctWGCYrnpxVuInOklCOyvOvq7OH5Mc9BdMMewJuG7g+raQXkmf6rSriyCTPQ6TQNStLFXY=
X-Received: by 2002:a05:6512:39c4:: with SMTP id k4mr2231945lfu.14.1632781498176;
 Mon, 27 Sep 2021 15:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com> <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
In-Reply-To: <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Sep 2021 15:24:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
Message-ID: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
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

On Fri, Sep 24, 2021 at 12:12 AM Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/24/21 10:43 AM, Andrew Morton wrote:
> > On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.ali=
baba.com> wrote:
> >
> >>
> >>
> >>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wro=
te:
> >>>
> >>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> >>>> Transparent huge page has supported read-only non-shmem files. The f=
ile-
> >>>> backed THP is collapsed by khugepaged and truncated when written (fo=
r
> >>>> shared libraries).
> >>>>
> >>>> However, there is race in two possible places.
> >>>>
> >>>> 1) multiple writers truncate the same page cache concurrently;
> >>>> 2) collapse_file rolls back when writer truncates the page cache;
> >>>
> >>> As I've said before, the bug here is that somehow there is a writable=
 fd
> >>> to a file with THPs.  That's what we need to track down and fix.
> >> Hi, Matthew
> >> I am not sure get your means. We know =E2=80=9Cmm, thp: relax the VM_D=
ENYWRITE constraint on file-backed THPs"
> >> Introduced file-backed THPs for DSO. It is possible {very rarely} for =
DSO to be opened in writeable way.
> >>
> >> ...
> >>
> >>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.or=
g/
> >> All in all, what you mean is that we should solve this race at the sou=
rce?
> >
> > Matthew is being pretty clear here: we shouldn't be permitting
> > userspace to get a writeable fd for a thp-backed file.
> >
> > Why are we permitting the DSO to be opened writeably?  If there's a
> > legitimate case for doing this then presumably "mm, thp: relax the
> There is a use case to stress file-backed THP within attachment.
> I test this case in a system which has enabled CONFIG_READ_ONLY_THP_FOR_F=
S:
>
> $ gcc -Wall -g -o stress_madvise_dso stress_madvise_dso.c
> $ ulimit -s unlimited
> $ ./stress_madvise_dso 10000 <libtest.so>
>
> the meaning of above parameters:
> 10000: the max test time;
> <libtest.so>: the DSO that will been mapped into file-backed THP by
> madvise. It recommended that the text segment of DSO to be tested is
> greater than 2M.
>
> The crash will been triggered at once in the latest kernel. And this
> case also can used to trigger the bug that mentioned in our another patch=
.

Hmm.. I am not able to use the repro program to crash the system. Not
sure what I did wrong.

OTOH, does it make sense to block writes within khugepaged, like:

diff --git i/mm/khugepaged.c w/mm/khugepaged.c
index 045cc579f724e..ad7c41ec15027 100644
--- i/mm/khugepaged.c
+++ w/mm/khugepaged.c
@@ -51,6 +51,7 @@ enum scan_result {
        SCAN_CGROUP_CHARGE_FAIL,
        SCAN_TRUNCATED,
        SCAN_PAGE_HAS_PRIVATE,
+       SCAN_BUSY_WRITE,
 };

 #define CREATE_TRACE_POINTS
@@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm,
        /* Only allocate from the target node */
        gfp =3D alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;

+       if (deny_write_access(file)) {
+               result =3D SCAN_BUSY_WRITE;
+               return;
+       }
+
        new_page =3D khugepaged_alloc_page(hpage, gfp, node);
        if (!new_page) {
                result =3D SCAN_ALLOC_HUGE_PAGE_FAIL;
@@ -1863,19 +1869,6 @@ static void collapse_file(struct mm_struct *mm,
        else {
                __mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
                filemap_nr_thps_inc(mapping);
-               /*
-                * Paired with smp_mb() in do_dentry_open() to ensure
-                * i_writecount is up to date and the update to nr_thps is
-                * visible. Ensures the page cache will be truncated if the
-                * file is opened writable.
-                */
-               smp_mb();
-               if (inode_is_open_for_write(mapping->host)) {
-                       result =3D SCAN_FAIL;
-                       __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr=
);
-                       filemap_nr_thps_dec(mapping);
-                       goto xa_locked;
-               }
        }

        if (nr_none) {
@@ -1976,6 +1969,7 @@ static void collapse_file(struct mm_struct *mm,
        VM_BUG_ON(!list_empty(&pagelist));
        if (!IS_ERR_OR_NULL(*hpage))
                mem_cgroup_uncharge(*hpage);
+       allow_write_access(file);
        /* TODO: tracepoints */
 }
