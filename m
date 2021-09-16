Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5446940DA35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhIPMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:43:32 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:61249
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239707AbhIPMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itqiqDOFqFJx/9PPCVnXLA5nkiZFA81JXBvVl1+7cB+EAjYknN3pYPQAaHMmQ8eAksDG5OY7es4/aTfucpKUUtWc43Nn896jGnOg9SyrNhw2JSQ90OulLVIiicqyvK57N51HFNEI77wWyRqlhLh62FWX8H45SuQI541rm/Gd9TbatoLIXNGDQf2Qp+5ScUVpOHh60w6YdfGs7S+yojtoD9zzuKFb/TD6P2h9+I+Nq1hCfWPlZ603at+2cbr6S/g/F1XgzeOZYTedeR8/IYZdqEu7DtJdnyqrlwtED5cm9QjK0QG/G6yCGIDNgTGUYf7194Vn0msn88FfZPr3uf0Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xdb+d3JErbuqtyxphdnp4HDFMKU63gNcAZM6XhYtZUo=;
 b=NrUEa0n5S8M0qRJd/nWxKuMWozxQz5H70levZwK+f7PKafwkA6U671tl5pc78Yk/4B4INVFdBjPQJNspSaM0po18PkKoDJQtlzfinJ8gYkZ0MDGJeT7yR2bGV0ls2f0xJtDZuVT7zumdSjTa1cpaw/rTV6QxeWUXw9sgHXo3LVlhmEJaJuDQC/1pIChQJnqsVT7J44m9esvuNmBcrdP+8hk8JtrRoSbhf/prIOmq+3KpJBszrO9LVTAy2X0B5XEItlwVUVXdqm7oyP0jRjvZkMzk0LVNpQWr7OZZPNOvNDP4cKoa3CG4lr2PslVF69zipyQVHKFKPXJDIZFVo9eeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdb+d3JErbuqtyxphdnp4HDFMKU63gNcAZM6XhYtZUo=;
 b=KlIzKz2vdtK1oYtyc9iQU4rt1hwc8m3oZHInSdQ0iAe06aERl4tDH33DnLJNjLDijUZL5aMhBxuT2iA9aTNRAcr1LuRWgooklgl9JXgSbzYPYLo/UmBaMQNnpiODdLF1PRI5rEE8uly24KfEupD1lpoCE77WmFWkVtZrBNkCDmY=
Received: from BN7PR06CA0068.namprd06.prod.outlook.com (2603:10b6:408:34::45)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 12:42:07 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::45) by BN7PR06CA0068.outlook.office365.com
 (2603:10b6:408:34::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 12:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:42:07 +0000
Received: from Mayan-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 07:42:04 -0500
From:   Sanket Goswami <Sanket.Goswami@amd.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <mgross@linux.intel.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH] platform/x86: amd-pmc: Check s0i3 cycle status
Date:   Thu, 16 Sep 2021 18:11:30 +0530
Message-ID: <20210916124130.2581-1-Sanket.Goswami@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c50d0c3d-5cc1-443b-c0ad-08d9790f64ca
X-MS-TrafficTypeDiagnostic: CH2PR12MB4006:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40069E16034B3EEF461D07599CDC9@CH2PR12MB4006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kKw+zcht1/NbXhpDF4dFYUnpDl4lgGglEQuOhfS2ku6XZ68lWbIwqhSEsPaLDbEBPV/wVStTeqmWsAGmDDKS4SVeinI/QnYHP+lZKenk0LClb2fPK20BBDqTq0IF33Ync9LZBqzqLNndzzrKm5RqoHGDJa9ePCvclxtCVC4a2+nflFvux9WCIYA+SfpbZvcoRt1y61Wh85MKyiK/GfGTR5lH/FnC2PWlgJ/ogM76z5LqCqB3H3UAq1esWnMB70zxIJP9ollAnvfLhi53ffi8ppIAIQ8xw3raWnlVQL6bdZ93jUVh0J5be2i8yzPAKTVcf2D1V3o7xIDf84wwggg51EARK7+M/8CBqy9kM5iojGJoRcbil8xk+3ge769eqZ8FparUl5FmL4l5cEv34GFnvjlIRAiICVyxO/YkhJW9lHJStRGu1vML1rfltGSspOJVM3kj//YQ5nC3C8viGWjUtGDds8bRc8n7HJKmS8sCyQpbrA0RtfiCq/nvBo2xARtTXVUuD+XZ6lq1bsp+9FdimGxnMdhwFfHtevWJsCpKZ4rjauGVQU9SU6X0VFQ0Vtxhcv7w0KRVixAL13cauwRvvFsrq018iaWlSXQNC94LpLKVpf5nti6xVrGJ9CFDWxDyWT1NsjTP3Rg0gwHEtyNj9UVhgBujvBlEAgyh+6STyUi3VRLirtQdVN4Y8l++36vMvXz3U2WbcrrlcNLs8A/jCGBFHcwBm1GLONuThV3zK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(186003)(82310400003)(1076003)(356005)(86362001)(5660300002)(16526019)(47076005)(478600001)(82740400003)(26005)(8676002)(8936002)(36860700001)(4326008)(2906002)(83380400001)(54906003)(7696005)(2616005)(6666004)(110136005)(70586007)(70206006)(81166007)(426003)(36756003)(316002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:42:07.1685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d0c3d-5cc1-443b-c0ad-08d9790f64ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the PM firmware returns the status of the last s0i3 in the smu_metrics
structure, the existing name "s0i3_cyclecount" seems to be a misnomer.
Change it accordingly to "s0i3_last_entry_status".

Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 0c970f613e09..91c1f1c6c929 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -141,7 +141,7 @@ static inline void amd_pmc_reg_write(struct amd_pmc_dev *dev, int reg_offset, u3
 struct smu_metrics {
 	u32 table_version;
 	u32 hint_count;
-	u32 s0i3_cyclecount;
+	u32 s0i3_last_entry_status;
 	u32 timein_s0i2;
 	u64 timeentering_s0i3_lastcapture;
 	u64 timeentering_s0i3_totaltime;
@@ -170,7 +170,8 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
 	seq_puts(s, "\n=== SMU Statistics ===\n");
 	seq_printf(s, "Table Version: %d\n", table.table_version);
 	seq_printf(s, "Hint Count: %d\n", table.hint_count);
-	seq_printf(s, "S0i3 Cycle Count: %d\n", table.s0i3_cyclecount);
+	seq_printf(s, "Last S0i3 Status: %s\n", table.s0i3_last_entry_status ? "Success" :
+		   "Unknown/Fail");
 	seq_printf(s, "Time (in us) to S0i3: %lld\n", table.timeentering_s0i3_lastcapture);
 	seq_printf(s, "Time (in us) in S0i3: %lld\n", table.timein_s0i3_lastcapture);
 
-- 
2.25.1

