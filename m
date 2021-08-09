Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCCC3E4178
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhHIITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhHIITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD40C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:18:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628497119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dHiapdGIx1XQgnVPzSifyQPqZ+8Im0TDS7MbfUXmGCM=;
        b=yZJSvqh70cSboFE0f6UZr4jR/TnbU8oYU/nk/xdkJIMoLVkMqJIewBo4SviYke8pq4zUZb
        zffFwwUlddwqPdtT2/K5anVRS4CkZbShNpJHThaXaY5qBaGUbQgXOz8hpFhfNb4ERjKlPJ
        QUzntcJokNno/3xfl6m+DQV6GsqTui0/uSEwDlbsY7atem6NIWYpz8IyRtq7pd01Mm0MI7
        Kpts2r6ujBBsI4djN384uWY3rjKAl3lww//7+ZnSaCCX+lbsvTrn+O6lKQv/VhCP/X0H0b
        PUzI26YQ91J1QEVXmNCTmarV0lgJZmZzwGrb8JR7295iTezqvJHjh5vEFxIyYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628497119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dHiapdGIx1XQgnVPzSifyQPqZ+8Im0TDS7MbfUXmGCM=;
        b=TFhMEtLd4fyM8vz5Xdoq0qTqxAtGpIJjTR9ggBgri2PG45iGu0413r9UrDqeLPevammrEI
        J+1wdZR1O9wh8HAg==
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 58/64] futex: Clarify comment in futex_requeue()
In-Reply-To: <20210808184320.zytackz5nf37brqu@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153956.161214930@linutronix.de>
 <20210808184320.zytackz5nf37brqu@offworld>
Date:   Mon, 09 Aug 2021 10:18:38 +0200
Message-ID: <87lf5bt4ip.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08 2021 at 11:43, Davidlohr Bueso wrote:

> On Thu, 05 Aug 2021, Thomas Gleixner wrote:
>
>>From: Thomas Gleixner <tglx@linutronix.de>
>>
>>The comment about the restriction of the number of waiters to wake for the
>>REQUEUE_PI case is confusing at best. Rewrite it.
>
> This certainly reads better.
>
>>
>>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>---
>> kernel/futex.c |   28 ++++++++++++++++++++--------
>> 1 file changed, 20 insertions(+), 8 deletions(-)
>>---
>>--- a/kernel/futex.c
>>+++ b/kernel/futex.c
>>@@ -1960,15 +1960,27 @@ static int futex_requeue(u32 __user *uad
>>		 */
>>		if (refill_pi_state_cache())
>>			return -ENOMEM;
>
> Perhaps this can be moved after the nr_wake check below? No sense
> in calling refill_pi_state_cache() if the user is passing bogus
> parameters.

Yes.
