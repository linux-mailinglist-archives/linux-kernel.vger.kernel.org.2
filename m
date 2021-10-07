Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D2424F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbhJGIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:51:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35448 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhJGIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:51:17 -0400
Date:   Thu, 7 Oct 2021 10:49:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633596562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJmYkJ5Ei1SZdIIXbBxYdWQ7EPM9kgv2ytNpLYGKcbE=;
        b=z/k3FWdKanajPCZ+26v2+kBLTXDD4Xm6McNO3df7kFDlQIwL1zO6iBbR8MFtt06BtLzTGX
        2pM6r/X+Z7is8bKb7uJkwbZymkajRnygJeyEmYol8JYRifNSgI3ZSKsx0Bgysokxj1AbJ4
        +crl2o5FaTX/lFcyyR+PTQYyZ0TM2eE8OI+NhVijRaH6saawGqBCchPXlOaELUn6T8V4lk
        D+6Y5ZPvC6mlvXoaNXhA+iC308HLxOnIUkZsKf8EAnh7uGd/6snkAWQyNcmDXsR/ELxtsa
        rWTW3LEm8OfKT555qjw1Th3aNGpb/9tP9p3HZe7cEM2U3VuQTchytxisKz5W2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633596562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJmYkJ5Ei1SZdIIXbBxYdWQ7EPM9kgv2ytNpLYGKcbE=;
        b=Am7fcNjg0WOLRRFpk9a/EwFsmQoLX+9rXG63g1JFfj1apivyY8Tp8xzguKvaJadjc2ya1i
        VMBsxWWPkd8pjQAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes
Message-ID: <20211007084920.4wo5fmjxmistivqa@linutronix.de>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20211006151339.GA422833@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006151339.GA422833@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-06 08:13:39 [-0700], Paul E. McKenney wrote:
> On Thu, Sep 30, 2021 at 12:10:01AM +0200, Frederic Weisbecker wrote:
> > PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
> > concurrent NOCB (de-)offloading.
> > 
> > Thomas suggested to drop the local_lock() based solution and simply
> > check the offloaded state while context looks safe but that's not
> > enough. Here is a bit of rework.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	rcu/rt
> > 
> > HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad
> 
> Many of these look quite good, but any chance of getting an official
> Tested-by from someone in the -rt community?

I looked over the series, bootet the series and run a quick rcutorture
and didn't notice anything.

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> 							Thanx, Paul

Sebastian
