Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E063741C52D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbhI2NH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:07:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbhI2NH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:07:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632920741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7fGf3JOCmLvS/sfHyNXBRWUbSUXhk8NJHd4u4NgqeY=;
        b=ME11AodDNH3YGMSmxoYRnu2SeziGDfhyIL/dqvE7iqcDk/inPzgf0xF79mHmPR5nG177tM
        MRyp2ZztIynNhdyJhqTe8ldYwdQPSVfrQvyHjeRv6d2oHmjQ+BenGOr9xOwC0FAeBQl2z/
        Z04y99TV0a+A1Wqap3ykcnrsqXhm1w9Tqxd+SRU9SgDc+5jwO25VimC+JWzHToSyDGeTrW
        c6E2LXUmlwl2SdtIkRZaDFF3FNfd6pQ5JU+uaAbpoGzRaOTBxHm6jyMlUBQoPLC0Q/5wo9
        1px49GmsjUDSyinBd+cx8fiDvBBZYTyeFWb8/JMXYkPXXhmcH/7iflNvj6QItQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632920741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7fGf3JOCmLvS/sfHyNXBRWUbSUXhk8NJHd4u4NgqeY=;
        b=0NsK69SjO7uGIgQqOvPGOxCwFtmdE80Ag9zV1BIwdUq08oY0Hek79i/Od991NG03wTtPZA
        m9ZdAGyGAN1YuiCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 5/5] sched: Move mmdrop to RCU on RT
In-Reply-To: <YVRV2jhVIbGxd+JB@hirez.programming.kicks-ass.net>
References: <20210928122339.502270600@linutronix.de>
 <20210928122411.648582026@linutronix.de>
 <YVRV2jhVIbGxd+JB@hirez.programming.kicks-ass.net>
Date:   Wed, 29 Sep 2021 15:05:41 +0200
Message-ID: <87ilyj8rbu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29 2021 at 14:02, Peter Zijlstra wrote:
> On Tue, Sep 28, 2021 at 02:24:32PM +0200, Thomas Gleixner wrote:
>> +#ifdef CONFIG_PREEMPT_RT
>> +/*
>> + * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
>> + * by far the least expensive way to do that.
>> + */
>> +void __mmdrop_delayed(struct rcu_head *rhp)
>> +{
>> +	struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);
>> +
>> +	__mmdrop(mm);
>> +}
>> +#endif
>
> Would you mind terribly if I fold this into mm.h as a static inline ?
>
> The only risk that carries is that if mmdrop_sched() is called from
> multiple translation units (it is not) we get multiple instances of this
> function, but possibly even !LTO linkers can fix that for us.

No preference here.
