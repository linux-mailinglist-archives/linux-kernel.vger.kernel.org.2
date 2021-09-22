Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701D541405A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhIVETk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:19:40 -0400
Received: from mail-bn1nam07on2048.outbound.protection.outlook.com ([40.107.212.48]:9863
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhIVETi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:19:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV+kamLt6pHWetF70PXdwda4g5+vDq+0qDGYdXdLeYJA3mB1PmNkkY4ThqIJTBNc8hH+h00EzuaV6PrlPP8Y6IgrUX7lKlqQGahOjeSp6rMVpON2/gjfmL8IxNJalsysTpqjG/PpIiILlZifnLCKh6XVCcCBuZjcxg5PE/JDxaXE9RcjNow9XB9m6JaW7anVhpjgXh95pdJuZsbMZxLQoJnhOTOqypz8fd7NNYV/Y1c3tShXoFTiiHmbw3x+yzHBzHrksBcjKbt0xfmYMXbntLPDAGOeOe2A6CV5ZyfHbbwEugyi86RfR/ZkvoUL7DbpEKIF/nnJQd3TZgno7a9NNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s5R00q9ddpO3OeyaNirZwbNdVyX1OPP7qci4QDPMAtU=;
 b=mtYYM/DaDp0YJCzws83rqwaNqUY+kgjEWedw5ggk9P5oOkv/jobRinVoCPfx6ukAWo1mfDKN1kO/0jQfvw+e2jFTI9Is0DQm0xnqZjSwtj9QLqjV1LS3CdiAO20CoWgnS2rZsY0hvdQsdgvpl1OicPgnIDEUTaa2mRA4munQ4Q9AtXapKAO73sBdNIWxJu1x9papb1VKsv6+4u3zRb4GlZY+7IGWaoycENGR0fzup8FoY+3ULciKFvYUxLB9vVF7S15jOOArUR7z3WM9sz/0FjFMfuWY2vWpCJJFSB5PLzhvtsf8XQHWTamQ4pd0NkVDb7x+AD7RmkPl5AphqfJG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5R00q9ddpO3OeyaNirZwbNdVyX1OPP7qci4QDPMAtU=;
 b=XF/qoq9yQvDuK7uk4VUgKCfWlM/XiYAG4FWgFBtPRXa1VeyfGw/fvgndq5v+dPfCPmZOkKYJvahrYV+7AMKCr1LLES8WVBChHa81S/lI/FoCFsV6e+JkKndFNAekTYLEMfMEVg5jzlzyIbzdzQAH11Pr20/e9NIEx1g05MbzMyp/J9KG/qnEOyyKJ1wXp/JlDm2I6xicCO2klomtefJLX7Jn0UZEmsq5P+zFo13x6CNW4qwWkdw6h86VWUaf+RE2nqqD8+YktzN8Os25prZkzhH7e4L/G//dSdgcCAE5s1JlSx/jofVgJrNHUZHkBJVEq27T432qrSkpWXybHmkiKA==
Received: from MWHPR1701CA0014.namprd17.prod.outlook.com
 (2603:10b6:301:14::24) by CY4PR12MB1592.namprd12.prod.outlook.com
 (2603:10b6:910:d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 04:18:07 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::92) by MWHPR1701CA0014.outlook.office365.com
 (2603:10b6:301:14::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 04:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 04:18:06 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 04:18:06 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 04:18:05 +0000
Received: from sandstorm.attlocal.net (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 21:18:05 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     <o451686892@gmail.com>
CC:     <akpm@linux-foundation.org>, <almasrymina@google.com>,
        <dave.hansen@linux.intel.com>, <jhubbard@nvidia.com>,
        <khandual@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@suse.com>, <minchan@kernel.org>,
        <osalvador@suse.de>, <pasha.tatashin@soleen.com>,
        <weixugc@google.com>, <willy@infradead.org>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <ziy@nvidia.com>
Subject: [PATCH 0/1] mm/migrate: de-duplicate migrate_reason strings
Date:   Tue, 21 Sep 2021 21:17:54 -0700
Message-ID: <20210922041755.141817-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 281ca7ca-1828-4be3-35f3-08d97d7ffaaa
X-MS-TrafficTypeDiagnostic: CY4PR12MB1592:
X-Microsoft-Antispam-PRVS: <CY4PR12MB15920D3FB28769192ABC7EBFA8A29@CY4PR12MB1592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4knDBQ6sD/oMibGxmn7mzfrfxlAB0lEclB7qYiUMolMxTWQA4avwA1lZv9XX70UZ3rHyQarqCmhC0hEW2xFRrNB9nVm695UfELZmi5phhamcdreAMVO5oDOkgisEHlqB5L5RO1ZTkuzj5QD5KVsw9J2F06tJJXqndJYoprxK1/4vr1ityUMEuGgaQQ0xdGYw8itVMFf+LVYym/HQY4kXrMsM4w8VBP/lbYg6zq6i62uWWFL5vzzMQ3Dns68ZCXV9SY6Qf2IBXKqwzaB28bt4WgtFGSHO1guyVEQCJkeonijUnkrvivIIEVzfXfJ2qLoFG5mZCJuCRnAoUcotLFbGwKdr/QDM3/DPlFu+0cE5o+fGqPtW8fbZ2qmItJGRYOv9sgxU/4ZIi7IuA9EcahULaVnI7IXt2DpUaXYXQJi25Md/mwqm05x5DgI1wq6C9gpG7JcEPA4plR4Pn9zx8CuDKDK9cYKbZNtsa1BpjjyDZEazogmIvjpxf9kUAvN6VjaWEUhG4m1m6n6pGUBinLz16QjY2FiIOGQHjq409i++omBjJcZDAoBHzGWBj0gXhIXyvStupHYaZuhBifCmkDE1Wb22xyMg70tqZxG4/p5/v3+9PK55Xi8sIgMBnmMpPqCForUgglsLJHAdz9MKet4k6hq7DGA+XfRixCaNd18YHh01gDR7KA12+ApraTbuEduxJEyN7twGCwHR9w9J9U+UpP3BAQhrpLC891l1Ba7fBjMHlwGf6Fm7AasZ2z6bZWw+BG2xWWuh3sLjVxnRy5EVHOqnaqKt+oE/8imnaKVmXo=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(336012)(1076003)(47076005)(2616005)(4326008)(8936002)(83380400001)(26005)(36756003)(6916009)(8676002)(2906002)(6666004)(82310400003)(54906003)(5660300002)(426003)(356005)(86362001)(316002)(186003)(107886003)(966005)(7416002)(508600001)(7636003)(70586007)(70206006)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 04:18:06.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281ca7ca-1828-4be3-35f3-08d97d7ffaaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1592
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a follow-up that avoids the need for a BUILD_BUG_ON().

Pre-requisite: today's linux.git, plus Weizhao Ouyang's series v2, here:

https://lore.kernel.org/all/20210921064553.293905-1-o451686892@gmail.com/

Testing: I've done some cross-compile testing with various .config's, and
a short LTP test run. However, I have not yet attempted to verify the
actual reason strings during debugging.

I also noticed that migrate_mode is correctly passed around as an enum,
but migrate_reason is inaccurately passed around as an int. Not sure if
I'll follow up on that, as there is precious little (none, actually?)
type safety assistance from the compiler in discerning between an int
and an enum, so not much value in fixing it up.

Cc: Weizhao Ouyang <o451686892@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>

John Hubbard (1):
  mm/migrate: de-duplicate migrate_reason strings

 include/linux/migrate.h      | 19 +------------------
 include/linux/migrate_mode.h | 13 +++++++++++++
 mm/debug.c                   | 20 +++++++++++---------
 3 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.33.0

