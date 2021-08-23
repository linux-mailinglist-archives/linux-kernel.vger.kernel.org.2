Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669FA3F4A51
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhHWMIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:08:05 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:63073
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233895AbhHWMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve1rBnjoPWIL3ANGW3+y/dEpBoU7w+ngbdOPnh6g6FDRfvdm3fYOPe973g4HAAOXs2NoYwUdneSeCFtAAR2IbOFBw4AOguPDgCd88SLPj7TkFYHtYiDlWzyddZRpPjJE2gorl/h3eOISJ5KqJ61yFjmQsDST5YZixPr2HsiVT+551WzAWLOyHF4OVBguVcC5RdvCucU5qEeHddOE9mgaZb1hK2YpNzs+GV5IWl38DUHh5EGWpVZGGlDT4ZYW0ev6QLKBpqvaYxTrs4TzFY9Hx72Y0a2QbNZL/COKWjdWXIuhAVxuaQ9Tt/+GLhfaVv/G6J7+wwOCIaV6DqhiP0Vrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEeuq4XvSh8qExXe+LVM0XZg1YqD9oL5YTVuwW9O3t4=;
 b=LNy18NSCSVSZev+wH3QQv0a8S0Y7MfKMwWKoQWwcx8nbDq+JInJJyymS6Rr08NgBgK7VKPJUgMi3n6DpZQ4yoHo2dhs/gGgF7aPSkBQtYO4Jj4bUBHRKKdmmVIPlJoVnHQKlcnaJXOXIDr7bVFi7ni/HzI4pCrEgG6Ac4v6/fosezvuj4nxXSzbApDYGvBBh1AZW8lZkprjFFHsOS/slftuiHdlNUwMsO62EI6d6mRomAoY2AwNHvLz4rMZGtjTf8lNm/qx2jXR+2DffJTpE4S7+327VjLYdidSpgFZiPvh6ZJ+Nb9JrikT3uSKQpnwITvVEI02wSQZGs5pQxlfmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEeuq4XvSh8qExXe+LVM0XZg1YqD9oL5YTVuwW9O3t4=;
 b=DD+J3LAE8WIoTY33iZZ7iFUOjB9+D9Rd8vVVf4kYY1QQooCrUJtl0bTLsvQNHbAVxEhVl2Llk2NpSPhrVQMvD+rsAzvrUfjf/k4WL/HZMaodEPUOtPOeDZBHPesiL6RFkuOrq8oV+z1tKx3uAMbRLecqZGA5lWBDPzqvy6W1LcU=
Received: from DM6PR04CA0026.namprd04.prod.outlook.com (2603:10b6:5:334::31)
 by DM6PR02MB5804.namprd02.prod.outlook.com (2603:10b6:5:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 12:07:19 +0000
Received: from DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::e5) by DM6PR04CA0026.outlook.office365.com
 (2603:10b6:5:334::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Mon, 23 Aug 2021 12:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT042.mail.protection.outlook.com (10.13.4.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 12:07:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 05:07:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 05:07:18 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.243] (port=36904 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1mI8jW-0008CE-MC; Mon, 23 Aug 2021 05:07:18 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3] clk: zynqmp: fix kernel doc
Date:   Mon, 23 Aug 2021 05:07:13 -0700
Message-ID: <1629720433-19019-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629446294-1056-1-git-send-email-rajan.vaja@xilinx.com>
References: <1629446294-1056-1-git-send-email-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1ffb86-42f1-4cac-9cd9-08d9662e8e7e
X-MS-TrafficTypeDiagnostic: DM6PR02MB5804:
X-Microsoft-Antispam-PRVS: <DM6PR02MB580455D7A04B1E304E3FA1E3B7C49@DM6PR02MB5804.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onmxo4OH1jQcLS7s3IEre6/a/d1WUIGOWCO3d7mIC5E5Rj3w2PoP12devQEOLhWhsiIIvjOa6Dk4Xw+cLP0vOk79Y9wpmacKasxYEUYCnB2lzK7ATHN11ym0q2gfWS7K4jxJoDkuOUzD+bqXOT3EJhBqDNa4UPgAjyq0jMsjU+xY++XHUL9++MHXSLTEDqVpPKRa6w9CLcB3LXqwBD0ctOxUnXEGNrwYwjwW9Iyktqf7Vsgp1CdsIy8an+SCz+EuCuCt2bGVxfJ7SZBnhOIZYbNjT6lbPP27AIP9JYHqk6hJmfAgMMp/ImfBBrHyov/v2Psmkg1MO+m4TUp1WzCGcvvpVzq3YgX0a+xZ4db6RY82du6T5JGVagK8QsOCaGqvTbPmw8zJZqH1QaeSg9pdTaRndfqDQTjB+FMA1CrROe/90UR1SFSDkQj+Jm8FbRpL4jmxOqAt9uiUnXOcM78uN3YY+t+A20AfVNLkotGxRuHHa2YZ/85uLxPMJM8e37fwr/NrzccO+5PVQm+DNNvpszR6ZAmNKDoaLK9wAbaAtORyeNQSjc1tEJBiAIGmch6HuLjb8cvDt5IbhwcEtbhZ0tsevJeoYX36teFjjTnXeHvQ5qPsG5u3RwFssnMySyd0Uv7d1jIITnMd17K2oxonlhrAvS8ufGI+fMiSMO92nbXBXb1oQ4cbqjvIKltfCkE4ERhym9DYU2jhUM4czC3fBDco28ZxlLRXgVUnNoNuwgk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7696005)(2906002)(9786002)(26005)(6636002)(70586007)(508600001)(70206006)(44832011)(2616005)(110136005)(54906003)(36906005)(107886003)(4326008)(316002)(5660300002)(8676002)(8936002)(47076005)(426003)(336012)(36756003)(7636003)(356005)(4744005)(186003)(83380400001)(6666004)(82310400003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 12:07:19.3927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1ffb86-42f1-4cac-9cd9-08d9662e8e7e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5804
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing description of 'custom_type_flag' structure member.

Fixes: e605fa9c4a0c ("clk: zynqmp: Add support for custom type flags")

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
Changes in v3:
 - Fixed typo in description of 'custom_type_flag' structure member.
Changes in v2:
 - Updated Fixes tag.
---
 drivers/clk/zynqmp/clk-zynqmp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
index 84fa80a..60cbc06 100644
--- a/drivers/clk/zynqmp/clk-zynqmp.h
+++ b/drivers/clk/zynqmp/clk-zynqmp.h
@@ -56,6 +56,7 @@ enum topology_type {
  * @type:	Type of topology
  * @flag:	Topology flags
  * @type_flag:	Topology type specific flag
+ * @custom_type_flag: Topology type specific custom flag
  */
 struct clock_topology {
 	u32 type;
-- 
2.7.4

