Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C801D3A9D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhFPORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhFPORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:17:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01038C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:15:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gt18so4145020ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yRf3l2lZiHlO+p7mhmhnfK0YsykT++f3d831cbdKgWY=;
        b=d3Yqetc9M65JZ1FiHuoxo7IHCl70eaIufk3z8i6Yo94EaOQByTps8L6stNJVUiz1HV
         a4DC9EkN2tTxpffygo7tHVkg717BsL1gwUMrvqyJ+5GPWY9JPdy+RSEhkzrE5ErVwClF
         eKzniA8PYaHOuzcnKgobZ+rlW5uaCpBL9qVwWFYlas0rs7ypP4CZYxtYI7jUqGCvn856
         xWC37h9bJeleD8LAnD5xhAsjd58I/FTR6KATtq23vF1JN/MkX2vHfy+5jZqdL77ZogmW
         UwSshMJTSUE3kpxJqVx6v+pfYpDoIyNuse6viVbkNIowQTKIaNMNc7YUda+L53tACETS
         KC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yRf3l2lZiHlO+p7mhmhnfK0YsykT++f3d831cbdKgWY=;
        b=PcwNcgNY95HtBOCYdJ3CikM77WnNPpvrM+xswaM6AVo1Pra2zWcagcDsbzYTD9epD/
         xmHxsN6dstGvlvHA4cVGdPLE/JoytnypIt8fXEsNP9tuANDhAllr1SvV0Hd/CwH2riz1
         5zcHX1BJBRkkUf/8vY0cRTDj2bbVKWfjtSQtrxpca4kk6b4/pZ+eZ1msu/keDjMLqEjz
         LmfstPZoNcgQxe/J3yGQLvPKTLMpruuuI1QeBdkKyZVe4mDU4ozIYkeP305G5guPEPaB
         XD8gXZV6GDIN9QWw0D20Ke1GGlYytOb1R9fourEDMtMrP+SSdka5BE0FCKvq7X5Y9Wn7
         XTZQ==
X-Gm-Message-State: AOAM532aZszlINB+2aE87rRUj0IKBDD0oPM9x8ciJYkSfhkA3pHh6jHY
        MGjnirp2xMK1sEtd/Q3wpVBgiDlAYE6La/aVgeA=
X-Google-Smtp-Source: ABdhPJx0ZuPuYTRXF8slzQjyDsMrdkzGIPKoMQZt0lRzkD9W6rpoWafdjULmOJOki/eDWgFp2Qd0SUTYLU+AuFhw6w8=
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr5454844ejb.139.1623852937524;
 Wed, 16 Jun 2021 07:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210601033319.100737-1-gshan@redhat.com> <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com> <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com> <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
In-Reply-To: <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 16 Jun 2021 07:15:26 -0700
Message-ID: <CAKgT0UfSx+qhfLvnukag+Z4Ab72Lyg8UXBvduiswm2BnFZH9vw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to MAX_ORDER
To:     Gavin Shan <gshan@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:10 AM Gavin Shan <gshan@redhat.com> wrote:
>
> On 6/15/21 12:26 PM, Alexander Duyck wrote:
> > On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wr=
ote:
> >> On 11.06.21 09:44, Gavin Shan wrote:
> >>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
> >>>> On 01.06.21 05:33, Gavin Shan wrote:
> >>>>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
> >>>>> minimal order (threshold) to trigger page reporting. The page repor=
ting
> >>>>> is never triggered with the following configurations and settings o=
n
> >>>>> aarch64. In the particular scenario, the page reporting won't be tr=
iggered
> >>>>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from th=
e
> >>>>> page freeing. The condition is very hard, or even impossible to be =
met.
> >>>>>
> >>>>>      CONFIG_ARM64_PAGE_SHIFT:              16
> >>>>>      CONFIG_HUGETLB_PAGE:                  Y
> >>>>>      CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
> >>>>>      pageblock_order:                      13
> >>>>>      CONFIG_FORCE_MAX_ZONEORDER:           14
> >>>>>      MAX_ORDER:                            14
> >>>>>
> >>>>> The issue can be reproduced in VM, running kernel with above config=
urations
> >>>>> and settings. The 'memhog' is used inside the VM to access 512MB an=
onymous
> >>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
> >>>>>
> >>>>>      /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       =
   \
> >>>>>      -accel kvm -machine virt,gic-version=3Dhost                   =
     \
> >>>>>      -cpu host -smp 8,sockets=3D2,cores=3D4,threads=3D1 -m 4096M,ma=
xmem=3D64G \
> >>>>>      -object memory-backend-ram,id=3Dmem0,size=3D2048M             =
       \
> >>>>>      -object memory-backend-ram,id=3Dmem1,size=3D2048M             =
       \
> >>>>>      -numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dmem0                =
         \
> >>>>>      -numa node,nodeid=3D1,cpus=3D4-7,memdev=3Dmem1                =
         \
> >>>>>        :                                                           =
   \
> >>>>>      -device virtio-balloon-pci,id=3Dballoon0,free-page-reporting=
=3Dyes
> >>>>>
> >>>>> This tries to fix the issue by adjusting the threshold to the small=
er value
> >>>>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU'=
s RSS
> >>>>> drops after 'memhog' exits.
> >>>>
> >>>> IIRC, we use pageblock_order to
> >>>>
> >>>> a) Reduce the free page reporting overhead. Reporting on small chunk=
s can make us report constantly with little system activity.
> >>>>
> >>>> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM per=
formance.
> >>>>
> >>>> c) Avoid affecting creation of pageblock_order pages while hinting i=
s active. I think there are cases where "temporary pulling sub-pageblock pa=
ges" can negatively affect creation of pageblock_order pages. Concurrent co=
mpaction would be one of these cases.
> >>>>
> >>>> The monstrosity called aarch64 64k is really special in that sense, =
because a) does not apply because pageblocks are just very big, b) does som=
etimes not apply because either our VM isn't backed by (rare) 512MB THP or =
uses 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because=
 we don't really happen to create 512MB THP either way.
> >>>>
> >>>>
> >>>> For example, going on x86-64 from reporting 2MB to something like 32=
KB is absolutely undesired.
> >>>>
> >>>> I think if we want to go down that path (and I am not 100% sure yet =
if we want to), we really want to treat only the special case in a special =
way. Note that even when doing it only for aarch64 with 64k, you will still=
 end up splitting THP in a hypervisor if it uses 64k base pages (b)) and ca=
n affect creation of THP, for example, when compacting (c), so there is a n=
egative side to that.
> >>>>
> >>>
> >>> [Remove Alexander from the cc list as his mail isn't reachable]
> >>>
> >>
> >> [adding his gmail address which should be the right one]
> >>
> >>> David, thanks for your time to review and sorry for the delay and lat=
e response.
> >>> I spent some time to get myself familiar with the code, but there are=
 still some
> >>> questions to me, explained as below.
> >>>
> >>> Yes, @pageblock_order is currently taken as page reporting threshold.=
 It will
> >>> incur more overhead if the threshold is decreased as you said in (a).
> >>
> >> Right. Alex did quite some performance/overhead evaluation when
> >> introducing this feature. Changing the reporting granularity on most
> >> setups (esp., x86-64) is not desired IMHO.
> >
> > Yes, generally reporting pages comes at a fairly high cost so it is
> > important to find the right trade-off between the size of the page and
> > the size of the batch of pages being reported. If the size of the
> > pages is reduced it maybe important to increase the batch size in
> > order to avoid paying too much in the way of overhead.
> >
> > The other main reason for holding to pageblock_order on x86 is to
> > avoid THP splitting. Anything smaller than pageblock_order will
> > trigger THP splitting which will significantly hurt the performance of
> > the VM in general as it forces it down to order 0 pages.
> >
>
> Alex, Thanks for your reply and sorry for taking your time to this
> discussion.
>
> Could you please confirm it's PAGE_REPORTING_CAPACITY or the budget
> used in page_reporting_cycle() when you're talking about "batch"?

Yes, when I refer to batch it is how many pages we are processing in a
single call. That is limited by PAGE_REPORTING_CAPACITY.
