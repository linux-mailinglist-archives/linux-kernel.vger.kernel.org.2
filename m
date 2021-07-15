Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034203C9EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhGOMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:36:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhGOMgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49BD131B;
        Thu, 15 Jul 2021 05:33:54 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B59C3F694;
        Thu, 15 Jul 2021 05:33:53 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Update nohz.next_balance for newly NOHZ-idle
 CPUs
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210714113928.2795632-1-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <21fda84b-3d66-e8c1-f384-026adbc28ac4@arm.com>
Date:   Thu, 15 Jul 2021 14:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714113928.2795632-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2021 13:39, Valentin Schneider wrote:

[...]

> @@ -8942,6 +8946,10 @@ void __init sched_init(void)
>  			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>  		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>  			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +#ifdef CONFIG_NOHZ_COMMON
> +		per_cpu(nohz_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> +			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +#endif /* CONFIG_NOHZ_COMMON */
>  	}
>  #endif /* CONFIG_CPUMASK_OFFSTACK */

s/CONFIG_NOHZ_COMMON/CONFIG_NO_HZ_COMMON

Otherwise CONFIG_CPUMASK_OFFSTACK system will have issues.

[...]
