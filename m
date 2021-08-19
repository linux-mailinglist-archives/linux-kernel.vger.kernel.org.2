Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757073F10D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhHSC63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbhHSC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:58:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D932C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:57:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i9so9290270lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0tJ1RmmmhTuQR1NWmbvmxw68o8us2kyNZm27u3KBNE=;
        b=DS+jKUOA5fmZ4xaJlUgX8saC04N4GZ+KcDw+71fTzlRCw2zWVr4lymv6W9K7uepXlM
         6qbUW+0Z+gxH/BMpq8yXA5SaSX0/SIJd5RusMoIIenyExSccjxhIXr6AYI2uI+ddf5mf
         dN0bTvKu6z63248oQA8NFXjUdR2PUFixl7L+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0tJ1RmmmhTuQR1NWmbvmxw68o8us2kyNZm27u3KBNE=;
        b=H8BAILlJ03BlscHJ9YPj5iANKBetutg6yVS/SfzhJ8hXZBLTZwF5fYvPXR6IEPisyn
         wuApWVnSuna6zc92RngiezAHdcWHdM0epn/JdAsYxH6ReXFpnXICn2yVd5x7dASL36hD
         ffj1R8lEZUNR2zpS5almd7MEZJeKe51rwdGN0KH/26Q/B+mSjdA+Xb3pIlH6/1Cf6/va
         ernEYukn8LtM7hv0wmmOZSPe2UgFl9KsUY2WY6Ni+Ip8iu8lSgUO03Myop2LKKbYe12h
         qWt8/tsctZvZHASU+kgsRNq39WYoGANBvhO3RHr6U6GC0Sw0JplMzWmdj+AnXArWlqMD
         aXAA==
X-Gm-Message-State: AOAM530vwbkGVD9CHcI3NcZLa4KcVwNeHgzM2JeduSW11j3lFX/DPgxo
        Rl0roRVfgtSxL6A6icZa8VA+vf/ZXICDYh1L
X-Google-Smtp-Source: ABdhPJwc3cSGdprV0uZp+poafWVPYBlOCUCfn5FEe4m0n4JISW1wB1zHopB2IHyjxjo9icJNyEL+Bg==
X-Received: by 2002:a19:5517:: with SMTP id n23mr8137044lfe.264.1629341869806;
        Wed, 18 Aug 2021 19:57:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m12sm153980lfh.182.2021.08.18.19.57.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 19:57:49 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t9so9363385lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:57:49 -0700 (PDT)
X-Received: by 2002:a19:500e:: with SMTP id e14mr8399571lfb.487.1629341868860;
 Wed, 18 Aug 2021 19:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
In-Reply-To: <76d3418c-e9ba-4392-858a-5da8028e3526@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Aug 2021 19:57:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
Message-ID: <CAHk-=wgBMNC1ePTgqM6f0iBH94KE5_oHQYD2sqCbjev0KaZ6Kw@mail.gmail.com>
Subject: Re: [PATCH] kernel: make TIF_NOTIFY_SIGNAL and core dumps co-exist
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Olivier Langlois <olivier@trillion01.com>,
        Tony Battersby <tonyb@cybernetics.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 8:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> task_work being added with notify == TWA_SIGNAL will utilize
> TIF_NOTIFY_SIGNAL for signaling the targeted task that work is available.
> If this happens while a task is going through a core dump, it'll
> potentially disturb and truncate the dump as a signal interruption.

This patch seems (a) buggy and (b) hacky.

> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -41,6 +41,12 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>                 head = READ_ONCE(task->task_works);
>                 if (unlikely(head == &work_exited))
>                         return -ESRCH;
> +               /*
> +                * TIF_NOTIFY_SIGNAL notifications will interfere with
> +                * a core dump in progress, reject them.
> +                */
> +               if (notify == TWA_SIGNAL && (task->flags & PF_SIGNALED))
> +                       return -ESRCH;

This basically seems to check task->flags with no serialization.

I'm sure it works 99.9% of the time in practice, since you'd be really
unlucky to hit any races, but I really don't see what the
serialization logic is.

Also, the main user that actually triggered the problem already has

        if (unlikely(tsk->flags & PF_EXITING))
                goto fail;

just above the call to task_work_add(), so this all seems very hacky indeed.

Of course, I don't see what the serialization for _that_ one is either.

Pls explain. You can't just randomly add tests for random flags that
get modified by other random code.

               Linus
