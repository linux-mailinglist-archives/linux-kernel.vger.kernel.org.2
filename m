Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E29425706
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhJGPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhJGPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:49:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD1C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:47:45 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z184so7294954iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93k30BowPAWJLvRYOEPtip43/6dZEF05PbXu8mfv+TI=;
        b=pkXbgGbEfdJ9fpdSaLsbOtSQlYPHSEzaXIqbleidL+uRH1mABVSXcrLLlzLzIZqB5C
         UUoygOXmBimnW3yVifKAcCDlx+rEjQ0trpUxvaHMKyYz7YPcDja8Z1Zrr+/fSSwr6svT
         f62DCHtbDbtSBwRmA+w+i3bQQSywsOROEBgGBo+51fZigZJZktTx1zE7FMp9KHScdsJM
         A123guNIRiynRX3yTJLC/TzUoUGucFHye4572sqtutVYRmWEqIlcKQPo7UNisu4Vykta
         GpytpJIlEbghtZjJPWJ2hM3wBhmTIlrlXxzoQZUxLI0dVSke7l5uN8mRq9NLJg7/Bdm9
         VM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93k30BowPAWJLvRYOEPtip43/6dZEF05PbXu8mfv+TI=;
        b=AAXFnJ2C84viemsf2gtU683T2GAYzYBXk7xXtiYRWKiaeU/KLAOi/RBKVkS0ZjlCNI
         21vfnLVwkFBGH8ZgyoesYQUcMvWK8JQKHglO0flND9N0iYpUm18OgJq5Y6eXnWSHRxT0
         KARxUTantldqxTmeJE3Zfy/SBVHRAv2/LrykPuGApjMjG3z5HS4phQmXM94esR9QewpX
         jtS1bR/r4oJtunONAl9qFPOaL8OLEZ4vYFc6Y5DCMvvonkh4Bty0vSzcc6RqWaZLOcai
         YOG5V2makMEhFj5ZkoevZkdbFR2bYy3GvSHJ3ThvafaVWfp+wDk2eNOezxIwxrI8IL9k
         rJjw==
X-Gm-Message-State: AOAM533ucTH+kIbxNFfmzWvuehVTmALgva7b190k0pbPyzhK4LYmrkfA
        Lz17uGNItc7DD9IylMYEanuPWSSumtzNxJrqzFE=
X-Google-Smtp-Source: ABdhPJy2evXXOlfqSfyreD00ReTBFkUXswgYgXak4PB9HCazKYzJkPVB+iW4wJ9z5JlAth8ls+Sx1e8wlPDxgzlLrJY=
X-Received: by 2002:a05:6638:35a0:: with SMTP id v32mr3536250jal.128.1633621664959;
 Thu, 07 Oct 2021 08:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211007120752.5195-1-laoar.shao@gmail.com> <20211007120752.5195-4-laoar.shao@gmail.com>
 <202110070755.60DFB87711@keescook>
In-Reply-To: <202110070755.60DFB87711@keescook>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Oct 2021 23:47:09 +0800
Message-ID: <CALOAHbAFZRUPn-kpgtm1Qi-ro2y=fJn3am94ho5N+f6HTxj9wA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sched.h: extend task comm from 16 to 24 for CONFIG_BASE_FULL
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 10:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 07, 2021 at 12:07:51PM +0000, Yafang Shao wrote:
> > When I was implementing a new per-cpu kthread cfs_migration, I found the
> > comm of it "cfs_migration/%u" is truncated due to the limitation of
> > TASK_COMM_LEN. For example, the comm of the percpu thread on CPU10~19 are
> > all with the same name "cfs_migration/1", which will confuse the user. This
> > issue is not critical, because we can get the corresponding CPU from the
> > task's Cpus_allowed. But for kthreads correspoinding to other hardware
> > devices, it is not easy to get the detailed device info from task comm,
> > for example,
> >
> >     jbd2/nvme0n1p2-
> >     nvidia-modeset/
> >
> > We can also shorten the name to work around this problem, but I find
> > there are so many truncated kthreads:
> >
> >     rcu_tasks_kthre
> >     rcu_tasks_rude_
> >     rcu_tasks_trace
> >     poll_mpt3sas0_s
> >     ext4-rsv-conver
> >     xfs-reclaim/sd{a, b, c, ...}
> >     xfs-blockgc/sd{a, b, c, ...}
> >     xfs-inodegc/sd{a, b, c, ...}
> >     audit_send_repl
> >     ecryptfs-kthrea
> >     vfio-irqfd-clea
> >     jbd2/nvme0n1p2-
> >     ...
> >
> > Besides the in-tree kthreads listed above, the out-of-tree kthreads may
> > also be truncated:
> >
> >     rtase_work_queu
> >     nvidia-modeset/
> >     UVM global queu
> >     UVM deferred re
> >     ...
> >
> > We should improve this problem fundamentally.
> >
> > This patch extends the size of task comm to 24 bytes, which is the
> > same length with workqueue's, for the CONFIG_BASE_FULL case. And for the
> > CONFIG_BASE_SMALL case, the size of task comm is still kept as 16 bytes.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> This, as expected, adds 8 bytes to task_struct, which is reasonable. I
> don't see any easy places to consolidate other members to make this a
> "free" change, but I did just remove 64 bytes from task_struct[1], so
> this is okay. :)
>

Cool!

> Reviewed-by: Kees Cook <keescook@chromium.org>
>

Thanks for the review.

> [1] https://lore.kernel.org/lkml/20210924025450.4138503-1-keescook@chromium.org/
>

-- 
Thanks
Yafang
