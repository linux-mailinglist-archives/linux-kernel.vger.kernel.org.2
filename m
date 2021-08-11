Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2AD3E89DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhHKFmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhHKFmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:42:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34616C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:41:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m18so2655090ljo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BduDOX00ysZTdeQxJ1CdKnHUEWn0cfmBkvq3fWTpoAc=;
        b=G7dVsZFKwE2iJ6U3ue9eR8pIZhMeg0S7YHysi8mK3ryCJb0yrCdNhhVfAYGe3sXJZT
         70zuMZUVAiPymn+c5P8gZPvwesT8x+AEg4CwI+IKuWrHyb6LdpEACVONdNfzJf0kR6mo
         ouYHyvduKMc27YvMhRh2WoJ7lfAh4zlX8fdTWNtQrkXCnMtqGLWAX6Y3sGrYSPGq95SS
         iZXxy9ceSZDlFhLJlgjHPyuGaSKgS4IUJfu4qutQRq504xMyf85e1U2wh2LWzkdf7KJZ
         u0OESDypeYFUGl8T0SVoT4qi7rkNBy6O7emxyO2mLs0q8VB0FJj86MMZwy0HBbN7/VlQ
         pu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BduDOX00ysZTdeQxJ1CdKnHUEWn0cfmBkvq3fWTpoAc=;
        b=Ah90AIALnYs/SNzIxBHtb5ZUzMIHluLeS4Dp2deCGWFop7wCk8LxuYIRLbVPL3tYBm
         otpW1u9OyxgO76auZ7Cu7+DKAWANXw+YWBWdZaqzkII0+uyAQ9quZ5La0kwh2Saw+Hma
         2xuJjsTgBa0zPA/uKjSK1PhNKcFeLlWlc2N4yaM/5mhhyrpGoof3tipS1rF+l2DQraPX
         7QMTy825Roq3gMmDEmYII9S4igf5LyjhdCMNRuTaTs/iOsZs4tULbyuYE2ShamKAH6tU
         cgaXifbN87DabgBRxBCS0zPROachhPoX4C6lSI46723HRwlNe1Yudnb7I4KAFJxVsPnm
         9aTQ==
X-Gm-Message-State: AOAM531EbQdt4gY6d3pvyBUktK5zw0Ts643km/CTTDcb9c+lAL72JHO5
        G+wV/Gdq/AX0fPDJldH4V7WJsUoyQ7fgPwuBx8c=
X-Google-Smtp-Source: ABdhPJxTzHd9zktg2dIbU4FDdRTxprP12MXY+HOuEJIWoM+dR78/1m7+QIn92XpltdNzSlztCnzT16zTU4jmQaDiCV8=
X-Received: by 2002:a2e:92c8:: with SMTP id k8mr21908929ljh.136.1628660505451;
 Tue, 10 Aug 2021 22:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210809185449.2565768-1-daeho43@gmail.com> <425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org>
In-Reply-To: <425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 10 Aug 2021 22:41:34 -0700
Message-ID: <CACOAw_xTh_HZizaVzDNjnVswu_OQwOjzEWRNxouGtM9E5qj6Pg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce blk_alloc_mode mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 6:58 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/8/10 2:54, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a mount option to control block allocation mode for filesystem
> > developer to simulate filesystem fragmentation and after-GC situation
> > for experimental reasons to understand the filesystem behaviors well
>
> At a glance, I think this functionality can be used to initialize filesystem
> status as fragmented one, which is commonly used in the first step of aging
> test, in order to make filesystem fragmented, aging program needs to fill
> file or block sequentially and remove them at fixed interval, that takes a
> lot of time. IMO, it will be great to support this by filesystem naturally
> to save time of aging filessytem, rather just for experimental reasons to
> understand filesystem behavior.
>

Yes, that's what I meant~ :)

> Maybe we can add a new mode for filesystem allocation mode except adaptive
> and lfs mode, maybe "fragment" mode... :P
>

Sounds good~ Could you suggest the names for both blk_random and seg_random.
We need seg_random mode,too, in order to simulate after-GC condition.

> > under the severe condition. This supports "normal", "seg_random" and
> > "blk_random:<num>" options.
> >
> > "normal" (default): f2fs allocates blocks in the normal way.
> > "seg_random": f2fs allocates a new segment in ramdom position.
> >                With this, we can simulate the after-GC condition.
> > "blk_random:<num>": We can make f2fs allocate only 1..<num> blocks
> >                      in a row and forcibly change the segment randomly.
> >                      With this, the newly allocated blocks will be scatter
> >                      throughout the whole partition and we can simulate
> >                      filesystem fragmentation condition.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >
> > ---
> > v2: changed the <num> initialization way.
> > ---
> >   Documentation/filesystems/f2fs.rst | 16 ++++++++++
> >   fs/f2fs/f2fs.h                     | 20 +++++++++++++
> >   fs/f2fs/gc.c                       |  5 +++-
> >   fs/f2fs/segment.c                  | 12 ++++++++
> >   fs/f2fs/super.c                    | 47 ++++++++++++++++++++++++++++++
> >   5 files changed, 99 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> > index ff9e7cc97c65..a0ca963fda20 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -312,6 +312,22 @@ inlinecrypt               When possible, encrypt/decrypt the contents of encrypted
> >                        Documentation/block/inline-encryption.rst.
> >   atgc                         Enable age-threshold garbage collection, it provides high
> >                        effectiveness and efficiency on background GC.
> > +blk_alloc_mode=%s     Control block allocation mode. This is a developer option
> > +                      for experiments to simulate filesystem fragmentation and
> > +                      after-GC situation. The developers use this mode to understand
> > +                      filesystem fragmentation and after-GC condition well, and
> > +                      eventually get the insight to handle them better.
> > +                      This supports "normal", "seg_random" and "blk_random:<num>" modes.
> > +                      In "normal" mode (default), f2fs allocates blocks in the normal way.
> > +                      In "seg_random", f2fs allocates a new segment in ramdom position.
> > +                      With this, we can simulate the after-GC condition.
> > +                      In "blk_random:<num>", we can make f2fs allocate only 1..<num>
> > +                      blocks in a row and forcibly change the segment randomly.
> > +                      You can set the <num> within 1 .. 512 number.
> > +                      With this, the newly allocated blocks will be scatter throughout
> > +                      the whole partition and we can simulate filesystem fragmentation
> > +                      condition. Please, use this option for your experiments and we
> > +                      strongly recommand a filesystem format after using this option.
> >   ======================== ============================================================
> >
> >   Debugfs Entries
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index fccee18ab776..aed09e8c0fce 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -155,6 +155,9 @@ struct f2fs_mount_info {
> >       int compress_mode;                      /* compression mode */
> >       unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
> >       unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
> > +
> > +     int blk_alloc_mode;             /* block allocation mode */
> > +     int blk_alloc_random_max;       /* the maximum chunk size for block random allocation mode */
> >   };
> >
> >   #define F2FS_FEATURE_ENCRYPT                0x0001
> > @@ -1740,6 +1743,8 @@ struct f2fs_sb_info {
> >
> >       unsigned long seq_file_ra_mul;          /* multiplier for ra_pages of seq. files in fadvise */
> >
> > +     int blk_alloc_remained;                 /* remained block count for this block allocation period */
> > +
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> >       struct kmem_cache *page_array_slab;     /* page array entry */
> >       unsigned int page_array_slab_size;      /* default page array slab size */
> > @@ -3619,6 +3624,21 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> >   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> >                       unsigned int segno);
> >
> > +#define MIN_BLK_ALLOC_RANDOM 1
> > +#define MAX_BLK_ALLOC_RANDOM 512
> > +
> > +enum {
> > +     BLK_ALLOC_MODE_NORMAL,          /* normal block allocation mode */
> > +     BLK_ALLOC_MODE_SEG_RANDOM,      /* make segment allocation random */
> > +     BLK_ALLOC_MODE_BLK_RANDOM,      /* make block allocation random */
> > +};
> > +
> > +static inline bool f2fs_need_seg_random(struct f2fs_sb_info *sbi)
> > +{
> > +     return F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_SEG_RANDOM ||
> > +             F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_BLK_RANDOM;
> > +}
> > +
> >   /*
> >    * checkpoint.c
> >    */
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 9dce44619069..571b50322e6e 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/freezer.h>
> >   #include <linux/sched/signal.h>
> > +#include <linux/random.h>
> >
> >   #include "f2fs.h"
> >   #include "node.h"
> > @@ -256,7 +257,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
> >               p->max_search = sbi->max_victim_search;
> >
> >       /* let's select beginning hot/small space first in no_heap mode*/
> > -     if (test_opt(sbi, NOHEAP) &&
> > +     if (f2fs_need_seg_random(sbi))
> > +             p->offset = prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
> > +     else if (test_opt(sbi, NOHEAP) &&
> >               (type == CURSEG_HOT_DATA || IS_NODESEG(type)))
> >               p->offset = 0;
> >       else
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index f9b7fb785e1d..6dff2d36ad6b 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/timer.h>
> >   #include <linux/freezer.h>
> >   #include <linux/sched/signal.h>
> > +#include <linux/random.h>
> >
> >   #include "f2fs.h"
> >   #include "segment.h"
> > @@ -2587,6 +2588,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
> >       unsigned short seg_type = curseg->seg_type;
> >
> >       sanity_check_seg_type(sbi, seg_type);
> > +     if (f2fs_need_seg_random(sbi))
> > +             return prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
> >
> >       /* if segs_per_sec is large than 1, we need to keep original policy. */
> >       if (__is_large_section(sbi))
> > @@ -3150,6 +3153,15 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
> >   static bool __has_curseg_space(struct f2fs_sb_info *sbi,
> >                                       struct curseg_info *curseg)
> >   {
> > +     /* To allocate block chunks in different sizes, use random number */
> > +     if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_BLK_RANDOM) {
> > +             if (--sbi->blk_alloc_remained < 0) {
> > +                     sbi->blk_alloc_remained = prandom_u32() %
> > +                             F2FS_OPTION(sbi).blk_alloc_random_max;
> > +                     return false;
> > +             }
> > +     }
>
> Why not adjusting __refresh_next_blkoff(), so we can control granularity of
> allocation interval, e.g.
>
>         if (seg->alloc_type == SSR)
>                 seg->next_blkoff =
>                         __next_free_blkoff(sbi, seg->segno,
>                                                 seg->next_blkoff + 1);
>         else if (seg->alloc_type == LFS)
>                 seg->next_blkoff++;
>         else
>                 seg->next_blkoff += sbi->fragment_granularity;
>
> Thanks,
>

I am not sure this is safe, is this?
Plus, I wanted to allocate the blocks in a chunk sized between
<1..num>. This is a little bit different from what I meant.


> > +
> >       return curseg->next_blkoff < f2fs_usable_blks_in_seg(sbi,
> >                                                       curseg->segno);
> >   }
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 9ead6d2e703b..ef14f3e8b29a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -155,6 +155,7 @@ enum {
> >       Opt_atgc,
> >       Opt_gc_merge,
> >       Opt_nogc_merge,
> > +     Opt_blk_alloc_mode,
> >       Opt_err,
> >   };
> >
> > @@ -231,6 +232,7 @@ static match_table_t f2fs_tokens = {
> >       {Opt_atgc, "atgc"},
> >       {Opt_gc_merge, "gc_merge"},
> >       {Opt_nogc_merge, "nogc_merge"},
> > +     {Opt_blk_alloc_mode, "blk_alloc_mode=%s"},
> >       {Opt_err, NULL},
> >   };
> >
> > @@ -1173,6 +1175,40 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> >               case Opt_nogc_merge:
> >                       clear_opt(sbi, GC_MERGE);
> >                       break;
> > +             case Opt_blk_alloc_mode:
> > +                     name = match_strdup(&args[0]);
> > +                     if (!name)
> > +                             return -ENOMEM;
> > +                     if (!strcmp(name, "normal")) {
> > +                             F2FS_OPTION(sbi).blk_alloc_mode =
> > +                                     BLK_ALLOC_MODE_NORMAL;
> > +                     } else if (!strcmp(name, "seg_random")) {
> > +                             F2FS_OPTION(sbi).blk_alloc_mode =
> > +                                     BLK_ALLOC_MODE_SEG_RANDOM;
> > +                     } else if (!strncmp(name, "blk_random:", 11)) {
> > +                             const char *num = name + 11;
> > +                             long size;
> > +
> > +                             ret = kstrtol(num, 10, &size);
> > +                             if (ret) {
> > +                                     kfree(name);
> > +                                     return ret;
> > +                             }
> > +                             if (size < MIN_BLK_ALLOC_RANDOM)
> > +                                     size = MIN_BLK_ALLOC_RANDOM;
> > +                             else if (size > MAX_BLK_ALLOC_RANDOM)
> > +                                     size = MAX_BLK_ALLOC_RANDOM;
> > +
> > +                             F2FS_OPTION(sbi).blk_alloc_mode =
> > +                                     BLK_ALLOC_MODE_BLK_RANDOM;
> > +                             F2FS_OPTION(sbi).blk_alloc_random_max = size;
> > +                             sbi->blk_alloc_remained = size;
> > +                     } else {
> > +                             kfree(name);
> > +                             return -EINVAL;
> > +                     }
> > +                     kfree(name);
> > +                     break;
> >               default:
> >                       f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
> >                                p);
> > @@ -1919,6 +1955,14 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> >       else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
> >               seq_printf(seq, ",fsync_mode=%s", "nobarrier");
> >
> > +     if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_NORMAL)
> > +             seq_printf(seq, ",blk_alloc_mode=%s", "normal");
> > +     else if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_SEG_RANDOM)
> > +             seq_printf(seq, ",blk_alloc_mode=%s", "seg_random");
> > +     else if (F2FS_OPTION(sbi).blk_alloc_mode == BLK_ALLOC_MODE_BLK_RANDOM)
> > +             seq_printf(seq, ",blk_alloc_mode=%s:%d", "blk_random",
> > +                             F2FS_OPTION(sbi).blk_alloc_random_max);
> > +
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> >       f2fs_show_compress_options(seq, sbi->sb);
> >   #endif
> > @@ -1947,6 +1991,9 @@ static void default_options(struct f2fs_sb_info *sbi)
> >       F2FS_OPTION(sbi).compress_ext_cnt = 0;
> >       F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
> >       F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
> > +     F2FS_OPTION(sbi).blk_alloc_mode = BLK_ALLOC_MODE_NORMAL;
> > +     F2FS_OPTION(sbi).blk_alloc_random_max = MAX_BLK_ALLOC_RANDOM;
> > +     sbi->blk_alloc_remained = MAX_BLK_ALLOC_RANDOM;
> >
> >       sbi->sb->s_flags &= ~SB_INLINECRYPT;
> >
> >
