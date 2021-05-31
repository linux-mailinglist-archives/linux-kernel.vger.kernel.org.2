Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63D93953A5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 03:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhEaBYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 21:24:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3290 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 21:24:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ftcqm38VPz1BGCK;
        Mon, 31 May 2021 09:18:28 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:23:08 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 09:23:07 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <bp@suse.de>,
        <rafael.j.wysocki@intel.com>, <mpe@ellerman.id.au>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] tools/testing/nvdimm: use vzalloc() instead of vmalloc()/memset(0)
Date:   Mon, 31 May 2021 09:48:35 +0800
Message-ID: <1622425715-146012-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc() instead of vmalloc() and memset(0) to simpify
the code.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 tools/testing/nvdimm/test/nfit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 54f367cbadae..258bba22780b 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1625,7 +1625,6 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
 	if (rc)
 		goto err;
 	INIT_LIST_HEAD(&nfit_res->list);
-	memset(buf, 0, size);
 	nfit_res->dev = dev;
 	nfit_res->buf = buf;
 	nfit_res->res.start = *dma;
@@ -1652,7 +1651,7 @@ static void *test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma)
 	struct genpool_data_align data = {
 		.align = SZ_128M,
 	};
-	void *buf = vmalloc(size);
+	void *buf = vzalloc(size);
 
 	if (size >= DIMM_SIZE)
 		*dma = gen_pool_alloc_algo(nfit_pool, size,
-- 
2.30.0

