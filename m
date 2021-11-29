Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C373460F27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhK2HHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:07:43 -0500
Received: from mail-dm6nam08on2048.outbound.protection.outlook.com ([40.107.102.48]:4832
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229818AbhK2HFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:05:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktW+RuDrMJttFqs86zJZpTZZZl2h7YupcH80nzvybo5Q61Z6NYEhfq+SXsQBFLBstyQkX2RTtvc/lPTUvnyG+RL9yex78C+SjpLuKPLBOjhMVt8IjElgUvljNkCd5RCWVgwehfpuTKuUoirPkO8e8KnnQWqH5zhOqbevhgDMK+O9Uo0ZMuYpmbV8exOzLDAt/OlOtE6tmmTIy47VFg0bslwPRBJOAuXi7A0D22BnPDzKd2WGyTud8o5UhAExD5zG3Q+2wBPgFrf85aUcroVNIHdUaMzHUnV5o3lvFL/Di0Rfhr1ot+K5h1ZUpmdAzTemhPnmqYkIBATrfkbZ9ValyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AUAw3dik1899UTcLJDGYAWPcxTXApmVmWz3GQvTnUM=;
 b=PNSS0xWKlQlpu4diui471aYFLntXacqLbl9JrxKSWnfu1AP2ck0bvbgY5KaADW+TEJ6/tUyv8BvkqUaHrl7RTg3LW8I8cqpVuy39FzAeCw6/xnpPef1RHkf7tJZm9SLzPaVCfYfpp+R7e4N5YTDzd0aUjWohmGkinLaSUbcot1cDycF+wn6JVvDQOs6HO3s97YcaK7U/zvoBzDfBhNg9GQc56ostICAtiSie2WNELY0JFsRrZBz4Y7KcQjY5dlL2KH83PxT/EGFrpRPTOsbPxNxzLDZe+J+ZLBE6D2CxCHxQyw3pb+9xSu1UYoMYxy1SYtRAz33OIrQh9+twOvEvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AUAw3dik1899UTcLJDGYAWPcxTXApmVmWz3GQvTnUM=;
 b=HZni6PcHfDn/lY43CAf/qop/u+vjY4wSsxdukvCwc1gsrJKBUGJzqtiMLA1PdW0WC1lSHAjzNvU4CPoxdvk2v5zLrHFeplqwYb83KCHdx0jF8gja3xlvNHSrUUa47urygtzEjpQWC2Obamg6Hf6eagGH6E2vdcse5qqU5TUImDA=
Received: from BN0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:408:e5::27)
 by DM6PR02MB6282.namprd02.prod.outlook.com (2603:10b6:5:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 07:02:23 +0000
Received: from BN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::f4) by BN0PR02CA0052.outlook.office365.com
 (2603:10b6:408:e5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 07:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT051.mail.protection.outlook.com (10.13.2.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 07:02:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 28 Nov 2021 23:02:23 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 28 Nov 2021 23:02:23 -0800
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=33638 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mragB-000GZ4-9z; Sun, 28 Nov 2021 23:02:23 -0800
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <jliang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 0/3] Add Xilinx Event Management Driver
Date:   Sun, 28 Nov 2021 23:02:13 -0800
Message-ID: <20211129070216.30253-1-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <YZUcAch7lVZ32/+t@kroah.com>
References: <YZUcAch7lVZ32/+t@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8e2cb6e-d97c-4907-4b38-08d9b30631ec
X-MS-TrafficTypeDiagnostic: DM6PR02MB6282:
X-Microsoft-Antispam-PRVS: <DM6PR02MB62826A0E337940DA57A5F417A1669@DM6PR02MB6282.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V+KzElWx/o7cXwYEK2gEER6AHvUUK7qDWR4X28CNZtdnvnzCYv2ieyfLDG16/utvZsAWPSy1LkdqJ7HEpsupnVcU/VTftfxoeYywQue7QvWqz+VMd6jEzD6YqWl9ZoDwYd2U9bCPfvBN5WHG7GxnYajIALf7HVeD4tNpJ9TEHXt5HXr8WGB9R1APSoKrg11jUUMpZ0vxx+XAeiPYIaCNd1VbxUNiTvO2IitUs3BKNC6lMW080hil8S4CSPfnpzkJ9JIqiiaRAOyfDKBdJUd2yvAyXiezmHiboKTHpgW+n/bNFd58nIQ38dAFCQ2C0nGSqoLX99bCoghZlTn+JhKnMai0EuLc7Zdcr189FT7KhU+P5RQzC+QIBz8RxYeKB9m2np2vRqUvnjvSkNADjRQI0G4UlwdR66rmH7HVDWD2KKIxydzLgfzb74ZJ8pDQcnygN1Ax6tw1H0khsXlvow6g4fZ7AHlyVs9vibbUD5bvY6amk6w1PEUFE4Xpk3S7JIGDTnIVBriHw5GZJWovkBc4vRnrr8QD6fOo6Elx2ZJ7MM3OeUFq6xV8LlqWAZhGCrF4FR95obV7/SpbngVxd3ZcwIyy7QrRGmYmiQzT5CHuQ1RPy2lj5vsZ4XEDNyTUr04q3aA2x+cFdxfxJ6o8CAz+I4CAkmMZkHWkgmhMbr0ABbEXbvkZ8v2WZiH9dnXO82XVQxbp+iutlmR4S6Fna0hBQfpHz9NVX8LgfOlO8EWc9U=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(47076005)(186003)(54906003)(508600001)(26005)(36756003)(426003)(336012)(36860700001)(9786002)(44832011)(2616005)(83380400001)(82310400004)(70586007)(8936002)(70206006)(1076003)(356005)(2906002)(6666004)(6916009)(4326008)(7696005)(5660300002)(8676002)(316002)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 07:02:23.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e2cb6e-d97c-4907-4b38-08d9b30631ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Linux driver provides support to subscribe error/event notification
and receive notification from firmware for error/event and forward event
notification to subscribed driver via registered callback.

All types of events like power and error will be handled from single place
as part of event management driver.

Changes in v8:
- Rebase on latest tree.

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

Abhyuday Godhasara (3):
  drivers: soc: xilinx: add xilinx event management driver
  firmware: xilinx: instantiate xilinx event manager driver
  driver: soc: xilinx: register for power events in zynqmp power driver

 MAINTAINERS                                 |   6 +
 drivers/firmware/xilinx/zynqmp.c            |  14 +
 drivers/soc/xilinx/Kconfig                  |  10 +
 drivers/soc/xilinx/Makefile                 |   1 +
 drivers/soc/xilinx/xlnx_event_manager.c     | 600 ++++++++++++++++++++
 drivers/soc/xilinx/zynqmp_power.c           |  48 +-
 include/linux/firmware/xlnx-event-manager.h |  36 ++
 include/linux/firmware/xlnx-zynqmp.h        |   2 +
 8 files changed, 716 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
 create mode 100644 include/linux/firmware/xlnx-event-manager.h

-- 
2.32.0.93.g670b81a

