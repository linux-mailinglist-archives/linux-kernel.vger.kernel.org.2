Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A147331028E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBECHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:07:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12077 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhBECHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:07:03 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWzJ75k26zMTmC;
        Fri,  5 Feb 2021 10:04:39 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 10:06:17 +0800
Subject: Re: [PATCH v2 0/6] crypto: hisilicon - enable new algorithms of SEC
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
 <20210102210044.GA1514@gondor.apana.org.au>
 <5432190d-0467-1a99-3629-bf8b618b35ef@huawei.com>
 <20210104113347.GA20681@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <e9a38ae0-383c-59f8-345a-f906fb0b0598@huawei.com>
Date:   Fri, 5 Feb 2021 10:05:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210104113347.GA20681@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/4 19:33, Herbert Xu Wrote:
> On Mon, Jan 04, 2021 at 04:15:13PM +0800, liulongfang wrote:
>>
>> Currently, we have not conducted Fuzz testing.
>> For SEC driver, we only adds support for these new algorithms
>> with existing interfaces of Crypto. So, do we need to do Fuzz testing on the existing interfaces?
> 
> Please test with SCRYPTO_MANAGER_EXTRA_TEST.
> 
> Thanks,
> 
After testing with SCRYPTO_MANAGER_EXTRA_TEST, Specifications that our hardware does not support
will cause the test to fail. Before using this patchset,
we need to add software support to solve these problems.
The current patch set needs to be aborted.
Thanks.
