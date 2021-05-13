Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86DE37F8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhEMNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:30:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2588 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhEMN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:29:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fgspq0bGzzsRJ3;
        Thu, 13 May 2021 21:25:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:27:53 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH 1/3] coresight: core: Fix use of uninitialized pointer
Date:   Thu, 13 May 2021 21:27:47 +0800
Message-ID: <1620912469-52222-2-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620912469-52222-1-git-send-email-liuqi115@huawei.com>
References: <1620912469-52222-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Currently the pointer "sink" might be checked before initialized. Fix
this by initializing this pointer.

Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6c68d34..4ddf3d2 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -608,7 +608,7 @@ static struct coresight_device *
 coresight_find_enabled_sink(struct coresight_device *csdev)
 {
 	int i;
-	struct coresight_device *sink;
+	struct coresight_device *sink = NULL;
 
 	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
-- 
2.7.4

