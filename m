Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710034FF85
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhCaLfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:35:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29692 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhCaLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:34:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617190498; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=aLE2e54gqStA8Gea85ZN6DBrVkGCQq0RGwMhe1LwdI0=; b=eyPlpdErgWEKkop0AtNIHe6NQ/T5xI0gpXdjRj/0E3QJ0aHGUvlTO6wyG3sHCaUHLCeoupb2
 nPeDIc8It3sQKLXLHtKG5vXTY2TJkc5piAJhz11rdIAYfwA73132vW/f9UpyXq8Pla7I+Ydj
 enHqRpLhQovuNi0iaKZQ42BNlOo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60645e5f9a9ff96d95ba4837 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 31 Mar 2021 11:34:55
 GMT
Sender: clingutla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90847C43461; Wed, 31 Mar 2021 11:34:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.43.40] (unknown [223.185.99.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 590E7C433CA;
        Wed, 31 Mar 2021 11:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 590E7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=clingutla@codeaurora.org
Subject: Re: [PATCH v3 4/7] sched/fair: Introduce a CPU capacity comparison
 helper
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-5-valentin.schneider@arm.com>
From:   Chandra Sekhar Lingutla <clingutla@codeaurora.org>
Message-ID: <c833d09c-d99f-7541-f8cb-5202dc5e7243@codeaurora.org>
Date:   Wed, 31 Mar 2021 17:04:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210311120527.167870-5-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

The reduced margin is helping our platforms, Please feel free to add my 
tested-by tag:

Tested-by:  Lingutla Chandrasekhar <clingutla@codeaurora.org>

On 3/11/2021 5:35 PM, Valentin Schneider wrote:
> During load-balance, groups classified as group_misfit_task are filtered
> out if they do not pass
>
>    group_smaller_max_cpu_capacity(<candidate group>, <local group>);
>
> which itself employs fits_capacity() to compare the sgc->max_capacity of
> both groups.
>
> Due to the underlying margin, fits_capacity(X, 1024) will return false for
> any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
> {261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
> CPUs, misfit migration will never intentionally upmigrate it to a CPU of
> higher capacity due to the aforementioned margin.
>
> One may argue the 20% margin of fits_capacity() is excessive in the advent
> of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
> is that fits_capacity() is meant to compare a utilization value to a
> capacity value, whereas here it is being used to compare two capacity
> values. As CPU capacity and task utilization have different dynamics, a
> sensible approach here would be to add a new helper dedicated to comparing
> CPU capacities.
>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>   kernel/sched/fair.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index db892f6e222f..ddb2ab3edf6d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>    */
>   #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
>   
> +/*
> + * The margin used when comparing CPU capacities.
> + * is 'cap1' noticeably greater than 'cap2'
> + *
> + * (default: ~5%)
> + */
> +#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
>   #endif
>   
>   #ifdef CONFIG_CFS_BANDWIDTH
