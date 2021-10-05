Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0E423154
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhJEUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhJEUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:13:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB0C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MCBYWRZXXI7lG2SR1+H8A6OZCZlzLeBzMu0FnfRFJw=; b=kHLxU4+osHn2e1kvCmtyaAXNCO
        lZ1u7yHf6Rjt/cLnTQyIR8thhzawECpeQylLENp9kEgkNu+WXJiXSJZckIuJWQ+omGEwHm8VurVb+
        IDZC3mpSayK71l+60ZTtEf822sI+cw84mWypKJTOXJnZGgl/xhw1kVSQEuwQKMnePZVzeUm17ls1d
        roR91T1W7uR/QSpJ7U+M9ksMLc7FUtXUMQKHfgvr/FalCbyQwUE2J5fEKZRyiDFJ2URA36Mc/fHTi
        QpN8Q1xCdrEV9FcfIdMRJULQfHXZ6/9/TyMQ6KC0yHzbiFaR/I57JrBtfxBsFT45ET5zSr/PqsLa9
        IIxqApJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXqmF-000ENF-Hi; Tue, 05 Oct 2021 20:11:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C90F981A96; Tue,  5 Oct 2021 22:11:03 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:11:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/5] irq_work: Ensure that irq_work runs in in-IRQ
 context.
Message-ID: <20211005201103.GB174703@worktop.programming.kicks-ass.net>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-3-bigeasy@linutronix.de>
 <20211005154827.h2pna3vfqbo7icjn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005154827.h2pna3vfqbo7icjn@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 05:48:27PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-27 23:19:16 [+0200], To linux-kernel@vger.kernel.org wrote:
> > The irq-work callback should be invoked in hardirq context and some
> > callbacks rely on this behaviour. At the time irq_work_run_list()
> > interrupts should be disabled but the important part is that the
> > callback is invoked from a in-IRQ context.
> > The "disabled interrupts" check can be satisfied by disabling interrupts
> > from a kworker which is not the intended context.
> > 
> > Ensure that the callback is invoked from hardirq context and not just
> > with disabled interrupts.
> 
> As noted by lkp, this triggers from smpcfd_dying_cpu().

It lives then? I don't think I've had it report on my trees in about a
week :/

> Do we care enough to change this or should I rather drop this one?

Drop it for now I suppose...
