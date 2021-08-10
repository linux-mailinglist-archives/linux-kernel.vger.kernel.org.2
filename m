Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E23E3B52
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhHHQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 12:15:50 -0400
Received: from foss.arm.com ([217.140.110.172]:43358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhHHQPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:15:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C6E31B;
        Sun,  8 Aug 2021 09:15:25 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF8023F718;
        Sun,  8 Aug 2021 09:15:22 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 2/4] sched: Introduce is_pcpu_safe()
In-Reply-To: <800ff941e3ec86ea1397cddf8ecea3d4a17c55dc.camel@gmx.de>
References: <20210807005807.1083943-1-valentin.schneider@arm.com> <20210807005807.1083943-3-valentin.schneider@arm.com> <800ff941e3ec86ea1397cddf8ecea3d4a17c55dc.camel@gmx.de>
Date:   Sun, 08 Aug 2021 17:15:20 +0100
Message-ID: <87a6lrap5z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/21 03:42, Mike Galbraith wrote:
> On Sat, 2021-08-07 at 01:58 +0100, Valentin Schneider wrote:
>>
>> +static inline bool is_pcpu_safe(void)
>
> Nit: seems odd to avoid spelling it out to save two characters, percpu
> is word like, rolls off the ole tongue better than p-c-p-u.
>
>       -Mike

True. A quick grep says both versions are used, though "percpu" wins by
about a factor of 2. I'll tweak that for a v3.
