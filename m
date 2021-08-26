Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE003F8F70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 22:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbhHZUER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhHZUEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 16:04:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669F3C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:03:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a25so8820774ejv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0BpLP31/YDp0oS0QQ/zKz5EA+ge6XdTWOf5ZkKT3Kuc=;
        b=WwQ8OauUN7FsyY/dOEosuTX3TeoMC7Le4ZpPuVIh+DxbEENCsHUE2hiNZiZeoF3Z/P
         pgrD61NBwIZs2+V9gK9sX5ew9rNG5X4j21v4bMaeDYmzMmwL0dTHQz7XGLxa9O2ffTb/
         573itbcumcgHaI1a7SNS5Q9WrBFN3MGQbYJX3gfp8Xltmc9K3Hj1XnPB1oaYP7OJfA19
         bNEn/AxGiBmZBtdMkLGzKWcrDDzKhkijZL6AHwl9MkYX+wsrkTn9zVqvtc+VoT+kFHuz
         GMKhkn+YUCmGPEBVDrEeYD1NXeOBqrkQF5iateW4CRs0g27sxWaB3k6FEjzlWSb0O9Op
         hHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0BpLP31/YDp0oS0QQ/zKz5EA+ge6XdTWOf5ZkKT3Kuc=;
        b=SG4xJBFpHWYCzhym1TwkTKPEQL37RrBxhqYSD5i5p5EjVRAPwD92bSkJEfTzzT04mE
         mHtuoRRQmr2o2jLLA8M6/KA2BQUSGXoCS7Mk4LfeOM8rxEqwuCVh0PAM93sFNBzE/DHX
         gxi5EOEFcQnGVAwWGq+uRvYYX7YaQi3OvyN2+83PULVJOPUWoOAXqMz9wrFBULODDnaX
         OWt1LRC+E4X5/OwlINA0R43jW294qbI6dDJFm6G1wyDO2uE4tIZnK171OjHBmLKjbk6x
         R2Y2HFJmYw8LoiP0Wq67YQpNuUeVmZDGb+clVWq3t36s//eXDdebDI4qcv0+lJf2YQCV
         BRVw==
X-Gm-Message-State: AOAM532R19Lrf4SALmrhfYnCvaSmWm/tE9V/G1NaEkMgn5iIhgrE0+XT
        1wg45ns8DswXPMVmMC6J1pYhlCl18Ge0DdjaXOE=
X-Google-Smtp-Source: ABdhPJzUVpa6/NtdTsh0/jmm8+vPEpfXOFohthNugdMUGKBmVxp71652j/Bbgmi8rDL7kIF0a6qNY2lOyQCLIu+CLgg=
X-Received: by 2002:a17:906:417:: with SMTP id d23mr5895729eja.383.1630008206978;
 Thu, 26 Aug 2021 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 26 Aug 2021 13:03:13 -0700
Message-ID: <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
Subject: Re: [PATCH] mm: hwpoison: deal with page cache THP
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "osalvador@suse.de" <osalvador@suse.de>,
        "hughd@google.com" <hughd@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wrote:
> > Currently hwpoison doesn't handle page cache THP, just give up and retu=
rn
> > error.  It is just because the hwpoison THP support was added before
> > page cache THP was supported.
> >
> > Handling page cache THP is simple, they could be offlined by splitting =
THP,
> > just like anonymous THP.
>
> I think that this patch is not enough to contain an error because page ta=
ble
> entries pointing to subpages in shmem thp are removed during thp splittin=
g.
> Then the processes using the file newly allocates another (zeroed) page f=
or
> the poisoned address, which results in slient data lost.
>
> According to the comment in unmap_page() at mm/huge_memory.c, file pages =
are
> supposed to be faulted back on demand:
>
>   static void unmap_page(struct page *page)
>   ...
>           /*
>            * Anon pages need migration entries to preserve them, but file
>            * pages can simply be left unmapped, then faulted back on dema=
nd.
>            * If that is ever changed (perhaps for mlock), update remap_pa=
ge().
>            */
>           if (PageAnon(page))
>                   try_to_migrate(page, ttu_flags);
>           else
>                   try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);
>
> , but I don't think that faulting back during memory error handling might=
 be
> hard because it does not have any direct information about mapping proces=
ses
> of an error page.  memory_failure() uses try_to_unmap() to find them but
> splitting of shmem thp makes this impossible, because it removes the rela=
ted
> page table entries.
>
> There was a discussion about another approach of keeping error pages in p=
age
> cache for filesystem without backend storage.
> https://lore.kernel.org/lkml/alpine.LSU.2.11.2103111312310.7859@eggly.anv=
ils/
> This approach seems to me less complicated, but one concern is that this
> change affects user-visible behavior of memory errors.  Keeping error pag=
es
> in page cache means that the errors are persistent until next system rebo=
ot,
> so we might need to define the way to clear the errors to continue to use
> the error file.  Current implementation is just to send SIGBUS to the
> mapping processes (at least once), then forget about the error, so there =
is
> no such issue.
>
> Another thought of possible solution might be to send SIGBUS immediately =
when
> a memory error happens on a shmem thp. We can find all the mapping proces=
ses
> before splitting shmem thp, so send SIGBUS first, then split it and conta=
in
> the error page.  This is not elegant (giving up any optional actions) but
> anyway we can avoid the silent data lost.

Thanks a lot. I apologize I didn't notice you already posted a similar
patch before.

Yes, I think I focused on the soft offline part too much and missed
the uncorrected error part and I admit I did underestimate the
problem.

I think Hugh's suggestion makes sense if we treat tmpfs as a regular
filesystem (just memory backed). AFAIK, some filesystem, e.g. btrfs,
may do checksum after reading from storage block then return an error
if checksum is not right since it may indicate hardware failure on
disk. Then the syscalls or page fault return error or SIGBUS.

So in shmem/tmpfs case, if hwpoisoned page is met, just return error
(-EIO or whatever) for syscall or SIGBUS for page fault. It does align
with the behavior of other filesystems. It is definitely applications'
responsibility to check the return value of read/write syscalls.

>
> - Naoya Horiguchi
>
> >
> > The question is how to distinguish them with allocating and freeing THP
> > which can't be handled by hwpoison properly.  It seems page->mapping is=
 a
> > good indicator, both anonymous page and file page have it populated, bu=
t
> > it won't be populated until the page is added to rmap or page cache, in
> > other word, instantiated.  If page->mapping is populated it is
> > definitely not in allocating or freeing.
> >
> > The later get_page_unless_zero() could serialize against page free
> > paths.
> >
> > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/memory-failure.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 60df8fcd0444..caa0b0c1f5b8 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1149,13 +1149,16 @@ static int __get_hwpoison_page(struct page *pag=
e)
> >
> >       if (PageTransHuge(head)) {
> >               /*
> > -              * Non anonymous thp exists only in allocation/free time.=
 We
> > -              * can't handle such a case correctly, so let's give it u=
p.
> > -              * This should be better than triggering BUG_ON when kern=
el
> > -              * tries to touch the "partially handled" page.
> > +              * We can't handle allocating or freeing THPs, so let's g=
ive
> > +              * it up. This should be better than triggering BUG_ON wh=
en
> > +              * kernel tries to touch the "partially handled" page.
> > +              *
> > +              * page->mapping won't be initialized until the page is a=
dded
> > +              * to rmap or page cache.  Use this as an indicator for i=
f
> > +              * this is an instantiated page.
> >                */
> > -             if (!PageAnon(head)) {
> > -                     pr_err("Memory failure: %#lx: non anonymous thp\n=
",
> > +             if (!head->mapping) {
> > +                     pr_err("Memory failure: %#lx: non instantiated th=
p\n",
> >                               page_to_pfn(page));
> >                       return 0;
> >               }
> > @@ -1414,12 +1417,12 @@ static int identify_page_state(unsigned long pf=
n, struct page *p,
> >  static int try_to_split_thp_page(struct page *page, const char *msg)
> >  {
> >       lock_page(page);
> > -     if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> > +     if (!page->mapping || unlikely(split_huge_page(page))) {
> >               unsigned long pfn =3D page_to_pfn(page);
> >
> >               unlock_page(page);
> > -             if (!PageAnon(page))
> > -                     pr_info("%s: %#lx: non anonymous thp\n", msg, pfn=
);
> > +             if (!page->mapping)
> > +                     pr_info("%s: %#lx: not instantiated thp\n", msg, =
pfn);
> >               else
> >                       pr_info("%s: %#lx: thp split failed\n", msg, pfn)=
;
> >               put_page(page);
> > --
> > 2.26.2
> >
