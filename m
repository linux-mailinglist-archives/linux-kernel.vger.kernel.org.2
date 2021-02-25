Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DF3325996
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBYWW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhBYWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:17:58 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6CC061225
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:17:15 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d20so6287882qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44yiA3ypd9Z9fwxLK92nJoDxSjcY2FUyKf3kzqwUJOc=;
        b=iVwq6CfNSEWonjlkLJQXRi/Cm0iUxxT/lq17x1VuDi2jMuBd5UqiT0VF1uybRg1VRq
         zfnjXy9mkKEQolQC+sxlLW19vUBXi5GCKfnC8K8QDhVNbb2hpjgO8eGnL/KJWEV6lJCy
         69Nos5MsEt5Ost6aGeqeUrd/QVHVj9AwlF9wHBMBlJdS/NshrnNbRPfyqgzcF4zkDK7G
         3k7tN4cirrQD5EYAmob3YmlDYeddz8ZzveMrgQIvOsyAExDT8YN/DrOqJDmdCeJ8hFvG
         uZrCBhW9p3WJS9qYlkeLTBe0hNhjgjwlxKLkFGg8aFWtPyjj45YOu9NbfWsbsGZYOfyo
         6f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44yiA3ypd9Z9fwxLK92nJoDxSjcY2FUyKf3kzqwUJOc=;
        b=OA60FjBFSWx9nPsKn/cRTPkTCp6vNYHSDMtvUbLRaX4AIZ8vuoGFr29zjaasiwPXUs
         s2I44Xlc0IVu1Ywx29D8RuQBl/BDGqSSWyD1PCZfNtAx3HOBzZGIXUTU5rK4yLi+H4hm
         vrfe/4C4R3F1h8vXWFy0g3jhfhBQU1sgAtwz2R5Y18yjjCRdRgrUtlzVzacOKKYXWEit
         Nyu+KYtEoGQ0c94y3kC3oX126ohOsI6jCH9X9SpZTKnCFIGTQqUgiLiJTDMWeCHwKDIH
         Q/HxJ5qBtSdfVuL0Y0R1tdRv/IgDm2HuyNhZ/d0FJ4QqPVx+nYdxAT7AKH9/pOGmq3cP
         pN6w==
X-Gm-Message-State: AOAM5312IPns488zckADh3kdkrS6r5+8hsb2PlXKCPSwOTTnY51bdqzL
        Uw7CsCGXclTrNgQZ0786rTUTF5TcdT2qAtPPItt98w==
X-Google-Smtp-Source: ABdhPJwvFoUfCTC8dTmdEf1tqOL0hY16jfa2aPfzu2EUETLRgHILXhnffm5SUXSanL/djuug7AXELkupurbAJ+g24V4=
X-Received: by 2002:ae9:c00e:: with SMTP id u14mr4794568qkk.482.1614291434386;
 Thu, 25 Feb 2021 14:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20210214000611.2169820-1-zzyiwei@android.com> <YC+ZQAwwb4RGgjDf@alley>
 <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
 <CAKB3++b4wnsh+Kbgk4U200hLQmudM28sK=s9e6mARpM-eZ2ZZw@mail.gmail.com>
 <YDUkoTGk2G/GZj8w@alley> <CAKB3++Yf5cv8shHU0T1nqfNTgbknU1uMu54YXWqNGqXHpa_oAA@mail.gmail.com>
 <YDYdoRwezfVsWS4W@alley>
In-Reply-To: <YDYdoRwezfVsWS4W@alley>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Thu, 25 Feb 2021 14:17:04 -0800
Message-ID: <CAKB3++YFqao5f4oZ2eX3GhLDChNx5EheXG-y9aUsReY3JETYtQ@mail.gmail.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 1:34 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2021-02-23 14:29:37, Yiwei Zhang wrote:
> > > > which is not cool because it will make the
> > > > asynchronous effort a no-op. Is there a way we can include caller
> > > > thread metadata(task_struct pointer?) when it enqueues the work so
> > > > that the RT worker thread won't preempt the caller thread when that
> > > > queued work gets scheduled? Probably require the CPU scheduler to poke
> > > > at the next work...or any other ideas will be very appreciated,
> > > > thanks!
> > >
> > > This sounds like a very strange use case.
> > > Why is the worker kthread RT when the work can be delayed?
> > >
> > > If the kthread has to be RT because of another work then
> > > your proposal will not work. The delayed processing of
> > > low priority work might block and delay any pending
> > > high priority work.
> > >
> > > You should consider handling the less important work in a separate
> > > kthread worker with a lower priority or by the system workqueue.
> >
> > Just want to clarify that it's not about delayed_work any more. In my
> > latest question, it's a RT thread with normal work queued and
> > scheduled to be run immediately. However, I simply don't want the
> > worker to preempt the thread that queues the work.
> >
> > It's a high prio work that we don't want other random tasks to preempt
> > it. Meanwhile, we don't want it to preempt the called thread. In
> > addition, assume we can't raise the priority of those caller
> > threads(otherwise I'd be fine with using a workqueue).
>
> Honestly, it sounds weird to me. Either the caller or the
> worker has higher priority.
>
> Well, I think that behavior could be achieved by
> CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
>
> Anyway, this is rather a question for scheduler experts.
> It is possible that it has some solution. But it is also
> possible that it is so specific behavior and it would
> complicate the scheduler too much.
>
> Best Regards,
> Petr

Thanks for the pointers! I'll explore further with scheduling folks.
