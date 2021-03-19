Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98577341210
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhCSBYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:24:08 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:43392
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231375AbhCSBX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqMhMm0PI7VKg4GxPHPbotYiBcojr0+nLvdB2ee2x/47V2H+J1EEp8XMu0CWyViLb7VsjswvodJNqAzP/o7y5qJf6htSLz0S/juYkaPRt393HrfeYImtzBgAGpO2aX3sl0dnhyly0sPUfRdE7Fm7UMPuxVfwpwiLaXKdlhPerMN8/Vj+Wzmb546UzqRoJo40KxygGITtwy/r4/GzjhNPr7LXua1nz0GMVgeCdfn8PyJKvQ5s6DFw0bOMPz20n7WnbjcnUvKgzWNZ1HT+xc6bxVPjGA4PefS/0kIFB7hmSx+7s3xp0lzy9/1s6i7+whINM6CIxuI0FlpBjs6O4/w+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUPOVDzeOM1lnX3E6O81aEglFvA7amf6FgUqTfe5F0o=;
 b=P9Sn992Fv83ylwMKooEYLQbhc1qbU+zQWbvq+C4vQW5DfW1REXaTJJV++rQxKCBCMG3J5GKHGbb6yOC2ItXpi3C3HHk7gfCaegwx6LbcozgJMGxu+U3V4LZLeSe02sp/xRbrBaaHglMeYiMNElQo7p4w0XJGA9dElNuY1QCvgjSRuFfa1e0sM1XbUqDvKaK8WeaQc7EiGy9tVLD/BbMaRVyqHC+7z3brvwT2sI5KtYQiOPg4ocSQLfrEOB0iCRYxX7dRbqfJpaVCZtPQyp68PuJWJDd93TQ8mhak/c/2NvNHYKIvIy90wz2WaRPlh3eSyIrfwq4Phpb3Q7UIQYAFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUPOVDzeOM1lnX3E6O81aEglFvA7amf6FgUqTfe5F0o=;
 b=oGnBNkLrRu+ZfA4RA5oY57eCPIzACFbBOcoJcwS2hp21Y++o7EQssY65SKEsKoGMDlYc6R5WBavIzKsX+Blv2mfhoPLMfEDYSA1358ngZ0fbgR9WL7v21jnaiieOwGbLc5s4SoM2jLm/g1EhMT1QVkzhGPvIm/QOzGyBpZpZajA=
Received: from BN6PR13CA0048.namprd13.prod.outlook.com (2603:10b6:404:13e::34)
 by MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 01:23:53 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::cb) by BN6PR13CA0048.outlook.office365.com
 (2603:10b6:404:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Fri, 19 Mar 2021 01:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 01:23:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 20:23:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 20:23:52 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Thu, 18 Mar 2021 20:23:48 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <shumingf@realtek.com>, <flove@realtek.com>,
        <derek.fang@realtek.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] ASoC: amd: update spdx license for acp machine driver
Date:   Fri, 19 Mar 2021 07:10:43 +0530
Message-ID: <1616118056-5506-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8788de3-c263-4c1a-5030-08d8ea75a882
X-MS-TrafficTypeDiagnostic: MN2PR12MB4607:
X-Microsoft-Antispam-PRVS: <MN2PR12MB46078381C5F0C348D4652AD097689@MN2PR12MB4607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fqn07Clj9mCL8kDQtZHLxiA/73ZgxCWuhlNjnnp91F+2kVcNFjFWFa2+OoF+jy3rpJtKf+pNQW7R66+aGKHBCw2NHC6rDa6/o/PtRzHBUXX28VuwJ8c2RVtUkmCk2ZM5iDvK5YDtlr7zeVotnxkCk/pdl/FzcuYC+oDcBpepDA+BIaFubmYsOJxTflW0Bbi+bCaPPxW7fQ0+uObmDgEyogAKRZzkC1jO987NVWaMs1yEvsCi7MjC0FFGUkzZxyLqhTsfsOJjYlqeYkXZslAYB4m9lFim7WG2HJ+w3InNwwjdJ2xs6bY+hAYEIoUE7QF3W4j6OR/Hgy+ZP04UYpDznGxSbzLt8LYWJI27JBU5IT6TdPi719cyybhxJp7vz2npwK0gcPUVHWZBKXFiLq0CuGbh7xXjMfhzz15lWJIYqTvWDASWcq27RW7TQMj4KPtWwokZP31nzYtShMLlUV4z0QDA7EXro5/5jnm4rSoBSxkL7FOS1IAHI8UAcsGgRZ1oY4tcZ6klnFUa4C/jlKdLd68CVndxNw4Ek90BBkFUj3BkCsya32FVffoy2pv3LfUN5aS6fy+6gqW+0aqfYuA0AJzZOkNyQuXibrsUzpljrqgAaIS4doR0UY8Z6nCYH+ykrAYAPHgVwBBcrGNOAGCa0Cbu7hjeimLzaO2NFzJ6AlmTY1xFbi/jBtB7g10TLaIO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(478600001)(82740400003)(7696005)(8676002)(110136005)(26005)(70206006)(70586007)(356005)(2906002)(83380400001)(81166007)(54906003)(336012)(6666004)(426003)(5660300002)(186003)(7416002)(8936002)(316002)(36756003)(82310400003)(2616005)(36860700001)(4326008)(86362001)(15650500001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 01:23:53.1651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8788de3-c263-4c1a-5030-08d8ea75a882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update SPDX license for acp machine driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index e65e007..84e3906 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -1,27 +1,8 @@
-/*
- * Machine driver for AMD ACP Audio engine using DA7219 & MAX98357 codec
- *
- * Copyright 2017 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
+// SPDX-License-Identifier: MIT
+//
+// Machine driver for AMD ACP Audio engine using DA7219, RT5682 & MAX98357 codec
+//
+//Copyright 2017-2021 Advanced Micro Devices, Inc.
 
 #include <sound/core.h>
 #include <sound/soc.h>
-- 
2.7.4

