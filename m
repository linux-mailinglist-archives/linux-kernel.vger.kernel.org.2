Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040ED33880F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhCLIz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:55:59 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:50176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232605AbhCLIzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJoj4c5Y/DVrcOqVKDssJpFzhmJNuqAIfoqj6+0XB9266LYZ4aO3rK4LIURrDe1iqTkPjuZQKG6Yps13UeORQyT+dviS7Ow9bHQwSiX1QXhUZvjPqFhbzPtzDix2GCdrnDnjuTg0U9zhbLIZaR5OB0NmH/MDWYcfrptVPQYzWOht3rGBtxjXrqPzcwVgrueeKfT79GttTyWrBQJ50fXQNydk/s/GZybFbGJFRLDVcyXs++UwzT77Q4JldgBe+p/mL2InK30DAM96po8qAvg/G4myYW1oGELNd0HlnCdmcM66xp1GAR1z7F9+HtWbvjJbcmXfITDPQI3cf3Vp2Ayo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se+1GFxUO86DQkANWM2t3Rgn8XNhbz2KY4ibd7clvw4=;
 b=nhJtUMSL8CJtfu6Y+PqD5bvZbwto7qInXd6NA34xchpMzdaoMrIyIZNoCFzHULzb5jNaG6qHoLCqkN+lQtLYKADwRrc15cuiGki6f0M9K8C8TBDVW/hLYuZci9V4vpwz0IyS4fE5/Q4lxKaa86fmEcLxPE68h6FbhAPD2O0zf5KVRxPUQdX7RBhNkoAg/bq/cB+YccZoE2FZHVamVbL2mAGzLHrMDF0kt+5ZFS1LGiQru4u8AeSgHKQvwlxA903S61cdzTJ1/WJOFiKKZSAenO4p8TqG9KCnfCEj7wEItuvagP3qRdvLE8R5eL5cRFA2Ik8be/Ov+d9tznCPxCCehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se+1GFxUO86DQkANWM2t3Rgn8XNhbz2KY4ibd7clvw4=;
 b=G9+7Yykn8snD+SdDdh0zA+EOUZRdqf4qJMmQbhz7SQoMtH+tXKxOkFq3EtgCumlvgdtg5b0MXn1lj3l9WVlaEpeAUer72IHhluKo3/vQerJ7stqPFHQnbt3I0nfjFcjAy5ng+ANK/20ev8MU8+8m2rz/Nm3IKWabuAfYlaUvIDQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Mar
 2021 08:55:21 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:21 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, Wei.Huang2@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 6/7] iommu/amd: Introduce amd_iommu_pgtable command-line option
Date:   Fri, 12 Mar 2021 03:04:10 -0600
Message-Id: <20210312090411.6030-7-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Fri, 12 Mar 2021 08:55:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acb77d12-ad01-4a6a-c3b9-08d8e5349112
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB28408BDF1CE4B39A6537F6E3F36F9@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: al4fQc1/bJaq29KP8VbHtmUCn6g4rtWlbc/Ca2/mEOZyTNTfVpkLNMCj76nKiry1mD78+OXVG+2ayv0hD8TqMA3GMJ1ZFyKla2OhkMTrJ/jqhNPZApcDVp+YqNSl+Pf7jzEt68Cjx2RruHr3ci3XZQyeBgWopYep7ZA77Om/6YsM3SbkBKBM9roJA+lZulgtIpoeE2h1h3cof2YKZWtMTZIPBEqnJfEf+3A4c9YCkqsNqfHmjpFltHwxf1aS/e4VcYpcmnG5Tbx0suSfppG2ze8yRjvzRDc+fvbesL+w7Y94ijzAylnbVcPJ/DqZNpF4r6Ye/01OSZ20QCqQagMkz2Cw2m/bcTxr2mq13wlKUX+//jSQMwJ8UGBADtgNigR2NVSEMPdqzzLyPW//GsPCYcMHsDx1l3qj5+zhmL3sSOj9bjzlEJBOkw9Y7rEfHTEOIdfr57NipICRFTl+UNm2wrM1VSbXEvpOkugLvdtAEOyEDx9Zsaic5Nez0NYJt8D8Bbs2U7uwUgGqxcN85YMPbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(8936002)(36756003)(86362001)(2906002)(8676002)(316002)(1076003)(26005)(956004)(2616005)(66946007)(6666004)(186003)(6486002)(5660300002)(7696005)(16526019)(44832011)(66556008)(52116002)(4326008)(66476007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BIyC+HTfSGbP98tSUn6pUD3XkNu3PiEdmu2/KQVSSfVt0A7QWDhYeMGp4JzT?=
 =?us-ascii?Q?MsSAyhvz8sa3HMfMT4kSF5SI4ihuTdmEgJ7n4Jup+GEnFfwKbq8yvcDG7QOz?=
 =?us-ascii?Q?hHp8BsLcmmr8T4RUQ54tYV0H2+ysQ16fpp36fLafprzaIY0+tvgIJNDpiTPF?=
 =?us-ascii?Q?O8LD/J0ykzl4V4dsk0NjhXSvuw8vIL7v+LXUrPpNjRAsJCo4lmxEKHzHr8Rw?=
 =?us-ascii?Q?l0L/jIGsj2nU+vH+roqTlnbNJ/O0lh48dOXNe1+Ezr7Jw9MGsKRLiWOQ6fCQ?=
 =?us-ascii?Q?lKuDsNrCZESU0CZfN23dkKzdwR+UV71QKh9BHHq+rVgxeBdOr9dUQaYTkuTg?=
 =?us-ascii?Q?O0wRzLNIzVeUzIBtyxwZd8n7ZGVhGimGbDf16ifdNQBcUrz3gdnhrAyDFSVU?=
 =?us-ascii?Q?JGUzA1Wo5fAGuLJQGM9uylduJNSn14EyFA01vQv1+/DL3FQOnzb5nC64R5dp?=
 =?us-ascii?Q?RPIK0n+IQy8sQWTOSVQsQKamcwxiNMedK6Ln9prCMECG2DKS94zeIQQgAobj?=
 =?us-ascii?Q?bC3DWTHXVkItbAsAxTChhRYNc3veqvaN6PANPqxH6nY4GsFPqUUIJ8MSW6ia?=
 =?us-ascii?Q?GohzgOHXplJPuI1l77uRPQqRqYoGmQe24JAPN5GftevjGuHjZCpOveKiPlzF?=
 =?us-ascii?Q?KbakonAi6cctw10U7Cxw6R7jR69pi6xIc38wa2XBkme2hbx/FRZEPLVv3NTb?=
 =?us-ascii?Q?cul92Ck3Kg49fo1BQfVnk6cdPIIpC57hJzZv3NHbiOtXI+jEZabDNKUWlLE1?=
 =?us-ascii?Q?s8H0Ps1rSGCHP/KWHaxAOcUmV/AgF9nyRf3GRINWAHDXLHJxtx7z7wXe66Qr?=
 =?us-ascii?Q?fe8bBroRrH96XJokdCxZuSLSP2PWESYEpxZw+kv7qeZKEvx6yKV9tMcDUCaz?=
 =?us-ascii?Q?9WcmwgVg81PTG37LxEzYe/GKLi1bhjXBvG/ZMspEcvAg0rZgwgKDrHYMYFcf?=
 =?us-ascii?Q?1jrLyKJyW21F7q3m1BoKxx2DeU8vt3M5OeQZuI2l7NCfnj2lTbld4F53RsKY?=
 =?us-ascii?Q?0xYoLiMMFzVOP/DcGUskaZ+TNY8g5WQw9MJMrK3p+I10iB1E5eHRY5AA3ius?=
 =?us-ascii?Q?TXi7hl3MFJVzOp7HuCQ5JNA0Zkf2mSKtdJRAZhcqGx9OWbyOgJEJSFjD+PRW?=
 =?us-ascii?Q?iyOZ+DI3CJYQ/esW4PmH6yK5KFGXXL/Nmtyqc6jrZkmx6xtltZtXHVva0O91?=
 =?us-ascii?Q?CP/jiRm2qarVaz52gASUgoJ63Nahzgy6GkPvFbwIisqF2Y/4Nnot1VC44ec5?=
 =?us-ascii?Q?7hrAnO04SvmcAp1J/D7PLcUyMycxf7Zi30+XBALMND2sZO1GVE3YFSQVJj6m?=
 =?us-ascii?Q?FuFyblvFqbUHpvIs2kLDmYiH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb77d12-ad01-4a6a-c3b9-08d8e5349112
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:21.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gH1sxdaQCW54BoPlqWiXspd9PXgAGN9mQpvoke7XR2muJiQXcmAj8KI53aF0HwHA9PPQyOX61ljhGnmhE0LTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow specification whether to use v1 or v2 IOMMU pagetable for
DMA remapping when calling kernel DMA-API.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/iommu/amd/init.c                        | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..466e807369ea 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -319,6 +319,12 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
+	amd_iommu_pgtable= [HW,X86-64]
+			Specifies one of the following AMD IOMMU page table to
+			be used for DMA remapping for DMA-API:
+			v1         - Use v1 page table (Default)
+			v2         - Use v2 page table
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9265c1bf1d84..6d5163bfb87e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3123,6 +3123,20 @@ static int __init parse_amd_iommu_dump(char *str)
 	return 1;
 }
 
+static int __init parse_amd_iommu_pgtable(char *str)
+{
+	for (; *str; ++str) {
+		if (strncmp(str, "v1", 2) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+			break;
+		} else if (strncmp(str, "v2", 2) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V2;
+			break;
+		}
+	}
+	return 1;
+}
+
 static int __init parse_amd_iommu_intr(char *str)
 {
 	for (; *str; ++str) {
@@ -3246,6 +3260,7 @@ static int __init parse_ivrs_acpihid(char *str)
 
 __setup("amd_iommu_dump",	parse_amd_iommu_dump);
 __setup("amd_iommu=",		parse_amd_iommu_options);
+__setup("amd_iommu_pgtable=",	parse_amd_iommu_pgtable);
 __setup("amd_iommu_intr=",	parse_amd_iommu_intr);
 __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
-- 
2.17.1

