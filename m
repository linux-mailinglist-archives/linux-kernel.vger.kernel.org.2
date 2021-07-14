Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14023C7B24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhGNBqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:46:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10479 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGNBqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:46:35 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPgDn2BgHzccSB;
        Wed, 14 Jul 2021 09:40:25 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 09:43:42 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 09:43:41 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <sudeep.holla@arm.com>, <james.morse@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
Date:   Wed, 14 Jul 2021 09:32:55 +0800
Message-ID: <1626226375-58730-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM64, when PPTT(Processor Properties Topology Table) is not
implemented in ACPI boot, we will goto 'free_ci' with the following
print:
  Unable to detect cache hierarchy for CPU 0

But some other codes may still use 'num_leaves' to iterate through the
'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
would crash. So clear 'num_leaves' in free_cache_attributes().

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
v1 -> v2: Drop the Fixes tag as it doesn't fix anything in upstream.
---
 drivers/base/cacheinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index bfc0959..dad2962 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -297,6 +297,7 @@ static void free_cache_attributes(unsigned int cpu)
 
 	kfree(per_cpu_cacheinfo(cpu));
 	per_cpu_cacheinfo(cpu) = NULL;
+	cache_leaves(cpu) = 0;
 }
 
 int __weak init_cache_level(unsigned int cpu)
-- 
1.7.12.4

