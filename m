Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8353FB05C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhH3ETE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34860 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhH3ETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297087; x=1661833087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UACASCCu4bZVbM9KnCDapGebG+fpRzurqhRW9zyjqrc=;
  b=bYqrsHBzabptqzUunL5/KRYB+eNO7Exk0pwPMYwEr1QhAw21M1989K7I
   w23p9ySkyY3oBfWT63FPXpBnEnwsHKM9H+bCmUep/21aXcQ9NG/Dc/yFp
   +50IYUL5oHda4NtFB2GJmjoOORV2a5eQiOFAqrw4XpkjspZNRkzlTfFsP
   4w2it9HViO6paVeYnPCYrF9gNuLB89ij6QMeFQr98NXdj+JJfGlAiixrp
   3+aU2oqf6NzQYxgsUbw5YKHoyRgDmJFMP++dNaM4EH/lUSQaKCZKC2tEG
   oUjSu1EIMO2RbvoFtD3f74F3HJtBvKNe6fPX5jRzwA7zLJAtlt55S74ru
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="178734032"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs7q/zxv6PF74cOFlS5KtDtClfWW2gv+kDuamguYhHYTNIveVjutUvFYoO///WA3R9oSvOdHha9pZy98gNK3OoZVirC4ShaFc4Mt4V2v3engwF+RaHmgetLNjkaoaf0VRSOcR3m85Zs3hj1UPXHOFWVWfy7LodNpJqvgGDwzRVYtgwSsszASTQd081ZQKLejVSQgWSWEFDRvsBv4wcIczVfBerZ3zc5SmrG/XDsscX56cwTLI4n8Ls1ZyxaLtzoIjmdegScC4LTkkvY7anxRAsvShiQPJ7CvXvtl/Si0+2SBxZ4MKDYC9vscdoLGp59BHnw/M/nHh9f2e65rQyYEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf6W397BRew9EELVUGZ9YLSC1OfSExrKtD+7YgpPVww=;
 b=lQOmXvMNDGV/yRXa0g4FHXcEb8I3UTZW+fVZFtxGqMxCSmcRYAN2biI1gbsrgcWR3ITAjTdyaG70wH7R7t1+Yiv1vtPgd69jNt3MFKPbvZK8fEyYjF6R+17UwgazfdYcZwfg/HNHEuuJ/yIfzEo74AFGYZRjIT9KoxkOpl7/8jqfW4rXkcQUYab9uTawT+hKQ5nR92W1VLGJgReIk3w+XJfHDjsMkfHMVmQCOtBijMEQ2KaDID2w6P9vBeQgZENnwmQQ1YeLKSV9YBpqzEvCpGET8X9e2IxEfBPeDgUS3Izoa+btRhy7kQEy7O3XhRg5FQwyb9y2tm5SmwzphomURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf6W397BRew9EELVUGZ9YLSC1OfSExrKtD+7YgpPVww=;
 b=A+qRcnNop+FkqaAo/AkqRZP045Fw/qoN6jNsSqAq2N5m38PcON3Sy5Kwrm8ax3h/5fcrc/TYgiB5Qm63xRv34d9EnpaLl6uqoqFk3orDfeIdXV8CFe1uMu/dMfRQGueSPyy75v2L06cjJKOVykYbXhFIFeZmOFdkXSwuFeCHq7Q=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7823.namprd04.prod.outlook.com (2603:10b6:a03:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 04:18:06 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:06 +0000
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
Subject: [RFC PATCH v3 03/11] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Mon, 30 Aug 2021 09:47:21 +0530
Message-Id: <20210830041729.237252-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830041729.237252-1-anup.patel@wdc.com>
References: <20210830041729.237252-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::12) To SJ0PR04MB7821.namprd04.prod.outlook.com
 (2603:10b6:a03:3ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ae5a01-d052-45b7-263b-08d96b6d2acd
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB78238F357F6194AA516C57118DCB9@SJ0PR04MB7823.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mggJEJsD8FliCMVS/+FEgDwv+ABIGz391fZheJW9eZ5cfa47ZL7cKWSkWwszfg24gAzPSNLIsz3oe6Dn4pzNywIrTTLwF77LH+dudyCk1YMOuxWLvAs8z9n+lZrh6T1aq4PQg7VhungG3RdGMP/HNNQKtzgP49O5e+qVzRwVlxNARtgTJ+mFx3T0A9T9poUfp4pLd6rj3qsEq5budgzykVzCh34kalltALf2KDCuDnt38yeJdBFZ5fyo03xgIxnT3XrAxVK3IudDbW4J6X/G8PtsyVx3q1OeoVOmviuPDAQOYQbrWON4U/Gy0focyBy+O6fah9XtSjcKQ/1megjQWdps5B7c4bCGsla3cFhpjpSv7/kj5HVSgjNuLPu4kzirH2XJ9cR+rkZR5/yvsK0WgzJDW82pFAA/STGNEjdAlKKbMdVd5ia+URCrLCvNTZWy4OGbXnV8tSpWkoqNWmL4nHBgxfZBmfdEWDxAgOEHgW8sJejF/xl6OZucVDg03zbvklanAJfgLRTHQ8/PsQKOupfPFz/897MkM3wlHFJMqrFEXgYZp8GLAfCqNtcfXOOhH+S2pwwEVq7wtOg2yIYqSIE3LebOWLwrQJ3IkdmSIaUsf6x3hja4QYwgAqC0sMp03oWy2+CXt/gatOzAU+an/V+ks3uKINvM+JGrwwdugEtvlrZ2RDGtjJYLigDLRM0CcPHXjoBciOMxQKkXMXTXyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(478600001)(66946007)(26005)(66556008)(2906002)(316002)(8936002)(52116002)(5660300002)(6666004)(55016002)(66476007)(1076003)(44832011)(36756003)(8676002)(956004)(7696005)(2616005)(54906003)(86362001)(7416002)(110136005)(83380400001)(186003)(38100700002)(8886007)(4326008)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xUxnHaoPO6rsX6cKiS/gdf4PPEbCQIuw34vvGNoiRQrhWEVoKPB2exyTB3V?=
 =?us-ascii?Q?KqJbxqGom3OeurzIGrCCI2RgHqyIMiBauqtJ81WtDmHE7D5ZnvtrUUmQVH+2?=
 =?us-ascii?Q?FXYqNtt2CINhzYDHrllGTWFjnYmpc4Wwk7JwqEa7N08bIRgSxLD9Y37JGDPY?=
 =?us-ascii?Q?sqz/g79L+0FZcRa89+QJRYzAlOnUFSmfaQl7NqD5EUXIKO9nnLT78NAXNq2J?=
 =?us-ascii?Q?DKI9ywhhNjufv7VMGNn75lpHjkvxTGnCLhM1694Xs7US80TpJ6OoQHxljFSE?=
 =?us-ascii?Q?gXfCAvkcJuL0TqCb9vqtKjcTvsahd+ekvAUn1Ax6Y04EKxMbqxYDiBH3FMov?=
 =?us-ascii?Q?vak4eIinIG6Nqz5PhJHtiMbM4C7CZhzY6rAaCY+9cmPEknTIf5mluRXR6ssa?=
 =?us-ascii?Q?A0Qg4sAzBBHO3bVAdYBpUyrfrWocQMZmiznhXb0+C+WHDVSyf5L/sv9EQTmv?=
 =?us-ascii?Q?fBqvew0p8X9Hglapy9LtXxU2qwglu5vlW8IciBwmu9SPKwBCOwDeQ84x7Mul?=
 =?us-ascii?Q?Qalrbx34sG7LrUEkxCtJsLsSF66JigD1mRKVslPb/WDR2aN5LjraDF8kmUsI?=
 =?us-ascii?Q?tUn5ZmnHUxFPmBfYqbfDHx4gJAkXFUe+hTueSrxmr37tGdeR1JlO5S1dtnn9?=
 =?us-ascii?Q?AOQ7whh76xK9KoAWy/NcKr998kIv9x5EFgvF0KzvHBR2f4saCCae8TBvnpDD?=
 =?us-ascii?Q?R6R5ggULaLEuAslSnn6girqarfW59p8RsyD5Oj127QceAM4t1dnEddqt3MgB?=
 =?us-ascii?Q?YBtrx8d77DUmNAGsWyJe/cdYPbuwhI82uaJEO7x42XP4pqgKuQyHKpsZkRjD?=
 =?us-ascii?Q?0lYp/0jTMfWexQZSHWW8BoFyNsBWdC1U23kFxP2HqP7cgF8RltBzcdc52jkh?=
 =?us-ascii?Q?xobzZXmSZBmYXh1bF1BajmTTM1fUtkMesS6mM6V3wvNz+CGE/hxSrEqleIMw?=
 =?us-ascii?Q?CER0BE7cW5/81uuXXTN5jbKto+Rll5maJwzqtcthNwtjb31samMIshT6PYau?=
 =?us-ascii?Q?p6gCujnZOYvoLF4UHqIqikeAe5vbQpAQyCWnMAYoaqdKYD7/exCm7nxXP+oD?=
 =?us-ascii?Q?Q8F6jBvfcvQFTl61UKwKOCHmKqXL9jfcfC1PjYrb62MrNu4O+eGiuWwpPeWI?=
 =?us-ascii?Q?3a1KFL0tmU1kSj83RP48lKk7GYHT1689OCVMFJxGvjeTYFiA0PJiLL67rrGv?=
 =?us-ascii?Q?iV4OKALhWAyHYebz2gvnPD3aD0yW/vqf3biAirAoyYstrBqGeEeV6ekBGnor?=
 =?us-ascii?Q?AZXkBblyZArPvNMxrAfMg7dQ+/FqKseb54t9lIGN7kuq+GhaN+BBLN4C6Nb3?=
 =?us-ascii?Q?oSonRFu/vpQ5pV7xZkXL6r2s?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae5a01-d052-45b7-263b-08d96b6d2acd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:06.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9b4LtHt29aaCsCUMLnZxF3tNwaAk964Pa5CFa7t0hn2JQZvSM6cshexP47tIYFSP0h+60lsesi2W4LwVv5c4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7823
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
index dc284ad3551c..c65daf50ff1f 100644
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
index 6c9873b7d60e..a8ce7a0556ab 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -183,7 +183,10 @@ void riscv_ipi_setup(void)
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
@@ -191,6 +194,10 @@ void riscv_ipi_set_virq_range(int virq, int nr)
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

