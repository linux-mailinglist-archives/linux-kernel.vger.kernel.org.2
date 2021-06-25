Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23523B406F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhFYJ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhFYJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:27:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB3EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dMY13I84dJhIYMfvS1RIUCTZQHlkbDFJwuVqw/xla9o=; b=Bage5B+IKEi/d2/kEmdBJUTaIL
        uduNNAFJLqp9bRKi2mrC5OrNptagawKlKMLhLahxCPCm8nyr5JuH4TZ8IUgyogE8lDw2Di7UplKXC
        qZ4DH1fSKtx3kbOksdqZVZAnjfHpX2PzYWSMVtqUKdQzXn1MPg+fefw53N3nqnsB86eWHl6U+gmkb
        U1fqob3AQbIErtLGCpWnDCPUfoUj8JopyTqGj/t5+HcVsnWy1v1JCo4Z4aFj/a026QHa6j25we8gB
        ySlJndqNAxalHky7S8evCZpQmLcwmRBrCIngc9KwG8f5XUHdlT1HbTiR/7A0ZZC4uAXIFZt3opRoo
        70yepG2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwi4P-00BWpS-6g; Fri, 25 Jun 2021 09:24:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74DD0300252;
        Fri, 25 Jun 2021 11:24:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51EAA200B392D; Fri, 25 Jun 2021 11:24:22 +0200 (CEST)
Date:   Fri, 25 Jun 2021 11:24:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YNWgxrX4xfa8l0oF@hirez.programming.kicks-ass.net>
References: <20210608231132.32012-1-joshdon@google.com>
 <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
 <CABk29Nu=mxz3tugjhDV9xCF7DRsMi9U747H+BqubviEva36RUw@mail.gmail.com>
 <7222c20a-5cbb-d443-a2fd-19067652a38e@arm.com>
 <CABk29NtVRG8cotfbK=R0kKXuKCnkEG514H=6ncri=CM8Qr9uiQ@mail.gmail.com>
 <f48b5233-ce60-7e1a-02e6-1bfbcc852271@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48b5233-ce60-7e1a-02e6-1bfbcc852271@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:06:57PM +0200, Dietmar Eggemann wrote:

> I agree. `cpu.idle = 1` is like setting the task policy to SCHED_IDLE.
> And there is even the `cpu.weight.nice` to support the `task - tg`
> analogy on nice values.
> 
> I'm just wondering if integrating this into `cpu.weight` and friends
> would be better to make the code behind this easier to grasp.

Magic weight values are dodgy imo. Easiest to have an explicit idle knob
which then disables the weight knobs.
