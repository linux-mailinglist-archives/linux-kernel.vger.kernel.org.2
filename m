Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D2400474
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbhICSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhICSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:02:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D9C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:01:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm15so65565edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SyJvZD7lJqqKYwlbh3qnfFLdpMkzDzlAGBsSQWDkD5w=;
        b=n5XzQx5dwdaPhJK1h+CE9a6mF4Br+S1/pJtepeTDnohOO7xyWJPm+QnqWda/DHHq7D
         jjAEDW/dYhSBZVnvhDWxxzIcf1rfJnEfaacndZivpBSFNwIyZriDFF24JQZStPqnz4Vl
         vgLdkGcCBzf+rcYXkcK0uu2xhHIzvOqyLI/yosnF8YodO3Ae6hpIRH1Cwbpu/qERwo5O
         djdc+3nvvyzrsireY/MraUnUdO24feUOikzw+5OZNtVmJHtRr1J9hlB/HWUsfGsfL72m
         D89vAI/RpCCSf26JcezaivsXcnOCfgq6n69jrGPlo+vT47UZ9JYmApSJoIOsPfd3/+9b
         AWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SyJvZD7lJqqKYwlbh3qnfFLdpMkzDzlAGBsSQWDkD5w=;
        b=fMtngPAvkETLwvefD4lHHEYALeAbZ0+aHLjC2CPhnk5Ktrdd3mde9Yi+h0xlCXX6xo
         vfKr2mj8g1hGza82sjQROO8a67mH75wB/kxU8AjXRQZLTHZq9l/eevU3pa89ZsG64Kvk
         CrciPJdgQlmwH+TqpwukogXHfnkUEuw4kR0eWAu40aroZTcTbDLO2JQ5u9YDbDtfL558
         /uuTtbjkXfvK1C0VIhluqpdNKKlDlDcoE56tOVK4tpBWg1eXTX81sc1OQO7SwWQn7GlZ
         re2oRLaAZDNhDKw34Gj54rwPsu6ICbEG41FhP+dMDnmJbhx8Ie11yeoPqZW1wmGvZ/o7
         kwXA==
X-Gm-Message-State: AOAM533SghSs/CUw0Uc648ZCCNMJHjHg85LE3i8msYS5Y5FlZBV/0+x+
        T3AkPF78krq7Ei77ZPejNa3X4CPYnn9Ok+EkpnQ=
X-Google-Smtp-Source: ABdhPJz8JjVN4PhIQNiM04OqiPSJFG8h/Sao0o7hqry+k1odp5POWqQ7kselvysr37HquwccQE/rCkxkeQiWjp/nEqA=
X-Received: by 2002:aa7:ccd6:: with SMTP id y22mr200057edt.363.1630692081245;
 Fri, 03 Sep 2021 11:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
 <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
 <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
 <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com>
 <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoBz2DwPXC5Nj+Kd6-pRaHgtZ-MGNPzYW4azN6Xpz3oyw@mail.gmail.com>
 <20210903115311.GA2477773@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210903115311.GA2477773@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 3 Sep 2021 11:01:09 -0700
Message-ID: <CAHbLzkoXaB_Hz_ZUw4BvR0PKV_ZV4F+hHekRS9RgUnxBYkMV_g@mail.gmail.com>
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

On Fri, Sep 3, 2021 at 4:53 AM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Thu, Sep 02, 2021 at 11:32:49AM -0700, Yang Shi wrote:
> > On Wed, Sep 1, 2021 at 8:07 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
> > <naoya.horiguchi@nec.com> wrote:
> > >
> > > On Mon, Aug 30, 2021 at 04:44:06PM -0700, Yang Shi wrote:
> > > > On Thu, Aug 26, 2021 at 10:02 PM Yang Shi <shy828301@gmail.com> wro=
te:
> > > > >
> > > > > On Thu, Aug 26, 2021 at 8:57 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=
=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 26, 2021 at 03:03:57PM -0700, Yang Shi wrote:
> > > > > > > On Thu, Aug 26, 2021 at 1:03 PM Yang Shi <shy828301@gmail.com=
> wrote:
> > > > > > > >
> > > > > > > > On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=80=
=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > > > > > <naoya.horiguchi@nec.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wrote:
> > > > > > ...
> > > > > > > > >
> > > > > > > > > There was a discussion about another approach of keeping =
error pages in page
> > > > > > > > > cache for filesystem without backend storage.
> > > > > > > > > https://lore.kernel.org/lkml/alpine.LSU.2.11.210311131231=
0.7859@eggly.anvils/
> > > > > > > > > This approach seems to me less complicated, but one conce=
rn is that this
> > > > > > > > > change affects user-visible behavior of memory errors.  K=
eeping error pages
> > > > > > > > > in page cache means that the errors are persistent until =
next system reboot,
> > > > > > > > > so we might need to define the way to clear the errors to=
 continue to use
> > > > > > > > > the error file.  Current implementation is just to send S=
IGBUS to the
> > > > > > > > > mapping processes (at least once), then forget about the =
error, so there is
> > > > > > > > > no such issue.
> > > > > > > > >
> > > > > > > > > Another thought of possible solution might be to send SIG=
BUS immediately when
> > > > > > > > > a memory error happens on a shmem thp. We can find all th=
e mapping processes
> > > > > > > > > before splitting shmem thp, so send SIGBUS first, then sp=
lit it and contain
> > > > > > > > > the error page.  This is not elegant (giving up any optio=
nal actions) but
> > > > > > > > > anyway we can avoid the silent data lost.
> > > > > > > >
> > > > > > > > Thanks a lot. I apologize I didn't notice you already poste=
d a similar
> > > > > > > > patch before.
> > > > > > > >
> > > > > > > > Yes, I think I focused on the soft offline part too much an=
d missed
> > > > > > > > the uncorrected error part and I admit I did underestimate =
the
> > > > > > > > problem.
> > > > > > > >
> > > > > > > > I think Hugh's suggestion makes sense if we treat tmpfs as =
a regular
> > > > > > > > filesystem (just memory backed). AFAIK, some filesystem, e.=
g. btrfs,
> > > > > > > > may do checksum after reading from storage block then retur=
n an error
> > > > > > > > if checksum is not right since it may indicate hardware fai=
lure on
> > > > > > > > disk. Then the syscalls or page fault return error or SIGBU=
S.
> > > > > > > >
> > > > > > > > So in shmem/tmpfs case, if hwpoisoned page is met, just ret=
urn error
> > > > > > > > (-EIO or whatever) for syscall or SIGBUS for page fault. It=
 does align
> > > > > > > > with the behavior of other filesystems. It is definitely ap=
plications'
> > > > > > > > responsibility to check the return value of read/write sysc=
alls.
> > > > > > >
> > > > > > > BTW, IIUC the dirty regular page cache (storage backed) would=
 be left
> > > > > > > in the page cache too, the clean page cache would be truncate=
d since
> > > > > > > they can be just reread from storage, right?
> > > > > >
> > > > > > A dirty page cache is also removed on error (me_pagecache_dirty=
() falls
> > > > > > through me_pagecache_clean(), then truncate_error_page() is cal=
led).
> > > > > > The main purpose of this is to separate off the error page from=
 exising
> > > > > > data structures to minimize the risk of later accesses (maybe b=
y race or bug).
> > > > > > But we can change this behavior for specific file systems by up=
dating
> > > > > > error_remove_page() callbacks in address_space_operation.
> > > > >
> > > > > Yeah, if fs's error_remove_page() is defined. It seems the filesy=
stems
> > > > > which have error_remove_page() defined just use generic_remove_pa=
ge()
> > > > > except hugetlbfs. And the generic implementation just clears the =
dirty
> > > > > flag and removes the page from page cache.
> > > > >
> > > > > If error_remove_page() is not defined, the page would stay in pag=
e
> > > > > cache since invalidate_inode_page() can't remove dirty page.
> > > > >
> > > > > >
> > > > > > Honestly, it seems to me that how dirty data is lost does not d=
epend on
> > > > > > file system, and I'm still not sure that this is really a right=
 approach
> > > > > > for the current issue.
> > > > >
> > > > > IMHO the biggest problem is that applications may see
> > > > > obsolete/inconsistent data silently, right? Actually keeping the
> > > > > corrupted page in page cache should be able to notify application=
s
> > > > > that they are accessing inconsistent data.
> > > >
> > > > The removal from page cache behavior may be much worse for shmem/tm=
pfs
> > > > since it actually removes the whole data blocks for the file. The u=
ser
> > > > will get all zero if the corrupted blocks are read without any
> > > > notification.
> > > >
> > > > The more I stared at the code and had tests done, the more I think =
we
> > > > should keep the corrupted page in page cache and notify the users.
> > > >
> > > > It seems easier for readonly filesystem. Just remove the page from
> > > > page cache since it always could read data from disk. This is also =
the
> > > > current behavior.
> > > >
> > > > For shmem, the page could be kept in page cache with dirty flag set
> > > > since it won't be written back.
> > > >
> > > > For regular filesystems that could do writeback, things are a littl=
e
> > > > bit more complicated since we need to prevent from writing back by
> > > > clearing dirty flag. Other than writeback we also need to distingui=
sh
> > > > cache drop from truncation/hole punch/unlink. We don't want cache d=
rop
> > > > (e.g. echo 1 > /proc/sys/vm/drop_caches) drop corrupted page. But
> > > > truncate/hole punch/unlink should be fine to remove the page since =
the
> > > > underlying data blocks will be gone too.
> > > >
> > > > Thanks to the refcount pin done by memory failure, cache drop can't
> > > > drop the page since it checks if the refcount is expected or not.
> > > > Truncate/hole punch/unlink doesn't check refcount so they could
> > > > proceed. But inode evict (slab shrinking path) may call truncate, s=
o
> > > > the corrupted page may still be removed from page cache when the
> > > > underlying data blocks still exist IIUC. There might be other paths=
 in
> > > > filesystems to have page cache truncate but the underlying data blo=
cks
> > > > are still present.
> > > >
> > > > The read/write syscalls also need check hwpoisoned flag. I'm not su=
re
> > > > if I miss other syscalls or not.
> > >
> > > Thanks for analyzing, I think that filesystems supporting writeback m=
ight
> > > call filemap_write_and_wait() when evicting inode, which can notify e=
rror
> > > by AS_EIO flag in struct address_space.  But it does nothing for no-w=
riteback
> > > filesystems like shmem.  So we need better error report for them.
> >
> > AFAIK the address_space error just works for fsync. Anyway I could be w=
rong.
> >
> > I think clearing the dirty flag might be the easiest way? It seems
> > unnecessary to notify the users when writing back since the most write
> > back happens asynchronously. They should be notified when the page is
> > accessed, e.g. read/write and page fault.
> >
> > I did some further investigation and got a clearer picture for
> > writeback filesystem:
> > 1. The page should be not written back: clearing dirty flag could
> > prevent from writeback
> > 2. The page should be not dropped (it shows as a clean page): the
> > refcount pin from hwpoison could prevent from invalidating (called by
> > cache drop, inode cache shrinking, etc), but it doesn't avoid
> > invalidation in DIO path (easy to deal with)
> > 3. The page should be able to get truncated/hole punched/unlinked: it
> > works as it is
> > 4. Notify users when the page is accessed, e.g. read/write, page fault
> > and other paths: this is hard
> >
> > The hardest part is #4. Since there are too many paths in filesystems
> > that do *NOT* check if page is poisoned or not, e.g. read/write,
> > compression (btrfs, f2fs), etc. A couple of ways to handle it off the
> > top of my head:
> > 1. Check hwpoison flag for every path, the most straightforward way,
> > but a lot work
> > 2. Return NULL for poisoned page from page cache lookup, the most
> > callsites check if NULL is returned, this should have least work I
> > think. But the error handling in filesystems just return -ENOMEM, the
> > error code will incur confusion to the users obviously.
> > 3. To improve #2, we could return error pointer, e.g. ERR_PTR(-EIO),
> > but this will involve significant amount of code change as well since
> > all the paths need check if the pointer is ERR or not.
>
> I think the approach #3 sounds good for now, it seems to me that these
> statements are about general ways to handle error pages on all page cache
> users, so then the amount of code changes is a big problem, but when
> focusing on shmem/tmpfs, could the amount of changes be more handlable, o=
r
> still large?

Yeah, I agree #3 makes more sense. Just return an error when finding
out corrupted page. I think this is the right semantic.

The amount of work for shmem should not be big.

For other writeback filesystems we could make the filesystems check if
the page is error pointer or not one at a time. Once all filesystems
have been done, we change hwpoison code to keep corrupted page in page
cache so that we don't have to do all the things altogether in one
gigantic patchset. This approach should be more manageable and review
friendly IMHO.

>
> > 4. #3 may break truncate, so maybe need convert hwpoison page to
> > exceptional entry? I'm not sure if I'm over-engineered or not.
>
> I think of taking refcount of inode associated with error pages to preven=
t
> the truncation via inode eviction, which might be worth considering.

The memory_failure already does it by get_hwpoison_page(), right?

>
> We somehow need keep error information on memory, which should be kept fr=
om
> being removed, maybe except system reboot and explicit removal operation
> from the file's user.  So it might be helpful if we can deal with
> inode_evict from slab shrinking and from explicit calls from users.

The refcount pin from get_hwpoison_page() could prevent the page from
being released by inode eviction from slab shrinking path since
invalidate_mapping_pages() is used which does need to freeze refcount.

In the beginning I thought the problem is if we return error pointer
for truncate/invalidate, how can we convert it to regular page pointer
since truncate still need remove the page from page cache. But the
further investigation shows they call find_get_entry() which just
iterates xarray to return page. So it seems we don't need to do
anything. It doesn't matter to return poisoned page for
invalidate/truncate paths.

There are some other callers of find_get_entry() may need attention. A
quick look shows they could backoff sooner if poisoned page is found.

>
> > 5. We also could define a new FGP flag to return poisoned page, NULL
> > or error pointer. This also should need significant code change since
> > a lt callsites need to be contemplated.
>
> Could you explain a little more about which callers should use the flag?

Just to solve the above invalidate/truncate problem and page fault
doesn't expect an error pointer. But it seems the above
invalidate/truncate paths don't matter. Page fault should be the only
user since page fault may need unlock the page if poisoned page is
returned.

>
> >
> > Most filesystems use generic page fault handler (filemap_fault), just
> > very few have their own implementation, e.g. ceph, DAX, etc.
> >
> > I don't know which way we should go, should need more advice.
>
> I think that DAX doesn't use page cache, so I think that it anyway needs
> special handling as a separate issue.

Yes, DAX doesn't use page cache, but the data blocks of filesystem
actually are memory. It seems PMEM driver already has some mechanism
to handle poisoned page. I don't think we need handle it right now.

>
> Thanks,
> Naoya Horiguchi
>
> >
> > >
> > > >
> > > > I'm not a filesystem expert so I'm not sure if I'm missing somethin=
g
> > > > else or not. But I'm supposed the most should be covered.
> > > >
> > > > I'd like to start with shmem/tmpfs since it is relatively easier an=
d
> > > > this also could unblock shmem THP hwpoison support. Any comment is
> > > > welcome.
> > >
> > > I think that keeping corrupted pages in page cache can be a better so=
lution.
> > > So if you plan to write a patchset, I'm glad to review/test it.  Star=
ting with
> > > shmem/tmpfs sounds nice to me.
> >
> > Thank you very much. Yes, I'm working on it. And I already had some
> > patches work (just check if page is hwpoisoned in every path, #1
> > approach listed above). I could clean up the patches and send out to
> > gather some feedback.
