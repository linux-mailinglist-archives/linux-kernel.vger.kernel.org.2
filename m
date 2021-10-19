Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED2433B25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhJSPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233380AbhJSPw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634658646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsccSX59W4YeJaYSTM3gJiasyvFI3K5d9wkdPDLF474=;
        b=FXVgkGk+1pivUatLMgmRe029PjnBqHE394uXaFdBi1f5RkdN+dLOO320zngAquupI30cTF
        iYRVCeuoxoPXeYKA5kyocNrVGoCPxlJXCGRy1q/aJ9HuEl/UxSTbRK1TUGg2+HeAtVBLp8
        v311hSsVyrd750bgbQihPTmFk/hB3YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-T-vBfGN-MWG5s-wJ9p5bPQ-1; Tue, 19 Oct 2021 11:50:45 -0400
X-MC-Unique: T-vBfGN-MWG5s-wJ9p5bPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 283EB80A5E3;
        Tue, 19 Oct 2021 15:50:43 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90EB55DAA5;
        Tue, 19 Oct 2021 15:50:03 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2C0E84172ED8; Tue, 19 Oct 2021 12:07:18 -0300 (-03)
Date:   Tue, 19 Oct 2021 12:07:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch v4 1/8] add basic task isolation prctl interface
Message-ID: <20211019150718.GA61531@fuller.cnet>
References: <20211007192346.731667417@fedora.localdomain>
 <20211007193525.755160804@fedora.localdomain>
 <YWWIHkoAdTkzU0TP@hirez.programming.kicks-ass.net>
 <20211013105637.GA88322@fuller.cnet>
 <YWb0ycw/sNV8isBH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWb0ycw/sNV8isBH@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:01:29PM +0200, Peter Zijlstra wrote:
> That's absolutely terrible :/ you're adding extra unconditinal atomics
> to the entry/exit path instead of using the ones that are already there.
> That's no good.
> 
> Also, you're very much not dealing with that race either.

Again, because we haven't seen any use for the notification signal.

But anyway, about the general race:

CPU0                                    CPU1

sys_prctl()
<kernel entry>
                                        if (target_cpu->isolated)
                                          // checks CPU0, not userspace, queues IPI
mark task 'task isolated'
<kernel exit>

		                         arch_send_call_function_ipi_mask()

task is interrupted

----

A possible solution would be to synchronize_rcu (or _expedited if
necessary):


CPU0                                    	CPU1

sys_prctl()
<kernel entry>
						rcu_read_lock()
                                        	if (target_cpu->isolated) {
                                          		// checks CPU0, not userspace, queues IPI
cpu0->isolated = true
synchronize_rcu/synchronize_rcu_expedited

		                         		arch_send_call_function_ipi_mask()
						}
						rcu_read_unlock()

<kernel exit>

----

But that cpu0->isolated variable is not usable for the TLB flush
stuff, for example.

But regarding the question
"the inherently racy nature of some of the don't disturb me stuff":
i think it depends on the case (as in what piece of kernel code).
For example, for the TLB flush case the atomic cmpxchg loop gets rid of the race.

But the above RCU protection might be sufficient for other cases.

And about the notification to userspace, can't see a reason why it can't 
be performed in asynchronous fashion (say via eventfd to a manager
thread rather than isolated threads themselves).

> Also, I think you're broken vs instrumentation, all of this needs to
> happen super early on entry, possibly while still on the entry stack,
> otherwise the missed TLBi might be handled too late and we just used a
> stale TLB entry.

Alright, right after switch to kernel CR3, right before switch to user CR3 
(or as early/late as possible).

