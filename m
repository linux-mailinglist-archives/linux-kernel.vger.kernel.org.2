Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEF140C697
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhIONre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhIONrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:47:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KGeyo69IOf8jXHMIDvz7bZx3lbLuH6HqZKyrsohBeAI=; b=qd7CqgiDWVYAXJjihKTzs3TJJk
        KN//U6thCnw4XKFxxhsOS22B3m5RIBThcejY8uK+RRtHTF01qSEy+KDfUZhHyRYhWs6TpVEWAM5aX
        Ms4nQ/kmNn9A60NCWgPZ4Bos7AdDmLzLT78JhdLG2rDAmI+H5Uo1LP9EBh+aBEjNHlGXRPF6qwhpq
        KMmhsX1oyB9mqdJNsny0jAcPedSglqIjN6ZHJKbOiOn42NT3aUPKs4UuKNan+HTVorSiYy9POaA39
        76SGJqD/5dpN4EEsTEZ8KKT/eiSXIhr+SC+keS0BGzWaG3XYv6NlyW4wkgP8EzuvBf6Y3n96zBdue
        j3bkzw1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVDo-00FiXm-SH; Wed, 15 Sep 2021 13:45:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC1C430003A;
        Wed, 15 Sep 2021 15:45:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 972AB234E53A7; Wed, 15 Sep 2021 15:45:06 +0200 (CEST)
Date:   Wed, 15 Sep 2021 15:45:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/5] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-ID: <YUH44qrky9oM+3nU@hirez.programming.kicks-ass.net>
References: <20210915035103.15586-1-kernelfans@gmail.com>
 <20210915035103.15586-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915035103.15586-3-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:51:00AM +0800, Pingfan Liu wrote:
> hardlockup_detector_event_create() indirectly calls
> kmem_cache_alloc_node(), which is blockable.
> 
> So here, the really planned context is is_percpu_thread().
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang Qing <wangqing@vivo.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Santosh Sivaraj <santosh@fossix.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/watchdog_hld.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..6876e796dbf5 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -165,10 +165,13 @@ static void watchdog_overflow_callback(struct perf_event *event,
>  
>  static int hardlockup_detector_event_create(void)
>  {
> -	unsigned int cpu = smp_processor_id();
> +	unsigned int cpu;
>  	struct perf_event_attr *wd_attr;
>  	struct perf_event *evt;
>  
> +	/* This function plans to execute in cpu bound kthread */
> +	BUG_ON(!is_percpu_thread());
> +	cpu = raw_smp_processor_id();
>  	wd_attr = &wd_hw_attr;
>  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);

This patch makes no sense.
