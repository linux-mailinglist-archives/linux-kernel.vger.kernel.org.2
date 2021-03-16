Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3833DE17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhCPTtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:49:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhCPTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:48:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615924135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRw7n8NDH/xKVa1BdRtlfYFO/sQ1st+ZQbLu0oouf90=;
        b=hLtkfOQgvO5903XhIqu2IqWGMNbdFqsSIq0fxxpZvoz5Ke5VpTaF1h6jTSSIRWgaQtO19H
        nV+1NJGkwP7GWWX0QK6DZM8IUSldMVpCtGYhQzg71tG5+msPFjQFNKJn+K79YRH90gY6mk
        pm4GcOlG1p8CcUxQRmuXOA1wEscE5BDLr100ZHAxqzfY9WotFRPsTymAkXcfYyrTMieh6z
        hZL6cJ5gw9sPp0Hk2GZu+AKmo8JmWidw9B2aUuCC52KCPIY2aO/swJgj+no2mirzh3VKsu
        RzTQYH5SGS2dFBTeH0U1Z+HaIwuM+42w7DSVZdrxKxApwZrtCqqiJO++JDTE6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615924135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRw7n8NDH/xKVa1BdRtlfYFO/sQ1st+ZQbLu0oouf90=;
        b=EZrXTc4LywkCfTMOamwTdFSfC7eJ2r5vL4Rywzzh0exnDiAUCmQI2fxKKew+8JapjTcrvN
        KeS+PHzXYx0iNKAg==
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] futex: Leave the pi lock stealer in a consistent state upon successful fault
In-Reply-To: <20210316180305.sh7nyi4xjskd3e3j@offworld>
References: <20210315050224.107056-1-dave@stgolabs.net> <20210315050224.107056-3-dave@stgolabs.net> <YFCUYimuDkUonySp@hirez.programming.kicks-ass.net> <20210316180305.sh7nyi4xjskd3e3j@offworld>
Date:   Tue, 16 Mar 2021 20:48:54 +0100
Message-ID: <87im5qzxp5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16 2021 at 11:03, Davidlohr Bueso wrote:
> On Tue, 16 Mar 2021, Peter Zijlstra wrote:
>>IIRC we made the explicit choice to never loop here. That saves having
>>to worry about getting stuck in in-kernel loops.
>>
>>Userspace triggering the case where the futex goes corrupt is UB, after
>>that we have no obligation for anything to still work. It's on them,
>>they get to deal with the bits remaining.
>
> I was kind of expecting this answer, honestly. After all, we are warned
> about violations to the 10th:
>
>   * [10] There is no transient state which leaves owner and user space
>   *      TID out of sync. Except one error case where the kernel is denied
>   *      write access to the user address, see fixup_pi_state_owner().
>
> (btw, should we actually WARN_ON_ONCE this case such that the user is
> well aware things are screwed up?)
>
> However, as 34b1a1ce145 describes, it was cared enough about users to
> protect them against spurious runaway tasks. And this is why I decided
> to even send the patch; it fixes, without sacrificing performance or
> additional complexity, a potentially user visible issue which could be
> due to programming error. And unlike 34b1a1ce145, where a stealer that
> cannot fault ends up dropping the lock, here the stealer can actually
> amend things and not break semantics because of another task's stupidity.
> But yeah, this could also be considered in the category of inept attempts
> to fix a rotten situation.

It's one of the 'Doctor it hurts when I shoot myself in the foot' cases :)
