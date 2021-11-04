Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED049444FBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 08:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKDHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 03:38:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBE3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 00:35:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f8so18258818edy.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkZPWkcdepIuZo7m0/533Igkr9SAQLK/i8PmfbIafTs=;
        b=RZ1mIsBX2B5iiKW33Ms55dq6bCbcofRa4BEKyKeUVX8dawsMuR9uQ+5egTuzFzqUMZ
         XGnVjCXALSeqTwJ/i4s6T/4s9C6ulISyfX6c2v0lupMH/Nc0e9Ss4Zq1yvB6saC1NU0t
         NVh263p5XkK+P1PmtSVNm7/M1GDKqr9Vd1gOTFzEt2YIblWOocS+9eSE2KxmUsX06HoC
         gaSqpRfQ+BuFhtdpMXZzbn8p7hkVIvek8ecgBhbBrylDxpSxhre9HqxB1N5/sbDNdPLS
         ompN9XZunFsU9RPIlPMycZjGGG7n6aMCflv6UTcaYh7oK5jUnObe7BQyzhPxfNyu+XZO
         SO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkZPWkcdepIuZo7m0/533Igkr9SAQLK/i8PmfbIafTs=;
        b=ZO/4waWEOvcHHJGXI7e7rs5H/g+vAn8rNuX1weV7SBVthD3yA57eOK3A34U2Zj4fOc
         YwHt+Va4iqzq0BfYy2/viI/zlD+YAzu1wgXZqsP+OLUgGnZ/z6XPVFtUBYQn7kA0qgSw
         Su22SmPFs6RVa6v/QbDE8/PHJLfI+gJbn8z/qNyKtRO3IGRE5fV6LgbHqCwv4lFiVPPX
         jdFKqIKiCmcBYHbAA1Xno8d+OA9+hJgV2cQs+hbbWYh1Vr4EYJD+fzsV4i8ut1CbBQl1
         hXAyp5fLaCJCaTGG20KY6phG2Q/X+mWteI11xBm2XPk5zelIWCp7jAoaAjFW4DFopNmo
         b2Jw==
X-Gm-Message-State: AOAM531A0iAUI3dD2x3XZLvJF98iMgHDUl1Ppsk+vvsE3+rUxxtdpV3b
        pbyBwCwpKY3EeZh9d4f8zm633l7/RooRMomnSHk=
X-Google-Smtp-Source: ABdhPJzGY2xuGJJWHXYPhzEDFln+ygLq5IoLRcxHXVEFymXekm4J5416Aal05F91IRbzHf+K6Pa9WzZHBLE8uKWC23c=
X-Received: by 2002:a05:6402:5109:: with SMTP id m9mr15208877edd.15.1636011350318;
 Thu, 04 Nov 2021 00:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211103142228.1235864-1-mudongliangabcd@gmail.com> <bff77e5c-7e14-32c5-6ffe-78e35271532b@kernel.org>
In-Reply-To: <bff77e5c-7e14-32c5-6ffe-78e35271532b@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 4 Nov 2021 15:35:24 +0800
Message-ID: <CAD-N9QVq4Lc3gEe8yZw3bBWo3Yzf=K_+KXDratJp=oyXhS_gPg@mail.gmail.com>
Subject: Re: [PATCH] fs: f2fs: fix UAF in f2fs_available_free_memory
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 3:16 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/11/3 22:22, Dongliang Mu wrote:
> > f2fs_fill_super
> > -> f2fs_build_segment_manager
> >     -> create_discard_cmd_control
> >        -> f2fs_start_discard_thread
> >
> > It invokes kthread_run to create a thread and run issue_discard_thread.
> >
> > However, if f2fs_build_node_manager fails, the control flow goes to
> > free_nm and calls f2fs_destroy_node_manager. This function will free
> > sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
> > after the deallocation, but before the f2fs_stop_discard_thread, it will
> > cause UAF(Use-after-free).
> >
> > -> f2fs_destroy_segment_manager
> >     -> destroy_discard_cmd_control
> >        -> f2fs_stop_discard_thread
> >
> > Fix this by switching the order of f2fs_build_segment_manager
> > and f2fs_build_node_manager.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/f2fs/super.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 78ebc306ee2b..1a23b64cfb74 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -4135,18 +4135,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >       }
> >
> >       /* setup f2fs internal modules */
> > -     err = f2fs_build_segment_manager(sbi);
> > -     if (err) {
> > -             f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> > -                      err);
> > -             goto free_sm;
> > -     }
> >       err = f2fs_build_node_manager(sbi);
> >       if (err) {
> >               f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
> >                        err);
> >               goto free_nm;
> >       }
> > +     err = f2fs_build_segment_manager(sbi);
> > +     if (err) {
> > +             f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> > +                      err);
> > +             goto free_sm;
> > +     }
> >
> >       /* For write statistics */
> >       sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
> > @@ -4351,10 +4351,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >       sbi->node_inode = NULL;
> >   free_stats:
> >       f2fs_destroy_stats(sbi);
> > -free_nm:
> > -     f2fs_destroy_node_manager(sbi);
> >   free_sm:
> >       f2fs_destroy_segment_manager(sbi);
> > +free_nm:
> > +     f2fs_destroy_node_manager(sbi);
>
> IIRC, above two functions shouldn't not be called reversely due to some
> resource dependency, Jaegeuk, please help to confirm this.
>
> So I suggest to call destroy_discard_cmd_control() before
> f2fs_destroy_node_manager(), is it fine to you?

Maybe f2fs_stop_discard_thread is better than
destroy_discard_cmd_control. It only stops the kthread, leading to
fewer side effects.

How do you think?

>
> Thanks,
>
> >       f2fs_destroy_post_read_wq(sbi);
> >   stop_ckpt_thread:
> >       f2fs_stop_ckpt_thread(sbi);
> >
