Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D745D8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKYLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:10:47 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:63521
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230479AbhKYLJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsKLbtXMUqYOWRWqju3XGVWJArciGS62bkYeh4DXKgzUmlmeSp963cj3bg9LbZG8siU4i9jGFvw9dzBgKFZSPrMnUJrqxh/TO/m8qCstvmwpA6oJkC1yyEjIBO6thi9s4sLZ0uqb+LGcb29P4KlQt5FG+Y9dv2v2ewAywKZ+AeSSlj93olNndyyNHoUGBjPaJtrlnvmK4f17XQgLyGUckiR3kqprIIePPoHfgvnSiU5Hy9bkVOWXXiEymBvnfM7i6q3Ecmdp1ovtDb1DH3JJlQdEZMQi3Uf3gOhKrN8GRDXDfwKV9Yxq0o4k8mqL3lJJPlNwU1gO3pkG2/oqenuBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7KGFiD30k7y+U5gkqoqBPfIAYgYril7/G1Q1CuQWP0=;
 b=MlnYRwItmVRqTZltAwZcBJ7XA/ijwCyK3bQqRi1ZLlXvNQ3zzA8F2Z8sjvpILx5M1K0SLtxofyTfrKWstfQxZVX2VmJyxoQ/Wj1x2blAZJnZ2mZH6nJykb6I7a8zn6VEX+C6XfSzNv771iPT0XLHQJvCeUmIEQvb8spMEG6Wpt/cOKONxnQwM0dl8AboF3++2nWglPsw1CqjyUBrpDlE+DPvbJtMM5qa95GuPL7cLUE0hDhrIulDcYJQhVjX0aFN+hMHL1oVZInbSmnoEkKcEWWcssTKGB5B+Icwn+9+nYPBhyC7vWK5GRe+MLGxQvdINAnBZr1uh2z5QJfdp5yJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7KGFiD30k7y+U5gkqoqBPfIAYgYril7/G1Q1CuQWP0=;
 b=hzPuyiBizBLJ41g8ddDcinJwuY/8QV1duBMiFoMge7nFiG7bXJyhbfTvJshXoFvXWaYqOrr+BGB6oH8vVwm0wIPTvdHMRGXfR0dGi8FEZ0RLGiF+femUXd6GWoRxPG7lPBQiEqPJz5Clf6GbNaWTEI2/xJCkhtRbq7+mLU1Fq5w=
Received: from MWHPR21CA0044.namprd21.prod.outlook.com (2603:10b6:300:129::30)
 by BYAPR12MB3557.namprd12.prod.outlook.com (2603:10b6:a03:ad::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 11:06:28 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::c) by MWHPR21CA0044.outlook.office365.com
 (2603:10b6:300:129::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.8 via Frontend
 Transport; Thu, 25 Nov 2021 11:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:06:28 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:06:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 03:06:27 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 05:06:24 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/7] drivers: x86: clk-fch: Add 48MHz fixed clk support on Stoneyridge
Date:   Thu, 25 Nov 2021 16:34:47 +0530
Message-ID: <20211125110447.1188073-8-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99f5dbce-12ad-42e7-5a87-08d9b003a148
X-MS-TrafficTypeDiagnostic: BYAPR12MB3557:
X-Microsoft-Antispam-PRVS: <BYAPR12MB35575A5CE8397562CE2E298382629@BYAPR12MB3557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZb77NSccZ2VJjZ5rrxZJFYzvMzz2MVszzf2qJ4ZSNw3rfc5qln3okCoYZ7kVOC1AVW7gH5HkeGEzbumEVC4ucxZaXrGDORQ0P+zITIfpv1/USz4ObrufnOjRkXdi6Pz9xyrzuMryAjiZeYfhO0x4aHxvJB6PVFXkLMKmBRseZsHznn86I/zWZdfFDt0cuDQPor0KTIaYbL4B5p/S0K5YCV4rubsyQEToiVjDiJoElBnR2/n6rIRLQZ+sKs29hZHrr6r8kxOzpl0cKPeEuCAwYw/ol+z6yoxDRo8yHmxyWaLteV0jt7albtbSQOoDeV7l+larjYyId3qOcjrvItl8hFnmxf3PeISrgIG3NkOPQ5ZTBJmbB1cgZB0rXvcN5fvJmyfZwC7UTJQ52p42XsEc151oFHQjKgAgNVw+yPi877o+rdOoJAWTkjmCks+zCTBXRL04epVWOd7muvnjYoKVqIMTMd2P1MLa4+SIrPoUcYBLwpodx+AVhGGAisSGs0MD0492AmuOwHa6y1HNc0l9K2tPECpGP1vd+MEw2Gb2nKvH+gW/0YF7aKB3gHh3X5KIQrhrFE2XoUkcEWK2C1NgCoC0Yb1JxeKdRNcYA+K/HjFz+Oa99ma+t24sZtPF9Tm+L8hpFPgGa8TH4J+y2MNXZjePn6KnwM1Bgh2r0h/QivD23+ZWodj8/j11EH0EpkwgAAPyRzwKxN4twL331qnqQoO6k3HLqTGf/Vru7HSIz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(316002)(36860700001)(186003)(70586007)(70206006)(336012)(426003)(81166007)(356005)(2616005)(1076003)(4744005)(47076005)(508600001)(86362001)(5660300002)(6666004)(36756003)(8676002)(110136005)(54906003)(26005)(4326008)(2906002)(83380400001)(7696005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:06:28.5317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f5dbce-12ad-42e7-5a87-08d9b003a148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3557
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stoney ridge SOC pci root port id into pci_device_id table to
enable 48 MHz fixed fch clock support on Stoneyridge platforms.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/clk/x86/clk-fch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 8747212cd289..e3cd176a49e8 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -34,6 +34,7 @@
 /* List of supported CPU ids for fixed clk */
 #define AMD_CPU_ID_RV			0x15D0
 #define AMD_CPU_ID_RN			0x1630
+#define AMD_CPU_ID_ST			0x1576
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
@@ -41,6 +42,7 @@ static struct clk_hw *hws[ST_MAX_CLKS];
 static const struct pci_device_id fch_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RN) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_ST) },
 	{ }
 };
 
-- 
2.25.1

