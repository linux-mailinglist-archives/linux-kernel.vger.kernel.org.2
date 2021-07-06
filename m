Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE73BC77B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhGFHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhGFHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:54:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h2+X2jUiUw7N4xQlb+2GXTRE5SiK3oXBKYl3mVIx76g=; b=ER59DZ6AwzG4JMo5pUPR+nZpMD
        DSo3rIqaYKZe2q8/nxrfyF0OdiyiwwZ2daPfS0jIlhfZayhwCpisitfHwpUVueDDqGf1jdkE8/zjO
        a/Zy2VIkBoo+ClUJ8smti5yk3KlwL7eSpSTl7Mg38gMfJ0su9TnerqWF4DDkLWXC0HeHEVs6Pv48d
        O1OFDz6IghSin6QuRqz5KTPS6Sl4u3OkM4XXC/rjVTBETxbQ1Pnndw8hAydquQ3xIpZAAYFJ3NUMf
        pDtVUgxeSdnL+gU9hwcBj50TKQz4/3DmkrC052ixiGPSpFSYP9yuIPpstgiw2z+PmX7UvZJPRkAcT
        ns+MQGGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0frD-00AyHU-06; Tue, 06 Jul 2021 07:51:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACE8F3001DC;
        Tue,  6 Jul 2021 09:51:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92FF1200E1E68; Tue,  6 Jul 2021 09:51:01 +0200 (CEST)
Date:   Tue, 6 Jul 2021 09:51:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] rcu: Remove needless preemption disablement in
 rcu_all_qs()
Message-ID: <YOQLZR3lESyLVkex@hirez.programming.kicks-ass.net>
References: <20210705234344.104239-1-frederic@kernel.org>
 <20210705234344.104239-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705234344.104239-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 01:43:44AM +0200, Frederic Weisbecker wrote:
> The preemption is already disabled when we write rcu_data.rcu_urgent_qs.
> We can use __this_cpu_write() directly, although that path is mostly
> used when CONFIG_PREEMPT=n.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 27b74352cccf..38b3d01424d7 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -871,7 +871,7 @@ void rcu_all_qs(void)
>  		preempt_enable();
>  		return;
>  	}
> -	this_cpu_write(rcu_data.rcu_urgent_qs, false);
> +	__this_cpu_write(rcu_data.rcu_urgent_qs, false);

There's another subtle difference between this_cpu_write() and
__this_cpu_write() aside from preempt. this_cpu_write() is also
IRQ-safe, while __this_cpu_write() is not.

I've not looked at the usage here to see if that is relevant, but the
Changelog only mentioned the preempt side of things, and that argument
is incomplete in general.
