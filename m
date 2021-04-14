Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9B35F888
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352542AbhDNP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351032AbhDNP46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:56:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0A926112F;
        Wed, 14 Apr 2021 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618415797;
        bh=GBahCXxJ62uOp5Wtb/xiDQbIOdfZywgcb2iH1Iqnvp4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tkg4Crus0F+kFlIFrgeB0QIcyK2C7kufwF2rcxO47UUgTo4ii4ivT/2obecgMEunu
         dKGBxdfg58Gv3bQ5QJM4XtC4qrWP9NXHQPVYsPq43TpL54FWO/UBEbve2lGOyX02YX
         LWfAseWf9VaFDDQb1jP1Tiu5Ut9D0QcvL5kW/E3kBsatrWdurEJmXyaq8zJmGdxj5S
         05uFF4oj07XlHQlf9DMbR6Gg49nBm2CC+xQo9ss7MHmYgfw8kFCOAZaE1Ky3etNAcl
         K2VYcd6S+zwFxt0K8dsj9+mor6UCsxvry72Lv9P44dpIFltn2n8DEKBIw7QNKb9m54
         lD9WTE1p1USzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BD88C5C034B; Wed, 14 Apr 2021 08:56:36 -0700 (PDT)
Date:   Wed, 14 Apr 2021 08:56:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] srcu: Early test SRCU polling start
Message-ID: <20210414155636.GP4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414132413.98062-1-frederic@kernel.org>
 <20210414132413.98062-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414132413.98062-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 03:24:13PM +0200, Frederic Weisbecker wrote:
> Test an early call to start_poll_synchronize_srcu() and place it before
> the early test to call_srcu() on the same ssp.
> 
> After the later call to srcu_barrier(), we expect the first grace period
> completion to be visible by a subsequent call to
> poll_state_synchronize_srcu(). Report otherwise.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Given the first patch, this one looks good, give or take my usual
editing compulsion.

							Thanx, Paul

> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> ---
>  kernel/rcu/update.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index dd94a602a6d2..c21b38cc25e9 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -524,6 +524,7 @@ static void test_callback(struct rcu_head *r)
>  }
>  
>  DEFINE_STATIC_SRCU(early_srcu);
> +static unsigned long early_srcu_cookie;
>  
>  struct early_boot_kfree_rcu {
>  	struct rcu_head rh;
> @@ -536,8 +537,10 @@ static void early_boot_test_call_rcu(void)
>  	struct early_boot_kfree_rcu *rhp;
>  
>  	call_rcu(&head, test_callback);
> -	if (IS_ENABLED(CONFIG_SRCU))
> +	if (IS_ENABLED(CONFIG_SRCU)) {
> +		early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
>  		call_srcu(&early_srcu, &shead, test_callback);
> +	}
>  	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>  	if (!WARN_ON_ONCE(!rhp))
>  		kfree_rcu(rhp, rh);
> @@ -563,6 +566,7 @@ static int rcu_verify_early_boot_tests(void)
>  		if (IS_ENABLED(CONFIG_SRCU)) {
>  			early_boot_test_counter++;
>  			srcu_barrier(&early_srcu);
> +			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
>  		}
>  	}
>  	if (rcu_self_test_counter != early_boot_test_counter) {
> -- 
> 2.25.1
> 
