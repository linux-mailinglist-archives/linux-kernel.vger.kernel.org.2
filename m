Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB843911F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJYI1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:27:00 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:46326
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232063AbhJYI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+92hup9b0Qz933feD15DgZBQSEa0GL0y0XfjsF1PaHfkP/sbKXosDndpkATGRSfMjMRI0Hbu1HFjiHkbpisGqUF3uwisjKgk2Q77hUwKqJZMsgVDNThJpH+MKQzsSmUIeCSA0vtPdyPqN6Z0ryCLcRkGT+5wA6nQFzWdE4Qu+i6+PqzjFAP8Q76IMWBMAm2UYfYMa8kAtj2WD1S7RoKwFsy4NHM39+85CThK1hXgI+YfX2DGVVGtwmb6yaGMypo2apA4Ht9voqKRNT4lzNA/+sWlCgg1ZzkK2afNNuidRI1ZPg3oAuDEbpMOr8llr4+MkCjmoaK6EO9PUtUjacvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGCIbz9l6dW2sl+hTl0JVk1pMDjil5yljDKu5Qf8E7w=;
 b=UKYRs8DYwxBoVVU8jkIjmqVci3dY0J9tQ6tymyvwk2ucfm7hqVAe4deGpCEkI5DAD37WUdLSmbE2eeb9XiePo9DL712Gz4YKjuXCi6jf9bevFCDx4XAZ0+K/lZWE7tr2uA3yMBPVsTdm6kNFAmaLTeYu3UqCurqF4S9SUkuhnRDGtw81Ba3j/lBAgITmZHOnbhG3q/ezo71EORoc6RBfzTHbVzdAsdNoIJys77FwpT+Q5jH/5NAj6sodtvmlCbgABgKh+QNoVg/MnTKCFHqCcWUF4pPNL/v2RRJz2XkKtMcRa/muJzsND+nQ8S10OQ+I1HgDynLx9OKacIeD5nEPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGCIbz9l6dW2sl+hTl0JVk1pMDjil5yljDKu5Qf8E7w=;
 b=X9p8hb+qWgdD8ChmfNEycaScbulmAZk5g7Gp+xqmjXTiPPvWW6BkLGMg4Lch3PFQI3jffJvf7waE5Ruq/FIu97RWwDz7yDA6YQwe+FcWA4VUaAYL85y8TvLkzIyDMQfQdVgrK0ZNKd3FZQdwFsUosvw0tQZuQA99duoMqxDWYd4=
Received: from SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6)
 by CH2PR02MB6375.namprd02.prod.outlook.com (2603:10b6:610:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 08:24:26 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::b1) by SN7PR04CA0151.outlook.office365.com
 (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 08:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:24:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 01:24:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 01:24:01 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37006 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mevGz-0003vt-IP; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 0/6] Add Xilinx Event Management Driver
Date:   Mon, 25 Oct 2021 01:23:44 -0700
Message-ID: <20211025082350.10881-1-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71c19c3b-1664-4a62-621e-08d99790db3b
X-MS-TrafficTypeDiagnostic: CH2PR02MB6375:
X-Microsoft-Antispam-PRVS: <CH2PR02MB63757CA13E6C8DADF223EB64A1839@CH2PR02MB6375.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLNHGcqM8e3Y0l5jHnidVsI9TpOys8f2vXBmL1a9C3Eioo2slsut0UE+xV0iv7DAtT2trvvjRYeKGuVyHb9YZNvu5deJe2LnPhtCex17vkxCr6T6Up4ne6+O94mB4R9LAF3q8Si40mvIS+mMZL2W7SqcYzYgWhE1rAuJZHewk6AfPLJNu8qp/Rmd6ejRr85zlLWC24ZjvnuJe1AtT1faMuVpvHzE8jTcNjW9n7SxHiW3gPWYOp3aAq42nGddgd9xNL5DQKIZjlVANq+5TLiQ1kcVYYN1SP+v7bCkM6eeokaQ+JF4SAIY6j+luOl6uvmmpCvcScVWiPooIlYNNtVkGoBNtzzRhTH+IMcH97tG6XZg+9YU4UMBcFHGRdQc0OMbm4TneitPaye2qV1WsaBSFG+rEDtJ+cF3uhphlPgv1jgA7oXV0oQEH+hr+nJ4amhddkQS1BuWmvu3yMZC2ZcrlWFM8evkvw1DxOkauihSCmhs6+PSztK/9cyFpiB1LfGsrma/0LbTVIn8lQfAtShBrhi9Rooj0WMDrF74+3Ij5sdtOhjHzhtvgeYUUJP5uhW8PB+pKInCbeq0idhYI87UmmMj+M3JdwZsYmQaAmZQwLuwajIBbQ3/+Xv9Kk3U1imKyU47XDdslOQV3QRNeu4lxB5gaGancYAlHoWHoYP3TB7314ijzm9DsxO+KoQrrsnqFLfDN9fT2NiwYeZ83Ji2dhNOlQlzlM+Fk9RMZGf1bTE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(83380400001)(6916009)(336012)(36906005)(316002)(7696005)(44832011)(1076003)(4326008)(82310400003)(36756003)(8676002)(8936002)(5660300002)(9786002)(36860700001)(7636003)(54906003)(356005)(2616005)(2906002)(426003)(47076005)(70206006)(186003)(70586007)(508600001)(26005)(6666004)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:24:25.8013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c19c3b-1664-4a62-621e-08d99790db3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Linux driver provides support to subscribe error/event notification
and receive notification from firmware for error/event and forward event
notification to subscribed driver via registered callback.

All types of events like power and error will be handled from single place
as part of event management driver.

Changes in v6:
- Minor bug fix.

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

