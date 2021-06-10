Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB43A2582
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:33:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A258FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D+iXKgWjzrBeu8d6K0dCcnDC4Dhm+YZkQwhSxe0dL2s=; b=pvrdJYRlHaMIW2NXjwyh+72ouu
        YEc2Le/I7FosSzu1Y4ASGdOdhAblgC9bNnJmApXgLMqtWVoFwqJfZr5niTVzhPA4L61Ao1v7ttJkb
        +5I3FEH7K8CDYcFjwZY0/bM3p+mnoGWjqvVIbVHew/I2W6F41RVnU6/LVW++u6SCp5hBlYcQ9PdKu
        BwoTXFQ4068KtRf6mkAWWqBpMtjPY1F1yZsdMMMUCfGRSCaQj5yUCOkUqFcwDqy7oO1JNqsm9y40N
        P9JjzZHBYRQieWLzESGMAOw4NxSMoe7qUaumDkngo7+6Efr4gip8w3XysGEDpTceB14beDRoWHNIF
        W2enN1aQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrFA0-005Man-RZ; Thu, 10 Jun 2021 07:31:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FCF5300258;
        Thu, 10 Jun 2021 09:31:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F0B22CCA72EF; Thu, 10 Jun 2021 09:31:33 +0200 (CEST)
Date:   Thu, 10 Jun 2021 09:31:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6] psi: fix race between psi_trigger_create/destroy
Message-ID: <YMG/1Uv5qOk0RfcX@hirez.programming.kicks-ass.net>
References: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
 <YKfBTWQxPkI5jKUe@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKfBTWQxPkI5jKUe@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:18:53AM -0400, Johannes Weiner wrote:
> On Fri, May 21, 2021 at 10:05:54AM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > Race detected between psi_trigger_destroy/create as shown below, which
> > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > and psi_system->poll_timer->entry->next. Under this modification, the
> > race window is removed by initialising poll_wait and poll_timer in
> > group_init which are executed only once at beginning.
> > 
> > psi_trigger_destroy                      psi_trigger_create
> > mutex_lock(trigger_lock);
> > rcu_assign_pointer(poll_task, NULL);
> > mutex_unlock(trigger_lock);
> > 					mutex_lock(trigger_lock);
> > 					if (!rcu_access_pointer(group->poll_task)) {
> > 
> > 						timer_setup(poll_timer, poll_timer_fn, 0);
> > 
> > 						rcu_assign_pointer(poll_task, task);
> > 					}
> > 					mutex_unlock(trigger_lock);
> > 
> > synchronize_rcu();
> > del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> > psi_trigger_create
> > 
> > So, trigger_lock/RCU correctly protects destruction of group->poll_task but
> > misses this race affecting poll_timer and poll_wait.
> > 
> > Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> > scheduling mechanism")
> > 
> > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
