Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF22325B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBZCQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:16:45 -0500
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:9312
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229947AbhBZCQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:16:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpZsvM4RzT2585qfRgOUmtnQvrddSq1fukECkpovTRDd+QsqPmQMltlKy+ffKdWVDBUD0lCIpDSMDsfZe7veSMTonmO1vdSpoXmMIlD06KDUpUfsnxK62bopsDRFMmHrBFAgZ6NEHZjc3WPYabyKNT5jNE6YuaKwxlZF+gvAF+RMu7Dn1QjMpYxwcE5eiGRevQnNc5QfuSQJwvWqe7TCvkrrkHSIVXrIv4ioviMGNZK2Ise+Y89Zk3NVyk6t/2VTBCq8eK8sgFJEOSQe46n2AwjFJtQKLBuWwEwFTmEmGHVexBEhpX779r1Q+eNpHuZJ90I+dEkV8mEQGrGCZKhz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6juJEFkkKVHON73LjUVqpNnWJLqEWcVgOfnHaBcAUUs=;
 b=TMjuNdd7mz+r0ryNRP3puSIlDIDBXVA6OqkXVNR7dFK/QkUo+xAsl3bXBqnXcaeWap4D024CHiGbn4hqPVPDH4x07jFvk7x1y+d7J5juD3MU/Vmaibd8jOKT8Bx+2IdPIKbwJBIaRR4NnCSYyOO1aPDXCFUQ0xwWsIMgo+kmnR4SpYJw0WHXVktFYNk3tyP8ikAp56R9a7IzYLJmtQLbJwHjqszriFlW4OE5tN0wWl5qqxy7WHnRRiUS2cR/Pzw9hDZhjZMtvFRyGERaeltJNj3tnFZAZHFDrdZ5YZvseAkBBAozVFcQqU7HHAVvRSG7paAddTB7sQFStsLMoBObHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6juJEFkkKVHON73LjUVqpNnWJLqEWcVgOfnHaBcAUUs=;
 b=T8JSTKhOEDxo2x8jsw/hMxyYcGsvj1imMYwv2bhV3WrvKO7iLEqRdddxikaVrpXvqn0WrD89j9qpc15dJM9TvyY0kE9S4paRAeeVDybAjPmsAeOqQMUOJDnsbRC3n1okIEDXdbyU2EBiHspHvFEtjiGcOI5raTlr6d2aRk1kSbo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Fri, 26 Feb
 2021 02:15:55 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::f598:e5a4:43da:794b%4]) with mapi id 15.20.3846.047; Fri, 26 Feb 2021
 02:15:55 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        regkh@linuxfoundation.org, rafael@kernel.org
Cc:     meng.li@windriver.com
Subject: [PATCH] driver: regmap: set debugfs_name to NULL after it is freed
Date:   Fri, 26 Feb 2021 10:15:37 +0800
Message-Id: <20210226021537.7530-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To CO1PR11MB4849.namprd11.prod.outlook.com
 (2603:10b6:303:90::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK0PR01CA0057.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 02:15:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa4fb9c2-df91-4247-e30f-08d8d9fc724f
X-MS-TrafficTypeDiagnostic: MW3PR11MB4555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR11MB45556707B0E1DAD3404ACFB7F19D9@MW3PR11MB4555.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/rOVwe0+hACHuDi3+wz6Oj/xypXN5FMsAjRt2SMgqXN9voGawLVs4sm83bEPEw307LKFXTVIYcxHO/qsxnSNhvrx2DXJn0f4UZRw66Wq+eLcX1tDRZON77Lw7ojGh9m8hpZ5tYsncRFnk2tvSZoaj5bk2Jh2UyHn315tdkCUO27J7BICPFztySDiYbookeZx2aMwYw6Xivt/nu6T1z4d7Ltr4CErK66+hXPkD4wFXMezJe3XieKvDto15b4HsqzQk8LuFVI1qjh56vrWIwGA4OBu/O2NwGiUYNCKYrSlqzyXSHntGVGLD/pMM+wWRZ/cfbwoy5mdMTKuzfz2Z/4u99iB5N7bSKGJBxseUYonUKrhEGbMdejjy3Jj2q3pndeZAhoD7BXdN+Ff7lF0YFAOfhenVK6zTv/YVwBQPQaf1dqmZs4D1Nv2U+p+R6m+QQ3Pet5GOXygJI/+4TU+YlenR780D8Xhe5kQYCEmhm7bmOH2/vfpkl+4fROT+mXxJAIaZa98QrvEia0SKFfVx1cGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39850400004)(396003)(346002)(2906002)(26005)(6512007)(6486002)(8676002)(2616005)(86362001)(186003)(9686003)(956004)(4326008)(478600001)(6506007)(16526019)(5660300002)(83380400001)(316002)(66556008)(66476007)(66946007)(107886003)(1076003)(6666004)(8936002)(36756003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HI1/rNOY0j3SUEkEms+3e+2otD70o1+3EJIwAIb3DccTvuYdujHnX2R096p8?=
 =?us-ascii?Q?yVl/Aq2sJp43sYDiIS3K+9B+Ug3022kVO8E3s0hLnDayg0pZ677fAiBTnGXx?=
 =?us-ascii?Q?StmoyygRoIl+djlhdEh8If5fjtfrH45sNTnmAzO9+SSBWO+AMLw2OuAr32Nw?=
 =?us-ascii?Q?XccXg1HrmQrYFur4D5xoLxeKpDNXzTriNbXq+KDgnj7LNAETrYPhegKvCyZw?=
 =?us-ascii?Q?xTlgXAHuS+0TprnaFQcEPsD1U1Y4W8mXgCFqLtWZah3sWEj2OJjh+XGtLE4G?=
 =?us-ascii?Q?wEQgCdq9/kKQOW+P9J+uAIYVk9XB4E2B9QEJ4kbviFUkmNW64W+v016TP33B?=
 =?us-ascii?Q?3q6IrTUhLYRGdOnYQCjoHaefq2+19KbSRiphpvxfNgkifRCUvn8ZjsK0GPIN?=
 =?us-ascii?Q?TphrR1fnL3nU6O/pSwsARL6FA65B2yl5wjSOpIIdYDUuaHb45EYRolX7xlFc?=
 =?us-ascii?Q?wWU2L1By5eddVH2tnhHnyC35czxkhTsH+/FvfjZHDfddIF2DEmB8Y+AIZC+g?=
 =?us-ascii?Q?nBRo4sAV+v7ViyQqV++WcewXO2wU96mhxPLte/FF9KhnraZ+usmWiBf6uRy4?=
 =?us-ascii?Q?FHF/ydS/8wkCSiu7Jj6OSN+ed0xZ2+7Ey8D5sEW4MnYzUeCE9G1wvgw/9sHk?=
 =?us-ascii?Q?rarkKwyMum3kxWPUMt9C4uCBpqxHQJLawpBf2lfBh1mB8CCqPrCzuQCDV3mg?=
 =?us-ascii?Q?+2gYDlXJR2lpmca6bzLEp7kjiVPT+MZBPBQsdul4pPCBKxPGZoQRbCcDU07n?=
 =?us-ascii?Q?jsV3SJ4Y6Q4hb1jm4Jv1SHVmPEA43eBNeBXbfsF3rRHii14o82uvkP/IiJpK?=
 =?us-ascii?Q?bdXUOQBCtxAcfaD8VvpPKOX2YRoN4q6jWcg1oaRAct83SXr4ELgZMsVtBuP+?=
 =?us-ascii?Q?rs1yMum2mK3OI5O4Sq6C3x7y+3spwWG4V/S9LHkUGW/CGvXbmnq/VzfJ4nNS?=
 =?us-ascii?Q?xKaelC76EWb+a7sMiAmMUqUnMiCQ5M/CANEnZ7C3YKOvn78CiIjgX0Gecb65?=
 =?us-ascii?Q?UJuoiP5OWnkQEKD+Cke8geCdUquXKomQd/i+ZmfJvO5QELu/tNB7oCWBwOzI?=
 =?us-ascii?Q?N2bOvdUebHGKAu/ka6gOLvWGnCtmPpzmXOU/+Tv9EXspUZptxz1T7uVHB3qW?=
 =?us-ascii?Q?oczCLSF1RlO6nH5rx7BMy223jlK2YE061agnnjfk0yhlw3R5BtYQQFTuF/Fi?=
 =?us-ascii?Q?BUp3yTCzZuY1CSnzdQ4xUKZ4g+gJSknpoRBkqmUQeY4nzwnudueC6UsA9Zl9?=
 =?us-ascii?Q?piOCqKCBZd56sMtrSsLDFI5Dif4hpkHrz3mG33NMEIGAWdG+ltPC5XdO3Jk3?=
 =?us-ascii?Q?kvwCkNx2j+Zdy+URyMmi/110?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4fb9c2-df91-4247-e30f-08d8d9fc724f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 02:15:54.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i0mNuDRD5BhT7vrfDg3JIu5R2F45lSSHaOr7HApsetMINAQDO4jcyMrVDCyWyX7y1Ue2d8H2E6k+l7rXDP0uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Li <Meng.Li@windriver.com>

There is a upstream commit cffa4b2122f5("regmap:debugfs:
Fix a memory leak when calling regmap_attach_dev") that
adds a if condition when create name for debugfs_name.
With below function invoking logical, debugfs_name is
freed in regmap_debugfs_exit(), but it is not created again
because of the if condition introduced by above commit.
regmap_reinit_cache()
	regmap_debugfs_exit()
	...
	regmap_debugfs_init()
So, set debugfs_name to NULL after it is freed.

Fixes: cffa4b2122f5("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/base/regmap/regmap-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 398991381e9a..4f2ff1b2b450 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -661,6 +661,7 @@ void regmap_debugfs_exit(struct regmap *map)
 		regmap_debugfs_free_dump_cache(map);
 		mutex_unlock(&map->cache_lock);
 		kfree(map->debugfs_name);
+		map->debugfs_name = NULL;
 	} else {
 		struct regmap_debugfs_node *node, *tmp;
 
-- 
2.17.1

