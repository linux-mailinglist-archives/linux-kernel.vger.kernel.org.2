Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BEE442EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKBNEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:04:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15343 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhKBNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:04:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hk95T6YfLz90h1;
        Tue,  2 Nov 2021 21:01:33 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 21:01:42 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 2 Nov 2021 21:01:41 +0800
Subject: Re: [PATCH -next] ubi: fix race between ctrl_cdev_ioctl and
 ubi_cdev_ioctl
To:     Baokun Li <libaokun1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <patchwork@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20211101013739.236430-1-libaokun1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <decf845d-ce14-cfb7-9500-73f271b7a38e@huawei.com>
Date:   Tue, 2 Nov 2021 21:01:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20211101013739.236430-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/11/1 9:37, Baokun Li 写道:
Hi, Baokun
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index a7e3eb9befb6..708b1b96de01 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -467,6 +467,7 @@ static int uif_init(struct ubi_device *ubi)
>   	if (err)
>   		goto out_unreg;
>   
> +	spin_lock(&ubi->volumes_lock);
>   	for (i = 0; i < ubi->vtbl_slots; i++)
>   		if (ubi->volumes[i]) {
>   			err = ubi_add_volume(ubi, ubi->volumes[i]);
> @@ -475,11 +476,13 @@ static int uif_init(struct ubi_device *ubi)
>   				goto out_volumes;
>   			}
>   		}
> +	spin_unlock(&ubi->volumes_lock);
>   
>   	return 0;
>   
>   out_volumes:
>   	kill_volumes(ubi);
> +	spin_unlock(&ubi->volumes_lock);
>   	cdev_device_del(&ubi->cdev, &ubi->dev);
>   out_unreg:
>   	unregister_chrdev_region(ubi->cdev.dev, ubi->vtbl_slots + 1);

There still exist one place that ubi_attach_mtd_dev() may race with 
ubi_remove_volume():

ubi->bgt_thread = kthread_create(ubi_thread, ubi, "%s", ubi->bgt_name)

     goto out_debugfs;

...

out_debugfs:

     ubi_debugfs_exit_dev(ubi);

out_uif:

    uif_close(ubi);      // Another process does ioctl to remove volume, 
which may cause volume double free.

