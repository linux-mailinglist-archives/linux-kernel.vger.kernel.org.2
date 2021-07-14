Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B012F3C7AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhGNBFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:05:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6811 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhGNBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:05:08 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPfGF6rP8zXrJg;
        Wed, 14 Jul 2021 08:56:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by dggeml757-chm.china.huawei.com
 (10.1.199.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 09:02:14 +0800
From:   Yi Zhuang <zhuangyi1@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>
CC:     <zhuangyi1@huawei.com>, <hegdevasant@linux.vnet.ibm.com>,
        <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc/rtas_flash: fix a potential buffer overflow
Date:   Wed, 14 Jul 2021 09:16:08 +0800
Message-ID: <20210714011608.15043-1-zhuangyi1@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the possible output size instead of the
actual output size, the available flash_msg length returned by
get_validate_flash_msg may exceed the given buffer limit when
simple_read_from_buffer calls copy_to_user

Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>
---
 arch/powerpc/kernel/rtas_flash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a99179d83538..4aa6bad28556 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -473,6 +473,10 @@ static int get_validate_flash_msg(struct rtas_validate_flash_t *args_buf,
 		    (args_buf->update_results == VALIDATE_TMP_UPDATE))
 			n += snprintf(msg + n, msglen - n, "%s\n",
 					args_buf->buf);
+			if (n >= msglen) {
+				n = msglen;
+				printk(KERN_ERR "FLASH: msg too long.\n");
+			}
 	} else {
 		n = sprintf(msg, "%d\n", args_buf->status);
 	}
-- 
2.26.0.106.g9fadedd

