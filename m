Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884C397DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFBBNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:13:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6124 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:13:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvrX10qKkzYpxS;
        Wed,  2 Jun 2021 09:09:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:11:49 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 09:11:48 +0800
Subject: Re: [PATCH 1/1] tpm_tis: Use DEFINE_RES_MEM() to simplify code
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210601064507.9989-1-thunder.leizhen@huawei.com>
 <20210601175728.gyi3yepdtvu4hald@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <277d929b-0602-ffbb-5866-64731a19ff14@huawei.com>
Date:   Wed, 2 Jun 2021 09:11:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210601175728.gyi3yepdtvu4hald@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/2 1:57, Jarkko Sakkinen wrote:
> On Tue, Jun 01, 2021 at 02:45:07PM +0800, Zhen Lei wrote:
>> No functional change.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> No change, no need to apply?

But it can make the code look simpler, easier to read and maintain(The start
address does not need to appear twice). I think that's why these DEFINE_RES_*
macros are defined.

By the way, would it be better to change the letters in 0xFED40000 to lowercase?

> 
> /Jarkko
> 
>> ---
>>  drivers/char/tpm/tpm_tis.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
>> index 4ed6e660273a414..d3f2e5364c275f4 100644
>> --- a/drivers/char/tpm/tpm_tis.c
>> +++ b/drivers/char/tpm/tpm_tis.c
>> @@ -363,11 +363,7 @@ static int tpm_tis_force_device(void)
>>  {
>>  	struct platform_device *pdev;
>>  	static const struct resource x86_resources[] = {
>> -		{
>> -			.start = 0xFED40000,
>> -			.end = 0xFED40000 + TIS_MEM_LEN - 1,
>> -			.flags = IORESOURCE_MEM,
>> -		},
>> +		DEFINE_RES_MEM(0xFED40000, TIS_MEM_LEN)
>>  	};
>>  
>>  	if (!force)
>> -- 
>> 2.26.0.106.g9fadedd
>>
>>
>>
> 
> .
> 

