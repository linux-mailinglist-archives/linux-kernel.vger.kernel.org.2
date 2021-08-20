Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4C3F34F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhHTUJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:09:32 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:54593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238656AbhHTUJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LerJlFDr9Fp38Ngb4NforZ/52I77fK3IyXIOfo8NH0vrFj0h5cyvNAEgIS5EZ0wrcxt3AlPpm635M0xLSvrIBiWsAfbe7jUQ8AxZr00fSmwVhgZYvI1unOUnJXOtKXrD9qNEqVwmsjSZLrTAgEDaG8lo6SPWrH3sWgnjIDPKUf+nX0zfr5IOVA8Is46kIIqZ7if30PqJXgJ5vkSmGC3rIOTlSVmWGewLeDohMOj5t9lQc1ohPmbTfQZ1aywqoXcfzTaRFSXc3//f2y2HgTVAomtD7CGY1rje+LngDxqSc1XXg7dpbUjvvHGdR8vtkcRgi5s2imzR8SRA3XV9mvio/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+US6/SrKYn8RKo3jVFCsv5yk4EETKwL2Bx/bp/Ev6ro=;
 b=jecC4U9+L46oFjczPB+GtzhwkTYPkB7iaDrvQ3lsmfe9NQ2MfLum/S9dFUdJTQDtr2s0rrMaSevEZhGPR+CMREmmfiZeXnL6lruW8MOCjdPGyqgckU6XPejf/+uaN1nyDCuDyfFNxMCDEf9k5E51Ehwu5u3Jc/Ne3cyxHvLUc06VYHQDrue6/3oVspYpvcQKrN2T1m6N+M1rB1lV2RmpL8XvEMglZA4eVbrLQOH0smJCb5cNPT+iSMoBzgzgQu44kNeaZ/43dkbQs+bOd6bppno/3b+waD7Z0ZH8wLpEYfmQ4xLbCAp608sFMhTWfMok2Nnk6R0MK9gEs2ypFkho1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+US6/SrKYn8RKo3jVFCsv5yk4EETKwL2Bx/bp/Ev6ro=;
 b=pnakTO7UvATA1/nX6AO8Gs8yF52cH0ZH5ZScoPDZquQ/CADdDumhX2kGqzkyIXAyvBbswRp4YKhAmpofYPSCI9EG8T9D32QmLVjIZ2VrW3APkhG1BN01Q3NKHDGHuhFy7n9oaLd7MRV/vNpaUnudYfTFx0TryEp/Q09+TYrsUEM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 20:08:48 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b%3]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 20:08:48 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, wei.huang2@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/3] iommu/amd: Remove iommu_init_ga()
Date:   Fri, 20 Aug 2021 15:29:57 -0500
Message-Id: <20210820202957.187572-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:405:4b::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.184.1) by BN6PR1401CA0021.namprd14.prod.outlook.com (2603:10b6:405:4b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 20:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62e582af-575a-4670-08a8-08d96416526a
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429A36B7B0DFE255E0E3AC4F3C19@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7ENQ1FkQGXsjcoPklrZCUxAf3eKx8SuoQ41BhsXvsxeBzG9xm++mjF+pNMVcrHgZlBJ3hetpjoAd6gNhocG9e5PxwwuOC23XBT5rOZqMYR+j3p8z95Ak+W2GFYIAvZkIMveNMcZcsw62NS4suWZ7s1vn+DE0y8ljuakR5WAJivYDKOjdW7Uj2XrGK84+e2bFEM4lfKtqsOac5M+9cqNznwb6ZzJxecUOtpSmKBNWmz/IfJDD3qdbLL0I83qwHA3Mwhykx+Xg2QrEqDLokbzM74sJnAroBlTeN3CxMSGiF09+W6eS8hufsHeuYr3cWHEGXlBYEScUl4KqM6Za8gtXPUcMr31p5CSm0sq6Z5rsYJyBDc18sz12En2B7SX2nttS4T/FMZzk9PWydawF1jsWEMSQYHqYVa8nJUs579QlyeN+5XkLFd9HZtwWuHuiTdAxRrIQjbaOTg/HisiQHIsujy/OYwvJl9aiR3OZUj5fXj+0gRibsczub2XkC3krk//V6QQyXcVEqGzKsTep3UoNbJfhgK9VbyZF1qSfRZ5KHDOhLCGpJG+qKJV4P1z7Uf0ZVVe0BOyUfetmcEdQ161MvxFpen8E7mEqOiDxqqjlf538dEM5HoH9qNibuAuh5AOWdIqj77OLXwxzeBQeNneUHrRx6f6x7IU6+LEVux3moLAihp967UUq99DO7adKTDcrSGWPkUJHsN5Vru5Jlq36Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(2616005)(52116002)(478600001)(7696005)(44832011)(38100700002)(38350700002)(956004)(316002)(1076003)(66946007)(5660300002)(6486002)(6666004)(36756003)(2906002)(83380400001)(4326008)(26005)(86362001)(8676002)(186003)(66476007)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fi5woo8ll2sNJ1wuEoJBD5c3MhZisxJxXcaZkODRBpxvBOLDrPGeiH01D1z1?=
 =?us-ascii?Q?jQ6Aes05cLwDXcqK/9eWBxxnPBOLeSL5lvV3GvqXcUuXMcCY6rbT2Y+dLAO4?=
 =?us-ascii?Q?VRGHSotkFU8tay4pBmJRQP2cmxU0Yot0w3qbq3ZiNNAtN8Pi1e0wiheqW70K?=
 =?us-ascii?Q?8ULl7ZWrEdtMPma12YvtdeyfvXDP6T+xv7KwhHEZvLqDyRU8G2PUZSTfUf/S?=
 =?us-ascii?Q?L+rrOUUNWwmwafmR5pHMlsn9o+tUAsRH1TyzhJUdyq/VdanIimF8cFs+qZ5m?=
 =?us-ascii?Q?je25ukm4wutFhAaMHcSJhdbI8WRksJW+78I9GCDvbFqATUx4KNlD9nYleDnV?=
 =?us-ascii?Q?34VU4CSsW+rN8jfG6bN/R3JGnjnNUAyoLhmA5t6cjzNJ+R8HmPBeTFUtBfSj?=
 =?us-ascii?Q?fHMXs/XlcujmoxL9+R7LWY70wIAtR2wVjaOlZge8+r9U8kto2PsmrNdm5fxP?=
 =?us-ascii?Q?314fmhQjAOjtFKF62dDQQU5BH1lLcN5FhbpB4fkHq1n3AqxSmbUwK17j+NP2?=
 =?us-ascii?Q?JUKTkfk15DumPLUzFN8d8DI76/x+ZXOsMl00FIqFbIxpJ5gMGCGB88EJkKJK?=
 =?us-ascii?Q?DFe//JwktN6IrFttC1scC0ToOgADSFOR9LWT3tNugQpnd7qcE8ZtI2eRq4C2?=
 =?us-ascii?Q?02BIWVtfQyJZ+SC7tfnGZi8pGkcidwNnsEfAmKvN0/gOceF7XyVUSo+h4h4g?=
 =?us-ascii?Q?UVa3jzkgtoknns/OvvlVfsWkMgw6ZWUFWAtP31ByG4wxRy0JgyHuXyPeoVoP?=
 =?us-ascii?Q?rz8se2Tz33x2gM03BK9+xecDKhnPgqurvPr9JMs8zm6rNS9+0ArYGvDKmO80?=
 =?us-ascii?Q?F5fiVdgJAi1G72BpASvSWmXGEetEmA22CHhg1oIzCw/818nSzMEFQOSXa2i2?=
 =?us-ascii?Q?uqyDoDqe/Q7vi/TC6O1sqZpRGC9fBBEbwO215VzaXGMIDMIo9KAKwD9QRop7?=
 =?us-ascii?Q?9i5nb4nlnlRPlOx6eNDkNh07zwRRev/mdOeJZOP4AhSaBrW0eC9FbRmW0xdU?=
 =?us-ascii?Q?WhQyuGW+npb5SUbVg0BE0qEJi/BMtJwoBAYI/WVkMFbwMeezpBfSo9WXV+yQ?=
 =?us-ascii?Q?iLiimMdxQCXWIYW4D3vHl6KHPpyyBC/KWOQshXX0DsPVXkyqSUoE3wht649B?=
 =?us-ascii?Q?Hb3R28bFklwxar4cH3ZYBLPc3DW6ePR1stCavZT6utyuEuPJTvFYms5Zw8m7?=
 =?us-ascii?Q?5rJVyR+6dRG/y40LqFRLDGmoCIQXIX5E23mRV04DErpx+Xty/T0P7/YlOAfp?=
 =?us-ascii?Q?zapnn+/l2X/s+93KBjrUub/evs7U09tTwMtfShuVbRZV6/Jb7UemcTH8oq98?=
 =?us-ascii?Q?cHldhAvWZNnltAbI+vb3eO7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e582af-575a-4670-08a8-08d96416526a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 20:08:48.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbwTUvCo6U7tnTRVd3ZFtSiXtfIb3UG7szdFb8MSsIIl7bZX9ZZNwvAxNgcfsuj3OLP4jkgJvjFNqczX8nNE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the function has been simplified and only call iommu_init_ga_log(),
remove the function and replace with iommu_init_ga_log() instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ea3330ed545d..5ec683675ff0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -827,9 +827,9 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 	return 0;
 }
 
-#ifdef CONFIG_IRQ_REMAP
 static int iommu_init_ga_log(struct amd_iommu *iommu)
 {
+#ifdef CONFIG_IRQ_REMAP
 	u64 entry;
 
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
@@ -859,18 +859,9 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 err_out:
 	free_ga_log(iommu);
 	return -EINVAL;
-}
-#endif /* CONFIG_IRQ_REMAP */
-
-static int iommu_init_ga(struct amd_iommu *iommu)
-{
-	int ret = 0;
-
-#ifdef CONFIG_IRQ_REMAP
-	ret = iommu_init_ga_log(iommu);
+#else
+	return 0;
 #endif /* CONFIG_IRQ_REMAP */
-
-	return ret;
 }
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
@@ -1852,7 +1843,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (iommu_feature(iommu, FEATURE_PPR) && alloc_ppr_log(iommu))
 		return -ENOMEM;
 
-	ret = iommu_init_ga(iommu);
+	ret = iommu_init_ga_log(iommu);
 	if (ret)
 		return ret;
 
-- 
2.17.1

