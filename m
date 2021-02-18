Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF731E446
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBRCQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:16:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12180 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhBRCQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:16:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DgytL0V8LzlLgj;
        Thu, 18 Feb 2021 10:13:30 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 10:15:14 +0800
Subject: Re: [PATCH v8 3/9] crypto: atmel-ecc - move curve_id of ECDH from the
 key to algorithm name
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <tudor.ambarus@microchip.com>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
References: <1612777137-51067-1-git-send-email-yumeng18@huawei.com>
 <1612777137-51067-4-git-send-email-yumeng18@huawei.com>
 <20210210045630.GA7510@gondor.apana.org.au>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <656bfe6b-7e38-bc9e-ffc6-24aae83e0a56@huawei.com>
Date:   Thu, 18 Feb 2021 10:14:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210210045630.GA7510@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2021/2/10 12:56, Herbert Xu д��:
> On Mon, Feb 08, 2021 at 05:38:51PM +0800, Meng Yu wrote:
>> As curve id of ECDH will be moved from its key into algorithm name,
>> we cannot use 'curve_id' in 'struct ecdh', so we should modify ECDH
>> driver in atmel, and make ECDH algorithm name be the same as crypto
>> (like 'ecdh-nist-pxxx');
>>
>> Signed-off-by: Meng Yu <yumeng18@huawei.com>
>> Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
>> ---
>>   drivers/crypto/atmel-ecc.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Patches 3-5 need to be squashed into one in order to avoid future
> bisection failures.
> 
> The alternative is to let the new/old names coexist but it's probably
> not worth it for this case as the number of drivers impacted is small.
> 
> Thanks,
> 

OK, thanks.
