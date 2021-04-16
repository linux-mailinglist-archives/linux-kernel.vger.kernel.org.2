Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD3361763
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 04:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhDPCI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 22:08:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16467 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhDPCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 22:08:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FM01f0K4Mzrf7f;
        Fri, 16 Apr 2021 10:06:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 16 Apr 2021
 10:08:25 +0800
Subject: Re: [PATCH 1/1] char: hpet: Remove unused local variable 'm' in
 hpet_interrupt()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nils Carlson <nils.carlson@ericsson.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210415142404.3846-1-thunder.leizhen@huawei.com>
 <YHhTVXS4u5jXG5Fc@kroah.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f821054a-0bb2-2a66-4b7d-ceaf48705700@huawei.com>
Date:   Fri, 16 Apr 2021 10:08:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YHhTVXS4u5jXG5Fc@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/15 22:53, Greg Kroah-Hartman wrote:
> On Thu, Apr 15, 2021 at 10:24:04PM +0800, Zhen Lei wrote:
>> Commit 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for
>> delayed interrupt") removed the reference to local variable 'm', but
>> forgot to remove the definition and assignment of it. Due to
>> read_counter() indirectly calls "read barrier", the performance is
>> slightly degraded.
>>
>> Since the following comments give some description based on 'm', so move
>> the assignment of 'm' into it.
>>
>> Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for delayed interrupt")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/char/hpet.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
>> index ed3b7dab678dbd1..46950a0cda181a1 100644
>> --- a/drivers/char/hpet.c
>> +++ b/drivers/char/hpet.c
>> @@ -156,14 +156,16 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
>>  	 * This has the effect of treating non-periodic like periodic.
>>  	 */
>>  	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
>> -		unsigned long m, t, mc, base, k;
>> +		unsigned long t, mc, base, k;
>>  		struct hpet __iomem *hpet = devp->hd_hpet;
>>  		struct hpets *hpetp = devp->hd_hpets;
>>  
>>  		t = devp->hd_ireqfreq;
>> -		m = read_counter(&devp->hd_timer->hpet_compare);
>>  		mc = read_counter(&hpet->hpet_mc);
>> -		/* The time for the next interrupt would logically be t + m,
>> +		/*
>> +		 * m = read_counter(&devp->hd_timer->hpet_compare);
> 
> Why did you comment this out?
> 
> And are you sure that yuou are not required to actually read that
> counter, even if you do not do anything with the value?  Lots of
> hardware works in odd ways...
> 
> Have you tested and verified that this still works properly?

Sorry, I didn't actually test it. I didn't see any dependency on
this read operation for other members' reads and writes. If this
read operation is potentially required, hopefully there is an
explanatory note next to it.

> 
> thanks,
> 
> greg k-h
> 
> .
> 

