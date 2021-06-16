Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06C53A9998
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhFPLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhFPLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:53:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAF2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BILF6/R+VB8OzefHhcVLIuTdGh6RLRSzEmoeurdnr4A=; b=Hu6rNDrtrbbjEeIWnoRUB49PtL
        Zz/w/kIccIfwAnSysECfzVW6PQggYkLNyHS+eDhZHoa+tXgULkNEDe/Poefo6If3f1BQ/x3clKtpq
        qbQyd0MNnFArP3rNEmWdXsdrL6pooUSmohzYxiniG+aT/sP6bezcmYQXXruGKFcV5OUKGDYLBldLz
        03Z9yoZ3RtCVFvsnY8JvrJh9LC3R0Zlz7hlitHaHvSBtP5XT64ED8HkNKXZks58FeHV025Ng1g7C0
        HUm5nHj3nNGihLNSzT9PhQ7tRModq7pBKfw3uRP+k/xkJYUpgOiF9TwzdjOEv019szGMx2Ll54lf0
        Dq3uj3Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltU41-007zjd-8k; Wed, 16 Jun 2021 11:50:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BD78300252;
        Wed, 16 Jun 2021 13:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8552420277F84; Wed, 16 Jun 2021 13:50:32 +0200 (CEST)
Date:   Wed, 16 Jun 2021 13:50:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime
 counter if timer is disabled
Message-ID: <YMnliH1u33FgsV8A@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-3-frederic@kernel.org>
 <YMm7iafJ1mberGIg@hirez.programming.kicks-ass.net>
 <20210616105116.GA801071@lothringen>
 <YMnf5vW3MUyuKUa5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMnf5vW3MUyuKUa5@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:26:30PM +0200, Peter Zijlstra wrote:
> Right, so by the time patch #5 comes around, you seem to be at the point
> where you can do:
> 
>  * fetch cputime and start threadgroup counter
> 
>  * possibly arm timer

- possibly

> 
>  * if expired:
>    - fire now
>    - if armed, disarm (which leads to stop)
> 
> Which is the other 'obvious' solution to not starting it.

So we unconditionally start and arm, and then have the early expire do
the same things as regular expire.
