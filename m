Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BE32DD3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhCDWk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:40:26 -0500
Received: from mail-eopbgr700086.outbound.protection.outlook.com ([40.107.70.86]:4634
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232160AbhCDWk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOcv5b5ASmwoZEz+Q5rPAV5YRkoo6qZll+YAsU651Uzr1Kf24rjIAbntZIjx8ZoGOBqote0rugMMYOAjUPEyHjn+s+1SIsip8JFiPJrvfwhpHtLKQl7SKLcxTs4gn3wYM4aM+Hqf6KhPyWIORG2DW8GuuAj+I2r0MODfvB2kgSBrUbx9S59oyZZa1SQ35dVxYFg5IHML+HEgN8mIczV1Zj3sXqV1T1GlAsmJ0G3h32KmL/cQ/pn3UICawirGUKUXIOU2pVHEd8HVV4oEvzNSV68jE2rmRNYeG0lsHVZ1N+8VynYQAnYFSguCgur/VKJOZNhrPAjyQpNQ1/Dy+7qQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRvg1EOm+8IyfAujBtbCI5yOsEe+qfiZrIBNEBvMPTc=;
 b=EJ0RZGNKB+/ykzSVrefZKFKrZBD4QLiaDA++Iy36QCPa5SF44flKe2jNo9LnVyPakpoHGoksvf2VTM04+42Jg0BUNe4PVUYCTPjFC8RVfErCB+6lzhxzcJ3NnoN61XlsX+DibUXtrAJA2i+jgpHZCHkfi0jgmqPcxr+dhNbNluafj3M4RPRAKpW1T4mFWs1BgkbqXJfi7XZ0VV6cvDx1D9/bq34DZtV1ruftUGx09wWBs1quvQxNXhLbUysvzg1ZtLM3xxVi9uJiDgXYIdNBDIlhlxnhhpVfMzUPaQX5XIpHG6p78L1IddWcPq9ytR11iKX4Jj/SbYWZOuN57xc7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRvg1EOm+8IyfAujBtbCI5yOsEe+qfiZrIBNEBvMPTc=;
 b=ib6bpOMnJZ0xgNNs3K+aA+E3JuvaTBWz/L2CVMa21YqVIWoUFOYG9pkpL7nuAsMLZlpr6yUBheuD+NapmFvl7C3i7zshs1fepRf6/t7osjvkUSV30rNK61s29s0FTo4UV2s7kQGVm3OMROduJ9USUmazUmiwRhdoGB37mPIJWn8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1868.namprd12.prod.outlook.com (2603:10b6:3:106::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Thu, 4 Mar 2021 22:40:24 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::c9b6:a9ce:b253:db70]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::c9b6:a9ce:b253:db70%6]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 22:40:22 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH] x86/virtio: Have SEV guests enforce restricted virtio memory access
Date:   Thu,  4 Mar 2021 16:40:11 -0600
Message-Id: <b46e0211f77ca1831f11132f969d470a6ffc9267.1614897610.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0008.namprd08.prod.outlook.com
 (2603:10b6:803:29::18) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amdoffice.net (165.204.77.1) by SN4PR0801CA0008.namprd08.prod.outlook.com (2603:10b6:803:29::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 4 Mar 2021 22:40:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ed6698b-49b4-48b9-f073-08d8df5e7f0a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18684826F2D2718513D9D7C0EC979@DM5PR12MB1868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5oHpxa1qA0Eby2nQED8t2SeDuT66hD64B6g3paB05KOZQkj+bzl/2dNyXfRyeJ6ragKxcSVMQa26sZ9IdB6U1T03Tgc96Pvc4IOB7iaSp31PXQqVqKboay2C1Z/XuuNy0s2NMfYA1kXSSN2+8RciwLfOMiLWJ4Ox1SUaiApEKufbagrq/j+nZpjCh0ExZdyADpToaLsI0WVIP83+KWGfYqwOn3/J+rw+nXblBgc9CtiEUrixSjD2j7RKOUKkugscgq1psNPXBI7BYg7y6j8UJD4yPmR6XqSoDN9SAbDoAPqjY32YgRq1s5mFYhUaii4pej41kysxD+wkNZ+99W/SA4/pFBzhGQdL0db2OLjoBgOc4lTpvFtPoJAkgfg3s3+OEHi46APy2AesC7CHWzDUd4VSMkyz1nRo1ayp2aHzDN0AEvc5RtK/KscgF4OR3o0QvR0P6z/GOJes6CgoyPwOzdJNnckPFaiNACNNx9I+o4nuHR6zTUj91b205kkkwck9uo07mBuqAB678I3XrpmfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(83380400001)(54906003)(8936002)(6512007)(66556008)(6486002)(66476007)(8676002)(4326008)(2906002)(316002)(52116002)(5660300002)(478600001)(26005)(16526019)(956004)(86362001)(36756003)(6666004)(186003)(66946007)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kGG/nwEQ5/AHqhXz9HZmeWGCd6PGTTLWRSdfNbxJBexcTFLI4T84iTyoDrrN?=
 =?us-ascii?Q?oum+Tbd8q6h6AEBoR2sQ7nEMS2yZhKfdSQ1z6gVIi3JF0fcCQuKIqYK3uDDM?=
 =?us-ascii?Q?wP6KNZuYkqaRhNsKRBJsjPWLtSOiZL5W///XAISnAPhH/yqSES1NLmsozU2C?=
 =?us-ascii?Q?nDRwG7Sgbg5gcj3SbuTkpYdron2H8s//JZUrOke9jLFkXkOqrst1OJCmyBI6?=
 =?us-ascii?Q?QQcAuHlBqaXaiKc8t/22Pto/ynpvPuCkTtpXIF0pjKVsk/5WWkYeUhzwv56S?=
 =?us-ascii?Q?WSFDIxoCaHiLsisX4PusBHrAhix2tonDSygw4nekl1093On32Ys1TJ+YdqVV?=
 =?us-ascii?Q?Z6ZOby7SHx4P2KS58a/jYHsD9Avq4H9zBRh+VfG2+vNqfMo0RZXNNE4EI+49?=
 =?us-ascii?Q?d+C8Yva7sQqh6p13kqgJnplKsFB7vEqrOWgfBRulhB3/55zlV1Kx2SF8qJ4R?=
 =?us-ascii?Q?sbfj1FGUz5ASBfXj/7mroyJhFtntSFOGH0sAj6o4/7o3X4T9FS5Yxb+i0jRz?=
 =?us-ascii?Q?L5odUqWHqfiWIGa+ucW3/Ou5uDnZu2C3XpFnHnxH00iO6SIXAMRCu5iMhhnB?=
 =?us-ascii?Q?ufrXmKbYkdIJYplUx9IcDbW72iRGnLsnP6n8FM2E5wHXFsax54ZsYOEOqatX?=
 =?us-ascii?Q?vYefAK/ykUD0INauz/978f8601z+5c0ywDMONNMUEVbBTKc3QZeSro1caaNu?=
 =?us-ascii?Q?m7Ty80doKNLBv6jJEa97DI3wexCcjdrlhXtUAQyuxwBV8Rt3yOEkgiysIY5A?=
 =?us-ascii?Q?K4kGPYcalJasJzEvosqnjAkzcIw1P7iTus0t4dG5DsqWsflU86ugHHyhA0zH?=
 =?us-ascii?Q?L+Ppfyx8tn/4I1rDGe2MbyIVhOCAVWxSNWqGKQEaAT5Pe1e1Dch1cNzI6/1I?=
 =?us-ascii?Q?40+KbjD0wq6RdFP8d53n9BS/vns2z6tkObrsLjUCgJ4moGHJklAvhsouqB22?=
 =?us-ascii?Q?46okFKsye2PB4uJObPI2AIFbnY1fEJYUNMi04o4s0TloLm/39iq341sWX4nT?=
 =?us-ascii?Q?lR3TJO3hKLt/sGUF8X0TDTxDBk5ze6dTaxsB8eHa4Vpqef8xhNqnGLiD0y7X?=
 =?us-ascii?Q?5hFac9Ab1UXZrgxGKaVrJgcLxi5PAI9enJ2nWBmWGVaG279AAlMzVtWyTzOd?=
 =?us-ascii?Q?QIGqt3sKZlZ9aDs2pZ76sgUhT0Jzzlbk2khFbVIHl0saNUcxkACCjm/A+8+M?=
 =?us-ascii?Q?SuO6UAYaGXkLBV7OiXAUgdclwx+LOa0+xxC8h4UZRJk1QHS35IAiMi+gFJNq?=
 =?us-ascii?Q?mu8EobBicAxqQm8dCvMqtOrz1+Q6mFuwLTeKo9KnF+urIKlZR6LZArdYQ2Pl?=
 =?us-ascii?Q?hKcYFi3ulixdWzEyKrIbibKG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed6698b-49b4-48b9-f073-08d8df5e7f0a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 22:40:22.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuYHEkdbp2mn3CbIORT6LfOd3ItLzCdxzVJ2dyePg3JhNSCVvcUsWb9utGtgtTsTI7saWuW9ep7lnxLsfSYBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

An SEV guest requires that virtio devices use the DMA API to allow the
hypervisor to successfully access guest memory as needed.

The VIRTIO_F_VERSION_1 and VIRTIO_F_ACCESS_PLATFORM features tell virtio
to use the DMA API. Add arch_has_restricted_virtio_memory_access() for
x86, to fail the device probe if these features have not been set for the
device when running as an SEV guest.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig          | 1 +
 arch/x86/mm/mem_encrypt.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..e80e7268d2c6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1518,6 +1518,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4b01f7dbaf30..667283f3dcfa 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -484,3 +484,8 @@ void __init mem_encrypt_init(void)
 	print_mem_encrypt_feature_info();
 }
 
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return sev_active();
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
-- 
2.30.0

