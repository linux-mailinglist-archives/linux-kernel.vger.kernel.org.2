Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68F42892A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhJKIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbhJKIx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:53:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA63C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7YVymMd1SbIp4GGj6cvsViy3NVnVBW502IFSGTTc15g=; b=hC/2VI3bQPtweCVTvBVDOAPH2H
        opdczrNE5tbrFkVWctScNRc9NA1YZlHh4OGk1LNSSM4CJYsK9trCjmrPLeB9TSHlxDvls7kyOwf7D
        MsH2pqc8Y1wjwcCvzBU3nJlL5Vk9TpDgzKCbk2UCbEFbPFwPQVPqiah7GXDWrTxYsvW1E7NUnvBck
        od8/6qMrctyy5uTJZPyyFAowAm6aWYc6HAc0IGuOApG4gKoRbFYOyfNj3wypf5s25MExqRDjsg9sp
        /z0ppkyWA6NQMPY2cQDZ3aA4vpjLelQPcgAy3iinw/JysDFKyWPtmLcTNGlJZoSfmvCmsSHFYqTkM
        TlCWEjbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZqyy-005OkA-DM; Mon, 11 Oct 2021 08:48:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67EBB3001E1;
        Mon, 11 Oct 2021 10:48:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09ED72BFB0E3D; Mon, 11 Oct 2021 10:48:28 +0200 (CEST)
Date:   Mon, 11 Oct 2021 10:48:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RESEND PATCH v2] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <YWP6W7Be0Yp6egsn@hirez.programming.kicks-ass.net>
References: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
 <20211008200328.5b88422d@oasis.local.home>
 <bcdbccc6-a516-2199-d3be-090a5e9f601d@linux.alibaba.com>
 <YWP2rtX9Ol9dZc/l@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWP2rtX9Ol9dZc/l@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:32:46AM +0200, Peter Zijlstra wrote:
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index a9f9c5714e65..ca12e2d8e060 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -214,7 +214,14 @@ static __always_inline void trace_clear_recursion(int bit)
>  static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
>  							 unsigned long parent_ip)
>  {
> -	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
> +	bool ret;
> +
> +	preempt_disable_notrace();
> +	ret = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
> +	if (!ret)
> +		preempt_enable_notrace();
> +
> +	return ret;
>  }
>  
>  /**

Oh, I might've gotten that wrong, I assumed regular trylock semantics,
but it doesn't look like that's right.
