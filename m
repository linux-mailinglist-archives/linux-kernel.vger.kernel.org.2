Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215C23A9BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhFPN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhFPN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:26:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Elup1K/pdOal6CMU6IFSCXYZK6fFIS7MIHnYzrq8KME=; b=TBnMCfED2L4xmLB5Y+GvP/WBM7
        3P9n8XnZvQAk0JiRbhMIrNLnPyeMzu9XLH9fWIM3tiBI1yHnJB9ZGu7Z0li/5svzB00+NYpdsjeLK
        pE0ojJEq0UNLDOid/i8gj99+HsORNSqpeVZowyna09BBzTPpddF4WMdIRCNuMfnlH+38A2Gp4PGSP
        4BWqwdaVVsKRAMvartmA/FBYoKhBhXbuaq9iUKBad4XIinZuANaQRDFjUpNLLS4mCffMTd8zjLZx/
        bQBp/AOxKtWIN4wacfgwtzc60scCshcy84YB3iPh76mqcfe0xurWGsQ3euLkHjzpfY+ij9999tpbT
        rC2KdbSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVWD-008KWn-P5; Wed, 16 Jun 2021 13:23:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13FD1300269;
        Wed, 16 Jun 2021 15:23:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F151420C169EE; Wed, 16 Jun 2021 15:23:50 +0200 (CEST)
Date:   Wed, 16 Jun 2021 15:23:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/6] posix-cpu-timers: Force next expiration recalc after
 early timer firing
Message-ID: <YMn7Zl2uc6NyUfXJ@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-6-frederic@kernel.org>
 <YMnHnUcufPhtnDZP@hirez.programming.kicks-ass.net>
 <20210616115923.GC801071@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616115923.GC801071@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:59:23PM +0200, Frederic Weisbecker wrote:
> On Wed, Jun 16, 2021 at 11:42:53AM +0200, Peter Zijlstra wrote:
> > I'm thinking this is a better fix than patch #2. AFAICT you can now go
> > back to unconditionally doing start, and then if we fire it early, we'll
> > disarm the thing.
> > 
> > That would avoid the disconnect between the start condition and the fire
> > condition.
> 
> Right but the drawback is that we unconditionally start the threadgroup
> counter while initializing the timer to 0 (deactivated).
> 
> Then in the next tick at least one thread will need to lock the sighand
> and re-evaluate the whole list.

Yes.. but how common is it to enqueue expired timers? Surely that's an
unlikely corner case. All normal timers will have to suffer one extra
tick and iteration on exit, so I find it hard to justify complexity to
optimize an unlikely case.

I would rather have more obvious code.

