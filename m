Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7055C420772
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhJDIle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhJDIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:41:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC5AC061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zKfDV0YNjCwsU17bwwpjgv9Pzvz+7OLk3zePGdmFYy8=; b=hlLS99M+YxsFJUfufRgK/afR0W
        ke9AhprYdInkVZ9Mv2erU7XbHL9jtxpzkFdrrOaSDlvyTId9EStVoWAnvVMJhG6qU9awxJHSBp6KK
        S95QdHlOJaVVpPJfYxFpc+nM+JHNET9gi3mmEso5KUo1Hl+a0CrVPBAS+IJbvniFo7cTPPSE0Ejxu
        KxWUsaWT8uXQ0iZPbNFdllxGEqkIwgZ/szqvX9YnQnGg3Pao47a0xftztbZ/Dx8iOCvbDZuNr1mUL
        RvDgrbK8eUjfbT4ApAnZA4oiEH4ZdqIpIzzYsmcFmDW+b0mMD/6TFOycb5ljUIzK9xOyA6oWgH0OW
        AN3npNZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXJVS-007nRF-IH; Mon, 04 Oct 2021 08:39:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB97A3002DE;
        Mon,  4 Oct 2021 10:39:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 557BF20A660F3; Mon,  4 Oct 2021 10:39:29 +0200 (CEST)
Date:   Mon, 4 Oct 2021 10:39:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC 1/6] sched: Add nice value change notifier
Message-ID: <YVq9weHmEGOVsj/p@hirez.programming.kicks-ass.net>
References: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
 <20210930171552.501553-2-tvrtko.ursulin@linux.intel.com>
 <20210930183316.GC4323@worktop.programming.kicks-ass.net>
 <4aca656d-678f-4d61-38a4-d2e7a8fd89ab@linux.intel.com>
 <5c71ec04-9148-0587-c495-11dbd8f77d67@linux.intel.com>
 <YVct0D9kB1KtrwZ3@hirez.programming.kicks-ass.net>
 <01a968c9-c427-f4c7-44d5-2f47f939f9eb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a968c9-c427-f4c7-44d5-2f47f939f9eb@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:12:37AM +0100, Tvrtko Ursulin wrote:
> On 01/10/2021 16:48, Peter Zijlstra wrote:

> > Hmm? That's for normalize_rt_tasks() only, right? Just don't have it
> > call the notifier in that special case (that's a magic sysrq thing
> > anyway).
> 
> You mean my talk about tasklist_lock? No, it is also on the syscall part I
> am interested in as well. Call chain looks like this:

Urgh, I alwys miss that because it lives outside of sched.. :/

> sys_setpriority()
> {
>   ...
>   rcu_read_lock();
>   read_lock(&tasklist_lock);
>   ...
>   set_one_prio()
>     set_user_nice()
>     {
>       ...
>       task_rq_lock();
>         -> my notifier from this RFC [1]
>       task_rq_unlock();
>         -> I can move the notifier here for _some_ improvement [2]
>     }
>   ...
>   read_unlock(&tasklist_lock);
>   rcu_read_unlock();
> }
> 
> So this RFC had the notifier call chain at [1], which I understood was the
> thing you initially pointed was horrible, being under a scheduler lock.
> 
> I can trivially move it to [2] but that still leaves it under the tasklist
> lock. I don't have a good feel how much better that would be. If not good
> enough then I will look for a smarter solution with less opportunity for
> global impact.

So task_list lock is pretty terrible and effectively unbound already
(just create more tasks etc..) so adding a notifier call there shouldn't
really make it much worse.


