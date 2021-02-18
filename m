Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1DE31E42C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBRCDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:03:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12615 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBRCDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:03:09 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dgybr5V08z168fr;
        Thu, 18 Feb 2021 10:00:56 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 10:01:58 +0800
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/sec - fixes shash test error
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1612692280-11386-1-git-send-email-liulongfang@huawei.com>
 <1612692280-11386-4-git-send-email-liulongfang@huawei.com>
 <20210210064328.GA15849@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <0afaed85-eeb0-236c-817f-a0f9cf02c65a@huawei.com>
Date:   Thu, 18 Feb 2021 10:01:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210210064328.GA15849@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/10 14:43, Herbert Xu Wrote:
> On Sun, Feb 07, 2021 at 06:04:40PM +0800, Longfang Liu wrote:
>> If the header file "crypto/internal/hash.h" not
>> added, the allocation of crypto_tfm will fail when
>> the shash algorithm calculates the hash
>> through the software.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
>> index d2c4a2c..988faf7 100644
>> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
>> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
>> @@ -7,6 +7,7 @@
>>  #include <crypto/des.h>
>>  #include <crypto/hash.h>
>>  #include <crypto/internal/aead.h>
>> +#include <crypto/internal/hash.h>
> 
> Please explain what exactly in this file needs this header file.
> 
> As it stands you could just be hiding real bugs.
> 
> Thanks,
> 
The crypto_alloc_shash() interface in the header file
will be used in the function sec_aead_ctx_init(),
If this header file is not added, calling the interface
crypto_alloc_shash() during the initialization of the
aead algorithm will return an error.
Thanks,
