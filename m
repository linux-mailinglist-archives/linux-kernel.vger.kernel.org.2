Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC09030A861
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhBANMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBANMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:12:12 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D03C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:11:31 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f2so19474372ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZBg5DGHXau4A2AR5uVxrHKMoYL9lpKJv6v+HASZfsoI=;
        b=dgVqUWYOmnLGptFmKmn3LgQnDrYUa2N/HlrTFBWCjoXAljYn3K9EeixcbTOFGc+6oj
         XuGGE/YFDzOpyW0q3ooJIRlQPz8MMumDSOjwvNCC4FuZRUudyQUJiiaYBarz1o/Lcs7y
         3x+StsdVrKB36dgoR4BKqr2THokj8Sj2/HSZ4d5rhtr83clGPj3puoe7E5zhIR1I9TuW
         eSa0VtMB9DAf3WOQnvJAe7pTdfeuW/FZxM3w/0IvuRFSRiYntxFdThcsCr1JT0Wt/zWF
         118LeJGhUtlBDYqeyyYoXLV/QkfhJopEXpBd9hQ1D8AqiLnkbd5fp4XkXqxPFa8aWxBV
         qT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZBg5DGHXau4A2AR5uVxrHKMoYL9lpKJv6v+HASZfsoI=;
        b=LL/miPh+s8FbH6gnOSMLEbNkxU+LILAwCVU6Dx5MF4my2XW+J1whLjun0m5bULNIHS
         W7gnk7ceqV03S9QZZAtdSd8bxGOmvV1YfAyYP05Ziry6eD+BQcrVOZ/jziJ2mA9JItbt
         BGOI2zq7js3KBQAwno2etykcSzpOKlf8croW5j1d/DvPz19WS8s+d+iVi2vYvXdtZIUw
         N2zhdSy+X5NOcRTkGs9aEzeaALi/oqSp7qJvb5nQoRqkBZrga6Vnt5qGBrLHVqtvjydJ
         PoFi65UywnceqKy4UbL97xH8EgKa5XizwzQaS0+EEYns5pMqqv48prXvQXsE1MJUwU+w
         HInw==
X-Gm-Message-State: AOAM530mJrdNT0RxTRRxcxMa82F8BhGXVthcvZADNo/AYKlzhIeWC5c3
        PsuReW3uMcI5CBK/qEl3qS9q/VPIcXusKGGkBvs=
X-Google-Smtp-Source: ABdhPJz6gAYFrEmDqDihjtfxmFigHRqoAecV4tJ0gMa4onzo4iLumtU/Yt6+A9HfVbvrv9fSJlWpwhgLgvhunptG3+c=
X-Received: by 2002:a2e:a366:: with SMTP id i6mr10208319ljn.21.1612185090071;
 Mon, 01 Feb 2021 05:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20210201000606.2206740-1-daeho43@gmail.com> <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
In-Reply-To: <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 1 Feb 2021 22:11:18 +0900
Message-ID: <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix checkpoint mount option wrong combination
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I think we need to select one among them, disable, enable
and merge. I realized my previous understanding about that was wrong.
In that case of "checkpoint=3Dmerge,checkpoint=3Denable", the last option
will override the ones before that.
This is how the other mount options like fsync_mode, whint_mode and etc.
So, the answer will be "checkpoint=3Denable". What do you think?



2021=EB=85=84 2=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:40, Ch=
ao Yu <chao@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021/2/1 8:06, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > As checkpoint=3Dmerge comes in, mount option setting related to
> > checkpoint had been mixed up. Fixed it.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/super.c | 11 +++++------
> >   1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 56696f6cfa86..8231c888c772 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -930,20 +930,25 @@ static int parse_options(struct super_block *sb, =
char *options, bool is_remount)
> >                               return -EINVAL;
> >                       F2FS_OPTION(sbi).unusable_cap_perc =3D arg;
> >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> >                       break;
> >               case Opt_checkpoint_disable_cap:
> >                       if (args->from && match_int(args, &arg))
> >                               return -EINVAL;
> >                       F2FS_OPTION(sbi).unusable_cap =3D arg;
> >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> >                       break;
> >               case Opt_checkpoint_disable:
> >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> >                       break;
> >               case Opt_checkpoint_enable:
> >                       clear_opt(sbi, DISABLE_CHECKPOINT);
> > +                     clear_opt(sbi, MERGE_CHECKPOINT);
>
> What if: -o checkpoint=3Dmerge,checkpoint=3Denable
>
> Can you please explain the rule of merge/disable/enable combination and t=
heir
> result? e.g.
> checkpoint=3Dmerge,checkpoint=3Denable
> checkpoint=3Denable,checkpoint=3Dmerge
> checkpoint=3Dmerge,checkpoint=3Ddisable
> checkpoint=3Ddisable,checkpoint=3Dmerge
>
> If the rule/result is clear, it should be documented.
>
> Thanks,
>
>
> >                       break;
> >               case Opt_checkpoint_merge:
> > +                     clear_opt(sbi, DISABLE_CHECKPOINT);
> >                       set_opt(sbi, MERGE_CHECKPOINT);
> >                       break;
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION
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
> >
