Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEF3E05CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhHDQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbhHDQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:22:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91DC0613D5;
        Wed,  4 Aug 2021 09:22:34 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628094152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYAu+x/wAlGvb/Mk3k0JT/DRiAXNKYQWd63guiFfZG4=;
        b=dsSnqlrsS+kJGLUNtVOx6VUnKY0gldGjRifRsZbHXPISJH09MPnHz3WctVMULa7tYoMvA5
        Aw8dpbFZL70KCt/8aFaSmC1cRnWSst7lKyBn8Uxm1QBX3GMpyKRlMh2AvI5cShNnklVEud
        BAd8zHi3lPHiI/K3k052RN3J4FCy6JLvVVDT0MT+I36lC3Wo5g2QJgaEy6qtugWakCWIbu
        LV6GS318yt7LQIEc0Jglcpreoka/H+AB5KnwalHW2WDPzbt0ONP2YYiI9tgbL0r+mEoTgY
        DXa/FIJPtPSEKqrZUuMByDOxMQJLPlZuu+blzvBNA43eqrcylrkHkcp6Y91DSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628094152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYAu+x/wAlGvb/Mk3k0JT/DRiAXNKYQWd63guiFfZG4=;
        b=tvu6dZTlyWOa8Np7RFGAqI1yqmsyEgi0kwXBBq0DDkKGUX+qN8rK5Fx1BFI9e0bsXLjfHQ
        Ylqds5yuk40P7iCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804162231.rfj5i736lqc4nsio@linutronix.de>
References: <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804121704.1587c41b@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804121704.1587c41b@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 12:17:04 [-0400], Steven Rostedt wrote:
> Perhaps in this situation, we could open code it to:
> 
>   	if (stall_hash != -1U) {
> 		raw_spin_unlock(&wqe->lock);
> 
> 		/* On RT the spin_lock_irq() does not disable interrupts */
> 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> 			local_irq_enable();

no preemption happens here with NEED_RESCHED set.

>  		io_wait_on_hash(wqe, stall_hash);
> 
> 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> 			local_irq_disable();
> 		raw_spin_lock(&wqe->lock);
>  	}
> 
> Note, I haven't looked at the rest of the code to know the ripple
> effect of this, but I'm just suggesting the idea.
> 

Sebastian
