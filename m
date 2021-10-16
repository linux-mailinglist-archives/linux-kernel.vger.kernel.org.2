Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D95430065
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 07:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhJPFYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 01:24:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28947 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJPFYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 01:24:01 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HWWbh5hw3zbmDF;
        Sat, 16 Oct 2021 13:17:20 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 16 Oct 2021 13:21:50 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <eli.billauer@gmail.com>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] char: xillybus: fix msg_ep UAF in xillyusb_probe()
Date:   Sat, 16 Oct 2021 13:20:47 +0800
Message-ID: <20211016052047.1611983-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When endpoint_alloc() return failed in xillyusb_setup_base_eps(),
'xdev->msg_ep' will be freed but not set to NULL. That lets program
enter fail handling to cleanup_dev() in xillyusb_probe(). Check for
'xdev->msg_ep' is invalid in cleanup_dev() because 'xdev->msg_ep' did
not set to NULL when was freed. So the UAF problem for 'xdev->msg_ep'
is triggered.

==================================================================
BUG: KASAN: use-after-free in fifo_mem_release+0x1f4/0x210
CPU: 0 PID: 166 Comm: kworker/0:2 Not tainted 5.15.0-rc5+ #19
Call Trace:
 dump_stack_lvl+0xe2/0x152
 print_address_description.constprop.0+0x21/0x140
 ? fifo_mem_release+0x1f4/0x210
 kasan_report.cold+0x7f/0x11b
 ? xillyusb_probe+0x530/0x700
 ? fifo_mem_release+0x1f4/0x210
 fifo_mem_release+0x1f4/0x210
 ? __sanitizer_cov_trace_pc+0x1d/0x50
 endpoint_dealloc+0x35/0x2b0
 cleanup_dev+0x90/0x120
 xillyusb_probe+0x59a/0x700
...

Freed by task 166:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0x109/0x140
 kfree+0x117/0x4c0
 xillyusb_probe+0x606/0x700

Set 'xdev->msg_ep' to NULL after being freed in xillyusb_setup_base_eps()
to fix the UAF problem.

Fixes: a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 drivers/char/xillybus/xillyusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index e7f88f35c702..dc3551796e5e 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -1912,6 +1912,7 @@ static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
 
 dealloc:
 	endpoint_dealloc(xdev->msg_ep); /* Also frees FIFO mem if allocated */
+	xdev->msg_ep = NULL;
 	return -ENOMEM;
 }
 
-- 
2.25.1

