Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41BE3D07E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhGUEH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:07:56 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:53440
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232119AbhGUEHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:07:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPq1Ou/iEgRKitoNWS5d38famT2g9I+tktifJhe5CqasN33rHeRIPrBJZ+L1MsfYGwKHw5GaOkNdlerYqMS0MLKWiOMEIljphu7+v/5aaIeQm7BU+8AD02d4t4d3alhy5OralPNyDo3tOEi3UGmWmH6C72Ivfh3+OLxiWrtXkJzgIJbBOuD/CZrilR3FooVRorZT+cv2gsB4uIxMbwYajuurCJAoqGY7D8jeliUcCz3Uc2GVT6VnP5vlI+qcOubPBGO871hR94GumhsMsV6w9wsOQyLhm7TI30Yio1BuhACPU21SnVuvPkiUAtEhtyQADEYkx4bpSxWj6MecrG7V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrzMv5T4lvXTDDAO61PU0YC1kmkH91c8l3sbzBCe32Y=;
 b=bCHeHjcgQF9uiYddAZ4M896m/myjiqimbnss3V4m9+YujLLOBHunM+vtZMRfMldZ0fTbs0m67SsQNI3u965s03CG6uaT5JSaRN3CT5vd8tkcno1nW1o40MVILjboSrB5zPsi+WSyv67tmZHxQ5q9DpUlz/3BORJco7C9ppQh4/k4btjsFXoBnCGW07aGUwGFjjgnVgnaG5G2XQZJkCVisxCQq9ZVvoGfrQfDfxF5eM2kAVpTC3c2w7cLO/jU0waVdThNWLP4Gj7a3B76e8gj08h5pUEExTcjx5qf/K4lvkx2sXgL9g1V0roNsNrhpmYmSm8LeAGFpJVtiG/O58IBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ellerman.id.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrzMv5T4lvXTDDAO61PU0YC1kmkH91c8l3sbzBCe32Y=;
 b=Jlb4Ku4ZcQZaofYPWvyZoEHBllgl4ryC4R3SotLCq17haHBbQ/umJl/W30gR0b6P/Va4TyR56lUuAgrZeH9cH2oj2MJAVNn1gEbYs3kUeH0jTR2YsHTsYRXznSRhgVgbarESO0AoeyLfFZfwJVBocW0+TQFd/DPD9g598PdArzw=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 MWHPR12MB1904.namprd12.prod.outlook.com (2603:10b6:300:114::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 04:48:06 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::6f) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 04:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; ellerman.id.au; dkim=none (message not signed)
 header.d=none;ellerman.id.au; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 04:48:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 23:48:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 21:48:04 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 23:48:03 -0500
From:   Anson Jacob <Anson.Jacob@amd.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <bindu.r@amd.com>, <roman.li@amd.com>, <Anson.Jacob@amd.com>
Subject: [RFC v2 0/2] PPC: Add generic FPU api similar to x86
Date:   Wed, 21 Jul 2021 00:47:59 -0400
Message-ID: <20210721044801.840501-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b57cd7-6f0f-41f0-30a0-08d94c02bad3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1904:
X-Microsoft-Antispam-PRVS: <MWHPR12MB190494D82B1C7EDB6A652764EBE39@MWHPR12MB1904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWnrdtgg7QSEPQ5A7nmhRCfvJTJe05roofGklhwzfVHVRw82rHSqSuryUSYmh7c4rUdsKBlY8Jor8ynLJHK3fzGYdOl2sqwlEx6707WPt9c+mg4qBVxPcSJp3mlkfsdQhqaKAGqN1NE3Jnj1oXs2GN+6x37JepgskK5pgubkzbpp1Sxl2N6EL2Un/zFyGc/PeviTKe8ESsyZlbt04IxA4f0t4sJ07wXMK6IZZl+4Tcwn115IQMuMq4Yzpkh9UWSpSCNmnAL3KP6mAus39sU3dKC/9PnPuk+1Wj3yyCQ3RKJQAD3lS6nD9IggqxxpPMe6MCOBH837wEb39kh2Omgew909bQ40ZSivA79GC0lkE9vEYCtKSGhM2Euw4rqWAAzrLyUwUhwWHAQ1nVLRdwntQ50fZNY+E3J6OJWJ6nbkIML830vdUPcKXjE1eONcgAvEfPBAEuJcowkoVWx7xXA7KKSkmPb2e2JtPM2Rh9N9Dl9B6c4gJQR0i4HkK3+QTxXEdDUUtxEt/P4Cf3QJWFcBiVwqXyMeMOIO45/isShVfq9E4/dFZA5VfWy4sjyemjBuLsppbap0bctt1FgwvNJEc4icWG7Xt+zVIMzghvJDoW6ruwH5XM3mx1PcNbvBrgvxJEUxxtIv1bIr15JxDB+77r9trcXqFyS4gXq4dJfhouOceRjElYyl5zyJpTIyM5sv6CecJqgxiGzsixRhz0CeNTMZZrGswTbpj3WTDnqdyoDBkh7B/MoiVc3eOjKneW+ZGVjVSGehgIa/mmqEYhVTkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(5660300002)(4326008)(2906002)(86362001)(186003)(8676002)(47076005)(1076003)(6666004)(478600001)(2616005)(110136005)(336012)(316002)(54906003)(36860700001)(70206006)(7696005)(36756003)(356005)(8936002)(81166007)(4744005)(426003)(26005)(70586007)(83380400001)(82740400003)(82310400003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 04:48:05.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b57cd7-6f0f-41f0-30a0-08d94c02bad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to have generic FPU enable/disable
calls similar to x86. 
So that we can simplify gpu/drm/amd/display/dc/os_types.h

Also adds FPU correctness logic seen in x86.

v2:
- Added asm/fpu/api.h powerpc variant with kernel_fpu_begin/end()
  and kernel_fpu_enabled() declarations
- Updated kernel_fpu_enabled as EXPORT_SYMBOL_GPL
- Got rid of macro switch for PPC in dc/os_types.h as header file
  with same name as x86 is added by previous patch in the series

Anson Jacob (2):
  ppc/fpu: Add generic FPU api similar to x86
  drm/amd/display: Use PPC FPU functions

 arch/powerpc/include/asm/fpu/api.h        |  18 +++
 arch/powerpc/include/asm/switch_to.h      |  25 +----
 arch/powerpc/kernel/process.c             | 130 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/os_types.h |  29 -----
 4 files changed, 151 insertions(+), 51 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fpu/api.h

-- 
2.25.1

