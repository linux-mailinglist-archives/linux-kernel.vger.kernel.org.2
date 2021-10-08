Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E3426A88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbhJHMQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbhJHMQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:16:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945DC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 05:14:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 134so10407883iou.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7RegfCL6tH5xSc5mxPpRRtzBps25gyk/r/PHLPNIRI=;
        b=qfd5lSqN8VBkxT53NtRve3pCi+plrXhIjPrXRHmFD9lIzJmXldDE+i/ZsTKJ+IFq/h
         8/WuVfcpqHaCWNP/5UEY50mAqI97dxdwVucEK7kLF96OHlteQKbt+SapG8cuYy4Cp4tz
         02SkFpEeSBffhsfSQoAT1Pb70855JKggCOJd7GwDScWU8bxEUiFJzTafaW6UcUFLRS6A
         ahsTxc1HChkio+3cla20TjboSMvHbT9mY5OVvKEGrZXX3QRZfa2NlrBctwTnbco1wR34
         NPJr6Aa6XKHi+8M4QRhiDQYRbdtlZC9kbjXiVsLdpHzNNreZDuvmtmgMFxDMK4Nh0HVO
         5uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7RegfCL6tH5xSc5mxPpRRtzBps25gyk/r/PHLPNIRI=;
        b=hcdAn7HXtocXzarNA+cIEs+jELnHy/ANKtNodA3GRGCbhrLsRQKAqh6YApU3zwKTGH
         PuAQIhuUFGV2g17GGBP6cboT/jyRwfXho2iGTkcoY677zIKj3o027Yt3M+RjfNeScVL9
         JlWXB2dc+XKLtKG7DKJUPOe0d6JVIOcRn1iUStw6+0mCMy7xoHzo1jLZtUGXyrRGyMP1
         ryHKAcyUn1OKw4pqxOuRSpFsfH112rgAdgtJVzeGhGB/XkvJ4lZpZgSOt3v51JMfGfiJ
         qPnXXnY/RkpN5hO7ZX6H0icv2pRWXX1XdeErp1Yud+gwpBcCeNDrvKI3QyNuhhjxvO7F
         bEpw==
X-Gm-Message-State: AOAM531lMeLmmqApzH0Ej1k+RDCtO/OfAQqhK4I/vPz+w+9T3y6gb9LV
        LbMx5gLLACshmX5YF93fJO/jWzd7T5eMtY/SFzE=
X-Google-Smtp-Source: ABdhPJzsLdKASK3N3O0kNsCSmJYITrdZlfuJijmyp+jwf2M2Ow8ueNQwaCIvBj3oK4TyE92atYZVOr0HYoCxzHD2uEc=
X-Received: by 2002:a05:6638:d0e:: with SMTP id q14mr7207579jaj.139.1633695297388;
 Fri, 08 Oct 2021 05:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211007120752.5195-1-laoar.shao@gmail.com> <20211007120752.5195-5-laoar.shao@gmail.com>
 <20211007134103.4da8a8ab@gandalf.local.home>
In-Reply-To: <20211007134103.4da8a8ab@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 8 Oct 2021 20:14:21 +0800
Message-ID: <CALOAHbDW4KnHndEXFVs-teQy6EQWuSi7thjkp7Ye8kboUGgvKg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kernel/kthread: show a warning if kthread's comm
 is truncated
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 1:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu,  7 Oct 2021 12:07:52 +0000
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > -             vsnprintf(name, sizeof(name), namefmt, args);
> > +             len = vsnprintf(name, sizeof(name), namefmt, args);
> > +             if (len >= TASK_COMM_LEN) {
> > +                     pr_warn("truncated kthread comm:%s, pid:%d by %d characters\n",
> > +                             name, task->pid, len - TASK_COMM_LEN + 1);
>
> Instead of saying how many characters it is truncated to, what about just
> showing what it was truncated to?
>
>                         pr_warn("truncated kthread comm from:%s to:%.*s for pid:%d\n",
>                                 name, TASK_COMM_LEN - 1, name, task->pid);
>
> ?
>

The 'name' is the truncated one. So it will be printed like,
[    0.222126] truncated kthread comm from:rcu_tasks_kthre
to:rcu_tasks_kthre for pid:10

If we want to show the full name, we have to use the namefmt,  which
is not suggested to use by Petr.
See also https://lore.kernel.org/lkml/YVXVBXSZ1m4ScvbX@alley/

Or we can do it as follows,

-               char name[TASK_COMM_LEN];
+                /* To show the full name if it will be truncated. */
+               char name[TASK_COMM_LEN + 8];

Then the full name will be printed:
[    0.222587] truncated kthread comm from:rcu_tasks_kthread
to:rcu_tasks_kthre for pid:10

But that seems a little overkill ?

-- 
Thanks
Yafang
