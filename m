Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C219B38E351
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhEXJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:28:09 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:42363
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232614AbhEXJ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjhgAeO8wwJW4KWCQ5dJcdiiM3zkqcsTMc6JFrj2uBwgYxjAOYWK/vTB5spDkU/ZDWG+0mFLWpoTkzy60NlSTuFNJxUjqWD/qzxTfEoWMx06QHNc4Q/TtqzoC7bofzvqNLyn/BMUEAs1D5+5q+NQAAcMtfysEjXIBWCW3UsJCafOGBATyzvpoanfP06qg3GqJULx+44+OISsYNGgEkxckGrwN5gb5z4i5bfRcvviAb6VxpXOYbHP2TK2X13DQWc798JjeaZeMmlGiH89vi1F3GRx5PfsaOixfxtJ3exoon3B8SxOeKWzMDn3+rOOSOrstLU9sZoOkP2dQOf4kEREcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M0nJU/y2MKjtfSlFmSxDKO8kQQbJQf3ehgUixbHk4A=;
 b=ixj30kcvisQs6iMv8pQKHVnqGadRLMr94irbBwGYYkgbMlddrvUNBHrkW0AtMO0p1JzpYoGqL+xattSTGiARbZKKU24tYNiItDV6FgaJRxs/POgKl/GI07Fea0hq2B9/K/VbEuPe0NP5498V9xh9NXkwEsbGkt3w8NxL6E0T/3sJ0YgAYqWG7pWeKBpQw8Ex3YnAfm3066tThVCl7jlM/5bcWqRvg5o0vA+g2bm7R/vniBPoIH49pKXAlN97GB+5Pn1qD+sRaO4lmhLgAIEarr6KXJZUMqvkkQihwa5pdBEybs+tiuwUYSox2/du+MYzy6SPQx4/1CtQWBLhluaW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M0nJU/y2MKjtfSlFmSxDKO8kQQbJQf3ehgUixbHk4A=;
 b=bQe6+eQavRbTPBlEHoNu5EwVQTDryAlJg9MvZOs3a+mthU2FfQI+cVUTjZP3X87u5mY1YuMnWZTPzWaYKMZAEUGPyuGNclLhm8/gxL34IG/kEEMUI6DSk8UyKMSX9jK7oeEL9RxW/Xwi0/1xcNhUEGpL3t7rmn3Sc596fM3th5I=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6188.namprd03.prod.outlook.com (2603:10b6:408:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 09:26:27 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 09:26:26 +0000
Date:   Mon, 24 May 2021 17:25:29 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 1/2] kfence: allow providing __kfence_pool in arch specific
 way
Message-ID: <20210524172529.3d23c3e7@xhacker.debian>
In-Reply-To: <20210524172433.015b3b6b@xhacker.debian>
References: <20210524172433.015b3b6b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:a03:167::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Mon, 24 May 2021 09:26:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 212b5db6-68fb-4623-cbff-08d91e96014d
X-MS-TrafficTypeDiagnostic: BN9PR03MB6188:
X-Microsoft-Antispam-PRVS: <BN9PR03MB61886206BCE947C8E13A97AFED269@BN9PR03MB6188.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVcBFegMUBkO7fU0YjcOqwYno3UYFc/Jgq9KIewO2toWp82wXWMRVvR/uMP8Pj1iMYKU0RMkWhrYJTCytSnwhV2GLiBCH1FngUvinN+aKSmySXZqACsmpU9Wf3tRQ0vUGeg4u2oTLfMjBBvaqE7ktuRjGPDyOjRPuwoft2fBGgAS02o5jVhvzyhSThtkuH5xjkmqZ+6DM40YzrGosvSJjm0lbvLXLE4dtLigO7nSwRWAx40+o7lqgy5I9Cblf9DjfTVVlr44yVKpYPaqUKqasn5ns7FuuuY0JT1SqOanr2xflKTG3RvXMKU0KTV3p5H5ms3eFHGombtFZrJjbZG3FgIvU0iITX+5Leu0nC2V99Ik7kkGbDCSsAFjj+XXyO/VA4mEv6aQBan/SSmBWYugMGzt6NORGZOYXe07mlY3Rvq5sgpL4DpexV98kMTk2xCOutr6B1E83u1OkOOD5pKuacDXHH/OQmkDCjhFDIEYmpn3GBWWw0N2uCvLOMHnsW8/zRXuTVILHha85Be5vvVAyqVorZlSnX1Uqtz1FTCZ8OzYY5qal0tdhRnow2v82MZbBb5XimXVzI8lmguiitFRoLneW3LjpqvzQA35AXJ2svaOQGO0HVzi577sJXVkJjOX1Uck8KyDS1AA0jgaG0LtqiokWGvU5Ry/fkdZtguTU9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(396003)(136003)(366004)(66946007)(1076003)(316002)(66556008)(66476007)(5660300002)(478600001)(2906002)(4326008)(110136005)(7416002)(16526019)(186003)(26005)(8676002)(52116002)(7696005)(956004)(55016002)(6506007)(86362001)(83380400001)(38350700002)(9686003)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0qMlpUMKtnluZ2JfT5oP48G8nX2hVfICByh/N/wcuAkrhB8IuWJZgphE7ICA?=
 =?us-ascii?Q?VjBTyXkYeTbAH3V4ntXhCqmNRFXzhne7EZeI1OG7HZaLmGsvRc6DQj92pkao?=
 =?us-ascii?Q?V97ynW88BRkGat2lQbAShCJB9W9w8X7IWw2oQEyjo0IDTBnFhig0fFjcW5WH?=
 =?us-ascii?Q?SSKdmc37u8MmOoDwI4zE6pKUPxV3VFp3ybPymTvEsqX6ZF8niLJRD7d/Ak6U?=
 =?us-ascii?Q?O+Y8T0M2yA+Jif6ZTEnNvmhLU4K304LlhKJCCIVuszl/2eKzCtAkVnoUugom?=
 =?us-ascii?Q?O6fz4n26yXuCOBdUsCzldkwiMtUECyrUk5fRLauVBDnHbnJfvtELz7Jrjfcr?=
 =?us-ascii?Q?0cLDjMta2GXVCRVhW8iW6qsrZD6uIdGGpUQ3kln5oQGUDXebOgwCnQ7GtZZs?=
 =?us-ascii?Q?jPn5IJpQz/7dZ+CuBKgBj4piP4d0RmvaqLkCvTmYVTEy9xkIdmf7+8Jir8wF?=
 =?us-ascii?Q?DsgaNTWcTz+v85KJbzxH5SlxP1yfWbZCQcFsjK/F/gFDqELm2YGSx/Hlfzuj?=
 =?us-ascii?Q?mWYV52iAWVw7ozyZ5koixXzwiuBxH0JRSdhj4BCmqe2tyBxcA8maUwpxKB2K?=
 =?us-ascii?Q?f+WCXDXzFP2UXa+i+Uy3iX+kmpUcR8eOBx6bAD2KSh+4gval2Y54yDpMdXEJ?=
 =?us-ascii?Q?/7+KjzjIsOOvVYmPiLcIpZAH1YVre2ir1P9JsDDWR5ynHlrr4Icgy2yCQSw+?=
 =?us-ascii?Q?+aObZO1/WLNtyL4RsoMmPkG1yFT/x9cLyiqfGvdovAvNULNmJ//kPG+Rukn3?=
 =?us-ascii?Q?H31DUk3bwMgj/zkECvrBXTgIu/6G5u/BcF6jnWsw56QsIhc79D8MtXuFcB8C?=
 =?us-ascii?Q?RHOoDy8OrUHYp9oliQ2A527QS/MjfxLlIYuAlRGVwQs1dp7dzHwtT3G4IxYv?=
 =?us-ascii?Q?F7nWHfZjeo+OnoryC62qmHvUbroq83aTzX0iTmvmSyhqgj8xyeAd2RTHcH+W?=
 =?us-ascii?Q?BiU2VAExk5pwNzbdWN39YmG+1VAWZgubfcOXaSY0gUiHCG0S8Dvtjmo3mwbI?=
 =?us-ascii?Q?si5dpM7N9nrjcUMWOHhyXtt62lrkG4f/J72H9sAM+5Q+Qp1pHiggMACKZSR5?=
 =?us-ascii?Q?9xll5ufa+j0Fx8aGjY+3/bJRUEyAUe0Bj0gaUdq9w54hbUxX7Ikwko3WQFM6?=
 =?us-ascii?Q?E1FT05DO47y37FUNNrDgtveK8CHKb8rdExeIxVS9M8LxpUqjEU6mYaBUIGcD?=
 =?us-ascii?Q?FNZyS1FWcFB3WA3v0lf5E/LmgD7y3mH0cyGcjA77FW3rmTVuKPika4tfes8x?=
 =?us-ascii?Q?7/S9FZulgk55YiGuyPIHH1nmv0eQpIbfm+I6LY8BhAjbKBlS79+A8dHsO1mD?=
 =?us-ascii?Q?zqZ6+JbHQLdAOGOA4PhsODAo?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212b5db6-68fb-4623-cbff-08d91e96014d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 09:26:26.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZRkAq73ytDBjrW+o+bNwG4TB+9naOak+z8LepMTL09TGP1P8l/gY0vREYptP6xErxvf22sfleFXhzBH+wATbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures may want to allocate the __kfence_pool differently
for example, allocate the __kfence_pool earlier before paging_init().
We also delay the memset() to kfence_init_pool().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 mm/kfence/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index e18fbbd5d9b4..65f0210edb65 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -430,6 +430,8 @@ static bool __init kfence_init_pool(void)
 	if (!__kfence_pool)
 		return false;
 
+	memset(__kfence_pool, 0, KFENCE_POOL_SIZE);
+
 	if (!arch_kfence_init_pool())
 		goto err;
 
@@ -645,10 +647,10 @@ static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
 
 void __init kfence_alloc_pool(void)
 {
-	if (!kfence_sample_interval)
+	if (!kfence_sample_interval || __kfence_pool)
 		return;
 
-	__kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
+	__kfence_pool = memblock_alloc_raw(KFENCE_POOL_SIZE, PAGE_SIZE);
 
 	if (!__kfence_pool)
 		pr_err("failed to allocate pool\n");
-- 
2.31.0

