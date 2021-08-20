Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76553F27B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhHTHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:40:02 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:31456
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233162AbhHTHjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:39:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3xOucc6TCQYVAOaXPLQ38+CzDnGHlJ1fCRo7Gam82XKogXneJCls+yAbsEtJhkMzvK0S+4Sj/ShLxBxCINQOEdmBtfYbokVSgIZNnI36738yb/8l8lOeJydNkVhBq9Uy77plZkCEG+3DJRNFRMHnd0OyA8jFio7H9UvVTOZr/ObXRyw7jTCvKdhtDvBXACi8rkYYqHIkHkmnDa/3J5/2yFr/K3t261JLODP2OWfkNc5bmWPDUveeccm0VCJnxCqsq4szpGmEhVLCxBUZ2RNQDZ98w5BF0G0O7ifpiT795ANOPxDZROwD0uNp7F97TM/RUaNB5f8/YYHEpuarEXUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjo0/SL9vyf7SpqA9DWXbOVw4KTC7SCqLQIc3lG3SRs=;
 b=TddzQr7wq4GyYlw1XBnjkouosSokCMAoXRuoKTtNlNvxCttEYexs8JbuK+ffM55QiNqORKLw1OtEA9OVmnosBzBCm9oF9Re/bG0cZT+TC4t4xib1pgjp89/jslMrfM/cs8lyzH/H+stnv0nvYrCrQLvIIwubfmDL2dIy061TGeH/EhT81pTiqraO2p0X2BIDRHnAcGIcWzmlOFCGJMxrtHhL5MlS55+8G4t/8Od8Yq6Jmt2omY9Y1Dr2+jhf/j8iR6/VwcpwgVMq5pRujCVANXcEBosJHol8XsX9Dw0rKx4cy+oQ2mafnwf1XNAqS3ibJ/gfsi47uOf1e5ttrOBZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjo0/SL9vyf7SpqA9DWXbOVw4KTC7SCqLQIc3lG3SRs=;
 b=Y5o3LtBPZFD1k4Vlb0wy8SpmObmMiChk+Umd/uVWwdiBWvLMwfEe9OZ8TiGng0wmP5emWDGAGwmNo7iZKkh8tB9BCUZxk4tthzXRMMbNgTDvq0UxQzHBZWG09KMdirewdyQCL0SRNJ9aPpHS8jUE8+hgBrtMZh3uN8PTmuQRFFM=
Received: from BN9PR03CA0748.namprd03.prod.outlook.com (2603:10b6:408:110::33)
 by BYAPR02MB4648.namprd02.prod.outlook.com (2603:10b6:a03:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 07:39:08 +0000
Received: from BN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::c9) by BN9PR03CA0748.outlook.office365.com
 (2603:10b6:408:110::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 07:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT064.mail.protection.outlook.com (10.13.2.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 07:39:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 00:39:05 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 00:39:05 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.243] (port=34116 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1mGz7J-000Ae4-1w; Fri, 20 Aug 2021 00:39:05 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] clk: zynqmp: fix kernel doc
Date:   Fri, 20 Aug 2021 00:38:33 -0700
Message-ID: <1629445113-32649-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 004ba7fd-e3cb-4961-ade3-08d963ad982b
X-MS-TrafficTypeDiagnostic: BYAPR02MB4648:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4648CC8592B612EC029ED44CB7C19@BYAPR02MB4648.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8mSg04UY0o79bNXuUKZeK35Ec1Bc+J+tzO21V3dXZgOEe7GPTzw0OWQMprYQ4+HFD4gqW0AXrxKIERVRrWKoNkyPndp5dz5ZYuDQJQ7XolWqm41WDkAmfNiG3XsxlKGzORGkfYDM992QbQIhIZCIRwcWDCFca6ZUHCdudheKX3WNrqMsKEE0bdvh1PbkaMtXvuPphTvVHRGqjNhovQ0fPmNGcS8EhXjAcWBA8M9zv0DRGaaJ9k77lxE0JgqnQ/rSNPTgj8UVnM12OwaQWf6X9XiwsxIYCsiOVMMnjbuCEVtLu9CP91nME6GjIbI3cmfv/JUVTdeD7v3sQ8ompLsA835WP6b3KE3NLlmEfOLs2bwGw53Jwt3DeUF73RSRgn9SdxJTIg26VerWrd4jrGSpif/U6/QUMAdv5kmdjvGtbEHNEPj2WDHvGqcwA/naLSWwcqBumBefNRmxHGc/D3tQREMGR6ZXp6/G5yTgkOjHWN1seObMp3jGi7bN1WGdtPNEnnW2ZmR7HDMsQZGbjJ8Mb1fBhwgmbgcItbredh+ZnIVYladG6xHmogWAxIFE2uyJMHTqIy8W2WODNXYjfdwkk6d3pwKfeoRerM54CcSODboiNnr14l7ArdXDEjid9LLtMdAKbnmkKimDbqi4+ZX1pIkkaknyZnoc4gTF1dykWSCBsZS66XCFpu4uzF+9b+OW8Qnit58pPKZ+dNaGU62gihGuxojLgui7IzYAkk+P1k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(8936002)(8676002)(478600001)(82740400003)(4326008)(6636002)(107886003)(316002)(9786002)(70206006)(70586007)(356005)(7696005)(2616005)(44832011)(7636003)(336012)(4744005)(36860700001)(54906003)(5660300002)(6666004)(36756003)(110136005)(82310400003)(47076005)(426003)(186003)(83380400001)(2906002)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 07:39:08.1797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004ba7fd-e3cb-4961-ade3-08d963ad982b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing description of 'custom_type_flag' structure member.

Fixes: e605fa9c4a0c1218e5604b42bef59de0a3a4f813
       ("clk: zynqmp: Add support for custom type flags")

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
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

