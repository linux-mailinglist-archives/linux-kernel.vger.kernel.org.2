Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868BB30B176
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhBAUMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhBAUMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:12:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8EC464DDB;
        Mon,  1 Feb 2021 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612210285;
        bh=SVk6wZfqxxsHCXT7WOr31/Z4hljLQRXiUCLq5W0mmSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkukJlKbzFq/tYjOL1ZqZSLmh7lX2Thorgufxc0WYAbW3R7aZTGNe+Vpb/NfFchlH
         owWBvBmQlPdbZ/aO5GFvwp3WpSu7yMg0aZ7WMQr1Kwj75fyybr32V/kbj5zbBaBmWB
         TyBhDGD0MgMkxZhylgIFozuGIOCZHnnq270cl7i1o7ghQFTNospWZzls7twhCeMcuw
         Vdqgu6uoUrgcG7EbOseFXJSYx3jLiIi/YcyTk8+6vcSO+GeDCBDQnqJYLpkhDQ2MZP
         zP1D7vOBDeKOQm09LMEelEWgwE3yEbaQo+EIwd0HXnpppwv1veocvfQI9FGiH5X8EB
         xGNCbxodaqP0w==
Date:   Mon, 1 Feb 2021 12:11:23 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix checkpoint mount option wrong
 combination
Message-ID: <YBhga9OJPcRa7ntk@google.com>
References: <20210201000606.2206740-1-daeho43@gmail.com>
 <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
 <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Daeho Jeong wrote:
> Actually, I think we need to select one among them, disable, enable
> and merge. I realized my previous understanding about that was wrong.
> In that case of "checkpoint=merge,checkpoint=enable", the last option
> will override the ones before that.
> This is how the other mount options like fsync_mode, whint_mode and etc.
> So, the answer will be "checkpoint=enable". What do you think?

We need to clarify a bit more. :)

mount checkpoint=disable,checkpoint=merge
remount checkpoint=enable,checkpoint=merge

Then, is it going to enable checkpoint with a thread?

> 
> 
> 
> 2021년 2월 1일 (월) 오후 9:40, Chao Yu <chao@kernel.org>님이 작성:
> >
> > On 2021/2/1 8:06, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > As checkpoint=merge comes in, mount option setting related to
> > > checkpoint had been mixed up. Fixed it.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >   fs/f2fs/super.c | 11 +++++------
> > >   1 file changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 56696f6cfa86..8231c888c772 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -930,20 +930,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> > >                               return -EINVAL;
> > >                       F2FS_OPTION(sbi).unusable_cap_perc = arg;
> > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > >                       break;
> > >               case Opt_checkpoint_disable_cap:
> > >                       if (args->from && match_int(args, &arg))
> > >                               return -EINVAL;
> > >                       F2FS_OPTION(sbi).unusable_cap = arg;
> > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > >                       break;
> > >               case Opt_checkpoint_disable:
> > >                       set_opt(sbi, DISABLE_CHECKPOINT);
> > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> > >                       break;
> > >               case Opt_checkpoint_enable:
> > >                       clear_opt(sbi, DISABLE_CHECKPOINT);
> > > +                     clear_opt(sbi, MERGE_CHECKPOINT);
> >
> > What if: -o checkpoint=merge,checkpoint=enable
> >
> > Can you please explain the rule of merge/disable/enable combination and their
> > result? e.g.
> > checkpoint=merge,checkpoint=enable
> > checkpoint=enable,checkpoint=merge
> > checkpoint=merge,checkpoint=disable
> > checkpoint=disable,checkpoint=merge
> >
> > If the rule/result is clear, it should be documented.
> >
> > Thanks,
> >
> >
> > >                       break;
> > >               case Opt_checkpoint_merge:
> > > +                     clear_opt(sbi, DISABLE_CHECKPOINT);
> > >                       set_opt(sbi, MERGE_CHECKPOINT);
> > >                       break;
> > >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> > > @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> > >               return -EINVAL;
> > >       }
> > >
> > > -     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> > > -                     test_opt(sbi, MERGE_CHECKPOINT)) {
> > > -             f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       /* Not pass down write hints if the number of active logs is lesser
> > >        * than NR_CURSEG_PERSIST_TYPE.
> > >        */
> > >
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
