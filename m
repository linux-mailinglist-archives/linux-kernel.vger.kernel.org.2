Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7494241DBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351682AbhI3ODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351598AbhI3ODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:03:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD70C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:01:21 -0700 (PDT)
Date:   Thu, 30 Sep 2021 16:01:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633010479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEaU61dOdKgM7/AO/0iYOp6ClHW9w4Lvq2/tyBRb3F0=;
        b=qRI6kak+J1IF5brZ3i3lxzTFpnL6+Tlu2CTHSNov0hFcurHrnXpo/llbrfJs6HPtxMYkQX
        E2bObP6fJP0pK8GOMvf86LMEEQXVrJx3CroEjM5FpdJgTmVx3T7KjNQiJcvR9g94+8/gJN
        X2/jgq4de8oHVQLWCLPSQH8FhSihRUSz0hTU9UWcVAfZ2ezWJSOD08byEqbIgnSs2jYmYf
        7Sr9we/RyQT9KDNcw9Q9e3Rir6Gf1hQ+jkYto1nJIjADsn7o5Q+gBlmtZPeRZRMIKUs8Jk
        sVq4XRJE0Lu3HlCLR0oU0Fa3ljcPV0qvA0ARCikp8G9ah4cz5YTYH50kp1an5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633010479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEaU61dOdKgM7/AO/0iYOp6ClHW9w4Lvq2/tyBRb3F0=;
        b=DckXyQJjpUYLUZyL6exsf+TwGpGbCLHc8ihveqqcbfIspT92KdxFdpxWSObYivI5eIcF32
        tun9y7n/a0ywYeBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     peterz@infradead.org, valentin.schneider@arm.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com
Subject: Re: [RFC] cpu/hotplug: allow the cpu in UP_PREPARE state to bringup
 again
Message-ID: <20210930140118.z352cj3uzjscctcb@linutronix.de>
References: <20210901051143.2752-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901051143.2752-1-longpeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 13:11:43 [+0800], Longpeng(Mike) wrote:
> The cpu's cpu_hotplug_state will be set to CPU_UP_PREPARE before
> the cpu is waken up, but it won't be reset when the failure occurs.
> Then the user cannot to make the cpu online anymore, because the
> CPU_UP_PREPARE state makes cpu_check_up_prepare() unhappy.
> 
> We should allow the user to try again in this case.

Can you please describe where it failed / what did you reach that state?

> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  kernel/smpboot.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index f6bc0bc..d18f8ff 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
>  		 */
>  		return -EAGAIN;
>  
> +	case CPU_UP_PREPARE:
> +		/*
> +		 * The CPU failed to bringup last time, allow the user
> +		 * continue to try to start it up.
> +		 */
> +		return 0;
> +
>  	default:
>  
>  		/* Should not happen.  Famous last words. */
> -- 
> 1.8.3.1

Sebastian
