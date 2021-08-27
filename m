Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157B43FA17D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhH0W2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0W21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:28:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368DC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:27:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630103255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91e94HHhZSMJLJbiqoHXaf8evhWKVBIWRThhwAs8N8c=;
        b=pr9SMZf5OvBBScP5arA0G+Dei2FPgg/CSBER/ikOPBMZsy+Fs4uOSALFNbDV3jtCKQ69oR
        Wj7rupvq+MjfMBJguOcPf1zfLL3dUdl86pmUJh1dQalwzbcYaXOsIdz4SeNmy64QqhO2qs
        p+esBVDqyt12pKPSVirt2UdPX6P3JciMS6fME3JQstq7bx68M2dHAu7OwjIMx1hPvq0Bal
        2BjxV9FECZUgl8pq0S3yvwzPhaf7SS2X1r9pD5l5u9Xd+6I9E1jkh4/HRXkY39Agdk0J0l
        qU5hvecpFGiG5Lx1jcx7fK6uOUponFt7ruwoCF56xvjW2em20exHIWwbxGxUEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630103255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91e94HHhZSMJLJbiqoHXaf8evhWKVBIWRThhwAs8N8c=;
        b=v2qv6EcY4LuQe0ZlaFhlBl5W2FIus8sXideIlKNV8oXso0uGhrxzjVcekWReg91KfwJKIY
        k8m3VC8YVIJN7SCg==
To:     Wang Qing <wangqing@vivo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RESEND] softirq: Introduce SOFTIRQ_FORCED_THREADING
In-Reply-To: <1629689583-25324-1-git-send-email-wangqing@vivo.com>
References: <1629689583-25324-1-git-send-email-wangqing@vivo.com>
Date:   Sat, 28 Aug 2021 00:27:34 +0200
Message-ID: <87k0k61q21.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang,

On Mon, Aug 23 2021 at 11:33, Wang Qing wrote:

> At present, whether the softirq is executed when the interrupt exits 
> is controlled by IRQ_FORCED_THREADING. This is unreasonable. It should 
> be split and allowed to take effect separately.

There is nothing unreasonable about it. When interrupt force threading
is in effect then it obviously requires that soft interrupt processing
goes into threaded mode as well. But the threaded execution still takes
place when the force threaded interrupt handler completes. Only softirqs
which are raised from hard interrupt context (e.g. timer interrupt) are
forced off to ksoftirqd.

What you are proposing here is completly different as you enforce
softirq execution in context of ksoftirqd only.

> At the same time, we should increase the priority of ksoftirqd when
> forbidden to execute in interrupt exits. I refer to the implementation 
> of PREEMPT_RT and think it is reasonable.

What are you referring to? PREEMPT_RT does not modify the priority of
ksoftirqd. If system designers want to do that, then they can do so from
user space. 

And doing so can be problematic depending on the workload as this
effectively breaks the softirq overload mitigation mechanism which
depends on deferring to ksoftirqd so that e.g. the consumers of received
network packets can be scheduled and the system can make progress.

Just because it does not break on your system with your particular
workload and configuration does not make it suitable for general
consumption.

> +#ifdef CONFIG_SOFTIRQ_FORCED_THREADING
> +static inline void invoke_softirq(void)
> +{
> +	wakeup_softirqd();

Depending on the configuration and timing this breaks any early boot
mechanism which depends on softirqs being handled before ksoftirqd is
available. This was clearly never tested with full RCU debugging
enabled. 

Aside of that the changelog lacks any form of technical analysis and
justification for this. Just claiming that things are [un]reasonable and
making uninformed statements about PREEMPT_RT does not qualify. Quite
the contrary it's definitely unreasonable.

Thanks,

        tglx


