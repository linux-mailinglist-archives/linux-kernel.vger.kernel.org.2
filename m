Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4335E394C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhE2MHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:07:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2470 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2MHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:07:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsgCl6qnYz689v;
        Sat, 29 May 2021 20:02:27 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 20:05:18 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 20:05:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] USB: gadget: f_fs: Remove unneed cast in ffs_prepare_buffer()
Date:   Sat, 29 May 2021 20:04:08 +0800
Message-ID: <20210529120408.23456-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coccicheck run provided information like the following.

./drivers/usb/gadget/function/f_fs.c:3832:9-16:
 WARNING: ERR_CAST can be used with data

ffs_prepare_buffer() should return an ERR_PTR() encoded error
code on failure.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index bf109191659a..cb419bbd089c 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3829,7 +3829,7 @@ static char *ffs_prepare_buffer(const char __user *buf, size_t len)
 
 	data = memdup_user(buf, len);
 	if (IS_ERR(data))
-		return ERR_PTR(PTR_ERR(data));
+		return data;
 
 	pr_vdebug("Buffer from user space:\n");
 	ffs_dump_mem("", data, len);
-- 
2.17.1

