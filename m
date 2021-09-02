Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F13FEC24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbhIBKaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:30:35 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:60896
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233716AbhIBKad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqE6xZxYc5iZy1K9oX0yG8eL6cmeeq5uclDWt6zVLeblrVO4+U9IR4XRnyjELxC6yEo3k4OPvCJd5tnzq7DvmHyKA1QTYiK2DK3KdoxC8BNwFppvSj8viwa6zyQTFHr4R32JfMNz3CqIg5bDYVyKJMqRNuTK2PeuGKbq7vn3USwaXwiXizkVL6LhbjCd6yEcETdGlvyPpZkBhT7o7ruz0iqNhH7HDhXWpaRk/VmNVQxIbYTcc0/W9EecSa5ZiRDYx3zcu+t/WIp/Njfvz/TpBVT9KZy2nH2WhA0BcJA4I7x5nCnN/1NWWLZ/qmyV+p3/IRcEDmK+yGGFR2B9dcVPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd4FTylxWS484ovMLgvbBiw9oRJzc4Xj0EyjRyXjZTc=;
 b=Y8fx32ZQJbwyjcRtlZGicSCwD4b8eE4wXqlHsWXEQAOhEL1FIEVbl5MB+hHbfgouaQa4y9CNsbjrXsWEbQm0UpJqMFGT73HmEADI9daY1c2imzALnb63HCuyHrFzRGysnLujxY8Vs02FgPxnC0GGuQXvWlAx/LLB/qx3PIadl+KevKJyHrJOZ5eRNF7YNEpj905YHQYoD/+WTnDcTlsa3cBM7/JO/kALbw73M3XJhrf6fIRwhmCIrb0d/M6SDZfjeLc505+o8rwjHMPqzhrC6h9EHOb0bKExWD/gHgRFeHFD+AuNo9RxNFH4UNCRCs7isF+x2SZV8nHv5qzTgwWq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd4FTylxWS484ovMLgvbBiw9oRJzc4Xj0EyjRyXjZTc=;
 b=R1ZbMjxBhibTRF46FCEOZBJHR5RIuCLvV5Y58Orw+aa3m0UhBCvmZdkJcxrPYRpd/vku2vTNYskEeP4QiJ7xnUlAODrzyCGuBlzB8OBt1UCtJf9Ojy08JW2A2WH7NAJIGvKDkQOqWiCnoZH/qSeV7ifchbzkJrispZzc/G8mDEU=
Received: from BN6PR14CA0030.namprd14.prod.outlook.com (2603:10b6:404:13f::16)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Thu, 2 Sep 2021 10:29:34 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::dd) by BN6PR14CA0030.outlook.office365.com
 (2603:10b6:404:13f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Thu, 2 Sep 2021 10:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 10:29:34 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 05:29:32 -0500
From:   Nirmoy Das <nirmoy.das@amd.com>
To:     <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] debugfs: use IS_ERR to check for error
Date:   Thu, 2 Sep 2021 12:29:17 +0200
Message-ID: <20210902102917.2233-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ef5fc8e-b65e-4a25-af1a-08d96dfc8eab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:
X-Microsoft-Antispam-PRVS: <DM5PR12MB159455042DAB26B794403CE98BCE9@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJyGa5/cw7bZ61ab195JvAN3d1ENf8+HbbZ+hXILDOfPh0DZezhBUpGnZO2qh4wyRZrAMoUX4/eiIeUni4vGkENiVR7E1nwAI1OpHY6Nz/J8ntSMzjBzMLRjUrGa8YRk7nOj0tgxx20AP54xyNfCe3wjvrLbHycR/XmCZ37ySRTHZWDcmqgGSPtb3ZT/GDK8OUZtpoVwT1scL8r4odDk8wLMrWpYYGRRIX5AOENlGN+wZkcl6RqAcwpNvhOyGBssEMiqM9PVpBmX1Zibjy99bMaRchf56m+cOIq1yC1Gx0ScnjXVYEM8itgSYICSn3iDQr7n+QNMHhrO9VqH61H6/zCPyZtCd0TIuWUIMXnTC6wzMnVyrCwH5e4BMgqjMF5eTXZtjIxhslI+s6KrxFLd9eaXSkirkRPr/THa/hVgknSsMUrgBfI/+wuuFVlPpmgcqB4LYFRlVF1P3nxyB9BA3QZ2cV2VBn2uPGDeJC2Xg6Xb/2S+TzA/joOuUybl/VRvJ43aHPJn1boq4fOs0saCg3y7fg4IyJD3xpSzlnG6y6tuIxO1Sxyj15A+Gjtzdq6XDZGTFoXV7z6o965lV4m7TDzVfW3y3UNrWQQwB41e95UHeItQk+52zN9quunPsIGYnF7QTET79cgf9kW0BAZwkordslsyhgNOdPaaYxxR5Xk0VAyMcDayr9bNeZ0MjxDiKnxnIBT9DZh34cYz1cB/xx7985yaCNjDuz23kcFXOr4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(2906002)(4326008)(36860700001)(8676002)(81166007)(966005)(6666004)(356005)(8936002)(5660300002)(4744005)(70586007)(54906003)(426003)(336012)(70206006)(36756003)(2616005)(508600001)(7696005)(82310400003)(44832011)(16526019)(186003)(26005)(316002)(83380400001)(6916009)(86362001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 10:29:34.1998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef5fc8e-b65e-4a25-af1a-08d96dfc8eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() returns encoded error so
use IS_ERR for checking return value.

References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 8129a430d789..2f117c57160d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
 {
 	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
 
-	if (de)
+	if (!IS_ERR(de))
 		d_inode(de)->i_size = file_size;
 }
 EXPORT_SYMBOL_GPL(debugfs_create_file_size);
-- 
2.32.0

