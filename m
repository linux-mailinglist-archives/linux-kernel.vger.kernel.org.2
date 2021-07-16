Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F323CB54A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhGPJfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:35:25 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46327 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhGPJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:35:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0UfxpEdN_1626427941;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UfxpEdN_1626427941)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 17:32:22 +0800
Subject: Re: [PATCH v2 2/4] crypto: arm64/sm4-ce - Make dependent on sm4
 library instead of sm4-generic
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210624080857.126660-1-tianjia.zhang@linux.alibaba.com>
 <20210624080857.126660-3-tianjia.zhang@linux.alibaba.com>
 <20210716074825.GA13279@gondor.apana.org.au>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <5397e44f-9a05-80ff-9a2f-08a95ebfef4d@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 17:32:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716074825.GA13279@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 7/16/21 3:48 PM, Herbert Xu wrote:
> On Thu, Jun 24, 2021 at 04:08:55PM +0800, Tianjia Zhang wrote:
>>
>> +int sm4_ce_setkey(struct crypto_tfm *tfm, const u8 *in_key,
>> +		       unsigned int key_len)
>> +{
>> +	struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
>> +
>> +	return sm4_expandkey(ctx, in_key, key_len);
>> +}
> 
> This triggers a new warning.  Please fix and resubmit.
> 
> Thanks,
> 

Thanks for your comment, I will fix and resubmit in next version patch.

Cheers,
Tianjia
