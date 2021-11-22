Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB16D45894F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhKVGcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:32:00 -0500
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:61097
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231419AbhKVGb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:31:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWZwxVRkszMFYJk+2WoIo0RElExKduKSeR8t2i0DR2fZEbsjGVU0z9sHR6K7eSKp3JW/l/Q2n0ugV1Af600YrvGAyKuSyMJw5OXz/bJQyIO2U53mtmwKm5/xX+fSxbNWIwyFqtJBDTLwX+qD/Ynk0wNR7zU28Pj15ramFh3yJUNlKrdu52GuI2d3C11Mw7RjlJYXACW5VGgCFf+dz8CCLGz7s+GV2um/bs3ZcaDJhkBVx5lGjsBJZLtKsiSNXNAnbRtus/eXRoiuRkcVherJAVtbZQ/LUBBhbdnj7VtCSWYUQ9mBX+331lbg158r/faXigZIXZE6tYQUT7h2ITSSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcMpELuqOPEU2SZHvpZG+H0PhucP955eYdU2Lo4rCUQ=;
 b=LhS3BVC41dRts+8dNeAXeH+OgX6tJV45z1Z00rOuIwVwGuCH+oqFrJxVnt1TQTCWrdOrRlBctSvvepqqEP6dG5JUtiWjbcZYEIQyGzLFApF9US5xna1Ec53IC043O12RcP6VDAa+tnvmy7IBKVtGpVQMWidP9GgXQwkOJPS5WgHOmz1L64Z9T0KaQ/NIq3KmA6Bsb8ETDHHOqb+4pHVTNnK2arqVmclP/zzq1zdRwTqhUIDfLedzFrlQVNw6FeeXGQdou4qjZrQItgmn5q+BSzCz2pw8x5saxCj1kzGP5y5Qa5W2//pqr9XACTptx+tlsPhG++z85CDlzglneZnD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcMpELuqOPEU2SZHvpZG+H0PhucP955eYdU2Lo4rCUQ=;
 b=j0xyFh6dqDF02Whl4573GagHDX3RWIaVJhDnM0hcfodK8tTuo1PIx956wci81TeHwSY1DLZ6h/VofSvDYncVD2mYMKgFEe9+5WLvnn4d55UzPLaFT5sb8qL5u+5536Swsb7WZhAwv5vGU7WB18qtTJbB09evLW3nX+WdkOiEQcc=
Received: from DM6PR08CA0061.namprd08.prod.outlook.com (2603:10b6:5:1e0::35)
 by DM6PR02MB6171.namprd02.prod.outlook.com (2603:10b6:5:1d1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 06:28:51 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::60) by DM6PR08CA0061.outlook.office365.com
 (2603:10b6:5:1e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 06:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 06:28:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 21 Nov 2021 22:28:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 21 Nov 2021 22:28:49 -0800
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=53536 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mp2oq-0001Mv-VJ; Sun, 21 Nov 2021 22:28:49 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mka@chromium.org>, <ravisadineni@chromium.org>,
        <stern@rowland.harvard.edu>, <alcooperx@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <piyush.mehta@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH V2 0/2] usb: misc: add support for microchip,usb2244 USB-SD controller
Date:   Mon, 22 Nov 2021 11:58:32 +0530
Message-ID: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 002ebf12-6550-4118-6594-08d9ad815948
X-MS-TrafficTypeDiagnostic: DM6PR02MB6171:
X-Microsoft-Antispam-PRVS: <DM6PR02MB617113A0FA3444976F304D85D49F9@DM6PR02MB6171.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ot9H36sXdEIQGnktjaPlWJqvaSkSGMDZsWfZc9RH+yMMr1vpAEPAYL8pRgu+RCAczj1VyqQG+5oyxpl079ll7Yc/Y8s6Mei+vORpa7E/+g5bTUeClruCJm+hibalEGuvg+rDHvP5eD7nLfCN3l4uQgrmz4AZowvZWRoOb3mbdM1bbt4VeFMhz1DGjHlbw+/PRQtgJrf542G/1FK+pJmPP8U3Ai8S1D8tIwtba89cOh5az5e3ofCKSiVGizRgHn0PBiMuppNQQTSBlT3FAUfCUg/aqxszep1wcuJKd2kvLB6P3/azg86Tphsac5A7RBx0hwlcr/8GtnRRGl8hkSxaWgkOHU0XKq8Yc7Nwnke0DCyWXFmwYZt0Orq+dMdFuadliMm4qcZChKomMTfJdglADsiEcSomzZZJ+cbMhaXJoiTVLhpHqUV4oBQwm8eNKk6Ai0V5GLs8JA0b53v2EodjTq1w1510MDaiZ0Hal3zhUG7BvX30vC15JMTO0mboiY2prvcW1e3AMSeI7Jz813SILp34VvISchfTpFucgO/lo2tfH59Qus4bKXiaqVzsM/1OZ7TTizh0nXnLiAu1y41v+jE2LKYD7NLqAyF6qQo7nlV0RoIkjS+xAlPy5pjgPyEBZ5o5/1BB2PYYhs55KiY5ssIBA4AtjgPpWhEUzgAvrG+ZttiGWM3o8ChSg8Ps2QqV81EuVOl9J5oa/nyIMUnPORgFe2Ja2u/LVXVhNZ8cab685rbDEEp8lXmWZqzKhu86tiVhfA14YhBDHmyTp0YlQIji4KLKbde4beCr1tqPrTdWSqw0unxB84tQ6tGDYQtx
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(54906003)(83380400001)(36906005)(2616005)(110136005)(6666004)(6636002)(36756003)(70206006)(316002)(4326008)(356005)(70586007)(9786002)(8936002)(8676002)(26005)(1076003)(336012)(966005)(7696005)(508600001)(186003)(426003)(82310400003)(2906002)(36860700001)(5660300002)(47076005)(44832011)(107886003)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 06:28:50.9029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002ebf12-6550-4118-6594-08d9ad815948
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's USB224x family of Hi-Speed USB 2.0 flash media card
controllers provide an ultra-fast interface between a USB host
controller and flash media cards.

This patch adds a GPIO based usb-sd reset for USB2244 USB2 ultra
fast SD controller. This usb2244 driver trigger sd reset signal
after soft reset or core Reset. The SD needs to be resetted after
completion of phy initialization. After the toggling of gpio,
controller gets out form reset.

As part of the reset, sets the direction of the pin to output before
toggling the pin. Delay of microseconds is added in between low and
high to meet the setup and hold time requirement of the reset.
---
Changes for V2:
- Update reset polarity, make reset ACTIVE LOW in the dt-binding document
  and usb2244 driver.
- Fix WARNING: msleep < 20ms can sleep for up to 20ms by changing msleep to
  usleep_range()
- Addressed Rob Herring review comments
  - Added usbsd node under the usb controller (usb0) node.
  - Remove Warning: decoded text below may be mangled, UTF-8 assumed.	

Review comments:
Link: https://lore.kernel.org/lkml/20211024180628.2992108-3-piyush.mehta@xilinx.com/t/#m2e146078276051984a144ba074c6cf4eee07b4d0
---
Piyush Mehta (2):
  dt-bindings: usb: misc: Add binding for Microchip usb2244 Controller
  usb: misc: usb244: add support for USB2 ultra fast sd controller

 .../devicetree/bindings/usb/microchip,usb2244.yaml | 47 +++++++++++++++
 drivers/usb/misc/Kconfig                           | 10 ++++
 drivers/usb/misc/Makefile                          |  1 +
 drivers/usb/misc/usb2244.c                         | 69 ++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
 create mode 100644 drivers/usb/misc/usb2244.c

-- 
2.7.4

