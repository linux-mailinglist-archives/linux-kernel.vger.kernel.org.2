Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5D45C6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbhKXOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:12:38 -0500
Received: from cpanel.siel.si ([46.19.9.99]:60648 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349986AbhKXOIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2c75zZfAqhpoL4zO4NRoQ9BKCaoadrkZMtbowndMmoA=; b=BAs5F9IetnEIxDKCuobwrBSEOb
        ucibUgBbBmzzvrOM0j9x6i0aEjd97Hei2/8o4KX9SYLicPMXnxTH27ollOnDLDN/gaA0jgE39Ilzf
        G5nM8B3ESLw0sV9Pre7wInOM5+rui6PJNeKGrAwkphoFoCcJSrapQiOGp1yQgmmabobpNgevqto+z
        /MNQIZqMFWRRxsWj7vfQMpSzuj9Bxg63JxGC1xWuhkvql8bV98uNgQk6Ow3hRrrJe0gXT01JEojf4
        gJg95bMMtgrnzxCVpEqmenn0NeGMBcB5iybFQuPbmG0pl20MwxZAfY5IqLEdfM3+i9LEtxhI9jf52
        uRDseMYw==;
Received: from [89.212.21.243] (port=46752 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mpstA-0076nA-9V; Wed, 24 Nov 2021 15:04:44 +0100
Subject: Re: [PATCH 2/2] mfd: da9063: Make vbcore registers volatile
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.riedmueller@phytec.de" <s.riedmueller@phytec.de>
References: <20211124070001.2516750-1-andrej.picej@norik.com>
 <20211124070001.2516750-2-andrej.picej@norik.com>
 <DB9PR10MB4652A195CDB7E237A0D87F6180619@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <358de8cf-ec40-3552-da0d-98b065120649@norik.com>
Date:   Wed, 24 Nov 2021 15:04:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB4652A195CDB7E237A0D87F6180619@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 24. 11. 21 10:34, Adam Thomson wrote:
> On 24 November 2021 07:00, Andrej Picej wrote:
> 
>> From: Stefan Riedmueller <s.riedmueller@phytec.de>
>>
>> The VBCORE1_A and VBCORE2_A registers are used to set the desired output
>> voltage of the BCORE 1 and 2 buck regulators. These values can be critical
>> if used as input for core voltages. Thus make them volatile so they do not
>> get cached.
> 
> I don't understand the need for this change. What is this fixing? As I
> understand it the registers in question aren't volatile so should persist.

So basically this two patches were needed because we needed to enable 
internal LDOs bypass mode on the imx6 and in the process this PMICs regs 
needed to be somehow adjusted, which only worked if this regs were 
marked as volatile. Long story short, this method was only introduced in 
Phytec's version so upstreaming really doesn't make much sense.

I apologize for any inconvenience, but this two patches somehow slipped 
through the process and landed on the "send-to-upstream" list. I also 
talked with @Stefan Rieadmueller and he agreed that this two patches can 
be dropped.

Thanks for your time.

> 
>> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>   drivers/mfd/da9063-i2c.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
>> index 343ed6e96d87..8a3629c30382 100644
>> --- a/drivers/mfd/da9063-i2c.c
>> +++ b/drivers/mfd/da9063-i2c.c
>> @@ -161,6 +161,7 @@ static const struct regmap_range
>> da9063_ad_volatile_ranges[] = {
>>   	regmap_reg_range(DA9063_REG_ADC_RES_L,
>> DA9063_AD_REG_SECOND_D),
>>   	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
>>   	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
>> +	regmap_reg_range(DA9063_REG_VBCORE2_A,
>> DA9063_REG_VBCORE2_A),
>>   	regmap_reg_range(DA9063_AD_REG_MON_REG_5,
>> DA9063_AD_REG_MON_REG_6),
>>   };
>>
>> @@ -206,6 +207,7 @@ static const struct regmap_range
>> da9063_bb_da_volatile_ranges[] = {
>>   	regmap_reg_range(DA9063_REG_ADC_RES_L,
>> DA9063_BB_REG_SECOND_D),
>>   	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
>>   	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
>> +	regmap_reg_range(DA9063_REG_VBCORE2_A,
>> DA9063_REG_VBCORE2_A),
>>   	regmap_reg_range(DA9063_BB_REG_MON_REG_5,
>> DA9063_BB_REG_MON_REG_6),
>>   };
>>
>> --
>> 2.25.1
> 
