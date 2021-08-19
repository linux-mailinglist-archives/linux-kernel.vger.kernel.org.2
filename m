Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08E53F2067
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhHSTLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:11:24 -0400
Received: from mail-bn8nam08on2089.outbound.protection.outlook.com ([40.107.100.89]:7585
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhHSTLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:11:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB3O/24lq7UQrjCOppdDTd45Nkb6/aaZRTAytmQ0NiBk/shpEegZXYpi20/vVTCDdZsaLr6z6PSjN1r5+uoyZkRHeHulkXnzLohgFQZ7+90HKyLRn3pmR3jJNjCy1+/JyVOIadUeekwZEvp+AwZLuSsyHt5TdO+ZHgyhdujZFymNj/GnedWidaQanI1hw84u+XqGXquQBL5HoW2Cyxt+D/SrJRfNhzOnD1JYyS4Zn57ZZxwnQ7z47hrJuCC2zv2rUSPD0Mpv77VyrtFq9xjtFxSMkrX8LRbGKBDyUcWF4hGB9ZmHBsac9lL7BhKNu7r1HJQ15sfrGRYID92MZi8ZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+MRdQWEcVXF/A9yoRQVPha1g1U1JtcUtSqLwrEmzhc=;
 b=SO03/xA9Bi/QDMVDZz1p5VSi+dY5s0trA33wl7k6LEGMVbYSoD+njMSqJRywzcnNIpK/ykOgRXZX2AdatVdx8qB2fPlJczQakarOzFXXRX5+zR9RsYumyqDz/smJXPqwn9o2vHiyMjDgwLJqO8oWrqwoNGrYqHZL+J9ohGqDCslfc4a81BiDj7Oi7+MTKM5qXm+lHttay7ivflhSVseIyg+9I5DZEM5EuVWL3IA3T9FuA6SXXgF1mO6ilNiIkhk37iFFnbJyd1YrhRhGlOAK3s/HktZ8IpXVIIj+dEZ8qD95TmZ/nuF4ydJvCZEliKuLcnw5GbQwbFzSDKvgufH13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+MRdQWEcVXF/A9yoRQVPha1g1U1JtcUtSqLwrEmzhc=;
 b=Qgsix+m43JHoyB9Aw045PfQtaEC9lYk3XhVqRC9VlbQqTEEMhfqW51QNRVPvXK/ZIU7q2YeTcTkAlZ+tyt+BsVq0zgBli4/MIKba5L0blCs6oqiTSaCWZJb0iAORKDbQHaixP1IaKLa2+Z22cA1JHyuX+tHMX5K0sNlCVT2UA9w=
Received: from BN6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:404:13e::25)
 by PH0PR02MB8391.namprd02.prod.outlook.com (2603:10b6:510:10a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 19:10:45 +0000
Received: from BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::f0) by BN6PR13CA0039.outlook.office365.com
 (2603:10b6:404:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend
 Transport; Thu, 19 Aug 2021 19:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT020.mail.protection.outlook.com (10.13.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 19:10:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 19 Aug 2021 12:10:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 19 Aug 2021 12:10:41 -0700
Envelope-to: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.34] (port=50028 helo=xsjdsteger51.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <daniel.steger@xilinx.com>)
        id 1mGnR3-0008NA-LU; Thu, 19 Aug 2021 12:10:41 -0700
From:   Daniel Steger <daniel.steger@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Daniel Steger <daniel.steger@xilinx.com>
Subject: [PATCH] fs: sysfs: do not remove files if group is null
Date:   Thu, 19 Aug 2021 12:10:20 -0700
Message-ID: <20210819191019.3380999-1-daniel.steger@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d205cd3e-494e-4f34-ffec-08d963450bb0
X-MS-TrafficTypeDiagnostic: PH0PR02MB8391:
X-Microsoft-Antispam-PRVS: <PH0PR02MB83910712C47F6BCD48E3847BC1C09@PH0PR02MB8391.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/bQYwRynOPhoEXOFt+/MFN2asDaNLLdDjmqX9m/PefWpKBvuAggF1XybF4FF+toPxD/5eHp3Y1WcfQ7Fr7Y9nwcMql/BcB1Fruxh3sD6sKjhD3LDgkfe40PL1l026NJr/RALv4z1rRwzt0MnFV6rmMw/yiJrgFbCwS2azRPInj1Uyh16G3TTQ+iDx29kjkldWuH3gqBMvbfvkH8AS9HtA42FgmApA0HzRRfdxBsw8gKw3znBCCUDDb67H9gpMhC0+EnwvjiD2fWzQlyF6w2eedpCPZUPtSiQckueib99MCnPvGYeauAu16OUmzmF4MX4d4wQdJJcfApwVXci65eD/bN/m/RE9hk/NwQpjpcKxtLi34k1d7dhDoEXsiV1KPCnLbWdYTy3xyIeFOxCxXM3XVOA8NuWOI2O7j+xQnm1lI7CN1dtGGxuAsJ94jApttGxRLmERJv+30/eY5gx87K4jhf4YJ/WRAH2H90bxBwVIbLutXc0N1oCRfBLtH4B+JuTtTioRYsRBq7k3meDnN6yAvgloHxKcc03xLgIHOi/h0DEF4KZC03mDhN1a5UHkC2R6MyQ6evv6va7tt1YtpqeLOb+hUV3JoVacqzLGgwxIiJ8y2cCpkBKUEdIplYBQFr2CGjE6xWy4anZ3vCZFBetO0arDd5qbvR5hBdmqsVaDz6JTs5ug9+AAW38AaDRj0I8XxMZGxGCn4LBKdhzgTrO+I3+NZEJ9XJg8JqiXud/JI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(5660300002)(1076003)(2616005)(336012)(4326008)(70586007)(316002)(186003)(478600001)(44832011)(26005)(47076005)(83380400001)(6666004)(82310400003)(426003)(9786002)(70206006)(2906002)(36860700001)(36756003)(7696005)(356005)(54906003)(36906005)(8936002)(7636003)(110136005)(107886003)(8676002)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 19:10:44.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d205cd3e-494e-4f34-ffec-08d963450bb0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation allows the remove_files() API to be
called without checking if the grp->name is null. Ensure that
the group name is valid prior to removing files.

This patch fixes a race condition where device_del() will cleanup
sysfs entries prior to device managed sysfs entries. This results
in a NULL group->name and a system error during device cleanup.

To reproduce the issue, simply create a new child device in a
platform driver of your choice. Add a sysfs file group using
devm API. On driver exist ensure to unregister your child device.
Do not call devm_device_remove_group() and leave it up to the
implementation to automatically clean up the files. Here is where
you will see a kernel error complaining that the files have already
been removed.

Signed-off-by: Daniel Steger <daniel.steger@xilinx.com>
---
 fs/sysfs/group.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 64e6a6698935..023b40840f36 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -286,9 +286,10 @@ void sysfs_remove_group(struct kobject *kobj,
 		kernfs_get(kn);
 	}
 
-	remove_files(kn, grp);
-	if (grp->name)
+	if (grp->name) {
+		remove_files(kn, grp);
 		kernfs_remove(kn);
+	}
 
 	kernfs_put(kn);
 }
-- 
2.25.1

