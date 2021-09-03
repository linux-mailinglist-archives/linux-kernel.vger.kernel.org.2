Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45A3FFE85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348542AbhICK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348440AbhICK4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:56:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D358C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 03:55:19 -0700 (PDT)
Date:   Fri, 3 Sep 2021 12:55:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630666518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvN6IMMsP49Bv/0k51LM4SGpirebIiS+8hkYgQxZAo0=;
        b=a6B8zwmAGGj7Hv50J3mZS25k0xsB6m/R3A0jgyb2dKbn4PU67QvVK07bphlzHQBXirsnGc
        Zg06V9AOo+CXTARgoXcsiyNCthglMnCO1oumN6IGWJnSqw3WEp0y/CCR0KW0bMQl0I5bRy
        DSFhi2H/5v1EOqhVngYHLSY8DQrsAA4tcg9DUOTlJOgSos92UenPiIq1G5Sa5xdOOwNlQV
        ojZAJGk3J77aF7kr3Fw6yazmcnA6qdYe2VYx/O4QAFPW3krc/ZRfB+KWZMgQLIJy3D7Maq
        9CMn//K7vXYwGU7BHg3CWZpyuQ2A91df74nnWOaFzxLYzsLzoXbH8g6HcFX24Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630666518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvN6IMMsP49Bv/0k51LM4SGpirebIiS+8hkYgQxZAo0=;
        b=cUfwObwvOi6ymRUtZylYFl4FOTmyK52l5i6dOlUDCcLnkWoXrRn+MBaaW2a3/oyRppuhfQ
        FlreO8BHC05ZGBBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        rostedt@goodmis.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
Message-ID: <20210903105516.tu33jhdhwzdwpb6g@linutronix.de>
References: <20210901222825.6313-1-dave@stgolabs.net>
 <20210901222825.6313-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901222825.6313-3-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 15:28:25 [-0700], Davidlohr Bueso wrote:
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index 4ba15088e640..3444bc709973 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -141,6 +141,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>  {
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  	struct task_struct *owner;
> +	DEFINE_WAKE_Q(wake_q);
>  
>  	raw_spin_lock_irq(&rtm->wait_lock);
>  	/*
> @@ -151,9 +152,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>  	 */
>  	owner = rt_mutex_owner(rtm);
>  	if (owner)
> -		wake_up_state(owner, state);
> +		wake_q_add(&wake_q, owner);
>  
>  	raw_spin_unlock_irq(&rtm->wait_lock);
> +	wake_up_q_state(&wake_q, state);
>  }

You keep the same wake_q in task_struct. Don't you miss states/wake ups
if a task needs both wakes? one for TASK_NORMAL and one for
TASK_UNINTERRUPTIBLE?
Side note: This wake up happens in an-IRQ off region. So there no
PI-boosting dance around as it would be the case with a sleeping lock.

Sebastian
