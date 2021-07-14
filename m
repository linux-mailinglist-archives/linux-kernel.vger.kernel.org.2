Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2A83C8210
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhGNJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:54:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhGNJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:54:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626256274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5fJRzonGN9uQmme0/djkgIoQ/GhoQQzRXG1HoHzAP8=;
        b=E8rv9zkmiuP0AMHOg275EmBnnXZvZ3ZBn+s6ygH6fAkrqbA4184R4YXxWpwGjSrwmi9sES
        TAIE94AuV250j1P2vyfIzejy+yK3oCNJowE2Npf88V7nKB0cmF11mtVmVIsaiXXKfdGUjT
        Qrmq+vx7zU0BaadfVuHaLP/q6FEiZ0sXuL8+GMfY06wTwCPXbPA5p+ynSVb+1PzeOqKeTc
        bjufKsHybp8jbar85E4CNUm0onvYFw0oqazB+nrxCfIdRX1FqJxGaLAexqzpDzwKLOY6AF
        s2Mes51GFvBQyjoAlLkUsXnJbkCGuEPJQHhvyQOWHovw1Ff/rmO13ns0QmOreA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626256274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5fJRzonGN9uQmme0/djkgIoQ/GhoQQzRXG1HoHzAP8=;
        b=7WfdmIqyGNseiWMY7kVoDy3zQE6mKW4Reso9ZUZocTmhyO62FjebaGu2bw8Qe99OBTW09D
        PJcwKSt0tzJLmJAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 16/50] locking/rtmutex: Use rt_mutex_wake_q_head
In-Reply-To: <20210714085557.GD2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160747.508939354@linutronix.de> <20210714085557.GD2725@worktop.programming.kicks-ass.net>
Date:   Wed, 14 Jul 2021 11:51:14 +0200
Message-ID: <87v95db4vh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14 2021 at 10:55, Peter Zijlstra wrote:
> On Tue, Jul 13, 2021 at 05:11:10PM +0200, Thomas Gleixner wrote:
>> +	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
>> -	DEFINE_WAKE_Q(wake_q);
>
> The naming doesn't really line up nicely... Would DEFINE_RT_WAKE_Q()
> work?

Sure.
