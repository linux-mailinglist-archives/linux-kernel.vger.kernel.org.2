Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6FB3F5099
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhHWSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:46:07 -0400
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:43233
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231288AbhHWSqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:46:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf1xkRswtNNXmf/cQ6fJvTz7pXRrf3mvPHZ6tDUo+Bz6qX+D41ZWpdKyFy+G/zKvWLncl8nsj5zmuODwzBjQlv0bF96RS5zP9qoV4kat/UndqOG/qoUv1TEzuMtMZWgL81y3CHOKYu4TFDg+uI/9aaVKuXs0LvPheXqSa/t5kMd+bYnxUW75ZruQUUrGx1b+goQJJGHItYPrg3e9HN/u3+tKQDYbU2g1obvbal4YbYmNWJk/c0cA9rjK7OVg2ME/k1wZ6hX8vJXCA5n4ONnnIKYL1pSkCfC7RNi0GP1sgS3m8G6x562GulCaJYNwFT/uN1+QDmYXxqAm89YbD3vgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUK10HJRPMVR9BWYkzpYYXowqGTKgzckgHOEj3d5TwY=;
 b=OZqL1TuW6tb1ZtPLTHJyR5m4/gCi6iUOEFHSC0Y7x+i834PvSwn5h9NgD/D0Mhhm6vMJ+o6hfWg7XR0lpLPWxTHpX9/lRFfp4Y8/M1hDTDoh0z6tZm+C68B5jmhqcAYtcI+4kiL+N5izD/scusu93qOU+W5Mbqhyv4rkIB9zLNLarZGzWYTJJ44/HfBCGzCrVte9kbIt2dmv0UUdoZpHe+/79A5Js+4MyV4KIOy0PsiqSMKeSfW2OvpJlcK267NkcZa9QKa1iirfFvlVdua9sF/tKrhLXS62rtXLkdDLu8plC+OrbrzCUABjXsQKctqkA5VlKWTfBLk3mECNphenLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUK10HJRPMVR9BWYkzpYYXowqGTKgzckgHOEj3d5TwY=;
 b=ZF4taa3GrYJQnnG2JKyNHADmrR1DwM1cM/qXiskwxqdvAa3vltyMGWUL9ZMpzWZXEckyvK4T89GvmAztOteRu1Hr1MC0edPsjFoUiPCt0eDA/qUxAyw9Mk7xk+Rqxt6+0Tpp20DYATYrch4It5CMKOas39JplhrKYSFCQWdwatQ=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by DM5PR12MB2584.namprd12.prod.outlook.com (2603:10b6:4:b0::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 18:45:22 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3d) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 18:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:45:21 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:45:18 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kun.liu2@amd.com>, <alexander.deucher@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Subject: [PATCH 0/2] Add DWC3 controller suppport for AMD's platforms 
Date:   Tue, 24 Aug 2021 00:14:47 +0530
Message-ID: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b3a621-32ab-4ac3-218e-08d966662972
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25840C0A35B3E15D92FC05D2A0C49@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1vl6fvYJaKtykhf/0FSLKiOK2kmUYw1VMn4AofWHfqrQqYUXkx9g3NBOD9MwYQ7WSUl1flczqbviF91+zoPF1v/O8B3WqmHhv232Y4A2Q9AjHqkqgVnad7uVoulAlAVIuFuzDHEM/zOlka3tktC5a5aMGFpZKDh5CWhDv1q98Y84pqnW/xXyXtH2t4uJQxcPTDoGNKevPiDgIz1nHAetUaLsxbuL99Fv0mptCyMw/0A8v4EtWX8ye9N6WWxYlFihuMmGD8zNYuX+LA+l1BgAIQX0zhFdBNtFjUk7VY/p56rvchbh0ZTGf+3J2m1XT3akRVSc/taJ6oZZKL2fTgemqWAU8BD/JupqSUn8B07q8MmBb0pW5nYGaNW8FgMIR9zzEojpzjSVZm6E1pzYSFbY5wpYAFBINUMFIMTY2bSiGYBXrf+WQP8rF1YUXu1Efui15YhRs/5V9GvNdpAh8ccwSxjUtVR2YAbPB+7qbfY11NXn/lAU1ZEIl4sAOEn+JaGRfzBQV3UGadhIAZ4TalbSHE6M4ULRm+wcv0D3z8uOYFqF5Y5lHoCGhxT7wjZGENlPgfgNhncZgpGJcD0JiUw/sa8XBIEccGdhCzWVRJhNahmhk5v5lmo73/SOLdLTYfmVRsbpacKL+n8ziC05rOKGrMl07UhMZ8yeea9LUp5oJwz8B+YXhBNXd1BZDDfHkBPWQ3WBQp1mgLWIQWHziBXsOpzuuEhSUGacPlM6KOmaWZrRVrvCHvlzU0E6JGgXSLvV1BLYy8LldlytKQvJX/hm5SFmK6IJ2Uqfj4+jwZYE0k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(70586007)(110136005)(70206006)(4326008)(54906003)(316002)(7696005)(4744005)(478600001)(81166007)(6666004)(86362001)(356005)(5660300002)(47076005)(8936002)(78460400001)(1076003)(26005)(4743002)(2616005)(82310400003)(36756003)(426003)(36860700001)(336012)(34020700004)(186003)(8676002)(2906002)(16526019)(82740400003)(49343001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:45:21.7248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b3a621-32ab-4ac3-218e-08d966662972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer generation of AMD's platform has DWC3 controller. Also there is 
a requirement to support user space role switch control. This patch
series addresses the same.

Nehal Bakulchandra Shah (2):
  usb: dwc3: pci: add support for AMD's newer generation platform.
  usb: dwc3: pci add property to allow user space role switch

 drivers/usb/dwc3/drd.c      |  2 ++
 drivers/usb/dwc3/dwc3-pci.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.25.1

