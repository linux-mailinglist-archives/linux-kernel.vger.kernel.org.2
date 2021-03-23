Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE8345910
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCWHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhCWHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:49:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G4mKOqnYLS5aisPRhWh1adzyNjnyD9ytIXDxcLbdvrI=; b=ZJ4PXU1YPJMi984UIuN8NuXFRX
        tP239BNgy8mfay0WeOLu1yzBworA5ecPTYbjGNZPcMU4fWQh2n71ympTJmvqq9jdxhJyDxLzhBol0
        fVLHQmAV6x1GKLmHvXY/6X3loL2Am/4s0mu6P71PtnU0vGStckfJdAySA8H6gJtTw3TAfsw9G8Iui
        vbWgcrpall8K+6FO8xWflSZpu1UWDmCndRMIgWD6s1Y26WC09M1x8wHqph2aJPE5Rs+Nat8lhkNsW
        NqonrdlXCgDeIPkInrdA5fkpONF7NSJXp+2nw1V6GKAglvzzOH0ZK5n0AioDuYuB3JkzznmKidSB3
        yggpVzpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOblX-009jsb-IV; Tue, 23 Mar 2021 07:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB662300F7A;
        Tue, 23 Mar 2021 08:47:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF7F12BCFBCCE; Tue, 23 Mar 2021 08:47:50 +0100 (CET)
Date:   Tue, 23 Mar 2021 08:47:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] static_call: fix function type mismatch
Message-ID: <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
 <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322172921.56350a69@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:29:21PM -0400, Steven Rostedt wrote:
> On Mon, 22 Mar 2021 22:18:17 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > I think the code works correctly on all architectures we support because
> > both 'int' and 'long' are returned in a register with any unused bits cleared.
> > It is however undefined behavior in C because 'int' and 'long' are not
> > compatible types, and the calling conventions don't have to allow this.
> 
> Static calls (and so do tracepoints) currently rely on these kind of
> "undefined behavior" in C. This isn't the only UB that it relies on.

Right, most of the kernel lives in UB. That's what we have -fwrapv
-fno-strict-aliassing and lots of other bits for, to 'fix' the stupid C
standard.

This is one more of them, so just ignore the warning and make it go
away:

 -Wno-cast-function-type

seems to be the magic knob.
