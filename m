Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD44042B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbhIIBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349086AbhIIBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:17:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F51C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:16:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f18so212143lfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvLyT4+7Aiymn6gXzNE4oKTpQfZnma/CF9vdVIrLCj0=;
        b=loBPUFiJ17CJ4ZdjUsFhVmUZ8Cg018uO8pv3jVcFNEjIZVzht/g5phznAS6jMzVM7u
         1b960PykAURWK6R1WWuzYsw1WW/rLiiB1NxXWRiQWasxgYExBxCr0g++4OVjJSsjh3SR
         Atd5BJHlbFWfJE2Q91fduLBIh2jw6EkyO6aLkrNX5AOHzzR7mGXDFiy3btCQndztlZgc
         wMW4aso3DZSP1xVwh53RCmETvnWLjxKzqi4PG3MtfJ/mBoRtUYpvQt2QP9HbAAok0SgT
         j4GFArFfPaSYyAc0q8fUct1EMmVfzoYa1W89crrw9OsK17O+labUFu/nJOKRHk8tso4a
         mcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvLyT4+7Aiymn6gXzNE4oKTpQfZnma/CF9vdVIrLCj0=;
        b=s7rjVS5aw2pCgWhZXqYhwewK8CgaqufsU4TGyi4M65owCEWZO13KKKnpF33yTgsZpW
         atnEQdniD9zvL2qDAZ163/AeRqV0orMqPHc0j+sS5Yh0+bv8BT3Elz03pIJ0YglM9GN3
         q46yO3sH5T3cflGaBSau+xEs2szaTNKcPf5AobX1f6IhjQ026bQF8xGsJuRKqM4omZqS
         uFfLfqg6h9i9QW/hURpGhvTreHqIl4Yc/cs+5+myL4WGyfQCHa/6HVLuKUHHPh/vRQaY
         /i6EcxMA9+n4BwoPh4tIujkO+/GDqlWNZ5Cjbedivffu4yQfBkA7N2uiuyF0mC6QKJt8
         XTig==
X-Gm-Message-State: AOAM531piG7AubvOWMdfXxvXXFCwKbiwI2bE+Zc1lxvNJtIVa3JC4pug
        1r0QGebMyPpKfdU2TuGProcVPqSe6GsS7WoQhooOPw==
X-Google-Smtp-Source: ABdhPJysB844wVmbqvrXWaqDyoi57lhNAEbQuTWxjHVgx5kqArBdJnl+Uo9biEAEfd2Ku+wq/XpmEh5qIkX6IKdkir4=
X-Received: by 2002:a05:6512:695:: with SMTP id t21mr365696lfe.157.1631150203757;
 Wed, 08 Sep 2021 18:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
In-Reply-To: <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Sep 2021 03:16:17 +0200
Message-ID: <CAG48ez3rRReCVpuhQu_-f_a0Yn=cUBqu1aNSG0JtHK8mjqzFsw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:38 AM Jann Horn <jannh@google.com> wrote:
> On Wed, Sep 8, 2021 at 8:49 PM Peter Oskolkov <posk@posk.io> wrote:
> > Add helper functions to work atomically with userspace 32/64 bit values -
> > there are some .*futex.* named helpers, but they are not exactly
> > what is needed for UMCG; I haven't found what else I could use, so I
> > rolled these.
[...]
> You of course won't be able to simply traverse userspace pointers in
> such a situation, only access the specific userspace object that
> you've prepared beforehand, but luckily it looks like:
>
>  * idle_server_tid_ptr is only accessed in get_idle_server()
>    -> which is used from process_waking_worker()
>      -> which runs in sleepable context
>  * idle_workers_ptr is accessed from:
>    -> enqueue_idle_worker
>      -> which is also used from process_waking_worker()

Ah, I guess I got that wrong: process_waking_worker() is sleepable,
but it might be holding the mmap lock, so it can't fault, right? Which
means this would actually be problematic...
