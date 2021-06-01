Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD33238DF07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 03:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhEXB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhEXB6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 21:58:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BCCC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 18:56:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g24so13912791pji.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 18:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FM+e38Wml7m54RkS7j2rn27xqbrXlTey4W5nT4IOzRY=;
        b=kgUtrQAVbJ90/URD++DxPVVktR7e+fQ6cpKz9a8Bdne0dhW9wsTUhXFpEAuiXLnjAb
         RcYUBACPQTdxyl3piDXOJ6yb9iQrSw/wT13J8c5MJUaHeEuMefb87rjCtJ+OAF57m1Qf
         alNUUiWm17hDddpVqiSG55uHd0hGFb+VTmaWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FM+e38Wml7m54RkS7j2rn27xqbrXlTey4W5nT4IOzRY=;
        b=ZmspQraaFTvMKCcZxi3c6+zaEIBl5h/xZK4iqiCSqu3yFU0TIwIyi817Ile8lsrnHk
         LrrjYlVLsPgV8b3x8CEuKunbGl6XKwK1sUtGInmeeGYB3s7nSyWjXZAKzOll9HrQ2Zul
         iU02F/iCfAR7epHFVECHFbNg3xttdX/N3hhOGm4Deuws/Sn2w697sG+WOpR3C5CnlH1v
         lIa7eCq/qZtlmxnksMt7Z3fcSF8QAqUT07iurWGQVPPCdNUJB6cvBojG7WLPoFfNxSxJ
         AeZNsg1orA6eh36eLtG9t1skuN+3JZozKwiT7dQHiH7uMQk2wg32tcTuyjwVKcC5igvB
         SzCg==
X-Gm-Message-State: AOAM531fWsnpjRVahTDDukoyVJoVkmGNK2yBnp01xf4jWhQs0iYnlIJf
        MACl5MqeExAzuhjwzLsnZOVbBVyxTuX+WA==
X-Google-Smtp-Source: ABdhPJy8vY4fjpNXm+3Ebx73BqIL5wz4RB5QpEnA4CRnwfzSdC0pRLC3rrYVy1abizhxJ5haM7h7/w==
X-Received: by 2002:a17:90a:a25:: with SMTP id o34mr19684348pjo.221.1621821409698;
        Sun, 23 May 2021 18:56:49 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:7357:1320:fdb3:1853])
        by smtp.gmail.com with ESMTPSA id o4sm8790658pjf.9.2021.05.23.18.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 18:56:49 -0700 (PDT)
Date:   Mon, 24 May 2021 10:56:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <YKsH3GrEoxcMf4j0@google.com>
References: <20210521155624.174524-1-senozhatsky@chromium.org>
 <20210521180127.GD4441@paulmck-ThinkPad-P17-Gen-1>
 <20210521213855.GA3437356@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521213855.GA3437356@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/21 14:38), Paul E. McKenney wrote:
> 
> And on that otherwise inexplicable refetch of the jiffies counter within
> check_cpu_stall(), the commit below makes it more effective.
> 
> If check_cpu_stall() is delayed before or while printing the stall
> warning, we really want to wait the full time duration between the
> end of that stall warning and the start of the next one.
>

Nice improvement!

> Of course, if there is some way to learn whether printk() is overloaded,
> even more effective approaches could be taken.

There is no better to do this.

> commit b9c5dc2856c1538ccf2d09246df2b58bede72cca
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri May 21 14:23:03 2021 -0700
> 
>     rcu: Start timing stall repetitions after warning complete
>     
>     Systems with low-bandwidth consoles can have very large printk()
>     latencies, and on such systems it makes no sense to have the next RCU CPU
>     stall warning message start output before the prior message completed.
>     This commit therefore sets the time of the next stall only after the
>     prints have completed.  While printing, the time of the next stall
>     message is set to ULONG_MAX/2 jiffies into the future.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

FWIW,

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 05012a8081a1..ff239189a627 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -648,6 +648,7 @@ static void print_cpu_stall(unsigned long gps)
>  
>  static void check_cpu_stall(struct rcu_data *rdp)
>  {
> +	bool didstall = false;
>  	unsigned long gs1;
>  	unsigned long gs2;
>  	unsigned long gps;
> @@ -693,7 +694,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	    ULONG_CMP_GE(gps, js))
>  		return; /* No stall or GP completed since entering function. */
>  	rnp = rdp->mynode;
> -	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> +	jn = jiffies + ULONG_MAX / 2;
>  	if (rcu_gp_in_progress() &&
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> @@ -710,6 +711,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		print_cpu_stall(gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
>  			rcu_ftrace_dump(DUMP_ALL);
> +		didstall = true;
>  
>  	} else if (rcu_gp_in_progress() &&
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> @@ -727,6 +729,11 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		print_other_cpu_stall(gs2, gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
>  			rcu_ftrace_dump(DUMP_ALL);
> +		didstall = true;
> +	}
> +	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {

Can `rcu_state.jiffies_stall` change here?

> +		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> +		WRITE_ONCE(rcu_state.jiffies_stall, jn);
>  	}
>  }
