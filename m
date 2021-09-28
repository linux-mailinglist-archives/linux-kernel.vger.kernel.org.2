Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95941BABA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243178AbhI1XFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243153AbhI1XF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:05:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E1D36138F;
        Tue, 28 Sep 2021 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632870227;
        bh=YXvSHKBymg2WBJls6Cohm3xZKrztTc361zM6vY8ERTE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F9drGIly/q94yX10gumMgX0Znt66fhg6fiYB8Le/5yS1zHRxfNj8CyvgCaovLy7/8
         QuBDzVSLSwZifC5Ig3jS51Cnvncq/zocnr1wCSUcIE/3oA0f1saBKEL7zUOmUnzZjy
         brDGnQtotRPTdH5iEwpWJCvTCys+Gy+1QwkmjWL7cJa3+0kMxhVtM4e1PBg/J+bXZu
         J2OmjC9iVR45dfywgYyZLw5OJQebmT77ZJbw7xFPMcXGRblbl2NIOnc7+M/6WdiSUt
         +ncHBbfbWCGSrIjOg1o5KwLvvssQ60qx19EBKV0NgE7wE8J6S5gkuKwsnuBmT3m0wE
         bw6VMnvNPO8XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 591EA5C0B37; Tue, 28 Sep 2021 16:03:47 -0700 (PDT)
Date:   Tue, 28 Sep 2021 16:03:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rcu: Always inline rcu_dynticks_task*_{enter,exit}()
Message-ID: <20210928230347.GN880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928084020.819856223@infradead.org>
 <20210928084217.908041969@infradead.org>
 <87ee989vml.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee989vml.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:35:14AM +0200, Thomas Gleixner wrote:
> On Tue, Sep 28 2021 at 10:40, Peter Zijlstra wrote:
> 
> > RCU managed to grow a few noinstr violations:
> >
> >   vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x0: call to rcu_dynticks_task_trace_enter() leaves .noinstr.text section
> >   vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0xe: call to rcu_dynticks_task_trace_exit() leaves .noinstr.text section
> >
> > Fix them by adding __always_inline to the relevant trivial functions.
> >
> > Also replace the noinstr with __always_inline for the existing
> > rcu_dynticks_task_*() functions since noinstr would force noinline
> > them, even when empty, which seems silly.
> >
> > Fixes: 7d0c9c50c5a1 ("rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you!  I will apply to the pair of RCU commits at the next rebase.

							Thanx, Paul
