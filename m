Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6040044D8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhKKPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhKKPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:05:44 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E15C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:02:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 131so15760493ybc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8o29KaKbhMCf5wOHov2sGbl0/vltBBfTeJdXxiCu74=;
        b=HsvYfeCVvI5/oZKMA5QfP2HaOAjafm2PgfOucMtpC4Z2WgQ+21r8++32YHxr6ag0th
         wPchbTINVaBus5keieM66KJC3QJYOvJvQTMkpTHHhiKMTTj80z1O9L15a/NvemKlG1DS
         fWuFmoBGFfIgnluAzkwl7yYkorvdnfn1OqUJDt6WrFQVsvs9JdtwyZxrSL4+1WEglq3e
         v/G+dXaJtASdSR0AeJiviYyTzZDzdVtfg5yr/ZWOYt2GBXgmnbj+9F8NM6JpExg6doun
         otQGxjvR6DBTKL3YXBwS08XmTqQphs6i2nDb9y6j8TSDgA/ms5lPUQRPhE9otePLPqNr
         2Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8o29KaKbhMCf5wOHov2sGbl0/vltBBfTeJdXxiCu74=;
        b=P6V754bfjm89skUIF66arf0yvAXq/dcmAyI2+Pxn2ZC7Gwv6L0CkvCR7+tve2tAUNR
         TBgZeOYFXb5I1NKykbNO6+4+PO94HCB1m0OksvBe0J/0w+AFYGApNk99Uvtn8f9Tn2nV
         gSpuqaajkmd2kp2rQBi17D31RWP6tkMLpw8kZb1/QR3L6AkvpYcTciUbSAhVps0XHlDz
         iEl2ih2CRLIDaiq3E9afBAp0iN1c32c9TkSCmdl3c+plT9r+JVQ83bCf7VHm6PzqsN6U
         2RpUI7rhXnGSuLvcYyRcSCHxgdgEuQlDdWTLMU3YmzgehJ96THl81kK7pdIbpRboWPRu
         DSHw==
X-Gm-Message-State: AOAM5300bblR/uH8qJmz+5icLiWNpnLOkkSKFf68Ii2zrwwqiD9PihJ2
        /MwmsvPLIGeLK3dFzVr6Ac7GUd3WGC6+SRZ2tyk9AA==
X-Google-Smtp-Source: ABdhPJzGfKyTi1LhQjYMtf7XBM9eH87cIhjonTwhq0TRvmNG1Ol//HSSejAJUAlk51wdMnXmMEl65gO+SIhoMGjNCyw=
X-Received: by 2002:a05:6902:134b:: with SMTP id g11mr8505610ybu.202.1636642974118;
 Thu, 11 Nov 2021 07:02:54 -0800 (PST)
MIME-Version: 1.0
References: <YYDvm9c/7cGtBvw6@dhcp22.suse.cz> <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz> <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz> <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
 <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz> <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
 <CAJuCfpHJnVG7PMhKW-Snz38az-Bv=QCFXa7DxD=KgEMbHJOi6A@mail.gmail.com> <YYzgZARxi8csprIx@dhcp22.suse.cz>
In-Reply-To: <YYzgZARxi8csprIx@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 11 Nov 2021 07:02:42 -0800
Message-ID: <CAJuCfpEK+yruF8D9rzS44N3n6OLASL7nK2dfNj9daWpk-BguwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 1:20 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 10-11-21 17:49:37, Suren Baghdasaryan wrote:
> > On Tue, Nov 9, 2021 at 1:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Tue, Nov 9, 2021 at 12:10 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > Yes, those can run concurrently. One thing I completely forgot about is
> > > > 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > > > which is about interaction with the munlock.
> >
> > Agrh! This interaction with the munlock you mentioned requires us to
> > take mmap_write_lock before munlock_vma_pages_all and that prevents
> > __oom_reap_task_mm from running concurrently with unmap_vmas. The
> > reapers would not be as effective as they are now after such a change
> > :(
>
> __oom_reap_task_mm will not run concurrently with unmap_vmas even
> with the current code. The mmap_sem barrier right before munlock code
> prevents that.

You are right, it will run concurrently with another
__oom_reap_task_mm in the exit_mmap. But I thought we wanted to get
rid of that call to __oom_reap_task_mm in exit_mmap or did I
misunderstand?

>
> --
> Michal Hocko
> SUSE Labs
