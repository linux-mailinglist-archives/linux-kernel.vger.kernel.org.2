Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91E3ACB29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhFRMly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:41:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62817 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhFRMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624019977; x=1655555977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KlzjgfDDS0bfoaFpWdrpgenEz3ga6t8KJmgOBXJ5SfM=;
  b=gx3hQw90CZ/9qqFHSeCykZZmWSCd3Z8yw1i1LsZIGBicxOVZsldVmecz
   enH85jac8+4W0oHPFD9y4Hi+Y4Y2WE9Av1RD6BD8NPHqCwu6hklDVNLkr
   IXsB3PspRcPcj40pu6f7jtkFsLSMPV2KVXvV437MECyFxg2x1uMQFSRrl
   kFX71lGDtwqZCUPSvm8SCIzJ5n04rxGeOXD9n8L7CE7m0fvJl/XOw00br
   g2aD8qDKU3cDiMV36Ul0BWLKKJty3o2DegRqj0m1aKkulcfzMy14mDAcM
   jmuvSBK0JRHU0jBOwJk5zGMAcUVwbmcWPRrCbSYE+Q5A4M8Rjpl+Vaplb
   A==;
IronPort-SDR: GbhzW0fQpN/zHwWhM3xoiEI6AKw/RYCF2v3oTA2C+iRpwH3YYhI1y2eSmToCu/pEcqAcanqMav
 Wv1iPvNUm7b0Koc6mOMNESIJbJlWnU+62y6zI+M2yZUPmYAxUZC6ZMOjYa+rwXxoXBhenzdgAI
 7UJi1LWTgunUjj34sdlJxxu2gXPTXYJwLho82ZP8sqimq6Ct1G5s6ewhabiLbnmsixhA80GEu0
 +kP14q7k7HSUDXF7ArCBYvTFwKM3FDG7+2FuH3A/R7byrvnNEFrLfSFK4ya7Pu/eqyQrFXWQl/
 vi0=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="283779308"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:39:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImsDc1zqa4h3QoXBf5o+fFZWzE2NH/3N7CLNk9aCGWMbAbh8enfCmvoAkJwHDbERQ17eD7EqmREvgY/SMOGTjLTEZr33qLGfLAFcK+fRO5wvyeRxLAgRN6Apnid1wuzx5Hg9ylxBQ8xtCPG9NqREdIFvyZahLMt4y6VKnkD3trw07pSkGhrkmICl3x4w6D8ZHCOdIlA3F7tMb/vjd2GoAJCs3Nn+AfH7Sgu8TtiQluwvRp0LRZmNRoiHEzQxWM6IDLY9ITiIqGII7Idx59EbfrmSmNIpcUZkTzfegRU5S5DUdGuTDj7LbIRb4AaZUcqvzeUUIcKPeBOdbkHmaPc2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAiDCUj00GGoAG8WLp6p6vPZ+oLgsdbXAnnLR8roOos=;
 b=GuVkdRTZZPgT1rc9uRwP0RCUigpPYSonrcqendMrO1P+xkOW2pphcJyhzVRCoV9skmGuOlmI0Clv20QZbUOji8ZzgElRc/vTfE3MQoozwJIrv6QUNgGcCJlkumAwb/gg3J9yXu5Q86ual8h+mG4xZpKntm7ebZHYUkw+Y9Ei/B5NG1S9H5eWyzJUzNMGmZKMcFQnbO5+0+zlPyPa1mH3Xd/5XIL+LsF8ayzNiGTvWil3IggfDI23OdptUblZJ2/VT6o0CBpYxiFAtg/RaekS1xxhgCeA34kK23b49I5Tzb1exMMYWGo+fGY1n80PPvv+RDnZWhara1dteYuSHznkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAiDCUj00GGoAG8WLp6p6vPZ+oLgsdbXAnnLR8roOos=;
 b=AH9bfI/Ym+25Zpz/0wpHnHK/b1ZWgOkooBh5kwn3/Z88kNP21r/SC9UIDpno5di+U0vqdxqJh2y+oM1miXgHJKrffo6RS0vg+k3KTmBocs68sSR76cGvWDzvUxERfXn6xkaRhH/S2JjvIz9r+uPPjV9UpMao8o7s22CYFvxrbig=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:39:36 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:39:36 +0000
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
Subject: [RFC PATCH v2 04/11] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Fri, 18 Jun 2021 18:08:44 +0530
Message-Id: <20210618123851.1344518-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618123851.1344518-1-anup.patel@wdc.com>
References: <20210618123851.1344518-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.164.186]
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b455923-6198-4c96-7c80-08d93256218b
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78434BEF7331B889BCA32B038D0D9@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNviAol7z8DsJnkhqs3EYri8pV87dAtNJP4dIhwYxxwjj2ifnqjfW7bR6MnUjpVsq8WSX31MxDgmVhZGXrViuhrtWcsVX5R5gVQZHlJn9n2lCDmCSYWRcMoZPJf4oCvDye59ygZHY08jysEiIucfNgJ5jEkpVrL3lulHrpMtO1qNMK9JIo4LZS5n7T3/mscRzHbjhHJ8H3xSaIGyWgHEKIcQvx42xf27sLeZ/dz2y4jNqvTMMtSSwF8CgZmrNyuzrlxiDJB/ppBIPaJydC58NCm7UZahfXnUUcQXUUz7t6EZX014MFC3xQHcVNJy2Cg1rZ3pa+S08UWt2ke5ZWiw/7p/7YOMTJAsUayFeV4LeOSdJRvAF0kBGXrPEWtMTHPqM9wtLeaM2Y4Z6YiKpLXmia2SLVYqFN6ZoAqIXPrnu1neiI4f0264CaRhhRnDFWln54mY/m+Nq+ldjtbU3AlyUNIvTF7RHBrXqwahxeArKpqenx9zDFpb7cQf0w1SfHGpj/FB/XArsMxMuaD7rtiCDRcN1utxC5toWIwH2fduWWNlXupB309k3yQjgmpj4bJ1culIdXk4SfcKYvfiAkFF3a09pqiMllRyfV/ZVTZ2l71cfldiZ898X/D2L99wnlJkJXpmYfSq6QGs3aFskya7Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(83380400001)(316002)(4326008)(16526019)(186003)(110136005)(54906003)(52116002)(26005)(55016002)(2616005)(956004)(2906002)(5660300002)(7416002)(478600001)(38100700002)(38350700002)(8676002)(66556008)(8886007)(44832011)(86362001)(8936002)(36756003)(1076003)(66476007)(66946007)(6666004)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lBQBccsGOWMDQ9VifTWOhXaEbTAcKaRybvVrIl73Bv9KshMGIJV1u/6I/aJU?=
 =?us-ascii?Q?sWYRvfrQgGvgOjInaYa6Y5C9bm+JXn3i31Vl8aM3NxTMdTiJAne97nsDpoXS?=
 =?us-ascii?Q?9kdLHjYdyegmNkoZYd+VWVLf8HvD4yndsGPjDLqQbnhzI1sGNuMHFkWya/S/?=
 =?us-ascii?Q?tPL5PbHPh3j0tP3Kt17tKIybcvIWWf8ZFPSrrL7cuN6Y3PdGuDbi80Ng4ZAZ?=
 =?us-ascii?Q?Nw9/1iaWny9c2TkWhwRYOyR6LMmIuzWZdlb7apZXHSqC51LDm2CLiSLTKU2N?=
 =?us-ascii?Q?yWEsN2AZnr8IaEyt9onGU/zjSzgtS5JLeCmkW1B2JiWFpWX8rlYtWFyFkfRX?=
 =?us-ascii?Q?aC9pQl9YCJXX/CjDr3kQU2AcSmI1qEdrlhbkI2xy+AcEGthhNiej4lo2B1LF?=
 =?us-ascii?Q?yqEtjbR5X07hrplc0jLmjifzWztMAOfCC3OIEZI0wild/0oaL1+RmDuRpVyq?=
 =?us-ascii?Q?Azfwp/9i/gH08pYZdhMlU9C+yAVfANT1eA9qs5jKJhfjjRj+FoZ4W/wrENiM?=
 =?us-ascii?Q?uNfWDz54FYXv77WtU9WHcLHvM4nyIIXMK6onQ2SL4P56yzWhacHFNZuKT0Gh?=
 =?us-ascii?Q?iEyDRMY2UAw4dMhDwBJ2PFTM5RW/C44JJVU0d77LOgDTKZWIx8CJVweO6dZF?=
 =?us-ascii?Q?kd4ZHJxFU1c3YxYvUC0ukSNTicnebgISWRJEB05kLZKy+rRyeQ2vWF/VGQsG?=
 =?us-ascii?Q?FdBiTBYyMNYkJRpR+M8C/HGHUfRU0DwfqEFe2UQYVnN/eQfoNnn1jFBtn46B?=
 =?us-ascii?Q?Hdv2Uc4ZGuz8rxwwgnDdIQMakYV8pgD8JAuj9v3+06ORto7qYrnz9glV8nr4?=
 =?us-ascii?Q?Bd7wxk+zzvNKcbFPTp0uxps3IS1RcLeqKekTQM2u8ak8kLCxAnhpI7g34Mpc?=
 =?us-ascii?Q?GSIkxb8Vtwjt5s+xZ8scN+VXu8easiVBmcvUjQzz907xg/6xltpOBqudjC+f?=
 =?us-ascii?Q?SKLSQlpkxW1DunCWPbBUkOTgJD3gGZsxRowLJJvXgidpPwRIxzr9BsrxLx7k?=
 =?us-ascii?Q?vYhEKizyjpyqn8XnpjqZzLHrbYYOCbM3P6o7wVV6IYlG8HrbmIsQGLD7BDov?=
 =?us-ascii?Q?uDCn4LJVkKEcF3Ch7jfmVe3HaFD15E5FdCJQEukdWNm4MljEmctZn9UQsDTj?=
 =?us-ascii?Q?WqfWzuRBasykakH9jBiElZpu5pUsbce0qburCtwnAKymYyFR1ukcRbvS42ma?=
 =?us-ascii?Q?epauOMjEmS0lcqZ8pR6dWwoAzG6xcatS9C/ecp6BNlhpaaelAqk2JIP9O5vu?=
 =?us-ascii?Q?AsPZpkYuy++oZZ2wgMq2XFwQJ59aSES9EuHc0IHpCV11Ehuvg7bdRvKalTfN?=
 =?us-ascii?Q?AUV+wSfv1+VHz6x8GouBJqT+?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b455923-6198-4c96-7c80-08d93256218b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:39:36.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a6TjvAKZ2ug7YDka56s6S3jfPLHPmASDiW/mBGaEz6hNPTrQPRlfa/u1o502Xe1t5pGzh6YT+OcOFHMZ6TFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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
 arch/riscv/kernel/smp.c      |  9 ++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 6bdaab122ffa..f4856c911335 100644
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
 void riscv_ipi_setup(void);
 
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
@@ -102,10 +110,16 @@ static inline void riscv_ipi_setup(void)
 {
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
index 6cc0ea95e1af..0a06542d2b74 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -153,7 +153,7 @@ static int __init sbi_ipi_set_virq(void)
 		return -ENOMEM;
 	}
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_LONG);
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, false);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 26d563615f53..3905177b6748 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -178,7 +178,10 @@ void riscv_ipi_setup(void)
 	riscv_ipi_enable();
 }
 
-void riscv_ipi_set_virq_range(int virq, int nr)
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 {
 	if (WARN_ON(ipi_virq_base))
 		return;
@@ -186,6 +189,10 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 	WARN_ON(nr < IPI_MAX);
 	nr_ipi = min(nr, IPI_MAX);
 	ipi_virq_base = virq;
+	if (use_for_rfence)
+		static_branch_enable(&riscv_ipi_for_rfence);
+	else
+		static_branch_disable(&riscv_ipi_for_rfence);
 }
 EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
-- 
2.25.1

