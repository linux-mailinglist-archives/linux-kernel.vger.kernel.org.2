Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249BE3F2ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhHTPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhHTPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9337C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:20:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z2so21384728lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3Z4SJ92yMv1cU71E0Fc+Pt/WE6+UKZ4tmdm2fUYN4I=;
        b=fGtrdnFpPtcwTxnxcEqd4hXGv5m/IwXMu6zHgsjkRMyBail4gdmQ/puuHj/QWaCVCq
         B2+s+lrSUego0C1JxtiO6EjLCGAn/8Ck/cQE1W63CW1z2crAi+dg3BUldWvoeIg9jSu2
         Fvmiu9DV0v9BJGeAeuge0DCOYk2uKDPdFAq3Noc5iZ2x1NFtcGPHyzds0c4H3NNOprhj
         4wpO9zq2tB5rTwrwrld2vmyKyjFpURdVstDegxPmx9/2j8+oDmc1yas3l1RDJG8IE3NC
         ryOzksZoKWzIW0A23CgHMu8d9BZvtMw6+B2AmKdorepfZulAzBJHoIq6XjkQ+RZE91f6
         tbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3Z4SJ92yMv1cU71E0Fc+Pt/WE6+UKZ4tmdm2fUYN4I=;
        b=qIQgfvihcPBRzerZvUzaMsA0iK4RvoY0eHKnI9jcVsviF8zeY2cSX3066E3AtT5i0Z
         WM5wSrbSaAo5HurNicE20Xpzww+BMijXWg5zDxS97bIWCsoI3rnKxnB++nyGIlITzF9e
         LDF5mxTdR6JNh/Nm2Bt8PqOQ/YL3vdCjSW+/r/O9+drXBFsUo+LA8ocTmEomBgjsF0Y3
         GDp5DdC3qUW/ODdXYyznIp1lgo+PnWbXRPtb5yAPXeRYbQqFCdRzsQCnOlgG9i+aNsJt
         xAujW6VxjOyAQcOjrRnIMeE3WUvNQ/to70EJtszZHqLQ2eOikD+shg7chPRuNKmjwcYj
         Tbpw==
X-Gm-Message-State: AOAM531T84C9cK1mKQhYUdvFTRTQP7aYV2G3Yn0RWYZraJOsZp2rdj+i
        vH2Ghr62PR8XxmUtcjz2iijIu59d42duqYwfsFQ=
X-Google-Smtp-Source: ABdhPJwhgWUpB24B5xOZbrVx5H/6RcYKALsAPmKxUwkQH/ZVyccnhTyVnPNEs0g+SZBhNeYKkeBze0gjCredrfZxJ28=
X-Received: by 2002:a05:6512:c08:: with SMTP id z8mr15321526lfu.533.1629472851101;
 Fri, 20 Aug 2021 08:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210808215234.1939266-1-daeho43@gmail.com> <5cce41d6-d59a-0596-6d14-e313aa91c78b@kernel.org>
In-Reply-To: <5cce41d6-d59a-0596-6d14-e313aa91c78b@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 20 Aug 2021 08:20:39 -0700
Message-ID: <CACOAw_zdL+3TPxJfsrZ0+nMHBbzU+uHNcp4vych1QCMMpvUnug@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: change fiemap print out format
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 3:15 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/8/9 5:52, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Given fiemap way to print out extents in the kernel, we can correctly
> > print the layout of each file in a unit of extent, not block. So, I
> > changed fiemap print out way like below.
> >
> > Fiemap: offset = 0 len = 60
> >       logical addr.    physical addr.   length           flags
> > 0     0000000000000000 00000020032df000 0000000000004000 00001008
> > 1     0000000000004000 00000020032e0000 0000000000004000 00001008
> > 2     0000000000008000 00000020032e1000 0000000000004000 00001008
> > 3     000000000000c000 00000020032e2000 0000000000004000 00001008
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++---------------
> >   1 file changed, 34 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> > index 42dbd60..0d2948e 100644
> > --- a/tools/f2fs_io/f2fs_io.c
> > +++ b/tools/f2fs_io/f2fs_io.c
> > @@ -731,11 +731,11 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
> >   #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
> >   static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
> >   {
> > -     unsigned count, i;
> > -     int fd;
> > -     __u64 phy_addr;
> > -     struct fiemap *fm = xmalloc(sizeof(struct fiemap) +
> > -                     sizeof(struct fiemap_extent));
> > +     unsigned int i;
> > +     int fd, extents_mem_size;
> > +     u64 start, length;
> > +     u32 mapped_extents;
> > +     struct fiemap *fm = xmalloc(sizeof(struct fiemap));
> >
> >       if (argc != 4) {
> >               fputs("Excess arguments\n\n", stderr);
> > @@ -743,26 +743,41 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
> >               exit(1);
> >       }
> >
> > -     fm->fm_start = atoi(argv[1]) * F2FS_BLKSIZE;
> > -     fm->fm_length = F2FS_BLKSIZE;
> > -     fm->fm_extent_count = 1;
> > -     count = atoi(argv[2]);
> > +     memset(fm, 0, sizeof(struct fiemap));
> > +     start = atoi(argv[1]) * F2FS_BLKSIZE;
> > +     length = atoi(argv[2]) * F2FS_BLKSIZE;
> > +     fm->fm_start = start;
> > +     fm->fm_length = length;
> >
> >       fd = xopen(argv[3], O_RDONLY | O_LARGEFILE, 0);
> >
> > -     printf("Fiemap: offset = %08"PRIx64" len = %d\n",
> > -                             (u64)fm->fm_start / F2FS_BLKSIZE, count);
> > -     for (i = 0; i < count; i++) {
> > -             if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> > -                     die_errno("FIEMAP failed");
> > +     printf("Fiemap: offset = %"PRIu64" len = %"PRIu64"\n",
> > +                             start / F2FS_BLKSIZE, length / F2FS_BLKSIZE);
> > +     if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> > +             die_errno("FIEMAP failed");
> > +
> > +     mapped_extents = fm->fm_mapped_extents;
> > +     extents_mem_size = sizeof(struct fiemap_extent) * mapped_extents;
> > +     free(fm);
> > +     fm = xmalloc(sizeof(struct fiemap) + extents_mem_size);
> >
> > -             phy_addr = fm->fm_extents[0].fe_physical / F2FS_BLKSIZE;
> > -             printf("%llu: %llu\n", fm->fm_start / F2FS_BLKSIZE, phy_addr);
> > +     memset(fm, 0, sizeof(struct fiemap));
> > +     memset(fm->fm_extents, 0, extents_mem_size);
>
> Is that equals to memset(fm, 0, sizeof(struct fiemap) + extents_mem_size);?
>

Oh, you're right~

> > +     fm->fm_start = start;
> > +     fm->fm_length = length;
> > +     fm->fm_extent_count = mapped_extents;
> >
> > -             if (fm->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST)
> > -                     break;
> > +     if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> > +             die_errno("FIEMAP failed");
> >
> > -             fm->fm_start += F2FS_BLKSIZE;
> > +     printf("\t%-17s%-17s%-17s%s\n", "logical addr.", "physical addr.", "length", "flags");
> > +     for (i = 0; i < fm->fm_mapped_extents; i++) {
> > +             printf("%d\t%.16llx %.16llx %.16llx %.8x\n", i,
> > +                 fm->fm_extents[i].fe_logical, fm->fm_extents[i].fe_physical,
> > +                 fm->fm_extents[i].fe_length, fm->fm_extents[i].fe_flags);
> > +
> > +             if (fm->fm_extents[i].fe_flags & FIEMAP_EXTENT_LAST)
> > +                     break;
> >       }
> >       printf("\n");
> >       free(fm);
> >
