Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2030B923
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhBBID3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhBBID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:03:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BAC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:02:47 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b20so15026466ljo.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SGASE06gQlEzUsoewEXdn4+6FUJciTQ5BccQkIIbjP8=;
        b=rk/5KIs2uyJ/0Y8VyiYqX6+briWMp6Oxd42yS5/ffNbdsphjaWRBJrinklRRs/W9Hn
         fiUrcFpn+2g3n5hB1ykVKIsilpZb2aCoe2TK9bi/e07lUUvyB1CduYYeAIkzVxG6swiK
         g4UJpWguE2YBl3uDz4TgMgHuHvJ9VnZRx06QirI/qagvMj9of4U9fzeWVKtAYqbIlPx5
         Wr+pXckifZxpLI5XmewghRsUgePAf8GHezysnhQgLzqPrXbUvqmdxQaJxzsf5Qe4XtuN
         +0dNQ9U00/1O/0Lsmq7Cs82U0N286/wR1VndF9NNlxYZdSDnkhNOzxwFDAM4YFSdCP8t
         CB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SGASE06gQlEzUsoewEXdn4+6FUJciTQ5BccQkIIbjP8=;
        b=AhSbazPAW1fSg1Z0DHsvpWK06LhCx/+jyaMmkgkDee2iz9dnEJuNvBUJ+o5GaHkbCE
         XynVcQGJ9xry8v3C92Kao8Ds66HlQAWKdXkFNMs++Gr31fVY6S1Mn+zl9FHuazArxFrG
         mxG6c/Ugwb9jZe2d96MH/jaMNvZAqyzpWrGMNlFPXgOiFp5az5+Rd+/wko0Z3yY4xAF0
         sDFGCsum4p7Ki1cYzCOUA6QwSLAiK3RrhuyAhE4Mz3yDMtArvh3UHu5XHC8p7JMltinW
         7T2DcvbCcVpNSh26jPMYFMejku2KmyqZcXuoIsdI11eqID5su6GoC8emcF9u2YZVE7fv
         WzLQ==
X-Gm-Message-State: AOAM530lrmFP5v66sl6qQzngikZcejOxNKlmxJFCk6Yg+eApUcWA212t
        oLRMW6CdoXEj1DLxYdXOcC+ExSNhLqH0KdDmln2QuJ3o
X-Google-Smtp-Source: ABdhPJziW3M6NhdKHx6se4TFZTJB9vq10SDDsVil//prLMDSHkO/3HylLTZuPUBgnU0srMKYlNaE4MwtYZdu5oJIefI=
X-Received: by 2002:a2e:a366:: with SMTP id i6mr12457243ljn.21.1612252965417;
 Tue, 02 Feb 2021 00:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20210202051829.2127214-1-daeho43@gmail.com> <ef27f0cc-87b6-cea1-31a6-f2837d6a673c@huawei.com>
In-Reply-To: <ef27f0cc-87b6-cea1-31a6-f2837d6a673c@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 2 Feb 2021 17:02:34 +0900
Message-ID: <CACOAw_wGY1CNXZ9QoLB1t0800Wyjv1_P9iuqk4SOKjT-oUQamw@mail.gmail.com>
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

I chose the same step with "flush_merge", because it doesn't have
"noflush_merge".
Do you think we need that for both, "noflush_merge" and "nocheckpoint_merge=
"?

I thought we needed to give some time to make this be turned on by
default. It might be a little radical. :)

What do you think?

2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:40, Ch=
ao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/2/2 13:18, Daeho Jeong wrote:
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
> > ---
> >   Documentation/filesystems/f2fs.rst |  6 +++---
> >   fs/f2fs/super.c                    | 26 ++++++++++++++------------
> >   2 files changed, 17 insertions(+), 15 deletions(-)
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
> > index 56696f6cfa86..d8603e6c4916 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -145,6 +145,7 @@ enum {
> >       Opt_checkpoint_disable_cap_perc,
> >       Opt_checkpoint_enable,
> >       Opt_checkpoint_merge,
> > +     Opt_nocheckpoint_merge,
> >       Opt_compress_algorithm,
> >       Opt_compress_log_size,
> >       Opt_compress_extension,
> > @@ -215,7 +216,8 @@ static match_table_t f2fs_tokens =3D {
> >       {Opt_checkpoint_disable_cap, "checkpoint=3Ddisable:%u"},
> >       {Opt_checkpoint_disable_cap_perc, "checkpoint=3Ddisable:%u%%"},
> >       {Opt_checkpoint_enable, "checkpoint=3Denable"},
> > -     {Opt_checkpoint_merge, "checkpoint=3Dmerge"},
> > +     {Opt_checkpoint_merge, "checkpoint_merge"},
> > +     {Opt_nocheckpoint_merge, "nocheckpoint_merge"},
> >       {Opt_compress_algorithm, "compress_algorithm=3D%s"},
> >       {Opt_compress_log_size, "compress_log_size=3D%u"},
> >       {Opt_compress_extension, "compress_extension=3D%s"},
> > @@ -946,6 +948,9 @@ static int parse_options(struct super_block *sb, ch=
ar *options, bool is_remount)
> >               case Opt_checkpoint_merge:
> >                       set_opt(sbi, MERGE_CHECKPOINT);
> >                       break;
> > +             case Opt_nocheckpoint_merge:
> > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > +                     break;
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> >               case Opt_compress_algorithm:
> >                       if (!f2fs_sb_has_compression(sbi)) {
> > @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb,=
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
> > @@ -1782,7 +1781,7 @@ static int f2fs_show_options(struct seq_file *seq=
, struct dentry *root)
> >               seq_printf(seq, ",checkpoint=3Ddisable:%u",
> >                               F2FS_OPTION(sbi).unusable_cap);
> >       if (test_opt(sbi, MERGE_CHECKPOINT))
> > -             seq_puts(seq, ",checkpoint=3Dmerge");
> > +             seq_puts(seq, ",checkpoint_merge");
>
> Other noxxx options will be shown in show_options(), how about following =
them?
>
> >       if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_POSIX)
> >               seq_printf(seq, ",fsync_mode=3D%s", "posix");
> >       else if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> > @@ -1827,6 +1826,7 @@ static void default_options(struct f2fs_sb_info *=
sbi)
> >       sbi->sb->s_flags |=3D SB_LAZYTIME;
> >       set_opt(sbi, FLUSH_MERGE);
> >       set_opt(sbi, DISCARD);
> > +     clear_opt(sbi, MERGE_CHECKPOINT);
>
> Why should we clear checkpoint_merge option in default_options()?
>
> Thanks,
>
> >       if (f2fs_sb_has_blkzoned(sbi))
> >               F2FS_OPTION(sbi).fs_mode =3D FS_MODE_LFS;
> >       else
> > @@ -2066,9 +2066,8 @@ static int f2fs_remount(struct super_block *sb, i=
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
> > @@ -2076,6 +2075,8 @@ static int f2fs_remount(struct super_block *sb, i=
nt *flags, char *data)
> >                           err);
> >                       goto restore_gc;
> >               }
> > +     } else {
> > +             f2fs_stop_ckpt_thread(sbi);
> >       }
> >
> >       /*
> > @@ -3831,7 +3832,8 @@ static int f2fs_fill_super(struct super_block *sb=
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
