Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5505340BEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 06:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhIOEHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 00:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhIOEHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:07:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4BF961261;
        Wed, 15 Sep 2021 04:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631678788;
        bh=WYstT8YUj7N6DeOrzi3FtzLeW79E91ytEQY8XZ7M6Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=by//OxjLEOvgfQI9lVob2GQYVf7o03y2Tcf2Iydip8t4e83ps8T/EDJrhSZVH7kGO
         FoJ39jyJouMWEcJtz2Ycftz2JIYbH1aq9dKxsxz42+xZyeZRyxtoAGrMtIhadDmOD0
         XQsmCsJoPzw1uJubuZmb+Z/XQdgjFjGqbCseA5+s=
Date:   Tue, 14 Sep 2021 21:06:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/5] kernel/watchdog_hld: clarify the condition in
 hardlockup_detector_event_create()
Message-Id: <20210914210627.c92374b3726a22014b359dbd@linux-foundation.org>
In-Reply-To: <20210915035103.15586-3-kernelfans@gmail.com>
References: <20210915035103.15586-1-kernelfans@gmail.com>
        <20210915035103.15586-3-kernelfans@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 11:51:00 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:

> hardlockup_detector_event_create() indirectly calls
> kmem_cache_alloc_node(), which is blockable.
> 
> So here, the really planned context is is_percpu_thread().
> 
> ...
>
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

Can we avoid adding the BUG()?  Find a way to emit a WARNing and then
permit the kernel to continue?

> +	cpu = raw_smp_processor_id();
>  	wd_attr = &wd_hw_attr;
>  	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);

