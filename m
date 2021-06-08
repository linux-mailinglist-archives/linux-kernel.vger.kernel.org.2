Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205FF39EAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFHAdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:33:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4384 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFHAdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:33:50 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzWKz0769z6vNJ;
        Tue,  8 Jun 2021 08:28:07 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 08:31:57 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 08:31:56 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <Roy.Pledge@nxp.com>, <leoyang.li@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] soc: fsl: dpio: use list_move_tail instead of list_del/list_add_tail
Date:   Tue, 8 Jun 2021 08:50:32 +0800
Message-ID: <1623113432-49313-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_move_tail() instead of list_del() + list_add_tail().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 7351f30..340c090 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -76,8 +76,7 @@ static inline struct dpaa2_io *service_select(struct dpaa2_io *d)
 
 	spin_lock(&dpio_list_lock);
 	d = list_entry(dpio_list.next, struct dpaa2_io, node);
-	list_del(&d->node);
-	list_add_tail(&d->node, &dpio_list);
+	list_move_tail(&d->node, &dpio_list);
 	spin_unlock(&dpio_list_lock);
 
 	return d;
-- 
2.6.2

