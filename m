Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E73AC57D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhFRH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:59:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7367 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFRH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:59:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5rkx4Dy6z6xxj;
        Fri, 18 Jun 2021 15:53:13 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:57:14 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:57:13 +0800
Subject: Re: [PATCH -next] crypto: sl3516 - Fix build warning without
 CONFIG_PM
To:     LABBE Corentin <clabbe@baylibre.com>
CC:     <ulli.kroll@googlemail.com>, <linus.walleij@linaro.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210617035129.4948-1-yuehaibing@huawei.com>
 <YMtHcruTqo3WE+g6@Red>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <00d33044-8101-bc41-ac02-90517c13f19a@huawei.com>
Date:   Fri, 18 Jun 2021 15:57:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YMtHcruTqo3WE+g6@Red>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/17 21:00, LABBE Corentin wrote:
> Le Thu, Jun 17, 2021 at 11:51:29AM +0800, YueHaibing a écrit :
>> drivers/crypto/gemini/sl3516-ce-core.c:345:12:
>>  warning: ‘sl3516_ce_pm_resume’ defined but not used [-Wunused-function]
>>  static int sl3516_ce_pm_resume(struct device *dev)
>>             ^~~~~~~~~~~~~~~~~~~
>>
>> Use #ifdef macro to guard this.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/crypto/gemini/sl3516-ce-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> Hello
> 
> Thanks for the report, but I am sorry and need to NAK this patch.
> 
> The driver needs PM, without it, clock and resets are never set.
> The correct fix is to add "depends on PM".

Ok, v2 on the way, thanks.

> 
> Regards
> .
> 
