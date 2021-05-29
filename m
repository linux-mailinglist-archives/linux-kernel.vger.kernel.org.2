Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A4394B54
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhE2Jfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2Jft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:35:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9343C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 02:34:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 124so6543443qkh.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2zk5Z9qlmuHt7s59WmntMYgLXKVD6H7rp//7T7Ci/8=;
        b=hDCCEJVAZKetxCHmjId0bnmlfkx3k16wWn12wNDc5P5idPT0ngrHc3rLGObhkyriBA
         mvWG+3CPFlSemwRz6/fXgFfplhLrrwCh98FXV9wmSTImqhMKUrgx0gMSuP/84D0d+8F1
         7mFB4u54hKeRmrfeBxbOlnCpASZOQXTn6idAD5hD5+lB3QNbcG/BxCWObvGJvZ8GRaob
         qMPvxz97lervJeKwHD2gCa4qLV9+4lkpECE3tnM832PMwWx4zZURXY5u3hfI4DhsDqyR
         3h4CZOWLvtZjihPvbgqkqq5T+aN0xCp4TYoid+7HEBLzgoQ/+zTp9LvGewApdQg5gMFH
         H9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2zk5Z9qlmuHt7s59WmntMYgLXKVD6H7rp//7T7Ci/8=;
        b=ftxrav+XyMZifwqspk2LO/0x/V6QCXKoWSgPSc8Gw+Jk5fRLJjzjqPbzQVsR9KBBTz
         nsZWEwaLsaSrP8v+b0XaYaSSQOyN5/E87+J4Hv+BCKZ3W39yJjNKwkqM+818Bzh4txKI
         GPzgQk5lWX8CRDy4xXpOifK8wCfAb9k519euKlctQQ+zcP1I3oWWrm1d40ookSq7koRF
         nNKn9TMp3xEtRSZwjmDUvUpQuXN3hFteE/t2HahnqHFfCUKip9Vhp36ZCzgq59bgaEP/
         ERv+bOKpE2ZlXP+ErEeJUuiRXORw1hZtov/S6Lal98C+uyUwK6ww3WTMuBChMJm9j3YI
         Btvw==
X-Gm-Message-State: AOAM533/ayJEHrfEynoPVmgc6lIE2ngahS+3o3KEF6cfFj7GCkWeyBVN
        crmaiKWLSsrH+m8X9H20Ah+KcQ5DXSdnZdfKwYcttg==
X-Google-Smtp-Source: ABdhPJwXoRj5VTC3ispBzurA46Rc887udt72YjBDhzkFyli/geAoFElPNHYPCgUZMfBGhigry3TT9gk/AkYI1XbfgsE=
X-Received: by 2002:ae9:e706:: with SMTP id m6mr7950209qka.74.1622280852071;
 Sat, 29 May 2021 02:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
 <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
 <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com> <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Sat, 29 May 2021 11:33:32 +0200
Message-ID: <CAFpoUr04ziEzvNBJx0xKSuuEnapGzyABwaM-FU3TUaCZkQ4WPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> normally tg_load_avg_contrib should be null when cfs_rq_is_decayed()

Yeah, I think that is an ok assumption of how it _should_ work (given
the other patches in flight are merged).

> The reason of this list is to ensure that the load of all cfs_rq are
> periodically updated  as it is then used to share the runtime between
> groups so we should keep to use the rule whenever possible.

Yeah, right.

> we probably need to keep (cfs_rq->nr_running >= 1) as we can have case
> where tg_load_avg_contrib is null but a task is enqueued

Yeah, there is probably a chance of enqueuing a task without any load,
and then a parent gets throttled.
So (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running) is probably the
way to go if we want to avoid
a new field. Will resend a patch with that instead.

In case the new field is the main issue with the original solution, we
could also change the on_list int to have three modes like; NO, YES,
THROTTLED/PAUSED, but that would require a bigger rewrite of the other
logic, so probably outside the scope of this patch.

Thanks
Odin
