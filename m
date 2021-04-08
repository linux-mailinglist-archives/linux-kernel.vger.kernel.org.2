Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D52358153
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhDHLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:07:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16088 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:07:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGJLv542Jz19KpQ;
        Thu,  8 Apr 2021 19:04:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:06:58 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <joern@lazybastard.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <matthias.bgg@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/3] code optimization for mtd
Date:   Thu, 8 Apr 2021 19:15:11 +0800
Message-ID: <20210408111514.1011020-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Kuai (3):
  mtd: rawnand: mtk: remove redundant dev_err call in mtk_ecc_probe()
  mtd: plat-ram: remove redundant dev_err call in platram_probe()
  mtd: phram: Fix error return code in phram_setup()

 drivers/mtd/devices/phram.c    | 1 +
 drivers/mtd/maps/plat-ram.c    | 1 -
 drivers/mtd/nand/raw/mtk_ecc.c | 4 +---
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.25.4

