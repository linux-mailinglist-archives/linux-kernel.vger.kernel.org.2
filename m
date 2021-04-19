Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B23A363C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhDSHEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:04:10 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:9530
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237527AbhDSHEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5svZRZzT2h+glvIjucxBPxR1u+KL2tzfUWSh+lzhIeY64Co+2QNiYQSSI2Tp3ATJ/KNwXrCoCFCV3U4keGpiU8dm8mVaTC2VwyCk2z/2R+2l/cZb2BHSN327x84fVTPy2mLI/FXmsaCFiMLBYw1H26td80tJqshnDLknPMIdWyLTwsUCDiSL7SA7DIVzItxChPQUtDcnA9u6h4RwMwigzIcUwKv8HCjL0SPzO3qgzq8mUmR8BGZSl772AqsEoA2XKPPp63k4sBkgNiPVedJPxlu0b05Fcryf53tiwaHE6O9R7JHFT8X2gaEk3vz1wTs/zZ5jhXQJj99ZZZhPT/Wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44pinDRiqBmdj7VUGAArYMHd7Mg7/8DAdcZwrc4Z0AQ=;
 b=KuW7gB3ILZkEjpxv9PGIN+eSgFkeyLoYnsovOlpoO7CP3PvJd5p2/3ozdn8n6sM1X9Iwh0PqfzHd0dYLt2ntsQdQLs+niCfzpasYzRlb4/LSElxuaX/3sbrXojaguPkjeT+4/rQlLmlBgynp85wyQI2Sau6KZpXvs9uXg1rGT4SJ6hOEE7R4S09IBN9CLWnvRHmbvLUTuk0aOuh49BfGEyj6b2s7kjjXUK54XrGcF9deFre8/P9VzrWL7UG2sUtkiagv4mbhNFvoTe65d58xc9/XozFgp2zw44XZsfb4WztyOTdg4whqH4gRYKfXYqefmHv4RXtnO4xxoXxdabkURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44pinDRiqBmdj7VUGAArYMHd7Mg7/8DAdcZwrc4Z0AQ=;
 b=B8l4KDm0cknmip4a7FilVbOcuNYj3A8hg61BnEDgMC4lAV377Z+pBBxNFOBfsgkOQ1LXJNVn5EfogO0Jzp/PNXkQeZ0kR98QMGiQsRq+HYBNuz3zX3PPZc/cg0DE96OsLABBtMdFitXfATCSvQFp2HFAiNEwjNX5ohCFR0Y12qvR5mM0aDBnm7IQcOqS3MZOwXx6mxW1OK1Y1/Oast9ZSuUV+1FM5aX6Lpds58RdCvDGr4syaAw6tkfg9f85L+yMEqRw7srJBh8Q3/Sz/xDm3f1ckRw5U2s+vqAiN7t3WJExhur5CGvUig/HidPe5cymtznb4zTjQeKzRTTOe1oxVw==
Received: from DM5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:3:c0::32) by
 BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 07:03:36 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::b1) by DM5PR16CA0022.outlook.office365.com
 (2603:10b6:3:c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 07:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:03:36 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 07:03:35 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, <smuchun@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v5 2/3] kernel/resource: Refactor __request_region to allow external locking
Date:   Mon, 19 Apr 2021 17:01:08 +1000
Message-ID: <20210419070109.4780-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419070109.4780-1-apopple@nvidia.com>
References: <20210419070109.4780-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 759b2cf9-9d0c-45d5-c8a1-08d9030140a8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51647B4477A6EB6E16A43D95DF499@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4rCPeo8s9hxoMD4OKHeOxgIo8TT/fzTh0OMGnqDEESzJPJMM2akGhz2bmTvgdwYAM7AOpGZ3tx2VhR7+NtihvXTLZIcTexK2jtMvpOonbApV7wphLw4N1CVNIOTD7et6+yMSQAynfpYhDhvs5KN0Ccl0XVJFxbEACGQ7RTdS94w5ESENS74TXBjszmrrXg/tadUqdH7qOyo3vE4cRcbNziVfqC0s1wSCS4KdNTSNNQpAPtcF0gN6w917TYifKVeSE77AE6Bf4+6YoUmAMUI4cGF9neIchHSBn9MzoB7m+L19YQXSmdRwp5uvQzqoeEBtA6b/+G+DjIbxezU6o+t3hSYwBelyx96kviQEyf8rU+VPQqtQHOs9sw5feBVsMQ6Re8s+Y14UTzmXNM5sgb26qlOiu1E/+pq9Y8SjABiKhr6ourbakpwMEKTRrb8S5j2ppWHXxqIGCKBl8aVFq9dS7/OTQIYlLOFVFn3/snH7gum0V+g7egujFwoxTrm7upuGf2tA27buXsjGWPPoUgbZwuHMt6PUkQq5qSEEcHmkcojJebRtxdantH9RsOFPdK2Bj7xEMlDf1q7satz5OAHY4AY0c7spbjFFXHZayS6t+BDCdw9/IZ7mxCPyiJrHkje6tjglOKThqbv5bvL2agPxFaoiHM8LjTR3IwVKzF8hwg=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(70586007)(36756003)(2616005)(2906002)(47076005)(186003)(82740400003)(356005)(426003)(70206006)(6916009)(478600001)(7636003)(107886003)(4326008)(36906005)(1076003)(86362001)(83380400001)(26005)(36860700001)(316002)(8936002)(6666004)(82310400003)(5660300002)(16526019)(54906003)(7416002)(336012)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:03:36.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b2cf9-9d0c-45d5-c8a1-08d9030140a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the portion of __request_region() done whilst holding the
resource_lock into a separate function to allow callers to hold the
lock.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 kernel/resource.c | 52 +++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 736768587d2d..75f8da722497 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1181,31 +1181,16 @@ struct address_space *iomem_get_mapping(void)
 	return smp_load_acquire(&iomem_inode)->i_mapping;
 }
 
-/**
- * __request_region - create a new busy resource region
- * @parent: parent resource descriptor
- * @start: resource start address
- * @n: resource region size
- * @name: reserving caller's ID string
- * @flags: IO resource flags
- */
-struct resource * __request_region(struct resource *parent,
+static int __request_region_locked(struct resource *res, struct resource *parent,
 				   resource_size_t start, resource_size_t n,
 				   const char *name, int flags)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	struct resource *res = alloc_resource(GFP_KERNEL);
-	struct resource *orig_parent = parent;
-
-	if (!res)
-		return NULL;
 
 	res->name = name;
 	res->start = start;
 	res->end = start + n - 1;
 
-	write_lock(&resource_lock);
-
 	for (;;) {
 		struct resource *conflict;
 
@@ -1241,13 +1226,40 @@ struct resource * __request_region(struct resource *parent,
 			continue;
 		}
 		/* Uhhuh, that didn't work out.. */
-		free_resource(res);
-		res = NULL;
-		break;
+		return -EBUSY;
 	}
+
+	return 0;
+}
+
+/**
+ * __request_region - create a new busy resource region
+ * @parent: parent resource descriptor
+ * @start: resource start address
+ * @n: resource region size
+ * @name: reserving caller's ID string
+ * @flags: IO resource flags
+ */
+struct resource *__request_region(struct resource *parent,
+				  resource_size_t start, resource_size_t n,
+				  const char *name, int flags)
+{
+	struct resource *res = alloc_resource(GFP_KERNEL);
+	int ret;
+
+	if (!res)
+		return NULL;
+
+	write_lock(&resource_lock);
+	ret = __request_region_locked(res, parent, start, n, name, flags);
 	write_unlock(&resource_lock);
 
-	if (res && orig_parent == &iomem_resource)
+	if (ret) {
+		free_resource(res);
+		return NULL;
+	}
+
+	if (parent == &iomem_resource)
 		revoke_iomem(res);
 
 	return res;
-- 
2.20.1

