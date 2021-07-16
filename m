Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5E3CB26D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhGPG0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhGPG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:26:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B98C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:23:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o201so8050977pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xzgmBAMTKaWW+fbNYQ+L7b6kv6KG0i0qA+QcZiCEoI=;
        b=I3orhdAUR1175eZURxhfyAJ7CqobfiowaeAbvpi0ScsDi7od82tNTkpOsIEb5vuXc8
         uiJP08+iZjRudNpKVDVpC6LkhFZYlyh5DTRaP4y4/vl108u3qC4+z29trzopkkDxL6kS
         H3ruEBFeLwf7uY82Ofn/VXwN99zQQCXxhQiuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xzgmBAMTKaWW+fbNYQ+L7b6kv6KG0i0qA+QcZiCEoI=;
        b=rFy+rY79Ix+pCfM3KVqPDXzdmDTKFZtbZNKC01L2RtFDBXJYZQ9UfYAc7+/NHMm3Hi
         HjzsECHc9MXNqyhHqvWIobpoCHNZIIJxApeONAk7HbwWk2ge1OZNoPR1HqpnPqWzdG0u
         uH32grbQ4DUpKV3yZcZIxxH0CVXL4Bz/QhWRO1qylAvBh1OjU1UMqq0At0gixtDenAzT
         EWeQKmwuY1RW3QW0hexQCAIQi6vyrcpUzb/TBe+daBF6WJA4ZnteuTK3TwEIJ1BIvldz
         7ZCycFLbtaqjn62y1oYsz5UX5r6wZINkdPCMOBICPgteplvKXYGsOSz8qt9JnJ0PtcEu
         W6qw==
X-Gm-Message-State: AOAM530COnAXgeL+7Slz8Kl+ZREJ1NfxdT8YhKQVCQaRjeFZzjEM+Mgb
        ujPou/jgwY4wLeD5qoKrPUHcpg==
X-Google-Smtp-Source: ABdhPJxlm5rRKo8YGCJc75HnetKVDPUTsWuJ7zBzLBP/3F472XDqMZCaxZFCoFMsG8oYEG/Wr6Zg4g==
X-Received: by 2002:a63:1d41:: with SMTP id d1mr8403424pgm.199.1626416592834;
        Thu, 15 Jul 2021 23:23:12 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:d1af:356e:50a6:75e8])
        by smtp.gmail.com with ESMTPSA id bj15sm7295551pjb.6.2021.07.15.23.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 23:23:12 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:23:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] rcu: call kvm_check_and_clear_guest_paused
 unconditionally
Message-ID: <YPEly3zNxNUjuc5i@google.com>
References: <20210716054113.1244529-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716054113.1244529-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/16 14:41), Sergey Senozhatsky wrote:
> @@ -657,6 +657,13 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	unsigned long js;
>  	struct rcu_node *rnp;
>  
> +	/*
> +	 * If a virtual machine is stopped by the host it can look to
> +	 * the watchdog like an RCU stall. Check to see if the host
> +	 * stopped the vm.
> +	 */
> +	kvm_check_and_clear_guest_paused();
> +
>  	lockdep_assert_irqs_disabled();
>  	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
>  	    !rcu_gp_in_progress())
> @@ -699,14 +706,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>  	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> -
>  		/* We haven't checked in, so go dump stack. */
>  		print_cpu_stall(gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
> @@ -717,14 +716,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>  		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
>  
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like an RCU stall. Check to see if the host
> -		 * stopped the vm.
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return;
> -
>  		/* They had a few time units to dump stack, so complain. */
>  		print_other_cpu_stall(gs2, gps);
>  		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))

This patch depends on
https://lore.kernel.org/lkml/20210716053405.1243239-1-senozhatsky@chromium.org/

If that x86/kvm patch lands, then we need to handle
PVCLOCK_GUEST_STOPPED in watchdogs.


In theory, this patch opens a small race window, if the VCPU gets preempted
after kvm_check_and_clear_guest_paused() (external interrupt, etc.)
But it's hard to tell how likely the problem is.
