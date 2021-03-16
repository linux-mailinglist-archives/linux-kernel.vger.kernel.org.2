Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294C133D5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhCPOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:36:32 -0400
Received: from casper.infradead.org ([90.155.50.34]:34786 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbhCPOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rjw1WKumRyJtsR4bEBFv737F1QPjf5K33LJyF0RbOX4=; b=KOm0ME0ZCooVqAJKYEgrgA7Ah3
        5i5Nirsw6NK9IBlXMNB0MLcB98NeQ45Hsy5GKnX7LDyac2tJVJ2OJ9ogW79SoIjpjGFjhSCXYPV55
        JpCQ3RXlA3cHj4ddkb94as4qt9ssAC4TOm2NHr0YHNbbIl4oCHWzX4RhqFmdBTLuOcfV+KNyzwjiJ
        2zvNo6CMZfSMGl8KoCjpsG8sbzS/QZeTEL/LJhw4HFThiV2cD+/yFGORc+E+Ox7oQ+AwnNX5m3M09
        VKV+Zb8cMX3bVAI73DTepwna5jS7d32LOaEvfALOALMOkxfhacwpirZONh0rs8JT5I8roaNp9fMPn
        SynoETEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMAnK-000BYm-8s; Tue, 16 Mar 2021 14:35:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 767BE305C22;
        Tue, 16 Mar 2021 15:35:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 167342DAC4D5B; Tue, 16 Mar 2021 15:35:37 +0100 (CET)
Date:   Tue, 16 Mar 2021 15:35:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length()
 from returning negative value
Message-ID: <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316133703.GC639918@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:37:03PM +0100, Frederic Weisbecker wrote:
> On Tue, Mar 16, 2021 at 01:21:29PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 11, 2021 at 01:36:59PM +0100, Frederic Weisbecker wrote:
> > > From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
> > > 
> > > If the hardware clock happens to fire its interrupts late, two possible
> > > issues can happen while calling tick_nohz_get_sleep_length(). Either:
> > > 
> > > 1) The next clockevent device event is due past the last idle entry time.
> > > 
> > > or:
> > > 
> > > 2) The last timekeeping update happened before the last idle entry time
> > >    and the next timer callback expires before the last idle entry time.
> > > 
> > > Make sure that both cases are handled to avoid returning a negative
> > > duration to the cpuidle governors.
> > 
> > Why? ... and wouldn't it be cheaper the fix the caller to
> > check negative once, instead of adding two branches here?
> 
> There are already two callers and potentially two return values to check
> for each because the function returns two values.
> 
> I'd rather make the API more robust instead of fixing each callers and worrying
> about future ones.

But what's the actual problem? The Changelog doesn't say why returning a
negative value is a problem, and in fact the return value is explicitly
signed.

Anyway, I don't terribly mind the patch, I was just confused by the lack
of actual justification.
