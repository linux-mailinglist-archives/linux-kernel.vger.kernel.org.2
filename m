Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13B3E32D7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhHGC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:59:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16057 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhHGC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:59:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GhRms4kq1zZyLV;
        Sat,  7 Aug 2021 10:55:57 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 7 Aug 2021 10:59:33 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 10:59:32 +0800
Subject: Re: [PATCH 2/2] mtd: mtdconcat: Remove concat_{read|write}_oob
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
 <20210731023243.3977104-3-chengzhihao1@huawei.com>
 <20210806212655.16e4d03d@xps13>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <83cb21c4-0140-40d5-e0f8-7f2a7e781a5f@huawei.com>
Date:   Sat, 7 Aug 2021 10:59:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210806212655.16e4d03d@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/8/7 3:26, Miquel Raynal 写道:
Hi Miquel,
>>   static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
>>   {
>>   	struct mtd_concat *concat = CONCAT(mtd);
>> @@ -684,10 +580,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>>   	subdev_master = mtd_get_master(subdev[0]);
>>   	if (subdev_master->_writev)
>>   		concat->mtd._writev = concat_writev;
>> -	if (subdev_master->_read_oob)
>> -		concat->mtd._read_oob = concat_read_oob;
>> -	if (subdev_master->_write_oob)
>> -		concat->mtd._write_oob = concat_write_oob;
> Actually I am not sure _read|write_oob() is the right callback to
> remove.
>
> Richard, what is your input on this? Shall we remove _read|write()
> instead? I don't remember the exact rationale behind these two helpers.

Oh, I guess I made a mistake. It looks like that reserving _{read|write}_oob is a better method in my limited knowledge to nand driver. For example, nand_do_read_oob() behaves different from nand_do_read_ops(), and calling which function is decided by mtd_oob_ops.databuf.
Callback _read_oobs() can support both functions, but callback _read() don't support nand_do_read_oob(). So mtd_read_oobs() covers mtd_read()?
Is my understand right?

