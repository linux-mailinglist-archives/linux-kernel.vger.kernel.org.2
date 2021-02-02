Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7330B440
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBBAmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhBBAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:42:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22151C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:41:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id e15so5296949lft.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SLf4YUT/WIzk5e1MjJoufGzuMgi4ERJsS94Tsuvs6D0=;
        b=CtYbQhuyL/QEy1OXjkO47o/XmSTAGGGnaUFEGAOhtFMYfsCfpvbVRvW/cjVRxMoT6E
         sOa83IdnpOmbOELiNP/0f60HJlhzmQ3zva2cfwpgqp5SO1kSysAtdZrG4Zlzn5NgW9rL
         JBn1NjpNK2bvwfVGwbNRl0iFsFvnHiPd5FGALWtmBt8ZgIg8whH3OSa4rTgHk479dlSr
         pYhQwUqkxTvy285CjpG1UK/pkv0aWSt5iEM4mpuW9ba3qFLN/0JL+AMOmBD0e9TbD/lg
         WPT+k6ZMNzOkgnROFYHyPwfZdXIWIhaxAO7ltQXyAzvXZ3BD/MpY1WiTLYAKo6770Vap
         1iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SLf4YUT/WIzk5e1MjJoufGzuMgi4ERJsS94Tsuvs6D0=;
        b=WETMWFiNAEtRJYkVvct8iDGi17juBQHy5134I2yoT7fPAjUUmNuspENeHGQhKJfaBv
         5BPln9Do4GSlg5B94ddDZztqKfXDI2ovwewTEm7JX0gOfb3F6GHWKZfljwItcvPPVK0O
         x5DmIEFLvDRsN/LRAKnDuRPBFpYTBCkGZDTz1DGJ2heURXhuV84Wunor7fL2cU6Gk5Ai
         9sWEYixeZstL3ZpSEIT/1Gy/NuOJQo89omF0J0I1YeHH1Oz8ybhEsw6Hehsf1YmGIULp
         qKL0qJs+ez2gQfMT773qML27LXXQYVl+rN4FWBl9oLVbqEpuJFSdskAEmkU6g+TIEylz
         U7ZQ==
X-Gm-Message-State: AOAM533+jEmIAGgVddSAh8hnCuaMFj/WmwhXhnHaUSobG/4q3e6LqSfe
        6NKE5ibaUukH6nTKMnafIkHoyOY6qvvcok24mPI=
X-Google-Smtp-Source: ABdhPJze8cXgBBahm+b/zMNTT7q7MVcKN3WtQhcCVbBF+3JL7jRx/9yGgjm0LnBxFEKZp72l7VXjH+DmgG5d6PXrrjQ=
X-Received: by 2002:a05:6512:3e6:: with SMTP id n6mr9838057lfq.139.1612226514583;
 Mon, 01 Feb 2021 16:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20210201000606.2206740-1-daeho43@gmail.com> <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
 <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com>
 <YBhga9OJPcRa7ntk@google.com> <CACOAw_xW1NM4bXdzkFi7ee-OuZJ093Kz+-Zbk0huwAFHafXvbw@mail.gmail.com>
In-Reply-To: <CACOAw_xW1NM4bXdzkFi7ee-OuZJ093Kz+-Zbk0huwAFHafXvbw@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 2 Feb 2021 09:41:43 +0900
Message-ID: <CACOAw_yqMnjN60F2q7eyWy6zaPK+pTVYheQeHteYhjEHDP-kJA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix checkpoint mount option wrong combination
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For less confusion, I am going to separate the "merge" option from
"checkpoint=3D".
I am adding another "ckpt_merge" option. :)

2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:33, Da=
eho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The rightmost one is the final option. And checkpoint=3Dmerge means
> checkpoint is enabled with a checkpoint thread.
>
> mount checkpoint=3Ddisable,checkpoint=3Dmerge =3D> checkpoint=3Dmerge
> remount checkpoint=3Denable,checkpoint=3Dmerge =3D> checkpoint=3Dmerge
> remount checkpoint=3Dmerge,checkpoint=3Ddisable =3D> checkpoint=3Ddisable
> remount checkpoint=3Dmerge,checkpoint=3Denable =3D> checkpoint=3Denable
>
> Like
>
> mount fsync_mode=3Dposix, fsync_mode=3Dstrict, fsync_mode=3Dnobarrier =3D=
>
> fsync_mode=3Dnobarrier
>
> 2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 5:11, =
Jaegeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On 02/01, Daeho Jeong wrote:
> > > Actually, I think we need to select one among them, disable, enable
> > > and merge. I realized my previous understanding about that was wrong.
> > > In that case of "checkpoint=3Dmerge,checkpoint=3Denable", the last op=
tion
> > > will override the ones before that.
> > > This is how the other mount options like fsync_mode, whint_mode and e=
tc.
> > > So, the answer will be "checkpoint=3Denable". What do you think?
> >
> > We need to clarify a bit more. :)
> >
> > mount checkpoint=3Ddisable,checkpoint=3Dmerge
> > remount checkpoint=3Denable,checkpoint=3Dmerge
> >
> > Then, is it going to enable checkpoint with a thread?
> >
> > >
> > >
> > >
> > > 2021=EB=85=84 2=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:=
40, Chao Yu <chao@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > >
> > > > On 2021/2/1 8:06, Daeho Jeong wrote:
> > > > > From: Daeho Jeong <daehojeong@google.com>
> > > > >
> > > > > As checkpoint=3Dmerge comes in, mount option setting related to
> > > > > checkpoint had been mixed up. Fixed it.
> > > > >
> > > > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > > > ---
> > > > >   fs/f2fs/super.c | 11 +++++------
> > > > >   1 file changed, 5 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > > index 56696f6cfa86..8231c888c772 100644
> > > > > --- a/fs/f2fs/super.c
> > > > > +++ b/fs/f2fs/super.c
> > > > > @@ -930,20 +930,25 @@ static int parse_options(struct super_block=
 *sb, char *options, bool is_remount)
> > > > >                               return -EINVAL;
> > > > >                       F2FS_OPTION(sbi).unusable_cap_perc =3D arg;
> > > > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > > >                       break;
> > > > >               case Opt_checkpoint_disable_cap:
> > > > >                       if (args->from && match_int(args, &arg))
> > > > >                               return -EINVAL;
> > > > >                       F2FS_OPTION(sbi).unusable_cap =3D arg;
> > > > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > > >                       break;
> > > > >               case Opt_checkpoint_disable:
> > > > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > > >                       break;
> > > > >               case Opt_checkpoint_enable:
> > > > >                       clear_opt(sbi, DISABLE_CHECKPOINT);
> > > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > >
> > > > What if: -o checkpoint=3Dmerge,checkpoint=3Denable
> > > >
> > > > Can you please explain the rule of merge/disable/enable combination=
 and their
> > > > result? e.g.
> > > > checkpoint=3Dmerge,checkpoint=3Denable
> > > > checkpoint=3Denable,checkpoint=3Dmerge
> > > > checkpoint=3Dmerge,checkpoint=3Ddisable
> > > > checkpoint=3Ddisable,checkpoint=3Dmerge
> > > >
> > > > If the rule/result is clear, it should be documented.
> > > >
> > > > Thanks,
> > > >
> > > >
> > > > >                       break;
> > > > >               case Opt_checkpoint_merge:
> > > > > +                     clear_opt(sbi, DISABLE_CHECKPOINT);
> > > > >                       set_opt(sbi, MERGE_CHECKPOINT);
> > > > >                       break;
> > > > >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> > > > > @@ -1142,12 +1147,6 @@ static int parse_options(struct super_bloc=
k *sb, char *options, bool is_remount)
> > > > >               return -EINVAL;
> > > > >       }
> > > > >
> > > > > -     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> > > > > -                     test_opt(sbi, MERGE_CHECKPOINT)) {
> > > > > -             f2fs_err(sbi, "checkpoint=3Dmerge cannot be used wi=
th checkpoint=3Ddisable\n");
> > > > > -             return -EINVAL;
> > > > > -     }
> > > > > -
> > > > >       /* Not pass down write hints if the number of active logs i=
s lesser
> > > > >        * than NR_CURSEG_PERSIST_TYPE.
> > > > >        */
> > > > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
