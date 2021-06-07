Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3EE39DDCE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFGNj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:39:58 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:43615 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFGNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:39:55 -0400
Received: by mail-qv1-f46.google.com with SMTP id e18so8789562qvm.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igiYe7SwyKBt7A5QKk3rIAjajnn7ad4fy0OWQQgiPI4=;
        b=AL0ARjGG2d5UzLScoqRAbXYinCmVuWXQBcHoLRgl5VkHuKhtrwKqmto+JNVUYgKPl2
         b3k4tNPWnwv4RcbyMRhhfOdEm01keBZ51WwEy3xtnoGWJHdy0O9oVdSCYKB9gJalztcE
         1O17QCIDR4emE/ABvZa7F4Pk6t48ADo7f1xfiGv8qs/T5cpIWZlrxkMA5GxlvBrTWGM9
         rljNNoAyIx9MkJQ75F6YKWrBtHge3WmRDRtPJ9xyNH6bSTE4P+sjkFPsXDjcZH35ArlB
         4T+hETApzFiQSXxIXIyMMdJXcT5Oa1Db+FDW7mQa13hipnaroVt4L8oh7MhuQxDfEgyH
         4MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igiYe7SwyKBt7A5QKk3rIAjajnn7ad4fy0OWQQgiPI4=;
        b=q1+BQeO0AEwLRZiRnHfwd4hvsuZk25NHIPJa9oYnhkpEUblxO2EeKhTW7ovGtbosOz
         c0JwH5DQe1pxyDOjo2Y6/GOnqaBJG6kLzdTWCxhHzgTqvevhjVv3H69/GDOqv48YC6Br
         6F06ruGoLLk4SxlcppOYHiXZb0qFgEzf24pwBxDkYgM7mVWyew660FG9F4OMQa87Q5t/
         30QdAauOOb6v7SEG+BLFdqLRQQbXtDRWNjSb/fcgk8TO0SuFbkJyIZJbtIbOfJaL4FHj
         l7xKB1PTwgzbUDhGPlDUYenCM9w6f0YqYWX0cGsp6pTM77uP08jIDlV02y9SBAMs/g+O
         y9kw==
X-Gm-Message-State: AOAM530NVivwFfxpiyn/LrWPwFruAihw7pS1mN1LMOcrDkJZNWud2v8Q
        MZLF171KVYWxJ2OmlDB4ddZ1KBGrpNr8mOJd7xG6Tw==
X-Google-Smtp-Source: ABdhPJxFAkP9Wrb9vGOGQ6bJTtZQhPUtesD4SeHIY7iDN560TIEUUvDnhf/P/AaRfgHMP2UWNREA0Y6d103uy9WzAeg=
X-Received: by 2002:a0c:eac3:: with SMTP id y3mr18247355qvp.9.1623073010586;
 Mon, 07 Jun 2021 06:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210604102314.697749-1-odin@uged.al> <CAKfTPtDHrD_QGoLeUkR0ALRakWH+KOopHZk=29fyi-oonerd9g@mail.gmail.com>
In-Reply-To: <CAKfTPtDHrD_QGoLeUkR0ALRakWH+KOopHZk=29fyi-oonerd9g@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 7 Jun 2021 15:36:12 +0200
Message-ID: <CAFpoUr1vta7F7PhzsTazqwrehhiySmD71veOxTo=PTBrGhpvLg@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on unthrottle
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

> It's not the best place for this function:
> - pelt.h header file is included below but cfs_rq_is_decayed() uses PELT
> - CONFIG_SMP is already defined few lines below
> - cfs_rq_is_decayed() is only used with CONFIG_FAIR_GROUP_SCHED and
> now with CONFIG_CFS_BANDWIDTH which depends on the former
>
> so moving cfs_rq_is_decayed() just above update_tg_load_avg() with
> other functions used for propagating and updating tg load seems a
> better place

Ack. When looking at it now, your suggestion makes more sense. Will fix it.

Thanks
Odin
