Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF343E1F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbhHEXyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbhHEXyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:54:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F18C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:54:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p145so11943547ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLYl6OwcycWJiQOocB69HVqDI1VRHTGIfy231FmhzDw=;
        b=r+UmOVmZg1Sid23KXOLJbi2qbWe3JFWnxz1Bt1wG0iJC0FrzuiYhHVe4mUw672l3Fk
         ZKZzTVFi0fm3jE27DeijLUa263z0zOC3LEeG2T8AxjUEj/qMYSrkXMWv/aSQJZVxzkUw
         F2kJ23oi9Qer6NZf0to3AD8U1e+bPQWkJIJWHcZvu7Ab+iBKLPcK+4tIbr7fOyrUgqyq
         ybTbN/Ayd+8O4mjzuj5Yjsqs3Ej2O+nX7QUNMhVYfbvYciRjtxD6/FgmdNN45fhiBkjY
         m97ZVWRYhK9xPybFeY2z/8y2glCsmw7/PL7KZM1hvBtdf0kGzwoP3tMUZFiYDFyoB+Ek
         JiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLYl6OwcycWJiQOocB69HVqDI1VRHTGIfy231FmhzDw=;
        b=It6lcFKp8RxeM4mVqgDHs4Vdn9uJv94gi3pXxOCcBSH9OwfH78PPTSMdRAD+8GfyMM
         ZBPkEaWb9Vpibs9pGRRDpn5fl4qLDcHsWSkdf+WZ9sZITyTAfTj0+niFqC2hS8npQgM3
         W4Uc7MVco4bsHglV7I72NQNWh2mEGSUqjRUzc4vuPCFnpjqSv4bLj6ylOMEb3loSFRIi
         Iy+6v+PpEOeLfhNFktHM37Ig/t3t1ovJ47KuOQ3kibZhLsH1g4z3aNQlNxvqmnC9a4CP
         Eua/4ArRvjSxN1134vR0oP1Ya2LdFAN88ddpYx58mA3dZbv2SZpR4vgkn3fhh/9VHUsD
         ZvTw==
X-Gm-Message-State: AOAM532973nH3l7PgxBVe6KZRxMDrGR/1FWQUDJNshQ2IeuUemYL6HpI
        WUMyNBhxUAEi7IQmufHJywK6aHYWeHPazBzhwAPieA==
X-Google-Smtp-Source: ABdhPJyo0St5PVeJNL5P168P4i8dTtpXHLE0XVnW4rs3oIgAObTl0VfD7Yao6Fie4uu/DhswiDa3ExmWED5j5XpfgWM=
X-Received: by 2002:a25:30c:: with SMTP id 12mr2070068ybd.212.1628207660351;
 Thu, 05 Aug 2021 16:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-2-joshdon@google.com>
 <20210805101849.GH8057@worktop.programming.kicks-ass.net> <YQwcIpnKq3TYYIIL@mtj.duckdns.org>
In-Reply-To: <YQwcIpnKq3TYYIIL@mtj.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 5 Aug 2021 16:54:09 -0700
Message-ID: <CABk29Ns5TdiiYZvY3sdA-Twgcvt3pOnRmZq4WSzoesxBrFmPeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched: cgroup SCHED_IDLE support
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 10:13 AM Tejun Heo <tj@kernel.org> wrote:
>
> Interface-wise, writing 1 to idle file is fine. This does move away
> the interface from being a purely semantical weight tree, which is a
> concern and I have a difficult time seeing that the stated benefits
> are significant enough to justify the changes. That said, this is
> primarily a scheduler decision, so if you think the addition is
> justified, please go ahead.

Thanks for taking a look Tejun. I won't restate the use-cases from
past threads here, but ideally the capabilities introduced in this
series will make SCHED_IDLE more useful (internally, we've certainly
found that to be the case :)).

Best,
Josh
