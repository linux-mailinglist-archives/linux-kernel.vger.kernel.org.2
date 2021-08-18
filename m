Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582C23F0A42
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhHRRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:30:27 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:42401
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhHRRaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C73qI39fBIGFyNdmt4BLFUE+cdgQFNMGktoqyN88MyIJZ/GbiQjdSHG/HcX87doZfzprkIsVx0jM6kXoKOLTfEauVuni8SIFra+XiORgOMOfIHevRH0AKB7eVPlRBQ1QJac2Cj1/q1FFtrZ6/aSLW7UrKoDsgjs4xyg+rQiNUWb7wexzdd2/rpIek27y1NCCBh0vKaFaLWRQ4REdikalPlv3trZS4PvZ4asBFmIX6H1EvfU7ifm6H8Tr/zqgEyVBy7O+MPqKrP46EBc+FipRPLbAPAN/nqhQrexTc6tm9uCAkrAfd0tbAVkqC1KHuacjfO3mCYGM2V4m3YLTgYmPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTvyDyaqbGtX6kt3qhhEAMiKrlY/rvu7lI+HCaAZsyY=;
 b=nZoG2sJS+/iCldYUfkeahAuakbvh1r+1m5ShQlL32A9kxwEIuFxUOAnOle+0WeejraTyWH1w7KNVZCu+XZpG+Jub/EWjt/j0FqQkDh2nYKta1d09a9tRFbOka/dzVqVeClqlGpDwFr0IZa+VadUzhpxOog/eSAZCm9JL5fdhMuIuiPLuB87COFxPL8xikyJ6Vd+8U+6iCT+DAt+5HsW+W3WAyIONxHvZ4uvQLRCtiLMpqDICx/0IcH7Yo4QZLN2bzhcak3lqyVsiTQwVlsHkJ7hQ4v/QK72ZATE98/+pblMrFdj5SoreZx+eaZz1LfKGe0y2OgLEfuLfKS2wfbhQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTvyDyaqbGtX6kt3qhhEAMiKrlY/rvu7lI+HCaAZsyY=;
 b=W4LQmcydbzo+E1v5xeit6xBWGzP39dafVBbaM6gYfIR398jjrE1qlKYM1QgxnNxdrjZR7zbf8S9w+kFpZqHhpvAfiJS6t8ME1N7eixdOMzQbyhKQw/JRRiCgXDO/oYS7trItH84RkqkfkBOghZiJM6u2Y8af9b5F3WUuig/vm50=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1585.namprd12.prod.outlook.com (2603:10b6:405:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 17:29:45 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4436.019; Wed, 18 Aug 2021
 17:29:45 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: [PATCH] perf/amd: Fix i386 build error: redefinition of 'get_ibs_caps'
Date:   Wed, 18 Aug 2021 12:29:35 -0500
Message-Id: <20210818172935.54392-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <202108182341.z6digIOK-lkp@intel.com>
References: <202108182341.z6digIOK-lkp@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:806:23::10) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA9PR13CA0065.namprd13.prod.outlook.com (2603:10b6:806:23::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.12 via Frontend Transport; Wed, 18 Aug 2021 17:29:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e12666-b7ed-4f26-0046-08d9626dc57f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB15850A8546FEC72E5CFA2D2487FF9@BN6PR12MB1585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avU01fk/dLdXAk/bVJ1ejrnWfdWJIybQdQaWAotoCXEJVDZy7/dUY8zNWatpnY8mNaFneRyc/0D6moA5oZytbIWhDBFAnGdmX6gAdP64rTFah4d+b3HXiJ5F2FJeE1D0cyo7RgM482L7IOBsAQaEuB2Na+4LfN8bymQZZumB3lS3CmIMEWJaBipoCy46yavfmx9xm9ej5b1W3jHn2T13w88e3QkgKQ6RBXeHjb9LpmBmC7e+lRFX4J2BrS12zwKiyh9elRubRvLlx85tiVAEE1SXmCmpWtnAAjzF0m3B3l5zX5B91ntv/h/L5FJQi+IIUi8VX9IVgqrsfdM6KscirY110EWpvwypgs8RrMxVBLULn+zJlp1NO/SRBWWmZHDjcm6FJXA6A+U3Ykl+53DAufOQx5HWXdMUE8Nmb/6ipu2ih/qhaClIKTQ7T5XyVRG7FPxOhmOYtBKSTcIbhvX7mtBICODDbgWv2yRUzTH5pj7F3GK9CoJ4KjrFZX6LHWck4Xa7VkHW1019BigZ8OliM59wAH4Qu+znp7GVzIqXrt8CfT6TxG4DBGeepWx2EgOgIbdaS9Lx7tk8J/xdPeMLgyrAZLPxWgG92ffStfHbT9+GB395WYk3F0cjZyz0cu0siftisd8BO8QJRTkP0ryDKfsX5V7F93xzeFrvK2ShnwMv3tWj8t2naMkkGXX1bpvveiIEqDnCCIEASP3R8Bn5nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(8676002)(52116002)(7696005)(956004)(86362001)(2616005)(5660300002)(83380400001)(478600001)(8936002)(186003)(4326008)(316002)(36756003)(44832011)(1076003)(6916009)(38350700002)(6666004)(66946007)(2906002)(54906003)(66556008)(6486002)(66476007)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QYxbyPbuG9n4Fo7Hhq46FjiH6OFflV5voR+RZ9g12Bh3EmV8STRKs61DoUlm?=
 =?us-ascii?Q?pAf7X/U7Ojx/YwByeryVorVjq4RgiBadn+MfR1wRI5Kdlx1nl01AGP8m6CGY?=
 =?us-ascii?Q?+D0CceQTYVvUVFhV8iLaT5+qIUMrvMZj249q5gemGROR5XpKw5kVCE3tJgL2?=
 =?us-ascii?Q?fWyaW2ESUejov/R86m0K3Z4PeCQp1PiSVdo6P2VZ2WKQZVSs73CU/nqSKjSy?=
 =?us-ascii?Q?8rFde1YM3Wf5YNhLfArgbtKkbiTnDM3UGikyILRYspsLpwTTqLLqyFy9A6jL?=
 =?us-ascii?Q?cDG5uQpMy2swSzP/dov80H17bJm/VchcLeNf8XiZIHOU9xkRFf6/amffY1gW?=
 =?us-ascii?Q?Ij5QRX8tgq70cgwK9vVDNnCnWcWq9Bsw0cMnjlpbGAW9amYKKjTHZo+nMGgf?=
 =?us-ascii?Q?+6lUjq4ibD67qq6OdgBT+AmG2VtzrvklQ1GTRvCx266dOXqHUYkB/7D/bg4c?=
 =?us-ascii?Q?TnB9q/NF/cY/+DaCpsoBglASjJVRyJriLXqB2h8ZFjPRMEWs/gGxE6dwj9Tg?=
 =?us-ascii?Q?Tyh93m0p3GpdUfeI0q+TtrgJSybvol0DlCE+puemPUps2Cm95lvZ5GPECKae?=
 =?us-ascii?Q?jtl/SRJRcWO+HOoEtNhNlZs38RtHAGdffpI2Ocs7IP9br/yyL9avgsh+3A+s?=
 =?us-ascii?Q?d4eJw96oK+SPbZEJN+3M+ogI+lxx43HXhCrNauYn7ZQnYYmH9lyhfLnHqiMp?=
 =?us-ascii?Q?LOrAILDdlUAhoA4g982ZuT7l9S9eI5Cs9PE5J/JpnK9263HZoc6OLuzoQQ0f?=
 =?us-ascii?Q?ZXp8OckbXaflHDkdlfa7cUh89z92d6YbCjw3LRc77P5E0QxbbofHvVcV7ugG?=
 =?us-ascii?Q?WY0nnkW+H21uNLC/0RlNR32PFacXzEDa8vKH8YHY3VSTFrrinLpS5vyf2oEu?=
 =?us-ascii?Q?QwZpiqf41PlseoOzKBPkQkVc99bDZjKGXLOctPPc539bKYzdS767CNceIY/m?=
 =?us-ascii?Q?sEBMrlfTYy/iErvamjRRw5bAXZFCuvOnL64mNmr2avOO81C7KFTAo2UsBW4Z?=
 =?us-ascii?Q?u8Cye/StE3ZjO9uX3OQhQP3qmXQNX/HyvzVwWH4mKd3i8YOQBAbHNZAyC11x?=
 =?us-ascii?Q?9wfwXmCsqZR5Musyl0K6fCERswyOfTP0tkdFUAebiMtBXUbP65n3h6PoTj1W?=
 =?us-ascii?Q?Ecf2MexXY6oO7Cd5XGqxt4sWcJ6f/mODnDL7xhw3bCiyEE0ASMzF5+gNwOHw?=
 =?us-ascii?Q?i1EFLTmFtYT785n5Xss9LR9g11dntiyH1k0SiuP/318ZC6mttnIcmJofAm8U?=
 =?us-ascii?Q?1aYPtiu4iBM1749hPB2pYYP/FFo7Euc0C9j5LMPa+k1Yelr177xndLx0DxBy?=
 =?us-ascii?Q?eI0hgkJP4BDA+QOTfJ1SyWEl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e12666-b7ed-4f26-0046-08d9626dc57f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 17:29:45.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ove9B3+q6ok9BHnf+JXGT6ONfPAnzilNvnILeYKHx+hPW/1UUMk/xMc7gnexWhwORBSH/ziW6Z9E50aeMfEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6c3f8af52cfc ("perf/amd/uncore: Allow the driver to be
built as a module") accidentally contained some unwanted ibs.o
Makefile dependency changes.  Undo them, and leave just the
uncore.o changes needed by the commit.

Fixes: 6c3f8af52cfc ("perf/amd/uncore: Allow the driver to be built as a module")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: kbuild-all@lists.01.org
---
 arch/x86/events/amd/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index ec45a12deb8b..6cbe38d5fd9d 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o ibs.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
+obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
 amd-uncore-objs				:= uncore.o
 ifdef CONFIG_AMD_IOMMU
-- 
2.31.1

