Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5839F86A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhFHOHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbhFHOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:06:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C531C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J43xUH/AHZt4gJaM2xTrRjyhFCkU6scv91z9S7p/g5o=; b=sa7zDG5qeI+XoEULbAJLGTxuG4
        OiePmA+AbUCIunerllEvQZR0v7LY32U9S+ivZGB6eBsiYORlutqLhQHLZy+N9DsGSYFa2H5Blx0id
        vh5d0WfZ8VuvpIsu9kVGj06YH+uZwZFmx+9wvZSvNpaZ6vsRnMXudrv4qvYgEL2uv+9dojiG9Eqhj
        E6h6t/9mcQM1m8yoQgwd7vADwrGgsZlEqHoqTankerPgnuYg5YomZHJQb6wTAFub2yjm7vmVR+tJm
        llPh03GREfzc2xFQOzddJyrdyYQq6eqTz0c1ivg95itJxlfskv2ilxbMr2o9HP5J4kZcfECfOyjHQ
        XJ0C1taA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqcLX-00H0AE-QT; Tue, 08 Jun 2021 14:04:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76A9A30018A;
        Tue,  8 Jun 2021 16:04:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FAF5201DEF2D; Tue,  8 Jun 2021 16:04:47 +0200 (CEST)
Date:   Tue, 8 Jun 2021 16:04:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Message-ID: <YL94/8cSr2R2wiTa@hirez.programming.kicks-ass.net>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-2-frederic@kernel.org>
 <YL92vbcw3ozRLycU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL92vbcw3ozRLycU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:55:09PM +0200, Peter Zijlstra wrote:
> Urgh, would something like this work?
> 
> ---
>  kernel/Kconfig.preempt | 64 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index bd7c4147b9a8..43c68a806e4e 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -1,11 +1,25 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> +config PREEMPT_COUNT
> +       bool
> +
> +config PREEMPTION
> +       bool
> +       select PREEMPT_COUNT
> +
> +config PREEMPT_DYNAMIC_OPTION
> +	bool
> +	help
> +	  Symbol that gates availablility of PREEMPT_DYNAMIC, selected
> +	  by preemption models that can be dynamically selected.
> +
>  choice
>  	prompt "Preemption Model"
> +	default PREEMPT_TYPE_NONE
>  
> +config PREEMPT_TYPE_NONE
>  	bool "No Forced Preemption (Server)"
> +	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
>  	help
>  	  This is the traditional Linux preemption model, geared towards
>  	  throughput. It will still provide good latencies most of the
> @@ -17,9 +31,10 @@ config PREEMPT_NONE
>  	  raw processing power of the kernel, irrespective of scheduling
>  	  latencies.
>  
> +config PREEMPT_TYPE_VOLUNTARY
>  	bool "Voluntary Kernel Preemption (Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> +	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by adding more
>  	  "explicit preemption points" to the kernel code. These new
> @@ -35,12 +50,10 @@ config PREEMPT_VOLUNTARY
>  
>  	  Select this if you are building a kernel for a desktop system.
>  
> -config PREEMPT
> +config PREEMPT_TYPE_FULL
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> +	select PREEMPT_DYNAMIC_OPTION if HAVE_PREEMPT_DYNAMIC
>  	help
>  	  This option reduces the latency of the kernel by making
>  	  all kernel code (that is not executing in a critical section)
> @@ -75,15 +88,24 @@ config PREEMPT_RT
>  
>  endchoice
>  
> +# default model for PREEMPT_DYNAMIC
>  
> +config PREEMPT_DYNAMIC_NONE
> +	bool
>  
> +config PREEMPT_DYNAMIC_VOLUNTARY
> +	bool
> +
> +config PREEMPT_DYNAMIC_FULL
>  	bool
> +
> +config PREEMPT_DYNAMIC
> +	bool "Dynamic Preemption Mode"
> +	depends on PREEMPT_DYNAMIC_OPTION
> +	select PREEMPT
> +	select PREEMPT_DYNAMIC_NONE if PREEMPT_TYPE_NONE
> +	select PREEMPT_DYNAMIC_VOLUNTARY if PREEMPT_TYPE_VOLUNTARY
> +	select PREEMPT_DYNAMIC_FULL if PREEMPT_TYPE_FULL

Arguably PREEMPT_DYNAMIC_{NONE,VOLUNTARY,FULL} are superfluous and the
default selection can use PREEMPT_TYPE_*.

>  	help
>  	  This option allows to define the preemption model on the kernel
>  	  command line parameter and thus override the default preemption
> @@ -100,6 +122,22 @@ config PREEMPT_DYNAMIC
>  	  Interesting if you want the same pre-built kernel should be used for
>  	  both Server and Desktop workloads.
>  
> +# actual preemption model
> +
> +config PREEMPT_NONE
> +	bool
> +	default y if !PREEMPT_DYNAMIC && PREEMPT_TYPE_NONE
> +
> +config PREEMPT_VOLUNTARY
> +	bool
> +	default y if !PREEMPT_DYNAMIC && PREEMPT_TYPE_VOLUNTARY
> +
> +config PREEMPT
> +	bool
> +	default y if !PREEMPT_DYNAMIC && PREEMPT_TYPE_FULL
> +	select PREEMPTION
> +	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
> +
>  config SCHED_CORE
>  	bool "Core Scheduling for SMT"
>  	default y
