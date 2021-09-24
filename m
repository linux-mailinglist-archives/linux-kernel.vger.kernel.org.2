Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8B4175FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbhIXNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:37:18 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33364 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346319AbhIXNhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:37:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UpRWw2x_1632490534;
Received: from 30.15.218.30(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UpRWw2x_1632490534)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Sep 2021 21:35:35 +0800
Subject: Re: [PATCH] firmware: arm_sdei: pass sdei_api_event_register right
 parameters
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210910040117.98736-1-zhangliguang@linux.alibaba.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <f0dac2f4-60f5-b200-47f1-0b845cfa02a6@linux.alibaba.com>
Date:   Fri, 24 Sep 2021 21:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910040117.98736-1-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Gentle ping! Any comments on this patch?


ÔÚ 2021/9/10 12:01, Liguang Zhang Ð´µÀ:
> Function _local_event_enable is used for private sdei event
> registeration called by sdei_event_register. We should pass
> sdei_api_event_register right flag and mpidr parameters, otherwise atf
> may trigger assert errors.
>
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>   drivers/firmware/arm_sdei.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a7e762c352f9..0736752dadde 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -558,14 +558,16 @@ static int sdei_api_event_register(u32 event_num, unsigned long entry_point,
>   static void _local_event_register(void *data)
>   {
>   	int err;
> +	u64 mpidr;
>   	struct sdei_registered_event *reg;
>   	struct sdei_crosscall_args *arg = data;
>   
>   	WARN_ON(preemptible());
>   
> +	mpidr = read_cpuid_mpidr();
>   	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
>   	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
> -				      reg, 0, 0);
> +				      reg, SDEI_EVENT_REGISTER_RM_PE, mpidr);
>   
>   	sdei_cross_call_return(arg, err);
>   }
