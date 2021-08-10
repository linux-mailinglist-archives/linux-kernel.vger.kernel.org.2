Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820883E5E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbhHJO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbhHJO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:58:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3A2C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:58:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628607490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcohOGUZfjN+n3KXHihq5kbx7jybdYSuSYnZPN00JEw=;
        b=BltCCP2l+cAWSkso+YYFOztHcw47FQvZ8fK1QpHQCwU9EhwCMk0l2SidpMZHTuvywYQa3l
        eUli40L+0KUqmO/Buqc7UVPWTS8dzucCmWlBm/KliAcfvrjcngeIlEgcbmLw5Rp+eudWDf
        XDfeTtxFesdFWPYl9tGWg12C3DKjhpp8jmwKtUphVwIrIxP8gZQYbvi7iVr+epsTjHpYS7
        4QBbbZ/999Y6Wexzt7VIY/QCrHCdxCm6PhKh5IbAylmSzcQb1tiAN305Gy6/bDEqJei6LS
        5QXdXrlW+c+vQhlBUKTFLvaOMrQyU8cXfFltsMD7MLF8mABjYGam/DVoo6+WIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628607490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcohOGUZfjN+n3KXHihq5kbx7jybdYSuSYnZPN00JEw=;
        b=HaESd6KY3PQ1In6XoQfeGtOTPgLwfYVlwgSaae5u5lsciFbfxXJ0KA141lD3+e4UdGqhAe
        Z7vUD+xbsmNDhjDw==
To:     Wang Qing <wangqing@vivo.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC 1/2] hrtimer: support hrtimer suspend when CPU suspend
In-Reply-To: <1624352816-26450-2-git-send-email-wangqing@vivo.com>
References: <1624352816-26450-1-git-send-email-wangqing@vivo.com>
 <1624352816-26450-2-git-send-email-wangqing@vivo.com>
Date:   Tue, 10 Aug 2021 16:58:10 +0200
Message-ID: <87zgtpqrct.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22 2021 at 17:06, Wang Qing wrote:
>  /**
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 4a66725..db34c9d
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -513,7 +513,8 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
>  
>  		next = timerqueue_getnext(&base->active);
>  		timer = container_of(next, struct hrtimer, node);
> -		if (timer == exclude) {
> +		if ((timer == exclude) ||
> +		(tick_nohz_tick_inidle() && timer->is_suspend)) {

Aside of being indented in unreadable ways, how is this supposed to be
correct? If the first expiring timer is excluded what prevents the next
one from being marked to stop in suspend or the other way round.

What's wrong with just canceling the offending timer before going into
suspend and rearming it on resume instead of adding a half baken magic
case for timers?

Thanks,

      tglx
