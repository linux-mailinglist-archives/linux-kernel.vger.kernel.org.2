Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806483EE495
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhHQCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:46:32 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14216 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhHQCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:46:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gpb4G0HlRz1CXd5;
        Tue, 17 Aug 2021 10:45:34 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 10:45:56 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 17 Aug 2021 10:45:55 +0800
Subject: Re: [PATCH v2] mtd: mtdconcat: Check existence of _read|_write from
 subdev'master device before assigning
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <bbrezillon@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <sfr@canb.auug.org.au>
References: <20210817024552.1691649-1-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <8b315831-84c5-38f3-d3b7-bb53f52c28b8@huawei.com>
Date:   Tue, 17 Aug 2021 10:45:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210817024552.1691649-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/8/17 10:45, Zhihao Cheng Ð´µÀ:
Hi Miquel,
I found a better way to fix the "WARNING" on _read|_read_oob checking. 
Since sub-mtd device has been registered successfully, we can check 
against the existence of _read|_read_oob callbacks by subdev's master 
device.
BTW, fix missing space between the SHA1 and the subject suggested by 
Stephen.
> Since 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() as wrappers
> around mtd_{read,write}_oob()") don't allow _write|_read and
> _write_oob|_read_oob existing at the same time. We should check the
> existence of callbacks "_read and _write" from subdev's master device
> (We can trust master device since it has been registered) before
> assigning, otherwise following warning occurs while making
> concatenated device:
>
>    WARNING: CPU: 2 PID: 6728 at drivers/mtd/mtdcore.c:595
>    add_mtd_device+0x7f/0x7b0
>
> Fixes: 2431c4f5b46c3 ("mtd: Implement mtd_{read,write}() around ...")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   drivers/mtd/mtdconcat.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index af51eee6b5e8..f685a581df48 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -694,6 +694,10 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>   		concat->mtd._block_markbad = concat_block_markbad;
>   	if (subdev_master->_panic_write)
>   		concat->mtd._panic_write = concat_panic_write;
> +	if (subdev_master->_read)
> +		concat->mtd._read = concat_read;
> +	if (subdev_master->_write)
> +		concat->mtd._write = concat_write;
>   
>   	concat->mtd.ecc_stats.badblocks = subdev[0]->ecc_stats.badblocks;
>   
> @@ -755,8 +759,6 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
>   	concat->mtd.name = name;
>   
>   	concat->mtd._erase = concat_erase;
> -	concat->mtd._read = concat_read;
> -	concat->mtd._write = concat_write;
>   	concat->mtd._sync = concat_sync;
>   	concat->mtd._lock = concat_lock;
>   	concat->mtd._unlock = concat_unlock;


