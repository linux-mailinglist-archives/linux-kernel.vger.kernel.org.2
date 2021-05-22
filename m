Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90238D51A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEVK2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:28:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5737 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEVK2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:28:24 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FnKLj37LhzqV18;
        Sat, 22 May 2021 18:23:25 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:26:58 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500008.china.huawei.com (7.185.36.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:26:57 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] drivers/perf: hisi: use the correct HiSilicon copyright
Date:   Sat, 22 May 2021 18:23:57 +0800
Message-ID: <1621679037-15323-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Hisilicon/HiSilicon/.
It should use capital S, according to the official website
https://www.hisilicon.com/en.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h      | 2 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 7c8a4bc..7387700 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -2,7 +2,7 @@
 /*
  * HiSilicon SoC DDRC uncore Hardware event counters support
  *
- * Copyright (C) 2017 Hisilicon Limited
+ * Copyright (C) 2017 HiSilicon Limited
  * Author: Shaokun Zhang <zhangshaokun@hisilicon.com>
  *         Anurup M <anurup.m@huawei.com>
  *
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 0316fab..e29c917 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -2,7 +2,7 @@
 /*
  * HiSilicon SoC HHA uncore Hardware event counters support
  *
- * Copyright (C) 2017 Hisilicon Limited
+ * Copyright (C) 2017 HiSilicon Limited
  * Author: Shaokun Zhang <zhangshaokun@hisilicon.com>
  *         Anurup M <anurup.m@huawei.com>
  *
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index bf9f777..4e7ee96 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -2,7 +2,7 @@
 /*
  * HiSilicon SoC L3C uncore Hardware event counters support
  *
- * Copyright (C) 2017 Hisilicon Limited
+ * Copyright (C) 2017 HiSilicon Limited
  * Author: Anurup M <anurup.m@huawei.com>
  *         Shaokun Zhang <zhangshaokun@hisilicon.com>
  *
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 13c68b5..3600458 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -2,7 +2,7 @@
 /*
  * HiSilicon SoC Hardware event counters support
  *
- * Copyright (C) 2017 Hisilicon Limited
+ * Copyright (C) 2017 HiSilicon Limited
  * Author: Anurup M <anurup.m@huawei.com>
  *         Shaokun Zhang <zhangshaokun@hisilicon.com>
  *
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index ea9d89b..7f5841d 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -2,7 +2,7 @@
 /*
  * HiSilicon SoC Hardware event counters support
  *
- * Copyright (C) 2017 Hisilicon Limited
+ * Copyright (C) 2017 HiSilicon Limited
  * Author: Anurup M <anurup.m@huawei.com>
  *         Shaokun Zhang <zhangshaokun@hisilicon.com>
  *
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index 46be312..671d97c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -2,7 +2,7 @@
 /*
  * HiSilicon SLLC uncore Hardware event counters support
  *
- * Copyright (C) 2020 Hisilicon Limited
+ * Copyright (C) 2020 HiSilicon Limited
  * Author: Shaokun Zhang <zhangshaokun@hisilicon.com>
  *
  * This code is based on the uncore PMUs like arm-cci and arm-ccn.
-- 
2.8.1

