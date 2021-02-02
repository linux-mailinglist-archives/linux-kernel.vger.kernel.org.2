Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0B30BAAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhBBJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhBBJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:08:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290FC061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:07:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id i187so26853950lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=In0CSDv/Q/hG+NkbNDt2FUl6WznC3/RqBO8x/j/rwFI=;
        b=kKwq8NuqIasiysmiiOEjM+AMztkHFZN6kB9OCZR+Mj5WY8zpucL6+MqB0P/+a157lc
         wV+FjCYM2jgaV0v9miDyCMQU2Au42uuuuLI/FDFTtafSvduYBI5F84DnnVVV2LjHe06c
         wNSjUyxbNBsPhJbketzpyp8kK8zpSeFxc3dF4xnjrl/H7k3IKh3TfM+StWhkAmK/JG9q
         gh0d3ZhfN14efQmslnGWA5jffXUp7uNa1I71byb33lTONTo5XeCYwgGUDYWJ28GbzJVA
         fWjtoGzHORjDB6xYuEkUEGCm+//0xZ+bZmuemKrjrsar///0PQKUJbspqd8gf/bp5sG+
         dVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=In0CSDv/Q/hG+NkbNDt2FUl6WznC3/RqBO8x/j/rwFI=;
        b=rmTrO6ZPi6yfHlV3Vwtb9ws1xte4j/p7+B59uGuKCmKVOjWQys3iAuAgZjDO++EjZr
         gOUSqE6GI1KTNGTNKBWILB2zhNY+Dz0LRQBW2jrqdEroOo3d9/h4PDGDebOnikuZUeUA
         2hW7wfeKYq6D6LEl2j/LCn48pUOTmJ26lsf5ecVHDkFl17gOXbF5PbvJKdlfUalCV7p6
         +7HR2YNk7XmhfmQybjFRVPjoVkMIo8do8LbyWMUjyq/LGLkZlPSk70e8RZ3/DFu69fwM
         jykWspZSubbPn7EZz8OUfXvCRHeLxy77QiEs87KcU+oXgrtAzJqBra0KrL//6WAcoGo1
         enLA==
X-Gm-Message-State: AOAM531SeuUBaM1kZTtYqgKQV8218XlX/E8TQnXYhv+wfbbmU/hZ3ZK+
        WY7s/izr2n/68Z4FDXVp52/HvA/b/k8mqGqGSZOW60v8
X-Google-Smtp-Source: ABdhPJxLisIdQY0zejshsTk4z/YUQKxMrEc3UtJHmWDciRLl6UDxmosGvSA1r0jLm8wqN6IZJ18pKP5OZx2jCwGmTxA=
X-Received: by 2002:a05:6512:3247:: with SMTP id c7mr10413959lfr.533.1612256873358;
 Tue, 02 Feb 2021 01:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20210202051829.2127214-1-daeho43@gmail.com> <ef27f0cc-87b6-cea1-31a6-f2837d6a673c@huawei.com>
 <CACOAw_wGY1CNXZ9QoLB1t0800Wyjv1_P9iuqk4SOKjT-oUQamw@mail.gmail.com> <6f1e4639-3715-d855-951d-7c0a67fa9913@huawei.com>
In-Reply-To: <6f1e4639-3715-d855-951d-7c0a67fa9913@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 2 Feb 2021 18:07:42 +0900
Message-ID: <CACOAw_zmPXzTrtp7VVyBoYLRe_TRzTB6CqjQkmLq=NU=Bky9WQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: rename checkpoint=merge mount option
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

If I understand it correctly, the only thing I have to do now is
remove "nocheckpoint_merge" now.
Am I correct? :)

2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:30, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/2/2 16:02, Daeho Jeong wrote:
> > I chose the same step with "flush_merge", because it doesn't have
> > "noflush_merge".
>
> Oh, "noxxx" option was added only when we set the option by default in
> default_options(), when user want to disable the default option, it
> needs to use "noxxx" option, and then we will show this "noxxx" option
> string to user via show_options() to indicate that "noxxx" option is
> working now.
>
> Anyway I think we should fix to show "noflush_merge" option because we
> have set flush_merge by default.
>
> > Do you think we need that for both, "noflush_merge" and "nocheckpoint_m=
erge"?
>
> For "nocheckpoint_merge", we can introduce this option only when we want
> to set "checkpoint_merge" by default.
>
> Here is the example from noinline_data:
>
> Commit 75342797988 ("f2fs: enable inline data by default")
>
> Thanks,
>
> >
> > I thought we needed to give some time to make this be turned on by
> > default. It might be a little radical. :)
> >
> > What do you think?
> >
> > 2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:40=
, Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On 2021/2/2 13:18, Daeho Jeong wrote:
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
> >>> ---
> >>>    Documentation/filesystems/f2fs.rst |  6 +++---
> >>>    fs/f2fs/super.c                    | 26 ++++++++++++++------------
> >>>    2 files changed, 17 insertions(+), 15 deletions(-)
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
> >>> index 56696f6cfa86..d8603e6c4916 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -145,6 +145,7 @@ enum {
> >>>        Opt_checkpoint_disable_cap_perc,
> >>>        Opt_checkpoint_enable,
> >>>        Opt_checkpoint_merge,
> >>> +     Opt_nocheckpoint_merge,
> >>>        Opt_compress_algorithm,
> >>>        Opt_compress_log_size,
> >>>        Opt_compress_extension,
> >>> @@ -215,7 +216,8 @@ static match_table_t f2fs_tokens =3D {
> >>>        {Opt_checkpoint_disable_cap, "checkpoint=3Ddisable:%u"},
> >>>        {Opt_checkpoint_disable_cap_perc, "checkpoint=3Ddisable:%u%%"}=
,
> >>>        {Opt_checkpoint_enable, "checkpoint=3Denable"},
> >>> -     {Opt_checkpoint_merge, "checkpoint=3Dmerge"},
> >>> +     {Opt_checkpoint_merge, "checkpoint_merge"},
> >>> +     {Opt_nocheckpoint_merge, "nocheckpoint_merge"},
> >>>        {Opt_compress_algorithm, "compress_algorithm=3D%s"},
> >>>        {Opt_compress_log_size, "compress_log_size=3D%u"},
> >>>        {Opt_compress_extension, "compress_extension=3D%s"},
> >>> @@ -946,6 +948,9 @@ static int parse_options(struct super_block *sb, =
char *options, bool is_remount)
> >>>                case Opt_checkpoint_merge:
> >>>                        set_opt(sbi, MERGE_CHECKPOINT);
> >>>                        break;
> >>> +             case Opt_nocheckpoint_merge:
> >>> +                     clear_opt(sbi, MERGE_CHECKPOINT);
> >>> +                     break;
> >>>    #ifdef CONFIG_F2FS_FS_COMPRESSION
> >>>                case Opt_compress_algorithm:
> >>>                        if (!f2fs_sb_has_compression(sbi)) {
> >>> @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *s=
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
> >>> @@ -1782,7 +1781,7 @@ static int f2fs_show_options(struct seq_file *s=
eq, struct dentry *root)
> >>>                seq_printf(seq, ",checkpoint=3Ddisable:%u",
> >>>                                F2FS_OPTION(sbi).unusable_cap);
> >>>        if (test_opt(sbi, MERGE_CHECKPOINT))
> >>> -             seq_puts(seq, ",checkpoint=3Dmerge");
> >>> +             seq_puts(seq, ",checkpoint_merge");
> >>
> >> Other noxxx options will be shown in show_options(), how about followi=
ng them?
> >>
> >>>        if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_POSIX)
> >>>                seq_printf(seq, ",fsync_mode=3D%s", "posix");
> >>>        else if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> >>> @@ -1827,6 +1826,7 @@ static void default_options(struct f2fs_sb_info=
 *sbi)
> >>>        sbi->sb->s_flags |=3D SB_LAZYTIME;
> >>>        set_opt(sbi, FLUSH_MERGE);
> >>>        set_opt(sbi, DISCARD);
> >>> +     clear_opt(sbi, MERGE_CHECKPOINT);
> >>
> >> Why should we clear checkpoint_merge option in default_options()?
> >>
> >> Thanks,
> >>
> >>>        if (f2fs_sb_has_blkzoned(sbi))
> >>>                F2FS_OPTION(sbi).fs_mode =3D FS_MODE_LFS;
> >>>        else
> >>> @@ -2066,9 +2066,8 @@ static int f2fs_remount(struct super_block *sb,=
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
> >>> @@ -2076,6 +2075,8 @@ static int f2fs_remount(struct super_block *sb,=
 int *flags, char *data)
> >>>                            err);
> >>>                        goto restore_gc;
> >>>                }
> >>> +     } else {
> >>> +             f2fs_stop_ckpt_thread(sbi);
> >>>        }
> >>>
> >>>        /*
> >>> @@ -3831,7 +3832,8 @@ static int f2fs_fill_super(struct super_block *=
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
