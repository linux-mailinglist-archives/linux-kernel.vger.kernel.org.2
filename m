Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366B640B4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhINQag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhINQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:30:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0201C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:29:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r3so25048209ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLdbCb/avNxTuz1aH11GNXLXKb4lBfj2ifLnEtCfqTs=;
        b=bcP5hplMqRw6+YWuCJHddtl22eao0d/Nb8Y25EY8LwGfcQLmLceu7BPOjnvuZ8PCSx
         Q7WOLIFvZpgNc4sLHlxAbsTfcnYTgIlcKFTKcQ/cNOz8rn47UNUHeNSenSvJ8yB67U9l
         LsqGVmXAkXCtDOApuyc3Vf/81utxiBSQZE4XZAI7dna17UTwtPVLbyizEF+GTMps4VX5
         959oUaxml1mRcqKb2HqRNYJQ4WEAbY5H4lIa03xzEd/MPKZjzs9rrZutfn7ZtSFaWmDQ
         RliDyWNAw7c7mfKnLB++R2NJ5051EXT1HuaaSHQH4U/cEU5VzxYMCmpi07sWJSlEeNOY
         sqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLdbCb/avNxTuz1aH11GNXLXKb4lBfj2ifLnEtCfqTs=;
        b=ytCAtTFjXlp7NizOh0Z2VwUy1eiiVeaQAaaxkE44QbnN8s5hyo1S2s8na2RXtfJjCC
         TdcNbGhbcnNrjJhzEWuRjRYfd/Lmx6yJSr6qhJBGsaf/ZRnhSpWE2cMxS1F42v/f4KKK
         g/2FlwlFSXGITC9wFgjFPOr6QTP9HWLbWyocNGYUlq6v0r/ZlNkqZv0BAszlK3GVvsJi
         DGyvSBaDKiyWkaockRc8KIu6kjf3Bf+WjSC17jT8BE6wTHeRx/mIsxRitx95RYSOGYbs
         lkdVr8AyOLxSP2/rg1C4pfGOqBo0pp74kzI4o5PQIFbtROl8HT3piO/HrJFdoXEzg7Wd
         uy1Q==
X-Gm-Message-State: AOAM5318K01brRpk93hejHS/nsPWtIiHypMPYQhNTB1Xoqn7ic364iUU
        EZHGCd9SyANzzIa2l7axMqR6Ud9c3XhUr0KxFtrPMg==
X-Google-Smtp-Source: ABdhPJwp95Btg7HW8Q0FVAK1BdPVzVJhAbjKl48pxlrCf2aCQY0Q3Ql+TwAlRFqXsSv2667qJlD8IFxV3UtgdG4ExSU=
X-Received: by 2002:a2e:900c:: with SMTP id h12mr16668315ljg.263.1631636952121;
 Tue, 14 Sep 2021 09:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com> <YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net>
In-Reply-To: <YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 09:29:00 -0700
Message-ID: <CAPNVh5chP3Zz+ww8WLb9bUYNikW-1PyOV=3==BM-92BgogaB3w@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 1:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 09, 2021 at 12:06:58PM -0700, Peter Oskolkov wrote:
> > On Wed, Sep 8, 2021 at 4:39 PM Jann Horn <jannh@google.com> wrote:

[...]

>
> Durr.. so yeah this is a bit of a chicken and egg problem here. We need
> a userspace page to notify we're blocked, but at the same time,
> accessing said page can get us blocked.
>
> And then worse, as Jann said, we cannot do this in the appropriate spot
> because we could be blocking on mmap_sem, so we must not require
> mmap_sem to make progress etc.. :/
>
> Now, in reality actually taking a fault for these pages is extremely
> unlikely, but if we do, there's really no option but to block and wait
> for it without notification. Tought luck there.

In the version of the patchset that I'm preparing to send I've decided
to punt on the issue and just ask the userspace to deal with locking
the memory as it sees fit: mlock() is available and as far as I can
tell RLIMIT_MLOCK is decently sized by default (6MB on Ubuntu, so
locked memory can contain more than 100k of structs umcg_task if
nothing else uses it); and if it is not enough for some special case,
it can be adjusted at a higher level in the userspace. If we get a
pagefault when we access struct umcg_task in the kernel, we just kill
the task.

Does the approach seem reasonable for the initial version of the patchset?

>
> So what we can do, is use get_user_page() on the appropriate pages
> (alignment ensure the whole umcg struct must be in a single page etc..)
> the moment a umcg task enters the kernel. For this we need some
> SYSCALL_WORK_ENTER flag.
>
> So normally a task would have ->umcg_page and ->umcg_server_page be
> NULL, the above SYSCALL_WORK_SYSCALL_UMCG flag would get_user_page() the
> self and server pages. If get_user_page() blocks, these fields would
> still be NULL and sched_submit_work() would not do anything, c'est la
> vie.
>
> Once we have the pages, any actual blocking hitting sched_submit_work()
> can do the updates without further blocking. It can then also put_page()
> and clear the ->umcg_{,server_}page pointers, because the task_work that
> will set RUNNABLE *can* suffer mmap_sem (again, unlikely, again tough
> luck if it does).
>
> The reason for put'ing the pages on blocking, is that this guarantees
> the pages are only pinned for a short amount of time, and 'never' by a
> blocked task. IOW, it's a proper transient pin and doesn't require extra
> special care or accounting.

I'd prefer to defer this smart/transient pinning of pages until later
if mlock() will solve the issue at the moment.

> Also, can you *please* convert that RST crud to a text file, it's
> absolutely unreadable gunk. Those documentation files should be readable
> as plain text first and foremost. That whole rendering to html crap is
> nonsense. Using a browser to read a test file is insane.

Will do. Maybe we can have both an RST and a TXT version of the
document? I think most files in /Documentation are RST...

Thanks,
Peter
