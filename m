Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9231F397
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 02:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSB0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 20:26:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSB0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 20:26:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DhYk80WCdzMbXD;
        Fri, 19 Feb 2021 09:23:28 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 19 Feb 2021
 09:25:13 +0800
Subject: Re: [PATCH v8 7/9] crypto: hisilicon/hpre - add 'ECDH' algorithm
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <tudor.ambarus@microchip.com>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
References: <1612777137-51067-1-git-send-email-yumeng18@huawei.com>
 <1612777137-51067-8-git-send-email-yumeng18@huawei.com>
 <20210210045756.GB7510@gondor.apana.org.au>
 <a92a1b89-75f2-e275-9a84-004072aadf66@huawei.com>
 <20210218200121.GA932@gondor.apana.org.au>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <5e1264cf-30ae-cbbd-21bc-90b09b8aa8f2@huawei.com>
Date:   Fri, 19 Feb 2021 09:25:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210218200121.GA932@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2021/2/19 4:01, Herbert Xu д��:
> On Thu, Feb 18, 2021 at 10:24:40AM +0800, yumeng wrote:
>>
>> Ecdh-nist-p384 is supported by HPRE now, currently there is no patch of
>> the generic ecdh-nist-p384.
> 
> In that case please leave it out until there is:
> 
> 1) An in-kernel user of p384.
> 2) There is a generic implementation.
> 
> Thanks,
> 

  OK, I will, thanks.

And p224 and p521 are the same as p384 (has no user and no
generic implementation), so they should be supported by HPRE later,
is it?

thanks.
