Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF03E8ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhHKHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:12:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8398 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhHKHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:12:18 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gl19n2YFFz86H8;
        Wed, 11 Aug 2021 15:07:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 15:11:53 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 15:11:52 +0800
Subject: Re: [PATCH 1/1] genirq/timings: Fix error return code in
 irq_timings_test_irqs()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508062043.2524-1-thunder.leizhen@huawei.com>
 <87a6lps9u7.ffs@tglx>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cae56d27-44ca-3f39-49ab-3f0cda472785@huawei.com>
Date:   Wed, 11 Aug 2021 15:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87a6lps9u7.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/10 21:33, Thomas Gleixner wrote:
> On Sat, May 08 2021 at 14:20, Zhen Lei wrote:
>> Fix to return a negative error code from the error handling case instead
>> of 0, as done elsewhere in this function.
> 
> Returning an error code is fine, but
> 
>>  
>>  		__irq_timings_store(irq, irqs, ti->intervals[i]);
>>  		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
>> +			ret = -EFAULT;
> 
> EFAULT is really not appropriate here. EFAULT is used for mapping
> faults. ENOSPC or EBADSLT perhaps?

EBADSLT will be better, the cyclic buffer can not be "no space".

> 
>>  			pr_err("Failed to store in the circular buffer\n");
>>  			goto out;
>>  		}
>>  	}
>>  
>>  	if (irqs->count != ti->count) {
>> +		ret = -EFAULT;
> 
> ERANGE?

Looks better than EFAULT.

Thank you for your suggestion, I will send v2.

> 
> Thanks,
> 
>         tglx
> .
> 
