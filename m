Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D03B4C48
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 05:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFZDzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 23:55:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5083 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFZDzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 23:55:37 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBfwJ1tbMzXlC5;
        Sat, 26 Jun 2021 11:48:00 +0800 (CST)
Received: from [10.174.179.57] (10.174.179.57) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 26 Jun 2021 11:53:14 +0800
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Subject: [PATCH v2] libnvdimm, badrange: replace div_u64_rem with DIV_ROUND_UP
Message-ID: <194fed48-eaf3-065f-9571-7813ad35b098@huawei.com>
Date:   Sat, 26 Jun 2021 11:53:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.57]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__add_badblock_range use div_u64_rem to round up end_sector and it
will introduces unnecessary rem define and costly '%' operation.
So clean it with DIV_ROUND_UP.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
V1->V2:
-- fix that end_sector is assigned twice, sorry for that.

 drivers/nvdimm/badrange.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index aaf6e215a8c6..af622ae511aa 100644
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
+	end_sector = DIV_ROUND_UP(ns_offset + len, sector_size);
 	num_sectors = end_sector - start_sector;

 	if (unlikely(num_sectors > (u64)INT_MAX)) {
-- 
2.23.0

-- 
Best wishes
Kemeng Shi
