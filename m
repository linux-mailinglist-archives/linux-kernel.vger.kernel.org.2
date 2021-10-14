Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9B42DB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhJNO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:26:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C91C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XeOyDQkq1uPXVeW24zX/26vNnS1ATHn1F0LAI5O9ioA=; b=kmBbNpOiO5do7yv3mmUvroGyby
        IgF2SKwEPtcfhKy7XK74HN3tbEvzNvDvttdEDRqNiaDCUsu7rfIIa88KMkq2Oc/5cG5mRipJT+aBT
        w2isuO2YltnZb3m6Fa4vkUFEbi3PUZ+7icaMa5t9t+CwrQnEmWhZGf/o5egMw72m5uVpamWIX6+wT
        djrdrqimAHBB/5QECgOc2lbWHmaTZ419vINmcfaNEViN2fPG8BD0u5JWFNQjCBsfA+W8ndJi6Xu94
        1cQnQwfjUs1+kJkDVlca6gqeIo65idlH6zC1Yf8ufjG1LzbcB7U1+tJOO9TG7/Vlq5SUZ2UaMVOV1
        EKAs/xvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb1eZ-009qfL-65; Thu, 14 Oct 2021 14:24:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B48423001E1;
        Thu, 14 Oct 2021 16:24:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 863602CE91EE8; Thu, 14 Oct 2021 16:24:13 +0200 (CEST)
Date:   Thu, 14 Oct 2021 16:24:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/core: forced idle accounting
Message-ID: <YWg9je0wEJsNAd3M@hirez.programming.kicks-ass.net>
References: <20211008000825.1364224-1-joshdon@google.com>
 <20211009155435.GW174703@worktop.programming.kicks-ass.net>
 <CABk29Nu6F4__ryF5p0En--Ze6CCev1Jy81W=LkTYaacf-YLkFg@mail.gmail.com>
 <YWV/HNDJaIAOLdrt@hirez.programming.kicks-ass.net>
 <CABk29NucE__6r3P64Ts3Nbf4sUy5Zkw1sbNNnab9KZ=68ydy=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NucE__6r3P64Ts3Nbf4sUy5Zkw1sbNNnab9KZ=68ydy=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:45:28PM -0700, Josh Don wrote:
> On Tue, Oct 12, 2021 at 5:27 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > > We scale by the number of cpus actually forced idle, since we don't
> > > want to falsely over or under charge forced idle time (defined
> > > strictly as time where we have a runnable task but idle the cpu). The
> > > more important scaling here though is the division over the number of
> > > running entities. This is done so that the aggregate amount of forced
> > > idle over some group of threads makes sense. Ie if we have a cpu with
> > > SMT8, and a group of 7 threads sharing a cookie, we don't want to
> > > accrue 7 units of forced idle time per unit time while the 8th SMT is
> > > forced idle.
> >
> > So why not simply compute the strict per-cpu force-idle time and let
> > userspace sort out the rest?
> 
> Do you mean to compute force idle solely as a per-cpu value? I think
> that would be fine in addition to the per-thread field, but a
> desirable property here is proper attribution to the cause of the
> force idle. That lets system management understand which jobs are the
> most antagonistic from a coresched perspective, and is a signal
> (albeit noisy, due to system state and load balancing decisions) for
> scaling their capacity requirements.

Urgh, reading is hard. I hadn't noticed you did per-task accounting (and
the original changelog doesn't clarify this either).

Also, should all this be undef SCHED_DEBUG ? Or be part of SCHEDSTATS ?
