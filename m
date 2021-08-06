Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939EE3E272C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbhHFJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbhHFJXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:23:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E03C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:23:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b6so333895lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pz/ZNLrZ0O+ZYLO34S4orrCykgTqtG1p1sxk4AuVhP8=;
        b=cGHj/WVq/vdRsPecp7h5K9JfcZgFhYagyOxvNOodNjPWx1ajkrEXS3JlyTiNibU3Zp
         SwCEr2nxYnnoN/rDaQwb38GFSgdZl2Kq0S1ZixHKqp+2avGFzfRNz6/iVMXsnP13GDXH
         RgM2ccrAp/Y1PFbzphGj/HwyUf/rf0UTzlmJOICfUXjvGmeePTEJrpD9OV4lH2mafCPY
         EUwoVZfgNlJ5UV5dhZ/CcQ8uSISli8alXXvbGedEUPmFhOF7U0zEPU4QCO18qhf9yaxy
         TcA08g0vlBeSatSxXBIZQVQuFf1Og0jFqjL2CJHgmHoOtEAS/Q+fp37wUoAuWgX6aBA1
         VJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pz/ZNLrZ0O+ZYLO34S4orrCykgTqtG1p1sxk4AuVhP8=;
        b=arTjRP92trpmG+VHt0ABfsziko5n1/X8leW904+QRGYD3de7a+BlqVdiYN18p+iZ2b
         yCMzp3Zt8OtrxFF1eCSOWgyIN54dqEnwKP+MOOVYu9/rGtPI+h9L0Fa+Do2MP1fQ0Xe9
         bNonbazdxo2DghOsAqAAhxnX1QWbPk+iyUkKIv/0sM6dASqHgKKB5DBQ4G52gNLQxh2j
         IrnDxa5wTRJxm/ZD1IS+0TvUXApLFWNsAEzecse0izS+FJMi8f1aXL+Qq4gqLxmFGJ7X
         oKpYIlxuqktkwa3V8VFl6Wz+HcPK699L6TvJg8sPdgvi/A5yCTe1BgRg04kM/Fun/Y7f
         j3zQ==
X-Gm-Message-State: AOAM530w/cvrtEncb9sDlgNby4EOJa7R0RfNn0eZOXoZ7y+QiVrowdaV
        /l8gGJYWCUwd4E5fidEzdssbQAQEAY191RQOlP8FFw==
X-Google-Smtp-Source: ABdhPJxF+e96ji6+s/JU3AfUGss3Zf7f2U0jNy8HR7IhhDpf9cNHe8wRq2148ITd4iRoh3nJDaO7hsQbtRbL15dwnV8=
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr7112194lfo.117.1628241808578;
 Fri, 06 Aug 2021 02:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210805170859.2389276-1-surenb@google.com> <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
In-Reply-To: <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Aug 2021 02:23:17 -0700
Message-ID: <CALvZod6k3Bm77xt4y=Mvf1Oi8XH25UJwLQaJaFNBFsBAcRuO_Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 11:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> I think you really want something like this:
>
>         if (flags)
>                 return -EINVAL;
>
>         pid = pidfd_get_pid(fd, &f_flags);
>         if (IS_ERR(pid))
>                 return PTR_ERR(pid);
>         task = get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 ret = -ESRCH;
>                 goto put_pid;
>         }
>
>         /*
>          * Make sure to chose a thread which still has a reference to mm
>          * during the group exit
>          */
>         p = find_lock_task_mm(task);
>         if (!p) {
>                 ret = -ESRCH;
>                 goto put_task;
>         }
>
>         mm = task->mm;

mm = p->mm;

>         mmgrab(mm);
>         reap = true;
>         /* If the work has been done already, just exit with success */
>         if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
>                 reap = false;
>         } else if (!task_will_free_mem(p)) {
>                 reap = false;
>                 ret = -EINVAL;
>         }
>         task_unlock(p);
>
>         if (!reap)
>                 goto dropmm;;
>
>         /* Do the work*/
>
>
> dropmm:
>         mmdrop(mm);
> put_task:
>         put_task(task);
> put_pid:
>         put_pid(pid);
>
>         return ret;
>
> --
> Michal Hocko
> SUSE Labs
