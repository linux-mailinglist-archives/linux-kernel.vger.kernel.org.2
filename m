Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4562943683D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJUQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhJUQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:47:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCFC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:44:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x192so1505599lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSAcocb1DpnBRWVfk8RW3057aiiYng+OMM3MbVC7Tos=;
        b=kS5wsvBUxmJmOtn1/RXJwN3TZzeP3kBEraI2Yit+v+QTjMaxkrnthAm0qhawJY03Lb
         4x86yMCxq3DEQBcQF0sIhsa/2niqUCWDRmRL5osvkWllWWuXwTD+3/q1S5Y/RGwja1Jm
         DNkpT90I+HzdkMcRA1uV0Ar4d77vXPRignToKaNB6tvCgaxYGWagqvQ0ecdbhBtzs7X/
         zF7RQ2XxYIMy4WCSto4wNexakV+/z7KjYgQ8BPjKjBq9hUuK3Vin1hVTtLz0EabDbx2f
         Yfvqih+WQRVcB1sEau3rkLxnSI7WPGVicVDOOYT3pO5pzIyHtqnv0EReNYb4XGwotTkK
         1Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSAcocb1DpnBRWVfk8RW3057aiiYng+OMM3MbVC7Tos=;
        b=vB4vPDkXE4aOjElnCgy3qDezJjq2MIGKo1Vp1g2l1dG9pQq0Be4uYyLskVTBJW/uq1
         nChUE/u7ehB26DaiTlBlgodlJXQvnuYaihwO6hXG0EtwUNx152UdsBWpL0itCZb5mEGd
         czWgnUe1HprbfGX2CpE8pUX47p17v4QzJzRO+ieENi6kETQed87JPVhTtoRsLDpDMxcv
         kjlrhHgTiG6pU6x+Ov66uzXtnapnMLN2yFLzRzynWGPBt90kPSOACUC11VzzIwjH/U/+
         r2WGuzBE22WGxcm7hhACu7AFHM4A0aINZrrPNOfGLNEMbR/7xHGN3ZAv0Sgu0C5FSm/v
         wkEA==
X-Gm-Message-State: AOAM531DLioBQjtpnmpoECNMemfVjv91vXhlT8nKndE6GtDm4knuo16s
        Jx6yUWRYoaPYN6wKuO46/WBfuSzo2rTF59fKY5yo/91M36Q=
X-Google-Smtp-Source: ABdhPJyRNBXjn9wxdZ7MbFFAfuc7SgOiEXEZ1NEqOg8ud6/szO1n+6DKtP3IvN6ZfsIux+0s0nXk159Jadl1pvhoQhY=
X-Received: by 2002:a19:6742:: with SMTP id e2mr6220633lfj.568.1634834684740;
 Thu, 21 Oct 2021 09:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211014190503.717830-1-daeho43@gmail.com> <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
In-Reply-To: <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 21 Oct 2021 09:44:33 -0700
Message-ID: <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock between sb_internal lock (sb_start_intwrite()) and
dquot related lock.
It's because we call f2fs_truncate(), which eventually calls
dquot_initialize(), while holding sb_internal lock.
So, I called dquot_initialize() in advance to make the 2nd calling of
it in f2fs_truncate() ineffective.
This is similar with the thing in f2fs_evict_inode() in inode.c

Thanks,

On Thu, Oct 21, 2021 at 5:11 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/10/15 3:05, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We detected the below circular locking dependency between sb_internal
> > and fs_reclaim. So, removed it by calling dquot_initialize() before
> > sb_start_intwrite().
> >
> >   ======================================================
> >   WARNING: possible circular locking dependency detected
> >   ------------------------------------------------------
> >   kswapd0/133 is trying to acquire lock:
> > ffffff80d5fb9680 (sb_internal#2){.+.+}-{0:0}, at: evict+0xd4/0x2f8
> >
> > but task is already holding lock:
> > ffffffda597c93a8 (fs_reclaim){+.+.}-{0:0}, at:
> > __fs_reclaim_acquire+0x4/0x50
> >
> > which lock already depends on the new lock.
> > ...
> > other info that might help us debug this:
> >
> >   Chain exists of:
> >
> > sb_internal#2 --> &s->s_dquot.dqio_sem --> fs_reclaim
> >
> >    Possible unsafe locking scenario:
> >
> >          CPU0                    CPU1
> >          ----                    ----
> >     lock(fs_reclaim);
> >                                  lock(&s->s_dquot.dqio_sem);
> >                                  lock(fs_reclaim);
> >     lock(sb_internal#2);
>
> Sorry, I still didn't get the root cause of this deadlock issue, could
> you please explain more about this?
>
> And why calling dquot_initialize() in drop_inode() could break the
> circular locking dependency?
>
> Thanks,
>
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/super.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 86eeb019cc52..a133932333c5 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1370,6 +1370,8 @@ static int f2fs_drop_inode(struct inode *inode)
> >                       /* should remain fi->extent_tree for writepage */
> >                       f2fs_destroy_extent_node(inode);
> >
> > +                     dquot_initialize(inode);
> > +
> >                       sb_start_intwrite(inode->i_sb);
> >                       f2fs_i_size_write(inode, 0);
> >
> >
