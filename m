Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0B3F086D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhHRPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236531AbhHRPvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADBC560EFF;
        Wed, 18 Aug 2021 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629301858;
        bh=9rLzTnBf+GfoVbey5cyLH9bQwxX6Dqebm7pt2bgYHOM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N2lZEXGBVenC8Oql8r+foHsV5LeAJi9YdfG0XWwp9DbkKOVm91WRUN7yZNTwV+X9i
         PrgYUg15FoCWWjyMT8rgzlE32U8Ik4PMAesoM7Lu7U6G3uvQEd2iuak3GuBgUJTpbB
         sOtuj88VyS8i6XDNBH41kJW0OWSeYQMuOgVYssnTT0y9TOYB0I4wbhR0/u5s654HG6
         EfTVNXq7XSQYOCQDETchPQK4zGsu2DP638CJrZbuWNRROGlcXLllFG5Cq9DbT+dpS9
         6bTqmpBA4skbVdf/Hhzv6navIOwhBZXwLzm5xEs2iW+NyRNjiKr0GuzbxJvbe7pdLB
         lG4cAZZEZ1ghw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 735E05C04B1; Wed, 18 Aug 2021 08:50:58 -0700 (PDT)
Date:   Wed, 18 Aug 2021 08:50:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 0/5] rcu-tasks miscellaneous fixes
Message-ID: <20210818155058.GU4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:58:38PM +0530, Neeraj Upadhyay wrote:
> Minor typos in comments and fixes for rcu-tasks.

I queued all but 4/5 for review and testing, thank you!!!

4/5 needs a slight fix that I cannot do in the patch itself.

							Thanx, Paul

> Neeraj Upadhyay (5):
>   rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment
>   rcu-tasks: Correct firstreport usage in check_all_holdout_tasks_trace
>   rcu-tasks: Correct check for no_hz_full cpu in show_stalled_task_trace
>   rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
>   rcu-tasks: Clarify read side section info for rcu_tasks_rude GP
>     primitives
> 
>  kernel/rcu/tasks.h | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
> hosted by The Linux Foundation
> 
