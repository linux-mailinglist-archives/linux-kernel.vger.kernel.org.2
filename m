Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D2389A90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhETA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhETA1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C78E1613AC;
        Thu, 20 May 2021 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621470356;
        bh=kxi2FW4GOYHlCiXzfLRe6LmjwHpcxDDms7TCiymAhi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8P/h7uYI5lmQS1oT1Eht3e51fUfFq62DfE23qQDPMmAiZjdhNNTuXNati0Li0H6U
         9wbRExz60HHNOjrO60Sc+RRuMA4UIGhE5KHaCZvBL4Op1wEPvzeY7R9JUpyBY0AneJ
         QPYAQI/+xWkkTkkLmXT24mWErS8vvZfr04IYteENDLC3VQpm+H0lVSptsgjQSUMLPv
         qhKQA2NWT6+BMkaBENZ/tQt6UwqDhzOC9WKSIeCnzBKcAM3pHogrzdF0XMwtZ2LiXM
         hQd/+wqZNpSUeWbZxKqTBedrlumtrQRxljSx1DlwJ8VQOoKWVgBXJXApMJfXEVOXwh
         6feVqsFTi7S5w==
Date:   Thu, 20 May 2021 02:25:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/3] rcu/nocb: Remove NOCB deferred wakeup from
 rcutree_dead_cpu()
Message-ID: <20210520002553.GA22836@lothringen>
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-3-frederic@kernel.org>
 <20210519155905.GY4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519155905.GY4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:59:05AM -0700, Paul E. McKenney wrote:
> On Wed, May 19, 2021 at 02:09:29AM +0200, Frederic Weisbecker wrote:
> > At CPU offline time, we make sure to flush any pending wakeup for the
> > nocb_gp kthread linked to the outgoing CPU.
> > 
> > Now we are making sure of that twice:
> > 
> > 1) From rcu_report_dead() when the outgoing CPU makes the very last
> >    local cleanups by itself before switching offline.
> > 
> > 2) From rcutree_dead_cpu(). Here the offlining CPU has gone and is truly
> >    now offline. Another CPU takes care of post-portem cleaning up and
> >    check if the offline CPU had pending wakeup.
> > 
> > Both ways are fine but we have to choose one or the other because we
> > don't need to repeat that action. Simply benefit from cache locality
> > and keep only the first solution.
> 
> But between those two calls, the CPU takes a full pass through the
> scheduler and heads into the idle loop.  What if there is a call_rcu()
> along the way, and if this was the last online CPU in its rcuog kthread's
> group of CPUs?  Wouldn't that callback be stranded until one of those
> CPUs came back online?

Nope, rcu_report_dead() is called from the idle path right before
arch_cpu_idle_dead(). There should be no call to the scheduler until the
CPU comes back online.

Thanks!
