Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792E633EA16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCQGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:53:10 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:53185
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhCQGwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZKLxXX3yWcVNu0D5/sPSfTZ5qGC8BR/xnt+/LBQngm7Nlnt560+DJelWIorCCpg2Y/NejDvD41N2XeHErzGuspUAgiVJTVRlCyjZCu8eTfhnfj/p0VjNpyD9RJIT+e3LxOO/VSmBrEMYS2TotPanwwM43lXgqPwtnLqGcPJKC+PVY/4zuw8iii/i6AXBIB9D8JU3QJjHNY/IqH3fqlI2zKDw8326/Emy0m7Z2ghWCqYUO9xPpVRlFcSyNVvxBI3Her6jeYsGbR0UEnfYl9Bg3B6j8RGoIm2WN5Pm7dN4CfjSEhfuZ04O4aPU6Okw4qnC2TlcdM8F2INcapJwoxKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3w6uoe208use+ErQ74inhng1le91Qj6jbswD9ixask=;
 b=DFVBECXVfyRnPTSWIOxuR0fFFvnR2HV41mX0ltqPXaNUvlGvPs11scPZoNwt/EWaLq9jNLh48pByFSWomhmqog/tGf5mfQd1e72Slqg2BguR0d59myeBHt+wRLVbhrEZc+ttgimupPdFzEMQEl7/xOTphConhEg2W2/K7fYq9sjK7+YCX0DKRDSgWmy8pkgxl/L7HqXXopH1ALYcpR1S8pXCFWY9kdn+kCz751aujaVzbHqk8vKpbhBm6N6xPlER7N2DsE2YXiARkWmm0vci698cmVmNT5fZ0PMr7kuaFMOxgs3cRV5Wmr/fja0z2nNN3OeV2wojOJ0zoPVirhXg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3w6uoe208use+ErQ74inhng1le91Qj6jbswD9ixask=;
 b=f+U8GB7O7aeGuxTdJj+EyILrEBTrXd/P6eRuudGe7D7cebMaMS6V+eAkKE0i8i/dpvJ3WAhb81Oy5h5f3xx3DvC2txaNIM2KXA5N/vbIwvH7o0Y22qLTtcO3oyRGwrrfVm+6UnVfbHoMyMZ5jdAIe5tTmpwZK0T+mm30q24dfdg=
Received: from MN2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:208:a8::20)
 by BYAPR02MB5287.namprd02.prod.outlook.com (2603:10b6:a03:67::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 06:52:43 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:a8:cafe::9d) by MN2PR12CA0007.outlook.office365.com
 (2603:10b6:208:a8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 06:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 06:52:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 23:52:33 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 16 Mar 2021 23:52:33 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 p.zabel@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=48676 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lMQ2i-0007eX-HL; Tue, 16 Mar 2021 23:52:32 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id B228C1210A8; Wed, 17 Mar 2021 12:22:31 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 0/2] Add a separate DWC3 OF driver for Xilinx platforms
Date:   Wed, 17 Mar 2021 12:22:27 +0530
Message-ID: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f780b0b1-f3af-4116-f92d-08d8e91143a1
X-MS-TrafficTypeDiagnostic: BYAPR02MB5287:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5287AC96F5FB439380621313C16A9@BYAPR02MB5287.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftZRgWR2demCVcNVqk0uyXGLKMELl1Wc4pceR9zt1WWpvwNxCGsBqm5OHkswKSYF0x1q1dqejB7oV9VrFQrpe+u8sLXyRV+Ecg/Ajq4nPGZ1iJ1WnS/e+kydkFiqGXUIwyM92sZq+L9nIyZiTgSXhS4tIXnubt/rsKcv+bSFWH7yaZiXP34ArSVTtd1vNzvMCmcrdS+BJi2WxFFnqAqqvrCvzK5rwq9AbFnYvutp1Zsiq4gOxqw9GN0EaNnfpLyrRHC6QA9c64BrkG8UkzHkqHgLLRGP9m0AGq7AnMNebqG0wMhuoapO5Qx91faqD96g7By2RZtMNVPznPsvnjc6iuwQa9H635JbPA9MHDZRLBlrh1MlvSTQO/OKVbYvSImj0PGsUUVFepA6g4IBbBhAQ9Q1Lr4C6+JsW9v4S3fKnvwT+ms/ugPuJvlBZpakyWqErTx+be1eEpDWt0d3L0CCJnuVgXHz1D12THEmLHrZTV75vIXd8LxFxvGgdowJTSQIS34k2gULKpY/T5eYd6WuOXKOZ88hrtt+3qi/wTzfkjzAgO3woGGo3OY1PU4Hfidi51GrlcByuhasnrqePaWUu/XqObjKgYQqT48BZO+xkAg5+6Cd2qLzQxwlC3Gcue+8gcXX2qWPddAe7o2d3xdHT6og7fAvkG62ZN3Ma1kFFd2vk+vMkZgjgTU59D/QZVTm
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(5660300002)(42186006)(478600001)(336012)(2616005)(36906005)(186003)(110136005)(70586007)(316002)(82310400003)(36860700001)(426003)(70206006)(47076005)(54906003)(8936002)(8676002)(26005)(4326008)(44832011)(6266002)(6666004)(2906002)(107886003)(36756003)(356005)(83380400001)(82740400003)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 06:52:42.9760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f780b0b1-f3af-4116-f92d-08d8e91143a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5287
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series documents the Xilinx Versal DWC3 controller. This also
adds a new Xilinx specific driver for adding new features in the future.

Changes in v2:
	- Addressed review comments from v1
	- merged normal and runtime suspend resume functions as they are
	  same
	- Improved description of some register operations to avoid
	  confusion
	- Updated commit log for patch 2/2 for better clarity.

Changes in v3:
	- Removed snps,enable-hibernation property from the devicetree
	  binding.

Changes in v4:
	- Error checking added for devm_phy_get
	- Documented resets in dt-bindings

Manish Narani (2):
  dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3
    Controller
  usb: dwc3: Add driver for Xilinx platforms

 .../devicetree/bindings/usb/dwc3-xilinx.txt        |  28 +-
 drivers/usb/dwc3/Kconfig                           |   9 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c                  |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c                     | 339 +++++++++++++++++++++
 5 files changed, 375 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

-- 
2.1.1

