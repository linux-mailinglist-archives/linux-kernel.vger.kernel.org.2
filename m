Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6FE420993
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhJDK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:59:12 -0400
Received: from mail-sn1anam02on2085.outbound.protection.outlook.com ([40.107.96.85]:6230
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231901AbhJDK7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:59:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiXx4eHDi+8amHeZb1Gq7bjTW0VFFvlEyNSPicuPXkrQ5J1Xwbqv7PYehfmKg1HPUhnaHPzB3E4vpGPLHFDZsJs/6TnhqyR+4WkHZsINK/cyU/8lj4iqHTH+yNN6OgS9k5boIqTnDHId5dJAPRbvAP1UO9Cbs2SRdRUuo2TTEMoM8J9corAtcAHnbURDliHaiVK6ApPsCszxPu9ubNJlYEqVMMOlLZXiPTwrIzcQ/Y3un0bewdjl5GsgDH+9OPsczlVx/cv0F8e2bndbAhKGQSHvoD7ShcY4q0g5iFKWH9MjJipv9PQYneD5gOo10R25RHMOOrye93O69jRYfhv9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMAItgvlKyoGFxav+RqJB6cznSlKL3JW5ZRXuN3s3Bk=;
 b=AVMDZzC5RzNjNhDdZrgGi9H2t+PzD+AhYHMrfbXYwMtyEWOiPn5Rlq0baHzRr4Z355sFvofoSw4Xq6vxbqqO3JKYU+VfibAuqSnx+vXk7yKafCqvmPwoqgQJr+OTkGoLZqyaweE7/2PQSveinvEiOAceEnrkDpfBA/guzPLumKxd5ljHNXNDN6NwP6kNmnp7yppGuz0FLyJIe4nNBbrujj4ti8thTOQoU4KJbFx/bUB7A2/WI6Yd1PnThfGG2qCQy/eg9owIV4YnOdLFGTBQPV681nWkFCiZaKzP+U3OE1zEnstmge/fbG4ENsB5Qwt7HPmsMGy2KhXMPI6vYsjskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMAItgvlKyoGFxav+RqJB6cznSlKL3JW5ZRXuN3s3Bk=;
 b=h8qG3Mwu0//19BvfGkfIRsyc0Ubx3oxunvCsvd8eMU/CefbfDMsYPU6EFOKP8DvaxHCsMZXx8axe0+XSWlKHSdkSdZTALs1YNCYlSyj+BjdlWx9DnlCuA/4TT7AlTgZ3X5CNtGFpHUxhKmeRicQ+Dh4CNcOrJY9tv63CyY+Eo2w=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 10:57:20 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::7b) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend
 Transport; Mon, 4 Oct 2021 10:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 10:57:19 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 05:57:15 -0500
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>, <mgorman@suse.de>,
        <riel@redhat.com>, Bharata B Rao <bharata@amd.com>
Subject: [PATCH 0/4] A few autonuma cleanups
Date:   Mon, 4 Oct 2021 16:27:02 +0530
Message-ID: <20211004105706.3669-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84171101-f245-41c5-cbe4-08d98725bc7e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4423F6CE07BDF7B755A18F77B0AE9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oM6rFiTb6MvXayPNtdKEdZAIuajb4ZbxLWGW3t168ic2gi8Rs+i/94oiRSkenJRmayNd81jqTfKo6iJhtkJ1mz5WQZGNWmHZvjPn5yUR3oWqQQeV9EFMowmp8F+8VeYo/4fXOZu6Wfhgrtp0FRm8g7AFFdxKeriGevE1bu7EnysjTbJ6Tz6D9cJmkkA0DPG0y9b1G7s8EK4uq5c0zpXAoy0ZgGmizAEkDCFIvQE4nF0hlPyUqK1lqoaBmDWWK8ojnJLPwJ0OvBoCpOvu4jUEyr94cLzaBs+eHufBSFvzeYNt0WHd8Ic342veLyU/yPVcRzAMydODN7EOS0keybxz/NbsF/PDdpTJ36WD+VLxT1yEcUb9aOHN6ElqRPc5Z4HCqHX08EuuvrgXcqFG2qxBLdIEpTesApkeAuDICB5iLpEsxNSaCYSsl0jRtWDeXJx08ASiIaKl2v4PmSvL1KCLplNXdrUvZJhlPVLsgYkIUcpAVWORpaF2qI79aP5Gji8nRxTm4HCJrHEuHQjYBWjqKXBcs21bmf35fgKuE8ZpxNO3/cppQRfkY9bwDhrpKWi0R7Fy31OKou0yRIzgZKA8nAJ3fclKufvONMORpQ3FtB4GlE0ojvBGShnfUMZvgsBDlLWJd2/iuXYUvf8SBqmnl9gQz/shMv9vgUKCTL2wCbxMIWzBRe7FGdXVG1KLW4KhLXnCN19mUIXFBq5OZlKEQOUUOV8AQtRa+ZMDTJcjfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(4326008)(8936002)(2616005)(82310400003)(426003)(83380400001)(4744005)(6916009)(2906002)(336012)(86362001)(1076003)(6666004)(70206006)(186003)(70586007)(54906003)(47076005)(5660300002)(8676002)(16526019)(36756003)(81166007)(356005)(26005)(36860700001)(7696005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:57:19.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84171101-f245-41c5-cbe4-08d98725bc7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few cleanups to the autonuma code.

First three patches shouldn't result in any functionality change.
Patches 1 and 2 are fairly simple and patch 3 is a trivial comment
fix. I am not too sure about patch 4 and hence it is RFC.

Bharata B Rao (4):
  sched/numa: Replace hard-coded number by a define in numa_task_group()
  sched/numa: Remove the redundant member numa_group::fault_cpus
  sched/numa: Fix a few comments
  sched/numa: Don't update mm->numa_next_scan from fault path

 kernel/sched/fair.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

-- 
2.25.1

