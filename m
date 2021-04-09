Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF235A031
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhDINnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDINnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:43:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8719DC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 06:42:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617975768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mJJvLHZKmQzpypZSHhde2DjzKGg2XyWeDcqmg718kA=;
        b=0PEbUQT9Vihz9V1BE5Nh9y0MtPn+Q22WSykkqKTMYoK5b0pq2pfh6N7Yi+7gIXJVkLiYY2
        8zlIsLb/GmyRrgQGIGbt8LMWwtGfrYoKn9Ow+uUu7X/b/gJsyn7CJypFBIiHr7CQy0cpv4
        1XPx1ocVhAQqVlUwuKgbhBCIH3Jk65Y1mamihaZ83cZwYfC0f3F1CbW1AzlLrk+6S8We6O
        jhHAAxWVUPsbRZot4mXzmxCymricTRjMZJeAQsb4aFflwCFGAOvnziqMvpKOB5lIHneEzJ
        v7v09oYD11iwXa5QRqFY2/dYSBYbybL6eCUg6qLsw3QUhSKX5t6H8tF3BHZ/Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617975768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mJJvLHZKmQzpypZSHhde2DjzKGg2XyWeDcqmg718kA=;
        b=jVKW32bES4JywV/2ikV/B2BQZMpg1q5JhKiOKBnW3+T5ZoV/dMXR+wxvdwPFxbDHK66hml
        mw/rsMwfs9uFkCDQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] Add split_lock
In-Reply-To: <YG7YWiaEZ1VKqFmb@hirez.programming.kicks-ass.net>
References: <20210408052338.3722069-1-willy@infradead.org> <YG7YWiaEZ1VKqFmb@hirez.programming.kicks-ass.net>
Date:   Fri, 09 Apr 2021 15:42:47 +0200
Message-ID: <87y2dr4lrc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08 2021 at 12:18, Peter Zijlstra wrote:
> On Thu, Apr 08, 2021 at 06:23:38AM +0100, Matthew Wilcox (Oracle) wrote:
>> bit_spinlocks are horrible on RT because there's absolutely nowhere
>> to put the mutex to sleep on.  They also do not participate in lockdep
>> because there's nowhere to put the map.
>> 
>> Most (all?) bit spinlocks are actually a split lock; logically they
>> could be treated as a single spinlock, but for performance, we want to
>> split the lock over many objects.  Introduce the split_lock as somewhere
>> to store the lockdep map and as somewhere that the RT kernel can put
>> a mutex.  It may also let us store a ticket lock for better performance
>> on non-RT kernels in the future, but I have left the current cpu_relax()
>> implementation intact for now.
>
> I think I like it, but I'm not sure it'll work for RT as is. It's a bit
> like qrwlock in that it only uses the internal (split) lock for
> contention, but that doesn't work for PI.
>
> I've not recently looked at RT, but I think they simply used to bloat a
> number of the data structures with a real lock. Sebastian and Thomas
> will know better.

Correct, but it depends on the nature of the bit spinlock and the lock
held times. Some of them we just keep as is as it's not worth the
trouble.

Thanks,

        tglx
