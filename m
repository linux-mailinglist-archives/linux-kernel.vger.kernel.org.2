Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1D3A3C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFKHBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:00:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6492C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m5lK4e9TJO8XBB5y/cSdJU8Jwl1I4V/g2KT+i3cvhZw=; b=Cw76PfspyfCMvt+m2QGfnsBi0g
        i3s/imGSh6wVXFsJ3tTVKqWT/ad5rQTLDJiCKijhiqJS3mnO/JDyOfBbD1smmjSDr+8sXXI1Dm7YB
        /M+4PPGmo7gApQ3M92hITaHRWRYn4IFSe8cdlmCSr7Vo/m4OmMCaybESngzttLgpuIIU8X+++hMvS
        DrJrJkh4Wo/i+RQqZz7tlPQ/8gV1OrxRVTV7m1R11d5Vm67EVEVpTqbtydb6N38mlT34EnHc+gOpq
        +U/ItooiO9bNTKFoTIOZS2lRRazlunS1J8mpX9yeTJ2QWDG6XwtIRWLfpyhellrP9biItDCbcsuoU
        oRLmsOlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrb7b-005nsG-3H; Fri, 11 Jun 2021 06:58:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8171300091;
        Fri, 11 Jun 2021 08:58:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC09A2027ABFC; Fri, 11 Jun 2021 08:58:31 +0200 (CEST)
Date:   Fri, 11 Jun 2021 08:58:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [Resend PATCH v6] psi: fix race between
 psi_trigger_create/destroy
Message-ID: <YMMJl+zinu3Ohw43@hirez.programming.kicks-ass.net>
References: <1623371374-15664-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznH34=fTybuJyd0H6ceB48EKLT77m4C2QkRNS5LhCc6h3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznH34=fTybuJyd0H6ceB48EKLT77m4C2QkRNS5LhCc6h3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 08:37:05AM +0800, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Race detected between psi_trigger_destroy/create as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. Under this modification, the
> race window is removed by initialising poll_wait and poll_timer in
> group_init which are executed only once at beginning.
> 
> psi_trigger_destroy                      psi_trigger_create
> mutex_lock(trigger_lock);
> rcu_assign_pointer(poll_task, NULL);
> mutex_unlock(trigger_lock);
>                                         mutex_lock(trigger_lock);
>                                         if
> (!rcu_access_pointer(group->poll_task)) {
> 
> 
> timer_setup(poll_timer, poll_timer_fn, 0);
> 
> 
> rcu_assign_pointer(poll_task, task);
>                                         }
>                                         mutex_unlock(trigger_lock);
> 
> synchronize_rcu();
> del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> psi_trigger_create
> 
> So, trigger_lock/RCU correctly protects destruction of group->poll_task but
> misses this race affecting poll_timer and poll_wait.
> 
> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> scheduling mechanism")
> 
> Co-developed-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Co-developed-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---

You really should've preserved the tags from Suren and Johannes, I've
added them. Also the Fixes: line shouldn't wrap and should be attached
to the other tags (no whitespace between), also fixed that. And I've
also made another few small edits.

Please pay attention to these things for next time.

Patch can be found in my queue and should show in tip/sched/core
somewhere on Monday if the robots don't hate on it.
