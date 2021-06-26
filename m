Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6C3B4DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFZKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:09:01 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E830DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 03:06:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x6so6576703qvx.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/ThALSA9i8+T+ytNEIFmWP/SPlrjAyvMt5ymtEVgqU=;
        b=Utx1eG8n8Pf3jZY3zG+KrSFa1D+vEdINO4S2mjEb19dBUfKH6mBgHCiCLQmgDYuDu8
         lzAV6EkZm6SIjPr5xK5rmw/JMKozsrtmTJYVmuGCo6u67Vxg6KtLI7lumqkDOy/ADlik
         hTIlm7h3QzM5UagOEdAJ0VaQU/wi5YmxderHJjwHioMiSZlE6Q6tgF49/LysAV54IfSF
         T6G09k4COwAILXN8e+mCl/eGUrdwV6RB+wojDdX3QWwRN7pYHgT+JV6AJ38uc7e0mmnl
         GtgIUvRDIoFJurmM0XmiXrGvLCHf5ZN/ZRpZAFn6L6OrhbfWdKP3Cm35UsPi3kSI/neT
         xB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=T/ThALSA9i8+T+ytNEIFmWP/SPlrjAyvMt5ymtEVgqU=;
        b=fMHvt62Yb8Y23q4Kjcd7NGENk+qf+D063JqaBGTm2zwM8ZeVV2fokeaZGP0ohUrBzN
         ikO5SlumZmGnBbi5oIdF9ewIVNnE3YLy5phXjfTXwk3IYKuKoDZocw1+9cw2VwXehVuv
         Cz1LCawq20xr/ojT/dwr1g4F3fReTRrZvmUwEEwjJnjaCg7ab1Iub46pTdMKpahW30i2
         CfqCUpjIRQcyl/gtgJ+0Svb1pNvqaYQsG34HO8DND4UIiRCv9PYVXOmKcVmAYWx+hRze
         O69AqIFkbH2DrVktFsn1oqPMJJlcrmZYFbjA9G70sURURXaOARQdVsF5KMLlz83O/4QQ
         3edA==
X-Gm-Message-State: AOAM531Ggizx31j9xTkwfW/PiAnYQDDySeB0Hu86L7UYVwtV5WYhgzdd
        aWOG7L4d+yRfrULTkIR6B7Q=
X-Google-Smtp-Source: ABdhPJxLbZmVMtQ9M07jTq3YwWh495lX5hb22ATsqwjVF/5jAbcEZz3GcOeMW9pPTAutrZ51KzeEdA==
X-Received: by 2002:a05:6214:207:: with SMTP id i7mr15835046qvt.10.1624701997815;
        Sat, 26 Jun 2021 03:06:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:cde6])
        by smtp.gmail.com with ESMTPSA id a14sm5321656qtj.40.2021.06.26.03.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 03:06:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 26 Jun 2021 06:06:32 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YNb8KI5zww8Pweat@mtj.duckdns.org>
References: <20210608231132.32012-1-joshdon@google.com>
 <YMobzbLecaFYuLtq@slm.duckdns.org>
 <YNWPBDH/mQdojEu9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNWPBDH/mQdojEu9@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

On Fri, Jun 25, 2021 at 10:08:36AM +0200, Peter Zijlstra wrote:
> It's a direct concequence of the hierarchical requirement. The approach
> is the only valid one. The other relative controllers that don't do
> this, are simply broken.
> 
> Absolute controllers have it easier, they can be trivially flattened.

That's too strong a claim. e.g. iocost controller, while in a different
domain, is a weight controller which takes different trade-offs to achieve
hierarchical weight based distribution at negligible nesting overhead. There
usually are more than one way to skin a cat.

> > There are several practical challenges with the current implementation
> > caused by the full nesting - e.g. nesting levels are expensive for context
> > switch heavy applicaitons often going over >1% per level,
> 
> Yeah, and there's numerical problems you run into as well due to
> limitied precision.

Another issue is per-queue level heuristics like boosting after idle
nesting not in quite optimal ways.

> Just don't do deep hierarchies.
>
> AFAICT it's a simple matter of conflicting requirements, on the one hand
> the hierarchical thing is required, on the other hand people seem to
> think all this crap is 'free' and create super deep hierarchies and then
> complain shit don't work right.

The problem is that the overhead is significant enough even at pretty
shallow levels. Even at just two/three levels, the cost is already
significant enough for some large-scale applications.

Thanks.

-- 
tejun
