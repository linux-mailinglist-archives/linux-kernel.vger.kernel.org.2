Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4D338C79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCLMOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhCLMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:14:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A1EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:14:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 16so6456027ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ewSlK4AgqVl/lUrMNefRbqPk79L5niUgLahfB8nAxVE=;
        b=PiDtlbg12X1HlmDllTVNxUC1GyNYCq0fMvIk8SGu+a2X0sjSofktaS102JQlVN3DVY
         YspJX6FTYzIygfzNiR4LwJykRVHaPhp2idHGakn5Y3NnG8UG+V4PfR+W6MXyVE44Q/Td
         8FmI2fqlZG+RKnwZ8X8GsSIp1U9pQBQQk4gnwtpcHtiz+z7UuPZBSnlDEmo9jJJt4zbO
         S17ljKUMmJiqBs3ooxaEY0EaZCu7nwFmHoZnn9xmmUIUwRshA+INfjBHe9+ThvmzBWDg
         zNj6F0J+9V/Ditk4NMDcx/Vt6Hy2cGchtz/V/0ahPtrRMDMgsAO35sT4EIp068KyEww8
         bNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ewSlK4AgqVl/lUrMNefRbqPk79L5niUgLahfB8nAxVE=;
        b=SU/bvyh26oCOoo5+Kewkv4pD0lMwpG1VRmfM9Pv4WjwfPynMVY9xIQvJ/2U6aWwTsM
         9Z56ySN/G/HoCot0tds0eSYO4Fkibf8muueY0wg1svCoFZ6qZ5TesT0/zhI2z09pW+M+
         PZk/Svvonic1s0jOuajlydPYsacT6mIpM+U/rthI40yB2Wc7VwXiB8i67+9Hko2YOoXH
         9IFWAECQQxcgbJKddC+YRr+PETckARNbyWacGarm2whw0Gpn+Hq+I+B9p0WDQq0iM0cy
         NNT8PyywXKM4v1ZXgKpTT8Y5GH6BweoknlHxWFXn4YfHL2CY0EPM1FH04eBi48DqAOf2
         0nUQ==
X-Gm-Message-State: AOAM531jtOQjtAREHodUdpyef5AeHDjyc5EDBuOkz+KQYNOAIiuNzbkQ
        2nuSNk65AR+Jr5O841GTOu6ozmdnboExon5p0js=
X-Google-Smtp-Source: ABdhPJwZDivQLHoHJ+XY3rjVuvqqdN5PA8dxiwuYnosyX61KTT5s2NgIb4fb02qlY0JULl6W6NP0EjpElTFGDe7z6dk=
X-Received: by 2002:a2e:9cce:: with SMTP id g14mr2176924ljj.136.1615551263419;
 Fri, 12 Mar 2021 04:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20210311023233.1034946-1-daeho43@gmail.com> <5000daf0-e204-4f49-f2e9-30489db46d1a@huawei.com>
In-Reply-To: <5000daf0-e204-4f49-f2e9-30489db46d1a@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 12 Mar 2021 21:14:12 +0900
Message-ID: <CACOAw_y1X7ExYSSr9CxaWBwyOZsO4sqyN=FWVZi7bp=0nwqFEg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add sysfs nodes to get runtime
 compression stat
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to use these just accumulating numbers and periodically
gather and reset them.
Yes, I will add the description like you suggested.

Thanks,

2021=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:50, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/3/11 10:32, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > I've added new sysfs nodes to show runtime compression stat since mount=
.
> > compr_written_block - show the block count written after compression
> > compr_saved_block - show the saved block count with compression
> > compr_new_inode - show the count of inode newly enabled for compression
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: thanks to kernel test robot <lkp@intel.com>, fixed compile issue
> >      related to kernel config.
> > v3: changed sysfs nodes' names and made them runtime stat, not
> >      persistent on disk
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 20 +++++++++
> >   fs/f2fs/compress.c                      |  1 +
> >   fs/f2fs/f2fs.h                          | 19 ++++++++
> >   fs/f2fs/super.c                         |  7 +++
> >   fs/f2fs/sysfs.c                         | 58 ++++++++++++++++++++++++=
+
> >   5 files changed, 105 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index cbeac1bebe2f..f2981eb319cb 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -409,3 +409,23 @@ Description:     Give a way to change checkpoint m=
erge daemon's io priority.
> >               I/O priority "3". We can select the class between "rt" an=
d "be",
> >               and set the I/O priority within valid range of it. "," de=
limiter
> >               is necessary in between I/O class and priority number.
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_written_block
> > +Date:                March 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show the block count written after compression since moun=
t.
> > +             If you write "0" here, you can initialize compr_written_b=
lock and
> > +             compr_saved_block to "0".
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_saved_block
> > +Date:                March 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show the saved block count with compression since mount.
> > +             If you write "0" here, you can initialize compr_written_b=
lock and
> > +             compr_saved_block to "0".
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_new_inode
> > +Date:                March 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show the count of inode newly enabled for compression sin=
ce mount.
> > +             If you write "0" here, you can initialize compr_new_inode=
 to "0".
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 77fa342de38f..3c9d797dbdd6 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1353,6 +1353,7 @@ static int f2fs_write_compressed_pages(struct com=
press_ctx *cc,
> >       if (fio.compr_blocks)
> >               f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, f=
alse);
> >       f2fs_i_compr_blocks_update(inode, cc->nr_cpages, true);
> > +     add_compr_block_stat(inode, cc->nr_cpages);
>
> If compressed cluster was overwritten as normal cluster, compr_saved_bloc=
k value
> won't be decreased, is it fine?
>
> >
> >       set_inode_flag(cc->inode, FI_APPEND_WRITE);
> >       if (cc->cluster_idx =3D=3D 0)
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e2d302ae3a46..2c989f8caf05 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1623,6 +1623,11 @@ struct f2fs_sb_info {
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> >       struct kmem_cache *page_array_slab;     /* page array entry */
> >       unsigned int page_array_slab_size;      /* default page array sla=
b size */
> > +
> > +     /* For runtime compression statistics */
> > +     atomic64_t compr_written_block;
> > +     atomic64_t compr_saved_block;
> > +     atomic_t compr_new_inode;
> >   #endif
> >   };
> >
> > @@ -3955,6 +3960,18 @@ int f2fs_init_page_array_cache(struct f2fs_sb_in=
fo *sbi);
> >   void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
> >   int __init f2fs_init_compress_cache(void);
> >   void f2fs_destroy_compress_cache(void);
> > +#define inc_compr_inode_stat(inode)                                  \
> > +     do {                                                            \
> > +             struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);           =
 \
> > +             atomic_inc(&sbi->compr_new_inode);                      \
> > +     } while (0)
> > +#define add_compr_block_stat(inode, blocks)                          \
> > +     do {                                                            \
> > +             struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);           =
 \
> > +             int diff =3D F2FS_I(inode)->i_cluster_size - blocks;     =
 \
> > +             atomic64_add(blocks, &sbi->compr_written_block);        \
> > +             atomic64_add(diff, &sbi->compr_saved_block);            \
> > +     } while (0)
> >   #else
> >   static inline bool f2fs_is_compressed_page(struct page *page) { retur=
n false; }
> >   static inline bool f2fs_is_compress_backend_ready(struct inode *inode=
)
> > @@ -3983,6 +4000,7 @@ static inline int f2fs_init_page_array_cache(stru=
ct f2fs_sb_info *sbi) { return
> >   static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info =
*sbi) { }
> >   static inline int __init f2fs_init_compress_cache(void) { return 0; }
> >   static inline void f2fs_destroy_compress_cache(void) { }
> > +#define inc_compr_inode_stat(inode)          do { } while (0)
> >   #endif
> >
> >   static inline void set_compress_context(struct inode *inode)
> > @@ -4006,6 +4024,7 @@ static inline void set_compress_context(struct in=
ode *inode)
> >       F2FS_I(inode)->i_flags |=3D F2FS_COMPR_FL;
> >       set_inode_flag(inode, FI_COMPRESSED_FILE);
> >       stat_inc_compr_inode(inode);
> > +     inc_compr_inode_stat(inode);
>
> Ditto, if we disable compressed file via f2fs_disable_compressed_file(),
> compr_new_inode value won't be decreased correctly.
>
> If there is no problem, it needs to add description to indicate it won't =
be
> aware of decrease of saved/written blocks or compressed inode number.
>
> Thanks,
>
> >       f2fs_mark_inode_dirty_sync(inode, true);
> >   }
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 7069793752f1..88d9ecdee8d3 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -3260,6 +3260,13 @@ static void init_sb_info(struct f2fs_sb_info *sb=
i)
> >
> >       init_rwsem(&sbi->sb_lock);
> >       init_rwsem(&sbi->pin_sem);
> > +
> > +#ifdef CONFIG_F2FS_FS_COMPRESSION
> > +     /* For runtime compression statistics */
> > +     atomic64_set(&sbi->compr_written_block, 0);
> > +     atomic64_set(&sbi->compr_saved_block, 0);
> > +     atomic_set(&sbi->compr_new_inode, 0);
> > +#endif
> >   }
> >
> >   static int init_percpu_info(struct f2fs_sb_info *sbi)
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index e38a7f6921dd..2b6e5e6e1286 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -282,6 +282,38 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> >               return len;
> >       }
> >
> > +#ifdef CONFIG_F2FS_FS_COMPRESSION
> > +     if (!strcmp(a->attr.name, "compr_written_block")) {
> > +             u64 bcount;
> > +             int len;
> > +
> > +             bcount =3D atomic64_read(&sbi->compr_written_block);
> > +
> > +             len =3D scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);
> > +             return len;
> > +     }
> > +
> > +     if (!strcmp(a->attr.name, "compr_saved_block")) {
> > +             u64 bcount;
> > +             int len;
> > +
> > +             bcount =3D atomic64_read(&sbi->compr_saved_block);
> > +
> > +             len =3D scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);
> > +             return len;
> > +     }
> > +
> > +     if (!strcmp(a->attr.name, "compr_new_inode")) {
> > +             u32 icount;
> > +             int len;
> > +
> > +             icount =3D atomic_read(&sbi->compr_new_inode);
> > +
> > +             len =3D scnprintf(buf, PAGE_SIZE, "%u\n", icount);
> > +             return len;
> > +     }
> > +#endif
> > +
> >       ui =3D (unsigned int *)(ptr + a->offset);
> >
> >       return sprintf(buf, "%u\n", *ui);
> > @@ -458,6 +490,24 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >               return count;
> >       }
> >
> > +#ifdef CONFIG_F2FS_FS_COMPRESSION
> > +     if (!strcmp(a->attr.name, "compr_written_block") ||
> > +             !strcmp(a->attr.name, "compr_saved_block")) {
> > +             if (t !=3D 0)
> > +                     return -EINVAL;
> > +             atomic64_set(&sbi->compr_written_block, 0);
> > +             atomic64_set(&sbi->compr_saved_block, 0);
> > +             return count;
> > +     }
> > +
> > +     if (!strcmp(a->attr.name, "compr_new_inode")) {
> > +             if (t !=3D 0)
> > +                     return -EINVAL;
> > +             atomic_set(&sbi->compr_new_inode, 0);
> > +             return count;
> > +     }
> > +#endif
> > +
> >       *ui =3D (unsigned int)t;
> >
> >       return count;
> > @@ -668,6 +718,9 @@ F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM)=
;
> >   F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> >   F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_writte=
n_block);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_bl=
ock);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode)=
;
> >   #endif
> >
> >   #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> > @@ -730,6 +783,11 @@ static struct attribute *f2fs_attrs[] =3D {
> >       ATTR_LIST(moved_blocks_foreground),
> >       ATTR_LIST(moved_blocks_background),
> >       ATTR_LIST(avg_vblocks),
> > +#endif
> > +#ifdef CONFIG_F2FS_FS_COMPRESSION
> > +     ATTR_LIST(compr_written_block),
> > +     ATTR_LIST(compr_saved_block),
> > +     ATTR_LIST(compr_new_inode),
> >   #endif
> >       NULL,
> >   };
> >
