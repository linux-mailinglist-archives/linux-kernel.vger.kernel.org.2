Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068EB33261B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhCINGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCINGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:06:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CC0565272;
        Tue,  9 Mar 2021 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615295182;
        bh=8dDtZs1QrcLkc249LnwPHsr1SeDTjrZFb5dC6gqbGCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9gLV0nqj7NwFJEAyh0l4oS0Thk6zuQCdN4bYGVHd/YbI7ep6dELaeKvIZ1+FCfY+
         fFyJ+KYIYBS6wYAKdKmNOYfJZQ6mGEhOqIQM+dFtozNmQCsb+GymmJv2bbiaqW1G5l
         0m6NoDXgscczbFBThvnCaDXY448i5gRhnXu5YfB5DXhdCwFz0j906pOR1CtH6o8vWB
         n7l7I5AfGAQfIIFOjN3M8vGmMudS+7qr+DYQa6sXHetodank7Hv3V7EPGv4ZMoDV0u
         gXkC0n+fTkO2B49dRmI+yM3uk55tRimbkzjc8IJhu5/5vDUOhqMt0BPkVdOwEh77mr
         V3KP2KOzqbATQ==
Date:   Tue, 9 Mar 2021 14:06:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V3 6/6] rcu: Prevent false positive softirq warning on RT
Message-ID: <20210309130620.GB236340@lothringen>
References: <20210309085552.815026890@linutronix.de>
 <20210309085727.626304079@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309085727.626304079@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 09:55:58AM +0100, Thomas Gleixner wrote:
> Soft interrupt disabled sections can legitimately be preempted or schedule
> out when blocking on a lock on RT enabled kernels so the RCU preempt check
> warning has to be disabled for RT kernels.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
