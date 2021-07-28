Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC43D9512
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhG1SMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:12:13 -0400
Received: from mail.efficios.com ([167.114.26.124]:35412 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhG1SMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:12:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BF26C35A57C;
        Wed, 28 Jul 2021 14:12:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jJm4gYNJE0rt; Wed, 28 Jul 2021 14:12:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 424A235A7CC;
        Wed, 28 Jul 2021 14:12:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 424A235A7CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627495925;
        bh=DCZHJxLFiP6E8I4eOKiXmUsj/d99HMTbY0nKRlng7QY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=i6fv32JcVY19808NPARNqJrWuMEaTok1At36PNlRwtfo5CXh0uuTcHbFEfdi0urPo
         jEb4vuQOKLZFwsXOLMI+q5h6o2SNUvQYSNb6oBdKn6rWW8i1F7gUfw7POIAimzZzUE
         E+O5IT5aPiKyhvYCEep5gvvCma7muhyunNvUjoFXQfz0WjadRERJFwlsGJPt5XM/Cw
         AzeEaoZ8QDaFPb/uMJ05TZ00cMEdE8pRzdu//LTsoOFS0m21Z7cH8JRdelESfzVq2O
         VCdb30inUfOO7I5Iqf4C19wZoad9cHE42u77PQ8ZKhqZTw8lxjdyjKMoxPk5Xmr9GF
         Vgo0QiksY1wgg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9zjFj8PY-m9m; Wed, 28 Jul 2021 14:12:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 286ED35A63F;
        Wed, 28 Jul 2021 14:12:05 -0400 (EDT)
Date:   Wed, 28 Jul 2021 14:12:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     paulmck <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1> <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: Weaken ->dynticks accesses and updates
Thread-Index: TE/AvfqqeEQYmttB8kfeuwD9d3elxQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 28, 2021, at 1:58 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Wed, Jul 28, 2021 at 10:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>> +/*
>> + * Increment the current CPU's rcu_data structure's ->dynticks field
>> + * with ordering.  Return the new value.
>> + */
>> +static noinstr unsigned long rcu_dynticks_inc(int incby)
>> +{
>> +       return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
>> +}
> 
> Maybe inline?
> 
> But more I reacted to how we sadly don't have percpu atomics. They'd
> be fairly easy to add on x86, but I guess it's not a huge deal.

Are the percpu atomics you have in mind different from what is found in
Documentation/core-api/this_cpu_ops.rst ?

Namely this_cpu_add_return(pcp, val) in this case.

I must be missing something subtle because AFAIU those are already
available. Those per-cpu atomics don't provide any memory ordering
though, which may be why those are not used here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
