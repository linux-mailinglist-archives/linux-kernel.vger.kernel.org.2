Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B54239E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbhJFIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:46:27 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:42465
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237543AbhJFIq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:46:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocVYZfCQFKI144xjnvXKDfTeobZkBsatUOX/7lgXt5qXhoSQd9iOXpPFYrXN6G3TbVmdEiamsiC2VmUESLTI0oqwDyt1PwXln9VCPtj1Efr7YQhxcm+S8fUTxL/xWa4VFF2GdC7z/uYjabD+qkx7pV3NaQbrDhK0Xr2Ycx6Uy0YOfSo+hCY4EfZ6cke/m6gwwp/U1cdyOIH5YL5q8QSwZoSIaRCY6CeWoMqm8aiOTehLzxoPy50FUvoUOYBn/iG5tjxnZayjVXLk1NnS1gmtm3URkRSkz/T0oSzkOkqkC5hYr7qnIJtS6fwh8E6Z0SvWjnquMhNmk+QUgWLTfxcC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgBrL3Sd+g61jz54ta9Fx3c71Wy+InYC8iUwows3FyY=;
 b=lNoFRw0x6fbX+Wiv+Jr4a2jAVxE1KeHUl+h/C14QujrynxiM2wg1MiUJMp5vLPl/ofaZmSVdU3FM1I83F4DnQYCzck7god42M87boyXNQC2PvsdrwdVuYgaiA8n0xUnFKr1mjJ7/no84YSxNo/DzBNZsPDP69BFDKj9wAT3hOPsy2JE/mcagb1DN2H1DjAWHuE2OG5PiNXDhhnEfpqDgaL7B2wt98tZc5t8lJatoLArPbMiV4yErs/juxoxuHlJdlj48qbJeNy66aSjj6ZQE5iLyXzhYDzt0WSrXokEkVOWYv8XAAYf184nLrDx/IdQ7lKO1ALGd9Hbe4c1ntCin5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgBrL3Sd+g61jz54ta9Fx3c71Wy+InYC8iUwows3FyY=;
 b=DRBRbF3A1/eHKmmbnQNfvXusZRGx1kn3Tq/kvacXmgVRnC96PzLkbZSxZx5IugK8WibPmct0MDHiMOMqLYXap5Edj1NRCuJwNRhTB/ukIi/N5alM3wfzjA3dNgygQZIF43fDrLVYfnRDnRZBy3DUmhGZyksgwVLL4RdcGVJOO8c=
Received: from CH2PR12CA0019.namprd12.prod.outlook.com (2603:10b6:610:57::29)
 by PH0PR02MB7784.namprd02.prod.outlook.com (2603:10b6:510:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 6 Oct
 2021 08:44:32 +0000
Received: from DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:610:57:cafe::db) by CH2PR12CA0019.outlook.office365.com
 (2603:10b6:610:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT031.mail.protection.outlook.com (10.13.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:44:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Oct 2021 01:44:27 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 6 Oct 2021 01:44:27 -0700
Envelope-to: gregkh@linuxfoundation.org,
 arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.243] (port=37526 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1mY2XG-0002N2-Nx; Wed, 06 Oct 2021 01:44:27 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <manish.narani@xilinx.com>,
        <nava.manne@xilinx.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] firmware: xilinx: check return value of zynqmp_pm_get_api_version()
Date:   Wed, 6 Oct 2021 01:43:55 -0700
Message-ID: <1633509835-31949-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76d88c4-669f-4b5e-9adc-08d988a58403
X-MS-TrafficTypeDiagnostic: PH0PR02MB7784:
X-Microsoft-Antispam-PRVS: <PH0PR02MB778433E074415F5D838056C0B7B09@PH0PR02MB7784.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duWL6eEbuddnGR4oPlXHyehiEVZWp52VOYcYj1RWB1+iojhyjlfg9Gk88yr3LYnNv9NdC6Dbyv3E0ZgDuPWu/oIXy4cs/3eiGaaphG8/mFRM8Mlg6d9kZVnaWCZBwKDq9N245nI+f8UZUw33TeJSkQdbub1EMbcXqfSiaZLH/FD/kiL5fwB3k3gI3hqdYv6j7gP5gzUZREpQn+Um9/OKAt+bvkkwmbAvcIbHqLpsvbJDfkHQ4361sBrPNcoiDcBF5eKPq4DzII1jzUe+Vt2mnVlfqsfEam8UHG97OzDSjNSptThRpZicNQyCI85yNN7km75yqq0uAhQH+tgRkvNjiWU36T+6eRe6Guu+tpXtQx20NeDfV5xxKhsYywoTUNBvOBiFK16hkxSRwnYWyR5lHTB/EV+bASLe1W4rrX/d3JZHlM+MiVvuDsykkC7xjyHcwZLy7GsZOiKgxOWSUnupbV0kUbHWIZEgBcMpxLKF+SZGOS6gLQHXwxbOfI/cJ7V93ds0TSVGvhj3BhDIF0l90won3/B2D4Q5qs9A9GsQpYwMkzNS1XezxbRioEOqWAzCj407SGKFIVNUoh1IRcnNCJYcrMr/RRh1QcT+365kITe35tAK4URMmnJnjPHeCe6SxOM8YMrNpXk4DmEYNXeWbebwNFJwEBZo69mI9lLwIZbfd0uPp3wjEJYawyYa9isVV+aofTdCY/hO7h2iySKFpAXLMs8ki3mfhuRykIlPX6Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(54906003)(7636003)(356005)(110136005)(82310400003)(9786002)(6636002)(36906005)(36860700001)(316002)(36756003)(44832011)(4326008)(508600001)(2616005)(426003)(336012)(186003)(2906002)(26005)(6666004)(8936002)(83380400001)(70206006)(47076005)(70586007)(8676002)(5660300002)(4744005)(7696005)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:44:31.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76d88c4-669f-4b5e-9adc-08d988a58403
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently return value of zynqmp_pm_get_api_version() is ignored.
Because of that, API version is checked in case of error also.
So add check for return value of zynqmp_pm_get_api_version().

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a3cadba..070197e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1371,7 +1371,10 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Check PM API version number */
-	zynqmp_pm_get_api_version(&pm_api_version);
+	ret = zynqmp_pm_get_api_version(&pm_api_version);
+	if (ret)
+		return ret;
+
 	if (pm_api_version < ZYNQMP_PM_VERSION) {
 		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
 		      __func__,
-- 
2.7.4

