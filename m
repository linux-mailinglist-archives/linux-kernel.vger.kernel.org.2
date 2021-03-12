Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB093397E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhCLUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbhCLUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:02:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:02:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615579336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZTUex9iUmioxRdB0BZBO5EmH81b4hMASMPDorRL4KI=;
        b=ojXNawhBP6s1C5bIiHUfrFe/W1mOt4ne0bpnE44RFVmJsmG/2+qlOaKEcRCZ7ySrd/Ypv7
        DSyMtPSM/cFT0sDtOgmdp+TmH0dBw3jU6US3+l6i5FFLOmit7lmzXsFqUp/5W3WinMuQNl
        9mLFmWraUEwVVGJtsshfhWotUUZ/FmnRKfVPaZKuwQoLTj/NUEl7EQ7qM9XRFblPtXi/2e
        ZY5FMQ27TMODgZY3e9YrZ0lVhaXVG8EVN5YbAym7EOOLL5DAyk0+MgOg4duw/bEDpFiwsE
        ZIzfsOr1wUmYhrceJa196C025zwD9+IvLpTSjMEBoo2FrcOUKxFolG6hlgZUIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615579336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zZTUex9iUmioxRdB0BZBO5EmH81b4hMASMPDorRL4KI=;
        b=cRoDJO70d05WfKV0flErSBYsTLb5MSd7czY4OgPXUegAI1nWfhp9omdK3GtZ2oXkWevRYG
        bV3H+hjlW/nwjdDQ==
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [patch V2 0/3] signals: Allow caching one sigqueue object per task
In-Reply-To: <m1blbpjswd.fsf@fess.ebiederm.org>
References: <20210311132036.228542540@linutronix.de> <m1blbpjswd.fsf@fess.ebiederm.org>
Date:   Fri, 12 Mar 2021 21:02:16 +0100
Message-ID: <877dmc2l9z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2021 at 15:13, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>
>> This is a follow up to the initial submission which can be found here:
>>
>>   https://lore.kernel.org/r/20210303142025.wbbt2nnr6dtgwjfi@linutronix.de
>>
>> Signal sending requires a kmem cache allocation at the sender side and the
>> receiver hands it back to the kmem cache when consuming the signal.
>>
>> This works pretty well even for realtime workloads except for the case when
>> the kmem cache allocation has to go into the slow path which is rare but
>> happens.
>>
>> Preempt-RT carries a patch which allows caching of one sigqueue object per
>> task. The object is not preallocated. It's cached when the task receives a
>> signal. The cache is freed when the task exits.
>
> I am probably skimming fast and missed your explanation but is there
> a reason the caching is per task (aka thread) and not per signal_struct
> (aka process)?
>
> My sense is most signal delivery is per process.  Are realtime workloads
> that extensively use pthread_sigqueue?  The ordinary sigqueue interface
> only allows targeting a process.

Unfortunately they use both. The majority is probably process based.

Thanks,

        tglx
