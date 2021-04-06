Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9A3549CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 02:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbhDFAwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 20:52:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15599 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbhDFAwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:52:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDppH5dlHz18H8f;
        Tue,  6 Apr 2021 08:49:59 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 08:52:00 +0800
Subject: Re: [PATCH] crypto: hisilicon/hpre - rsa key should not be empty
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <shenyang39@huawei.com>
References: <1616739212-7751-1-git-send-email-yumeng18@huawei.com>
 <20210402071225.GA10423@gondor.apana.org.au>
 <7384e015-5514-d6b2-4215-beb1f4701adb@huawei.com>
 <20210402102223.GA24978@gondor.apana.org.au>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <639630ef-f0c3-1ccb-983d-0cb9d2ac2952@huawei.com>
Date:   Tue, 6 Apr 2021 08:51:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210402102223.GA24978@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



�� 2021/4/2 18:22, Herbert Xu д��:
> On Fri, Apr 02, 2021 at 06:16:16PM +0800, yumeng wrote:
>>
>> I think it is not a real bug, and soft fallback setkey can always catch the
>> error.
>> But our original intention was to make it don't go to 'xxx_set_pub_key'
>> when the key is null, and it can return an error earlier.
>> But maybe it is not good.
> 
> It might make sense to check them twice if you were touching them
> directly, e.g., poking inside the key.  However, it appears that
> your driver simply palms off the key to rsa_helper.c which should
> check the key/keylen too so I think there is no need for this patch
> for now.
> 
> Thanks,
> 

OK, thank you.
