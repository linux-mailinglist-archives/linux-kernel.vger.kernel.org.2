Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6393F9086
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhHZWFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhHZWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:04:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:04:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me10so9399491ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dxCZhK0PWQk2bIvDc2xXT3qv1FpEBbUinTDdO8HtMZs=;
        b=is74MPwoQJl85ffVdXeqA425hPwMI5vNMUe7yQbsn8o732zSEye+qmmGuRZW6WDfIy
         YbhJcmadMMbsZwpeS9u0ha40HN1wRqyZCNJrPY8Vwjx9+mT3RdpOzE390LcEIYjhfc5C
         cJGfHmdZ6zRWB6yWMpbqtZrY3/RFC/t+SLvj33osEsyhR/qk3NSMKrce6zrkQKiDpfxM
         cjKu9yJV8Bmx+4g2zUsXoGJhK8ygxlMpxVA91cSpA53yHZvfhY0l+X9M2Oklf2tDATIi
         fg9GixNDC6gpXIfzh53NpkJusaDluKx2wl4F2G1XZ04SS8FbQ6Khs6uWoFQfvp5y3Hkn
         q8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dxCZhK0PWQk2bIvDc2xXT3qv1FpEBbUinTDdO8HtMZs=;
        b=eNBm1wpXL1XTdPA2T0okp4guKT7hxGGl9XN5IKkws+9pTm+n7jCvKCGv/LZCXOXReb
         92wxOaYbQDijYg8b8BSCPcUclOuxI2ERY+76tbTdf7BvOzZLgRNtlnzYm4xbtqsDZSwS
         Z2BaED57sIfC5Hrg9kyukFWobOVW7kz3HsMXPefDALDUx/JXuF4DJ53pJo+vYASkhSVW
         8qyf8SYw8drR14HghaDKmax2x7YT3TKidh03+oZN64ti0ItogOz2B+Px3auwCmHDSuGs
         Ffzn6ImJFY8D7lAo4EF0AV/usPeVogTXPAajLrJOaqHXQu05IMup5HloFRtqRO4CsA/z
         lCMw==
X-Gm-Message-State: AOAM532ESP9ZU9yh1w/wtRqh4anJcbPf5DPt6RjoaaoNUtPejdCzJ3yo
        5wuLHtzufUMPjvTcLfOGkqRdieyb3cwuuwHNzg0=
X-Google-Smtp-Source: ABdhPJwus1/wyi6JWbXWLLTKJMU00vG1qnAJd6dA63ndqQCheZ+vz4WD53ehjlZt6LBjx9HLIO+rTJgYttRyyTwRh9k=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr6387148ejr.499.1630015449917;
 Thu, 26 Aug 2021 15:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
In-Reply-To: <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 26 Aug 2021 15:03:57 -0700
Message-ID: <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
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

On Thu, Aug 26, 2021 at 1:03 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
> <naoya.horiguchi@nec.com> wrote:
> >
> > On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wrote:
> > > Currently hwpoison doesn't handle page cache THP, just give up and re=
turn
> > > error.  It is just because the hwpoison THP support was added before
> > > page cache THP was supported.
> > >
> > > Handling page cache THP is simple, they could be offlined by splittin=
g THP,
> > > just like anonymous THP.
> >
> > I think that this patch is not enough to contain an error because page =
table
> > entries pointing to subpages in shmem thp are removed during thp splitt=
ing.
> > Then the processes using the file newly allocates another (zeroed) page=
 for
> > the poisoned address, which results in slient data lost.
> >
> > According to the comment in unmap_page() at mm/huge_memory.c, file page=
s are
> > supposed to be faulted back on demand:
> >
> >   static void unmap_page(struct page *page)
> >   ...
> >           /*
> >            * Anon pages need migration entries to preserve them, but fi=
le
> >            * pages can simply be left unmapped, then faulted back on de=
mand.
> >            * If that is ever changed (perhaps for mlock), update remap_=
page().
> >            */
> >           if (PageAnon(page))
> >                   try_to_migrate(page, ttu_flags);
> >           else
> >                   try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);
> >
> > , but I don't think that faulting back during memory error handling mig=
ht be
> > hard because it does not have any direct information about mapping proc=
esses
> > of an error page.  memory_failure() uses try_to_unmap() to find them bu=
t
> > splitting of shmem thp makes this impossible, because it removes the re=
lated
> > page table entries.
> >
> > There was a discussion about another approach of keeping error pages in=
 page
> > cache for filesystem without backend storage.
> > https://lore.kernel.org/lkml/alpine.LSU.2.11.2103111312310.7859@eggly.a=
nvils/
> > This approach seems to me less complicated, but one concern is that thi=
s
> > change affects user-visible behavior of memory errors.  Keeping error p=
ages
> > in page cache means that the errors are persistent until next system re=
boot,
> > so we might need to define the way to clear the errors to continue to u=
se
> > the error file.  Current implementation is just to send SIGBUS to the
> > mapping processes (at least once), then forget about the error, so ther=
e is
> > no such issue.
> >
> > Another thought of possible solution might be to send SIGBUS immediatel=
y when
> > a memory error happens on a shmem thp. We can find all the mapping proc=
esses
> > before splitting shmem thp, so send SIGBUS first, then split it and con=
tain
> > the error page.  This is not elegant (giving up any optional actions) b=
ut
> > anyway we can avoid the silent data lost.
>
> Thanks a lot. I apologize I didn't notice you already posted a similar
> patch before.
>
> Yes, I think I focused on the soft offline part too much and missed
> the uncorrected error part and I admit I did underestimate the
> problem.
>
> I think Hugh's suggestion makes sense if we treat tmpfs as a regular
> filesystem (just memory backed). AFAIK, some filesystem, e.g. btrfs,
> may do checksum after reading from storage block then return an error
> if checksum is not right since it may indicate hardware failure on
> disk. Then the syscalls or page fault return error or SIGBUS.
>
> So in shmem/tmpfs case, if hwpoisoned page is met, just return error
> (-EIO or whatever) for syscall or SIGBUS for page fault. It does align
> with the behavior of other filesystems. It is definitely applications'
> responsibility to check the return value of read/write syscalls.

BTW, IIUC the dirty regular page cache (storage backed) would be left
in the page cache too, the clean page cache would be truncated since
they can be just reread from storage, right?

>
> >
> > - Naoya Horiguchi
> >
> > >
> > > The question is how to distinguish them with allocating and freeing T=
HP
> > > which can't be handled by hwpoison properly.  It seems page->mapping =
is a
> > > good indicator, both anonymous page and file page have it populated, =
but
> > > it won't be populated until the page is added to rmap or page cache, =
in
> > > other word, instantiated.  If page->mapping is populated it is
> > > definitely not in allocating or freeing.
> > >
> > > The later get_page_unless_zero() could serialize against page free
> > > paths.
> > >
> > > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > Cc: Oscar Salvador <osalvador@suse.de>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/memory-failure.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index 60df8fcd0444..caa0b0c1f5b8 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1149,13 +1149,16 @@ static int __get_hwpoison_page(struct page *p=
age)
> > >
> > >       if (PageTransHuge(head)) {
> > >               /*
> > > -              * Non anonymous thp exists only in allocation/free tim=
e. We
> > > -              * can't handle such a case correctly, so let's give it=
 up.
> > > -              * This should be better than triggering BUG_ON when ke=
rnel
> > > -              * tries to touch the "partially handled" page.
> > > +              * We can't handle allocating or freeing THPs, so let's=
 give
> > > +              * it up. This should be better than triggering BUG_ON =
when
> > > +              * kernel tries to touch the "partially handled" page.
> > > +              *
> > > +              * page->mapping won't be initialized until the page is=
 added
> > > +              * to rmap or page cache.  Use this as an indicator for=
 if
> > > +              * this is an instantiated page.
> > >                */
> > > -             if (!PageAnon(head)) {
> > > -                     pr_err("Memory failure: %#lx: non anonymous thp=
\n",
> > > +             if (!head->mapping) {
> > > +                     pr_err("Memory failure: %#lx: non instantiated =
thp\n",
> > >                               page_to_pfn(page));
> > >                       return 0;
> > >               }
> > > @@ -1414,12 +1417,12 @@ static int identify_page_state(unsigned long =
pfn, struct page *p,
> > >  static int try_to_split_thp_page(struct page *page, const char *msg)
> > >  {
> > >       lock_page(page);
> > > -     if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> > > +     if (!page->mapping || unlikely(split_huge_page(page))) {
> > >               unsigned long pfn =3D page_to_pfn(page);
> > >
> > >               unlock_page(page);
> > > -             if (!PageAnon(page))
> > > -                     pr_info("%s: %#lx: non anonymous thp\n", msg, p=
fn);
> > > +             if (!page->mapping)
> > > +                     pr_info("%s: %#lx: not instantiated thp\n", msg=
, pfn);
> > >               else
> > >                       pr_info("%s: %#lx: thp split failed\n", msg, pf=
n);
> > >               put_page(page);
> > > --
> > > 2.26.2
> > >
