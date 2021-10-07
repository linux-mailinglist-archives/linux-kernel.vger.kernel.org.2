Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD85425338
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhJGMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbhJGMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610232; x=1665146232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FeDTcAs6A48k7Cm4mU1jAWLsnXjd7mXVELZu0NXgxtc=;
  b=mZLFhywA5hW9CC7305BwVIDQMYFPKyWzLjoXK5i0yDrgEj8cRGcbBfHo
   tJ6dGuZe9npCamL58TkKsKbjVFMK7saUkVOBRrjN4NRzTpAd2s77viQWt
   d2cyCPjdEAtSvyFV9UzYsknuBPZMUo5GhQ2XHFXwLt5XYzvmyp29CtYWz
   esf+yt3S1CPLR8jh3DJPAvoMU38iC6mOYz5C7HdSLqxdb+LNUCG8aX/oX
   qUK8AJohUbzIocfdRlqBWMx7LRv/c7xWYFnAUNGC8dgJPk0eTjUXna3Q1
   5CWrKnI4TOktuGJg47RjUyG3InJiB6cywwU4VVz9GqzFb23+0NqtkcWyH
   w==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="186926237"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFoV2NeJHrp1lf8tuutQzQqK4ej9xV0I/lWs95V6Dfke7+FppEQj9PqAVZ5LDYDM9UUkUy8TqbV/vc6skSHM/mIvXvTKSv+8jnh2Q5xfRXAR9c6EdzwO8iC4KF6uDG94uPcnTZa9dNKsWF5MgeAJzUxL5dxCLMsVocGGMFqeqB8rT5tAm29xdwir+3xUA3uggCOhpjDQc0eI3GVjSC2ltb24tsMDhQQ7uG4wXif6Ala3d0qNo5OrvEsAx8ssY5M6qES+K0UecsAMKxzCeauor+QzADUE+0obE/CecnGm9T9OL4WPofqObPQN93UpC1ElnJX0U2/+Z/dQ+SegTNvt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aDXVQxbydsdk33I1+nWFdr1onRtybWjw2N7gu++NNw=;
 b=djacEp1j6UerA87D2QKMzcI/AMTdhffzgfsJIyiDZPXzbUx4OFPdR6zrqKpDEmflIAfSczt7cAoDQAVBXIOi21ozk33nvcCP+cYAyCdmSKQK7TJyy12QWz26Xr9t2N1c1daO+VPH12t1tP2qm//uyQ6RHQuoO+Ugq6nQdKQFCKAL3aJFbZRaa8ACMLIN8qNA2Hrq/AW1hKK7o1tCIidma/xZZqPlXoM8n15GAYafuNFdOttPUgAviJZ8hJcjXSjvLhiHxt27LnWpHWzixr+snrs4yJGoz6DiUXxzOcG4YXY7+locIs2XI4w0hIJkgeAQbhP9H8X0rEuE9QVAaPOmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aDXVQxbydsdk33I1+nWFdr1onRtybWjw2N7gu++NNw=;
 b=c9Xok9TLV7FmFNWZGIljuKPCvf6np+8mI1y5nPXGRROGvY+h3ziLba4IMamJTVkjLz/PvO8Z+bY5gZakV9MVWWPDnjdDKUFdO/qJ8mY8fwvMJ4ujpnSuLKI2jGeBrmVplLZy1RWOIlUjcxa/zONkiBq+xei2yLG/BrH9XP72MQU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:10 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:10 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH v4 03/10] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Thu,  7 Oct 2021 18:06:25 +0530
Message-Id: <20211007123632.697666-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa88e28-7a6d-451c-6ba9-08d9898f2e6d
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB777712042045EB5ECD3A15CD8DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/hqs0mQPgdDcB2t4Iu7UbYZIopxGwL2ysV2k/qlEz9hxQrWEg6agMDyxBYElXf+jK4NFWoF+PNtKsaar6O4ZwEcSv0Z2+amshSswnxXqjSxFmbF+SSft9NPGBlrI+smOBUwGlIgdrbU4H27eoYaxVdc7aTk4PF8/nRo0bgyR5gmPgKDLRtq+hl/J2VHznZbN3cY8YWlGPTFUHv6dwBh+GzfF+v/P1Ck+I9kVFGEVmxsv/vARsO8zV5Qq0g9lmV38grgYCCMwZFNAksG+tu3/1kVPyPp4fFGjQa0b7fIYThiYVoTPTCTxCsiuwEJxrpwdV2D8lEzIhjbNhVtRETg7XP5P2Cay8J3V4nqxkj1KEbsEh74PnkD8WQiHUPBx3/EaMzo8mHoal5JxcuJ+1SM7mr+tFGdtLScIOxtIGbuG2NJkJQ9QFW8M7qJEbAExDFEpjsoRpUD2O3j3/5n3T7L4VQs4xd7qiRli67l4MUIStecP0b4H2BlbVpUYCWZfpkgy89vf0XaxAHXOA7UtjRPR9jN4nnJqJd+vDmkxt/EIaTiv0ZbLuvt04cwaYDSjfygoi+Dijpbwvdtp3M6hC7nr7mq+4ufcTi0iWTcJToITFrmBp8h39MkU2TsyF3pKu+4bdAFGws+bl0oyv3cr87InOrf5yqxwP8FTEeWDCHtl3H6R2GQgeva1/Zs3VNEqWTf5wgPxi/aGy+2/V8Boaao8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(66556008)(66476007)(36756003)(4326008)(66946007)(83380400001)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+IjeRxGXT0WGUnCOslTTzlzLGg73YCOpFfA3Xh5Pd0d7kpfLKb0Qzm2+V21m?=
 =?us-ascii?Q?cwViLbJFppMhwWmor49expQVsTFkb1ULFqOmb6G4qQ/rdFSu5PBiHrB9yPtL?=
 =?us-ascii?Q?JsbGaIbm2ZKbUd0RKSaegiA4p8C+dJ9oFt04WIuuD3TOJOE0Mb0IGJFe9ZYp?=
 =?us-ascii?Q?x5fRbfSZvn57mZHYOOIWpMoq9MVceTbQ0D8ZHMiySUZkkq68fbAvoyqFi23Z?=
 =?us-ascii?Q?d8PxS4ONtoOXcO/7AGKq+tvdfSM9LtU8Qf2DoaOsSbDMZPjJyn1+ROqfcqdj?=
 =?us-ascii?Q?0wpysZPk9a97trf98h6Ye3KjQZktuzFWW9a6tMGl4+vnue4+ggebV2U3Ofb/?=
 =?us-ascii?Q?BQVjc+EK7ICbavPhWMu+eCyJpOSW4Pzh+Ed9A2+YkM2Icu6BttFeltHA/6xi?=
 =?us-ascii?Q?3ggR2J4DNGqa5NtDYoZsc8BY9cmzJaCr0WQtnvlL4NgM/aIAscnQYuCq320V?=
 =?us-ascii?Q?IunRWcVA7M1hjC38yD9xQvH3/VsTvyYsCALSChAEjQUBo49W9pxnoVDOjAMu?=
 =?us-ascii?Q?vzdEkEYa+6HFz8VUVk4iZlVg9vr4QX9Xx0YyKRYKqB319ahTusw5wK9wqFbi?=
 =?us-ascii?Q?nD+Kjiu6k1eAEaSi4L3y3NkFmGD9AwE3KO3x3yvpKGBnhMsQZT6LANanBmdr?=
 =?us-ascii?Q?XKO8horx4js6mtwwx3f/zRdzXKZcNljSqxXzg/YD/onDMvFLLstXXAVniJRV?=
 =?us-ascii?Q?R8hYcukiA4YpSu871yn/QwQuxKzuktO6qp3CAKH9ct2/z1nE1yl9e9twpTm6?=
 =?us-ascii?Q?Fuzn9A4hAL66wrkO5oIIW0xKyJIYsvs+2x8ys5CcnIQdMVtw8iTLyWmXkxTk?=
 =?us-ascii?Q?5a1d4wa8Svj6GsA5UVh3qJyIekDX2uXRwvWH0eZeaaun95IOJ9x/obERyB8S?=
 =?us-ascii?Q?HmpS28dW8GSbwVNwhWABSM5S3YkyE/cfThYiP/1JzFFLxTrIUJlxkFM4S3lM?=
 =?us-ascii?Q?38uZBToT1N0TGVLvF9xJXxaUmDCM5a46gRYoykLQtgEWaID4nZcaJb/RpX6Z?=
 =?us-ascii?Q?vavWf/q0jHms5fyW8MqqjdepxPGjKqhXjikCbuTTdHNdgB8Yc4/rq38RdhSj?=
 =?us-ascii?Q?jpKslMFWRC0DR2Bna2i0zm0lWeXcleriuDHiekWyB2YsAH1sUl9Rl/gUBHEa?=
 =?us-ascii?Q?wqX3ciVFQNMctNY8f3R3d+GNxm9ZNyyYQ1OMF063TX7ZvmhQyXxVBMP+Gejc?=
 =?us-ascii?Q?n08xAp6z9oSLhH6BUdYncwzNHsGwxPblLfmvX15xZuunvAPxwu84u0Cllqj6?=
 =?us-ascii?Q?00lskb0kS2bRXdN4kgYLW8ikVQ0++vYcwYgR68zeHTbKCSqAciiwMDpoHDEP?=
 =?us-ascii?Q?DMuM8/2dwfCqdE5LrEXeW3lk?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa88e28-7a6d-451c-6ba9-08d9898f2e6d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:10.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGu1wo2pwrNDab+fEsCgqQ0Rq+qIuS+G5WtgimbZj4J4qlTHmOPJ4wSBCzIxd37LVk0CLCIv/2YLfBkify5PiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To do remote FENCEs (i.e. remote TLB flushes) using IPI calls on
the RISC-V kernel, we need hardware mechanism to directly inject
IPI from the RISC-V kernel instead of using SBI calls.

The upcoming ACLINT [M|S]SWI devices and AIA IMSIC devices allow
direct IPI injection from the RISC-V kernel. To support this, we
extend the riscv_ipi_set_virq_range() function so that irqchip
drivers can mark IPIs as suitable for remote FENCEs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/smp.h | 18 ++++++++++++++++--
 arch/riscv/kernel/sbi-ipi.c  |  2 +-
 arch/riscv/kernel/smp.c      | 11 ++++++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index e5480d75b2d9..42569f1130f0 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -16,6 +16,9 @@ struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
 #ifdef CONFIG_SMP
+
+#include <linux/jump_label.h>
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
@@ -47,7 +50,12 @@ void riscv_ipi_disable(void);
 bool riscv_ipi_have_virq_range(void);
 
 /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
-void riscv_ipi_set_virq_range(int virq, int nr_irqs);
+void riscv_ipi_set_virq_range(int virq, int nr_irqs, bool use_for_rfence);
+
+/* Check if we can use IPIs for remote FENCEs */
+DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+#define riscv_use_ipi_for_rfence() \
+	static_branch_unlikely(&riscv_ipi_for_rfence)
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -103,10 +111,16 @@ static inline bool riscv_ipi_have_virq_range(void)
 	return false;
 }
 
-static inline void riscv_ipi_set_virq_range(int virq, int nr)
+static inline void riscv_ipi_set_virq_range(int virq, int nr,
+					    bool use_for_rfence)
 {
 }
 
+static inline bool riscv_use_ipi_for_rfence(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 8d06b1e3d682..2728be0439a2 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -149,7 +149,7 @@ static int __init sbi_ipi_set_virq(void)
 		return -ENOMEM;
 	}
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_LONG);
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, false);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 53902cd1671f..b9ea5f88ca0e 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -159,7 +159,10 @@ bool riscv_ipi_have_virq_range(void)
 	return (ipi_virq_base) ? true : false;
 }
 
-void riscv_ipi_set_virq_range(int virq, int nr)
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 {
 	int i, err;
 
@@ -182,6 +185,12 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 
 	/* Enabled IPIs for boot CPU immediately */
 	riscv_ipi_enable();
+
+	/* Update RFENCE static key */
+	if (use_for_rfence)
+		static_branch_enable(&riscv_ipi_for_rfence);
+	else
+		static_branch_disable(&riscv_ipi_for_rfence);
 }
 EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
-- 
2.25.1

