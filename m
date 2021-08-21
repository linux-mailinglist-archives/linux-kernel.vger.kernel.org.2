Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435263F3843
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 05:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhHUDKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 23:10:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8915 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhHUDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 23:10:19 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gs3KV1kZWz8sXc;
        Sat, 21 Aug 2021 11:05:34 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 11:09:39 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 21 Aug 2021 11:09:38 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/2] dt-bindings: soc: remove obsolete zte zx header
Date:   Sat, 21 Aug 2021 11:09:24 +0800
Message-ID: <20210821030924.192-2-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20210821030924.192-1-yuzenghui@huawei.com>
References: <20210821030924.192-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zte zx platform had been removed in commit 89d4f98ae90d ("ARM: remove
zte zx platform"), so this header is no longer needed.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 include/dt-bindings/soc/zte,pm_domains.h | 24 ------------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 include/dt-bindings/soc/zte,pm_domains.h

diff --git a/include/dt-bindings/soc/zte,pm_domains.h b/include/dt-bindings/soc/zte,pm_domains.h
deleted file mode 100644
index df044705a5ec..000000000000
--- a/include/dt-bindings/soc/zte,pm_domains.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2017 Linaro Ltd.
- *
- * Author: Baoyou Xie <baoyou.xie@linaro.org>
- */
-
-#ifndef _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H
-#define _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H
-
-#define DM_ZX296718_SAPPU	0
-#define DM_ZX296718_VDE		1  /* g1v6 */
-#define DM_ZX296718_VCE		2  /* h1v6 */
-#define DM_ZX296718_HDE		3  /* g2v2 */
-#define DM_ZX296718_VIU		4
-#define DM_ZX296718_USB20	5
-#define DM_ZX296718_USB21	6
-#define DM_ZX296718_USB30	7
-#define DM_ZX296718_HSIC	8
-#define DM_ZX296718_GMAC	9
-#define DM_ZX296718_TS		10
-#define DM_ZX296718_VOU		11
-
-#endif /* _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H */
-- 
2.19.1

