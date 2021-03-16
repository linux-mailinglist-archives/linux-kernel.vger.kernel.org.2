Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E133D4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhCPNhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235192AbhCPNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:37:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF2436500A;
        Tue, 16 Mar 2021 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615901826;
        bh=Yg9oeOO4X/in9ARGZA4zEauVUk8GipYuND6vVZtMxnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZucTS18hS1xL28ujRkmN9bAoZrtlBj5P+RjEJm79ORm9ImWrrVb0lpUGt8FxlIYc5
         Nt90A/NEqlBKYgrebPlg8EJuc+qqyokX9PG7+Xa6yXUUlZN858z3er5dxieA4HnscF
         88nxpuuWJdNxLUgUvT9AXB8mASHnQ5COlPHMTpUWKs2hdttixOownEDPiSnnhrVOU4
         brFwzVBoBgBdGPDZx3nKNc+QyLzZ/TyQkmU1Av/1ZAHPmjMFcvxmb/yi7niA8V7CV2
         4F55bqi5au7BZnAh+dyHf92PSB/qL7pO1WgCnqYLdVnLkE/q72zkh5QiQ3caDGBSId
         mm/44PPEsehmQ==
Date:   Tue, 16 Mar 2021 14:37:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20210316133703.GC639918@lothringen>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 01:21:29PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 01:36:59PM +0100, Frederic Weisbecker wrote:
> > From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
> > 
> > If the hardware clock happens to fire its interrupts late, two possible
> > issues can happen while calling tick_nohz_get_sleep_length(). Either:
> > 
> > 1) The next clockevent device event is due past the last idle entry time.
> > 
> > or:
> > 
> > 2) The last timekeeping update happened before the last idle entry time
> >    and the next timer callback expires before the last idle entry time.
> > 
> > Make sure that both cases are handled to avoid returning a negative
> > duration to the cpuidle governors.
> 
> Why? ... and wouldn't it be cheaper the fix the caller to
> check negative once, instead of adding two branches here?

There are already two callers and potentially two return values to check
for each because the function returns two values.

I'd rather make the API more robust instead of fixing each callers and worrying
about future ones.
