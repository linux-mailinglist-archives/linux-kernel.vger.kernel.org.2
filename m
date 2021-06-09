Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877523A0D56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhFIHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbhFIHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:14:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E0C06178B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=76BUpwV+9faalMya9WgMjsJtA0lRIce1TlADEejtRzY=; b=D1aIQkcMtuo1155owLsijrc7RO
        VHjKah6STnsJwFRjKyYnI+ScMo1McyrPd//3gjkQnPy9cFUtlzfaLvnN1rqDtBAF7CidIaMpD1onK
        hRHd/Iu+aL3XRO8GQyaOT0x1vOm+XymyegEYvH8yd2gTTLX09HzEEU1qAcKS6q6pzqlByFuZDLNgv
        HLO1XdPe+eUfiwR9nyRcGXEB4T9DijBsBNiM/58uTlHJ7bumorb/Qdkb/z6MvAVMVcGN7OHM76a7B
        OnHvxJ2FUPeLIOZnnddel941I6HuGmYvov7c1upfFjQmI/bEl3HwSWbkUP3QFVD1mlGGTxQbH2PZd
        BbKpibfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqsNc-0051HA-Rl; Wed, 09 Jun 2021 07:12:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A1A33002CA;
        Wed,  9 Jun 2021 09:12:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C06AE201DE6EE; Wed,  9 Jun 2021 09:12:04 +0200 (CEST)
Date:   Wed, 9 Jun 2021 09:12:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: find_new_ilb
Message-ID: <YMBpxBR3EMyAUa3j@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.22.394.2106082138350.16734@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2106082138350.16734@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:51:30PM +0200, Julia Lawall wrote:
> Starting from the following commit:
> 
> commit 45da7a2b0af8fa29dff2e6ba8926322068350fce
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Aug 18 10:48:17 2020 +0200
> 
>     sched/fair: Exclude the current CPU from find_new_ilb()
> 
> up through Linux 5.12, I observed that often when most of the machine was
> idle, there could be many (thousands) of sched_wake_idle_without_ipi
> events, typically between cores 0 and 1.  I don't see this any more in
> Linux v5.13-rc1.  I looked through the patches to fair.c and core.c
> subsequent to v5.12, and I didn't see anything that explicitly addresses
> this issue.  Before I plunge into another set of rounds of bisecting, I
> wonder if anyone knows whether and how this problem was resolved?

Hurmph.. that patch was preparation for a later change that never seems
to have happened. If it is causing trouble for you, I think you can
savely revert it.

At the time I thought it was very strange that new_idle would select
itself as idle-balancer, doubly so, because the only way to get there
would be with NEED_RESCHED already set, so the IPI wouldn't in fact do
anything.

Looking again, the difference is ofcourse that previously we'd select
self and NO-OP, but now we'll potentially select another CPU and
actually do something.

This is arguably an improvement, because we did want to do something.

 I can't quite remember what would've change here since, Vincent, can
 you remember?

Anyway, is this actually causing you trouble, or are you just going on
the increased number of events? 
