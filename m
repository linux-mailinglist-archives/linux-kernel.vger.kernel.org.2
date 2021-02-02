Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FEA30BB50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhBBJqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBBJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:45:41 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:45:00 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u4so21664014ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H63nqhu+RhN0uSPLDKy0j8fY+pttJoRRoiZky9oT7bg=;
        b=eqvbHSYuz2g9HMf8exvniz/ZFDDtc4+uUsO5u2HgSGQjQZmuQu8WkrZPRAGVIqm+cZ
         iGpSN4+ZJPjFuOWhbL6zIg0Et8K19XdkZ1inOEcitx2GH/NaasPLM/UdoJKU9En+kvNN
         VWCSRSE+4GGJeHtXqRmQXod3jt8RleUTbv4Rqt+I8MC8pIvi+GHBQJF6pmiF7J2Kr79k
         OHauXtZDJcEvpIaW1Oar2FGZiViVoC4/quU6++kCgbxZU95z5VvYs9NJuo4n08gHrEeE
         E/Yim1vm41k/gdJe/ougoG/PKMN7pn+Ch764S3Ll/iQpefsEH6pdlVsZVRJzaj/QVYw2
         fVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H63nqhu+RhN0uSPLDKy0j8fY+pttJoRRoiZky9oT7bg=;
        b=S1YBK4UpE3wBc7Mr6DQ3NvC19gxHp8I9KhHOsA1o3fMpPiULvP+EvQSz5taarDaOmq
         eaRh2SMx6eBBX6LsT9kxg2jyS80eh3soda0mOQkAsG+Gs3jIJlwtFVN/eLj/9313Y1JW
         RGVdkiW84S8p7gh1bWGpjQEGb2NO6U2bYo0jVEcWstaQ29ASFGlfGPoR9vbT7c9EP1vS
         jPDTdBNEo3xoY/C9kxyEVaxYJ0LQK718C6iFhImMc9cJHg3WwLsH0N9c+F52IrFogoJX
         WS4SZIw1rF95+bW8nk9TRiM9S9EPUdTg0tnm5ZNzNIL/F8u7tAFVUu5V71jrXO8Wjg98
         d1NA==
X-Gm-Message-State: AOAM532eqzGzHDhByB/DurZecklNzf4eQKYu7jUQ+d5g3tGKmkABYxVo
        1X3P3b0E5niAoIx3tef+2j9KflGrxzkNBuuC1o4PJcVbGbA=
X-Google-Smtp-Source: ABdhPJyRzhSfipXG8bDr4UZFi4qZIP9QUEg3fmowPo8TS6/UPq+AabjJ22y2C+42uiggWRQdUMXEo/wg/Fo11goRE6k=
X-Received: by 2002:a2e:a366:: with SMTP id i6mr12669282ljn.21.1612259099110;
 Tue, 02 Feb 2021 01:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20210202092332.2562006-1-daeho43@gmail.com> <a7adaf99-0df1-cf4a-a60a-d47a104f51aa@huawei.com>
In-Reply-To: <a7adaf99-0df1-cf4a-a60a-d47a104f51aa@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 2 Feb 2021 18:44:48 +0900
Message-ID: <CACOAw_wmodtCvDRa_1hh2=u9AP3Qg6VBGG4K1by9QJNGweApVA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: rename checkpoint=merge mount option
 to checkpoint_merge
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we remount it without the "checkpoint_merge" option, shouldn't we
need to clear "MERGE_CHECKPOINT" again?
This is actually what I intended, but I was wrong. Actually, I found this.

When we remount the filesystem, the previous mount option is passed
through the "data" argument in the below.
f2fs_remount(struct super_block *sb, int *flags, char *data)

If we don't provide the "nocheckpoint_merge" option, how can we turn
off the "checkpoint_merge" option which is turned on in the previous
mount?

2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:28, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/2/2 17:23, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > As checkpoint=3Dmerge comes in, mount option setting related to checkpo=
int
> > had been mixed up and it became hard to understand. So, I separated
> > this option from "checkpoint=3D" and made another mount option
> > "checkpoint_merge" for this.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: renamed "checkpoint=3Dmerge" to "checkpoint_merge"
> > v3: removed "nocheckpoint_merge" option
> > ---
> >   Documentation/filesystems/f2fs.rst |  6 +++---
> >   fs/f2fs/super.c                    | 21 +++++++++------------
> >   2 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesys=
tems/f2fs.rst
> > index d0ead45dc706..475994ed8b15 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -247,9 +247,9 @@ checkpoint=3D%s[:%u[%]]      Set to "disable" to tu=
rn off checkpointing. Set to "enabl
> >                        hide up to all remaining free space. The actual =
space that
> >                        would be unusable can be viewed at /sys/fs/f2fs/=
<disk>/unusable
> >                        This space is reclaimed once checkpoint=3Denable=
.
> > -                      Here is another option "merge", which creates a =
kernel daemon
> > -                      and makes it to merge concurrent checkpoint requ=
ests as much
> > -                      as possible to eliminate redundant checkpoint is=
sues. Plus,
> > +checkpoint_merge      When checkpoint is enabled, this can be used to =
create a kernel
> > +                      daemon and make it to merge concurrent checkpoin=
t requests as
> > +                      much as possible to eliminate redundant checkpoi=
nt issues. Plus,
> >                        we can eliminate the sluggish issue caused by sl=
ow checkpoint
> >                        operation when the checkpoint is done in a proce=
ss context in
> >                        a cgroup having low i/o budget and cpu shares. T=
o make this
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 56696f6cfa86..b60dcef7f9d0 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -215,7 +215,7 @@ static match_table_t f2fs_tokens =3D {
> >       {Opt_checkpoint_disable_cap, "checkpoint=3Ddisable:%u"},
> >       {Opt_checkpoint_disable_cap_perc, "checkpoint=3Ddisable:%u%%"},
> >       {Opt_checkpoint_enable, "checkpoint=3Denable"},
> > -     {Opt_checkpoint_merge, "checkpoint=3Dmerge"},
> > +     {Opt_checkpoint_merge, "checkpoint_merge"},
> >       {Opt_compress_algorithm, "compress_algorithm=3D%s"},
> >       {Opt_compress_log_size, "compress_log_size=3D%u"},
> >       {Opt_compress_extension, "compress_extension=3D%s"},
> > @@ -1142,12 +1142,6 @@ static int parse_options(struct super_block *sb,=
 char *options, bool is_remount)
> >               return -EINVAL;
> >       }
> >
> > -     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> > -                     test_opt(sbi, MERGE_CHECKPOINT)) {
> > -             f2fs_err(sbi, "checkpoint=3Dmerge cannot be used with che=
ckpoint=3Ddisable\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       /* Not pass down write hints if the number of active logs is less=
er
> >        * than NR_CURSEG_PERSIST_TYPE.
> >        */
> > @@ -1782,7 +1776,7 @@ static int f2fs_show_options(struct seq_file *seq=
, struct dentry *root)
> >               seq_printf(seq, ",checkpoint=3Ddisable:%u",
> >                               F2FS_OPTION(sbi).unusable_cap);
> >       if (test_opt(sbi, MERGE_CHECKPOINT))
> > -             seq_puts(seq, ",checkpoint=3Dmerge");
> > +             seq_puts(seq, ",checkpoint_merge");
> >       if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_POSIX)
> >               seq_printf(seq, ",fsync_mode=3D%s", "posix");
> >       else if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> > @@ -1827,6 +1821,7 @@ static void default_options(struct f2fs_sb_info *=
sbi)
> >       sbi->sb->s_flags |=3D SB_LAZYTIME;
> >       set_opt(sbi, FLUSH_MERGE);
> >       set_opt(sbi, DISCARD);
> > +     clear_opt(sbi, MERGE_CHECKPOINT);
>
> It's not needed here?
>
> Thanks,
>
> >       if (f2fs_sb_has_blkzoned(sbi))
> >               F2FS_OPTION(sbi).fs_mode =3D FS_MODE_LFS;
> >       else
> > @@ -2066,9 +2061,8 @@ static int f2fs_remount(struct super_block *sb, i=
nt *flags, char *data)
> >               }
> >       }
> >
> > -     if (!test_opt(sbi, MERGE_CHECKPOINT)) {
> > -             f2fs_stop_ckpt_thread(sbi);
> > -     } else {
> > +     if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> > +                     test_opt(sbi, MERGE_CHECKPOINT)) {
> >               err =3D f2fs_start_ckpt_thread(sbi);
> >               if (err) {
> >                       f2fs_err(sbi,
> > @@ -2076,6 +2070,8 @@ static int f2fs_remount(struct super_block *sb, i=
nt *flags, char *data)
> >                           err);
> >                       goto restore_gc;
> >               }
> > +     } else {
> > +             f2fs_stop_ckpt_thread(sbi);
> >       }
> >
> >       /*
> > @@ -3831,7 +3827,8 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
> >
> >       /* setup checkpoint request control and start checkpoint issue th=
read */
> >       f2fs_init_ckpt_req_control(sbi);
> > -     if (test_opt(sbi, MERGE_CHECKPOINT)) {
> > +     if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> > +                     test_opt(sbi, MERGE_CHECKPOINT)) {
> >               err =3D f2fs_start_ckpt_thread(sbi);
> >               if (err) {
> >                       f2fs_err(sbi,
> >
