Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04CE3FB5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhH3MSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:18:32 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:46432
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236921AbhH3MS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9GVhJlxBqh6edjDPlfwQzNNB5rEwUGJr2ZNccWvJ+iTMXQSizaXjgg11iEe/JcfFJgnylCELgJTpg6RqkaM+9TYKLwarCDpq4GjtgqYG/xM1PNnKhs94hVc3nNVSvjAYtdMQL5bl38sxp+YPSjSuEyEhCrvT1vaQ0ANqWeCXyI6X7r8ppxZWsGv631ht+TkWYHzf4mw87KTFwzpOXazh8DACfH0ws37FaQ4HkPLlxGloUdRmf0J0tbVFKhzcFNI12iuDf7Co5CGZfZvSK0Stn4axpsUTiQRMKlzIAE6ygVxqv0IvJxXhboAmB0v4KRgMUiZV+hzuNPwSVnBkmZnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtyTjGiSonHed2V7DLF/LwlcEKYZsrMBHRQagObBULk=;
 b=g1uORvhCEQYuQ87Tel4emVRSn5p6c3GfavM+km/MBVHLgdSqeq75wNEA7sP+rBaeSKTmaXivdZ/+STMkYKBU2J+kViLo/5LeufXGjdNEW/pQee/fQSUQkHp8oZTR/6oTrJtZCBV+gsFZxW4xtrVD2uTrtEYX5A132HArdcWncY07cwdc3PyNP3pCc6BYU4iYohCiHpbu88XR5hd32CM5FeI4w/4uN/qMkYRKnW99vlCHSfmTZcz9UHVqXaTEx0N/0UDTSGXyXvX9lYt4ZW83G6wph3iZcb66SFjoy25qRRoLRwjflKjiWuMG61u/OVw9asL0rU79wMGP0Ajc19+Tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtyTjGiSonHed2V7DLF/LwlcEKYZsrMBHRQagObBULk=;
 b=ETsTiTnTavwEu9GnztOgRtkM8FF1QVO7SGGhxVYN+9FztuwNS/s8ErNky93Kf1BEWWLC+Hz20gl4jk0hT8XfBxzqOajNFE93ry7cY8WGR6SsO1m3IDUOWE2s9Bf/SdJzmLV+OEwENkEGKiMNfAMohzqCvILAjDGClnZOlhhFlZU=
Received: from BN0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:408:ec::6)
 by MWHPR12MB1583.namprd12.prod.outlook.com (2603:10b6:301:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 12:17:23 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::f7) by BN0PR04CA0091.outlook.office365.com
 (2603:10b6:408:ec::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend
 Transport; Mon, 30 Aug 2021 12:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 12:17:23 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 30 Aug
 2021 07:17:20 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <kamezawa.hiroyu@jp.fujitsu.com>,
        <lee.schermerhorn@hp.com>, <mgorman@suse.de>,
        <Krupa.Ramakrishnan@amd.com>, <Sadagopan.Srinivasan@amd.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [FIX PATCH 0/2] Fix NUMA nodes fallback list ordering
Date:   Mon, 30 Aug 2021 17:46:01 +0530
Message-ID: <20210830121603.1081-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f65406-ec85-4a67-53e3-08d96bb01f72
X-MS-TrafficTypeDiagnostic: MWHPR12MB1583:
X-Microsoft-Antispam-PRVS: <MWHPR12MB158308F9BC78EBAEC63384DDB0CB9@MWHPR12MB1583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anaBALl6o6oGX60reXoxE+Nt2VhABg1DzOmqkf3H8dRLFOeynV2CEG6a3B0GD19LMNCY4biAEgcuCYSyjUBbh+Xfwg/XJ/KpPaEHeiPxg95nMpFjlTc6qjkh9Ou5wwZDmjJMsIPWrUe7AKTDcPECdI4uB8cSCP+ju1waaMHF0rsvLM9iUl+2LPSNbPQHSpmA4IGe/s1XtTrUW1TkSrQH6ysB7V8AhfGs8MuDfX3j7ov7m4EMVuYmu1nKc18Q1GgNlWIGyD6+sDEoAqdRhzMcpTPZxiyvCwPY6l3YFl9LxeJvAgKiH3M5ISw7nfIr2ttKFARY+8PXdTM0HaibzdNsr5Tzsit2uOPo2hS1bU+jmERdc8qRk3slXr4FrPEkiDzs4qM63OFUjMOCZ4bPrRD0R8VH/W2zSV6d2V+iaRqa3CU8SdZZiR6yI79TrF77OKRtxyfQE9q2dIhALKgEOp+Ij3BqKxRjXC+1r/1LUkFEv3bQrPD1qQ5fGvWbtDLPRwaIKzwiURBw7MjyGtbA1RC0qtnEV3q1EuweL1jp1ZCGcwvov2lVG1OS7xRKFv8iOpU1s81UUkrtzrCZFlyO7ArWE3lmnxRSt3yVhA1d2HoTSdm1/NXbZkRYfgn4/U1MzchX1W/iaWn/AS9QKfXxJxlaQgUhahO8BrfSFHIubYLoTi+vYwpl86N5eLlr+IE5xlYYMBWNk7geymnX36kV78dBuHfM4AUwYkbgbdi+MHmUDILUO9vCNwrWwvujqDB07kvm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(7696005)(316002)(82740400003)(36756003)(81166007)(6666004)(4326008)(36860700001)(2906002)(82310400003)(110136005)(54906003)(5660300002)(336012)(478600001)(16526019)(26005)(47076005)(1076003)(70206006)(4744005)(70586007)(83380400001)(186003)(86362001)(356005)(2616005)(8676002)(426003)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 12:17:23.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f65406-ec85-4a67-53e3-08d96bb01f72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1583
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a NUMA system that has multiple nodes at same distance from
other nodes, the fallback list generation prefers same node order
for them instead of round-robin thereby penalizing one node over
others. This series fixes it.

More description of the problem and the fix is present in the
patch description.

Bharata B Rao (1):
  mm/page_alloc: Print node fallback order

Krupa Ramakrishnan (1):
  mm/page_alloc: Use accumulated load when building node fallback list

 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1

