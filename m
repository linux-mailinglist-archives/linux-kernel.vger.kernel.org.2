Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5629437F33B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhEMGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:52:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2470 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:52:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fgj1153LnzBtwk;
        Thu, 13 May 2021 14:48:37 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 14:51:16 +0800
Subject: Re: [RFC PATCH] timer: Fix bucket_expiry calculation
To:     Thomas Gleixner <tglx@linutronix.de>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1620821729-40694-1-git-send-email-wangxiongfeng2@huawei.com>
 <87y2ckdnea.ffs@nanos.tec.linutronix.de>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <60582932-1332-ed33-d7e0-3eae78793449@huawei.com>
Date:   Thu, 13 May 2021 14:51:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87y2ckdnea.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2021/5/12 22:42, Thomas Gleixner wrote:
> Xiongfeng,
> 
> On Wed, May 12 2021 at 20:15, Xiongfeng Wang wrote:
>> When I use schedule_timeout(5) to put a process into sleep on my machine
>> with HZ = 100. It always sleep about 60ms. I enable the timer trace and
>> find out, when the timer_list expires, 'now' is always equal to
>> 'expires + 1'. I print 'base->next_expiry' in '__run_timers' and find out
>> 'next_expiry' is always equal to 'expires + 1';
>>
>> It is because we use the following equation to calculate bucket_expiry.
>>
>>   bucket_expiry = ((expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl)) << LVL_SHIFT(lvl)
>>
>> 'bucket_expiry' is equal to 'expires + 1' when lvl = 0. So modify the
>> equation as follows to fix the issue.
>>
>>   bucket_expiry = ((expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl)) << LVL_SHIFT(lvl)
> 
> That's wrong because you move the expiry of each timer one jiffie ahead,
> which violates the guarantee that a timer sleeps at least for one jiffie
> for real and not measured in jiffies.
> 
>   jiffies = 0
>   schedule_timeout(1)
> 
>    local_irq_disable()
> 			  -> timer interrupt is raised in HW
>    timer->expires = jiffies + 1 <- 1
>    add_timer(timer)
>    local_irq_enable()
>    timer interrupt
>       jiffies++;
>       softirq()
> 	  expire(timer); -> timer is expired immediately       
> 
> So the off by one has a reason and is required to prevent too short
> timeouts. There is nothing you can do about that because that's a
> property of low granularity tick based timer wheels.
> 
> That's even documented in the comment above the code you modified:
> 
> 	/*
> 	 * The timer wheel has to guarantee that a timer does not fire
> 	 * early. Early expiry can happen due to:
> 	 * - Timer is armed at the edge of a tick
> 	 * - Truncation of the expiry time in the outer wheel levels
> 	 *
> 	 * Round up with level granularity to prevent this.
> 	 */

Thanks for your explanation. I got it !

Thanks,
Xiongfeng

> 
> Thanks,
> 
> 	  tglx
> .
> 
