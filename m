Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD43EA07E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhHLIWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:22:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17007 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhHLIWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:22:31 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Glfhb3gDkzb17L;
        Thu, 12 Aug 2021 16:18:23 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 16:22:00 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 12 Aug
 2021 16:22:00 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <axboe@kernel.dk>
CC:     <maco@android.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qiulaibin@huawei.com>
Subject: [PATCH -next] loop: fix loop_validate_block_size() can't make sense
Date:   Thu, 12 Aug 2021 16:34:53 +0800
Message-ID: <20210812083453.761319-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We config the block size of a loop device throuth
the following process:

lo_ioctl(..., unsigned long arg)
|                      ^^^^
lo_simple_ioctl(..., unsigned long arg)
|                             ^^^^
loop_set_block_size(..., unsigned long arg)
        |                         ^^^^
        loop_validate_block_size(unsigned short bsize)
        |                                 ^^^^^
        blk_queue_logical_block_size(..., unsigned int size) {
                '''
                limits->logical_block_size = size;
                        ^^^^ int
                '''
        }

loop_validate_block_size() will check the validity of bsize.
But long to short will be truncated(eg arg=1049600 and
it becomes 1024 after truncation by short. The block size
must within the range of 512 ~ PAGE_SZIE, This truncation will
turn illegal block szie to legal). The wrong of block size will
raise other errors.

Fixes: 3448914e8cc55 ("loop: Add LOOP_CONFIGURE ioctl")
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1c298a8cfb..8fd551c00a9b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -277,7 +277,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
  * @bsize: size to validate
  */
 static int
-loop_validate_block_size(unsigned short bsize)
+loop_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.22.0

