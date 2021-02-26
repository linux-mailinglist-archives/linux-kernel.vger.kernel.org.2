Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A99325ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:20:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98338C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FToGrYZEhZ7do+of2HQZjjIowx4FaKkixGMAN3TvLg8=; b=B03MWOGl2rPry5VwLgE6XGeK2U
        TaTEoYBT/ZsHpYZE+bl0QOC4ozB6bXFhUAzlCvqxZGPZVBVw03BAxUWAFm2ousoh6WFOIIIOF6E9o
        Jt1rLd9C+7P/AOtSlD3F4Y0bHwdFbhhluSjLHnuN+OIuLTBmAY1KWGB9H07BOf/k6XQlGrf68WOgf
        fYVOxUMGM8PSo9T53j2RIIFsx2Pd0Lai7RZKZtOAv1n6Ay5DlfsPwVm8D2bPAJZmTsxCYDziDmWRS
        ugXy6002EFwCLVdPHCefHi+BCXnYudfbrG9T/OA88xAzc+ZmpJDeGctvC5XRwsJPVeUgwqyLfyJSZ
        A36LdYsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFYLP-00052B-Uk; Fri, 26 Feb 2021 08:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DB783011F0;
        Fri, 26 Feb 2021 09:19:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70C8F2016F991; Fri, 26 Feb 2021 09:19:23 +0100 (CET)
Date:   Fri, 26 Feb 2021 09:19:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     wangjingyu <wangjingyu@uniontech.com>
Cc:     paulmck@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        elver@google.com, rppt@kernel.org, samitolvanen@google.com,
        axboe@kernel.dk, a.darwish@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/init_task.c spaces required around that '='
Message-ID: <YDivC1LYwOleJ7n/@hirez.programming.kicks-ass.net>
References: <20210226070900.17730-1-wangjingyu@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226070900.17730-1-wangjingyu@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 03:09:00PM +0800, wangjingyu wrote:
> Ensure checkpatch compliance
> 
> Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
> ---
>  init/init_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 15f6eb93a04f..0f995118c6c0 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -81,7 +81,7 @@ struct task_struct init_task
>  	.policy		= SCHED_NORMAL,
>  	.cpus_ptr	= &init_task.cpus_mask,
>  	.cpus_mask	= CPU_MASK_ALL,
> -	.nr_cpus_allowed= NR_CPUS,
> +	.nr_cpus_allowed = NR_CPUS,

Screw checkpatch, this breaks alignment.

>  	.mm		= NULL,
>  	.active_mm	= &init_mm,
>  	.restart_block	= {
> -- 
> 2.11.0
> 
> 
> 
