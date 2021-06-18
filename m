Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E056F3AC546
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhFRHyV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Jun 2021 03:54:21 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49387 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhFRHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:54:19 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E49E8FF809;
        Fri, 18 Jun 2021 07:52:08 +0000 (UTC)
Date:   Fri, 18 Jun 2021 09:52:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] mtd: mtd_blkdevs: Initialize
 rq.limits.discard_granularity
Message-ID: <20210618095207.0bec4fde@xps13>
In-Reply-To: <20210615093905.3473709-1-chengzhihao1@huawei.com>
References: <20210615093905.3473709-1-chengzhihao1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Tue, 15 Jun 2021
17:39:05 +0800:

> Since commit b35fd7422c2f8("block: check queue's limits.discard_granularity
> in __blkdev_issue_discard()") checks rq.limits.discard_granularity in
> __blkdev_issue_discard(), we may get following warnings on formatted ftl:
> 
>   WARNING: CPU: 2 PID: 7313 at block/blk-lib.c:51
>   __blkdev_issue_discard+0x2a7/0x390
> 
> Reproducer:
>   1. ftl_format /dev/mtd0
>   2. modprobe ftl
>   3. mkfs.vfat /dev/ftla
>   4. mount -odiscard /dev/ftla temp
>   5. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
>   6. dd if=/dev/zero of=temp/tst bs=1M count=10 oflag=direct
> 
> Fix it by initializing rq.limits.discard_granularity if device supports
> discard operation.

Can you please verify that this is still needed after Christoph's
additional fix:
https://patchwork.kernel.org/project/xen-devel/patch/20210602065345.355274-10-hch@lst.de/

> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/mtd/mtd_blkdevs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 01bf234e7f3a..6eac1c9c164d 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -413,6 +413,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  	if (tr->discard) {
>  		blk_queue_flag_set(QUEUE_FLAG_DISCARD, new->rq);
>  		blk_queue_max_discard_sectors(new->rq, UINT_MAX);
> +		new->rq->limits.discard_granularity = tr->blksize;
>  	}
>  
>  	gd->queue = new->rq;




Thanks,
Miquèl
