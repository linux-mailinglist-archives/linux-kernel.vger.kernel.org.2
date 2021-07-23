Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9F3D3109
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhGWAIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhGWAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:08:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:49:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u14so9669323ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2WR76y4EE4IKn9g23ZCfDxjyNDy+13+LWLZTGdDMJQ=;
        b=CKIz8q0ZCZM0Q8O4lVDY1q+MHMPl96BgWOOtBaXt6rd56XVfVUDwC5LAmZ9Wum4B+w
         dhjLNF4NLVixabI/TSL0Xd7AIq5J8AwmNA6ftJy8XWqAjvFUicSQaCKCT05daJ9adAH5
         W1xIViHPUN/EYS3dzN11eLA8C6j+yjsReL5/W6yw7sh6Peb6SeValxVNMYzlXDoTEjSZ
         tcgQgJdAJHxvCybAHva3wEkWN1N1wGlAkgfQANzuv8oHruHMXTbChHFAgRpoG50dIv3z
         Uc+nY4J9WD4Y6bmPoNv8N5LY9iV/VWtAbcjd8WRvEKjUX4hgN2whnmgVPhjFeNuG8Z5v
         blnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2WR76y4EE4IKn9g23ZCfDxjyNDy+13+LWLZTGdDMJQ=;
        b=KgDGd829SpwIRDumPvRRpVZPLRItyv7NYsZ3QjkG6KGNp7mc3sh214K86GlQ3JiVnH
         Yu6d3nWXjVkLMoc8RcALYbk1l9MnCMTZg4YjHvstWLTnRpdX9YQKTELIOzAdopc3J9Jf
         slVhvmRwbot0JnL68rUT6/O1xwO2P+Xfo68kXJeSfnTl615WK3dex3WGEk7eBMyyWPiR
         n2A+xOQYLtcVGdgKljjsNhxFmfnEdj+Sy46/gOr+RzRMKjUrJT72It10AHyaJqdOziuM
         rfyr6yTYrVTVt2Zpl0QgWzVRicJdY98U87H+V8X9UFB+3EjLVLgbUMwzRX6b6wsEk60O
         cO3A==
X-Gm-Message-State: AOAM533wHAuJN6u+6rn4S234ji5RpSiPvWmRc1AGqD3ZJ7QcUofQ2v0H
        oKyqPzAX2U46XQljqsiZihloLr4oC5+RgwAEiec=
X-Google-Smtp-Source: ABdhPJyG5UUGNMqrzydpuJDEOwYAMik2fLtY+SeyvJRqGx5SNtI/Rgw5aYPQB/8OJgngoOhzRThkJ5viWsSOjMYshX8=
X-Received: by 2002:a05:651c:1549:: with SMTP id y9mr1690336ljp.335.1627001364043;
 Thu, 22 Jul 2021 17:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210722211921.3791312-1-daeho43@gmail.com> <dc7776c7-2694-5eea-fe9a-12191c833389@kernel.org>
In-Reply-To: <dc7776c7-2694-5eea-fe9a-12191c833389@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 22 Jul 2021 17:49:12 -0700
Message-ID: <CACOAw_wznnE_pMh_9aVYJdyF-JUn46AZ28hh_GSWcxSJYWsjkw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change fiemap way in printing
 compression chunk
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 5:20 PM Chao Yu <chao@kernel.org> wrote:
>
> Hi Daeho,
>
> On 2021/7/23 5:19, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > When we print out a discontinuous compression chunk, it shows like a
> > continuous chunk now. To show it more correctly, I've changed the way of
> > printing fiemap info like below. Plus, eliminated NEW_ADDR(-1) in fiemap
> > info, since it is not in fiemap user api manual.
> >
> >     Logical          Physical         Length           Flags
> > 0: 0000000000000000 0000000fdf692000 0000000000004000 1008
> > 1: 0000000000004000 0000000fdf693000 0000000000004000 1008
> > 2: 0000000000008000 0000000fdf694000 0000000000004000 1008
> > 3: 000000000000c000 0000000fdf695000 0000000000004000 1008
> > 4: 0000000000010000 0000000fdf696000 000000000000c000 1000
> > 5: 000000000001c000 0000000f8c60d000 0000000000010000 1000
> > 6: 000000000002c000 0000000f8c61d000 0000000000004000 1008
> > 7: 0000000000030000 0000000f8c620000 0000000000004000 1008
> > 8: 0000000000034000 0000000f8c623000 0000000000001000 1008
> > 9: 0000000000035000 0000000fc7af4000 0000000000003000 1008
>
> I wrote a file some like this:
>
> i_addr[0x9] cluster flag                [0xfffffffe : 4294967294]
> i_addr[0xa]                             [0x   72800 : 468992]
> i_addr[0xb] reserved flag               [0xffffffff : 4294967295]
> i_addr[0xc] reserved flag               [0xffffffff : 4294967295]
> i_addr[0xd] cluster flag                [0xfffffffe : 4294967294]
> i_addr[0xe]                             [0x   72801 : 468993]
> i_addr[0xf] reserved flag               [0xffffffff : 4294967295]
> i_addr[0x10] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x11]                            [0x   72832 : 469042]
> i_addr[0x12]                            [0x   72802 : 468994]
> i_addr[0x13]                            [0x   72833 : 469043]
> i_addr[0x14]                            [0x   72834 : 469044]
> i_addr[0x15] cluster flag               [0xfffffffe : 4294967294]
> i_addr[0x16]                            [0x   72803 : 468995]
> i_addr[0x17] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x18] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x19]                            [0x   72835 : 469045]
> i_addr[0x1a]                            [0x   72804 : 468996]
> i_addr[0x1b]                            [0x   72836 : 469046]
> i_addr[0x1c]                            [0x   72837 : 469047]
> i_addr[0x1d] cluster flag               [0xfffffffe : 4294967294]
> i_addr[0x1e]                            [0x   72805 : 468997]
> i_addr[0x1f] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x20] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x21] cluster flag               [0xfffffffe : 4294967294]
> i_addr[0x22]                            [0x   72806 : 468998]
> i_addr[0x23] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x24] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x25] cluster flag               [0xfffffffe : 4294967294]
> i_addr[0x26]                            [0x   72807 : 468999]
> i_addr[0x27] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x28] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x29] cluster flag               [0xfffffffe : 4294967294]
> i_addr[0x2a]                            [0x   72808 : 469000]
> i_addr[0x2b] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x2c] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x2d] cluster flag               [0xfffffffe : 4294967294]
> i_addr[0x2e]                            [0x   72809 : 469001]
> i_addr[0x2f] reserved flag              [0xffffffff : 4294967295]
> i_addr[0x30] reserved flag              [0xffffffff : 4294967295]
> i_nid[0]                                [0x       0 : 0]
> i_nid[1]                                [0x       0 : 0]
> i_nid[2]                                [0x       0 : 0]
> i_nid[3]                                [0x       0 : 0]
> i_nid[4]                                [0x       0 : 0]
>
> xfs_io file -c "fiemap -v" shows:
>
> before:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..31]:         3751936..3751967    32 0x1008
>     1: [32..63]:        3751944..3751975    32 0x1008
>     2: [64..71]:        3752336..3752343     8 0x1000
>     3: [72..79]:        3751952..3751959     8 0x1000
>     4: [80..95]:        3752344..3752359    16 0x1000
>     5: [96..127]:       3751960..3751991    32 0x1008
>     6: [128..135]:      3752360..3752367     8 0x1000
>     7: [136..143]:      3751968..3751975     8 0x1000
>     8: [144..159]:      3752368..3752383    16 0x1000
>     9: [160..191]:      3751976..3752007    32 0x1008
>    10: [192..223]:      3751984..3752015    32 0x1008
>    11: [224..255]:      3751992..3752023    32 0x1008
>    12: [256..287]:      3752000..3752031    32 0x1008
>    13: [288..319]:      3752008..3752039    32 0x1009
>
> after:
>     0: [0..31]:         3751936..3751967    32 0x1008
>     1: [32..63]:        3751944..3751975    32 0x1008
>     2: [64..71]:        3752336..3752343     8 0x1000
>     3: [72..79]:        3751952..3751959     8 0x1000
>     4: [80..95]:        3752344..3752359    16 0x1000
>     5: [96..127]:       3751960..3751991    32 0x1008
>     6: [128..135]:      3752360..3752367     8 0x1000
>     7: [136..143]:      3751968..3751975     8 0x1000
>     8: [144..159]:      3752368..3752383    16 0x1000
>     9: [160..191]:      3751976..3752007    32 0x1008
>    10: [192..223]:      3751984..3752015    32 0x1008
>    11: [224..255]:      3751992..3752023    32 0x1008
>    12: [256..287]:      3752000..3752031    32 0x1008
>    13: [288..319]:      3752008..3752039    32 0x1008
>
> I don't see any obvious difference, except w/ current patch, last
> FIEMAP_EXTENT_LAST is missing.
>
> Sorry, I didn't get the point of this patch, could you please explain
> more details for that problem this patch tries to fix and show the
> difference before/after the patch in commit message?
>
> Thanks,
>
> >
> > Flags
> > 0x1000 => FIEMAP_EXTENT_MERGED
> > 0x0008 => FIEMAP_EXTENT_ENCODED
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >
> > ---
> > v2: changed the print format
> > ---
> >   fs/f2fs/data.c | 76 ++++++++++++++++++++++++++++----------------------
> >   1 file changed, 42 insertions(+), 34 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 3a01a1b50104..058dc751e3a6 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1843,8 +1843,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >       u64 logical = 0, phys = 0, size = 0;
> >       u32 flags = 0;
> >       int ret = 0;
> > -     bool compr_cluster = false;
> > +     bool compr_cluster = false, compr_appended;
> >       unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
> > +     unsigned int count_in_cluster;
> >       loff_t maxbytes;
> >
> >       if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> > @@ -1892,8 +1893,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
> > @@ -1903,11 +1906,23 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >       if (!(map.m_flags & F2FS_MAP_FLAGS)) {
> >               start_blk = next_pgofs;
> >
> > -             if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
> > +             if (blks_to_bytes(inode, start_blk) >= blks_to_bytes(inode,
> >                                               max_inode_blocks(inode)))
> > +                     flags |= FIEMAP_EXTENT_LAST;
> > +             else if (!compr_cluster)
> >                       goto prep_next;
> > +     }
> > +
> > +     compr_appended = false;
> > +     /* In a case of compressed cluster, append this to the last extent */
> > +     if (compr_cluster && ((map.m_flags & F2FS_MAP_UNWRITTEN) ||
> > +                     !(map.m_flags & F2FS_MAP_FLAGS))) {
> > +             unsigned int appended_blks = cluster_size - count_in_cluster + 1;
> >
> > -             flags |= FIEMAP_EXTENT_LAST;
> > +             size += blks_to_bytes(inode, appended_blks);
> > +             if (map.m_flags & F2FS_MAP_UNWRITTEN)
> > +                     start_blk += appended_blks;
> > +             compr_appended = true;
> >       }
> >
> >       if (size) {
> > @@ -1926,38 +1941,31 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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
> >       if (map.m_pblk == COMPRESS_ADDR) {
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

Oh, I am sorry for too concrete exlpanation.
I am trying to fix this issue. Let's assume 4 block cluster, which has
been compressed with 3 blocks whose address is 0x1000, 0x5000 and
0x9000.
This cluster is discontinous cluster. In this condition, the previous
version just returns one extent starting from 0x1000 and we are
missing the information related to 0x5000 and 0x9000.
The current version will return 3 extents like below.
Logical Physical Len
0x0      0x1000.  0x1000
0x1.     0x5000.  0x1000
0x2.     0x9000.  0x2000

Thank you for letting me know a bug. I will fix it.
