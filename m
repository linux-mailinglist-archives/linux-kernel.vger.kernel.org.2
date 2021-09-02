Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA493FF349
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbhIBSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhIBSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:34:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4CCC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:33:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g22so4287129edy.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bvw5XRELYXdVTWskzlhuZWZ/Vps0mCMrCfQ2WshUnb4=;
        b=F+GdDBaEjiKI08+rRgLFty3QxLVZ2RYPnWenieeuwK8Y5aYFON8o5ulhkaX4+asBWg
         vUppTkN3PmEFtrqfR1v37YRw9hYWC7WMiid4L8t60mLUNkx3/wKgqLBjFQyj1QkY664C
         EcnD6AjozrNERfkjDHxEwGwsiW4L1+IcwrZSbf1/M0bc82mazrfB4kglLbmVleWUbMlZ
         Y5Wpn5yh/9NBsX3eqMooqkAAn2TcmNpzekTQi4nBiEeAi+X07+odEFLGK/hpzG0ZEOVX
         AYOCK4hkS0MLqkL9TMYFLlHdhPLJ7JfazXpRob4aihFX9qcs/y0Vm7E4swq07iv8vGvY
         1smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bvw5XRELYXdVTWskzlhuZWZ/Vps0mCMrCfQ2WshUnb4=;
        b=p7k+yfINS7I8xBJVSRcrDWeioHdwAou6eeL8eM30eqv40nqXnGgnmVBF5jfJhvK+JQ
         ALqSLf0lif/7FMquX6pKhY8h3BCAcLp39wS/9oqFENfCuIbsRGoIXXNrL+TgSGTkFuGT
         HiBAMnefAZaHPOKq1KyH4vngO6EdQibFt+GtBr03wuXWs4+4BeQVfWPkqYDVZFR+UkHY
         RbntRmD/wxpOZ7NE8WotOW7m0278XMPJlXmewk31jNkUtrBVvLsI8rwOJ3Hq+nOfM84f
         dMjfhER3OZDPHhfA3Yk2PNLeZizWIQfRu4fQz94fxjEc+gfCZMlyVuIcjbgrmDPo0O+m
         7nBA==
X-Gm-Message-State: AOAM531cJJVTLTRAUb6hQ/uT2UVsPt+joidHXiSkpBTkDLE6ouezny28
        wkG7/zcfVpoXHGoBS7U6xQIZow/S45mtBTW0qhY=
X-Google-Smtp-Source: ABdhPJxazeQpA+6WcG2SlstpBi0sQnsC1uS0cHz6aDai5OvPZSLFKsVJxJyGm9R6fxbdP+tw6L+R2WTvPDwbxPGwwvA=
X-Received: by 2002:aa7:c1ca:: with SMTP id d10mr4840133edp.294.1630607581909;
 Thu, 02 Sep 2021 11:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
 <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
 <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
 <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com> <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 2 Sep 2021 11:32:49 -0700
Message-ID: <CAHbLzkoBz2DwPXC5Nj+Kd6-pRaHgtZ-MGNPzYW4azN6Xpz3oyw@mail.gmail.com>
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

On Wed, Sep 1, 2021 at 8:07 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Mon, Aug 30, 2021 at 04:44:06PM -0700, Yang Shi wrote:
> > On Thu, Aug 26, 2021 at 10:02 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Thu, Aug 26, 2021 at 8:57 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=
=80=80=E7=9B=B4=E4=B9=9F)
> > > <naoya.horiguchi@nec.com> wrote:
> > > >
> > > > On Thu, Aug 26, 2021 at 03:03:57PM -0700, Yang Shi wrote:
> > > > > On Thu, Aug 26, 2021 at 1:03 PM Yang Shi <shy828301@gmail.com> wr=
ote:
> > > > > >
> > > > > > On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=80=E5=
=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wrote:
> > > > ...
> > > > > > >
> > > > > > > There was a discussion about another approach of keeping erro=
r pages in page
> > > > > > > cache for filesystem without backend storage.
> > > > > > > https://lore.kernel.org/lkml/alpine.LSU.2.11.2103111312310.78=
59@eggly.anvils/
> > > > > > > This approach seems to me less complicated, but one concern i=
s that this
> > > > > > > change affects user-visible behavior of memory errors.  Keepi=
ng error pages
> > > > > > > in page cache means that the errors are persistent until next=
 system reboot,
> > > > > > > so we might need to define the way to clear the errors to con=
tinue to use
> > > > > > > the error file.  Current implementation is just to send SIGBU=
S to the
> > > > > > > mapping processes (at least once), then forget about the erro=
r, so there is
> > > > > > > no such issue.
> > > > > > >
> > > > > > > Another thought of possible solution might be to send SIGBUS =
immediately when
> > > > > > > a memory error happens on a shmem thp. We can find all the ma=
pping processes
> > > > > > > before splitting shmem thp, so send SIGBUS first, then split =
it and contain
> > > > > > > the error page.  This is not elegant (giving up any optional =
actions) but
> > > > > > > anyway we can avoid the silent data lost.
> > > > > >
> > > > > > Thanks a lot. I apologize I didn't notice you already posted a =
similar
> > > > > > patch before.
> > > > > >
> > > > > > Yes, I think I focused on the soft offline part too much and mi=
ssed
> > > > > > the uncorrected error part and I admit I did underestimate the
> > > > > > problem.
> > > > > >
> > > > > > I think Hugh's suggestion makes sense if we treat tmpfs as a re=
gular
> > > > > > filesystem (just memory backed). AFAIK, some filesystem, e.g. b=
trfs,
> > > > > > may do checksum after reading from storage block then return an=
 error
> > > > > > if checksum is not right since it may indicate hardware failure=
 on
> > > > > > disk. Then the syscalls or page fault return error or SIGBUS.
> > > > > >
> > > > > > So in shmem/tmpfs case, if hwpoisoned page is met, just return =
error
> > > > > > (-EIO or whatever) for syscall or SIGBUS for page fault. It doe=
s align
> > > > > > with the behavior of other filesystems. It is definitely applic=
ations'
> > > > > > responsibility to check the return value of read/write syscalls=
.
> > > > >
> > > > > BTW, IIUC the dirty regular page cache (storage backed) would be =
left
> > > > > in the page cache too, the clean page cache would be truncated si=
nce
> > > > > they can be just reread from storage, right?
> > > >
> > > > A dirty page cache is also removed on error (me_pagecache_dirty() f=
alls
> > > > through me_pagecache_clean(), then truncate_error_page() is called)=
.
> > > > The main purpose of this is to separate off the error page from exi=
sing
> > > > data structures to minimize the risk of later accesses (maybe by ra=
ce or bug).
> > > > But we can change this behavior for specific file systems by updati=
ng
> > > > error_remove_page() callbacks in address_space_operation.
> > >
> > > Yeah, if fs's error_remove_page() is defined. It seems the filesystem=
s
> > > which have error_remove_page() defined just use generic_remove_page()
> > > except hugetlbfs. And the generic implementation just clears the dirt=
y
> > > flag and removes the page from page cache.
> > >
> > > If error_remove_page() is not defined, the page would stay in page
> > > cache since invalidate_inode_page() can't remove dirty page.
> > >
> > > >
> > > > Honestly, it seems to me that how dirty data is lost does not depen=
d on
> > > > file system, and I'm still not sure that this is really a right app=
roach
> > > > for the current issue.
> > >
> > > IMHO the biggest problem is that applications may see
> > > obsolete/inconsistent data silently, right? Actually keeping the
> > > corrupted page in page cache should be able to notify applications
> > > that they are accessing inconsistent data.
> >
> > The removal from page cache behavior may be much worse for shmem/tmpfs
> > since it actually removes the whole data blocks for the file. The user
> > will get all zero if the corrupted blocks are read without any
> > notification.
> >
> > The more I stared at the code and had tests done, the more I think we
> > should keep the corrupted page in page cache and notify the users.
> >
> > It seems easier for readonly filesystem. Just remove the page from
> > page cache since it always could read data from disk. This is also the
> > current behavior.
> >
> > For shmem, the page could be kept in page cache with dirty flag set
> > since it won't be written back.
> >
> > For regular filesystems that could do writeback, things are a little
> > bit more complicated since we need to prevent from writing back by
> > clearing dirty flag. Other than writeback we also need to distinguish
> > cache drop from truncation/hole punch/unlink. We don't want cache drop
> > (e.g. echo 1 > /proc/sys/vm/drop_caches) drop corrupted page. But
> > truncate/hole punch/unlink should be fine to remove the page since the
> > underlying data blocks will be gone too.
> >
> > Thanks to the refcount pin done by memory failure, cache drop can't
> > drop the page since it checks if the refcount is expected or not.
> > Truncate/hole punch/unlink doesn't check refcount so they could
> > proceed. But inode evict (slab shrinking path) may call truncate, so
> > the corrupted page may still be removed from page cache when the
> > underlying data blocks still exist IIUC. There might be other paths in
> > filesystems to have page cache truncate but the underlying data blocks
> > are still present.
> >
> > The read/write syscalls also need check hwpoisoned flag. I'm not sure
> > if I miss other syscalls or not.
>
> Thanks for analyzing, I think that filesystems supporting writeback might
> call filemap_write_and_wait() when evicting inode, which can notify error
> by AS_EIO flag in struct address_space.  But it does nothing for no-write=
back
> filesystems like shmem.  So we need better error report for them.

AFAIK the address_space error just works for fsync. Anyway I could be wrong=
.

I think clearing the dirty flag might be the easiest way? It seems
unnecessary to notify the users when writing back since the most write
back happens asynchronously. They should be notified when the page is
accessed, e.g. read/write and page fault.

I did some further investigation and got a clearer picture for
writeback filesystem:
1. The page should be not written back: clearing dirty flag could
prevent from writeback
2. The page should be not dropped (it shows as a clean page): the
refcount pin from hwpoison could prevent from invalidating (called by
cache drop, inode cache shrinking, etc), but it doesn't avoid
invalidation in DIO path (easy to deal with)
3. The page should be able to get truncated/hole punched/unlinked: it
works as it is
4. Notify users when the page is accessed, e.g. read/write, page fault
and other paths: this is hard

The hardest part is #4. Since there are too many paths in filesystems
that do *NOT* check if page is poisoned or not, e.g. read/write,
compression (btrfs, f2fs), etc. A couple of ways to handle it off the
top of my head:
1. Check hwpoison flag for every path, the most straightforward way,
but a lot work
2. Return NULL for poisoned page from page cache lookup, the most
callsites check if NULL is returned, this should have least work I
think. But the error handling in filesystems just return -ENOMEM, the
error code will incur confusion to the users obviously.
3. To improve #2, we could return error pointer, e.g. ERR_PTR(-EIO),
but this will involve significant amount of code change as well since
all the paths need check if the pointer is ERR or not.
4. #3 may break truncate, so maybe need convert hwpoison page to
exceptional entry? I'm not sure if I'm over-engineered or not.
5. We also could define a new FGP flag to return poisoned page, NULL
or error pointer. This also should need significant code change since
a lt callsites need to be contemplated.

Most filesystems use generic page fault handler (filemap_fault), just
very few have their own implementation, e.g. ceph, DAX, etc.

I don't know which way we should go, should need more advice.

>
> >
> > I'm not a filesystem expert so I'm not sure if I'm missing something
> > else or not. But I'm supposed the most should be covered.
> >
> > I'd like to start with shmem/tmpfs since it is relatively easier and
> > this also could unblock shmem THP hwpoison support. Any comment is
> > welcome.
>
> I think that keeping corrupted pages in page cache can be a better soluti=
on.
> So if you plan to write a patchset, I'm glad to review/test it.  Starting=
 with
> shmem/tmpfs sounds nice to me.

Thank you very much. Yes, I'm working on it. And I already had some
patches work (just check if page is hwpoisoned in every path, #1
approach listed above). I could clean up the patches and send out to
gather some feedback.

>
> Thanks,
> Naoya Horiguchi
