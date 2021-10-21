Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217E436354
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhJUNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:49:30 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:25682
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231182AbhJUNtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:49:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiTkPAsIrGo2rC7mw6YsyRihTYSCINOT0aotBB64Ss4hweTu+7A7ID0Vvg0/ONEzuUnYfMf0wPTf572jNvdCJ2tRzkDq3kRG+iqeT3bQQmWWLTpR3Snn0mCBgFo+y6PTN0je5tUhDo8kxG2ZBBbJFidp6Eo+2CrIqRxtKv8JMpOcEt4J4oAqj/HQTAvvD04nFUegKqQAidu3n20vFAbzs5U//53gSGmRA2//eTo3xs8720UGnVVkWo7vJsQzgC+A4pdAZ26jCsN4kwuNmeQ+ibyKUw2C/utAqkyVzFfz3Ic2+XZ0vnMREq5OkOl1StsV37NYFPtPdgapvgrPrwRnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfTQeWAR5wpRIrOvclktg2C0nGsRTx36moXWz4mACO0=;
 b=mzJNwNTndIsVgyaQKVDzYl5UeG8kepgIEBTGnRM8IaTlIV9x5rZ5B8c7XxoLUiRBu7jRorBYu6eeSw6KCWHPNw5NouhIjQAo0uPZpH3NBW7I8JQm4UUlESbQVM6F/qaORbk5uet4lkV3jqnYZMkh/cVlmlXN5aZn5L45XbzAdLfGd3VcxtU9jNcmb3L19XokTF9xG5lx2NAtKyKRpme9bDWN8s8VguJDHVDIUAdBq68ovSpAi/Q2jL2I2WwtvIOVX3aDEP5Yxwn0+z+zCQfwZJMT5Y1kP2JXNypUTKF195KSl6dVdpYKAkjlnql4xz6rlgtxUMaUwzOx1fwXeiX9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfTQeWAR5wpRIrOvclktg2C0nGsRTx36moXWz4mACO0=;
 b=jUnL2SWpbaF7eQ6Fn8zIjosNYscEAcOlKhz0wH3wVPWMX8l+ZNvEtyrHAkCUl+SG77g7TY1NT7PfJ3X31MUoIdKwaXTBCsQI5cWXbIFwtrM1k72ACeNwkpBanuuepkawtBM49JYXG54BTRZy8xBGhPpGGaQpq7KlEIaWxlKS78c=
Received: from DM5PR07CA0096.namprd07.prod.outlook.com (2603:10b6:4:ae::25) by
 DM6PR02MB4028.namprd02.prod.outlook.com (2603:10b6:5:96::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Thu, 21 Oct 2021 13:46:57 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::e0) by DM5PR07CA0096.outlook.office365.com
 (2603:10b6:4:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 13:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT034.mail.protection.outlook.com (10.13.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 13:46:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 21 Oct 2021 06:46:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 21 Oct 2021 06:46:53 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=56784 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mdYPF-0006R3-SF; Thu, 21 Oct 2021 06:46:53 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/6] Add Xilinx Event Management Driver
Date:   Thu, 21 Oct 2021 06:46:38 -0700
Message-ID: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ec2b7c4-9139-4d11-4044-08d994993fbf
X-MS-TrafficTypeDiagnostic: DM6PR02MB4028:
X-Microsoft-Antispam-PRVS: <DM6PR02MB402895EF21EBFCBEF06502A4A1BF9@DM6PR02MB4028.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy6UvjzCGJE6EzwEu3gynXKfJ5jOV9Vl1dljZxOnRu9EKuqa+dQoXcSF405CiiW+RLwRrTm7Ow5HkiOmRUqAoQdMZeYb7lrzYHHCO/3eVQT9S0j6OVi87AKfzqWOgoQmAVs1IQE7CMLz0Le7EgBB31cOYdFI9dwNoojtYKJjrPDm/RCuXvjuQNZ95sf7KxMWe6c5FVtgjudLWUgnZVgDmMdAgncB0mKqNm+vpSz7ZfBJ5fZgf4FIT53oothlSR09S4xMNPntL44nrUEdblzT+dAG7qpuM/zWsUw5hz1yMhYYzRiGahb/ZlFly3Z8fTHXA5tj/n9uoZ0gUK1RYTUyNf7H6ZRS/f6dYaS4QOhlhZJmPo1VCxJB38czB3at9bQTM+2VJiBBBst2ZBivvqchd+G2/DqhuVuhLfqdb3aF+fPKDpNPQ4mIa6MXzQTnq9prrV6DwovKoKlUpE4aRMxnj7sgtVlzZOQYx+2+HZs2WC56xFFMHiF9kJGiLSnsU4Mf4Fo3q+vVqjl2siZI+ft2+Lf26UURsrKrYSty1rCdFE4dS4ixEwT1H/s6e6pOEoMJoLTmLWt98eilpFVuF7YYFmH4i6dvwdBTs7iGwaXQua4qPntZJ6PKMmtpF4mirbMWubO0QF8E8XwKVX0WwHG0ipxHBfJLqljkVZuc1u2QihrbyLh3rhl9RWjJxQLs/37aMDBsh0ywiShkxppXM/i8vx/HDp1PhAdjL36eOo4p0Zg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(186003)(4326008)(70206006)(70586007)(36756003)(54906003)(9786002)(47076005)(2616005)(26005)(36860700001)(7696005)(426003)(508600001)(1076003)(82310400003)(336012)(44832011)(7636003)(83380400001)(356005)(316002)(36906005)(6916009)(8676002)(8936002)(2906002)(6666004)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:46:56.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec2b7c4-9139-4d11-4044-08d994993fbf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Linux driver provides support to subscribe error/event notification
and receive notification from firmware for error/event and forward event
notification to subscribed driver via registered callback.

All types of events like power and error will be handled from single place
as part of event management driver.

Changes in v5:
- None

Changes in v4:
- Rebase on latest tree

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
 include/linux/firmware/xlnx-zynqmp.h        |  29 +-
 8 files changed, 767 insertions(+), 9 deletions(-)
 create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
 create mode 100644 include/linux/firmware/xlnx-event-manager.h

-- 
2.32.0.93.g670b81a

