Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705D93D7B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhG0Ql6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhG0Ql5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:41:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35093C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:41:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u20so16413414ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ON7q0cRtYLSty813NUaupFpkMI6FU3tfgheJEaRd1H0=;
        b=Styo7U3xQ60+p2Gllfc090JptnVjEBjJrK6SZ52HzDUNCAWs3BPwrMLKE2EKOdN4U3
         3hsunmhBHs+Ah6vcnpDQMGHMbJQs/MktQ3WF4XJpQKZUIbFTPC3aEpOFam0imZFIVR09
         Hu93rR+VMcbDGYQLJwMUL4o9O6AlfN8wTsQkHQtul7RqZJMP4yJ5mZYwFsiMxxY4lAMj
         DSieXvRefwByRsoDF/zOQysqhhCWdNCr0iRZtx4T9dcR9VJ2awpoIVmDNUh13aE1+Azg
         DmHnOORoqUWQpMHHTzKW8Qq6ugXhydIb/yLui6ti8AmcrYZjsxMEQuHrcAexb8jailrR
         sTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ON7q0cRtYLSty813NUaupFpkMI6FU3tfgheJEaRd1H0=;
        b=oH7VMzNWld37pF9XKmjEJAlB0ikq0iKN9pb4jY3QtT95iIWHWlE5VoqmX5jG1hjP/u
         cq7dRcQBF3Xlo5ri9/mHGrFL+K4YriS7kXPAxprPnFixvoc3dODky2ZbdcLdbTOnqIID
         TeUWGSviIvvus5j3409yF9yMlqX7O+0PPqvnslcYQphqsPmFaj5MrDYuuml+7P0X+vqR
         xCvarcJC7ptmJGfey6ODcubWDHSnZH4SEXavIVl4JBMkgwFYwRTDGMT72bdaa/lJwutt
         pgwfiW9pdLb+zHP84aUwkHVzrVYaaLZeqlRI8hYBsg0+hHBGNoCMe43t2nby9HZNk/T8
         BJ3Q==
X-Gm-Message-State: AOAM5329QboE6mEvKeHg7WVrP6IsYuQDSlHgYaMHNZbkCyE5rw6R6DIQ
        iMEvhzj4c5AHgvkmmgOebg91fw2ZDdeDmY/Qz1U=
X-Google-Smtp-Source: ABdhPJziUdehrE8hWu7Q1ESI+Jw3ICyKRDSHjeBjsNTlQxW31dikbvpkcSQXzZmH+xOJoHoHX2to6l+TIyTiheT/Y7I=
X-Received: by 2002:a05:651c:1549:: with SMTP id y9mr15779622ljp.335.1627404114569;
 Tue, 27 Jul 2021 09:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210726041819.2059593-1-daeho43@gmail.com> <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
In-Reply-To: <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 27 Jul 2021 09:41:43 -0700
Message-ID: <CACOAw_zvFcV-5ePrFOr-bo2DxXyFzjDTSo-7aPcXG6jtNweEbA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about adding this?

skip_fill:

        if (map.m_pblk == COMPRESS_ADDR) {

                if (start_blk & (cluster_size - 1)) {

                        ret = -EFSCORRUPTED;

                        goto out;

                }

                compr_cluster = true;

                count_in_cluster = 1;

        } else if (compr_appended) {

On Tue, Jul 27, 2021 at 3:19 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/7/26 12:18, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > When we print out a discontinuous compression chunk, it shows like a
> > continuous chunk now. To show it more correctly, I've changed the way of
> > printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> > info, since it is not in fiemap user api manual.
> >
> > Let's assume 16KB compression cluster.
> >
> > <before>
> >     Logical          Physical         Length           Flags
> > 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> > 1:  0000000000004000 00000002c0920000 0000000000004000 1008
> >    ...
> > 9:  0000000000034000 0000000f8c623000 0000000000004000 1008
> > 10: 0000000000038000 000000101a6eb000 0000000000004000 1008
> >
> > <after>
> > 0:  0000000000000000 00000002c091f000 0000000000004000 1008
> > 1:  0000000000004000 00000002c0920000 0000000000004000 1008
> >    ...
> > 9:  0000000000034000 0000000f8c623000 0000000000001000 1008
> > 10: 0000000000035000 000000101a6ea000 0000000000003000 1008
> > 11: 0000000000038000 000000101a6eb000 0000000000002000 1008
> > 12: 000000000003a000 00000002c3544000 0000000000002000 1008
> >
> > Flags
> > 0x1000 => FIEMAP_EXTENT_MERGED
> > 0x0008 => FIEMAP_EXTENT_ENCODED
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Tested-by: Eric Biggers <ebiggers@google.com>
> >
> > ---
> > v4: initialized count_in_cluster
> > v3: fix the missing last extent flag issue
> > v2: changed the print format
> > ---
> >   fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++----------------------
> >   1 file changed, 42 insertions(+), 33 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 3a01a1b50104..1a716c3b5457 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1843,8 +1843,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >       u64 logical = 0, phys = 0, size = 0;
> >       u32 flags = 0;
> >       int ret = 0;
> > -     bool compr_cluster = false;
> > +     bool compr_cluster = false, compr_appended;
> >       unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
> > +     unsigned int count_in_cluster = 0;
> >       loff_t maxbytes;
> >
> >       if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> > @@ -1892,15 +1893,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >       map.m_next_pgofs = &next_pgofs;
> >       map.m_seg_type = NO_CHECK_TYPE;
> >
> > -     if (compr_cluster)
> > -             map.m_len = cluster_size - 1;
> > +     if (compr_cluster) {
> > +             map.m_lblk += 1;
> > +             map.m_len = cluster_size - count_in_cluster;
> > +     }
> >
> >       ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
> >       if (ret)
> >               goto out;
> >
> >       /* HOLE */
> > -     if (!(map.m_flags & F2FS_MAP_FLAGS)) {
> > +     if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
> >               start_blk = next_pgofs;
> >
> >               if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
> > @@ -1910,6 +1913,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >               flags |= FIEMAP_EXTENT_LAST;
> >       }
> >
> > +     compr_appended = false;
> > +     /* In a case of compressed cluster, append this to the last extent */
> > +     if (compr_cluster && ((map.m_flags & F2FS_MAP_UNWRITTEN) ||
> > +                     !(map.m_flags & F2FS_MAP_FLAGS))) {
> > +             compr_appended = true;
> > +             goto skip_fill;
> > +     }
> > +
> >       if (size) {
> >               flags |= FIEMAP_EXTENT_MERGED;
> >               if (IS_ENCRYPTED(inode))
> > @@ -1926,38 +1937,36 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >       if (start_blk > last_blk)
> >               goto out;
> >
> > -     if (compr_cluster) {
> > -             compr_cluster = false;
> > -
> > -
> > -             logical = blks_to_bytes(inode, start_blk - 1);
> > -             phys = blks_to_bytes(inode, map.m_pblk);
> > -             size = blks_to_bytes(inode, cluster_size);
> > -
> > -             flags |= FIEMAP_EXTENT_ENCODED;
> > -
> > -             start_blk += cluster_size - 1;
> > -
> > -             if (start_blk > last_blk)
> > -                     goto out;
> > -
> > -             goto prep_next;
> > -     }
> > -
> > +skip_fill:
> >       if (map.m_pblk == COMPRESS_ADDR) {
>
> Looks good, but one more thing I concern is how about detecting and
> returning -EFSCORRUPTED for below corrupted metadata cases:
> - [COMPRESS_ADDR, blkaddr, COMPRESS_ADDR, NEW_ADDR]
> - [blkaddr, COMPRESS_ADDR, NULL_ADDR, NULL_ADDR]
>
> Thanks,
>
> >               compr_cluster = true;
> > -             start_blk++;
> > -             goto prep_next;
> > -     }
> > -
> > -     logical = blks_to_bytes(inode, start_blk);
> > -     phys = blks_to_bytes(inode, map.m_pblk);
> > -     size = blks_to_bytes(inode, map.m_len);
> > -     flags = 0;
> > -     if (map.m_flags & F2FS_MAP_UNWRITTEN)
> > -             flags = FIEMAP_EXTENT_UNWRITTEN;
> > +             count_in_cluster = 1;
> > +     } else if (compr_appended) {
> > +             unsigned int appended_blks = cluster_size -
> > +                                             count_in_cluster + 1;
> > +             size += blks_to_bytes(inode, appended_blks);
> > +             start_blk += appended_blks;
> > +             compr_cluster = false;
> > +     } else {
> > +             logical = blks_to_bytes(inode, start_blk);
> > +             phys = __is_valid_data_blkaddr(map.m_pblk) ?
> > +                     blks_to_bytes(inode, map.m_pblk) : 0;
> > +             size = blks_to_bytes(inode, map.m_len);
> > +             flags = 0;
> > +
> > +             if (compr_cluster) {
> > +                     flags = FIEMAP_EXTENT_ENCODED;
> > +                     count_in_cluster += map.m_len;
> > +                     if (count_in_cluster == cluster_size) {
> > +                             compr_cluster = false;
> > +                             size += blks_to_bytes(inode, 1);
> > +                     }
> > +             } else if (map.m_flags & F2FS_MAP_UNWRITTEN) {
> > +                     flags = FIEMAP_EXTENT_UNWRITTEN;
> > +             }
> >
> > -     start_blk += bytes_to_blks(inode, size);
> > +             start_blk += bytes_to_blks(inode, size);
> > +     }
> >
> >   prep_next:
> >       cond_resched();
> >
