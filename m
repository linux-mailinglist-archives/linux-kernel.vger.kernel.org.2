Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9194533F5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhCQQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:40:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhCQQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:40:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615993065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hfp5FbCwf7b9zWj6otTTxV0pYwGHbBq667l/8N72UkU=;
        b=hxaGbQoVqqlJotXLxClA59ivKAxSwdz4nDJymE0VWp0zoqQ0s0qH8rp77kycGjDvYaX0gp
        JvesTJwMgUT8IV+7w/4C7R1X12yyzLCLsgMkyeFp+hSqTctYc+rSpgPSFH0zJNKqCVaBsg
        qlZz0cS1mhzJRQe3fOD3pX0xUQoaX+Yk3ktJjHYkDjQhZkQMG5tEdiYCyB5gNt0EyBiUH/
        ZRPJ1BS+kvkPViOwHhnKc21tY5SFIT9r8yg6/EJ6NS7H9u2Zni+0diL3Ug3VZK+vEjunW/
        w29sYMmuEmNAkDCaPxD1cslHCP93lrZiCnt6tyQ0ftSY4X9VBfDFqtjCJii6JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615993065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hfp5FbCwf7b9zWj6otTTxV0pYwGHbBq667l/8N72UkU=;
        b=Dq1wqIpvzIciBcZ8+FzAd5+TZlpfQvwY/zfr+V+we1N07ssXmyolKbEalbJ6Qm1tWQ8JCY
        WAftVYyCeXnTi+CQ==
To:     Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>
Cc:     Wang Qing <wangqing@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: swait: use wake_up_process() instead of wake_up_state()
In-Reply-To: <16b579d7e48b7ae58b77b9eaa9757566f57408b8.camel@gmx.de>
References: <1615893602-22260-1-git-send-email-wangqing@vivo.com> <4cb1a9ae15c414435020630cf6362163ddda1550.camel@gmx.de> <20210317094618.GA1724119@gmail.com> <16b579d7e48b7ae58b77b9eaa9757566f57408b8.camel@gmx.de>
Date:   Wed, 17 Mar 2021 15:57:45 +0100
Message-ID: <87y2elygie.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 11:41, Mike Galbraith wrote:
> On Wed, 2021-03-17 at 10:46 +0100, Ingo Molnar wrote:
>> * Mike Galbraith <efault@gmx.de> wrote:
>>
>> > On Tue, 2021-03-16 at 19:20 +0800, Wang Qing wrote:
>> > > Why not just use wake_up_process().
>> >
>> > IMO this is not an improvement.  There are other places where explicit
>> > TASK_NORMAL is used as well, and they're all perfectly clear as is.
>>
>> Arguably those could all be converted to wake_up_process() as well.
>> It's a very small kernel code size optimization. There's about 3 such
>> places, could be converted in a single patch.
>
> I still prefer the way it sits, but that's certainlyly a heck of a lot
> better change justification than "why not" :)

Which begs the reply "Why should we?" just for 10 bytes less of kernel
text :)
