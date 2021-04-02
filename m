Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72D935299F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhDBKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:16:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15905 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:16:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FBbX04h4nzkhSZ;
        Fri,  2 Apr 2021 18:14:56 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 18:16:29 +0800
Subject: Re: [PATCH] crypto: hisilicon/hpre - rsa key should not be empty
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <shenyang39@huawei.com>
References: <1616739212-7751-1-git-send-email-yumeng18@huawei.com>
 <20210402071225.GA10423@gondor.apana.org.au>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <7384e015-5514-d6b2-4215-beb1f4701adb@huawei.com>
Date:   Fri, 2 Apr 2021 18:16:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210402071225.GA10423@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2021/4/2 15:12, Herbert Xu д��:
> On Fri, Mar 26, 2021 at 02:13:32PM +0800, Meng Yu wrote:
>> We should ensure key is not empty before we set key.
>>
>> Signed-off-by: Meng Yu <yumeng18@huawei.com>
>> ---
>>   drivers/crypto/hisilicon/hpre/hpre_crypto.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
>> index 53068d2..7cf7d80 100644
>> --- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
>> +++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
>> @@ -1093,6 +1093,9 @@ static int hpre_rsa_setpubkey(struct crypto_akcipher *tfm, const void *key,
>>   	struct hpre_ctx *ctx = akcipher_tfm_ctx(tfm);
>>   	int ret;
>>   
>> +	if (!key || !keylen)
>> +		return -EINVAL;
>> +
>>   	ret = crypto_akcipher_set_pub_key(ctx->rsa.soft_tfm, key, keylen);
> 
> Does this fix a real bug? Wouldn't the soft fallback setkey catch
> this anyhow?
> 

I think it is not a real bug, and soft fallback setkey can always catch 
the error.
But our original intention was to make it don't go to 'xxx_set_pub_key'
when the key is null, and it can return an error earlier.
But maybe it is not good.

