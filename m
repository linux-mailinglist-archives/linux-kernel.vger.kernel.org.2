Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82CE396E05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhFAHiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:38:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:38:51 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622533029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15u6uWhP2I1jq+oVfgJeSHw4B622FxtoWLjPeu9407Q=;
        b=OPsmez0N0GbK40F5PFvpAnmB8APingKGpZLb+NV3pokwR1DEKzp7403MCvsvOEni5og2yW
        v2IZ+SrtOyaCnqSpQR1e6eHA4AZ3CDWtbwE0npFIx5kV85OmBMNdv94SuQcwr6Ed9eWd93
        527SBDp2RRlthQHcRe+nlXmkbtERAjiNMlPPMSwJDsfmv3LnDp+o+Rm03Teyb2ETlG8Nnd
        GHzg2bXLuGPW+DwX+kMQ+QNu2HXD0HLGQPVFAWIfctE651axxyATGyFZhSMJ/CzJAfaE2p
        GZQxVgYeO/haVQYK1DLMnG9k5UCpD8YBdFJMrvCNsKpe+FbI4qG3cyFWDL9Q9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622533029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15u6uWhP2I1jq+oVfgJeSHw4B622FxtoWLjPeu9407Q=;
        b=048Ya0yiZKFfSdftrXnF13TD9BkCNFoLnE1V5vQ7eLjkAU141TjkJgJDcZDT7c7d+p7n8f
        wSOi4BxPTBpxmjCw==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <87y2bu2hqp.fsf@jogness.linutronix.de>
References: <20210531162051.2325-1-john.ogness@linutronix.de> <20210531162051.2325-2-john.ogness@linutronix.de> <YLWhlZy8jQR3zpun@google.com> <87y2bu2hqp.fsf@jogness.linutronix.de>
Date:   Tue, 01 Jun 2021 09:37:08 +0200
Message-ID: <87v96y2fyz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-01, John Ogness <john.ogness@linutronix.de> wrote:
>> Is there any particular reason this does
>>
>> 	preempt_disable();
>> 	cpu = smp_processor_id();
>> 	local_irq_safe();
>>
>> instead of
>>
>> 	local_irq_safe();
>> 	cpu = raw_smp_processor_id();
>>
>> ?
>
> If the lock is owned by another CPU, there is no need to disable
> interrupts for this CPU. (The local_irq_save() is conditional.)

The cpu lock implementation from dump_stack() also keeps preemption
continually enabled while spinning. I used the cpu lock implementation
from PREEMPT_RT. But for my v2 I will adopt the same ordering from
dump_stack(), as you are suggesting.

Thanks for pointing that out.

John Ogness
