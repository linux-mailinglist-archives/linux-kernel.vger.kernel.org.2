Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676AB345964
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCWIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:14:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14845 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCWIOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:14:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4PGl690Mz92LL;
        Tue, 23 Mar 2021 16:11:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 16:13:57 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@openeuler.org>
Subject: [PATCH v2] coresight: core: Fix typo in coresight-core.c
Date:   Tue, 23 Mar 2021 16:11:26 +0800
Message-ID: <1616487086-50418-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:
WARNING: 'compoment' may be misspelled - perhaps 'component'?

Fixes: 8e264c52e1da  ("coresight: core: Allow the coresight core driver to be built as a module")
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0062c89..b57bea1 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -86,7 +86,7 @@ static int coresight_id_match(struct device *dev, void *data)
 	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
 		return 0;
 
-	/* Get the source ID for both compoment */
+	/* Get the source ID for both components */
 	trace_id = source_ops(csdev)->trace_id(csdev);
 	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
 
-- 
2.8.1

