Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A633A3E73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFKJBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhFKJBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B4A660BD3;
        Fri, 11 Jun 2021 08:59:15 +0000 (UTC)
Date:   Fri, 11 Jun 2021 09:59:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: use READ_ONCE() for accessing
 jiffies_scan_wait
Message-ID: <20210611085913.GA8132@arm.com>
References: <20210609155657.26972-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609155657.26972-1-yanfei.xu@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:56:57PM +0800, Yanfei Xu wrote:
> The stop_scan_thread() and start_scan_thread() cannot really solve
> the problem of concurrent accessing the global jiffies_scan_wait.
> 
> kmemleak_write              kmemleak_scan_thread
>                               while (!kthread_should_stop())
>   stop_scan_thread
>   jiffies_scan_wait = xxx       timeout = jiffies_scan_wait
>   start_scan_thread
> 
> We could replace these with a READ_ONCE() when reading
> jiffies_scan_wait. It also can prevent compiler from reordering the
> jiffies_scan_wait which is in while loop.

I'm ok with READ_ONCE but your patch introduces functional changes.

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 92a2d4885808..5ccf3969b7fe 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1567,7 +1567,7 @@ static int kmemleak_scan_thread(void *arg)
>  	}
>  
>  	while (!kthread_should_stop()) {
> -		signed long timeout = jiffies_scan_wait;
> +		signed long timeout = READ_ONCE(jiffies_scan_wait);
>  
>  		mutex_lock(&scan_mutex);
>  		kmemleak_scan();
> @@ -1812,11 +1812,8 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
>  		ret = kstrtoul(buf + 5, 0, &secs);
>  		if (ret < 0)
>  			goto out;
> -		stop_scan_thread();
> -		if (secs) {
> +		if (secs)
>  			jiffies_scan_wait = msecs_to_jiffies(secs * 1000);

For symmetry, I'd add a WRITE_ONCE here as well.

> -			start_scan_thread();
> -		}

The reason for stop/start_scan_thread() wasn't to protect against
jiffies_scan_wait access but rather to force a new delay. Let's say you
start by default with a 10min delay between scans (default) but you want
to lower it to 1min. With the above removal of stop/start, you'd still
have to wait for 10min until the scanning thread will notice the change.
Also, with secs=0, the expectations is that the thread won't be
restarted but this is removed by your patch.

-- 
Catalin
