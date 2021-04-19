Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F503640FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhDSLvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:51:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhDSLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:50:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FP4mv4Lv5zPs8N;
        Mon, 19 Apr 2021 19:47:27 +0800 (CST)
Received: from [10.67.101.248] (10.67.101.248) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 19 Apr 2021 19:50:17 +0800
Subject: Re: [PATCH] crypto: hisilicon/hpre - fix unmapping invalid dma
 address
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <1618048157-6289-1-git-send-email-tanghui20@huawei.com>
 <20210416112638.GA14703@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <df8a9c03-de99-4d2f-e577-05924002136e@huawei.com>
Date:   Mon, 19 Apr 2021 19:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210416112638.GA14703@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/16 19:26, Herbert Xu wrote:
> On Sat, Apr 10, 2021 at 05:49:17PM +0800, Hui Tang wrote:
>> Currently, an invalid dma address may be unmapped when calling
>> 'xx_data_clr_all' in error path, so check dma address of sqe in/out
>> whether it has been mapped before calling 'dma_free_coherent' or
>> 'dma_unmap_single'.
>>
>> An abnormal case is as follows:
>> hpre_curve25519_compute_value
>> 	-> hpre_curve25519_src_init
>> 	-> hpre_curve25519_hw_data_clr_all
>>
>> Fixes: a9214b0b6ed2(crypto: hisilicon - fix the check on dma address)
>> Signed-off-by: Hui Tang <tanghui20@huawei.com>
>> ---
>>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>
> This triggers new sparse warnings.

Thanks, I will fix it in 5.13 rc1.
