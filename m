Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F13455C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCWCza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCWCzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:55:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C77C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=B6rnhTgt4DFRiVhMGzydMz2xAFUaPHH+uQw05dRK294=; b=qByiGosATWAp/fcdOfNkxUjrut
        sZBAHdbA0agNTqahGdw/APr47frHmPWiQsxS7CWm4oFjMtkN2aqatxJhzfbss3ZbVsEejTy0x7WSz
        8lfF5b5pmN/Dkar3Cyx1plKDZi6o00N/AQ9tT799tgK1I5Rxita9FQvHWjvWi1uvrhSSy53GR+JSx
        ueq6Z5AZyJvcUc3AkZjs1LmI9zY0H7qIhKcTLL/vAEMsngPt3dCU2pcq87IaPORxzkpal16IezHz9
        2jtnF2Tc6wnhBxjXURx3ZXQz1PZnZBS5mFR16/RoaAJPVmJsapyQ+DjYg8z8T0cEPdYbaMb+m7AZJ
        XFRMu8uQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOXCG-009RBC-SH; Tue, 23 Mar 2021 02:55:13 +0000
Subject: Re: [PATCH] rcu: Fix various typos in comments
To:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210322230258.GA1983587@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70fcf956-5242-db43-b039-eb82f722eb36@infradead.org>
Date:   Mon, 22 Mar 2021 19:55:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322230258.GA1983587@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 4:02 PM, Ingo Molnar wrote:
> 
> Hi Paul,
> 
> Was working on automation to make it a bit more straightforward to fix 
> typos within comments (which we tend to reintroduce during 
> development), and here are the ones it found in the RCU code.
> 
> Thanks,
> 
> 	Ingo
> 
> =========>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Mon, 22 Mar 2021 23:57:26 +0100
> Subject: [PATCH] rcu: Fix various typos in comments
> 
> Fix ~12 single-word typos in RCU code comments.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c                                           | 4 ++--
>  kernel/rcu/sync.c                                               | 2 +-
>  kernel/rcu/tasks.h                                              | 8 ++++----
>  kernel/rcu/tree.c                                               | 4 ++--
>  kernel/rcu/tree.h                                               | 2 +-
>  kernel/rcu/tree_plugin.h                                        | 2 +-
>  tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h | 2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)

> diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> index d4558ab7a07d..3eeb871cf0de 100644
> --- a/kernel/rcu/sync.c
> +++ b/kernel/rcu/sync.c
> @@ -94,7 +94,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
>  		rcu_sync_call(rsp);
>  	} else {
>  		/*
> -		 * We're at least a GP after the last rcu_sync_exit(); eveybody
> +		 * We're at least a GP after the last rcu_sync_exit(); everybody
>  		 * will now have observed the write side critical section.
>  		 * Let 'em rip!.

		Drop the '.'.

>  		 */
Otherwise LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

