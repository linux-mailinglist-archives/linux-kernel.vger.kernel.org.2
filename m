Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD93E32AC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 04:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhHGCQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 22:16:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16056 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhHGCQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:16:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GhQpM61nXzZyJr;
        Sat,  7 Aug 2021 10:12:11 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 7 Aug 2021 10:15:47 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 7 Aug 2021 10:15:46 +0800
Subject: Re: [PATCH 1/2] mtd: mtdconcat: Judge callback function existence
 getting from master for each partition
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210731023243.3977104-1-chengzhihao1@huawei.com>
 <20210731023243.3977104-2-chengzhihao1@huawei.com>
 <20210806212857.240e0c1f@xps13>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <27c67e42-f275-fc50-64e5-d80233130f7e@huawei.com>
Date:   Sat, 7 Aug 2021 10:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210806212857.240e0c1f@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/8/7 3:28, Miquel Raynal 写道:
Hi Miquel,
> Hi Zhihao,
>
> Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sat, 31 Jul 2021
> 10:32:42 +0800:
> @@ -721,14 +724,15 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>   				    subdev[i]->flags & MTD_WRITEABLE;
>   		}
>   
> +		subdev_master = mtd_get_master(subdev[i]);
>   		concat->mtd.size += subdev[i]->size;
>   		concat->mtd.ecc_stats.badblocks +=
>   			subdev[i]->ecc_stats.badblocks;
>   		if (concat->mtd.writesize   !=  subdev[i]->writesize ||
>   		    concat->mtd.subpage_sft != subdev[i]->subpage_sft ||
>   		    concat->mtd.oobsize    !=  subdev[i]->oobsize ||
> -		    !concat->mtd._read_oob  != !subdev[i]->_read_oob ||
> -		    !concat->mtd._write_oob != !subdev[i]->_write_oob) {
> +		    !concat->mtd._read_oob  != !subdev_master->_read_oob ||
> +		    !concat->mtd._write_oob != !subdev_master->_write_oob) {
> Do you really need this change?

I think both "!concat->mtd._read_oob != !subdev[i]->_read_oob" and 
"!concat->mtd._write_oob != !subdev[i]->_write_oob" need to be modified 
otherwise concatenating goes failure.

I thought there exists two problems:

   1. Wrong callback fetching in mtd partition device

   2. Warning for existence of _read and _read_oob at the same time

so I solved them in two steps to make history commit logs a bit clear.

Though these two patches can be combined to one.

