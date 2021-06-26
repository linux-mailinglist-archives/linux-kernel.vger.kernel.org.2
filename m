Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFA3B4C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFZDc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:32:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8324 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFZDc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:32:56 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GBfQb3Trtz71y0;
        Sat, 26 Jun 2021 11:25:43 +0800 (CST)
Received: from [10.174.179.57] (10.174.179.57) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 26 Jun 2021 11:29:52 +0800
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Subject: [PATCH] libnvdimm, badrange: replace div_u64_rem with DIV_ROUND_UP
Message-ID: <f08656fd-ba11-a556-dacd-cc573ac2e069@huawei.com>
Date:   Sat, 26 Jun 2021 11:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.57]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__add_badblock_range use div_u64_rem to round up end_sector and it will
introduces unnecessary rem define and costly '%' operation. So clean it
with DIV_ROUND_UP.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 drivers/nvdimm/badrange.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index aaf6e215a8c6..28e73506d85e 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -187,12 +187,9 @@ static void __add_badblock_range(struct badblocks *bb, u64 ns_offset, u64 len)
 	const unsigned int sector_size = 512;
 	sector_t start_sector, end_sector;
 	u64 num_sectors;
-	u32 rem;

 	start_sector = div_u64(ns_offset, sector_size);
-	end_sector = div_u64_rem(ns_offset + len, sector_size, &rem);
-	if (rem)
-		end_sector++;
+	end_sector = end_sector = DIV_ROUND_UP(ns_offset + len, sector_size);
 	num_sectors = end_sector - start_sector;

 	if (unlikely(num_sectors > (u64)INT_MAX)) {
-- 
2.23.0

-- 
Best wishes
Kemeng Shi
