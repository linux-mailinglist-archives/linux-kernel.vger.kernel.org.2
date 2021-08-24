Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31B83F6604
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhHXRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:20:07 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:19297
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239423AbhHXRRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocWEk/TUZu7CivTxxu+1uyBHSkS6wqAJL0SnG/HlqX9R8VeYwLqCRYQpCm6N6n5TRps5n6D481giVZlCr/n1ZtPe6YMO7AyLs380Pq+s+nmcMmeaKfwus1fALYzkxDQeR0GpN03DTuEvnaB+QjMhiYEcFUnGXThONT+k3mXSU/kKSGsrcX+OoOIDY8DIBIQw2Djh3MpsQR0DKm6MVcF21gAo4vTxgZE74SbfWoZbmx2fwNJIi+S0VyKalKKgMSYk+vk6H9TjcysEIgC1vi938UWPEBmN/dpixKglorr9tf6TWtKtYwLmldXSG4cHxPt6IDZQcdCSfz0GhZmzDSOjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3egaPvIeMHWNThE/IS9hqv38jBgHaNpiK86ZDuFOVk=;
 b=GmAKAZG5o7+A1gCsyq/oLoVOLk4xs+bIXFm3ijlkCdUjWjuWGB3DOPaH7F65RyujMgPkEuLbnfpxMkZrUUVcZggRgBe4tl5waSs2zh/ZqZ3wBMhN3iIKMw8QJhAVIo7igjauJCDmjm2FwlSsFZNdz5IYzXDKKEUgPVgUnmsRYxYyCwYMHaVEVxScDgGJYT1mLdMsbvu/hn4tyDOIeTM9rsOjXdeU9g8f5j88qzf2AweZr1xlpkvXk+1FlL8Mi0Z27BBJpGGWeb6xIcBqe5N7lK2uqwxx6CZG+hpYNLYll9W3yxR2d4S99pKfeYauo+g5XVPpAaqDR7DZI/7eGKx8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3egaPvIeMHWNThE/IS9hqv38jBgHaNpiK86ZDuFOVk=;
 b=slezbgseYg+kjCPYlRaTDN977JAZ/BOUPJLNoYemFH9cQaHPriTFAiJvNnfavIhkvyFsyEmRgzW8YmHR/0xUf7Lg9esev+pfFXX73GEM1pUeN/3fZThxvOjupEiPqmvmnuqbmkc2diRl9SIYdcHpmMLP39qLV54FkEedr0CZj8Y=
Received: from BN9PR03CA0741.namprd03.prod.outlook.com (2603:10b6:408:110::26)
 by DM8PR02MB7975.namprd02.prod.outlook.com (2603:10b6:8:14::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 17:16:29 +0000
Received: from BN1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::4b) by BN9PR03CA0741.outlook.office365.com
 (2603:10b6:408:110::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 17:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT030.mail.protection.outlook.com (10.13.2.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:16:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:16:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:16:27 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48471 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa2E-0008Vy-7j; Tue, 24 Aug 2021 10:16:26 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id 69B8F604AC; Tue, 24 Aug 2021 22:46:25 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/6] Chipidea USB driver Enhancements and Bug Fixes
Date:   Tue, 24 Aug 2021 22:46:12 +0530
Message-ID: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4bf849-c061-4413-548f-08d96722e964
X-MS-TrafficTypeDiagnostic: DM8PR02MB7975:
X-Microsoft-Antispam-PRVS: <DM8PR02MB797594DBD333BD40A5F3AB43C1C59@DM8PR02MB7975.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c52tov4BkcqKjBM0EVwyEdGcHMQnSdakPb8Lnp7+JXFkMzScgLC+JXyGxWXr8UJOv1wrSZPBBnEQUu7Hmjwa+MDZ2vhHghDhhb3e6J5diXXNOfnym9zUE/y6YLTXJRpXOYv5rtpTe2FA8bcYJFP2GgJJgrVeKajzbpGXTUqykqi1NZEXsAIAGy2DE3WNhlJk5BMzp89i3uorRe16ZW5jxFdCHbEvtextilet0mmLYjCpqhrLIEGzlQ7vaTeNPkyp6Yv5yjS8fdS/xC+LoaBpxG8aNOpr2uJVscy4pSQqWxO5C4usleaI0Lh9SxrdOLhbmE8DgnzoTeXWPhiwaJpgjP0KpfHmo/SM0W7nvoz+BC4tV2Mde75sdX9qHZxdjLIvT10Y/WU9OgZMKWvIlOkGJLscSMoKBOoRKk4luJ5AaH9vNF23fSJgPy6hO/tAqicrUWZNGON5wrxGPqIBf1jHgub5r/ZXwxFQc9AdjpEFYY3bSC8YUAMvMDHxyKeJbJ+K1dhZjFPL+FsFnuzhn289BH0HJpsMfzylAKtrMqKfChjaFGDRCtKdYKWqjWXAQXBzoOAnzhRsPmB+SoVXFADtGDxhny9DLNOAGkIAbx9TccJmGXsgscYS0Bc/zFexe/9LxOY4tfCWgn1jk+SQDr6cDqADo841IehVW+sWp3ghwpzHjFrxrBBbr6lnpfAJMVF0jwU5ZJT8+jMFq2OLdQ/QfxF5Kx8pLq+okaz7gd3PXHU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(4744005)(82310400003)(426003)(2616005)(5660300002)(107886003)(36906005)(6266002)(316002)(6666004)(44832011)(4326008)(42186006)(6636002)(336012)(70206006)(70586007)(83380400001)(36756003)(508600001)(47076005)(7636003)(356005)(36860700001)(8936002)(2906002)(8676002)(26005)(54906003)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:16:29.0522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4bf849-c061-4413-548f-08d96722e964
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series has some Enhancements and Bug Fixes to chipidea USB
driver related to Zynq platform.

Manish Narani (3):
  usb: chipidea: Add support for VBUS control with PHY
  usb: chipidea: Use usb2 phy for Zynq platform
  usb: chipidea: Check usb_phy exists before using it

Piyush Mehta (3):
  usb: chipidea: Fix return value handling
  usb: chipidea: core: Add return value function check
  usb: chipidea: udc: Add xilinx revision support

 drivers/usb/chipidea/ci_hdrc_usb2.c |  5 +++++
 drivers/usb/chipidea/core.c         | 26 +++++++++++++++++++-------
 drivers/usb/chipidea/host.c         |  9 +++++++++
 drivers/usb/chipidea/otg.c          |  6 +++++-
 drivers/usb/chipidea/otg_fsm.c      |  9 +++++++++
 drivers/usb/chipidea/udc.c          |  3 ++-
 include/linux/usb/chipidea.h        |  1 +
 7 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.1.1

