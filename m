Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628F3D7E39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhG0TCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhG0TCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:02:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF20C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:02:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627412572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=bvvrmcWu0+5UgM010iuWRGP5hqcCGNl1Xbalf2ku9I8=;
        b=vKbRDH+j+uybecn6RunROIzb/tR7f3cLmXZX0ugy2iFNtHeeeQ9kwI9710L7ZiRuU/81Gp
        f7xQrpamB6iuG/WWKIseiVX7QDebkWYEsgu3bFnSyhY7PugZ3O32QyIrQblaFJ3yAkL9Zn
        Z6nHQfj/TpCmaeC25SmfLBJxsslVoUoBR3khWkhk2KrOsSv4DSadFd5NalEVV0U0wCHx3p
        P9nX0wBSmc8K8gC85a7eZhVVsPlf3bw12Ugdr+zFqgIlse6KSn5KQAQvco1kvqUveKgsgF
        86kRdQs/y9RLLqKFbsUzgxPwrVQ5adDBPu6uMNf7lu1auoAnRMjPA4YH27a1QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627412572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=bvvrmcWu0+5UgM010iuWRGP5hqcCGNl1Xbalf2ku9I8=;
        b=FXekQx7OcMsrd7BgRYDRKmu+f4aS0BQTkmlewH4gK+jafnzTMMbX42SsVO6m1e/y6+gmas
        bt70j2SaONOPZZAA==
To:     Valentin Schneider <valentin.schneider@arm.com>,
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
In-Reply-To: <87tukfllmd.mognet@arm.com>
Date:   Tue, 27 Jul 2021 21:02:52 +0200
Message-ID: <87zgu7pokj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27 2021 at 18:20, Valentin Schneider wrote:

> On 13/07/21 17:11, Thomas Gleixner wrote:
>> +/*
>> + * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
>> + * @lock:	The rtmutex to block lock
>> + * @state:	The task state for sleeping
>> + */
>> +static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state)
>> +{
>> +	unsigned long flags;
>> +	int ret;
>>
>> -	debug_rt_mutex_free_waiter(&waiter);
>
> This does end up showing up in rtlock_slowlock_locked(), but disappears
> from the rtmutex path. AFAICT it should show up at the tail of
> __rt_mutex_slowlock_locked().

Indeed.
