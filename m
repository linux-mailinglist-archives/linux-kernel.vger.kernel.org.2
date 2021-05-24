Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8138E6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhEXM5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:57:18 -0400
Received: from foss.arm.com ([217.140.110.172]:41968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhEXM5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:57:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C682ED1;
        Mon, 24 May 2021 05:55:48 -0700 (PDT)
Received: from [10.57.31.86] (unknown [10.57.31.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377403F719;
        Mon, 24 May 2021 05:55:46 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b2a24d60-966e-7ee6-b3b8-9c1920881d76@arm.com>
Date:   Mon, 24 May 2021 13:55:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 5:54 PM, Vincent Donnefort wrote:
> Some SoCs, such as the sd855 have OPPs within the same performance domain,
> whose cost is higher than others with a higher frequency. Even though
> those OPPs are interesting from a cooling perspective, it makes no sense
> to use them when the device can run at full capacity. Those OPPs handicap
> the performance domain, when choosing the most energy-efficient CPU and
> are wasting energy. They are inefficient.
> 
> Hence, add support for such OPPs to the Energy Model. The table can now
> be read skipping inefficient performance states (and by extension,
> inefficient OPPs).
> 
> Currently, the efficient table is used in two paths. Schedutil, and
> find_energy_efficient_cpu(). We have to modify both paths in the same
> patch so they stay synchronized. The thermal framework still relies on
> the full table.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 9be7bde..daaeccf 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -17,13 +17,25 @@
>    *		device). It can be a total power: static and dynamic.
>    * @cost:	The cost coefficient associated with this level, used during
>    *		energy calculation. Equal to: power * max_frequency / frequency
> + * @flags:	see "em_perf_state flags" description below.
>    */
>   struct em_perf_state {
>   	unsigned long frequency;
>   	unsigned long power;
>   	unsigned long cost;
> +	unsigned long flags;

Maybe for now, we can have 'bool' here?
We would avoid *Num_opps of 'and' operations below

[snip]

> +static inline
> +struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> +						unsigned long freq)
> +{
> +	struct em_perf_state *ps;
> +	int i;
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		ps = &pd->table[i];
> +		if (ps->flags & EM_PERF_STATE_INEFFICIENT)

Here, we can avoid this *N of '&', when having a simple bool

> +			continue;
> +		if (ps->frequency >= freq)
> +			break;
> +	}
> +
> +	return ps;
> +}
> +

[snip

> +static inline unsigned long em_pd_get_efficient_freq(struct em_perf_domain *pd,
> +						     unsigned long freq)
> +{
> +	struct em_perf_state *ps;
> +
> +	if (!pd || !(pd->flags & EM_PERF_DOMAIN_INEFFICIENCIES))

This one is OK, since we have two features for this 'flags' now.

The rest looks good.

Regards,
Lukasz
