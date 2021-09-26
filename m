Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D864189E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhIZPRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:17:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhIZPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:17:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632669366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsRaf8OAGX6covgXxnOnhA3KsoPYPNANd+4zdArtQfA=;
        b=gKcxH/2XXCvwbBpNOEkpn9NfnUs0BmAF9ue7/jVD5dK6Zs2MeGaM/noQKxzUZ+Frhn1R5L
        Fs2O42JSwamCSolzxJdObX9PhpMSnbf0FpYYzRzLF/4y5FZdiBiQ9YOqjM+HBclas0U2nU
        v7hYuaJYrzSGfAIakpTsbOiIzNktqzz5VNEDQwAT4awTq3PXJXQob02128N8b7gFbWwwlA
        8WU+siPeCqG0UZU9zbr5PCDkbXSjGaYlVOwFqSvzOR2vtaKHoS7a07ZYSdJTLaXvCsBZSP
        tMgP//+3TJ8RvVF/SsiXzDoEV4yJJTAdQOl3lBmXQYtQV1qHlhQwIzr9d5RxPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632669366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FsRaf8OAGX6covgXxnOnhA3KsoPYPNANd+4zdArtQfA=;
        b=habO0+wo1GRHZggq5rQ4wh+s900MFGaNY+j6d5yI8v7BKVc+PKt0TJ8n+H+LgZvhlQI6Cr
        qW5EOtFe1uxgbhDA==
To:     Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp: Wake ksoftirqd on PREEMPT_RT instead do_softirq().
In-Reply-To: <YU76mB5hzvw3xZRB@infradead.org>
References: <20210924094755.2m32pgqwrqw2cg2s@linutronix.de>
 <YU76mB5hzvw3xZRB@infradead.org>
Date:   Sun, 26 Sep 2021 17:16:05 +0200
Message-ID: <87tui7bc5m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25 2021 at 11:31, Christoph Hellwig wrote:

> On Fri, Sep 24, 2021 at 11:47:55AM +0200, Sebastian Andrzej Siewior wrote:
>> +	if (local_softirq_pending()) {
>> +
>> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +			do_softirq();
>> +		} else {
>> +			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
>> +
>> +			if (ksoftirqd && !task_is_running(ksoftirqd))
>> +				wake_up_process(ksoftirqd);
>> +		}
>> +	}
>
> At a cosmetic level this looks pretty weird.  Why the empty line inside
> the indented block?  Why the pointless negation instead of the obvious
> more straightforward order?

Yeah, the empty line is stray.

The negation is because quite some people complained in the past about
doing it the other way round as they want to see the !RT case first.

De gustibus non est disputandum :)

Thanks,

        tglx
