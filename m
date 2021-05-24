Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23338E354
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhEXJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:28:33 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:27897
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232590AbhEXJ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:28:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX39UVXdJCf7e9SDYY3SnExtNZTlM/qhrjJhzV9M7522IO18MokMRrWAkybuRB+siXvnhw2DPp8w+b4LmHdDKw5uoteZVEx0S6/ZgbnICghrRwM50nrluWHyPFmrHwXWwQ11GykanDAkK4fGz3N1CPqSllPjCVMH3k+4n9WMhvtIqwE/tB9Iely3Wi11/S/y9QX7e1UTMXkFEiyCGGT/RTzzI2G/IFCtz0AySYIR8LdP1p4RbooBxoZLqSmSinIhnFbDGG3gEPNi89Yhw4XhcU/HyUELiq3dIbWS4cmF640jlWOA12YV33YBTrmEQSZBhEkjmHqe3xwVAWezEN+THw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg7gEh75KCSRWy7ZOkeyvERqafWSItL3pI+nkwcPGtA=;
 b=Obcq4+9dfdVzrIJAxdKjFIBC//MfcNaLKYFV3MsFUwh4qUBqTPqreroDf/7SZWwKSmN1XWQ6dZ3XTo7hKCdL+98NWn/VNkFmhjg9dLNdmDnClrnvak4rWwp37gTpUCxlLF+awljbJFiBP/fRoZfq+Y631DLBTjELHTPORUCWqiZ5UlcSP3Q1ly8DYXpFREkMVL+EDXXgkyHXJdGQcAhqQr62BlUzoH06aVU7EQMdIEyX94zimCxwPTuuFxbq921LXSr22COhnTrU+c/wK8w7LxE0eu8IuovebIgnxH48LCt61EVeW9KUhMQ+/jwty8dgNls/6VzopedEpRYbknWztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg7gEh75KCSRWy7ZOkeyvERqafWSItL3pI+nkwcPGtA=;
 b=ir50RisU0e2oiok4LitI5xh2QOGWICV0sA6kOlM8u6pFRXO2iM9puucS53IlJDckzsPnJD3/HEyzKPG+pPGFX4jfNB+RQOecoGj727SHXlFEb8/ZI4bLNN0A4mihyv9VmcgzgU/T/5ARczgpXrqn60E4DC7cDxtm0Wb6dl65Wa0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6188.namprd03.prod.outlook.com (2603:10b6:408:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 09:26:42 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 09:26:42 +0000
Date:   Mon, 24 May 2021 17:26:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 2/2] arm64: remove page granularity limitation from KFENCE
Message-ID: <20210524172606.08dac28d@xhacker.debian>
In-Reply-To: <20210524172433.015b3b6b@xhacker.debian>
References: <20210524172433.015b3b6b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:a03:167::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Mon, 24 May 2021 09:26:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c197b04-eea2-480e-953a-08d91e960aa9
X-MS-TrafficTypeDiagnostic: BN9PR03MB6188:
X-Microsoft-Antispam-PRVS: <BN9PR03MB618860A27C69CD333610A1F8ED269@BN9PR03MB6188.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SF+h0OIsltN1lo+OaBe4aSGbPShl4BSOCnElbhf+6MFS0zB7SkagxwLHhB80m+VRU/s3tvIaXZ2t/iqf1IIsc0M83/ebn6LDmSzzEcz7gyFbOzEK/LH4K1c3DDuzwDGY9roYuz3PG80mb+cLeuokNsHi9N70Sm8rcJcLrfzGeFctOiuYWw5JDjjKg1YVWGSWbbYz83Zytc9iGISAPaagEr9B/qP7XVhRS1Ebuu7P6fow/TMWw+AHivN9SsFN5iJPk2nO12+xJFnDNBN38oItGx/HYWKlZWaOU+PcF4bh2vxbHVDpH0+/3/dS5jl0Hx8/WYxxqLCskB1jU6iPfb7SwQGNdB2kDbwzBuAVfLB/rlODImNFOixJhV9JEcb5yCwjRgWmp9yE4y95ODtwjs4D2jhu+fQBOJbdSxTuYF4kRuNdACKff33l6szDOaKQtUSxZKNgb9xISUubSyjKX6n+4NzOIwCjIeYTe9JPWaEOo3yjECGq/DPJrptyPPODWaMQ5Z2T8AKIV1Or7sE7q343gl5Oqfe8OiAh82nPJv5TvfqFMbdBPkwgVeZs6NZbWzrfxLE9dpkVmiZVPRp7f5Ce2H2X+xa3rZvSIrQDUQDkH2OWdLRgRKD+6eRlsokn+z+xr9go9hEKFnD2YPzmmWS7fIGvYaND2t3MayNM8tN2iaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(396003)(136003)(366004)(66946007)(1076003)(316002)(66556008)(66476007)(5660300002)(478600001)(2906002)(4326008)(110136005)(7416002)(16526019)(186003)(26005)(8676002)(52116002)(7696005)(956004)(55016002)(6506007)(86362001)(83380400001)(38350700002)(9686003)(38100700002)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UMRXa/8B/HR+Zj5sJLRrpbu6M9wOShn17El6lixBgoA6zyPHvz/MEfTPyLFf?=
 =?us-ascii?Q?/bNl2f8Kjmq1meXyKJlD0gwAYx5YuoqN3ld15VpB6Ueo24uGYXsigHv6ryWX?=
 =?us-ascii?Q?D68nawANsn7KRrCFOLU1hy9zsYPZ5bwKEr8bA0Ow97IcHa4jJrVCQEwYgY/x?=
 =?us-ascii?Q?SOBTKkUnhr2ZXLcdFi8ohTyg5I7B8ox0jMgUVkhWO0RpO5LHeBMDUOmGdlin?=
 =?us-ascii?Q?qP49TsglGs5s6/EhSOK8haXkrjdC7L864o5/PKcoa1H9Xp/p0OypBzEVDtFJ?=
 =?us-ascii?Q?6/PGyZhe4ALaFgi+6cCPrhCe0sX0VFaHUtHqPI1RUL7OqQhrJVPRXDuTgFZB?=
 =?us-ascii?Q?rFN6XOP+alHZXmtwvFw1CEfJgMSBtSFT0t+s8yXQzY3Q5DrC+M+gUJ+RbxU3?=
 =?us-ascii?Q?moUE0yK8pcz1LcXggyCOidjHFh0kQXDAzEcXga5W/3YHvsTaLCraw6Hix36O?=
 =?us-ascii?Q?ymynSHV7MoQLkcvB7U0B8r95av8hfmJc/y0xlLPRyc+sEQFhuQaOc14z1G6S?=
 =?us-ascii?Q?vnQ40mdNB+SFTQLDibwK28dX9wP/d0QalvNakdka9YQhx9TMDEa+oDqfoTKO?=
 =?us-ascii?Q?4OQx9z61ng8uq5Wq+/IH2NEOujTCHQBnXPSZJdwh+cjzh8w6/s0WAUjj0eIh?=
 =?us-ascii?Q?4BpOPP/e7vYpPhI+ZVPbD2tFhpGFXxvA44+vFt28wwCzYImUTXQGAMtRn8vb?=
 =?us-ascii?Q?MPtSM8rytuLv8FkT+JByIIYpeGCLapuSoP6GttHZWoOrZSds/mDESVgDddNf?=
 =?us-ascii?Q?ZQ/S4FmE1iMgHuMtqFSUY+2YB1YhPfQn8c+ph2xeEIoAcfu62725115fldph?=
 =?us-ascii?Q?KjdRDyW0d0za7QB2SWG3BHbLs63iDofBW2kYn3NBei/uOOiiFInTb/thQ1bB?=
 =?us-ascii?Q?MJQELZyFXqVWZOeMlXYle0IAHplb7Ccvls24j0BfgMhndCHf8VGlUyINLIpC?=
 =?us-ascii?Q?4E51GoaS4c/o7aUVVL6OhhnEYyKNx+SJYfY1D5lQIOQKKQfPh7Ca4Cjz/ljF?=
 =?us-ascii?Q?m67nAwZXqxEeHZl91j0my8o0P1k1DTTYTPr/y+Zrzo3RnbUoF4dicH5TTegS?=
 =?us-ascii?Q?+yGBlpJv7PyR5OrIcaM/HsxzEV3j5BCGek/55E4yNzW4Qubhi6uIVDd0P/t7?=
 =?us-ascii?Q?mj+SyEA/x+4zpBW/NIRb042Qvx2VUiypCWywbeb8NwWUYsJLt0U0Gykr+cyr?=
 =?us-ascii?Q?5R+TNmXX7C6ITEvjGrTNAQTMPer52aZ4dMTMPIZnJuDJ4B0JHELF1yvk5qrA?=
 =?us-ascii?Q?bD7Pw1qVBTmPCa7YyongTgPHoKeev7pH/HSdbaBlJRzw8zHaSXzUZVOyuApJ?=
 =?us-ascii?Q?3UJ61mf6kiHCIIaymYgCdaF5?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c197b04-eea2-480e-953a-08d91e960aa9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 09:26:42.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE7kNrSIND2LUEkAK/e8daGnfIx3pGkUxnh9tTuwVJBHl2LtYGMWyvCvF/TmC13ugR0b4MqYopw2Heh9vVJhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KFENCE requires linear map to be mapped at page granularity, so that
it is possible to protect/unprotect single pages in the KFENCE pool.
Currently if KFENCE is enabled, arm64 maps all pages at page
granularity, it seems overkilled. In fact, we only need to map the
pages in KFENCE pool itself at page granularity. We acchieve this goal
by allocating KFENCE pool before paging_init() so we know the KFENCE
pool address, then we take care to map the pool at page granularity
during map_mem().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/kernel/setup.c |  3 +++
 arch/arm64/mm/mmu.c       | 27 +++++++++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 61845c0821d9..51c0d6e8b67b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -18,6 +18,7 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
+#include <linux/kfence.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -345,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	arm64_memblock_init();
 
+	kfence_alloc_pool();
+
 	paging_init();
 
 	acpi_table_upgrade();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 89b66ef43a0f..12712d31a054 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/kexec.h>
+#include <linux/kfence.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -515,10 +516,16 @@ static void __init map_mem(pgd_t *pgdp)
 	 */
 	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
 
-	if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
-	    IS_ENABLED(CONFIG_KFENCE))
+	if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
+	/*
+	 * KFENCE requires linear map to be mapped at page granularity, so
+	 * temporarily skip mapping for __kfence_pool in the following
+	 * for-loop
+	 */
+	memblock_mark_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
+
 	/*
 	 * Take care not to create a writable alias for the
 	 * read-only text and rodata sections of the kernel image.
@@ -553,6 +560,15 @@ static void __init map_mem(pgd_t *pgdp)
 	__map_memblock(pgdp, kernel_start, kernel_end,
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
+
+	/*
+	 * Map the __kfence_pool at page granularity now.
+	 */
+	__map_memblock(pgdp, __pa(__kfence_pool),
+		       __pa(__kfence_pool + KFENCE_POOL_SIZE),
+		       pgprot_tagged(PAGE_KERNEL),
+		       NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+	memblock_clear_nomap(__pa(__kfence_pool), KFENCE_POOL_SIZE);
 }
 
 void mark_rodata_ro(void)
@@ -1480,12 +1496,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-	/*
-	 * KFENCE requires linear map to be mapped at page granularity, so that
-	 * it is possible to protect/unprotect single pages in the KFENCE pool.
-	 */
-	if (rodata_full || debug_pagealloc_enabled() ||
-	    IS_ENABLED(CONFIG_KFENCE))
+	if (rodata_full || debug_pagealloc_enabled())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
-- 
2.31.0

