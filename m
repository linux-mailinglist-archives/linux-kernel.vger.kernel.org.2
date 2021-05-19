Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6105F389520
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhESSPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhESSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:15:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B7C06175F;
        Wed, 19 May 2021 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bEauhK23RkZ9ceUqS0Q5SoC3nKkkUUnGX4i7BzWL1uI=; b=DaOL9sI7s465/b8l1gi6SJsmlP
        wQqlEpoB4sE9z7rMfrIX93vT1P6ssa5zl5Fy/7T0eEJWm7C2fWi22QjBlPeGBqEt5JfVBJTvDKjsz
        /JvLA3f/TQ/xeipragFFvW2nj1bQWzRMt44b2BhH986Tk+CqOZ74EVfrPDtcZmzNF+wcSJfK9pl/7
        jOn1kHEaqYPWvIh3xf74UIjGqLfd/wxeLyH5faWMLe+Llma+xijteG1QqGIzehFZK1JVTdVr6AnwH
        2oYFaC4aG+JY4OPCi43RIYUrFlizu6h3DgVqztD7A7Xvgh7E9OoczfYa20WZmRYRolCKcUjufvgXW
        xf9dQiig==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljQhu-00Fgi1-DZ; Wed, 19 May 2021 18:14:10 +0000
Subject: Re: [RFC PATCH 09/16] rv/monitors: wip instrumentation and
 Makefile/Kconfig entries
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621414942.git.bristot@redhat.com>
 <8ffcb3a4c8b55ef63cc02b487aa1c8ad5bf3f800.1621414942.git.bristot@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae9c9d42-2bee-3f97-1d53-43b876b1ec4f@infradead.org>
Date:   Wed, 19 May 2021 11:14:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8ffcb3a4c8b55ef63cc02b487aa1c8ad5bf3f800.1621414942.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 4:36 AM, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 74eb2f216255..4a1088c5ba68 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -14,6 +14,13 @@ menuconfig RV
>  
>  if RV
>  
> +config RV_MON_WIP
> +	depends on PREEMPTIRQ_TRACEPOINTS
> +	tristate "WIP monitor"
> +	help
> +	  Enable WIP sample monitor, this is a sample monitor that

	                    monitor. This

> +	  illustrates the usage of per-cpu monitors.

What does WIP mean here? I didn't see that in patch 08 (though
I could have missed it -- I did look).


-- 
~Randy

