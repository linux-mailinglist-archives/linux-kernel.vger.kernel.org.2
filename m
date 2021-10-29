Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61143F81C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJ2HwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhJ2Hvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:51:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD06C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 00:49:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r12so35829675edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjqTlAq/8atUNGknBengC56rv9Dz2YcbvxQpL6f31NE=;
        b=4NWQ97D8av1bcOmAuQzWks2cBvv6sEDFs9N8sqanD4uhWTidcfYo3hBwx+DyCNFz1K
         P4C+s2YWl0gtXhIEz4s/whnD2DqPHxtpemt8r9bU+0/beruJ6D0okHZ8gattocaYAXEv
         Zybb+4y2JNS6+rpvFo4Ectd4zS13QmraLGofH2mPNjDu9wd4ORTSd/6hT5VwdRxXkLxn
         F1ewJRoO/QNgJhKynXm88FBtssDG+yUlM9zauo+3ocX/ytwveSWrB/tl11tDpcdmyEHQ
         cxqna2wQ4HpL7O/dzDhj25Kv2djOE8/xDRnIPI1r/h0QlWADoXnouRt9Tdu3nKvKCxTs
         dQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjqTlAq/8atUNGknBengC56rv9Dz2YcbvxQpL6f31NE=;
        b=KbYc35wY/9Q59YQNLk0RbnV/97DqGqajJPTrqWSHyZBGEcuzfAjp6BfrDiFk1Xri6M
         BIlwuGkRSTG1OcjJ+oBRl0KRZd4WhUJh7masZXLmc2XwBHtMBgMwcomj8ww3zSBGwnQx
         ZypKuOw2ZGqYPNONQ+MXlDHA+wOjYqG3CgqJQavfP/Avt8W2W6HEIEk5SYphpjvvNjXF
         5e0080nnBmuND3SmONnsrUKMHkqu4W9u/B5ol0ZFPdvLqWWgBQbi176vf2TRBtxuQIw6
         zD8P91co6i4mzf7FXZ7cz07yWTYlq/pOFnZ0Zoc0azexOhKZV971/+W6ANdA1R7amq06
         mX/A==
X-Gm-Message-State: AOAM530psufMhxKIxpH9dK3Dr443kX2vK+5+LBih0AlorWPbJaf0dfs5
        ejEfqjn1zCDqln0lKTQYCTi+Z1MnLkEDy2Cl/s7xfA==
X-Google-Smtp-Source: ABdhPJwjitD9q7llnX4M3SYof8U1mUQbFwcD39eUp1B6VYUJIc75/H1aw9+QzCU4himzNKQr5lfz8Bq83cIf+yo39EY=
X-Received: by 2002:a17:906:c18c:: with SMTP id g12mr11994765ejz.458.1635493741880;
 Fri, 29 Oct 2021 00:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com> <20211028153028.GP3891@suse.de>
In-Reply-To: <20211028153028.GP3891@suse.de>
From:   =?UTF-8?B?5p2O5riv?= <ligang.bdlg@bytedance.com>
Date:   Fri, 29 Oct 2021 15:48:50 +0800
Message-ID: <CAMx52AR2h_RifrFPyu4WA3YDij9epuApOzG1zbH9F6pK4m7b9Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] sched/numa: add per-process numa_balancing
To:     Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:30 PM Mel Gorman <mgorman@suse.de> wrote:
>
> That aside though, the configuration space could be better. It's possible
> to selectively disable NUMA balance but not selectively enable because
> prctl is disabled if global NUMA balancing is disabled. That could be
> somewhat achieved by having a default value for mm->numa_balancing based on
> whether the global numa balancing is disabled via command line or sysctl
> and enabling the static branch if prctl is used with an informational
> message. This is not the only potential solution but as it stands,
> there are odd semantic corner cases. For example, explicit enabling
> of NUMA balancing by prctl gets silently revoked if numa balancing is
> disabled via sysctl and prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,
> 1) means nothing.

static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
{
    ...
    if (static_branch_unlikely(&sched_numa_balancing))
        task_tick_numa(rq, curr);
    ...
}

static void task_tick_numa(struct rq *rq, struct task_struct *curr)
{
    ...
    if (!READ_ONCE(curr->mm->numa_balancing))
        return;
    ...
}

When global numa_balancing is disabled, mm->numa_balancing is useless.
So I think
prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,0/1) should return an
error instead of modifying mm->numa_balancing.

Is it reasonable that prctl(PR_NUMA_BALANCING,PR_SET_NUMA_BALANCING,0/1)
can still change the value of mm->numa_balancing when global numa_balancing is
disabled?
