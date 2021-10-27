Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4D43CC52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhJ0OiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:38:07 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43760 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237738AbhJ0OiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:38:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UtuPuVY_1635345335;
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0UtuPuVY_1635345335)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 22:35:38 +0800
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
To:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     cuibixuan@linux.alibaba.com, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes.berg@intel.com
Subject: [PATCH -next] um: virt-pci: Fix application of sizeof to pointer
Date:   Wed, 27 Oct 2021 22:35:35 +0800
Message-Id: <1635345335-33899-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix noderef.cocci warning:
./arch/um/drivers/virt-pci.c:192:20-26: ERROR: application of sizeof
to pointer

Fixes: 4a22c4cebd61 ("um: virt-pci: don't do DMA from stack")
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
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

