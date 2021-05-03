Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2562F371572
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhECMxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:53:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233834AbhECMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:53:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D57481063;
        Mon,  3 May 2021 05:52:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 460E73F70D;
        Mon,  3 May 2021 05:52:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
To:     Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, qperret@qperret.net
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
References: <20210429101948.31224-1-Pierre.Gondois@arm.com>
 <20210429101948.31224-3-Pierre.Gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <013382c7-bccf-9e49-4a6b-5542cdd4abba@arm.com>
Date:   Mon, 3 May 2021 14:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429101948.31224-3-Pierre.Gondois@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 12:19, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>

[...]

> @@ -6680,25 +6686,23 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			}
>  		}
>  	}
> -unlock:
> +

No need for empty line.

>  	rcu_read_unlock();
>  
>  	/*
>  	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
>  	 * least 6% of the energy used by prev_cpu.
>  	 */
> -	if (prev_delta == ULONG_MAX)
> -		return best_energy_cpu;
> -
> -	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> -		return best_energy_cpu;
> +	if ((prev_delta == ULONG_MAX) ||
> +		(prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> +		target = best_energy_cpu;

       if ((prev_delta == ULONG_MAX) ||
-               (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
+           (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
                target = best_energy_cpu;

IMHO, using whitespaces to align both sub-conditions here makes it more
readable. Especially since braces aren't required around single
statements with a condition spanning over multiple lines.

[...]

With these minor things sorted:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
