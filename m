Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A663FFB4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbhICHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:52:50 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53746 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234758AbhICHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:52:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Un56PY0_1630655505;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Un56PY0_1630655505)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Sep 2021 15:51:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] um: virt-pci: Fix the application of sizeof to pointer
Date:   Fri,  3 Sep 2021 15:51:08 +0800
Message-Id: <1630655468-71684-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof() when applied to a pointer typed expression gives the size of
the pointer.

Clean up coccicheck warning:
./arch/um/drivers/virt-pci.c:192:20-26: ERROR: application of sizeof to
pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index c080666..156af2f 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -189,7 +189,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(data, 0xff, sizeof(data));
+	memset(data, 0xff, sizeof(*data));
 
 	switch (size) {
 	case 1:
-- 
1.8.3.1

