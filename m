Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CAC3EF067
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhHQQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:49:58 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34685 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhHQQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:49:54 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9E9B824000B;
        Tue, 17 Aug 2021 16:49:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 1/2] mtd: mtdconcat: Judge callback existence based on the master
Date:   Tue, 17 Aug 2021 18:49:18 +0200
Message-Id: <20210817164918.108904-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210817114857.2784825-2-chengzhihao1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f9e109a209a8e01e16f37e1252304f1eb3908be4'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-17 at 11:48:56 UTC, Zhihao Cheng wrote:
> Since commit 46b5889cc2c5("mtd: implement proper partition handling")
> applied, mtd partition device won't hold some callback functions, such
> as _block_isbad, _block_markbad, etc. Besides, function mtd_block_isbad()
> will get mtd device's master mtd device, then invokes master mtd device's
> callback function. So, following process may result mtd_block_isbad()
> always return 0, even though mtd device has bad blocks:
> 
> 1. Split a mtd device into 3 partitions: PA, PB, PC
> [ Each mtd partition device won't has callback function _block_isbad(). ]
> 2. Concatenate PA and PB as a new mtd device PN
> [ mtd_concat_create() finds out each subdev has no callback function
> _block_isbad(), so PN won't be assigned callback function
> concat_block_isbad(). ]
> Then, mtd_block_isbad() checks "!master->_block_isbad" is true, will
> always return 0.
> 
> Reproducer:
> // reproduce.c
> static int __init init_diy_module(void)
> {
> 	struct mtd_info *mtd[2];
> 	struct mtd_info *mtd_combine = NULL;
> 
> 	mtd[0] = get_mtd_device_nm("NAND simulator partition 0");
> 	if (!mtd[0]) {
> 		pr_err("cannot find mtd1\n");
> 		return -EINVAL;
> 	}
> 	mtd[1] = get_mtd_device_nm("NAND simulator partition 1");
> 	if (!mtd[1]) {
> 		pr_err("cannot find mtd2\n");
> 		return -EINVAL;
> 	}
> 
> 	put_mtd_device(mtd[0]);
> 	put_mtd_device(mtd[1]);
> 
> 	mtd_combine = mtd_concat_create(mtd, 2, "Combine mtd");
> 	if (mtd_combine == NULL) {
> 		pr_err("combine failed\n");
> 		return -EINVAL;
> 	}
> 
> 	mtd_device_register(mtd_combine, NULL, 0);
> 	pr_info("Combine success\n");
> 
> 	return 0;
> }
> 
> 1. ID="0x20,0xac,0x00,0x15"
> 2. modprobe nandsim id_bytes=$ID parts=50,100 badblocks=100
> 3. insmod reproduce.ko
> 4. flash_erase /dev/mtd3 0 0
>   libmtd: error!: MEMERASE64 ioctl failed for eraseblock 100 (mtd3)
>   error 5 (Input/output error)
>   // Should be "flash_erase: Skipping bad block at 00c80000"
> 
> Fixes: 46b5889cc2c54bac ("mtd: implement proper partition handling")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
