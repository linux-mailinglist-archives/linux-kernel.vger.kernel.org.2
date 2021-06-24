Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0E3B2EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFXMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:20:05 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:42880
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231405AbhFXMUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyaHeneGQejH6wrvGXRE26hLx2qAR8pDOyJQNTc7YX9qkQE7BqHkrADMODAXiV+PmGK27eQDkL9EB2EME/DTWKYtuWRMai9EC2v0ZFlWBpM8MeYswfVQTBYaR1eOVtAsaujcPZTJJ004oq5omQe6IKWyrcEX+gic3VywA5Idabhd9VRCM6OMzYOepO2zorg0cR83dBij24n+YHa3iwXn4yS6WZMBUUXo3GblR3gDQ+n1JUiipV++WVxLyQtWNfwCA127uTtWJZVQRysLT5bGV5mW6gEaN8f5Sx40aSqf8ji1NMOdDV10kwsMOdYKbxGI2BEHvFeUx1GySyAK8esdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioXmDd1F4OUYtcQ/SgdpRRbtbJYSzLI8LZLn2hbt91c=;
 b=cJ4aV3O7pOGkNH56pccnNe4zF9C8hPqRYtWcUd2S3JdY9M3yeP/HuoOUjEMlaZLgscwMQ13v8xO4ciHeIPOUrT3oTNOVilP/C+OoOH8DMLw1Q5rtDEa4QRWmLywH6T5ee6lN0uvnSsgibx0zJ9/mglzFe5TMCqIUbipA7Rt11bFRVKjqCVmiMELTK8QVCg/wU29uMlXM3+hpVzq/7ubLAe0Uku8JyqPLVDtP+1JSSrkJHXCQw6ijg5pww2tIl9CJl2BW+QefYAc0aZLryOJ+y+jzEJ91O2jiTn+51c6tpAzgfDxSst4gQWEm527cCd4no6IRIxH+L2I9X1CoKBFMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioXmDd1F4OUYtcQ/SgdpRRbtbJYSzLI8LZLn2hbt91c=;
 b=mJUg8q3n+LfVUlKHL5JFP+Em11KUjY9C4vdCtRSG/Bpu5U7cxvhUgDBAfxhvf05Z6z8o/pXWK9EtpDMTuzytwb/bPkT6fpKx1CfPpA9AbUT7xJUinllaTt97cBsREVlBGgQREKkRmOhqlMelYF3VY9PZvbPyUxaidQi9mPag/xk=
Received: from DM5PR08CA0032.namprd08.prod.outlook.com (2603:10b6:4:60::21) by
 MN2PR02MB5791.namprd02.prod.outlook.com (2603:10b6:208:110::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Thu, 24 Jun
 2021 12:17:41 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::52) by DM5PR08CA0032.outlook.office365.com
 (2603:10b6:4:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 12:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT010.mail.protection.outlook.com (10.13.5.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 12:17:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 05:17:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 24 Jun 2021 05:17:31 -0700
Envelope-to: mturquette@baylibre.com,
 sboyd@kernel.org,
 lee.jones@linaro.org,
 kristo@kernel.org,
 quanyang.wang@windriver.com,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.91] (port=51016 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1lwOIV-0003F7-EX; Thu, 24 Jun 2021 05:17:31 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@xilinx.com>, <lee.jones@linaro.org>,
        <kristo@kernel.org>, <quanyang.wang@windriver.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v5 0/4] clk: zynqmp: Add firmware specific clock flags
Date:   Thu, 24 Jun 2021 05:16:29 -0700
Message-ID: <20210624121633.22179-1-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5748052-e30b-4968-5138-08d9370a1089
X-MS-TrafficTypeDiagnostic: MN2PR02MB5791:
X-Microsoft-Antispam-PRVS: <MN2PR02MB579170B70E4BD7FAAE59BE31B7079@MN2PR02MB5791.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZSjTfs9XRCyPQVIbq1ehkUothA6nILC+AeBCdQghn7jkID249JcyPcM1klkJsUwt82FrSRHVcJAil6OSKwLCDfjRlfp+Dri8Ug6VOjEaxayvVpBuE3sNZ3hfeS/QhXvUNc6BnGCRlSYeF1u4ZOyoeIN/XJ0gF5POeLpbfWSG4Gj/M7tmcLRkI9oWtv+/pHCzhXckHOIdLqRZ9FHWEay69a3255DCEHKmGoysdMOSQV/R2AhLtJfHNvwI8tK4TCluNhVGL6+SoZRhe+Eqd/CCmRIyyf8dFystNBs/IutPZ//rQniB1v3jfnF10RGlx63i31TGff7ckUqMc4p4lnQJxi6a5sr/ZA1OIqt9ZwFOLowQkgQ5e9nTpZGoUX/5gXwrbgBnJ9YazvE2kEAdyR5M82oZrkz0xb5riaTaPSWpYH2+5b48mtMs0/Yj1dS62jSwIzeri7JLQPdL8Jep999eaig8h4bQEKpCWuetPbYtMvQyqR8e7QlrebOr2twMS3BuhUhXdI9cE7nvJKsc1/mRuC6sx9zciyZYctkcxquIRCNUkwNo/8XURpPhCyto/DHsRfsB1waHqNSI2TeWTDLbGMTSvC0IW69rxmIXO32tusPWhr5U2blccuK1ez8Ox+DpYoLmc50XxJmIQkz6rGfRU3zZbZBTN9sjkeNFxzY9LQgh1i/gqI2xGwx4L+nPaF5rCpZEljAgY1NE2ptJnr2p2Mhi5OBEGHEeRya0KO3HYo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39840400004)(136003)(46966006)(36840700001)(8936002)(7636003)(5660300002)(186003)(107886003)(2616005)(478600001)(26005)(44832011)(36906005)(47076005)(316002)(1076003)(36756003)(9786002)(8676002)(426003)(356005)(70586007)(336012)(82310400003)(36860700001)(54906003)(110136005)(83380400001)(2906002)(70206006)(4326008)(7696005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:17:41.5371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5748052-e30b-4968-5138-08d9370a1089
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5791
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently firmware is maintaining CCF specific flags and provides to
CCF as it is. But CCF flag numbers may change and that shouldn't mean
that the firmware needs to change. The firmware should have its own
'flag number space' that is distinct from the common clk framework's
'flag number space'. So use firmware specific clock flags in ZynqMP
clock driver instead of CCF flags.

Changes in v5:
 - Added base commit
 - Added patch #4 to handle divider specific read only flag

Changes in v4:
 - Use if condition instead of ternary operator.

Changes in v3:
 - Modify helper function signature to map zynqmp (common)flags with CCF
 - Add helper function to map zynqmp (mux & divider)flags with CCF flags

Changes in v2:
 - Add helper function to map zynqmp (common)flags with CCF flags.
 - Mapped zynqmp clock flags with CCF flags from
   zynqmp_clk_register_*() functions instead of
   __zynqmp_clock_get_topology() which is changing the flags to struct
   clk_init_data instead of the struct clock_topology.

Rajan Vaja (4):
  clk: zynqmp: Use firmware specific common clock flags
  clk: zynqmp: Use firmware specific divider clock flags
  clk: zynqmp: Use firmware specific mux clock flags
  clk: zynqmp: Handle divider specific read only flag

 drivers/clk/zynqmp/clk-gate-zynqmp.c |  4 ++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c  | 27 ++++++++++++++++--
 drivers/clk/zynqmp/clk-zynqmp.h      | 41 ++++++++++++++++++++++++++++
 drivers/clk/zynqmp/clkc.c            | 33 +++++++++++++++++++++-
 drivers/clk/zynqmp/divider.c         | 40 ++++++++++++++++++++++++---
 drivers/clk/zynqmp/pll.c             |  4 ++-
 6 files changed, 140 insertions(+), 9 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.32.0.93.g670b81a

