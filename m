Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8433B09C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCOLGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:06:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38285 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCOLFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615806338; x=1647342338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kTz65dXJEj+9htZ8c+7p8tdsqRWsoDmQvV/nAB/vatI=;
  b=DfPOXzQOvmB4EdoO1SJgLzr7G/2VImVGXS3M/CyJcf11SeydzEq8RyeA
   Zre6M0VeOrzxUWOLXwnSP0rB2yqnMeAjuTCgkKQeLDkA5oXt0wxQZ5JBL
   CzYGwUm9LADSMN7dUGcwStrP4UDBP3Lp86dpdJtvuUjxQs7hSHzoa7LXi
   N83USEfmpt2MplgRjhF4sahhNGNNFC98zJvhyH06/xQBS/cu/Dzdd8KDH
   5GMyShVqFy2+/pzaiRQotpPvOziX7A5MAkseigaBb/sORneVCK4QX/xKf
   VsoVtxrgDWDZjpr+bhsq8s7aHixjYLWhAllOG2450XL2IAxIps22hfXzQ
   w==;
IronPort-SDR: Jq6tnqfLSwh17UYcfJOGEKr3YKH01nK7/YgtxrgtQrCEaCKp57o3ryv4OV4PiYvUIMHS3X5RGK
 oIuNU0S2EYGQZuDoGImEfa8JR7VTS5fSvtG/va3pQRR8ED60H9gl2YLiqReAcFT/TruoZmEhog
 H9HS7vIlI/os5J2dG5l5vX3RIdFGGrpKflh0nTmkOJC5nP7k5d0KHiE7IRM88dcvtkWF16S9TI
 4/3tanqJ/1OWABWizzzP/sUPf9kGXTI5pIAW2LyUivCpGA+1Hg6VD20hA+ax5Ko1ROzrs6NOzk
 bM8=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="162172826"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 19:05:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH04RCchABeFdT8UbNcNGjW6i0y5x8RUNfG/gclsmN/7B6yPblT/bc+fPITpt4zytIWRz0VYJ5Yv9AColwEPksgmsMJivT94dqOBB66wCdMZ/FbNc5uSe5xoQrKhLHv8AFEl/e+CBwXKasodSj/dKxZNiWNIHgYdqI6GLdxbe6Zz4fPqbGjSmoKV9QhHhQYfJF5bDzoHa6n2T2yfHwlHqLUkaMEQVZPfH9Cz3vdDpR5Cs2XeX/Zb/fdTVxzUm3LitIR38fxqexGPtKO/kR+L6TCoWgIRp+0A4zCK6qfkR3NkKFINexRAHaKL7ibM5bdJiHmPAz8GfNQeiQOydmrjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBNtY1iWybFvnC1RPj74pXBDFxBhB6+zIHg/7rjTJTA=;
 b=If2YfDBDkMeNr1ajYcY/N1ouxe3+sCTxbbV532m8Aw60s0OiCbNK8bV0TpcBVHCB8AYpI5DepXr8Kn+Hw5Xc/LtOB5+73+2Y8aGGqzEVn+VUf42tmA520Z2VrNggeexYFnxfrHipcPLC9vX0ov2Hjrxg6Mt8TekfGprd7DNALwkSal4taTtGfa7kU1wXTGEVDQGxZT7Ua95olsbb+YsyRLQoO0cUOBOv40UBsAUelsE0TK3RpDujqXgjO9wsMw3BPIfQPHn7GTzxaJcPqL8mU78ii9YAsQVGKlPeOeQURL7Ym6351qwpsL7S1qH3UGg6qF1N4dE/nCD/FH+/8d6aQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBNtY1iWybFvnC1RPj74pXBDFxBhB6+zIHg/7rjTJTA=;
 b=I8Km08uDV5h2FjBzgyplRku2HWSe8i4X8ok3cUn2h3tA7eTH1GAcWs2dMyPvrimiHjCq9qzG2PN2a26Cw7AaTDQv7XDOq47SmGkiHbgqHWmK6Kk/zeFJ+k9bM2UzArERYTF81I5EfndwYfj1RGHRkfTIFvGtBS3ekzpAE9sGWxo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5547.namprd04.prod.outlook.com (2603:10b6:5:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 11:05:36 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:05:36 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v6 1/2] RISC-V: Don't print SBI version for all detected extensions
Date:   Mon, 15 Mar 2021 16:34:59 +0530
Message-Id: <20210315110500.802897-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315110500.802897-1-anup.patel@wdc.com>
References: <20210315110500.802897-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.167.33.244]
X-ClientProxiedBy: MAXPR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::15) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.167.33.244) by MAXPR01CA0097.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 11:05:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b9c3ccd-da4f-470a-600d-08d8e7a24282
X-MS-TrafficTypeDiagnostic: DM6PR04MB5547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5547B87A70EBF1BE3104FB5D8D6C9@DM6PR04MB5547.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVvzab03OdnSuLUy9DBPb50Hys8Zp1CMLZK1bO4t/xrfmDYQgRenMBqJvfd0jec1C6Mot0E98AClmCo3TzHALLu0rGwY3L5Rb4i2vZh+jUq2xGhj6NjfpoQMuZzGLZZKLRksp7w8z6wg3kecdG54rZZSXMx/hR8ViwKqvYjte73xNpcA4Pu4OA6f+6/scHXVZCHHVzdcF5rkp0VNemhfPIXNou4gno+FHPLD4xbGLTQlndX2TAQadgyV4mNbfRJ3mZuzOj7ervtse2yQUm+GpJ7Rb9JMp77Ev5caG1FewtDP9QEU3AeOXj4d0pH/8PEVRYtZKrB+ZGvvYxOpt9/bCxNXfR7C6IIPRHa1I/EPXXr8TC/AyVsVUugMWMakA1C0M3Yprjyx5+uWBLnajK0IRUEcyVJXlcSSDTyGbZBsli7iGuei05Knkzpr7AHtYUm+3L3eGFYSs6+KapZ5x2DKCQc6cxYQV/146FztSX6YlzSATIqlztQQ5TtcpquIOuc8lfPWsF4BT+r3A5MSTJ0Te+BvJLMyrVrZrQj6hIhWLyJu49CXbzuudUmrXdfSRnE7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(52116002)(4326008)(5660300002)(2906002)(8886007)(83380400001)(66556008)(66476007)(86362001)(54906003)(956004)(478600001)(2616005)(316002)(110136005)(26005)(16526019)(186003)(1076003)(8676002)(7696005)(8936002)(6666004)(55016002)(44832011)(66946007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/si83BIab9aP/tC3v4FLtIwreDcrBRPoaMLKMBTFcPjmRuh580K/spkfgSw0?=
 =?us-ascii?Q?emQq/2SGM09I+BKUNkNsXfq68jAmHil/Nb4JeTykK7LAUGeTZY/MkODb2q+c?=
 =?us-ascii?Q?U4S6PJ6MNZHyQJHpdaelFWP3fuKWmthl0gNVYPePAey/9R1hwSrB0u7aEWKe?=
 =?us-ascii?Q?+MR5HZQjYyIpxOLaSpk07Af/ZDC8dF/TLD91K8wGrPKRGBLOEbqc4Es8eE/n?=
 =?us-ascii?Q?GHPyuOV+9iCvBND1zpVYPlLDSRI12BpC/D6jngO3G4FuJGml7oYq9t0YTSsx?=
 =?us-ascii?Q?5lUWPtQRfKcmdMy+fB2mUXB4pZ9Ityb7z+x1J/8UDgwUZg43XtovKis/p7tq?=
 =?us-ascii?Q?VwohcqJiSomonzUuTRAIFErpXOYr97KmWZmgtIDU2XOL1QuEk0+Ku8fuT7+s?=
 =?us-ascii?Q?R1l0WzIKTlhgt7KCbRjH5Dy8azWjcIqFAUYApOPkbm+pd9V+yY2Frlwe9L7e?=
 =?us-ascii?Q?LDwX5s6fuZtae9rMnZ0C8Ndnkhq6Gr/mqxz0o4nCH4X3WW5C5VNYR/GZXQO/?=
 =?us-ascii?Q?iQXZFGLuTd5yNFZnLLOMNpSrXZzwObCk5QPQ6g/rMTPXsrqAvfnKs4nNrW/m?=
 =?us-ascii?Q?Zt62aW1izZynuJj3FkqXbHH73D4zMfOVUhGl8s7kD3Ns7cG9vQBez+CbUpSD?=
 =?us-ascii?Q?g2ki8T3Snaez0JXezgTcFPpcN7T4GDCt3xD/sdiMKORV/AHxRN9bDXW00ixF?=
 =?us-ascii?Q?3oyj9heQE9Cm9d1PnacZvqVZagkR1pIilT07ACOAmN+JSPK++cQlqAWb5jSj?=
 =?us-ascii?Q?V3dL05tCFW4IhnY/PkvhnlDr6Rpai6JqYY/Y8ZCDXiW/FTwQ8xzKqUn9nV3h?=
 =?us-ascii?Q?eVfzKB7WGfAEedwobVsSZxwSCwN+5ot2XgE1V3RoheWnGTJ4hmfzrKhhI5zd?=
 =?us-ascii?Q?HxFAn9v1P55ZwRQDqCBk5tkdJZK4hshSG42pI1XF5XUyVaJO/jDkCExf+T7+?=
 =?us-ascii?Q?oNruDIgVwNeyqTFP4my6l73Fwf3dIO9Oh++JY37E3gkOWRrCeFchC4jHh5JM?=
 =?us-ascii?Q?7I380Jj3VIQmF1oA34lfLeA0qZHJTHBV0QJXpfv1+ptVU2Ksyx9sYtPkYY12?=
 =?us-ascii?Q?oXJW5ePT4hf6RJWnKYb+X0H9q0nHXv/OkLw0dAaawhSg0FTNzfhdplwfvzN7?=
 =?us-ascii?Q?pG/slFxOz6hHchavpkYoeOKWUlMyjQf0P8Cn0El//JqAnrLPiakc+DElSd02?=
 =?us-ascii?Q?gdEmyduc1M2rdP08wGelql0PdfQSNTATWvxrXAtS2nI18t0X5dBEbeDslr+v?=
 =?us-ascii?Q?70/3rXLxByPKhE3yPdr6+k4jCc18oAjDeq1q6ADo00Se6Bzz9G12LcEULivv?=
 =?us-ascii?Q?uepFHhAALfilGYb5qGEQy906?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9c3ccd-da4f-470a-600d-08d8e7a24282
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:05:36.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7redtTkG0jqeYtfX/jCEkVRbcX+/cqOoWtnN11M7XFagajSpsdj8EVGAsHwX4m7fQVYjKN1f5Fm9BpdOZXjlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5547
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sbi_init() already prints SBI version before detecting
various SBI extensions so we don't need to print SBI version
for all detected SBI extensions.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kernel/sbi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f4a7db3d309e..c0dcebdd30ec 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -577,19 +577,19 @@ void __init sbi_init(void)
 			sbi_get_firmware_id(), sbi_get_firmware_version());
 		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
 			__sbi_set_timer = __sbi_set_timer_v02;
-			pr_info("SBI v0.2 TIME extension detected\n");
+			pr_info("SBI TIME extension detected\n");
 		} else {
 			__sbi_set_timer = __sbi_set_timer_v01;
 		}
 		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
 			__sbi_send_ipi	= __sbi_send_ipi_v02;
-			pr_info("SBI v0.2 IPI extension detected\n");
+			pr_info("SBI IPI extension detected\n");
 		} else {
 			__sbi_send_ipi	= __sbi_send_ipi_v01;
 		}
 		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
 			__sbi_rfence	= __sbi_rfence_v02;
-			pr_info("SBI v0.2 RFENCE extension detected\n");
+			pr_info("SBI RFENCE extension detected\n");
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
-- 
2.25.1

