Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83B13E47E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhHIOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHIOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:46:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00E4B61002;
        Mon,  9 Aug 2021 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520072;
        bh=LEtGDd/n8Dwr8IsRoI3nBLpetn6vDVygX+cnpP3VZco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xh3ZxqmYpkQ2uvzmkdNL0Rr3K4yYfz6iTv2r8rd4cBL2iHaEXejM6yQ5UcyUNXDgn
         /QRI92NOHUbtvEnB5MYnQll+fn1U/6p2FsUoXVjUXbCsVlNuxB6dXCVL4044yVt0tL
         TTRRqaLd42GWHYRDfTTE7q0KgYOyHd8iGvOu1Hmyk4z9yfgsKnvDu51y2oXl86yxGX
         lqFVXjbRYBCPjiJnzOw2DPeVjtAJ+mutGsr2HaJNJsz7abCB7FPcB1qQT+jAE9M1O4
         O3vNBi4fL/YBWiFwgYH5wOsr6sLkcu0f/ljqrbBD08SuAeyLI2ByhEHY0yKFeKSZwJ
         YoIxNTVzC6BIQ==
Date:   Mon, 9 Aug 2021 15:41:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Add the missing 'ES' of macro
 CONFIG_DEBUG_RT_MUTEXES
Message-ID: <20210809144107.GA1458@willie-the-truck>
References: <20210731123011.4555-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731123011.4555-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 08:30:11PM +0800, Zhen Lei wrote:
> The build option name is defined as DEBUG_RT_MUTEXES in lib/Kconfig.debug,
> commit f41dcc18698e ("locking/rtmutex: Move debug functions as inlines
> into common header") can also corroborate this.
> 
> Fixes: f7efc4799f81 ("locking/rtmutex: Inline chainwalk depth check")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/locking/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index b5d9bb5202c6..ad0db322ed3b 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -343,7 +343,7 @@ static __always_inline bool
>  rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
>  			      enum rtmutex_chainwalk chwalk)
>  {
> -	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
> +	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
>  		return waiter != NULL;
>  	return chwalk == RT_MUTEX_FULL_CHAINWALK;

Oops, yes. How did you find this?

Acked-by: Will Deacon <will@kernel.org>

Will
