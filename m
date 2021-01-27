Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE27F305044
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhA0Dxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:53:38 -0500
Received: from mail-eopbgr760070.outbound.protection.outlook.com ([40.107.76.70]:23533
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404911AbhA0BaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:30:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LamAIpd4olct6ZULcrfx56ZJYF4hTajbl8YuMN9ham+ZO8OVhuo3oqME7f/r7CsBx0EtHjmGFC/fRmwQvPdlxOPv9d2qjmuHtXjTQwKK+mkC+NNb249mxa8BX1ZAL5h3DjYAA39JwQPykzvPCmsCPZFv3BQ5s3m9UE4Uw3uOcyWhJ+sr/dXHpce/IhBvbqTIiTkvByLMjgrX21DAR4Yggt6c8grmllf9gka39TOUV6FUTIUaxSdrNnQzHOPsLaxk3pTS75T0PxEOtKXiPqv9BqBEh8xJEQ9mdE0kljq7bgeyML6cB6jw3YTPI3PTc8Tqglbsr/QBMFTqZSEgUz0kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I87kc3mj7645BgE8M0ifoVgcLy0IIT22jbUC6q1gYyM=;
 b=YXr8FzPPrDz0RgDpLCjQWuCL49ljqRtcL3hos3eck1gwQlwU2VAH2XjJESyoyJssqp4SskRDoCggqIWK+wHUdanSBVPunmzpMvgsI1DBZrZUIFMGe3e9xeglWLWZGffa8THMWs1yWgwomjvX/YwAUwu8XLbqvw9JXbQzmZ+a4TwHctgHk36PTdlsv8deaYz8sglLy3WrwYS7Bgpx1oaTRgrfldCEVvFFm9L/YMDR5m1rprCtsZ3pdjuoBcaTu8QL2nBul8cS26X212Hnr4px+WBUN6QgUHVFyOFv5QfIn+kaBiSbA/UfE0rJRQPxLJJBWxd9O91ZoosnlVjxEJcICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I87kc3mj7645BgE8M0ifoVgcLy0IIT22jbUC6q1gYyM=;
 b=s65svsD8DLEg2u9XAdoXhAdDCCrFrrOpTf98K9wGAsxGnTnyWEAdCBx1NeTTyPF7r/aFWfOJfjTOndtmVV1w4mOScJH7c0EKUYt7MU8JzYOW4RwpMajsEowid0VfydxUeGB8AwTO5U4fO1HQnncoBOmRuznC6oULObEwV62vH4A=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 SA2PR02MB7546.namprd02.prod.outlook.com (2603:10b6:806:144::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.16; Wed, 27 Jan 2021 01:12:42 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::c1) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Wed, 27 Jan 2021 01:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 27 Jan 2021 01:12:40 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 26 Jan 2021 17:12:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 26 Jan 2021 17:12:38 -0800
Envelope-to: hyun.kwon@xilinx.com,
 michal.simek@xilinx.com,
 laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.244] (port=42446 helo=xsjhyunkubuntu)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1l4ZNu-0003Ny-Lw; Tue, 26 Jan 2021 17:12:38 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
        id A7A2C2C7AA5; Tue, 26 Jan 2021 17:13:15 -0800 (PST)
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 1/1] MAINTAINERS: remove myself from the list
Date:   Tue, 26 Jan 2021 17:13:12 -0800
Message-ID: <20210127011312.697159-1-hyun.kwon@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20aa56b2-91de-466e-61c1-08d8c260a47c
X-MS-TrafficTypeDiagnostic: SA2PR02MB7546:
X-Microsoft-Antispam-PRVS: <SA2PR02MB7546D5AB6EE64FF5C362EE61D6BB9@SA2PR02MB7546.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9v02zf0GXc+7Yt42p54seodLuYBqlw29ScezG2+tvh51wzLOWm4ehwZby2RLq2IXz70F1Zd2UP9Trd6Xi9N8dnJU+vPrd4Jjh5mWynhBzxc96Cvb7zH3jHUUHKcfnWYIc1s081in6/quVmv3ImJdfcsmf4Zu9of5sPgne/Pa8wL8rnS2q2i6wVzIvOqls3b2vN7q6oD8GxpX7YKlfausp2V7RaMePTE3gO59Zx/F5hFM/nkYk6ghk56rW0owic01J3AwcGlV41wpW87paMc7mYhDE2pcTGA8IOOT+vndFO6jbLvEBWqC6pcJY6r5IO+wp0N1NTMynZm9CkYu4WThAkv5mX7ewCaiPMTpDX8qYiMKbhbx/je/Fozv7caiFAkwoiTiSC/cvmqQ9JD2Mjpp+O5i5U5cKuNlLUm4Izo0/ixy5i/eTtAwb6jvISX0rZeYDkwncHJ0herM6p8GttNRg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(42186006)(4326008)(8936002)(5660300002)(2616005)(82310400003)(44832011)(36756003)(70206006)(8676002)(6266002)(47076005)(2906002)(1076003)(83380400001)(186003)(107886003)(6916009)(356005)(6666004)(82740400003)(26005)(426003)(336012)(70586007)(36906005)(316002)(7636003)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 01:12:40.4550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aa56b2-91de-466e-61c1-08d8c260a47c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The email will become invalid soon.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 992fe3b0900a..4fc00c2da56d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6048,7 +6048,6 @@ F:	Documentation/gpu/xen-front.rst
 F:	drivers/gpu/drm/xen/
 
 DRM DRIVERS FOR XILINX
-M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
@@ -19577,7 +19576,6 @@ S:	Maintained
 F:	drivers/tty/serial/uartlite.c
 
 XILINX VIDEO IP CORES
-M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
@@ -19587,7 +19585,6 @@ F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
 XILINX ZYNQMP DPDMA DRIVER
-M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
-- 
2.25.1

