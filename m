Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5765390778
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhEYR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhEYRZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:25:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=o5bFZZx4+5hZCEtN64VRrO77CmVLQFfTKZ1IOxkh7y4=; b=EQu9zvAjEeMWS3RIcy4/8iIvIc
        rM3SCfgb5Cboq+HFpszga4LKRa3UNIRGi27YMHHvxFJeomRiT2HPi+WEr9NILr4j/FFGY5Z6a33iU
        tZ5apUog7W+F+OzOcSl9hDVz4KUvrJwKOwD/EnCYBSS9ssCJ2+FihV3B5aRI6/u8oHX4Y9Z6W49V4
        wAlGc3LOOce9N0EVwSKzk3RuZnNOZ5FhEgYErurzUssV+xFOlJbH0TIK3CPYvDC6GGRk6ChBVaUMP
        /Ft07qk+DhIvRfJP3xiK0abmxuGEvqjZVhjkIgfkyfJK6IW0rlR+KLf4gCEjFQ2wPjuOJWWjsHl72
        w5zdfJ3g==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llamt-006q9u-3w; Tue, 25 May 2021 17:24:15 +0000
Subject: Re: [PATCH] sched: Add CONFIG_SCHED_CORE help text
To:     Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        Ingo Molnar <mingo@kernel.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, Valentin Schneider <valentin.schneider@arm.com>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
 <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ded8f400-a0ee-db97-098d-8fa0c2fdfd18@infradead.org>
Date:   Tue, 25 May 2021 10:24:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 12:05 AM, Peter Zijlstra wrote:
> Subject: sched: Add CONFIG_SCHED_CORE help text
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue May 25 08:53:28 CEST 2021
> 
> Hugh noted that the SCHED_CORE Kconfig option could do with a help
> text.
> 
> Requested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/Kconfig.preempt |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -104,4 +104,18 @@ config SCHED_CORE
>  	bool "Core Scheduling for SMT"
>  	default y
>  	depends on SCHED_SMT
> +	help
> +	  This option permits Core Scheduling, a means of coordinated task
> +	  selection across SMT siblings. When enabled -- see
> +	  prctl(PR_SCHED_CORE) -- task selection ensures that all SMT siblings
> +	  will execute a task from the same 'core group', forcing idle when no
> +	  matching task is found.
> +
> +	  Use of this feature includes:
> +	   - mitigation of some (not all) SMT side channels;
> +	   - limiting SMT interference to improve determinism and/or performance.
> +
> +	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
> +	  unused there should be no impact on performance.
> +
>  
> 


-- 
~Randy

