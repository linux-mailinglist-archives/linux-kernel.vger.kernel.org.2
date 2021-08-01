Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116D73DCDE5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhHAVSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 17:18:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHAVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 17:18:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627852700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O35SFMUMXzb9B84YG5Z+hDPNHNRlrw4HbX7fTFJP/C4=;
        b=O0x5ajZh9CdV/SKgpxGD9ABh0RSypmwXnPh3qfu3R6H4hw6H/rX36uWeh2Z5ApeWC90dLd
        3i+5VsGKJEde2pIg68yDe0dIqIIjd/GThRN0e3Ue76isVIM0LFZ+tuA2gZKkSIXNzPScBi
        EArRwaIWq+ugrWJ/8r3djXbg+VrT0QoBmxAbmTw9X2spuasAYlP2IsWtlOS7lQ97QxuSre
        INS6p8cwEHxpJo0g7JYEUyV0Ostw2IjJlBpIS4oZWAbQOtuCB1MY9h1mtJ1v3lvF9q17/7
        W2vfrp6gBneaqBDYu62TRt7w1+7cg7RD2Jy6ls3stWyGaXew6vDsZw9SIBAkvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627852700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O35SFMUMXzb9B84YG5Z+hDPNHNRlrw4HbX7fTFJP/C4=;
        b=92z9vyGtuDwJ1OFkTPmgnVYc1hplEStx2UKijRu8v2cWaZ2+JZeMU38TBXgT28v6N+kHL/
        sQtyijrbAKdNcUBQ==
To:     Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
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
Subject: Re: [patch 50/63] locking/ww_mutex: Implement rtmutex based
 ww_mutex API functions
In-Reply-To: <9c710ceb11c98797f77fb90b483761a2eecac425.camel@gmx.de>
References: <20210730135007.155909613@linutronix.de>
 <20210730135207.978916983@linutronix.de>
 <9c710ceb11c98797f77fb90b483761a2eecac425.camel@gmx.de>
Date:   Sun, 01 Aug 2021 23:18:19 +0200
Message-ID: <87tuk83lus.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31 2021 at 15:26, Mike Galbraith wrote:
> On Fri, 2021-07-30 at 15:50 +0200, Thomas Gleixner wrote:
>
> ...
>> --- /dev/null
>> +++ b/kernel/locking/ww_rt_mutex.c
>>
> ...
>> +int __sched
>> +ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ct=
x *ctx)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __ww_rt_mutex_lock(loc=
k, ctx, TASK_UNINTERRUPTIBLE, _RET_IP_);
>> +}                                                ^^typo

Ooops.
