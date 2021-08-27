Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AAF3F93E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhH0FD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhH0FDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:03:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB98C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:02:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc21so11197720ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WJZU1W9C8cBpY9d4/U11BLxrp06rNyBlDKPtwsLRXMM=;
        b=J+piEI8gb/AVLJ8olrHyXWjnSZLaFznFh6YuzV3DuD/uCNxWzjzm7GHodyHE+8OKuc
         oV6M40dTtAajKAxfVZgmjSig8NBk/abXjg0speMjnhlJlwHpC/fMtnSJzltkSx548qEs
         zzH3DDE9FpiuGP9zqUoJSKYAjWsCHjlYVWFD6rB04QKxyjN7FZQAUDB8b9ziyaIDCXL3
         qxio4McKSMaTb4ZwW3/zsHqWypiIIGOv8VjKzcQSjuE/4ncJu+J0GBAo0NoobE0Qby0k
         3IbJVh0t5Qlt08TJ66g5ec4sQ30QI32aSBEXADO7QC+SlRAQvSDObkF/ZuOVEL3X1cAN
         Xyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WJZU1W9C8cBpY9d4/U11BLxrp06rNyBlDKPtwsLRXMM=;
        b=lxs11BD5OjYk6jZHGzy+WbD0VbQMZ43BJ25ZPAqWe3kwWW8Eojh5fva0Fw6fpF3tfi
         BfIYc/cv9d4YOTv1DR/ytKU4gp7FIjb+2GSMI3TY2fmsu6iVBh2gvKz6aCLk5ETaweoS
         64tUOTYH4MYOIJSsvQw3jxM/Zh/qiaTuLjRQdkArZqewJqfjPuJQP64uQ6cTTzsEqxGH
         /4PdkdqoSQ9MM2l0tdNvIvG1ChPDedXTQfiudCVf3nq/p2i/oTvgsTtnlcr8rqdtpiLL
         VDPhhCsFP7mxy8G+oDF70GknABbawLo/OJxOKjr8PB3XvgUaSuMGxt9sY0L44R92ijkJ
         MGWw==
X-Gm-Message-State: AOAM5301tSFkXME8WXGOJXC+5aSB27Zt3ZDtU5qp5KZnXi0KPThBC6uI
        do4yi+4TR5BFjUSTlewJRt4paAkssqLYIzZcdTA=
X-Google-Smtp-Source: ABdhPJw9GkhV0bx78Z6tqUkc88QEzSkJ4ELK5LYUUxvq0taDhYTHOFQL4zgi1okJx84MwE/8whSlq7Cf73B7V2vbpwE=
X-Received: by 2002:a17:906:c182:: with SMTP id g2mr7915118ejz.507.1630040555540;
 Thu, 26 Aug 2021 22:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210824221322.7663-1-shy828301@gmail.com> <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
 <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com> <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 26 Aug 2021 22:02:23 -0700
Message-ID: <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
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

On Thu, Aug 26, 2021 at 8:57 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Thu, Aug 26, 2021 at 03:03:57PM -0700, Yang Shi wrote:
> > On Thu, Aug 26, 2021 at 1:03 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Wed, Aug 25, 2021 at 11:17 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=
=E3=80=80=E7=9B=B4=E4=B9=9F)
> > > <naoya.horiguchi@nec.com> wrote:
> > > >
> > > > On Tue, Aug 24, 2021 at 03:13:22PM -0700, Yang Shi wrote:
> ...
> > > >
> > > > There was a discussion about another approach of keeping error page=
s in page
> > > > cache for filesystem without backend storage.
> > > > https://lore.kernel.org/lkml/alpine.LSU.2.11.2103111312310.7859@egg=
ly.anvils/
> > > > This approach seems to me less complicated, but one concern is that=
 this
> > > > change affects user-visible behavior of memory errors.  Keeping err=
or pages
> > > > in page cache means that the errors are persistent until next syste=
m reboot,
> > > > so we might need to define the way to clear the errors to continue =
to use
> > > > the error file.  Current implementation is just to send SIGBUS to t=
he
> > > > mapping processes (at least once), then forget about the error, so =
there is
> > > > no such issue.
> > > >
> > > > Another thought of possible solution might be to send SIGBUS immedi=
ately when
> > > > a memory error happens on a shmem thp. We can find all the mapping =
processes
> > > > before splitting shmem thp, so send SIGBUS first, then split it and=
 contain
> > > > the error page.  This is not elegant (giving up any optional action=
s) but
> > > > anyway we can avoid the silent data lost.
> > >
> > > Thanks a lot. I apologize I didn't notice you already posted a simila=
r
> > > patch before.
> > >
> > > Yes, I think I focused on the soft offline part too much and missed
> > > the uncorrected error part and I admit I did underestimate the
> > > problem.
> > >
> > > I think Hugh's suggestion makes sense if we treat tmpfs as a regular
> > > filesystem (just memory backed). AFAIK, some filesystem, e.g. btrfs,
> > > may do checksum after reading from storage block then return an error
> > > if checksum is not right since it may indicate hardware failure on
> > > disk. Then the syscalls or page fault return error or SIGBUS.
> > >
> > > So in shmem/tmpfs case, if hwpoisoned page is met, just return error
> > > (-EIO or whatever) for syscall or SIGBUS for page fault. It does alig=
n
> > > with the behavior of other filesystems. It is definitely applications=
'
> > > responsibility to check the return value of read/write syscalls.
> >
> > BTW, IIUC the dirty regular page cache (storage backed) would be left
> > in the page cache too, the clean page cache would be truncated since
> > they can be just reread from storage, right?
>
> A dirty page cache is also removed on error (me_pagecache_dirty() falls
> through me_pagecache_clean(), then truncate_error_page() is called).
> The main purpose of this is to separate off the error page from exising
> data structures to minimize the risk of later accesses (maybe by race or =
bug).
> But we can change this behavior for specific file systems by updating
> error_remove_page() callbacks in address_space_operation.

Yeah, if fs's error_remove_page() is defined. It seems the filesystems
which have error_remove_page() defined just use generic_remove_page()
except hugetlbfs. And the generic implementation just clears the dirty
flag and removes the page from page cache.

If error_remove_page() is not defined, the page would stay in page
cache since invalidate_inode_page() can't remove dirty page.

>
> Honestly, it seems to me that how dirty data is lost does not depend on
> file system, and I'm still not sure that this is really a right approach
> for the current issue.

IMHO the biggest problem is that applications may see
obsolete/inconsistent data silently, right? Actually keeping the
corrupted page in page cache should be able to notify applications
that they are accessing inconsistent data.

>
> Thanks,
> Naoya Horiguchi
