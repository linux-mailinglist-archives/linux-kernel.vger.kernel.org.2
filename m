Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30FB3B5961
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhF1HEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:04:38 -0400
Received: from mail-sn1anam02on2085.outbound.protection.outlook.com ([40.107.96.85]:24099
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232145AbhF1HEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:04:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El00aIL9N1zwFcUwEvAPmAzlb/woa9aNZc9g1allFSaQH159O0Sd6YRISAz9VXH2WTWCXgHncn31+ZEERYtm3Ra8ei9zI1IjxjCDwiCZE1k6AOwiN1dRFkKnyegvNVM4o6wkWVsYW3EE7ZpS4/FPPMIwJBEpVdBCj6WBXtOeZKh6xXrvUzsLqpfqXzaufLayFbAscle+cVTgpfGxWODEdedKwYUVkfrHC4IDkIFcNBV9qPmb0TFWNDz0ehlMTzbznwyhSpF4MRyPjnlXudPVBzowZ6B5XwW+Nn4XClPvzwYiU6v6kMuMCarWKLh4fk/0vB0Zop6XdTR/K5wTIg2VEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX45p+YI9dekv9xHeful0YERPMcz1oFE0qD9SEd03Bs=;
 b=DKiZL0U2HKqLYoIt1HRPDB4ZJZHTK3P7PAWyxRjP/aTsDpffkk/NYVOH6OXWEskgwgCHrJr80rjUQurkVg74PSxfPJbRbhfm37XgseLpuNTRecQ+MDvGV1DKlivHE8VHQdlsn/Me8qOUa3fWPENmzhpLnyr/20UyxtHXBFNzkmmreCTbt6/xzuOlH25NXmfSOdj82oo1oycioUQJzH+731JUk5+rEfrUikAgSLmrkaIAac6a/6XEL2vw6Zsv1lJyK0pEG3tpIRKELYIo8iQ+qgrO8o4qJ5XKRMb/qUlIsVfYRHoHSjW/XkcjtLbiqyMJYQtSLN0Dtll4O4JSD+BRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX45p+YI9dekv9xHeful0YERPMcz1oFE0qD9SEd03Bs=;
 b=aigawRrLd1AwOQ56m0VqR+XvJexkQAzywYgWO9TTit7Nb9nRy9VFJ5HQGUGAUVmHSaAqdklWBorbCm0192UksGFLTNOL5psk504BBMW6wKZPBkQgau6TJ3LPfkin6Hq/KV3dc70IvXBaaCrLnvivs4spqKw7p/7pt4e9ONJ5yok=
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 SJ0PR02MB7552.namprd02.prod.outlook.com (2603:10b6:a03:32d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Mon, 28 Jun 2021 07:02:05 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::29) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Mon, 28 Jun 2021 07:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 07:02:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 00:02:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 28 Jun 2021 00:02:03 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 lee.jones@linaro.org,
 kristo@kernel.org,
 quanyang.wang@windriver.com,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.91] (port=42476 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1lxlHP-0000Ik-6A; Mon, 28 Jun 2021 00:02:03 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v6 0/4] clk: zynqmp: Add firmware specific clock flags
Date:   Mon, 28 Jun 2021 00:01:18 -0700
Message-ID: <20210628070122.26217-1-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae23e061-439a-44b4-1796-08d93a02a37b
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7552:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7552B91CC62010FD44966B51B7039@SJ0PR02MB7552.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5pAYA1CIPqyDLT/yeR/FgM9mmU+aCMIgqVe3gUdLCOYPLZR9VN9otMAB6FO1Kvw5HQWxzAM3s1ZXEBDsfX7B70ZoWqPNanYyrMJOlKxoiasVcMm8Oc6fcFcEjfOliVX2EDIElM3vX9qfk+7ygA4b33DfBpj1wJFHYU8YJzHU1zqjp8zuVBgesVcj7wEftqYJhhgJMavqHfzcmEw+4MrpmrRFte4r9PFAbhESrjq+ME5rje9wT0izR/WzjG/zNFJvyCBq+eK6rg+eZWmc4JPLixlrZgSIjZcWHx9KMVxsqid9hGUY8mEqXI3YfWy43KfHVyaBKBvy9UGnq/LfqhPetsHPUJDbJp7jGxgZv2vjmtYgpIEFPs/+t6S6xxFNo1ec6A+Fopl04XxoP3G1aYfANM4rtJAR2PA5wGqaxNxV1xTYjAdpA8fO3xNy4b7UNScXM2PZ/j2gME6BDO801iJww3iZrHXFXDbMgNsa/LZ9Mhh/8p4JBEaaL1BgWn4PbWqniXbuK9wxagohWR/LizcmUk5kGCHMrWBevhIyfYv2sxNdi7iITP7xwiYMHQTuFqGg/DNwufIslslbDplFvR4cILR6saa2/tLrlXqIdwvaMW1nj9F7Lrf26SnpfQu4NlopjSHrOKViIsFWYYNF1CZZhP8FItjZJgN3XJI16GjkRGdZ1RRhtZEbO+mHj+tMmHZHBAH/03j5o94i2iBJI5MSAflzdTcXHu0W1yw4KeLjp0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(346002)(136003)(46966006)(36840700001)(186003)(82310400003)(36860700001)(83380400001)(44832011)(8676002)(47076005)(26005)(2616005)(8936002)(36906005)(1076003)(36756003)(9786002)(316002)(4326008)(54906003)(110136005)(7696005)(5660300002)(2906002)(356005)(7636003)(70586007)(70206006)(478600001)(82740400003)(6666004)(336012)(107886003)(426003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:02:05.5825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae23e061-439a-44b4-1796-08d93a02a37b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7552
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently firmware is maintaining CCF specific flags and provides to
CCF as it is. But CCF flag numbers may change and that shouldn't mean
that the firmware needs to change. The firmware should have its own
'flag number space' that is distinct from the common clk framework's
'flag number space'. So use firmware specific clock flags in ZynqMP
clock driver instead of CCF flags.

Changes in v6:
 - Removed flags not used by firmware

Changes in v5:
 - Added base commit
 - Added patch #4 to handle divider specific read only flag

Changes in v4:
 - Use if condition instead of ternary operator.

Changes in v3:
 - Modify helper function signature to map zynqmp (common)flags with CCF
 - Add helper function to map zynqmp (mux & divider)flags with CCF flags

Changes in v2:
 - Add helper function to map zynqmp (common)flags with CCF flags.
 - Mapped zynqmp clock flags with CCF flags from
   zynqmp_clk_register_*() functions instead of
   __zynqmp_clock_get_topology() which is changing the flags to struct
   clk_init_data instead of the struct clock_topology.

Rajan Vaja (4):
  clk: zynqmp: Use firmware specific common clock flags
  clk: zynqmp: Use firmware specific divider clock flags
  clk: zynqmp: Use firmware specific mux clock flags
  clk: zynqmp: Handle divider specific read only flag

 drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 ++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 27 +++++++++++++++++--
 drivers/clk/zynqmp/clk-zynqmp.h      | 33 +++++++++++++++++++++++
 drivers/clk/zynqmp/clkc.c            | 25 ++++++++++++++++-
 drivers/clk/zynqmp/divider.c         | 40 +++++++++++++++++++++++++---
 drivers/clk/zynqmp/pll.c             |  4 ++-
 6 files changed, 124 insertions(+), 9 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.32.0.93.g670b81a

