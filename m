Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA91840A76A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhINHcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbhINHct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:32:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2DC061768
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:31:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631604687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34FW6tNKnl2UHqN1zaauAKT0jdtLuod+8k5VEJEgY2A=;
        b=3bTuF3tTSA/JJTpr+ZaHAdO0F3QuG0WozHhBs9s9gNOVf8lBWYLT/J4AKfemu4MKH95Ov9
        I9wp0RTIQskm+JgkPf3vymhRiYRT+9uUiHiwX00uMuu6pjV/jpusLEAZcAvVsy3AX5oJmk
        OjeWVeKmGdvK4+W1DN+IBxiA3T+KVvXrfQuCePYowAbIcNTLvVcPPszp0CmtSY0kM2cj/m
        P0fAhMZHpn1p6M4NcWVAEBjIBfBJMZZ2U+hjNEHtLZmag8n+z1xbUQ/I2OTk103x3MjNke
        PDYwT15y+SpfkV0b4bqLUrOpCzyau7mf72m2dcb3+AGkS5clcB5mQ3WapiNXBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631604687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34FW6tNKnl2UHqN1zaauAKT0jdtLuod+8k5VEJEgY2A=;
        b=uS8Jm9In03bUsvznUhkDPVUjm2P/5CF24cL3mU3Z7Yc0YngTyqm7ThhmzDioIQh8A8iHH0
        3TUTITT9TYsxAIAg==
To:     Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/4] locking/rwbase: Properly match set_and_save_state()
 to restore_state()
In-Reply-To: <20210909110203.828203010@infradead.org>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.828203010@infradead.org>
Date:   Tue, 14 Sep 2021 09:31:27 +0200
Message-ID: <87mtofehps.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2021 at 12:59, Peter Zijlstra wrote:
> Noticed while looking at the readers race.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/rwbase_rt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -220,7 +220,7 @@ static int __sched rwbase_write_lock(str
>  	for (; atomic_read(&rwb->readers);) {
>  		/* Optimized out for rwlocks */
>  		if (rwbase_signal_pending_state(state, current)) {
> -			__set_current_state(TASK_RUNNING);
> +			rwbase_restore_current_state();

Right, that's functionally equivalent and makes the code more consistent.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
