Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916453E05F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhHDQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhHDQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:31:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F5CC0613D5;
        Wed,  4 Aug 2021 09:31:22 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:31:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628094681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aOC4dsj6TxzTA0IS5KEFQan2GWU0NpOoRWb6BDoMDbM=;
        b=0Zjmv52JL+nNnwB3dAkRER5TBD+gcZeq3Q+YcBdo024LpS4lzLbgBrJudIKvrbTkDAmn5K
        zwyM+uaA//PkEnlEjGiHPA8UbDKVSn9KnfmLTc7puetq6OZ9SCa7uVgFUkHPElMWOn/TN4
        fjKn8l+3+aE/n/41krCHpV1MYMDnWds5UJ7vEnlyJQRMuZ2dw49pZMywCrfYdjB6d61vej
        P2SJg3uXjkMS2mw2GgP021is7PkBsXTHiJBWTmuArIAwyz19so18n/2BYnoxqCiyx1726U
        HnalD9omt1nDxWfrwiRND1qrvdqXH6k8xL2XxvrPfRNUzP1Xp0GrOHWLrNEF0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628094681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aOC4dsj6TxzTA0IS5KEFQan2GWU0NpOoRWb6BDoMDbM=;
        b=6kf3rij4FgsTg58XVH0UFPF4O9ywZPA6KUtsNRN1ie6Ok6mN+781JilT9ttPK55d7miutC
        UaM0LrzR1MVa04AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804163119.t4c7bkpdk33byxtx@linutronix.de>
References: <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804121704.1587c41b@oasis.local.home>
 <20210804162231.rfj5i736lqc4nsio@linutronix.de>
 <20210804122541.741cf858@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804122541.741cf858@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 12:25:41 [-0400], Steven Rostedt wrote:
> On Wed, 4 Aug 2021 18:22:31 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > no preemption happens here with NEED_RESCHED set.
> 
> But if interrupts were disabled, how would NEED_RESCHED be set? As soon
> as you enable interrupts, the interrupt that sets NEED_RESCHED would
> trigger the preemption.

CPU-local wake-ups just set NEED_RESCHED and wait for preempt_enable()
to do the magic. Just because the code not perform wake_up() now does
not mean it will not do so in the future. Also it is here as an example
which might be copied somewhere else.

> -- Steve

Sebastian
