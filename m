Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33964403053
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhIGVfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhIGVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:35:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF29C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 14:34:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i21so1031528ejd.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ekA1hM42Ig0oMToDN3xqxTc68rtryW7vvpT1JdlIhKE=;
        b=oeprM0hW9m/o3602TuzndffPtLyH+AbriNttHxzcrlhRUqFHHq8InjWMTsU3uaUJyw
         UseB/NqmL6nq5ZA2NFby0HciYZCb3ox5E7IAsyli9Kcug7cr4/JT5jYnP0z3/F8r/Adc
         5UACimTNX8wWj9aPoghnA+7AwnL4EJSR1suTibz32pzJ41D9J532iNYSQVhgXZyFMCGs
         SOU7zvS3x1Ld97L99K3wlYCoEh2i3HdCWYapkszNxjBKP8Li65H1AW/3fwqJ1XpcXwxq
         7PskQWiVSMEGGYTR+qLod5uWRD6xRqofjgvYI4HIWqzrqujv7HRgF2cdHHkn5j9ODDkf
         BHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ekA1hM42Ig0oMToDN3xqxTc68rtryW7vvpT1JdlIhKE=;
        b=ICF+axh3emsFChUoJpLrLll2upBItDzqKyG3lIRjxpf2fgmTNtFJZ1AtjYB6uD1zcu
         D88qcTa7+1rcrNwcICxogn5o/uiTI5sJoFoA9gai2MBn5IR6eidGbDDyWYqHHaAhTtgJ
         xx4e82nbyX1cM+ZqzojI4gw37Klzr4gBOWvi/kd4LoL4ivBOyfC/l7DMO1FKE9T8ko62
         xZzaTwjXCOc4fwny38deLTaDnNZ//Hx9I/pA6aJ+Yx8H/N8nFW76yvq+v1NwnG33QbO7
         +5v6NpcukLKJUzjLcnZDNIRMvLR7cL0aSm1pJuf589XZjtSPRu7bNtVH+jacX1US/4dt
         ZOfw==
X-Gm-Message-State: AOAM533E/QMN3w86lCDNEtaPtQZ57enFPyy6t3210Mqj+TKW8wO72vX6
        0myzf2vrdQgV6229J1QDGpGT/pvq+bxrPBii8JGjG+bU
X-Google-Smtp-Source: ABdhPJzMdoTxeFmRf0kFcORK2f3Auz0MlQ3NdzhJVj4GX7YMXJV6ZL3hVcb+jWCC0m3AIIAr1xDG3Vpa0DtnnmzCuTU=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr454772ejc.62.1631050476674;
 Tue, 07 Sep 2021 14:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
 <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
 <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
 <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com>
 <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoBz2DwPXC5Nj+Kd6-pRaHgtZ-MGNPzYW4azN6Xpz3oyw@mail.gmail.com>
 <20210903115311.GA2477773@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoXaB_Hz_ZUw4BvR0PKV_ZV4F+hHekRS9RgUnxBYkMV_g@mail.gmail.com>
 <CAHbLzkpDK5qb1=VM8qeDdfjdqRyuL+ehwOK=8uZPYuR7J+xMEQ@mail.gmail.com>
In-Reply-To: <CAHbLzkpDK5qb1=VM8qeDdfjdqRyuL+ehwOK=8uZPYuR7J+xMEQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Sep 2021 14:34:24 -0700
Message-ID: <CAHbLzko6yTTnBopzASaYeuD5bBsc_kdhQxQoVd-wqEhkzX1agg@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 5:03 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Sep 3, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Fri, Sep 3, 2021 at 4:53 AM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
> > <naoya.horiguchi@nec.com> wrote:
> > >
> > > On Thu, Sep 02, 2021 at 11:32:49AM -0700, Yang Shi wrote:
> > > > On Wed, Sep 1, 2021 at 8:07 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=
=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > <naoya.horiguchi@nec.com> wrote:
> > > > >
> > > > > On Mon, Aug 30, 2021 at 04:44:06PM -0700, Yang Shi wrote:
> > > > > > On Thu, Aug 26, 2021 at 10:02 PM Yang Shi <shy828301@gmail.com>=
 wrote:
> > > > > > >
> > > > > > > On Thu, Aug 26, 2021 at 8:57 PM HORIGUCHI NAOYA(=E5=A0=80=E5=
=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Aug 26, 2021 at 03:03:57PM -0700, Yang Shi wrote:
> > > > > > > > > On Thu, Aug 26, 2021 at 1:03 PM Yang Shi <shy828301@gmail=
.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=
=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > > > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wr=
ote:
> > > > > > > > ...
> > > > > > > > > > >
> > > > > > > > > > > There was a discussion about another approach of keep=
ing error pages in page
> > > > > > > > > > > cache for filesystem without backend storage.
> > > > > > > > > > > https://lore.kernel.org/lkml/alpine.LSU.2.11.21031113=
12310.7859@eggly.anvils/
> > > > > > > > > > > This approach seems to me less complicated, but one c=
oncern is that this
> > > > > > > > > > > change affects user-visible behavior of memory errors=
.  Keeping error pages
> > > > > > > > > > > in page cache means that the errors are persistent un=
til next system reboot,
> > > > > > > > > > > so we might need to define the way to clear the error=
s to continue to use
> > > > > > > > > > > the error file.  Current implementation is just to se=
nd SIGBUS to the
> > > > > > > > > > > mapping processes (at least once), then forget about =
the error, so there is
> > > > > > > > > > > no such issue.
> > > > > > > > > > >
> > > > > > > > > > > Another thought of possible solution might be to send=
 SIGBUS immediately when
> > > > > > > > > > > a memory error happens on a shmem thp. We can find al=
l the mapping processes
> > > > > > > > > > > before splitting shmem thp, so send SIGBUS first, the=
n split it and contain
> > > > > > > > > > > the error page.  This is not elegant (giving up any o=
ptional actions) but
> > > > > > > > > > > anyway we can avoid the silent data lost.
> > > > > > > > > >
> > > > > > > > > > Thanks a lot. I apologize I didn't notice you already p=
osted a similar
> > > > > > > > > > patch before.
> > > > > > > > > >
> > > > > > > > > > Yes, I think I focused on the soft offline part too muc=
h and missed
> > > > > > > > > > the uncorrected error part and I admit I did underestim=
ate the
> > > > > > > > > > problem.
> > > > > > > > > >
> > > > > > > > > > I think Hugh's suggestion makes sense if we treat tmpfs=
 as a regular
> > > > > > > > > > filesystem (just memory backed). AFAIK, some filesystem=
, e.g. btrfs,
> > > > > > > > > > may do checksum after reading from storage block then r=
eturn an error
> > > > > > > > > > if checksum is not right since it may indicate hardware=
 failure on
> > > > > > > > > > disk. Then the syscalls or page fault return error or S=
IGBUS.
> > > > > > > > > >
> > > > > > > > > > So in shmem/tmpfs case, if hwpoisoned page is met, just=
 return error
> > > > > > > > > > (-EIO or whatever) for syscall or SIGBUS for page fault=
. It does align
> > > > > > > > > > with the behavior of other filesystems. It is definitel=
y applications'
> > > > > > > > > > responsibility to check the return value of read/write =
syscalls.
> > > > > > > > >
> > > > > > > > > BTW, IIUC the dirty regular page cache (storage backed) w=
ould be left
> > > > > > > > > in the page cache too, the clean page cache would be trun=
cated since
> > > > > > > > > they can be just reread from storage, right?
> > > > > > > >
> > > > > > > > A dirty page cache is also removed on error (me_pagecache_d=
irty() falls
> > > > > > > > through me_pagecache_clean(), then truncate_error_page() is=
 called).
> > > > > > > > The main purpose of this is to separate off the error page =
from exising
> > > > > > > > data structures to minimize the risk of later accesses (may=
be by race or bug).
> > > > > > > > But we can change this behavior for specific file systems b=
y updating
> > > > > > > > error_remove_page() callbacks in address_space_operation.
> > > > > > >
> > > > > > > Yeah, if fs's error_remove_page() is defined. It seems the fi=
lesystems
> > > > > > > which have error_remove_page() defined just use generic_remov=
e_page()
> > > > > > > except hugetlbfs. And the generic implementation just clears =
the dirty
> > > > > > > flag and removes the page from page cache.
> > > > > > >
> > > > > > > If error_remove_page() is not defined, the page would stay in=
 page
> > > > > > > cache since invalidate_inode_page() can't remove dirty page.
> > > > > > >
> > > > > > > >
> > > > > > > > Honestly, it seems to me that how dirty data is lost does n=
ot depend on
> > > > > > > > file system, and I'm still not sure that this is really a r=
ight approach
> > > > > > > > for the current issue.
> > > > > > >
> > > > > > > IMHO the biggest problem is that applications may see
> > > > > > > obsolete/inconsistent data silently, right? Actually keeping =
the
> > > > > > > corrupted page in page cache should be able to notify applica=
tions
> > > > > > > that they are accessing inconsistent data.
> > > > > >
> > > > > > The removal from page cache behavior may be much worse for shme=
m/tmpfs
> > > > > > since it actually removes the whole data blocks for the file. T=
he user
> > > > > > will get all zero if the corrupted blocks are read without any
> > > > > > notification.
> > > > > >
> > > > > > The more I stared at the code and had tests done, the more I th=
ink we
> > > > > > should keep the corrupted page in page cache and notify the use=
rs.
> > > > > >
> > > > > > It seems easier for readonly filesystem. Just remove the page f=
rom
> > > > > > page cache since it always could read data from disk. This is a=
lso the
> > > > > > current behavior.
> > > > > >
> > > > > > For shmem, the page could be kept in page cache with dirty flag=
 set
> > > > > > since it won't be written back.
> > > > > >
> > > > > > For regular filesystems that could do writeback, things are a l=
ittle
> > > > > > bit more complicated since we need to prevent from writing back=
 by
> > > > > > clearing dirty flag. Other than writeback we also need to disti=
nguish
> > > > > > cache drop from truncation/hole punch/unlink. We don't want cac=
he drop
> > > > > > (e.g. echo 1 > /proc/sys/vm/drop_caches) drop corrupted page. B=
ut
> > > > > > truncate/hole punch/unlink should be fine to remove the page si=
nce the
> > > > > > underlying data blocks will be gone too.
> > > > > >
> > > > > > Thanks to the refcount pin done by memory failure, cache drop c=
an't
> > > > > > drop the page since it checks if the refcount is expected or no=
t.
> > > > > > Truncate/hole punch/unlink doesn't check refcount so they could
> > > > > > proceed. But inode evict (slab shrinking path) may call truncat=
e, so
> > > > > > the corrupted page may still be removed from page cache when th=
e
> > > > > > underlying data blocks still exist IIUC. There might be other p=
aths in
> > > > > > filesystems to have page cache truncate but the underlying data=
 blocks
> > > > > > are still present.
> > > > > >
> > > > > > The read/write syscalls also need check hwpoisoned flag. I'm no=
t sure
> > > > > > if I miss other syscalls or not.
> > > > >
> > > > > Thanks for analyzing, I think that filesystems supporting writeba=
ck might
> > > > > call filemap_write_and_wait() when evicting inode, which can noti=
fy error
> > > > > by AS_EIO flag in struct address_space.  But it does nothing for =
no-writeback
> > > > > filesystems like shmem.  So we need better error report for them.
> > > >
> > > > AFAIK the address_space error just works for fsync. Anyway I could =
be wrong.
> > > >
> > > > I think clearing the dirty flag might be the easiest way? It seems
> > > > unnecessary to notify the users when writing back since the most wr=
ite
> > > > back happens asynchronously. They should be notified when the page =
is
> > > > accessed, e.g. read/write and page fault.
> > > >
> > > > I did some further investigation and got a clearer picture for
> > > > writeback filesystem:
> > > > 1. The page should be not written back: clearing dirty flag could
> > > > prevent from writeback
> > > > 2. The page should be not dropped (it shows as a clean page): the
> > > > refcount pin from hwpoison could prevent from invalidating (called =
by
> > > > cache drop, inode cache shrinking, etc), but it doesn't avoid
> > > > invalidation in DIO path (easy to deal with)
> > > > 3. The page should be able to get truncated/hole punched/unlinked: =
it
> > > > works as it is
> > > > 4. Notify users when the page is accessed, e.g. read/write, page fa=
ult
> > > > and other paths: this is hard
> > > >
> > > > The hardest part is #4. Since there are too many paths in filesyste=
ms
> > > > that do *NOT* check if page is poisoned or not, e.g. read/write,
> > > > compression (btrfs, f2fs), etc. A couple of ways to handle it off t=
he
> > > > top of my head:
> > > > 1. Check hwpoison flag for every path, the most straightforward way=
,
> > > > but a lot work
> > > > 2. Return NULL for poisoned page from page cache lookup, the most
> > > > callsites check if NULL is returned, this should have least work I
> > > > think. But the error handling in filesystems just return -ENOMEM, t=
he
> > > > error code will incur confusion to the users obviously.
> > > > 3. To improve #2, we could return error pointer, e.g. ERR_PTR(-EIO)=
,
> > > > but this will involve significant amount of code change as well sin=
ce
> > > > all the paths need check if the pointer is ERR or not.
> > >
> > > I think the approach #3 sounds good for now, it seems to me that thes=
e
> > > statements are about general ways to handle error pages on all page c=
ache
> > > users, so then the amount of code changes is a big problem, but when
> > > focusing on shmem/tmpfs, could the amount of changes be more handlabl=
e, or
> > > still large?
> >
> > Yeah, I agree #3 makes more sense. Just return an error when finding
> > out corrupted page. I think this is the right semantic.

I had a prototype patchset for #3, but now I have to consider stepping
back to rethink which way we should go. I actually did a patchset for
#1 too. By comparing the two patchsets and some deeper investigation
during preparing the two patchsets, I realized #3 may not be the best
way.

For #3 ERR_PTR will be returned so all the callers need to check the
return value otherwise invalid pointer may be dereferenced, but not
all callers really care about the content of the page, for example,
partial truncate which just set the truncated range in one page to 0.
So for such paths it needs additional modification if ERR_PTR is
returned. And if the callers have their own way to handle the
problematic pages we need to add a new FGP flag to tell FGP functions
to return the pointer to the page.

But we don't need to do anything for such paths if we go with #1. For
most paths (e.g. read/write) both ways need to check the validity of
the page by checking ERR PTR or page flag. But a lot of extra code
could be saved for the paths which don't care about the actual data
for #1.

> >
> > The amount of work for shmem should not be big.
> >
> > For other writeback filesystems we could make the filesystems check if
> > the page is error pointer or not one at a time. Once all filesystems
> > have been done, we change hwpoison code to keep corrupted page in page
> > cache so that we don't have to do all the things altogether in one
> > gigantic patchset. This approach should be more manageable and review
> > friendly IMHO.
> >
> > >
> > > > 4. #3 may break truncate, so maybe need convert hwpoison page to
> > > > exceptional entry? I'm not sure if I'm over-engineered or not.
> > >
> > > I think of taking refcount of inode associated with error pages to pr=
event
> > > the truncation via inode eviction, which might be worth considering.
> >
> > The memory_failure already does it by get_hwpoison_page(), right?
> >
> > >
> > > We somehow need keep error information on memory, which should be kep=
t from
> > > being removed, maybe except system reboot and explicit removal operat=
ion
> > > from the file's user.  So it might be helpful if we can deal with
> > > inode_evict from slab shrinking and from explicit calls from users.
> >
> > The refcount pin from get_hwpoison_page() could prevent the page from
> > being released by inode eviction from slab shrinking path since
> > invalidate_mapping_pages() is used which does need to freeze refcount.
> >
> > In the beginning I thought the problem is if we return error pointer
> > for truncate/invalidate, how can we convert it to regular page pointer
> > since truncate still need remove the page from page cache. But the
> > further investigation shows they call find_get_entry() which just
> > iterates xarray to return page. So it seems we don't need to do
> > anything. It doesn't matter to return poisoned page for
> > invalidate/truncate paths.
> >
> > There are some other callers of find_get_entry() may need attention. A
> > quick look shows they could backoff sooner if poisoned page is found.
> >
> > >
> > > > 5. We also could define a new FGP flag to return poisoned page, NUL=
L
> > > > or error pointer. This also should need significant code change sin=
ce
> > > > a lt callsites need to be contemplated.
> > >
> > > Could you explain a little more about which callers should use the fl=
ag?
> >
> > Just to solve the above invalidate/truncate problem and page fault
> > doesn't expect an error pointer. But it seems the above
> > invalidate/truncate paths don't matter. Page fault should be the only
> > user since page fault may need unlock the page if poisoned page is
> > returned.
>
> It seems page fault check IS_ERR(page) then just return
> VM_FAULT_HWPOISON. But I found a couple of places in shmem which want
> to return head page then handle subpage or just return the page but
> don't care the content of the page. They should ignore hwpoison. So I
> guess we'd better to have a FGP flag for such cases.
>
> >
> > >
> > > >
> > > > Most filesystems use generic page fault handler (filemap_fault), ju=
st
> > > > very few have their own implementation, e.g. ceph, DAX, etc.
> > > >
> > > > I don't know which way we should go, should need more advice.
> > >
> > > I think that DAX doesn't use page cache, so I think that it anyway ne=
eds
> > > special handling as a separate issue.
> >
> > Yes, DAX doesn't use page cache, but the data blocks of filesystem
> > actually are memory. It seems PMEM driver already has some mechanism
> > to handle poisoned page. I don't think we need handle it right now.
> >
> > >
> > > Thanks,
> > > Naoya Horiguchi
> > >
> > > >
> > > > >
> > > > > >
> > > > > > I'm not a filesystem expert so I'm not sure if I'm missing some=
thing
> > > > > > else or not. But I'm supposed the most should be covered.
> > > > > >
> > > > > > I'd like to start with shmem/tmpfs since it is relatively easie=
r and
> > > > > > this also could unblock shmem THP hwpoison support. Any comment=
 is
> > > > > > welcome.
> > > > >
> > > > > I think that keeping corrupted pages in page cache can be a bette=
r solution.
> > > > > So if you plan to write a patchset, I'm glad to review/test it.  =
Starting with
> > > > > shmem/tmpfs sounds nice to me.
> > > >
> > > > Thank you very much. Yes, I'm working on it. And I already had some
> > > > patches work (just check if page is hwpoisoned in every path, #1
> > > > approach listed above). I could clean up the patches and send out t=
o
> > > > gather some feedback.
