Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB23D312F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhBHKvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhBHKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:40:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF25C061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7xqCx4BT8WueOU2RkvLHCdkxtsw/O5oz5D05YzZmJsw=; b=dHRkaR5TrOPAJJx1zFeeoRhfv0
        xy0iUjkgsZ5kOzdrp1JpsO/Nuu1bZtcPvz5SOmdfSCwjI+Chtj8nRqf+yhnZu+PEHhg76HaQenaob
        Vu4eC7hON51qCR3SlHUJSgpEEkXLQ9c5rxWxVIX9qGWKQlRCD7Idah+3XgtYQmzn8dOaVahEv2Zqt
        5tXCpprZByi3SkfdIKmFF5V794CZRleQHe+/Dw7HwzloA1cD5Mtbs2kBNiooYHfZ9ihzbONYK6h0F
        NMWAK4QMzKuiCeADdtxy2jm0FvUH7nWMCXzA6lUNQ7LblDo2kZP3UPxOTerGwbEf9VCTzAhijPjY2
        4nROpgog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l93x0-0008RM-Ck; Mon, 08 Feb 2021 10:39:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 346AD3012DF;
        Mon,  8 Feb 2021 11:39:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 222D02BF248D5; Mon,  8 Feb 2021 11:39:25 +0100 (CET)
Date:   Mon, 8 Feb 2021 11:39:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched: make struct task_struct::state 32-bit
Message-ID: <YCEU3SSoYneIh5t1@hirez.programming.kicks-ass.net>
References: <20210206151832.GA487103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206151832.GA487103@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 06:18:32PM +0300, Alexey Dobriyan wrote:
> 32-bit accesses are shorter than 64-bit accesses on x86_64.
> Nothing uses 64-bitness of struct task_struct::state.
> 
> Propagate 32-bitness to other variables and functions.

You're saving a handful of bytes, why?

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -655,7 +655,7 @@ struct task_struct {
>  	struct thread_info		thread_info;
>  #endif
>  	/* -1 unrunnable, 0 runnable, >0 stopped: */
> -	volatile long			state;
> +	volatile int			state;

A much larger, but probably more useful cleanup would be to get rid of
that volatile.
