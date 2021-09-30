Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF1741DAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351403AbhI3N2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349521AbhI3N2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:28:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8FC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ez29o44AkkIcsIcpdmWWUPUZ2+d7FSmDVQK2AMmcXLw=; b=S3LmsDuYnxS+tZIRX1bRzGoYAx
        TMAcwU5HDThAlYAiW38Iwwc+c9wCb9YvNQ9kUB+B7AQJnJIKv3JDFNiFa4bxJkHihaxYyTt6JUJeE
        uW1QnMPsTRhI0QwFShZiYASVmv9MBgg4iDulUbh0c5P7WOChH8vRcJ+l4iNH/GewxTdw9Nmxc8pjf
        4An8/V8zOpcFYio2uEO146TPDieUhml7LGcIHO84e/dQ2Yvk+c6+eZ4aVUuYLWbRSk0/v7M2JGwln
        hzu6ShUdFwp7GLv4yNOMpjC3M135qenGzQ4ijSuC9CapdzVBqi4v+AYqVQ/O+W9sou5cNUmwJ35JB
        W92nW5Dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVw5E-006xfE-5P; Thu, 30 Sep 2021 13:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8387D300268;
        Thu, 30 Sep 2021 15:26:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 486822C907DB9; Thu, 30 Sep 2021 15:26:42 +0200 (CEST)
Date:   Thu, 30 Sep 2021 15:26:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, srikar@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, kjain@linux.ibm.com
Subject: Re: [RFC] hrtimer: Fix the hrtimer_forward to use correct delta for
 expiry time
Message-ID: <YVW7Eob25KYhooMN@hirez.programming.kicks-ass.net>
References: <20210930125219.1658-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930125219.1658-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:22:19PM +0530, Athira Rajeev wrote:
> Hrtimer uses "hrtimer_forward" function to forward the timer
> expiry. This function takes the "time" from when to forward
> and how much "interval" to forward as inputs. In some cases, it
> is observed that though correct interval is given to forward the
> timer, the expiry time is set to value less than expected interval.
> This will cause the timer to expire ahead of expected expiry time.
> Before updating the timer expiry value, hrtimer_forward checks to
> see if there is any delta between the time from when to forwad
> and previously set expiry. And this behaviiour is observed when
> delta is large value.
> 
> For example, consider case where we want to forward the expiry
> from "now" to 10 milliseconds. Below is trace prints captured by
> dumping the values used in "hrtimer_forward". And this instance is
> captured while forwarding timer from perf event multiplexing code
> which uses hrtimer.
> 
> <<>>
> [001] d....   304.118944: perf_mux_hrtimer_restart: Restarting timer from perf_mux_hrtimer_restart
> [001] d....   304.118945: hrtimer_forward: In nanoseconds, now is 303938589749, delta is 52868589749, hrtimer_get_expires(timer) is 251070000000, interval is 10000000
> [001] d....   304.118945: hrtimer_forward: Caller is perf_mux_hrtimer_restart+0xb0/0x120
> [001] d....   304.118946: hrtimer_forward: Caller's caller is merge_sched_in+0x268/0x4e0
> [001] d....   304.118946: hrtimer_forward: orun is 5286
> [001] d....   304.118947: hrtimer_forward: In hrtimer_add_expires_ns, before ktime_add_ns timer->node.expires in ns is 251070000000, timer->_softexpires is 251070000000,  ns is 52860000000
> [001] d....   304.118948: hrtimer_forward: In hrtimer_add_expires_ns, after ktime_add_ns timer->node.expires in ns is 303930000000, timer->_softexpires is 303930000000
> [001] d....   304.118948: hrtimer_forward: In hrtimer_add_expires, in nanoseconds, before ktime_add_safe, timer->node.expires in ns is 303930000000, timer->_softexpires is 303930000000
> [001] d....   304.118949: hrtimer_forward: In hrtimer_add_expires, in nanoseconds, after ktime_add_safe, timer->node.expires in ns is 303940000000, timer->_softexpires is 303940000000
> [001] d....   304.118949: hrtimer_forward: After hrtimer_add_expires, hrtimer_get_remaining in nanoseconds is 1405169
> 
> <<>>
> 
> In this example,
> timer->node.expires = 251070000000 ns ( previously set expiry )
> now = 303938589749 ns
> delta = 52868589749 ns
> 
> Here delta is "52868589749" which is greater than the interval to
> forward ( ie 10000000 ns ). Hence hrtimer_forwards adds this difference
> to present timer->node.expires in hrtimer_add_expires_ns() function. But
> instead of using actual "delta", code is using (delta/interval * interval)
> as below:
> 
> <<>>
> s64 incr = ktime_to_ns(interval);
> orun = ktime_divns(delta, incr);
> hrtimer_add_expires_ns(timer, incr * orun);
> <<>>
> 
> Hence we are actually using "orun * 10000000". In this example, it will be
> "52860000000" since "orun" does not include the mod value. Here we are
> missing "8589749" nanoseconds in the timer expiry. Hence, the final expiry
> time will be set to "303940000000".
> 
> Since we are not using exact delta, the hrtime remaining will be
> around 1405169 nanoseconds and will cause the timer to expire in 1.4 ms
> instead of 10 ms. Fix this by using "delta" instead of using the divided
> value.
> 

You misunderstand, the behaviour is correct and expected. What
hrtimer_forward_now() does is guarantee the expiry time ends up on an
integer multiple of @interval.

This is important to achieve periodic timers. Your patch would cause
period drift.
