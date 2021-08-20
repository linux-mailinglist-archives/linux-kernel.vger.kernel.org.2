Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7ED3F2802
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhHTH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:59:16 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:42016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232029AbhHTH7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9bYFZS0akzwxkNVQeFAP24Cuyc+O/c13FXk2uRCj5ZmASHJT/8BDUnRjb/ZNC9uHSdG0YqtRL2YpHjcO169oP4ZXJyOX9mWgKUcei3q6z1PkCTZ+JJNu0OsOoRiEDELgeKukU8cfIHU1iy7fmoNYv/HvRcai3Q5KccWzsrCW8WeLg8RBbh5NHZALvBtI0b0HnNwmtDcNsV8skrLXhR/u1xxMjGfmaP2M/p7ZG8x4GUbwCnDJ+BnRLaC0E6yhTvOB01Rl2y2zvhRlJwayqFgEqWe2SmAqXPzJRatSHpMoYRUmVZpKFDDL1GTtPxHo7/UoIRD3hY4s5kd3SE+l80Ttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJSTgjN8x/bA55zoZniNxXfxSFe3Uy9t1k9Buv6p9JU=;
 b=GAo+584W1skCVOPSyBCFKyjC//Z60S1JeWSJzB65/ticrgnABzv8xuVgfOyAglTtF3JOxd3cLXf4+WTtX4coWjcmVVUUXzJ+C7Bs4Nb4Q2jKo6Ck4lEhO5TRK4zi4HyrwZv0/uy7xZLWkd3FEbqmRgjZQyyROSrDk4hdU4Xg8DSqsdodIuQe/43M/vWFshd5rj4pmzQlwwR86GdzLpDBbGpry2rpCxdchLNRBIMPFyTk77qNw6gKkb1M0YIlvNSVghTwMm7OdPtxZokgkAe5Lp26suBiCfTpgh/9ghXKSAzVwEnUD4Ozq97rzkIId9GXw8DRUCIAcc9LwTxjvMMtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJSTgjN8x/bA55zoZniNxXfxSFe3Uy9t1k9Buv6p9JU=;
 b=Gwcf5vK6lWx9ffWj7KIXsri6f37Ep17LOZzrkgEXuW8DzIZWukt03YdytfC0isgKCjbzst7w+sVsXUwUhHIRml+2Sojh5jhyMtnuC3ic/YOHxx5g8W1g3I8njeJG5f0eGhY1fnNuY6W2t2HN4zpwFn9oAy7+fGTGxeJP0d/eB4E=
Received: from SA0PR11CA0157.namprd11.prod.outlook.com (2603:10b6:806:1bb::12)
 by BN0PR02MB7965.namprd02.prod.outlook.com (2603:10b6:408:166::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:58:31 +0000
Received: from SN1NAM02FT0007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bb:cafe::54) by SA0PR11CA0157.outlook.office365.com
 (2603:10b6:806:1bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 07:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0007.mail.protection.outlook.com (10.97.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 07:58:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 00:58:29 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 00:58:29 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.243] (port=34136 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1mGzQ5-000Cbo-3l; Fri, 20 Aug 2021 00:58:29 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v2] clk: zynqmp: fix kernel doc
Date:   Fri, 20 Aug 2021 00:58:14 -0700
Message-ID: <1629446294-1056-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629445113-32649-1-git-send-email-rajan.vaja@xilinx.com>
References: <1629445113-32649-1-git-send-email-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72fb103b-d037-4cd5-0157-08d963b04ce8
X-MS-TrafficTypeDiagnostic: BN0PR02MB7965:
X-Microsoft-Antispam-PRVS: <BN0PR02MB7965994CF0814A83B8F58554B7C19@BN0PR02MB7965.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgQZ3oBCFXQIaD6r42DrhNzc1pg2i1cua1kw8pUDQ5p91N3ZggaYDZ7NQzH5wwgN3mZVotHilQw97gx795lJ8B7ObXCKqRpMnlYcc0p6x91DSm8+LR2ZNclWDQo90YU3j3QkcFujTi017QYA+Te4UuZ75nLQWp9Qvwwf4uOFTYVolmdFLdW/P1zeDMsVw7KR9anm5N4Oh7xpO7QWrxr2ixRl5bnZWxDKm9NkwGl3yMi3bxA79woBw0ekyou1XrEyxd28gtXS5tzG2TnOGj0Tl3FL3y7Cv9XTo7Y0mS7UM7zUpSHYDCVmhUErfpAb8PaExN90pi5c4ZzfTaYpjgnae8EIdYa2R5b2IYUK/ruAt6NE7MTLiQsDMFlUt+8ajtJ/egX4ePB+TnQ6ERm4DBMduR17mej6Ao7JllQm9iHcAD7jVLDh4PQlB60pu9k5/vispCRKE6VHakf7Jl/DRSR8oVY4ubyVz3X9PbbiUkRC2P3fLpw0GlBDiEbVD6eKVmQzLPfws3d+HB9NWA6crQQOdqnzEqFms8eCusX71RgLOzE7PZaOcO9unx0cKtOeZ1uK/YcrnlAv8io5oTBmlBcGd6jX1bwWK7OD+KR6E/wo3Gb7fDP9FkT1b+ybZZyDigEUHsnLLMwCT5Bd50np33hCeWlmKeweNcKcwM7nWqtY501BWNo/ppcd6XOiBkFlSriRP+6b+IVVwqJU/rR0MO3/FZwN2m0phYEC97qXR4/HY3c=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(36840700001)(46966006)(7636003)(47076005)(8936002)(9786002)(316002)(82740400003)(356005)(26005)(6636002)(336012)(426003)(36860700001)(107886003)(7696005)(5660300002)(6666004)(4326008)(4744005)(70206006)(186003)(8676002)(54906003)(478600001)(2616005)(70586007)(82310400003)(83380400001)(110136005)(44832011)(2906002)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 07:58:30.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fb103b-d037-4cd5-0157-08d963b04ce8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing description of 'custom_type_flag' structure member.

Fixes: e605fa9c4a0c ("clk: zynqmp: Add support for custom type flags")

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
Changes in v2:
 - Updated Fixes tag.
---
 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index 84fa80a..a3cd2f8 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -56,6 +56,7 @@ enum topology_type {
  * @type:	Type of topology
  * @flag:	Topology flags
  * @type_flag:	Topology type specific flag
+ * @custom_type_flag: Topology type specific custome flag
  */
 struct clock_topology {
 	u32 type;
-- 
2.7.4

