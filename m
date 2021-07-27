Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7A3D7C11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhG0RUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:20:16 -0400
Received: from foss.arm.com ([217.140.110.172]:41656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhG0RUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:20:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB70A31B;
        Tue, 27 Jul 2021 10:20:14 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31A843F70D;
        Tue, 27 Jul 2021 10:20:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 10/50] locking/rtmutex: Provide rt_mutex_slowlock_locked()
In-Reply-To: <20210713160746.897411744@linutronix.de>
References: <20210713151054.700719949@linutronix.de> <20210713160746.897411744@linutronix.de>
Date:   Tue, 27 Jul 2021 18:20:10 +0100
Message-ID: <87tukfllmd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/21 17:11, Thomas Gleixner wrote:
> +/*
> + * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
> + * @lock:	The rtmutex to block lock
> + * @state:	The task state for sleeping
> + */
> +static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state)
> +{
> +	unsigned long flags;
> +	int ret;
>
> -	debug_rt_mutex_free_waiter(&waiter);

This does end up showing up in rtlock_slowlock_locked(), but disappears
from the rtmutex path. AFAICT it should show up at the tail of
__rt_mutex_slowlock_locked().
