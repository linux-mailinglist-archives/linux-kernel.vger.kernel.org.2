Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00783DC2AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 04:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhGaCWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 22:22:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7903 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhGaCWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 22:22:03 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gc7GT0HBlz81JH;
        Sat, 31 Jul 2021 10:18:09 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 10:21:56 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 31
 Jul 2021 10:21:55 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <bbrezillon@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 0/2] mtd: mtdconcat: Fix callback functions check
Date:   Sat, 31 Jul 2021 10:32:41 +0800
Message-ID: <20210731023243.3977104-1-chengzhihao1@huawei.com>
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

Patch 1: Check subdev's master mtd device's callback function while
making concatenated device.
Patch 2: Remove bad callback function assignments.

Zhihao Cheng (2):
  mtd: mtdconcat: Judge callback function existence getting from master
    for each partition
  mtd: mtdconcat: Remove concat_{read|write}_oob

 drivers/mtd/mtdconcat.c | 123 +++-------------------------------------
 1 file changed, 8 insertions(+), 115 deletions(-)

-- 
2.31.1

