Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE66842DA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJNNXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:23:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24313 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNNXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:23:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVVL1052GzYjTy;
        Thu, 14 Oct 2021 21:16:57 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 21:21:26 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 21:21:25 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <johan@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: serial: Fix possible memleak in keyspan_port_probe()
Date:   Thu, 14 Oct 2021 21:20:33 +0800
Message-ID: <20211014132033.554304-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got memory leak as follows when doing fault injection test:

unreferenced object 0xffff888258228440 (size 64):
  comm "kworker/7:2", pid 2005, jiffies 4294989509 (age 824.540s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8167939c>] slab_post_alloc_hook+0x9c/0x490
    [<ffffffff8167f627>] kmem_cache_alloc_trace+0x1f7/0x470
    [<ffffffffa02ac0e4>] keyspan_port_probe+0xa4/0x5d0 [keyspan]
    [<ffffffffa0294c07>] usb_serial_device_probe+0x97/0x1d0 [usbserial]
    [<ffffffff82b50ca7>] really_probe+0x167/0x460
    [<ffffffff82b51099>] __driver_probe_device+0xf9/0x180
    [<ffffffff82b51173>] driver_probe_device+0x53/0x130
    [<ffffffff82b516f5>] __device_attach_driver+0x105/0x130
    [<ffffffff82b4cfe9>] bus_for_each_drv+0x129/0x190
    [<ffffffff82b50a69>] __device_attach+0x1c9/0x270
    [<ffffffff82b518d0>] device_initial_probe+0x20/0x30
    [<ffffffff82b4f062>] bus_probe_device+0x142/0x160
    [<ffffffff82b4a4e9>] device_add+0x829/0x1300
    [<ffffffffa0295fda>] usb_serial_probe.cold+0xc9b/0x14ac [usbserial]
    [<ffffffffa02266aa>] usb_probe_interface+0x1aa/0x3c0 [usbcore]
    [<ffffffff82b50ca7>] really_probe+0x167/0x460

If it fails to allocate memory for an out_buffer[i] or in_buffer[i],
the previously allocated memory for out_buffer or in_buffer needs to
be freed on the error handling path, otherwise a memory leak will result.

Fixes: bad41a5bf177 ("USB: keyspan: fix port DMA-buffer allocations")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/usb/serial/keyspan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 87b89c99d517..ba27a9f0275b 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -2901,7 +2901,7 @@ static int keyspan_port_probe(struct usb_serial_port *port)
 
 	p_priv->inack_buffer = kzalloc(INACK_BUFLEN, GFP_KERNEL);
 	if (!p_priv->inack_buffer)
-		goto err_inack_buffer;
+		goto err_out_buffer;
 
 	p_priv->outcont_buffer = kzalloc(OUTCONT_BUFLEN, GFP_KERNEL);
 	if (!p_priv->outcont_buffer)
@@ -2953,13 +2953,12 @@ static int keyspan_port_probe(struct usb_serial_port *port)
 
 err_outcont_buffer:
 	kfree(p_priv->inack_buffer);
-err_inack_buffer:
+err_out_buffer:
 	for (i = 0; i < ARRAY_SIZE(p_priv->out_buffer); ++i)
 		kfree(p_priv->out_buffer[i]);
-err_out_buffer:
+err_in_buffer:
 	for (i = 0; i < ARRAY_SIZE(p_priv->in_buffer); ++i)
 		kfree(p_priv->in_buffer[i]);
-err_in_buffer:
 	kfree(p_priv);
 
 	return -ENOMEM;
-- 
2.25.1

