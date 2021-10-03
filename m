Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89299420206
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJCOXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhJCOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 10:23:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98BC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 07:21:23 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q6so15642783ilm.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLsBvOc6u//jlK7gHEH07WFhN7dqb9OTeWm8I3p/AkY=;
        b=SrZPaSpb6NTKrTi6dAph9DMMS0ol/yf+xMS0erj2GIRNd8FH1iB+NzytOwQmfbB8Oi
         n0fhdGmbPkgGNVjtN7mcF6KArXrr0WTBGL/jP1Lz/rb+zoZFQUyO2nWkjxQ9KlQAkBxn
         WptVi8aiEvLExHQDpsHHzPhIgRWYQbKsmpTalTmpDQUhOiSodU3JNuqIDZcL7s6SPLZn
         XMKHnB8mhzDwZcdxQsp5d6bHF7tG4qelRaJs0YtThXNc3R4yPLSJ67e1buYGozHzojUK
         Aq7+H8pkomdBArNBdr+54hqNV55/EW0A/1yBK8pgxEwJvGo6SkXd82wjW+eTZ2WVjYKr
         oDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLsBvOc6u//jlK7gHEH07WFhN7dqb9OTeWm8I3p/AkY=;
        b=cmdIsVHPRIJ+VRuA/0JyKB6fX3T2ZMxx8tG/xVihsnQJbgktDaur/EyqsEfyZdMMuK
         VffPmog6c/6UbOE3p2wWyOvAli1Q5n8JO9WFRf88Ct4cmSvw38/AZcU4kKvlxrtiuj9p
         GWczej/uEEz6CUwEHKaKt6MIo320un79Kh2dUMlA+pj1/sKDvebTMa3tZI1/wzVlpPsL
         w9bDlyrTrAovGcfV7SEL8tLOzVsl2whWwyOBOMpoz8F5PQHmK/zF6FFV8ENLNcK/F3DL
         0wCBqvCV6ahDpkuue5S8t2ZDz77CDoyQHzgxZVIB1y8fJqlu+85PbfxAvC7esp2GhHVs
         iuTw==
X-Gm-Message-State: AOAM530vQXtoIcLU9rhCOFFeMiPeJ2hqBLwon7sUIoqhnxP3sNmvJMbh
        jxfqYTIaS8QoNmJnjBX/9FjQjCZMYWTDBTH3Pqo=
X-Google-Smtp-Source: ABdhPJylV4bQup4aKrNgMd2/7oUamVcuwVYj7O5vq0cgGgE2PgoG9e8E5oEyDRczVzBN1enUofXG8KzpksNIBSlPo1E=
X-Received: by 2002:a92:ca4f:: with SMTP id q15mr6356369ilo.131.1633270882779;
 Sun, 03 Oct 2021 07:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115036.4851-1-laoar.shao@gmail.com> <YVkmaSUxbg/JtBHb@zeniv-ca.linux.org.uk>
In-Reply-To: <YVkmaSUxbg/JtBHb@zeniv-ca.linux.org.uk>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 3 Oct 2021 22:20:46 +0800
Message-ID: <CALOAHbDhwJsYO+a7dyTn-HxrpVNnaLi_xrJ7gk-mBwjPNV4YMw@mail.gmail.com>
Subject: Re: [PATCH 0/5] kthread: increase the size of kthread's comm
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 11:41 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 29, 2021 at 11:50:31AM +0000, Yafang Shao wrote:
>
> > That motivates me to do this improvement.
> >
> > This patch increases the size of ktread's comm from 16 to 24, which is
> > the same with workqueue's. After this change, the name of kthread can be
> > fully displayed in /proc/[pid]/comm, for example,
> >
> >     rcu_tasks_kthread
> >     rcu_tasks_rude_kthread
> >     rcu_tasks_trace_kthread
> >     ecryptfs-kthread
> >     vfio-irqfd-cleanup
> >     ext4-rsv-conversion
> >     jbd2/nvme0n1p2-8
> >     ...
> >
> > Because there're only a few of kthreads, so it won't increase too much
> > memory consumption.
>
> That's a bloody massive overkill.  If you care about /proc/*/comm, you
> might want to take a look at the function that generates its contents:
>
> void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
> {
>         char tcomm[64];
>
>         if (p->flags & PF_WQ_WORKER)
>                 wq_worker_comm(tcomm, sizeof(tcomm), p);
>         else
>                 __get_task_comm(tcomm, sizeof(tcomm), p);
>
>         if (escape)
>                 seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
>         else
>                 seq_printf(m, "%.64s", tcomm);
> }
>
> Hint: it's not always p->comm verbatim...

Right, I found it.  That's why I was wondering  storing the kthread's
comm in kthread_data.[1]
But after Petr's suggestion, I find increasing the size of comm to 24
for COFNIG_BASE_FULL and keeping it as 16 for COFNIG_BASE_SMALL is a
better solution.

[1]. https://lore.kernel.org/lkml/CALOAHbD3HUqUnjMYKX7NGwVWiS4K7OvS6uPNWucnOA5Cy3pn9w@mail.gmail.com/#t

-- 
Thanks
Yafang
