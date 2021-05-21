Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1CB38CFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhEUVdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhEUVdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:33:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:32:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a2so31657075lfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6vYR27HmzkzaqUZHwr4SiLt+czaPdhvvjAoc9a/8f4=;
        b=kbkZg3A0VW7YNL2AQdeZyjdjLFnKr0r5zNtON5zCs4W0SEs88Zb2w1stFkF4DAEKAv
         Xqt0m6CJLrU3EAR8lmuqG4s6wDsRaKPk4KLUcL47gCc/DrX5JfdDT42hPyurrI4foj61
         B1JBSHMmHKbNIAanRxLZhpKZHXMmunxC6R7x+q5/SveC27YeODeQtGFuBYFTu/4JASLK
         /00mtD3rsIxST/xDhPx7jEA3Xoo1WrUpzeppSxzsTiSUYWJ8/Rk26w+bDG/CqASNqWYh
         8644/xTDuxNQ80EZC2CoFwAfq18AquNHU/VySzNB4KObSyjI/JLsdywwn/UPSr6TEHPS
         LFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6vYR27HmzkzaqUZHwr4SiLt+czaPdhvvjAoc9a/8f4=;
        b=fav0wVv03drhJdjI38AS66ejKCn1qoEMlSi1Ax8lyCBSkIMTUivzXSwJuM2k7PYTmd
         rc+w5/kOIx91k0WQa0sewy92j9om9s23a6qqZfHPogxI+nwxLYawfK1aR5JFSb+cuS9u
         ClKp2kQc7wkm0R+rms6lFE1hp/j3uoYy5zpS1H15nlcyfgvzw3PemOMCtbwan7GcZGn8
         CISm7IurLcAsTKSdTm0871WWBB1vngkgu4x+O5avgO2lFE5iDbxukZSI46w2jD3sU38G
         brjBWj9K0eh4axBb6yZySl8plrTge6LNkBz8Gqgqrrm94mKo/rBzhincR4gPJIR24MKb
         lI0w==
X-Gm-Message-State: AOAM530fVVECEHvjPIsXVNT3iW5naTUt4UJsvfTogsT7BQmjwdAL8cQe
        0rV3C+yY8QB+GB/OH0qINSM7gyOwsDqDhkYTCBqIjg==
X-Google-Smtp-Source: ABdhPJwSS+3an+3n51uDLplzTHkpoN8PirrQ2vSH+OePXCfPOPzKmZC7X/nzbIlK+CqvlbDRj+Um0SQc2E8JUH/vu7E=
X-Received: by 2002:ac2:44a2:: with SMTP id c2mr3549286lfm.74.1621632739009;
 Fri, 21 May 2021 14:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <20210520183614.1227046-5-posk@google.com>
 <YKgEn/TBsTyhk0m1@gmail.com>
In-Reply-To: <YKgEn/TBsTyhk0m1@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 May 2021 23:31:52 +0200
Message-ID: <CAG48ez0=ndXMCM-hST1WLMpQu5X9w_93Df=EoBqdq+DhC_HwbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:09 PM Andrei Vagin <avagin@gmail.com> wrote:
> On Thu, May 20, 2021 at 11:36:09AM -0700, Peter Oskolkov wrote:
> > @@ -67,7 +137,75 @@ SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
> >   */
> >  SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
> >  {
> > -     return -ENOSYS;
> > +     struct umcg_task_data *utd;
> > +     int ret = -EINVAL;
> > +
> > +     rcu_read_lock();
> > +     utd = rcu_dereference(current->umcg_task_data);
> > +
> > +     if (!utd || flags)
> > +             goto out;
> > +
> > +     task_lock(current);
> > +     rcu_assign_pointer(current->umcg_task_data, NULL);
> > +     task_unlock(current);
> > +
> > +     ret = 0;
> > +
> > +out:
> > +     rcu_read_unlock();
> > +     if (!ret && utd) {
> > +             synchronize_rcu();
>
> synchronize_rcu is expensive. Do we really need to call it here? Can we
> use kfree_rcu?
>
> Where is task->umcg_task_data freed when a task is destroyed?

or executed - the umcg stuff includes a userspace pointer, so it
probably shouldn't normally be kept around across execve?
