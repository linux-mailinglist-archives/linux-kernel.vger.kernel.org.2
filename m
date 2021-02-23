Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8C322BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhBWOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:14:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12945 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhBWONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:13:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DlLZv00P7zjQfb;
        Tue, 23 Feb 2021 22:11:50 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 22:13:02 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] nvmem: Fix return value check in rmem_read()
Date:   Tue, 23 Feb 2021 14:22:14 +0000
Message-ID: <20210223142214.3405217-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function memremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvmem/rmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index b11c3c974b3d..80cb187f1481 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -37,9 +37,9 @@ static int rmem_read(void *context, unsigned int offset,
 	 * but as of Dec 2020 this isn't possible on arm64.
 	 */
 	addr = memremap(priv->mem->base, available, MEMREMAP_WB);
-	if (IS_ERR(addr)) {
+	if (!addr) {
 		dev_err(priv->dev, "Failed to remap memory region\n");
-		return PTR_ERR(addr);
+		return -ENOMEM;
 	}
 
 	count = memory_read_from_buffer(val, bytes, &off, addr, available);

