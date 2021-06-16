Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D193A9E24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhFPOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234120AbhFPOzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:55:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA6EB6105A;
        Wed, 16 Jun 2021 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623855191;
        bh=ZsjfkAZUSfYYQm0SQ91sXoN2r6em63x8jo3QgV63WRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ih1llUUBepIcelkQBN/uLty6yg7ykjRTKDjTQKDARdvYXAC8SN5NzZEwj32Q6Vb4J
         2CyEcUt0jwSvV4MKK7WnVLMZRF6/0g4SunOHKjkTbt7NnwfTSCXkuWvDRI2Xy+wDm6
         p49nyAnw5fEFkUgw7TqISw6wEv89YcwepIz0AkZ4zfIkFvTB4jY5LVe5aXKPYcMkO1
         Bt9M5SwtVhQ9IYQbsZPFztyv5x6fIn20G84DtOBffc7f0NTjmhbqI7/+HXDXSlK3L0
         P8c5clSkq59RQPMB4TmBSS9zA8XdxpObMUgoAiNyk5KycmcMRA463DQe6A/FB8KjNP
         YXlfhtm0bkI6g==
Date:   Wed, 16 Jun 2021 16:53:09 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/6] posix-cpu-timers: Force next expiration recalc after
 early timer firing
Message-ID: <20210616145309.GF801071@lothringen>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-6-frederic@kernel.org>
 <YMnHnUcufPhtnDZP@hirez.programming.kicks-ass.net>
 <20210616115923.GC801071@lothringen>
 <YMn7Zl2uc6NyUfXJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMn7Zl2uc6NyUfXJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 03:23:50PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 01:59:23PM +0200, Frederic Weisbecker wrote:
> > On Wed, Jun 16, 2021 at 11:42:53AM +0200, Peter Zijlstra wrote:
> > > I'm thinking this is a better fix than patch #2. AFAICT you can now go
> > > back to unconditionally doing start, and then if we fire it early, we'll
> > > disarm the thing.
> > > 
> > > That would avoid the disconnect between the start condition and the fire
> > > condition.
> > 
> > Right but the drawback is that we unconditionally start the threadgroup
> > counter while initializing the timer to 0 (deactivated).
> > 
> > Then in the next tick at least one thread will need to lock the sighand
> > and re-evaluate the whole list.
> 
> Yes.. but how common is it to enqueue expired timers? Surely that's an
> unlikely corner case. All normal timers will have to suffer one extra
> tick and iteration on exit, so I find it hard to justify complexity to
> optimize an unlikely case.
> 
> I would rather have more obvious code.

Ok, I'm having a try at it.

Thanks!
