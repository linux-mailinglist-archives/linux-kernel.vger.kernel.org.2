Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA241EEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354369AbhJANm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354222AbhJANmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:42:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BAAC06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ns7lmp26vxzWF66saKYYbwQ1SW1LaJgNeg9wHtAD4RY=; b=KhkkGZGTrNpEJ/MoaHXTKRs9oo
        mbY5Nahst1AMYclkUcr7DGHNP0mwGXRZmVawg/55oRth5rqZusKJGN4i5APaFDEBV3bok3B2tNV7W
        JQxAYBHip96X/Ys/f3Bvt5mHBCMJc1yK6Oyu5BPFeMKOf9W9tEkGtOEtKRfCAby5HMzFumpmcyvVX
        lzt58XDcXaJT2IElXTmRAD/Wh/wFM2vSPi4JonUGfkEtWc0w2+u81yIMQPVio+bq96noltKOlYx46
        KPcx1Ol/KDla0hCxYysbroTAB/gSaEUr8Rgk5/kyx3UbqQNBYZcON4Tsxiur32JOs0jSy17QzjfOL
        7AizGGrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWImU-007Ah0-ES; Fri, 01 Oct 2021 13:40:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1E71300299;
        Fri,  1 Oct 2021 15:40:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84D142C53BFE3; Fri,  1 Oct 2021 15:40:53 +0200 (CEST)
Date:   Fri, 1 Oct 2021 15:40:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <YVcP5bYyjyLvpHMd@hirez.programming.kicks-ass.net>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
 <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
 <20210930095348.tud6jdcenfkfzugz@linutronix.de>
 <YVXMN5YzUmpX20ET@hirez.programming.kicks-ass.net>
 <20210930163858.orndmu5xfxue3zck@linutronix.de>
 <YVbjxjzVM5Dx4Mv4@hirez.programming.kicks-ass.net>
 <20211001120855.hjjaqt5bpowit2r7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001120855.hjjaqt5bpowit2r7@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 02:08:55PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-10-01 12:32:38 [+0200], Peter Zijlstra wrote:

> > But basically that thing wants to reschedule, but suffers the same
> > problem as:
> > 
> > 	preempt_disable();
> > 
> > 	<TIF_NEED_RESCHED gets set>
> > 
> > 	local_irq_disable();
> > 	preempt_enable();
> > 	  // cannea schedule because IRQs are disabled
> > 	local_irq_enable();
> > 	// lost a reschedule
> > 
> > 
> > Yes, that will _eventually_ reschedule, but violates the PREEMPT rules
> > because there is an unspecified amount of time until it does actually do
> > reschedule.
> 
> Yeah but buh. We could let local_irq_enable/restore() check that
> need-resched bit if the above is considered pretty and supported _or_
> start to yell if it is not. A middle way would be to trigger that
> self-IPI in such a case. I mean everyone suffers from that lost
> reschedule and, if I'm not mistaken, you don't receive a remote wakeup
> because the remote CPU notices need-resched bit and assumes that it is
> about to be handled. So RCU isn't special here.

Mostly the above pattern isn't 'allowed', but it does tend to happen
with RCU quite a bit.

As per the perf code, I'm actually fine if RCU wouldn't do this. But
Paul feels that he needs to cater for it -- doesn't want to surprise his
users.

Fixing this in local_irq_enable() would blow up the code quite a bit.

I'm not sure it's something we can sanely warn about either, the case
for the remote reschedule IPI could cause false-positives.
