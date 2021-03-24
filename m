Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2970347ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbhCXOdY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Mar 2021 10:33:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhCXOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:33:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F59dB1dRqznW2v;
        Wed, 24 Mar 2021 22:30:38 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 22:33:03 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] libnvdimm/security: Make symbol '__nvdimm_security_overwrite_query' static
Date:   Wed, 24 Mar 2021 14:42:57 +0000
Message-ID: <20210324144257.1014160-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

drivers/nvdimm/security.c:416:6: warning:
 symbol '__nvdimm_security_overwrite_query' was not declared. Should it be static?

This symbol is not used outside of security.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4b80150e4afa..d3e782662bf4 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -413,7 +413,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	return rc;
 }
 
-void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
+static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nvdimm->dev);
 	int rc;

