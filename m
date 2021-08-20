Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5913F2F66
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbhHTP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbhHTP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:27:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9E5C0613A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:23:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u22so21272635lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmlIpUuRl+AQl6NHORx2uksaHk6e1Bkml3gkzzdbETU=;
        b=lfsgunIBPvh1N2HMfHLuTu6bb4D3MC64EfdWNwsp5/I6e9+sfnYHnIciUn9iZmjfE0
         RpMGbkMBlb41YT2k/VuMPHP5HH0vI1ft3AxZAqjXqSV2D48lo2PyvBqf1WE8groFrbSz
         piCHKr+s5jQ3BOWinXhcxtVn97Y2iAAcvrQ+yyehKq2a2l3LGlvs/TU3UNUT3xIayr0A
         upenWwnnUkAajCqzvvSGk9T7fSjgoGzVxrO0LYkz2bj/FByEg0EKheI4pi9b07cRPfpH
         SnvrUc9FNOeQ6o8yxGKnMLHduaRcnUfRnEr9uicYa2qgy2arR6dkRInN0Y84ycx9HbD7
         Hczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmlIpUuRl+AQl6NHORx2uksaHk6e1Bkml3gkzzdbETU=;
        b=ca3OFHTPU2PqSzEUUDt9RbxJEOvESfYVM+GnPeBHzEFHltvygv9QAGItrSGNO29UaH
         Ytm5CnRqjRR7E8PxgQB2KDMc4IM8R+ttylRlnrM5AkMb7b+r8IEYdO3dHvnNfsqgvaZo
         H7GxIFERG4xNTdTGlWwgmo/2rhFLsxv9FrzJ8AdWbJaeawIlqXRgDM1hqh9la164yG3v
         k0divu40ZdTQXFM2ogt2j4xAKd/u9U7rTycENXt7yO4Slxe/wQZoBcDYlHonSBO2r+0g
         BNqs+BqWqhmK5EFucF4eTHcgxhSWpqBZbZMoHWBPqcrpKcneoqNGI5QLTiUDzF6jHN9H
         kVBg==
X-Gm-Message-State: AOAM533MAMAzZ+UbwAJ2wExTBqyAOmmtKxzl+ieKvGy8/0e00PTqowBr
        U+jUIRDPtKe629HcF7oIgqJW39whwZ7tG0ExrgE=
X-Google-Smtp-Source: ABdhPJyw8/e5A74C67qJGcTsZiZKzpB1smdk0k5v/GkqQliEF2YXs0kwLwrudgjmcfMsEXbeJCSQEaghgLDo4wm0808=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr14978867lfm.622.1629472996150;
 Fri, 20 Aug 2021 08:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210820035229.216975-1-daeho43@gmail.com> <20210820035229.216975-2-daeho43@gmail.com>
 <48725f58-1a48-73f3-80cf-a0c5efc3b470@kernel.org>
In-Reply-To: <48725f58-1a48-73f3-80cf-a0c5efc3b470@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 20 Aug 2021 08:23:05 -0700
Message-ID: <CACOAw_xcwZN_H7_zi7iMJh9HpzXnPd67fNAcxhu5UUSmJk7c1Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: introduce periodic iostat io
 latency traces
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 3:50 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/8/20 11:52, Daeho Jeong wrote:
> > +void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
> > +{
> > +     struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> > +     int sync_type = bio->bi_opf & REQ_SYNC ? 0 : 1;
>
> int sync_type = bio->bi_opf & REQ_SYNC ? 1 : 0;
>
> Right?

This means just type, not boolean number. So, I set type 0 is sync and
type 1 is async.

>
> >   int f2fs_init_iostat(struct f2fs_sb_info *sbi)
> >   {
> >       /* init iostat info */
> >       spin_lock_init(&sbi->iostat_lock);
> > +     spin_lock_init(&sbi->iostat_lat_lock);
> >       sbi->iostat_enable = false;
> >       sbi->iostat_period_ms = DEFAULT_IOSTAT_PERIOD_MS;
> > +     sbi->iostat_io_lat = f2fs_kzalloc(sbi, sizeof(struct iostat_lat_info),
> > +                                     GFP_KERNEL);
> > +     if (!sbi->iostat_io_lat)
> > +             return -ENOMEM;
>
> What do you think of just embedding iostat_io_lat structure into f2fs_sb_info
> structure? it's minor thing though.
>

I also wanted to do that, but if we embed this type, we need to define
that structure in f2fs.h file.
Is it okay with you?

> Thanks,
