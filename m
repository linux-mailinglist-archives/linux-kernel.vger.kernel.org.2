Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC43C83EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhGNLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:36:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGNLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:36:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626262403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcaBntY+oSlhBqgrCZGx/dkv2Mafgo8FgMjqNZcerkg=;
        b=tfVwLL7KilpXwfngcy8oboF5AkXvv5s05Q4WOxT/DAaU+BtWaK2WAYtBsHA9VpiIuD9FJt
        +yKAuT48FqTUywKpzulm+uwMq53Jl4RdLNtfOgeFYIfbWlpcH/lNbZtqGgnlsQ8xaURLU9
        q3SbTyC5wUC3cJZW46miadIsizbAxdWRPb9PxcGfcOfUKLbToGsizzUJz+P/sRDJOanevs
        3ikP3dyKNmwleeuycnGjigxjgcO5YCXJcMu05rluhWzg2+mI84/pWZ8P/5XTVpbtONXGqu
        va2zeeomZgfWruiyDpnOmzPexTDjrSmHK/3ydt4d8fRjmFesZbl2cZ39bV89Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626262403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcaBntY+oSlhBqgrCZGx/dkv2Mafgo8FgMjqNZcerkg=;
        b=Q9X5Zd3o/84fsKNWFpfFRmfvvvid5KIFc5EjTBeBhb3TUUeRlnF11Iheyg5qMKdlW87GwN
        xfTNrOIG4C73G3CQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 14/50] locking/rtmutex: Add wake_state to rt_mutex_waiter
In-Reply-To: <20210714101831.GC2591@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160747.320345860@linutronix.de> <20210714101831.GC2591@worktop.programming.kicks-ass.net>
Date:   Wed, 14 Jul 2021 13:33:23 +0200
Message-ID: <87lf69b058.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14 2021 at 12:18, Peter Zijlstra wrote:

> On Tue, Jul 13, 2021 at 05:11:08PM +0200, Thomas Gleixner wrote:
>> @@ -33,6 +34,7 @@ struct rt_mutex_waiter {
>>  	struct rb_node		pi_tree_entry;
>>  	struct task_struct	*task;
>>  	struct rt_mutex		*lock;
>> +	int			wake_state;
>>  	int			prio;
>>  	u64			deadline;
>
> State is 'unsigned int', but we're (luckily) not yet at the MSB so it's
> a bit moot, still...

Still. Fixed locally
