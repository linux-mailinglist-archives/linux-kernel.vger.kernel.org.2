Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5F3CB089
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGPBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:45:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6939 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGPBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:45:16 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQv5x1kZ0z7v3J;
        Fri, 16 Jul 2021 09:38:45 +0800 (CST)
Received: from [10.174.178.125] (10.174.178.125) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:42:19 +0800
Subject: Re: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <David.Woodhouse@intel.com>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linfeilong@huawei.com>
References: <20210708131359.21591-1-linmiaohe@huawei.com>
 <20210716010224.44582046@xps13>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <95e3d455-ccb1-0e22-ee83-78dc6ad8aab1@huawei.com>
Date:   Fri, 16 Jul 2021 09:42:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210716010224.44582046@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/16 7:02, Miquel Raynal wrote:
> Hi Miaohe,
> 
> Miaohe Lin <linmiaohe@huawei.com> wrote on Thu, 8 Jul 2021 21:13:59
> +0800:
> 
>> From: Feilong Lin <linfeilong@huawei.com>
>>
>> The size in struct mtd_info_user is 32-bit, which will cause errors
>> when obtaining the size of large-capacity MTD devices, such as TLC
>> NAND FLASH-2048Gb.
> 
> Besides the fact that such devices are far from being supported by the
> Linux kernel, this change would basically break userspace, it cannot
> enter as-is...
> 

I see. Many thanks for your reply! We're working with these large-capacity
MTD devices now, any suggestion to work around this?

Thanks again!

>> Fixes: 69423d99fc18 ("[MTD] update internal API to support 64-bit device size")
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> ---
>>  include/uapi/mtd/mtd-abi.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
>> index b869990c2db2..efe0b53b10c1 100644
>> --- a/include/uapi/mtd/mtd-abi.h
>> +++ b/include/uapi/mtd/mtd-abi.h
>> @@ -128,7 +128,7 @@ struct mtd_write_req {
>>  struct mtd_info_user {
>>  	__u8 type;
>>  	__u32 flags;
>> -	__u32 size;	/* Total size of the MTD */
>> +	__u64 size;	/* Total size of the MTD */
>>  	__u32 erasesize;
>>  	__u32 writesize;
>>  	__u32 oobsize;	/* Amount of OOB data per block (e.g. 16) */
> 
> Thanks,
> Miquèl
> .
> 

