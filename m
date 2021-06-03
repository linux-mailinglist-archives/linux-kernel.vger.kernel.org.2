Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D779B39A29E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFCN7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:59:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3414 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFCN7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:59:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwnT14zQgz6v0j;
        Thu,  3 Jun 2021 21:54:45 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 21:57:44 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 21:57:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ryabinin.a.a@gmail.com>, <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] kasan: fix doc warning in init.c
Date:   Thu, 3 Jun 2021 22:07:00 +0800
Message-ID: <20210603140700.3045298-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc W=1 warning:

mm/kasan/init.c:228: warning: Function parameter or member 'shadow_start' not described in 'kasan_populate_early_shadow'
mm/kasan/init.c:228: warning: Function parameter or member 'shadow_end' not described in 'kasan_populate_early_shadow'

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 mm/kasan/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index c4605ac9837b..348f31d15a97 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -220,8 +220,8 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 /**
  * kasan_populate_early_shadow - populate shadow memory region with
  *                               kasan_early_shadow_page
- * @shadow_start - start of the memory range to populate
- * @shadow_end   - end of the memory range to populate
+ * @shadow_start: start of the memory range to populate
+ * @shadow_end: end of the memory range to populate
  */
 int __ref kasan_populate_early_shadow(const void *shadow_start,
 					const void *shadow_end)
-- 
2.31.1

