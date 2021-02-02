Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B600B30BD2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBBLcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhBBLaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:30:03 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D4C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 03:29:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so27411002lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 03:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5kBnK6zBKaZUM/KF8Xtcvvpals8MRe7AMck8YpBvR8g=;
        b=kCPH1503xyPxt1m8MExh8eJrcrYMZ70lQ6XGWkDQ9/MGfDoh75tb54uD/kjTCW0x6l
         khqZ+AFwCsLIhfUx7YmGvBjNTs7k3atCymOeQTXtOTYY8K6Ckonk4RyPTHMZyxPajDqJ
         td/uHsEm6IGNQfMWEhZ/Qmfc1x3yL7fPkkR6nxvnQtORXWrtD21ksRjCWEAj4rr4PMr/
         43DU+G0sHWiIK5Xlcyb7F0fn1kJeqA71zdgzhOnXFXM8JKpiHG/MefZbkq9et7QCUcLo
         HTHaZdX3keeoKgWghUgZOeLk5IYB8QNBgLlxBPYzCK6RZWfiodrPFGq4wUUvODBKrX/g
         IblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5kBnK6zBKaZUM/KF8Xtcvvpals8MRe7AMck8YpBvR8g=;
        b=mmJ34If0jbRNCj0PkQty7s02qDMy+rf+aJl55FjUT4Du5y/7u0vrba2QfDC2JB+Alw
         nNzJojdTrEbyCGLzlS/2aDrqXbiJBc5T9FcadLcbnwjBvViVOcPD5CVDHpkGDrhGLkUf
         wX1C83Edcb0xown964YeGG4j0/VBCuyyMKqbR6pjapjWCyzD9ckDg8D2CUqdsZA+0+UG
         axUnxj+ERsoqCiOqPp/hXAZqE1v7olCgoMNn9G/dvNiqkXVu/XtHgyoWpFhiGH/3NpzG
         92HNimKU3BQSbhWUWiHToYf6saDoLIiVampmMbgHaWLeeVrCJbqkHPk/UzBsFi7xOsk3
         oqUA==
X-Gm-Message-State: AOAM532jZZ3gvdpGQIhKxdxkWyqEs1YWDp94v2xZV2xF6YeCpwRw+SuO
        RCq2R1WP49OvU8kf4nsWSv8WaTQelvGrbi5hWWGbPtxSxeo=
X-Google-Smtp-Source: ABdhPJxEkiLKzIdRbvARRvqucEMvvvC5prTVc7U1IB0pCnGVayKH+8BmLmuMCf0ekJeALPbLZmVCi+TTX4kS9e50QR4=
X-Received: by 2002:a19:7403:: with SMTP id v3mr11134992lfe.67.1612265361566;
 Tue, 02 Feb 2021 03:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20210202092332.2562006-1-daeho43@gmail.com> <a7adaf99-0df1-cf4a-a60a-d47a104f51aa@huawei.com>
 <CACOAw_wmodtCvDRa_1hh2=u9AP3Qg6VBGG4K1by9QJNGweApVA@mail.gmail.com> <938ce080-d211-0834-64b4-fd4836a26d5a@huawei.com>
In-Reply-To: <938ce080-d211-0834-64b4-fd4836a26d5a@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 2 Feb 2021 20:29:10 +0900
Message-ID: <CACOAw_xLcARkqx7oQjLT--vxVHWBxdSz6dN0B00m9ejO+S7qoQ@mail.gmail.com>
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

Thanks for the explanation.

I am going to remove the line clearing "MERGE_CHECKPOINT".
But, when we go with the below remount command, I think the
"nocheckpoint_merge" option will work well to disable only just
"checkpoint_merge" from the previous option.
"mount -o remount,nocheckpoint_merge  /dir"

It would be more convenient to users. What do you think?

2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:55, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/2/2 17:44, Daeho Jeong wrote:
> > When we remount it without the "checkpoint_merge" option, shouldn't we
> > need to clear "MERGE_CHECKPOINT" again?
> > This is actually what I intended, but I was wrong. Actually, I found th=
is.
> >
> > When we remount the filesystem, the previous mount option is passed
> > through the "data" argument in the below.
> > f2fs_remount(struct super_block *sb, int *flags, char *data)
> >
> > If we don't provide the "nocheckpoint_merge" option, how can we turn
> > off the "checkpoint_merge" option which is turned on in the previous
> > mount?
>
> We can use "mount -o remount /dev/xxx /mnt" to disable checkpoint_merge,
> since that command won't pass old mount options to remount?
>
> Quoted from man mount:
>
>                mount -o remount,rw /dev/foo /dir
>
>                After  this  call  all  old  mount options are replaced an=
d arbitrary stuff from fstab (or mtab) is ignored, except the loop=3D optio=
n which is internally generated and maintained by the
>                mount command.
>
>                mount -o remount,rw  /dir
>
>                After this call mount reads fstab and merges these options=
 with the options from the command line (-o). If no mountpoint found in fst=
ab than remount with unspecified source is allowed.
>
> Thanks,
>
> >
> > 2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 6:28=
, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2021/2/2 17:23, Daeho Jeong wrote:
> >>> From: Daeho Jeong <daehojeong@google.com>
> >>>
> >>> As checkpoint=3Dmerge comes in, mount option setting related to check=
point
> >>> had been mixed up and it became hard to understand. So, I separated
> >>> this option from "checkpoint=3D" and made another mount option
> >>> "checkpoint_merge" for this.
> >>>
> >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>> ---
> >>> v2: renamed "checkpoint=3Dmerge" to "checkpoint_merge"
> >>> v3: removed "nocheckpoint_merge" option
> >>> ---
> >>>    Documentation/filesystems/f2fs.rst |  6 +++---
> >>>    fs/f2fs/super.c                    | 21 +++++++++------------
> >>>    2 files changed, 12 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/files=
ystems/f2fs.rst
> >>> index d0ead45dc706..475994ed8b15 100644
> >>> --- a/Documentation/filesystems/f2fs.rst
> >>> +++ b/Documentation/filesystems/f2fs.rst
> >>> @@ -247,9 +247,9 @@ checkpoint=3D%s[:%u[%]]      Set to "disable" to =
turn off checkpointing. Set to "enabl
> >>>                         hide up to all remaining free space. The actu=
al space that
> >>>                         would be unusable can be viewed at /sys/fs/f2=
fs/<disk>/unusable
> >>>                         This space is reclaimed once checkpoint=3Dena=
ble.
> >>> -                      Here is another option "merge", which creates =
a kernel daemon
> >>> -                      and makes it to merge concurrent checkpoint re=
quests as much
> >>> -                      as possible to eliminate redundant checkpoint =
issues. Plus,
> >>> +checkpoint_merge      When checkpoint is enabled, this can be used t=
o create a kernel
> >>> +                      daemon and make it to merge concurrent checkpo=
int requests as
> >>> +                      much as possible to eliminate redundant checkp=
oint issues. Plus,
> >>>                         we can eliminate the sluggish issue caused by=
 slow checkpoint
> >>>                         operation when the checkpoint is done in a pr=
ocess context in
> >>>                         a cgroup having low i/o budget and cpu shares=
. To make this
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>> index 56696f6cfa86..b60dcef7f9d0 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -215,7 +215,7 @@ static match_table_t f2fs_tokens =3D {
> >>>        {Opt_checkpoint_disable_cap, "checkpoint=3Ddisable:%u"},
> >>>        {Opt_checkpoint_disable_cap_perc, "checkpoint=3Ddisable:%u%%"}=
,
> >>>        {Opt_checkpoint_enable, "checkpoint=3Denable"},
> >>> -     {Opt_checkpoint_merge, "checkpoint=3Dmerge"},
> >>> +     {Opt_checkpoint_merge, "checkpoint_merge"},
> >>>        {Opt_compress_algorithm, "compress_algorithm=3D%s"},
> >>>        {Opt_compress_log_size, "compress_log_size=3D%u"},
> >>>        {Opt_compress_extension, "compress_extension=3D%s"},
> >>> @@ -1142,12 +1142,6 @@ static int parse_options(struct super_block *s=
b, char *options, bool is_remount)
> >>>                return -EINVAL;
> >>>        }
> >>>
> >>> -     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> >>> -                     test_opt(sbi, MERGE_CHECKPOINT)) {
> >>> -             f2fs_err(sbi, "checkpoint=3Dmerge cannot be used with c=
heckpoint=3Ddisable\n");
> >>> -             return -EINVAL;
> >>> -     }
> >>> -
> >>>        /* Not pass down write hints if the number of active logs is l=
esser
> >>>         * than NR_CURSEG_PERSIST_TYPE.
> >>>         */
> >>> @@ -1782,7 +1776,7 @@ static int f2fs_show_options(struct seq_file *s=
eq, struct dentry *root)
> >>>                seq_printf(seq, ",checkpoint=3Ddisable:%u",
> >>>                                F2FS_OPTION(sbi).unusable_cap);
> >>>        if (test_opt(sbi, MERGE_CHECKPOINT))
> >>> -             seq_puts(seq, ",checkpoint=3Dmerge");
> >>> +             seq_puts(seq, ",checkpoint_merge");
> >>>        if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_POSIX)
> >>>                seq_printf(seq, ",fsync_mode=3D%s", "posix");
> >>>        else if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> >>> @@ -1827,6 +1821,7 @@ static void default_options(struct f2fs_sb_info=
 *sbi)
> >>>        sbi->sb->s_flags |=3D SB_LAZYTIME;
> >>>        set_opt(sbi, FLUSH_MERGE);
> >>>        set_opt(sbi, DISCARD);
> >>> +     clear_opt(sbi, MERGE_CHECKPOINT);
> >>
> >> It's not needed here?
> >>
> >> Thanks,
> >>
> >>>        if (f2fs_sb_has_blkzoned(sbi))
> >>>                F2FS_OPTION(sbi).fs_mode =3D FS_MODE_LFS;
> >>>        else
> >>> @@ -2066,9 +2061,8 @@ static int f2fs_remount(struct super_block *sb,=
 int *flags, char *data)
> >>>                }
> >>>        }
> >>>
> >>> -     if (!test_opt(sbi, MERGE_CHECKPOINT)) {
> >>> -             f2fs_stop_ckpt_thread(sbi);
> >>> -     } else {
> >>> +     if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> >>> +                     test_opt(sbi, MERGE_CHECKPOINT)) {
> >>>                err =3D f2fs_start_ckpt_thread(sbi);
> >>>                if (err) {
> >>>                        f2fs_err(sbi,
> >>> @@ -2076,6 +2070,8 @@ static int f2fs_remount(struct super_block *sb,=
 int *flags, char *data)
> >>>                            err);
> >>>                        goto restore_gc;
> >>>                }
> >>> +     } else {
> >>> +             f2fs_stop_ckpt_thread(sbi);
> >>>        }
> >>>
> >>>        /*
> >>> @@ -3831,7 +3827,8 @@ static int f2fs_fill_super(struct super_block *=
sb, void *data, int silent)
> >>>
> >>>        /* setup checkpoint request control and start checkpoint issue=
 thread */
> >>>        f2fs_init_ckpt_req_control(sbi);
> >>> -     if (test_opt(sbi, MERGE_CHECKPOINT)) {
> >>> +     if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
> >>> +                     test_opt(sbi, MERGE_CHECKPOINT)) {
> >>>                err =3D f2fs_start_ckpt_thread(sbi);
> >>>                if (err) {
> >>>                        f2fs_err(sbi,
> >>>
> > .
> >
