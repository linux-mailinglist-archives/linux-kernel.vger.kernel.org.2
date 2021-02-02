Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9476230BBCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBBKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBBKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:09:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82746C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 02:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ab16otijG9bvAhz8VfD19hPIsyJecqtgK3hKzle+tDo=; b=cYlNH1xtktfv50ymA4Pp8pOdSN
        gtu1upXQtK08hAxSW0sFfy7aaUEVnjs3I2Rn2tfGMRIMaaV/djL7Bwz8IomO133jPuTlic+JSKhzv
        fvjUOTxYsr7I1ziASa7gu4jySLAJ7XwQVISw05mpzC3QVJ2l6ppoHSEfTxLW79muMKM7aTmDlRZ90
        dC0ICajuvQlTCyS+Zc/oln4H6LKI/gURQi2mRDKYWJ3vNAu8GJq53zjQiTLQIxpk09+k9EIwtBim6
        URi5judJ9OJX/8A5HaQn90bfPy3T3IL0FpZOKZXQiBK1NdI8UvOly/FwcZjlkJRfOuAduCe76AD0I
        icrAJkMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6scC-0006Dk-Rz; Tue, 02 Feb 2021 10:08:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01405301A66;
        Tue,  2 Feb 2021 11:08:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA3DA299C9F60; Tue,  2 Feb 2021 11:08:54 +0100 (CET)
Date:   Tue, 2 Feb 2021 11:08:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] tracepoint: Fix race between tracing and removing
 tracepoint
Message-ID: <YBkkthjSsDXYxHKq@hirez.programming.kicks-ass.net>
References: <20210202072326.120557-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202072326.120557-1-aik@ozlabs.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 06:23:26PM +1100, Alexey Kardashevskiy wrote:
> When executing a tracepoint, the tracepoint's func is dereferenced twice -
> in __DO_TRACE() (where the returned pointer is checked) and later on in
> __traceiter_##_name where the returned pointer is dereferenced without
> checking which leads to races against tracepoint_removal_sync() and
> crashes.
> 
> This adds a check before referencing the pointer in tracepoint_ptr_deref.

Agreed, a reload got added and it doesn't check the value again.

> Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

>  		it_func_ptr =						\
>  			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \

> +		if (it_func_ptr) {					\
> +			do {						\
> +				it_func = (it_func_ptr)->func;		\
> +				__data = (it_func_ptr)->data;		\
> +				((void(*)(void *, proto))(it_func))(__data, args); \
> +			} while ((++it_func_ptr)->func);		\
> +		}							\
>  		return 0;						\


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
