Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD51443AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKCBWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:22:45 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:27101 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKCBWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:22:43 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HkTRF10q4z1DHBw;
        Wed,  3 Nov 2021 09:18:01 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 09:20:05 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 09:20:04 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <patchwork@huawei.com>, <libaokun1@huawei.com>,
        <yukuai3@huawei.com>, <chengzhihao1@huawei.com>
Subject: [PATCH -next V2 0/2] ubi: fix race between ctrl_cdev_ioctl and ubi_cdev_ioctl
Date:   Wed, 3 Nov 2021 09:32:47 +0800
Message-ID: <20211103013249.498805-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock held by ctrl_cdev_ioctl is ubi_devices_mutex, but the lock held by
ubi_cdev_ioctl is ubi->device_mutex. Therefore, the two locks can be
concurrent.

ubi_attach_mtd_dev in ctrl_cdev_ioctl may be race with ubi_create_volume and
ubi_remove_volume in ubi_cdev_ioctl. Because ubi_attach_mtd_dev has similar
ubi_free_volume and ubi_open_volume. These two functions are called in
uif_init and uif_close, and we'll fix both races in this patch set.

Another function in ctrl_cdev_ioctl, ubi_detach_mtd_dev, uses reference
counting and ubi_devices_lock to avoid race in concurrency cases,
so we do not need to fix it.

V1->V2:
	Add race in uif_close

Baokun Li (2):
  ubi: fix race between volume operations and uif_init
  ubi: fix race between volume operations and uif_close

 drivers/mtd/ubi/build.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.31.1

