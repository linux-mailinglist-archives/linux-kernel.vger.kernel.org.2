Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDD30B39D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBAXeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAXeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:34:07 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6673C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:33:26 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x21so19350536iog.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAFqh/lDI2QEzpZGleo/NCpCzManWthLMflN8iWmGMA=;
        b=inT9UQh+qT9gwrScoEp/qa0i07HM6L5O2pDIkBQhSQjrR2RmT5M0iL3djd4i8aq5Xf
         OvcVBl5oefL1G+0C4fXzKbg3Jt1n+UxFw+q8Au8yeXUgGU4BdzduzFBrDAHeRcJYqZsd
         O7M/hX0AgGivjgiqwCeldXZFYdp8IYDpUqdWlBhF7bXpCOFA9yL11XHGMv9ccspjh6YZ
         7fLGv0RIcNsTpls6d+UvvNNxoIqhUs0CVCTaL0hQfTDj2oRcLAEOK6g+ixYhyuJxyYhe
         tbGJ5aCZSrcL3Lcw+s/Qbs5G6luhlm4Cu0xPPxbfHt4DpMWPC9Qh+7hnDcuKIXejE4Ed
         waMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAFqh/lDI2QEzpZGleo/NCpCzManWthLMflN8iWmGMA=;
        b=TLjzrmxVmY73rkagskW7I0D/64fME5aIdninIjx/z993LnfBXJi/1qHdejZNLmwwZy
         Gwk2kezR2XkTTs3V2QIJ2xiKn7XSrqi0cx996FJO7vfx8WuUogcLB2YKb912PAOjBgUy
         XFFXmh4/4UO79g8qIWO3FHxbczJ/DF2uKwxDuBXyUjqLIAvRvauXhD36gDH8LbWi8zr8
         tRc9B9b/9Er5Z/Yc6gkWmuFWhsvoCbgzk17VcgaWwWpoFrO+hh7kjFbJOcUoVEaE+ggi
         lSlZI6aGbXFrgSBoGAbkAMH+Nom7Ca+DXtbw6wqnk2acm4Rw+fyQ93Re1m6mQYeyHZ9u
         za4A==
X-Gm-Message-State: AOAM530qUw0vGXGn9UvN1cJLGNXHKYB2Ez/l9uxpwQ1E1u6PtqaXao88
        gASpykGW6R/CG0zWpGBwDbyHODSSbWwKMdzFbIU=
X-Google-Smtp-Source: ABdhPJyWQPyIk4/BbtnFvVjja6hU1GYdXYaoVbloXOz7rMPXQLLx0vBZ/CVhDLeIRzONWeL9XK2G5yDCq2H1OIjXQxM=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr14339795iog.27.1612222406071;
 Mon, 01 Feb 2021 15:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20210201000606.2206740-1-daeho43@gmail.com> <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
 <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com> <YBhga9OJPcRa7ntk@google.com>
In-Reply-To: <YBhga9OJPcRa7ntk@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 2 Feb 2021 08:33:13 +0900
Message-ID: <CACOAw_xW1NM4bXdzkFi7ee-OuZJ093Kz+-Zbk0huwAFHafXvbw@mail.gmail.com>
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

The rightmost one is the final option. And checkpoint=3Dmerge means
checkpoint is enabled with a checkpoint thread.

mount checkpoint=3Ddisable,checkpoint=3Dmerge =3D> checkpoint=3Dmerge
remount checkpoint=3Denable,checkpoint=3Dmerge =3D> checkpoint=3Dmerge
remount checkpoint=3Dmerge,checkpoint=3Ddisable =3D> checkpoint=3Ddisable
remount checkpoint=3Dmerge,checkpoint=3Denable =3D> checkpoint=3Denable

Like

mount fsync_mode=3Dposix, fsync_mode=3Dstrict, fsync_mode=3Dnobarrier =3D>
fsync_mode=3Dnobarrier

2021=EB=85=84 2=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 5:11, Ja=
egeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 02/01, Daeho Jeong wrote:
> > Actually, I think we need to select one among them, disable, enable
> > and merge. I realized my previous understanding about that was wrong.
> > In that case of "checkpoint=3Dmerge,checkpoint=3Denable", the last opti=
on
> > will override the ones before that.
> > This is how the other mount options like fsync_mode, whint_mode and etc=
.
> > So, the answer will be "checkpoint=3Denable". What do you think?
>
> We need to clarify a bit more. :)
>
> mount checkpoint=3Ddisable,checkpoint=3Dmerge
> remount checkpoint=3Denable,checkpoint=3Dmerge
>
> Then, is it going to enable checkpoint with a thread?
>
> >
> >
> >
> > 2021=EB=85=84 2=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:40=
, Chao Yu <chao@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On 2021/2/1 8:06, Daeho Jeong wrote:
> > > > From: Daeho Jeong <daehojeong@google.com>
> > > >
> > > > As checkpoint=3Dmerge comes in, mount option setting related to
> > > > checkpoint had been mixed up. Fixed it.
> > > >
> > > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > > ---
> > > >   fs/f2fs/super.c | 11 +++++------
> > > >   1 file changed, 5 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > index 56696f6cfa86..8231c888c772 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -930,20 +930,25 @@ static int parse_options(struct super_block *=
sb, char *options, bool is_remount)
> > > >                               return -EINVAL;
> > > >                       F2FS_OPTION(sbi).unusable_cap_perc =3D arg;
> > > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > >                       break;
> > > >               case Opt_checkpoint_disable_cap:
> > > >                       if (args->from && match_int(args, &arg))
> > > >                               return -EINVAL;
> > > >                       F2FS_OPTION(sbi).unusable_cap =3D arg;
> > > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > >                       break;
> > > >               case Opt_checkpoint_disable:
> > > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > > >                       break;
> > > >               case Opt_checkpoint_enable:
> > > >                       clear_opt(sbi, DISABLE_CHECKPOINT);
> > > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > >
> > > What if: -o checkpoint=3Dmerge,checkpoint=3Denable
> > >
> > > Can you please explain the rule of merge/disable/enable combination a=
nd their
> > > result? e.g.
> > > checkpoint=3Dmerge,checkpoint=3Denable
> > > checkpoint=3Denable,checkpoint=3Dmerge
> > > checkpoint=3Dmerge,checkpoint=3Ddisable
> > > checkpoint=3Ddisable,checkpoint=3Dmerge
> > >
> > > If the rule/result is clear, it should be documented.
> > >
> > > Thanks,
> > >
> > >
> > > >                       break;
> > > >               case Opt_checkpoint_merge:
> > > > +                     clear_opt(sbi, DISABLE_CHECKPOINT);
> > > >                       set_opt(sbi, MERGE_CHECKPOINT);
> > > >                       break;
> > > >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> > > > @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block =
*sb, char *options, bool is_remount)
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> > > > -                     test_opt(sbi, MERGE_CHECKPOINT)) {
> > > > -             f2fs_err(sbi, "checkpoint=3Dmerge cannot be used with=
 checkpoint=3Ddisable\n");
> > > > -             return -EINVAL;
> > > > -     }
> > > > -
> > > >       /* Not pass down write hints if the number of active logs is =
lesser
> > > >        * than NR_CURSEG_PERSIST_TYPE.
> > > >        */
> > > >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
