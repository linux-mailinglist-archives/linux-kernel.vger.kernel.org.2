Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC253A57F7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFMLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 07:24:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6348 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhFMLYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 07:24:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G2sWq6ZQqz6x0v;
        Sun, 13 Jun 2021 19:18:15 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 13 Jun 2021 19:22:11 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 13
 Jun 2021 19:22:11 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 0/6] Fix deadlock in ftl formating on mtd
Date:   Sun, 13 Jun 2021 19:30:29 +0800
Message-ID: <20210613113035.2329421-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an AA-deadlock problem while formating mtd device to generate
a ftl device. Fix it by reverting "mtd: allow to unload the mtdtrans
module if its block devices aren't open" recommended in [1].

[<0>] blktrans_open+0x47/0x340            LOCK(mtd_table_mutex)
[<0>] __blkdev_get+0x5b/0x3e0
[<0>] blkdev_get_by_dev+0x18f/0x370
[<0>] __device_add_disk+0x2db/0x700
[<0>] device_add_disk+0x17/0x20
[<0>] add_mtd_blktrans_dev+0x39e/0x6d0
[<0>] ftl_add_mtd+0x792/0x908 [ftl]
[<0>] register_mtd_blktrans+0xfb/0x170    LOCK(mtd_table_mutex)
[<0>] ftl_tr_init+0x18/0x1000 [ftl]
[<0>] do_one_initcall+0x71/0x330
[<0>] do_init_module+0xa6/0x350

[1] http://lists.infradead.org/pipermail/linux-mtd/2017-March/072899.html

Zhihao Cheng (6):
  Revert "mtd: blkdevs: fix potential deadlock + lockdep warnings"
  Revert "mtd: fix: avoid race condition when accessing mtd->usecount"
  Revert "mtd: mtd_blkdevs: don't increase 'open' count on error path"
  Revert "mtd: mtd_blkdevs: fix error path in blktrans_open"
  Revert "mtd: Remove redundant mutex from mtd_blkdevs.c"
  Revert "mtd: allow to unload the mtdtrans module if its block devices
    aren't open"

 drivers/mtd/mtd_blkdevs.c | 77 +++++++++++++++------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

-- 
2.31.1

