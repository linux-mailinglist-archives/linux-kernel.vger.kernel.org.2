Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3C3549F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhDFBM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:12:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14693 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhDFBM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:12:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDqFR0jbNznXlK;
        Tue,  6 Apr 2021 09:10:03 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 09:12:40 +0800
Subject: Re: [PATCH] ecc: delete a useless function declaration
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
References: <1617357357-11828-1-git-send-email-yumeng18@huawei.com>
 <3fbc88c4-50ae-3ffb-14e5-0cd39d492251@csgroup.eu>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <0e272e6e-6cb0-2c03-86c3-08d54690c97e@huawei.com>
Date:   Tue, 6 Apr 2021 09:12:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3fbc88c4-50ae-3ffb-14e5-0cd39d492251@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/4/2 18:34, Christophe Leroy 写道:
> 
> 
> Le 02/04/2021 à 11:55, Meng Yu a écrit :
>> This function declaration has been added in 'ecc_curve.h',
>> delete it in 'crypto/ecc.h'.
>>
>> Fixes: 14bb76768275(crypto: ecc - expose ecc curves)
> 
> Fixes tag is wrong I think, should be 4e6602916bc6
> 

Yes, you are right, thank you.

>> Signed-off-by: Meng Yu <yumeng18@huawei.com>
>> ---
>>   crypto/ecc.h | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/crypto/ecc.h b/crypto/ecc.h
>> index 46aa9bc..a006132 100644
>> --- a/crypto/ecc.h
>> +++ b/crypto/ecc.h
>> @@ -56,14 +56,6 @@ static inline void ecc_swap_digits(const u64 *in, 
>> u64 *out, unsigned int ndigits
>>   }
>>   /**
>> - * ecc_get_curve()  - Get a curve given its curve_id
>> - * @curve_id:  Id of the curve
>> - *
>> - * Returns pointer to the curve data, NULL if curve is not available
>> - */
>> -const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
>> -
>> -/**
>>    * ecc_is_key_valid() - Validate a given ECDH private key
>>    *
>>    * @curve_id:        id representing the curve to use
>>
> .
