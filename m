Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A2338F39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCLN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhCLN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:56:26 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E296EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:56:25 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 16so6843768ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 05:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+cQI6IBGeUFnwRLsME/R/tm5JUnpBXS5OxVlu71yp4=;
        b=mMF2TVCLPhwVCGaTyiVuCUd6NCDmmTEA7yh9NysOLee4jMJQ7JOY9v36HlbqsabBba
         /FGf3Y7rJJjMyz+xTy0hwTnDzi3Y3cGhrd6FMj5fgVDOHJGtX8BaeLHdY5/jZCPttwRg
         0Zzpc9bV6D+KgPBRRJpQ0+V+Z8Jnv2dHnoJgzgFMV6zz9UplBDRyBuoa2iz/Bwbw0vlO
         eByN3mWN9gvWj1C06T4Fhwb7nRgNYlfQVjJBEt7gtE7okN84k0Viqos1wFh46bkKTMUP
         TJgfhWXfX3+rnruqoByrVH46QnKqiXeJvT0TeafZdZIUtcXp3UwqujUo7O65z+LEiVcj
         i11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+cQI6IBGeUFnwRLsME/R/tm5JUnpBXS5OxVlu71yp4=;
        b=gSJ4kPyY4+lFDf91Yib5vnPPT3irXHktg+u/Vck6F2Z7pV7/sziKICJbVLE1NZ5i5W
         E1U8RscqVuXU2SQpIps98JrtKGc1Xvsnm6HU5thpiOg5JoB7H0U/TupOEEQTdBKel5Bc
         oCGoBNieKcELJHd4w2Ejjg8L3ci8eg+Ms01mTkEIwATHEtbapDVrWi0Eehw9iqLN8dSm
         m0Owh2gIFEXpIQyXgVWkVsjtaChT8al3ktsMhQeV7X8wH4EzIOpc0tudmBj73qz8JWgS
         lDCieV8dPO7Dcdkal2kvVYruTifmJibpK0exJ1ZuSUdiIQaMPuBJ7fFd48QsmWKROdik
         QQhQ==
X-Gm-Message-State: AOAM531ksPvSNe7gKWyeLc1V7qoaQDfSAgRI/Mn3ruHUBJrIPeJElddQ
        fA8OGhnIqAgd7WmwcXMWv4w7Lr4qnX7CJx2Fp6s=
X-Google-Smtp-Source: ABdhPJwffCGWRkIYD6jWDrR+Q0unl67vgMn+0dEdUWWEKjlYNiJpUUJIFaz6I1IKyXmNSfuo/Jf8Ma79sirQ5eT8Hic=
X-Received: by 2002:a2e:a58f:: with SMTP id m15mr2385147ljp.400.1615557384397;
 Fri, 12 Mar 2021 05:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20210312122531.2717093-1-daeho43@gmail.com> <YEtg8U7whCVV2tQt@kroah.com>
In-Reply-To: <YEtg8U7whCVV2tQt@kroah.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 12 Mar 2021 22:56:13 +0900
Message-ID: <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for suggesting me sysfs_emit().

For atomic values, actually, those are needed for writer part, not reader.

+#define add_compr_block_stat(inode, blocks)                            \
+       do {                                                            \
+               struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);            \
+               int diff =3D F2FS_I(inode)->i_cluster_size - blocks;      \
+               atomic64_add(blocks, &sbi->compr_written_block);        \
+               atomic64_add(diff, &sbi->compr_saved_block);            \
+       } while (0)

I needed a protection here, because they might be updated in the race condi=
tion.

2021=EB=85=84 3=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:39, G=
reg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Mar 12, 2021 at 09:25:31PM +0900, Daeho Jeong wrote:
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
> >     related to kernel config
> > v3: changed sysfs nodes' names and made them runtime stat, not
> >     persistent on disk
> > v4: changed sysfs nodes' desctiption
> > ---
> >  Documentation/ABI/testing/sysfs-fs-f2fs | 24 ++++++++++
> >  fs/f2fs/compress.c                      |  1 +
> >  fs/f2fs/f2fs.h                          | 19 ++++++++
> >  fs/f2fs/super.c                         |  7 +++
> >  fs/f2fs/sysfs.c                         | 58 +++++++++++++++++++++++++
> >  5 files changed, 109 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/AB=
I/testing/sysfs-fs-f2fs
> > index cbeac1bebe2f..ddd4bd6116fc 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -409,3 +409,27 @@ Description:     Give a way to change checkpoint m=
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
t. Note
> > +             that when the compressed blocks are deleted, this count d=
oesn't
> > +             decrease. If you write "0" here, you can initialize
> > +             compr_written_block and compr_saved_block to "0".
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_saved_block
> > +Date:                March 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show the saved block count with compression since mount. =
Note
> > +             that when the compressed blocks are deleted, this count d=
oesn't
> > +             decrease. If you write "0" here, you can initialize
> > +             compr_written_block and compr_saved_block to "0".
> > +
> > +What:                /sys/fs/f2fs/<disk>/compr_new_inode
> > +Date:                March 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show the count of inode newly enabled for compression sin=
ce mount.
> > +             Note that when the compression is disabled for the files,=
 this count
> > +             doesn't decrease. If you write "0" here, you can initiali=
ze
> > +             compr_new_inode to "0".
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
> >
> >       set_inode_flag(cc->inode, FI_APPEND_WRITE);
> >       if (cc->cluster_idx =3D=3D 0)
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e2d302ae3a46..2c989f8caf05 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1623,6 +1623,11 @@ struct f2fs_sb_info {
> >  #ifdef CONFIG_F2FS_FS_COMPRESSION
> >       struct kmem_cache *page_array_slab;     /* page array entry */
> >       unsigned int page_array_slab_size;      /* default page array sla=
b size */
> > +
> > +     /* For runtime compression statistics */
> > +     atomic64_t compr_written_block;
> > +     atomic64_t compr_saved_block;
> > +     atomic_t compr_new_inode;
>
> Why do you need these to be atomic?  What requires this?
>
> > +#ifdef CONFIG_F2FS_FS_COMPRESSION
> > +     if (!strcmp(a->attr.name, "compr_written_block")) {
> > +             u64 bcount;
> > +             int len;
> > +
> > +             bcount =3D atomic64_read(&sbi->compr_written_block);
> > +
> > +             len =3D scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);
>
> Please use sysfs_emit() for new sysfs entries like these.  Makes it much
> simpler.
>
> And look, you really do not need an atomic value as this is just a
> random number you are sending to userspace that could be stale the
> minute you read from it.
>
> Please just use a normal u64 and save the cpu sync for stuff like this.
>
> thanks,
>
> greg k-h
