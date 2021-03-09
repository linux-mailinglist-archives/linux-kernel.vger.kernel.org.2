Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E713330F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCIVcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhCIVc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:32:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C11264F59;
        Tue,  9 Mar 2021 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615325549;
        bh=X/NHyrXhlVVZOYp7ag0+RL8Aeg36G7MdG2rUBg2zpaw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bo9G9gFvOatOBnUAaD9wq3s0emeAmjg4uxyUJgQ+FEd1Yr5FQS1iibDIC6M5aNSY0
         Etib3ZaimejCVzYUXfrlWeJzAQFwPgtTzlezG56bXtGwYT/84fqmz0nNZQPV6xbx/h
         S70i6G17sk7QeSNpBwSaF3eKktYAwXd5kR0gTXNgcU2QYmIedOneJ7yLDTNg+RfqQG
         5Bf9I1GfOX/HwM/mq36Qgf47K4ArKnLrmExALI/qEoUoDeHz2C3pOOS1IfyA3pxyEW
         0XvVHokiITO/ik9BHCImIBk7GA/XU/9Xhjbs/71gTuWZ9qn7qrrDOKF9BIjo8IeMb2
         b3F9AVclM+hxw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4EAE335239E0; Tue,  9 Mar 2021 13:32:29 -0800 (PST)
Date:   Tue, 9 Mar 2021 13:32:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch V3 0/6] softirq: Add RT specific softirq accounting
Message-ID: <20210309213229.GT2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309085552.815026890@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 09:55:52AM +0100, Thomas Gleixner wrote:
> RT runs softirq processing always in thread context and it requires that
> both the softirq execution and the BH disabled sections are preemptible.
> 
> This is achieved by serialization through per CPU local locks and
> substituting a few parts of the existing softirq processing code with
> helper functions.
> 
> The series applies on top of
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git tasklet-2021-03-09
> 
> and is completely available from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git softirq
> 
> Changes to V2 which can be found here:
> 
>   https://lore.kernel.org/r/20201204170151.960336698@linutronix.de
> 
>  - Split the tasklet changes out (seperate submission)
>  
>  - Rebase it on the tasklet series (no further changes)

Passes modest rcutorture testing, and I do like the "NOHZ tick-stop
error" maybe going away!  That error is rare enough that it will take
some time to be reasonably certain.  In the meantime:

Tested-by: Paul E. McKenney <paulmck@kernel.org>
