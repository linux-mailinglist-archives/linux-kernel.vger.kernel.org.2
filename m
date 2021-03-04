Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8F32DB84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhCDU7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhCDU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:58:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BA9C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:58:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614891498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okpZzFCE+S/kjR2YiW6a2eXyNqNPc4VWZ1UoZTdt4R0=;
        b=euDRZRTeUVy0kkR2YRYIz8iu3IYbbMcaRDR7Fw0721nXYFm6ZH0QHJRyc7ksYZQIbuN0Vl
        NXs2UiiLx6p99lTTjd04Ss/YGagIPE+rByGqpUDHQBNRJNKqh7asfr8fbsbxTCovV2CyzX
        aF6PL1S74HIxampQ2tqbdSgcaaBOWOt+vsUeB6vHxGvz/F/fRNjkUeDRn0mBzNmpn/jG4w
        Jbp1jWzuanSBkavga1QU8TckKmekOUa7/GChmD64yFV2+N8S0ZAQJnQ8J8zgaP+89SNWws
        ffizAqVy2N6Ml3ubX2oJwgKXoiR0aZSvUW+hsJdyC+7rq0zciT+38YbdEzYw2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614891498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okpZzFCE+S/kjR2YiW6a2eXyNqNPc4VWZ1UoZTdt4R0=;
        b=zKrAHtGAZ+33kwzte2cezMBQ5pox4xJC9EqlZyyqRztMcSOw54Sc8E80MZOEArz0jtEkQP
        vkHFdD0YjmSYFEBA==
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
In-Reply-To: <m11rcu7nbr.fsf@fess.ebiederm.org>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <m1zgzj7uv2.fsf@fess.ebiederm.org> <20210304081142.digtkddajkadwwq5@linutronix.de> <87tupr55ea.fsf@nanos.tec.linutronix.de> <m11rcu7nbr.fsf@fess.ebiederm.org>
Date:   Thu, 04 Mar 2021 21:58:17 +0100
Message-ID: <87lfb263h2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04 2021 at 13:04, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>>
>> We could of course do the caching unconditionally for all tasks.
>
> Is there any advantage to only doing this for realtime tasks?

It was mostly to avoid tons of cached entries hanging around all over
the place. So I limited it to the case which the RT users deeply cared
about. Also related to the accounting question below.

> If not it probably makes sense to do the caching for all tasks.
>
> I am wondering if we want to count the cached sigqueue structure to the
> users rt signal rlimit?

That makes some sense, but that's a user visible change as a single
signal will up the count for a tasks lifetime while today it is removed
from accounting again once the signal is delivered. So that needs some
thought.

Thanks,

        tglx
