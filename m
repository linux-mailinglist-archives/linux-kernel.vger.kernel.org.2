Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4843FBF84
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbhH3XpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhH3XpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:45:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47314C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:44:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g22so24096378edy.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bpG4L9d+cRIIKTqDcLTt0bxF3iyS6yijTSug5gYz8jc=;
        b=kbTtePJcgJcz3U3Xmu/pEDRBjEgazEu8NMuoIpNUvyXSc7hrHmeRGBWh6eEw/gPwtA
         +ZWH9s6Uui7QwLpqmzi6B39kQ/O9SzJ0QnWz+mZmm23GTZhNHdqCv425db2LEF8tMjpp
         JzsKHijZN9syr7c3MUIRXKgEKQoHMUmySxj7xeJWQ4lync/4vr+H9LE2YCGpFdWWwzYH
         2bhQ9wvpXQ6kxKLuPmi6dFIjHwZaGmx2pRJKK9sSB8hNKViqbdrpZdPcqzcQoNemtgnZ
         yNzi4d7UQtBCaVuBVcfOR3OvnSuZhJWD+sXWLT1965ft5KH5chguvd9AByAwYojYU2ry
         hLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bpG4L9d+cRIIKTqDcLTt0bxF3iyS6yijTSug5gYz8jc=;
        b=l8I8It0VS+KAhPRRitbwE5mx8TICQjUYWLeDCf0K52b1SXh4KzNqlwoWSUCXb0966u
         cbuANHvWh5slBl9Rtkn2g03grsI6RQqDLufwbAO0Eo+KlrEbQys+HRlviXD431HqnkiI
         qUsxBWAsbwxoXMLAsF4Q70cjuY5cZWsiI1d44vxjHEMsCHvQuHpLCAZ1pvO7Ir4NuzEH
         UVxyxlR+MTVFhld5UQEFuAlyAccP8hcj6H53KGF4Ui10N443ZXz8zvXOWZAqVVzC07ce
         MPvhXrLCit+IjH0rUJnz0DlcVQMf4gYdDOkIAWdc78GXhmaXzhSNroaCEhH7MWqHEMuy
         noOg==
X-Gm-Message-State: AOAM533OkTtriKUca4mOj/W42m0QIA+xppIEZJAk0KNk+bBx3yTbgh4p
        AzbiFownhV0asY+lqve9VZA6a/vxx1fzt0GahG8=
X-Google-Smtp-Source: ABdhPJw+3MEgNduoDicMT0qQOJkhmJV2xyK4cE4U5oDEmVEpi90YNIG2XvnCgssov+UL1WUGvhDn9h4QXpLfywbaasc=
X-Received: by 2002:a50:eb8a:: with SMTP id y10mr26907900edr.137.1630367058843;
 Mon, 30 Aug 2021 16:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
 <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
 <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
In-Reply-To: <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Aug 2021 16:44:06 -0700
Message-ID: <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com>
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

On Thu, Aug 26, 2021 at 10:02 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Aug 26, 2021 at 8:57 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
> <naoya.horiguchi@nec.com> wrote:
> >
> > On Thu, Aug 26, 2021 at 03:03:57PM -0700, Yang Shi wrote:
> > > On Thu, Aug 26, 2021 at 1:03 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=
=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > > <naoya.horiguchi@nec.com> wrote:
> > > > >
> > > > > On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wrote:
> > ...
> > > > >
> > > > > There was a discussion about another approach of keeping error pa=
ges in page
> > > > > cache for filesystem without backend storage.
> > > > > https://lore.kernel.org/lkml/alpine.LSU.2.11.2103111312310.7859@e=
ggly.anvils/
> > > > > This approach seems to me less complicated, but one concern is th=
at this
> > > > > change affects user-visible behavior of memory errors.  Keeping e=
rror pages
> > > > > in page cache means that the errors are persistent until next sys=
tem reboot,
> > > > > so we might need to define the way to clear the errors to continu=
e to use
> > > > > the error file.  Current implementation is just to send SIGBUS to=
 the
> > > > > mapping processes (at least once), then forget about the error, s=
o there is
> > > > > no such issue.
> > > > >
> > > > > Another thought of possible solution might be to send SIGBUS imme=
diately when
> > > > > a memory error happens on a shmem thp. We can find all the mappin=
g processes
> > > > > before splitting shmem thp, so send SIGBUS first, then split it a=
nd contain
> > > > > the error page.  This is not elegant (giving up any optional acti=
ons) but
> > > > > anyway we can avoid the silent data lost.
> > > >
> > > > Thanks a lot. I apologize I didn't notice you already posted a simi=
lar
> > > > patch before.
> > > >
> > > > Yes, I think I focused on the soft offline part too much and missed
> > > > the uncorrected error part and I admit I did underestimate the
> > > > problem.
> > > >
> > > > I think Hugh's suggestion makes sense if we treat tmpfs as a regula=
r
> > > > filesystem (just memory backed). AFAIK, some filesystem, e.g. btrfs=
,
> > > > may do checksum after reading from storage block then return an err=
or
> > > > if checksum is not right since it may indicate hardware failure on
> > > > disk. Then the syscalls or page fault return error or SIGBUS.
> > > >
> > > > So in shmem/tmpfs case, if hwpoisoned page is met, just return erro=
r
> > > > (-EIO or whatever) for syscall or SIGBUS for page fault. It does al=
ign
> > > > with the behavior of other filesystems. It is definitely applicatio=
ns'
> > > > responsibility to check the return value of read/write syscalls.
> > >
> > > BTW, IIUC the dirty regular page cache (storage backed) would be left
> > > in the page cache too, the clean page cache would be truncated since
> > > they can be just reread from storage, right?
> >
> > A dirty page cache is also removed on error (me_pagecache_dirty() falls
> > through me_pagecache_clean(), then truncate_error_page() is called).
> > The main purpose of this is to separate off the error page from exising
> > data structures to minimize the risk of later accesses (maybe by race o=
r bug).
> > But we can change this behavior for specific file systems by updating
> > error_remove_page() callbacks in address_space_operation.
>
> Yeah, if fs's error_remove_page() is defined. It seems the filesystems
> which have error_remove_page() defined just use generic_remove_page()
> except hugetlbfs. And the generic implementation just clears the dirty
> flag and removes the page from page cache.
>
> If error_remove_page() is not defined, the page would stay in page
> cache since invalidate_inode_page() can't remove dirty page.
>
> >
> > Honestly, it seems to me that how dirty data is lost does not depend on
> > file system, and I'm still not sure that this is really a right approac=
h
> > for the current issue.
>
> IMHO the biggest problem is that applications may see
> obsolete/inconsistent data silently, right? Actually keeping the
> corrupted page in page cache should be able to notify applications
> that they are accessing inconsistent data.

The removal from page cache behavior may be much worse for shmem/tmpfs
since it actually removes the whole data blocks for the file. The user
will get all zero if the corrupted blocks are read without any
notification.

The more I stared at the code and had tests done, the more I think we
should keep the corrupted page in page cache and notify the users.

It seems easier for readonly filesystem. Just remove the page from
page cache since it always could read data from disk. This is also the
current behavior.

For shmem, the page could be kept in page cache with dirty flag set
since it won't be written back.

For regular filesystems that could do writeback, things are a little
bit more complicated since we need to prevent from writing back by
clearing dirty flag. Other than writeback we also need to distinguish
cache drop from truncation/hole punch/unlink. We don't want cache drop
(e.g. echo 1 > /proc/sys/vm/drop_caches) drop corrupted page. But
truncate/hole punch/unlink should be fine to remove the page since the
underlying data blocks will be gone too.

Thanks to the refcount pin done by memory failure, cache drop can't
drop the page since it checks if the refcount is expected or not.
Truncate/hole punch/unlink doesn't check refcount so they could
proceed. But inode evict (slab shrinking path) may call truncate, so
the corrupted page may still be removed from page cache when the
underlying data blocks still exist IIUC. There might be other paths in
filesystems to have page cache truncate but the underlying data blocks
are still present.

The read/write syscalls also need check hwpoisoned flag. I'm not sure
if I miss other syscalls or not.

I'm not a filesystem expert so I'm not sure if I'm missing something
else or not. But I'm supposed the most should be covered.

I'd like to start with shmem/tmpfs since it is relatively easier and
this also could unblock shmem THP hwpoison support. Any comment is
welcome.

>
> >
> > Thanks,
> > Naoya Horiguchi
