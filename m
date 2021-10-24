Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48791438B3D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJXSJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:09:02 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:6703
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231481AbhJXSJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwVwQSNu6aBT0xZ0sDsAppo9nV5RQXMhCH4i/nYEvG2nuZDrrJHPcI4WFq9Ka2e/Ur8uAqKMg4FITe0FoN9acRWws3adeN1f8dT15lOtuGSWoeLucXTdCAvC5IAZCXMcYBFSAabf9e5TgWNfhD6HgmotMRxcX8tWwAFWT/IvT5O4inU5l4nB70PRCMynC0zkmQ92ge8qNF4EqkUCb1U/5iRBEY+iPaZ3Y5okZg5otZ29o2DHEg3nqeM+NaWTpm4inEpYKvb1aHcdBIxxFjfYqrS3fNIkpRazoGZme8B04nCBQ/7znwiN21yBeKOvmrHa38PFdkVgFdbqvjAp+D0OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9XfxgSCj7LlHh93XWqKiqXs+DfZpy2MPoWyyUU/6Ak=;
 b=IiXanlAFM8I8zmOAqjhkmkUKGbtsEgfvGJ8xI5Q7wNRNoKQ0HWUBKg440sc75lwM59ujPeRT+rN03ezrAknQ8sz1nqBZ/xJqVShl5dJrLnI7aVVTbWOgs1hKDZUXloFwa5p79ql9khF2cNgRS9tWCkc5nHT4tHdbtBfIvloiM991ngnyvALLjZQ0IZCOuqXEP5catl/hyecjKVBjCRjEunTpeRllHAMadPQBu7sb14tdm2oSAk8V02P0H18Hu/IcYHzA3efmd5CIlt1ng1Id8zt2bw7wwqeqxGQLDddnI+76APziM0gnEJJAFoFnp+ggSwp+SKVvNzaeT49rIKh/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9XfxgSCj7LlHh93XWqKiqXs+DfZpy2MPoWyyUU/6Ak=;
 b=YxXUPLpAZvBarESmVeQD/03/59ynH9bhMCK04fyUBCNS+wZfQ1UNbcBAxjPl6/z2pf1e20dRPOoCRBOG73qSpx9VMjgZJu2K51yHdSSYmpfjk5lb137sH94DI4LdhsR0RCaeZ4StHbChSPW0HGjTA7mHFITbk1aMRZ2MN+1EMfA=
Received: from SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35)
 by SN4PR0201MB8807.namprd02.prod.outlook.com (2603:10b6:806:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Sun, 24 Oct
 2021 18:06:38 +0000
Received: from SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::e2) by SA0PR12CA0030.outlook.office365.com
 (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 18:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0021.mail.protection.outlook.com (10.97.5.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Sun, 24 Oct 2021 18:06:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 24 Oct 2021 11:06:35 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 24 Oct 2021 11:06:35 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 --to=robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=56658 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mehtC-0002dJ-Li; Sun, 24 Oct 2021 11:06:35 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <--to=robh+dt@kernel.org>,
        <mka@chromium.org>, <ravisadineni@chromium.org>,
        <stern@rowland.harvard.edu>, <alcooperx@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <piyush.mehta@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 0/2] usb: misc: add support for microchip,usb2244 USB-SD controller
Date:   Sun, 24 Oct 2021 23:36:26 +0530
Message-ID: <20211024180628.2992108-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 732135a8-2194-4862-42ca-08d9971905af
X-MS-TrafficTypeDiagnostic: SN4PR0201MB8807:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB880744481EA84540B0181897D4829@SN4PR0201MB8807.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Omv05gkYMmRaVy7PofYWFcmf132HBRkAu271al60aI0uePKujJ7fiPwd6hUenSxuAIm9TL91ck5zK9qtn/S/XyT8ugHhhTzcTyz2oyNEwdh4dU/iNKs2r2kB2gKPUJIJjWKFYskR09gy4KGkQDmi80tQ71O8Z0VUEQyknWMAz6pM+ffecT4lJVtOeKnVTfGwxrMmqoarHsXJftGIkZvXyvJnl47JqRgt+E0uIh00gDCFAd+ZapxOsbPqOgu/bfbCjYR+ASNgd/ygciBaNUGCBW6RnK2abzXA2OeEkwDzGEmuT6Ze48BC5341ZQOsMMc6YzdAMrReer1WsD0tJTyJOQNoqUT7WSrQPpSJJSab6fO8oAxtsJ+wipKURNY/4kPj/sjSwONVuYHsvYh2D5ztmKVv4uriSbdobDm2UK21mSUd+zKTcUXt3lOQKFQ327secvDMpFyV8JaYHjKHdcODggMAZQDmAj2WKG3WMek9x5l5ut/L8WRVV8Zagm1cAqQsyzmG3oeGolcfhXDY5xEgdnrIgE9SZRYSVr0wLQiAz01mLm8I3joPSW97cRPhd/7A1q/d2wJuFE909oDEUQePw/9Q1rNcDRnTbtaCCBVlUrCyQyumPK/J3PoTi8ZhpKaJwK6yffAfrzhTPXzHppc1M+56CexaMCgsqUQYSaB85y9PnRGa+xdTCmK0qfw1JVTtAH5GOGtcfDn1JXT8j64DrVTRgQmhv8hSuLHR6yaGJv8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(2906002)(356005)(2616005)(7636003)(70206006)(6666004)(70586007)(26005)(508600001)(186003)(44832011)(47076005)(1076003)(426003)(107886003)(36906005)(336012)(82310400003)(110136005)(36860700001)(9786002)(7696005)(6636002)(8676002)(5660300002)(36756003)(8936002)(316002)(4326008)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 18:06:37.4174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732135a8-2194-4862-42ca-08d9971905af
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8807
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

Piyush Mehta (2):
  dt-bindings: usb: misc: Add binding for Microchip usb2244 Controller
  usb: misc: usb244: add support for USB2 ultra fast sd controller

 .../devicetree/bindings/usb/microchip,usb2244.yaml | 43 ++++++++++++++
 drivers/usb/misc/Kconfig                           |  8 +++
 drivers/usb/misc/Makefile                          |  1 +
 drivers/usb/misc/usb2244.c                         | 69 ++++++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
 create mode 100644 drivers/usb/misc/usb2244.c

-- 
2.7.4

