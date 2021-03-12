Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760FB338810
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCLI4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:56:00 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:64640
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232424AbhCLIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:55:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5UYe7VTxT5qJbZmCNT66TACxLC4L4pnNeFobnZCz32/7342aLSGQcPRFInrUMi5NBHFfi0sDpRRuSUhUXre2f3Luag+DM3YjLpA/7QtMc3KplWpubXruveYADxJLVcnyWPJn6JP7y14KMADNELbvhgGLwsc0b6fegk3cwAVcVx9E9PARTZmzBbpFHZWM+/cq2zPSWSLa3xHa/Tr73aKfbiSXiPqqKsLtBGmRrUCnYE5acUy5FvHW9SobNUR0JdokOvEeQdy2qGgltDkPmYBUYxkvy5RIm+DSYOvwLg4+ylFfRL0fbPxbrxJGOPqgxSmBzrpvdsmLKk/RveqgRfExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDmXmgEW0tusxnNIg3wvamYKNUbXVOJyUAl7/8OxewE=;
 b=AbDAoBureTSnhp75AjI2M+ta4AGxVGrohkiOb5ze4JvomeG4EEOSkW0IIIiZLqHgKtrkaryKdauDDNY407al+IeCuz1ipJFH0Ld/4mEGDNPHnEWowYEM7gWzAL4ve0aM/WmHGsH9XhBVzP0p1jYRuswm4vD9UmlA2cLQQNE9AUZJ6X0M4V2KvijWaQrwThAaVc03SxULleGzsws26E3DCl/5LEAomdBn1YwcxSIE7KCD0nxqGy8DQkkK2e1H7J3JAuPEZbyZqJjTyG27aar3OyVC6y7UmLFs0ixNpbXMQJTrExlQpn+9W3zLO3BRTMvmkA3oxk4Ehi2fgrPbVcRUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDmXmgEW0tusxnNIg3wvamYKNUbXVOJyUAl7/8OxewE=;
 b=X8Bv1k8Hh4T8ZczoeILIPG1lh03WcR0vrTV46yY4KDUpozxj5gbwKoTyQ2TPfdxX8eyy1ol3thbeRQBKCuX4LAJzualo0CELy0flDYxG5a5zgSqoA6zTjSlonUOyNqu5ZuSDkGNJcIgUtC/zx5lq8DEGFTmNCTOxzH4BkEYIIAc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Mar
 2021 08:55:22 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:22 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, Wei.Huang2@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 7/7] iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
Date:   Fri, 12 Mar 2021 03:04:11 -0600
Message-Id: <20210312090411.6030-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Fri, 12 Mar 2021 08:55:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e18a8cf-9157-4a8f-0b1e-08d8e53491f9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28407AA5E6A50EB341B3C678F36F9@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfKkjY/YVnfdpSHsJUbz7h6iAl2mUVH/9U7PxuYCQ/BLkhu3Mng6lC0wzMGrIBjd38fX/V9gDLWXMVQiftq6ODCr/cfPsY+azf/zUybZSkLuUmP6xGuBotXLtQjKYTYR8M1rJwpVj1ySh/MQ0yig/bOTqbkrRGBswRf/yoCStPp2VwFOzkz/Xl3Wz8VuO0JkWwVpn/+p1hYpqX5OSuIp7tloEcznT9Jl78UIVPNYh2b5yGUfPeNfjzFXDysTj8Xf5zZy58oWA5LUM8a2bU69yFFxXEcWSQ6jxlbNFU005UdXalWlLE2IryVGNPL4b4gV+lBLmtFy7SW7tuKnrHgZFOUhuKBhOu91pJiBtCoWWU7u8OuZZeLBPNZSVQ5OjPNIDF1OL6w1eU1B2v5Q79ccgtxPqjPpIPD81Mzz2G3OEhC6I2nuo+YYOZsQWMhA6zIUp+lo8OXp5Snaq6AU0OjnKgAGGMe05cLurXfSF7j5AbshCcyKd4cd2GB9fthmIh0Ip+QtuoX+Eg3P/cKmq8dtXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(8936002)(36756003)(86362001)(2906002)(8676002)(316002)(1076003)(26005)(956004)(2616005)(66946007)(6666004)(186003)(6486002)(5660300002)(7696005)(16526019)(44832011)(66556008)(52116002)(4326008)(66476007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8XQRYvFk9dEZLVBBEwLMT14WnDSu+dMlxe7q9kGTpDlVnIqC1N6XsrKRSSIA?=
 =?us-ascii?Q?ITI6u0tpA+4KXLcNSz7ckujxx0nPILsFzfOn3wpmkz/hY4d0ef+xHkvBLzN2?=
 =?us-ascii?Q?udAWAEJ2Sk1EqJ5GeEyZlw2m/m/YwlJ0heK+8ognNM/O8J2JuyLkRh/5gHXR?=
 =?us-ascii?Q?/Y+SV+5udN+IeXi0zJzxe9sTrI61OVfYieV2Rjvn7k33MpD7aGMrieZJpvz0?=
 =?us-ascii?Q?f6Hrk7U4xXb5cneeeBokNfDZ3zj4u/ZSMYSKohafdOKlPeB4cHfif3uEsu3W?=
 =?us-ascii?Q?EbN2ts66twyu6rvlfyzINjzd5lG+d6PiNloV7j38ynk6mVROUw5D4jhISf2E?=
 =?us-ascii?Q?gYTyfVqIf5/uChMA5lz7m5cSTehEBtY8Eq/oWDAHrWqZe+RkzC2ED9ICMJvH?=
 =?us-ascii?Q?QNzWTN+2SSt+hjw8YRFdidIO0324rA4umSs4wHx5AOqgy/nwB2LtXzfU6y1M?=
 =?us-ascii?Q?EnPb0nsJV9JTsxyq1csK+kKFuPk4YtWw+utzp8LlEf9RyFLDG+tYyJYJX6gt?=
 =?us-ascii?Q?uTSjLikmPIgZ2sWgomTAlXru96eMDkJLNfr198kTc2ixrC8Bzd6fechqGYnq?=
 =?us-ascii?Q?EmOyEnyALpL2cfSAsn24Vwv77ogXcc01J21VhZ2Ei0F73JcexKxp0xoINO7z?=
 =?us-ascii?Q?CjtqMXAnY3tY11Hqkg6tpd1DiHs2W7BaE/jsLGS1TRQnGzvZqvZf211sG28J?=
 =?us-ascii?Q?iVCZ0B6VeeM4sh2+HM2y2/gTz2x4sfV107QXG0DF2N9psRREAp0k08ym77Wj?=
 =?us-ascii?Q?jPGSJ3bt35BP0aNfcxEpZ67wFLZ3b3FxT198XQXCKNgjcu73L+AunWr6IeTF?=
 =?us-ascii?Q?RsSmZzxJf9bjGJLU9Sw5JR9i6dOIUERAMkKeec2jyz+55J+ujoFgQaltAtzW?=
 =?us-ascii?Q?1ov7+sSN5lTXbcmOniAM3BCweM5Hic87VBeJujlJ8QTc4CpX1TKfl/ygedwR?=
 =?us-ascii?Q?GikUQ1mo7MAEvIdYXtF3A+WkxT8bCVI0m6yDa3hosVNkQQeVKOs2gJrp0ty9?=
 =?us-ascii?Q?6r0hajp89lox+4MJYF3yB713nW7eD/VAHiqOhA4nIUu82cAVLUg91UxCYjNC?=
 =?us-ascii?Q?dbCmVZHF0/mPcgQR66OKFpOyAcn4UZ9L4ylidUgsa7s5dsTRbE7nHNslfi1V?=
 =?us-ascii?Q?E1NHg7sl2Wtd3HAraDUEOpT3iLMlENhzLDR7yGuOzlwsZmyOVtH8fyOFdzVS?=
 =?us-ascii?Q?WXky3+kdDOEICEGBySkwhZpcUxOM0VnHEF5njlHwl7Auc9peaRf9fRg0+Qhu?=
 =?us-ascii?Q?frUanli1uGVuBbtITjtMeIvPmr5FzYrSsX2mi8tlKjIw04iPqq3md5vRPqfd?=
 =?us-ascii?Q?xR9Y1NP3IC61AVvmYJWqZ4y5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e18a8cf-9157-4a8f-0b1e-08d8e53491f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:22.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfaqYoI7QI9+Qw913wqw3QHw1Jw3clUsDIkwQM+jeGxpHK3L03IW+Yx+KHj9pYWef6eQUW5VvQi/I0Rj5qBHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce init function for setting up DMA domain for DMA-API with
the IOMMU v2 page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e29ece6e1e68..bd26de8764bd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1937,6 +1937,24 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
+static int protection_domain_init_v2(struct protection_domain *domain)
+{
+	spin_lock_init(&domain->lock);
+	domain->id = domain_id_alloc();
+	if (!domain->id)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&domain->dev_list);
+
+	domain->giov = true;
+
+	if (amd_iommu_pgtable == AMD_IOMMU_V2 &&
+	    domain_enable_v2(domain, 1, false)) {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
@@ -1964,6 +1982,9 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
 		break;
+	case AMD_IOMMU_V2:
+		ret = protection_domain_init_v2(domain);
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.17.1

