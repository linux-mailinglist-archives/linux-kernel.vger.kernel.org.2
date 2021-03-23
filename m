Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD73458CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCWHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:33:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6934FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RV79MNudtBE8lOMnZ4MTlcx7T/dwd5UQK0UyE/kmjoA=; b=o2R2IGy4YEqLXdupCdiPDA1S2z
        loRQEyvdqrl6/JHIRzKM0PuYJq2Ae80RZ19nnOPF1ZqH+LIj8oqmbI7szuTy66l2ZZPOxSkTdUCzy
        0brnOO9sAVgA+4/bOaJeVkHahUA14l3jdErwm3IZFdMPLu5rrbtTkRu/o+hWrucVVy1vvKM5TV5la
        ap7fVXNMnoh+JPZR1EH4Seh3fr8x7WFw2HnLYKSJgiLA7A8k+S05BGeV+rjThxG9/B5vEkJnyjDNg
        ltxtkHXXmXszdi1B+Fk2QuwVq8/6hk9YhVB2E6P1vf1QVMEzg6Xa1Q3NrjCMZ3mnk3bd2XnauWP0C
        /6jK9+nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lObXm-00E9UD-P8; Tue, 23 Mar 2021 07:33:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C1ED3010C8;
        Tue, 23 Mar 2021 08:33:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F7F32BD11CB8; Tue, 23 Mar 2021 08:33:37 +0100 (CET)
Date:   Tue, 23 Mar 2021 08:33:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] static_call: fix function type mismatch
Message-ID: <YFmZ0a1I+PvyPvne@hirez.programming.kicks-ass.net>
References: <20210322214309.730556-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322214309.730556-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:42:24PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The __static_call_return0() function is declared to return a 'long',
> while it aliases a couple of functions that all return 'int'. When
> building with 'make W=1', gcc warns about this:
> 
> kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
>  5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
> 
> Change all these function to return 'long' as well, but remove the cast to
> ensure we get a warning if any of the types ever change.

I still think it's utter batshit.

Please explain which architecture ABI is affected and why the warning is
sane.
