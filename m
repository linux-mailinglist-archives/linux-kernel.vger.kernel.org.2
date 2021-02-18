Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17331E454
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBRCZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:25:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12616 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBRCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:25:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dgz5h1BfDz168Qp;
        Thu, 18 Feb 2021 10:23:20 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 10:24:39 +0800
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
From:   yumeng <yumeng18@huawei.com>
Message-ID: <a92a1b89-75f2-e275-9a84-004072aadf66@huawei.com>
Date:   Thu, 18 Feb 2021 10:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210210045756.GB7510@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2021/2/10 12:57, Herbert Xu д��:
> On Mon, Feb 08, 2021 at 05:38:55PM +0800, Meng Yu wrote:
>> 1. Enable 'ECDH' algorithm in Kunpeng 930;
>> 2. HPRE ECDH Support: ecdh-nist-p192, ecdh-nist-p224,
>>     ecdh-nist-p256, ecdh-nist-p384, ecdh-nist-p521.
> 
> Where is the patch that adds the generic ecdh-nist-p384?
> 
> Thanks,
> 

Ecdh-nist-p384 is supported by HPRE now, currently there is no patch of
the generic ecdh-nist-p384.
