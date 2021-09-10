Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724FC406E23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhIJP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhIJP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:26:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:24:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p15so3789247ljn.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZjKxxJhljDYpS5pxLUIvBKfKDGClyt9lfbrixdEiN4=;
        b=CZk4eHjRRB0S9IDx1rrvd74xMZaLkjNkabIbLnVpAD5dYl1SUSxOxZs+Yyz4LS2dMj
         6Lfmu9lfrmJ+1/KsSIOPy5baFmFjfnMjUK+pW3Mi5+0/ifGafMfzw8iWZ/WSyX1DhB41
         XNMftHbTzzlwa1mAJUW0m1RgL52Kcjg4K6MfALvHsiOUBVwDxbAXLzVR0/79zrqh9PGv
         54UeGbiPKNYtvbZOzCcNhQYfxyJnFjO63aikC+ijKSjptGbD8qM2w6rU11pGccdhHaj+
         zO+zDBFqNNMGU/T8DfCmQgXhNUVggWpq6+GIpAWQRJbh9zZlVom1NUGPKUp7hmWqYJUu
         f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZjKxxJhljDYpS5pxLUIvBKfKDGClyt9lfbrixdEiN4=;
        b=4fTpjFY1cutriv2dzSkjfV75rkghdgGzpRW1in6JywFLLxg6bKDlKzenhLxwyYM0fm
         2y6T2W8JrQb6MeWI3HupqvxShmmj8OFMfLW8mTahZP+r/RbpdHHzWO+MVcMzKXn0w1Wd
         6gv6JOLE0MiWhFNihcCDpaQWk8Nxrwbe14DRD/qmD/oK5H7ayEEwLsVVLv/JpjDP3Adc
         Fi9B9MhNObB1n58bdxzwgMpYu6JoDBfmFIJflmvoWydLTDoA0q7uQHRDS3P3nYEyTwO5
         kC41jt+nKL/XbvJu0Ruwx6v5CzL9V2vJjLwtJ8CCwRZTubm/UUVZWy3pLHpMSZ+0z80o
         O4Vw==
X-Gm-Message-State: AOAM530dC3rA8TSgqvn+FFbKCF3vm2Pj5x+3fp5WOxg64hz1WePx43pb
        3yls6PIX2bed6MNYTbFmU9a6GgSb+R8vB+j1PW4=
X-Google-Smtp-Source: ABdhPJzmV9HMQrYPGkgG2aWLS9B2OTLtQ7N720iigCvWL3xhTZlgn8ddrP3+7jnZSJJVHrjQSlCp0YddqRNbPvFLS3Q=
X-Received: by 2002:a05:651c:88e:: with SMTP id d14mr4541154ljq.472.1631287493966;
 Fri, 10 Sep 2021 08:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com> <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org> <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org> <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
 <a59d23b9-961f-4129-7491-59f88923366a@kernel.org> <CACOAw_z+yfNN3p3U3Ji0vLe7xDP4vkVy11RdzwwcRwwnSTjsFg@mail.gmail.com>
In-Reply-To: <CACOAw_z+yfNN3p3U3Ji0vLe7xDP4vkVy11RdzwwcRwwnSTjsFg@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 10 Sep 2021 08:24:42 -0700
Message-ID: <CACOAw_y24AdH2Mpx4uhYbhmHnVRtUU2_4USUmi0Q61HGtE95RA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 7:34 AM Daeho Jeong <daeho43@gmail.com> wrote:
>
> On Thu, Sep 9, 2021 at 4:50 PM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2021/9/8 2:12, Daeho Jeong wrote:
> > > On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
> > >>
> > >> On 2021/9/4 12:40, Daeho Jeong wrote:
> > >>>> As a per curseg field.
> > >>>>
> > >>>>> Maybe, we run into the same race condition issue you told before for
> > >>>>> fragment_remained_chunk.
> > >>>>> Could you clarify this more?
> > >>>>
> > >>>> e.g.
> > >>>>
> > >>>> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
> > >>>> fragment_chunk_size = 384
> > >>>> fragment_hole_size = 384
> > >>>>
> > >>>> When creating hole:
> > >>>>
> > >>>> - f2fs_allocate_data_block
> > >>>>     - __refresh_next_blkoff
> > >>>>       chunk locates in [0, 383] of current segment
> > >>>>       seg->next_blkoff = 384
> > >>>>       sbi->fragment_remained_chunk = 0
> > >>>>       then we will reset sbi->fragment_remained_chunk to 384
> > >>>>       and move seg->next_blkoff forward to 768 (384 + 384)
> > >>>>     - __has_curseg_space() returns false
> > >>>>     - allocate_segment() allocates new current segment
> > >>>>
> > >>>> So, for such case that hole may cross two segments, hole size may be truncated
> > >>>> to left size of previous segment.
> > >>>
> > >>> First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
> > >>
> > >> Oh, correct.
> > >>
> > >>> I understand what you mean, so you mean we need to take the leftover
> > >>> "hole" size over to the next segment?
> > >>> In the example, the leftover hole size will be (384 - (512-384)). Do
> > >>> you want to take this over to the next segment?
> > >>
> > >> Yes, the left 256 block-sized hole should be created before next chunk
> > >> in next opened segment.
> > >>
> > >
> > > Chao,
> > >
> > > Do you have any decent idea to pass the left hole size to the next
> > > segment which will be allocated?
> >
> > Daeho,
> >
> > I guess we can record left hole size in seg->fragment_remained_hole.
> >
>
> I understand we need a new fragment_remained_hole variable in segment structure.
> But, I mean.. How can we pass over the left hole size from the
> previous segment to the next segment?
>

I mean we don't know which segment will be the next segment, do we?

> Thanks,
>
> > Thanks,
> >
> > >
> > > Thanks,
> > >
> > >> Thanks,
> > >>
> > >>>
