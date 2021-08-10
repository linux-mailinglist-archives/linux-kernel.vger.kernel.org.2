Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83E3E8318
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhHJSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhHJSlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:41:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 604E660231;
        Tue, 10 Aug 2021 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628620875;
        bh=LQmKjNaYxTFmzULlF8n8LkI2UE/YwJDrLt5T3bsXrlU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WGMunM/cVKwC3ZF2KkBLTwQniyzzS9XtOCDuJDXuGF9+RayEHH/0fSmr82u7lPVMF
         yNbnwZ6pHP3cJYtaTbQLhGWzRNDGkRMPJtZwlPbPgViM9M8NFzovHXA1FcPMYfvrKG
         98ScIeKkxMKMTELo0KVCHX+Dapf7YePN26Hc4AAwNLTb+ONPf3DoexK2/KTNnkojxq
         MJEJapHHmGOwMQgT5AeZGiWl7JVp/oKbFLSE5CSbOoJu6cmr0KEgtDtkL59x9rIUMD
         yhBExOglOjpAAeQ/35FrwLMlErgWaJsk3Kpjc3i8IzEzcVUZrxb9udxwHwr+ilc2A5
         897agaOuXRQfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B98F5C039B; Tue, 10 Aug 2021 11:41:15 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:41:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rcu: Make rcu_normal_after_boot writable again
Message-ID: <20210810184115.GJ4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210810084816.155203-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810084816.155203-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:48:14AM +0200, Juri Lelli wrote:
> Hi,
> 
> v2 of a proposed RCU change to make rcu_normal_after_boot feature usable
> on PREEMPT_RT as well, as it turns out it's useful on RT as well on
> NO_HZ_FULL configurations.
> 
> v2 gained an additional patch to revise rcu update module parameters
> permissions (as suggested during v1 review [1]).

Queued and pushed, thank you!

							Thanx, Paul

> Changes wrt v1:
> 
>  - Restrict the option to !PREEMPT_RT || NO_HZ_FULL (Paul, Sebastian)
>  - Change module params permissions (Paul) (02/02)
> 
> Thanks,
> Juri
> 
> v1 - https://lore.kernel.org/lkml/20210805080123.16320-1-juri.lelli@redhat.com/
> 
> Juri Lelli (2):
>   rcu: Make rcu_normal_after_boot writable again
>   rcu: Make rcu update module parameters world-readable
> 
>  kernel/rcu/tree_exp.h | 1 -
>  kernel/rcu/update.c   | 8 ++++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> -- 
> 2.31.1
> 
