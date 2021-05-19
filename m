Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11891388A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbhESJCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:02:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4678 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhESJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:02:13 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlRbf2SZlz1BP81;
        Wed, 19 May 2021 16:58:06 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:00:52 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:00:51 +0800
Subject: Re: [PATCH -next] irqchip/mbigen: fix compile warning when
 CONFIG_ACPI is disabled
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
References: <20210519050455.1693953-1-yangyingliang@huawei.com>
 <c9e2dee2a7bb11d3327bbe55f4f7cf05@kernel.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <6e4ff8c0-a297-e341-f430-9016920b3f48@huawei.com>
Date:   Wed, 19 May 2021 17:00:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c9e2dee2a7bb11d3327bbe55f4f7cf05@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/19 15:49, Marc Zyngier wrote:
> On 2021-05-19 06:04, Yang Yingliang wrote:
>> Fix the following compile warning:
>>
>>   drivers/irqchip/irq-mbigen.c:372:36: warning: ‘mbigen_acpi_match’
>> defined but not used [-Wunused-const-variable=]
>>    static const struct acpi_device_id mbigen_acpi_match[] = {
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  drivers/irqchip/irq-mbigen.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index 2cb45c6b8501..f565317a3da3 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -273,6 +273,12 @@ static int mbigen_of_create_domain(struct
>> platform_device *pdev,
>>  }
>>
>>  #ifdef CONFIG_ACPI
>> +static const struct acpi_device_id mbigen_acpi_match[] = {
>> +    { "HISI0152", 0 },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
>> +
>>  static int mbigen_acpi_create_domain(struct platform_device *pdev,
>>                       struct mbigen_device *mgn_chip)
>>  {
>> @@ -369,12 +375,6 @@ static const struct of_device_id 
>> mbigen_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, mbigen_of_match);
>>
>> -static const struct acpi_device_id mbigen_acpi_match[] = {
>> -    { "HISI0152", 0 },
>> -    {}
>> -};
>> -MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
>> -
>>  static struct platform_driver mbigen_platform_driver = {
>>      .driver = {
>>          .name        = "Hisilicon MBIGEN-V2",
>
> Is it actually a thing to have mbigen without ACPI? As far as I can
> tell, all the mbigen-equipped machines in existence use ACPI.

We also use mbigen on embedded board that uses device tree,
and mbigen driver already support device tree mode.

Thanks,

Yang

>
> Thanks,
>
>         M.
