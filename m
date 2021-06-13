Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAEF3A5945
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhFMPOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Jun 2021 11:14:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42639 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhFMPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 11:14:13 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 34F4C1BF205;
        Sun, 13 Jun 2021 15:12:09 +0000 (UTC)
Date:   Sun, 13 Jun 2021 17:12:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: Re: [PATCH 0/6] Fix deadlock in ftl formating on mtd
Message-ID: <20210613171208.64395d32@xps13>
In-Reply-To: <20210613113035.2329421-1-chengzhihao1@huawei.com>
References: <20210613113035.2329421-1-chengzhihao1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhihao,

Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sun, 13 Jun 2021
19:30:29 +0800:

> There is an AA-deadlock problem while formating mtd device to generate
> a ftl device. Fix it by reverting "mtd: allow to unload the mtdtrans
> module if its block devices aren't open" recommended in [1].
> 
> [<0>] blktrans_open+0x47/0x340            LOCK(mtd_table_mutex)
> [<0>] __blkdev_get+0x5b/0x3e0
> [<0>] blkdev_get_by_dev+0x18f/0x370
> [<0>] __device_add_disk+0x2db/0x700
> [<0>] device_add_disk+0x17/0x20
> [<0>] add_mtd_blktrans_dev+0x39e/0x6d0
> [<0>] ftl_add_mtd+0x792/0x908 [ftl]
> [<0>] register_mtd_blktrans+0xfb/0x170    LOCK(mtd_table_mutex)
> [<0>] ftl_tr_init+0x18/0x1000 [ftl]
> [<0>] do_one_initcall+0x71/0x330
> [<0>] do_init_module+0xa6/0x350
> 
> [1] http://lists.infradead.org/pipermail/linux-mtd/2017-March/072899.html
> 
> Zhihao Cheng (6):
>   Revert "mtd: blkdevs: fix potential deadlock + lockdep warnings"
>   Revert "mtd: fix: avoid race condition when accessing mtd->usecount"
>   Revert "mtd: mtd_blkdevs: don't increase 'open' count on error path"
>   Revert "mtd: mtd_blkdevs: fix error path in blktrans_open"
>   Revert "mtd: Remove redundant mutex from mtd_blkdevs.c"
>   Revert "mtd: allow to unload the mtdtrans module if its block devices
>     aren't open"

I understand that some fixes need to revert a couple of patches, but
isn't reverting 6 commits from the v2.6.32 kernel a bit odd for that?
At least, can you justify this choice? Are all these commits useless
and buggy?

> 
>  drivers/mtd/mtd_blkdevs.c | 77 +++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 47 deletions(-)
> 

Thanks,
Miquèl
