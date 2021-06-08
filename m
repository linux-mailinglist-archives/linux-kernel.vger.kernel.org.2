Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B716E39F839
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhFHN7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhFHN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:59:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Op3uqV/A9Ex2YVso6TTgEs9K55khleHTiTDRukTdfE=; b=qf0zzXFVIrl/J+kn4N773PW+X5
        6BcmlkOuZs9JYp2w85Py2TpuvT0usXmHI4yOfYeNErrdyXNhlsR0z7DzDRWgep2dVlL0EQqj9QkQZ
        kiQLloPorWjuE60qFvIO+icJB37JZGLrJryNVhpw3oG6cRIyDGig7+rM08IzHU12Tg9UPTKHHfV/r
        6ipVfYZ/5K1OosTWwkEHJsVnBQB8nK7X4ZoIEsUjNU5URiNJedzp29bsTW850cmwyLMsln4KUf2Tx
        gqWNZn1C17d+8s5SqYHpm6sSaj7fKgOiHfax9e9hLegc/zOKRTZVv1V5eOJdpuzO7AMDzgYZarXWM
        B9yve6Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqcDy-00GzoF-9c; Tue, 08 Jun 2021 13:57:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63FDB30018A;
        Tue,  8 Jun 2021 15:56:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 533EB201E7ED1; Tue,  8 Jun 2021 15:56:57 +0200 (CEST)
Date:   Tue, 8 Jun 2021 15:56:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched: Always print out preempt dynamic state
Message-ID: <YL93KX2go+Qwlhgg@hirez.programming.kicks-ass.net>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608120442.93587-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:04:42PM +0200, Frederic Weisbecker wrote:
> Previously the preempt dynamic mode wasn't printed out if it wasn't
> overriden with the "preempt=" boot option.
> 
> But now that the default preempt dynamic behaviour can be selected at
> Kconfig time, we can't assume anymore that preempt=full is the default.
> The only way to retrieve that information is to browse the kernel config
> file.
> 
> Better print it out unconditionally then.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/sched/core.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index df47a8275c37..6b883adad8f7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6262,6 +6262,21 @@ int sched_dynamic_mode(const char *str)
>  
>  void sched_dynamic_update(int mode)
>  {
> +	switch (mode) {
> +		case preempt_dynamic_none:
> +			pr_info("Dynamic Preempt: none\n");
> +			break;
> +		case preempt_dynamic_voluntary:
> +			pr_info("Dynamic Preempt: voluntary\n");
> +			break;
> +		case preempt_dynamic_full:
> +			pr_info("Dynamic Preempt: full\n");
> +			break;
> +		default:
> +			pr_info("Dynamic Preempt: incorrect\n");
> +			return;
> +	}

Indent fail; for vim, use: set cino=(0:0
