Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A482365342
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhDTHbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:31:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17799 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhDTHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:31:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPZzV6K2PzBrYk;
        Tue, 20 Apr 2021 15:28:22 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 15:30:34 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <santosh@fossix.org>,
        <ira.weiny@intel.com>, <akpm@linux-foundation.org>,
        <dan.carpenter@oracle.com>, <boris.ostrovsky@oracle.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next v2] tools/testing/nvdimm: Make symbol '__nfit_test_ioremap' static
Date:   Tue, 20 Apr 2021 15:47:47 +0800
Message-ID: <1618904867-25275-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

tools/testing/nvdimm/test/iomap.c:65:14: warning:
 symbol '__nfit_test_ioremap' was not declared. Should it be static?

This symbol is not used outside of iomap.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/testing/nvdimm/test/iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index c62d372..ed563bd 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
 }
 EXPORT_SYMBOL(get_nfit_res);
 
-void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
+static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
 		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
 {
 	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
-- 
2.6.2

