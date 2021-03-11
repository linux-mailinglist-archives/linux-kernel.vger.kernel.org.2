Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF93372FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhCKMpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhCKMpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:45:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:45:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615466721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG40CuSy0fez7l/xJZjpxowOZyasQXiGzrUgMjGjp44=;
        b=mIKwasz2hl1DnR8sFf8HkCDYDbkWDVdc4pwClnpM01LSO3nmhyuN5uqV6eiW1A6VrlTgtG
        86J9pcMka7g9y5lYrb+7f+JirWZwRZ4/+Nmxv1y8QeA4+JPaFm+AocC/mRX3T+N5xxsQwZ
        9CSuXO7eGvT2E3iOB5dJAhe9GRBT62j7rUGrEY1XrBJMz6LGsIx0+oHxxNgpF7eaYW1Rp9
        gJyxiugUKsr5phFPd7hKd9dUqhUpH1BR7/u6Rf8pEreAwWX//jJ9PqzP7RVQLjhQlDeqmt
        UvDXXa+SAeRiPU4z0oJkRy9ZxETEVG0zIhB7aFz9Fz1U8bggpu+G69aXPEBBRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615466721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG40CuSy0fez7l/xJZjpxowOZyasQXiGzrUgMjGjp44=;
        b=oYD01rJOoBPhHWBsptMnYIzXfNmxTTVEdnmw0J2pUaIHpol17QUn7A4am8+ufJMnnQ9P/o
        5WPzAp/jGDB+raBA==
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
In-Reply-To: <87mtva4l6o.fsf@nanos.tec.linutronix.de>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <m1zgzj7uv2.fsf@fess.ebiederm.org> <20210304081142.digtkddajkadwwq5@linutronix.de> <87tupr55ea.fsf@nanos.tec.linutronix.de> <m11rcu7nbr.fsf@fess.ebiederm.org> <87lfb263h2.fsf@nanos.tec.linutronix.de> <87sg524z6t.fsf@nanos.tec.linutronix.de> <m1pn06oeno.fsf@fess.ebiederm.org> <87mtva4l6o.fsf@nanos.tec.linutronix.de>
Date:   Thu, 11 Mar 2021 13:45:20 +0100
Message-ID: <87a6r95067.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2021 at 00:56, Thomas Gleixner wrote:
> Rant aside, there is no massive benefit of doing that caching in
> general, but there is not much of a downside either and for particular
> use cases it's useful even outside of PREEMPT_RT.
>
> IMO, having it there unconditionally is better than yet another special
> cased hackery.

Just did some micro instrumentation to measure the time spent in
__sigqueue_alloc/free() with and without the caching.

Unsurprisingly that results in a time reduction of ~67% saving about 3us
per alloc/free pair. Not hugely relevant for a kernel build but for
anything which is signal heavy it'll make an difference.

Thanks,

        tglx

