Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5743AB46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhJZE16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:27:58 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:29568
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231164AbhJZE14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0luwA7imLhqEcRB+NKzSK78BuKj3vUYAHjzYC8WSxImb/X4SO8VSFoptLQ3Oz07dZ4nGcW0ypS8T5oMJedFQqNAuobSle0vkHza2gC2OzFxhYfmByui5omqLjRRQgo3VmaYJ4HbwfL5rWuab9JXcQNC+eXJmILtzW2ql4Hcm8rqB/fnIG7LUfeZI/nRgMSlT+tk7cEcfeB8EyrQcwohWTf8W5zTyorAt3eOpGRIhTsMT2BSdDkj8QKBfW6ERu9p4ImAqvDGX2xLv1WEEnVJajxPpr9jJCUwFW3g5E6Y2kDwSq5+QxpyyyUBtYF1KwlwEf5ycLQCOuRksGlypb0LdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujM2tRCUufM5idGxCIPw/i4tSqQJwnU4kSsuMxfA/M4=;
 b=Qod4W8nOfLaf/21u1jnf/MaoJGbV19m/xOxgqJhzE7c0BfB4LE3gK8cjeGTCSD39OPZjdpvUrHSkuEvbebUgKpme1rRSNSmu9VJqaCliuFTlQMWdnNXcOrOP7OEwEwtmI4GhjlvuRgTlziv0JkSGc9Pcf8VZNVbO/9rXVkAphVnKaeO3fGPCE6U7eAmaMb/UqCystito0MDhCLLX89284e8M0YeTV96AQ5jbka55mWrdvZ1OkpWDasXXogoaoYPA9UoRS9VUIvmCDmw2ewUlwE6hNnLela8VssOBc+0kF/HlBpkAScgR3F1PdWepAAIXGsehXsWRv1hH1sTVl9JnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujM2tRCUufM5idGxCIPw/i4tSqQJwnU4kSsuMxfA/M4=;
 b=Pum4c78TaDKezwhhR0c4LH/QdYZPUJnTCUElr734DaSbJsByiziHl+ZfH7IjJEkQmvVwATPktDWBIGHqb1tbQ1dc3ROT93LFBDZbSAwYp2nDL+R5qwwdcfYCdqDvDKvDH12yhqefXC2C13Mew8uqVsaL5ruGaIprg2+cFw1gYbA=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 BYAPR02MB5816.namprd02.prod.outlook.com (2603:10b6:a03:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 04:25:31 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::76) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Tue, 26 Oct 2021 04:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT025.mail.protection.outlook.com (10.13.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 04:25:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 21:25:30 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 21:25:30 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37440 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mfE1i-0006GH-P2; Mon, 25 Oct 2021 21:25:30 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 0/6] Add Xilinx Event Management Driver
Date:   Mon, 25 Oct 2021 21:25:19 -0700
Message-ID: <20211026042525.26612-1-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
References: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963c73e8-8c64-4d2e-eceb-08d99838a5ac
X-MS-TrafficTypeDiagnostic: BYAPR02MB5816:
X-Microsoft-Antispam-PRVS: <BYAPR02MB58167FAF96AC6CD3AF0D35C4A1849@BYAPR02MB5816.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWy6YLM5PkuJfgcYib4VKVDgBxOdWqcRHFiA4TuPNqlrOCR6sKHa0Z5Pnns+TFWk1HCJKw5H4nasEQuiFhAz7hsDNjDkOby3oGpqF49cBV9qQyfhZYUWOBSq9agljNdjLYeErhVV6nzMciOwtZfNErJo+F80rm38JAGuOYrBBZ+f2ykiEpfi8iqLiCUjgwTPKwe9wf8BrWQzt4D05l13N7JPHG7mEvb32WBH0Z3ySZ9zRmRnYeenG/PnC4BRXQBOx6+axl+rSDKB0qt4a1GGg7cGeYDnN4Y2pRzH+o9eLonrjN3zWhYNtdpb5HkieMevBKznIsuOvqvgBd+QB6LJ8ctAsLth+oldEE/1iqcXc5hX6sMSin8f/a1m2noKmDmhSm591ijqAq1c71synjk0L+MdFRDWsePSTAYa8TyRXyEuDJpEXONEkEKumjRa3rFQdX5ibRfLbonoJEg1n9gJYsvQ0ToEHzkLkIj296dKk+m2MLBfzCuYOPSNvtBqyrD5lA/fdczi+93TmlytfRsUFU4Nl7ejSn/hgM3KcH32R5XT5q2F5ZRNBt+guRbs1jRopri4pLbObV4UCM0hJKxXavRpeNoenE7yh7ml6bQiyq+KoaqO8fN3PQalNW4IwgcMJ2qKTPI4lthtF8q/MFOWeQGAgJyjYAZyvrAnQSSK3fe/jh+VFmqojcEwi0u7X9R8vtVSxCnWvIY2AuSJDSittD1G86HNV7Td6iPyeUCBKZk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(8936002)(47076005)(7696005)(426003)(82310400003)(36906005)(70586007)(8676002)(70206006)(4326008)(44832011)(36756003)(508600001)(6666004)(2616005)(26005)(1076003)(2906002)(336012)(54906003)(5660300002)(7636003)(186003)(316002)(6916009)(83380400001)(36860700001)(356005)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:25:31.3880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963c73e8-8c64-4d2e-eceb-08d99838a5ac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5816
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Linux driver provides support to subscribe error/event notification
and receive notification from firmware for error/event and forward event
notification to subscribed driver via registered callback.

All types of events like power and error will be handled from single place
as part of event management driver.

Changes in v7:
- Update the cover letter and version history.

Changes in v6:
- Fix compilation issue that come due to force merge during rebase.

Changes in v5:
- None.

Changes in v4:
- Rebase on latest tree.

Changes in v3:
- Update the commit message.

Changes in v2:
- Removed updated copyright year from unchanged files.
- make sgi_num as module parameter for event management driver.
- Use same object for error detection and printing.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Abhyuday Godhasara (6):
  firmware: xilinx: add register notifier in zynqmp firmware
  firmware: xilinx: add macros of node ids for error event
  firmware: xilinx: export the feature check of zynqmp firmware
  drivers: soc: xilinx: add xilinx event management driver
  firmware: xilinx: instantiate xilinx event manager driver
  driver: soc: xilinx: register for power events in zynqmp power driver

 MAINTAINERS                                 |   6 +
 drivers/firmware/xilinx/zynqmp.c            |  40 +-
 drivers/soc/xilinx/Kconfig                  |  10 +
 drivers/soc/xilinx/Makefile                 |   1 +
 drivers/soc/xilinx/xlnx_event_manager.c     | 600 ++++++++++++++++++++
 drivers/soc/xilinx/zynqmp_power.c           |  54 +-
 include/linux/firmware/xlnx-event-manager.h |  36 ++
 include/linux/firmware/xlnx-zynqmp.h        |  33 +-
 8 files changed, 771 insertions(+), 9 deletions(-)
 create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
 create mode 100644 include/linux/firmware/xlnx-event-manager.h

-- 
2.32.0.93.g670b81a

