Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0949B333466
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCJEb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 23:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCJEbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:31:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09178C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 20:31:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u4so31229855lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 20:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WIGax6CTq1Xbs0TuzVbRm3W+ixL+uW3gPzMQJNTmBTc=;
        b=TqD7y94HlFLHDScj49G0fQWaGp7CBYf4nP/E8C5Bi/oah1WoRbZ1I402rkr3EY5+i7
         GvTigviKn/UMDMXCkgfzFGndI32QTy8q4hNvV7ip61iMRmzY9dd0Rvuvq+FCD4s4MT80
         h3axSyzOJt2v5iWkfpk0fOeM5BM4SnmnSaWx4JrX9YJp5jJ8E6XaWqjHswYwDHYDezBU
         84oJ9nDOqvjPl79WVx3h9cDdwNmsWIxIH2Tl6bJXjelkofxrcTkFh+fXtW9ZFCNVckPO
         xOXiyJ5uCr7XdzbpU0de2z2WCvjkWmboH53ZpYQMqrQLiA6xigdDM0/seOpBkpIzQSnf
         U5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WIGax6CTq1Xbs0TuzVbRm3W+ixL+uW3gPzMQJNTmBTc=;
        b=d8bBpM0okrFqaz4GrUNK7uvLlCrjhKojG6SlOcDTz/e/rXCd+DzhO0SPuaIBEok+VE
         cniCPh/LfxdGUP3fpmUBmeeOw83d2OGoC5BLfAq8iFR53+QM7zZ81kj9XTi8z/MhQSWk
         i0eYxrQ+l+wG6325xPS8oLttLqHLC5sCIDmgoHTeoqHiy0SIwBTG8G9rwaFOnom3Tu2J
         9krrM2DCd/ejDvBoEoxe+BuMP9hSJXPeNmDNhoAZO54WQ4sLniO4PyPUmiWcp07+XXBS
         1DFcP+waJ4HbBNeGjQxgsiof5DLWQnil3bvTOWJnkEpGQTDqiMbLhPzKsxHa9CKBSHDo
         5lAg==
X-Gm-Message-State: AOAM532BXueR0fHqag0zBassZ1iPvRuGL2zTpozlPWcipwiIpFATgNtV
        9WNkT0BLxQp19EygxolosO8nqxx9j3f/xsrTkJE=
X-Google-Smtp-Source: ABdhPJwAubEzBljM17QavlA+7h3y4MyaIYDDeO+GKAEDrM9KG6YQuOMNFB86LJze7BNEyQY7w/+ty0rtfPmW9knm5yg=
X-Received: by 2002:ac2:5dd2:: with SMTP id x18mr921368lfq.550.1615350663329;
 Tue, 09 Mar 2021 20:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20210305022402.2721974-1-daeho43@gmail.com> <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
 <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com> <203c1945-9d48-098e-fa8f-1c86b1086ae3@huawei.com>
In-Reply-To: <203c1945-9d48-098e-fa8f-1c86b1086ae3@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 10 Mar 2021 13:30:52 +0900
Message-ID: <CACOAw_yvqCpq8i_XfmyWVWdtZhOQf4itw2D5Xxhk97RgWmVing@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get accumulated
 compression info
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've reconsidered this feature and decided to get just runtime info
of them, not persistent on disk.
I am re-writing it.

Thanks,

2021=EB=85=84 3=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 10:31, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/3/9 21:00, Daeho Jeong wrote:
> > 2021=EB=85=84 3=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:22=
, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2021/3/5 10:24, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> Added acc_compr_inodes to show accumulated compressed inode count and
> >>> acc_compr_blocks to show accumulated secured block count with
> >>
> >> I noticed that these stat numbers are recorded in extra reserved area =
in
> >> hot node curseg journal, the journal will be persisted only for umount
> >> or fastboot checkpoint, so the numbers are not so accurate... does thi=
s
> >> satisfy your requirement?
> >>
> >
> > Yes, we are satisfied with just getting rough number of them. But, it
>
> Alright,
>
> > would be better if you suggest more accurate way. :)
>
> I think this is the cheapest way to store rough number, otherwise it need=
s to change
> f2fs_checkpoint structure layout or add a new inner inode to persist thes=
e stat
> numbers if we want more accurate one.
>
> >
> >>> compression in sysfs. These can be re-initialized to "0" by writing "=
0"
> >>> value in one of both.
> >>
> >> Why do we allow reset the stat numbers?
> >>
> >
> > Actually, I want to have a way to clear any stale number of them, but
> > I agree we don't need this.
> >
> >> Why not covering all code with macro CONFIG_F2FS_FS_COMPRESSION, since=
 these
> >> numbers are only be updated when we enable compression.
> >>
> >
> > I wanted to keep the info even in the kernel with doesn't support
> > per-file compression if those had been written once. What do you
> > think?
>
> Sure, if so it's fine to me. :)
>
> Thanks,
>
> >
> >> Thanks,
> > .
> >
