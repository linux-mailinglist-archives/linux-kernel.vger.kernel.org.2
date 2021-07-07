Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2243BF147
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhGGVRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGGVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:17:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD08C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 14:14:34 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id k184so5351459ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loWkjzY4e1q1zoZHIoGMbkPYSZPWyE4TminLeGzRfZ0=;
        b=JYYnHEW7ZNH43ntTgEZBKHhzqpowBI6y3rHjrmF5uvkQzSK4HhKY0mp3BfQMD3/Me/
         6OXpZA7yQkqZkYGTvHRXjbdhgH8yUWMeVMJpNs13YFwpbsqeka2BQtk/TqKJe+7Mx9fj
         2pgDhA88Y7yo0+4F2gl69EALQnn5KkkyHqDfpPbOaeKXV0r+RxcDC49qXe9BXJ+0Hne3
         MrW64UATyDb00486dDYc2Lm6aktcqib+A4x3UUSTjrqjrN0DS5ytMkoOInQNvYIDgmG0
         ucPCheNEKs6Hnzo3s3bKKEuXk4xj70d1LmyhuXmaK+DF9djnGA2617HjbhhUOtMAFVc4
         uUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loWkjzY4e1q1zoZHIoGMbkPYSZPWyE4TminLeGzRfZ0=;
        b=eDrXvGvLatKzrKhPDvOkclKtpjDr7nY04kL7CNYFM729XBHwJd2+AerRJcD6wrUxOM
         PVoVfpqnfh1aRDfMXeu8Fsel2tYp1zoOW58FBTeb5FbD7P5jy8bq5ZDYJ1qrnlImLcQF
         vWPZDslav/+W/FTkpe2d/aFc3O4zsDWo7BUAUqRa3LpKM9AzqNGxXoVVxfigHPjVpux/
         aD8SCnjXl13E0rBBGoijDLVkPd98qXHcvmkBsBsOFMx5X/cJbwhIMlb6DUUIJyRkZI7L
         xFCCm+dDoWjxuyBKzshmWeNmuGfxa0AaNREVvrsmG30xQwWXCQuXOv6R4+MSwRRqwf/Y
         tBMw==
X-Gm-Message-State: AOAM530upAZEnlUwLdoc0u1Qd9f7/Q4RBPp6Y/XeX+cKMsHsnBT/rMPc
        JqHqVgJAoA3yZ8BSf8newZBS+hYVLNgEF1un02OjRQ==
X-Google-Smtp-Source: ABdhPJwM1mTHA+Yqp9+iHV/qUeiY6igQYDtZUXENSPDMhTdqNdCJj848vaMBr7B12VFjkhhekQQQBKu5fJF0P0TR+Gc=
X-Received: by 2002:a25:83ca:: with SMTP id v10mr35894945ybm.84.1625692473923;
 Wed, 07 Jul 2021 14:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALCETrU577MD59P-+9sMYtS3t2sZYx-zi=VirhQpZLnhEck1vg@mail.gmail.com>
 <CAJuCfpFMTP-g9CFELMqNawX0FhF4vBNtRDP_R=WAi_RiuGW8-Q@mail.gmail.com>
 <YNzl6XNu2vxyCJu8@cmpxchg.org> <CALCETrWsVw4+jT_Z1uxidRAZ0SQbngYe7E2m-8iyX6qRbug6zA@mail.gmail.com>
 <CAJuCfpG5Ua7C4usJGEqTm6_UUd6VyRd0BsPgT97LWOzjb4Ry+g@mail.gmail.com>
 <20210702152724.7fv5tnik4qlap6do@wittgenstein> <af8e76f1-6625-25d1-98d2-a3c8a9bf2fd6@redhat.com>
 <YOWcj0+P238W1y+t@dhcp22.suse.cz>
In-Reply-To: <YOWcj0+P238W1y+t@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 7 Jul 2021 14:14:23 -0700
Message-ID: <CAJuCfpH8QQyxivztkC2-_Kk1MqA0mJVs91XXpvVsL=NzNebshw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 5:38 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 05-07-21 09:41:54, David Hildenbrand wrote:
> > On 02.07.21 17:27, Christian Brauner wrote:
> [...]
> > > That one was my favorite from the list I gave too but maybe we can
> > > satisfy Andy too if we use one of:
> > > - process_mfree()
> > > - process_mrelease()
> > >
> >
> > FWIW, I tend to like process_mrelease(), due to the implied "release" ("free
> > the memory if there are no other references") semantics.
>
> Agreed.

Ok, sounds like process_mrelease() would be an acceptable compromise.

>
> > Further, a new
> > syscall feels cleaner than some magic sysfs/procfs toggle. Just my 2 cents.
>
> Yeah, proc based interface is both tricky to use and kinda ugly now that
> pidfd can solve all at in once.

Sounds good. Will keep it as is then.

> My original preference was a more generic kill syscall to allow flags
> but a dedicated syscall doesn't look really bad either.

Yeah, I have tried that direction unsuccessfully before arriving at
this one. Hopefully it represents the right compromise which can
satisfy everyone's usecase.

> --
> Michal Hocko
> SUSE Labs
