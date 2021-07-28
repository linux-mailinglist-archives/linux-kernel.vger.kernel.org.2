Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B407C3D9566
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhG1Sjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:39:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:44918 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1Sjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:39:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2E49835A77D;
        Wed, 28 Jul 2021 14:39:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n02ovKwUYEnp; Wed, 28 Jul 2021 14:39:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B663935AD8F;
        Wed, 28 Jul 2021 14:39:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B663935AD8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627497574;
        bh=hz4Q+TDB5rKobUuxQy5ZrYWwx6dobvw3AwtQ5A09sxQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hybXLNeSX4F8QWh02WrntuVw2aSEorcUb2Zy5+eFJUj3GQEy44043OFQuhHRpVx7l
         eZt1IJnR1fX/Lf2uVSkoarq4fKh0lCRU/JThK1YC7aUfn2N3d62ZCLZLtf/UEalVtE
         s0xusAmIeIHGAzJB+mfSw3ld9Mv6kcy32MCcTym99JCr/3KnjvGWQWuHbr7Kqtjj3Z
         gCqraywaJ63J/zACnguQbJD90gXnjEoOEgde9BabE47L/gpJGw926B6GLNmIZXiywl
         QAAKKSufs3LT96uGaqiLP84ac64FotNk1sSTiVKvzguhGOq/Dxb1dMlzw+/cla1rEp
         ueS76JReT5l1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VxW4LVHMI1Yv; Wed, 28 Jul 2021 14:39:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9EAA835A77B;
        Wed, 28 Jul 2021 14:39:34 -0400 (EDT)
Date:   Wed, 28 Jul 2021 14:39:34 -0400 (EDT)
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
Message-ID: <1066702992.9268.1627497574534.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=wiLZYvjcj=ztF9tF0df8mSGKXwbCdxxy-JnoaE72VY5tQ@mail.gmail.com>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1> <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com> <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com> <CAHk-=wiLZYvjcj=ztF9tF0df8mSGKXwbCdxxy-JnoaE72VY5tQ@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: Weaken ->dynticks accesses and updates
Thread-Index: hdFDzu6BlE5e7R9k0VH579R89nPurg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 28, 2021, at 2:32 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Wed, Jul 28, 2021 at 11:12 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Are the percpu atomics you have in mind different from what is found in
>> Documentation/core-api/this_cpu_ops.rst ?
>>
>> Namely this_cpu_add_return(pcp, val) in this case.
> 
> Nope.
> 
> Those are only "CPU-atomic", ie atomic wrt interrupts etc.
> 
> The RCU code wants SMP-atomic, and it's mainly that we *could* do the
> addressing more efficiently.

OK, so combining the addressing tricks of this_cpu operations with
smp-atomic operations (e.g. LOCK prefix on x86). It may indeed become
worthwhile given enough users, and fast enough atomic operations.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
