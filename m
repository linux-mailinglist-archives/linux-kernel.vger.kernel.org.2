Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19F63C3302
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 07:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhGJFVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhGJFVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 01:21:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3FDC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 22:18:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t30so11632692ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4mATH1rAH12LEIYPmoL9CK2Se4W4ULkmGT4gCq/XxE=;
        b=EaEdVjTewqP2FMVCV+xBPaBTDaAjtdPk7FAEjRMotPxW8/vhdaBacCCFRKRa1s7tMk
         bO0Hy5Jjnl/m86iHHSrRt1N6uDcSI1JiYuyba+oqQKVudS4ojL18RddFTKzaWCMoZ3O/
         e2zOqu0mThC9o9oBoU/Z1/NF2rzs5TvHVK9aol2IDNkbvYsqAXmDwBvu3F5er0diQcKQ
         k2C1x72XFgLdqUhsdYPUtAKl4rZlilJSNYsOhzkHLSOsCMjWDMIYe2KuzGqve+CeB0sc
         /FdnlsWkcioStZs16bjFB89Jw2CWWQ2KBd5s8AyZhGd1Uy2wslJe1sFHQg1s4DkrMybT
         rD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4mATH1rAH12LEIYPmoL9CK2Se4W4ULkmGT4gCq/XxE=;
        b=rRD5MX1K/1f61itf1YR7NJy3pgQhD22MjYZ0PEwfFbQGzdJcBPLsiGLyz1V2tzr6eQ
         uX0BOMSptSaAUxBv9Yw10YZnIiA+oCwnbImjrbtp96ZdYfo5oci03fe7NysFnmNVk+IH
         QkCXJEzKwMDqKHq5/se3oDYzZn2lqcfU3JF7pO+5rpvxrjur7e0//kr9LEL1DUaoZkYu
         6U0OsV3ysEqTqc3jlAZ91qOvKpKH0nZoBtiBYb4Gc8lORN0J1a6QvUsb66X6syRI3Wol
         iNFekTJDkPRile9rq6yepl9HUCCEw7Liam0aoThpJNWKyAd0ECqWU/YgWVFIIbxpFQ7K
         TMRA==
X-Gm-Message-State: AOAM530hHuuq7ABcEUKv6zIjUZNJ+HDTa5G/FLUjP0DgR1AmTI4vbwok
        0NwrFRQvEKcqCpe3Kpqdx0lOfQfRDMlpUXOTJ3Q=
X-Google-Smtp-Source: ABdhPJybYhyTYehKBEjPvWk0GmpxHKoNPM/gwNzhOC2xs0gou3sdV/v7MkjXQoQ0RuWW6J9FqJSvhoIZ0/8JWy65CsQ=
X-Received: by 2002:a2e:5812:: with SMTP id m18mr6295729ljb.327.1625894309549;
 Fri, 09 Jul 2021 22:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210709204430.1293298-1-daeho43@gmail.com> <4f88fac8-2838-45ac-8f87-789b8b7c2d09@kernel.org>
In-Reply-To: <4f88fac8-2838-45ac-8f87-789b8b7c2d09@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 9 Jul 2021 22:18:18 -0700
Message-ID: <CACOAw_zNH5hOJGSgbeBSMtOiJuU8Knh5oCVvA7rmsJBw5YYM9w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get GC info for
 each GC mode
To:     Chao Yu <chao@kernel.org>
Cc:     Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 5:17 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/7/10 4:44, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added gc_dirty_segs and gc_dirty_segs_mode sysfs nodes.
> > 1) "gc_dirty_segs" shows how many dirty segments have been
> > reclaimed by GC during a specific GC mode.
> > 2) "gc_dirty_segs_mode" is used to control for which gc mode
> > the "gc_dirty_segs" node shows.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++++++++
> >   fs/f2fs/debug.c                         |  9 ++++++++
> >   fs/f2fs/f2fs.h                          |  5 +++++
> >   fs/f2fs/gc.c                            |  1 +
> >   fs/f2fs/sysfs.c                         | 28 +++++++++++++++++++++++++
> >   5 files changed, 57 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 95155e4ec7fe..0d863eb185f6 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -493,3 +493,17 @@ Contact: "Chao Yu" <yuchao0@huawei.com>
> >   Description:        When ATGC is on, it controls age threshold to bypass GCing young
> >               candidates whose age is not beyond the threshold, by default it was
> >               initialized as 604800 seconds (equals to 7 days).
> > +
> > +What:                /sys/fs/f2fs/<disk>/gc_dirty_segs
>
> How about renaming gc_dirty_segs to gc_reclaimed_segments?

Makes sense.

>
>
> > +Date:                July 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show how many dirty segments have been reclaimed by GC during
> > +             a specific GC mode (0: GC normal, 1: GC idle CB, 2: GC idle greedy,
> > +             3: gc idle AT, 4: GC urgent high, 5: GC urgent low)
>
> 3. GC idle AT

Got it.

>
> > +             You can re-initialize this value to "0".
> > +
> > +What:                /sys/fs/f2fs/<disk>/gc_dirty_segs_mode
>
> You know, F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS needs to migrate all
> blocks of target segment to other place, no matter the segment has partially
> or fully valid blocks, so it looks 'gc_segment_mode' will be more appropriate?
>
> Thanks,

Reasonable~ Got it.
