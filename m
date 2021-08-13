Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504623EB1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhHMHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:38:50 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43306 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239505AbhHMHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:38:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UirXt4z_1628840298;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UirXt4z_1628840298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 15:38:19 +0800
Subject: Re: [PATCH 1/3] crypto: tcrypt - Fix the wrong position of return
 value test statement
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210812131748.81620-1-tianjia.zhang@linux.alibaba.com>
 <20210812131748.81620-2-tianjia.zhang@linux.alibaba.com>
 <20210812135943.mnuce4252wp4xi52@altlinux.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <30de4d0a-42ee-3115-981e-bedc701bceb8@linux.alibaba.com>
Date:   Fri, 13 Aug 2021 15:38:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812135943.mnuce4252wp4xi52@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

On 8/12/21 9:59 PM, Vitaly Chikunov wrote:
> Tianjia,
> 
> On Thu, Aug 12, 2021 at 09:17:46PM +0800, Tianjia Zhang wrote:
>> The position of the return value test statement of crypto_aead_setkey()
>> is wrong, adjust to make it work properly.
> 
> This commit message does not explain anything. It's nearly equivalent to
> "fix".
> 

will update in next version.

>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/tcrypt.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
>> index d73a42fdaa9b..73c97e085baf 100644
>> --- a/crypto/tcrypt.c
>> +++ b/crypto/tcrypt.c
>> @@ -612,6 +612,12 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
>>   				}
>>   			}
>>   			ret = crypto_aead_setkey(tfm, key, *keysize);
> 
> Perhaps, you would say that return value of crypto_aead_setkey was lost.
> 

Yes, good idea.

>> +			if (ret) {
>> +				pr_err("setkey() failed flags=%x\n",
>> +						crypto_aead_get_flags(tfm));
>> +				goto out;
>> +			}
>> +
>>   			ret = crypto_aead_setauthsize(tfm, authsize);
> 
> But, isn't now return value of crypto_aead_setauthsize is lost?
> 
> Thanks,
> 

Yes, it is needed.

I will move crypto_aead_setauthsize() call out of the loop, only need to 
call it once after load transform.

Best regards,
Tianjia

>>   
>>   			iv_len = crypto_aead_ivsize(tfm);
>> @@ -622,15 +628,8 @@ static void test_aead_speed(const char *algo, int enc, unsigned int secs,
>>   			printk(KERN_INFO "test %u (%d bit key, %d byte blocks): ",
>>   					i, *keysize * 8, bs);
>>   
>> -
>>   			memset(tvmem[0], 0xff, PAGE_SIZE);
>>   
>> -			if (ret) {
>> -				pr_err("setkey() failed flags=%x\n",
>> -						crypto_aead_get_flags(tfm));
>> -				goto out;
>> -			}
>> -
>>   			sg_init_aead(sg, xbuf, bs + (enc ? 0 : authsize),
>>   				     assoc, aad_size);
>>   
>> -- 
>> 2.19.1.3.ge56e4f7
