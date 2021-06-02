Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7F398493
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhFBIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:53:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2952 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhFBIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:53:05 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw2jy6lBHz67fp;
        Wed,  2 Jun 2021 16:48:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:51:20 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 16:51:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>
CC:     <alexandre.belloni@bootlin.com>, <miquel.raynal@bootlin.com>
Subject: [PATCH -next] i3c: master: svc: fix doc warning in svc-i3c-master.c
Date:   Wed, 2 Jun 2021 16:55:44 +0800
Message-ID: <20210602085544.4101980-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following make W=1 warning:

  drivers/i3c/master/svc-i3c-master.c:207: warning: expecting prototype for struct svc_i3c_i3c_dev_data. Prototype was for struct svc_i3c_i2c_dev_data instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index eeb49b5d90ef..879e5a64acaf 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -195,7 +195,7 @@ struct svc_i3c_master {
 };
 
 /**
- * struct svc_i3c_i3c_dev_data - Device specific data
+ * struct svc_i3c_i2c_dev_data - Device specific data
  * @index: Index in the master tables corresponding to this device
  * @ibi: IBI slot index in the master structure
  * @ibi_pool: IBI pool associated to this device
-- 
2.25.1

