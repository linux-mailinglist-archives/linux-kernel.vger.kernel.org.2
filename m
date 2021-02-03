Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB030D6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhBCJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:50:58 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57687 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhBCJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612345847; x=1643881847;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ThLYGAl1tUYBTEhEe1rC59hQZhhTus7rqYTHtuAeaBc=;
  b=ZH1wVeMYxhj8co+buT3FINn8MAtQOJRRSzs4CWC4Si1gv37xH9fdlcBP
   TWbJEM3lvBDCvC48BtrLgxXpH/YoCTVg/ZdL2KRaemUYLzxLcVAOBFUqw
   NfIvfMO7UZC6ulTV+bfT81+E4swEIm9k4VUA/w+dkxeIpQcAlYmApXAnp
   095PTiGJDUM/9y0yocabPu+mrzTUVhs5MALLzyZg1orhHCQSc0x5DSfNS
   S/lW8bbzSN2N2nGXLgNWe20oiSRkCTjioag8udPIdfBnu/QiA/Z+YnEFF
   WV8tVF54Owt/E3o1engrpSQMXZKfe0plLmcCObSkCI8Qps97inqdbPeP+
   Q==;
IronPort-SDR: 6NsppIacHj1kzqmsmVB5ZTmCT3mEl9iys0Dxxi8Hj4Jhefid9nPJMBZmSnWRAVjRLKqJ4cTiLb
 gfwyTMTM9v4SILKau2bqcmhw++rczZfSaJnEp3EtnZqUIVc03ru4kplPEIII9a/Dhqy8dVCc1m
 8BUHBG+dThAHw+IR+7xfIMH3ZdiE6azQZxrVpd7+owYMMfUqjpjhdiqM2XlZTx0e6r6Y2wolO9
 fIuCaO5gKUqvGU/X109xR/bvFajd7q7hOCj3GalApUtkkMqKZqyfSTELKN+gcwsPWYy5zawSxZ
 r9I=
X-IronPort-AV: E=Sophos;i="5.79,398,1602518400"; 
   d="scan'208";a="159009259"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 17:49:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGTkSyNmKr8ZCmXFfdXOVMVGo3gZnix9dOS8DQu4PYxzILyOrjUMJ8KTWoysJaRYgsN032e9wnxxetqlKj2ONmJx7OSpCUM7WSUT5n37/1scUOzkPtEWoINaEXWBRVA+9hpgVT59h3uTo8FglTzTLVFsT7L7Y8NjOlQYbwHeMBLFQKlHNTF/f5OGuFElEkTbrLkM64F7nZze1OEyvqbDkSsKXE8T7CFCkYkP9IYfnwXaNEgPRy3sIDBZpRjoXwrRvN2N2K2iBhDKi3+S5pztJrsiOZL1lQeko+l3la+H4mSeYwHrXX4eGzjsz/q8zcniSqjYeoMSKe8b2xIJ+1UpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9aGiqRqfjnEIS9NaK4IH54O1jVPlnXVy754VPOfRQ=;
 b=kN414ItNhQTwCYi/3153IH2SDUIjD2WS1hCJSBCbq5nCKWDOWDCScUFMTnCtB4cQrhW6QekWAr7ZC/ckyYtq518uNw1Uz4LwA2vKtnMSpZCp60OQ5pESY7rKA1JVr+Nw1LbMvfL202t3P6nG/qNuopvcs7K/DTIitI8mykI6rbq+4+ltv6YAhotpafdJjnusb3alIifabMjnlFHxG/6hoaHpT3NBabRLdM/UKufmGoT1/Ouw5kB9nXBMjNYh6uBGxQcuBR50Oq2pGkNui8jzDuUQCfP9EFHc7ZsinKaZQ9aunG3lveCOWWDosSDtMWVxUrit3euv2Mu3mTviaaGB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9aGiqRqfjnEIS9NaK4IH54O1jVPlnXVy754VPOfRQ=;
 b=q0QroU26OS+jMT2/JKop2oIPdon34cOPR22LNZdz2zrBFxkpJ9zTpnFdF4Wj3rnnKaPeAw4tYJFTKr7jf3sFr0JVPm1CMYrvcmI+tR24JwNDCj4IvLjeTQRxGn1z3NyOkXPLk73yc1WEyp97aSwmKi6rF668qW4aMRpgtWoVUYc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6361.namprd04.prod.outlook.com (2603:10b6:5:1e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 09:49:33 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::2513:b200:bdc8:b97]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::2513:b200:bdc8:b97%5]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 09:49:33 +0000
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
Subject: [PATCH v5] RISC-V: Implement ASID allocator
Date:   Wed,  3 Feb 2021 15:19:07 +0530
Message-Id: <20210203094907.196608-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.53.20]
X-ClientProxiedBy: MAXPR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::30) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.53.20) by MAXPR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 09:49:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b902b479-c19b-4e33-ab7e-08d8c8290263
X-MS-TrafficTypeDiagnostic: DM6PR04MB6361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB63617976083432345CC0A7668DB49@DM6PR04MB6361.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooD6mZl89ESb2Drk6t704I7hYSob9gXlvbU1OQakEOnLJQXuXWIv8R17KW5B8fDDe06EYPII0bd9KXVi5LVku4MsX5HtA/3hJRrm6eg2OSzELR21AE26z3G3HugSgH25ka3Q7LDYKV4HoyFvBzLjl78KQr5H0G5wHtkleAM48xWjqzlNSjoGh7haK9GiYiKyNwy7QAwpcUF3fxPJ2cEY/a1r+8naPPb0VFOPOkFYU0bYOfle/u8A3N9r0H5FOcErQkJ7dHEAD0dNVN/awG4EgPa8K030cTIomHm2sWD/ec8xy5uTRyyydZPd0otylO84o2UtuGyaVFWuwp39KcgTt+/khmTA+DV1Jh+feFpFC+Ucg/ATYAuvqbyWL3l+gEuawe7SlJuImG2b5Pfx4Sll2DMVp1ZkQihHLybA0bc7nx/tAPSxMc7Ikh8E6eGTosF+eiJRIIhFiB1/tMsI2Ow+Ftd0ulFvqthTnUWyYrRljmQZkpuJxrdmvoA3+pMZ4ekZWSPstYa+5LEh0U2Csw+QA4q6Gf1dIHCBlliLKP9dYae4NHli41z2K7pG+3EkoI3OSTNOqeeBAE3kLKValxcgmqkZjbfEHnue+P5smR2lBcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(54906003)(66476007)(1076003)(8936002)(66556008)(7696005)(8676002)(110136005)(4326008)(956004)(8886007)(44832011)(52116002)(30864003)(6666004)(316002)(16526019)(36756003)(2906002)(5660300002)(186003)(478600001)(966005)(26005)(2616005)(66946007)(86362001)(83380400001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rOafxwu0LlNDaMImmlTY2guYIF95wmUIWwVHuFeAKnYmdHZWKGsPK+YmnRl4?=
 =?us-ascii?Q?dcpKKK4gO2ISr90HvzQQrp0XRH9c0x0UXibwP36tjKtFjgwI2oifbUw7lznp?=
 =?us-ascii?Q?wJ6APnjNuS+FssDX0AuIc1728k8LXYJIa2QZB2eAs5+BEUGqJnUayyxcqPCX?=
 =?us-ascii?Q?SKgSEAuaQZ/fFQKXGpq1CUd5Qo6v+retLbtG3sbqmh1kDbb2AxgulwC1UlO1?=
 =?us-ascii?Q?hIXqt1SCSCFMMjmogpTrNYe49fVIZQO7AfqWhaxLIPAM3lgfm6ht4J5h8+mR?=
 =?us-ascii?Q?zXOdardXdfJ5ODYGQSLkXBiEozvtxAefdt7IL3UhqejihZMbGQaY9k9e7h8v?=
 =?us-ascii?Q?r5caRm6RtLVqH55xbSxLuPoLn7/JxqZwpxMW3XvhjI7B0bYFV2KUEiagn9S0?=
 =?us-ascii?Q?yEh4ceSO16afFrY3cTGllJRd9gxfx/rfl8loBonL2K2TlwUP9Fq5L02YjM9y?=
 =?us-ascii?Q?IGCLZz2otKwDLXmzBRmqhJldzOXJlclpF3naZjKoCNff6Y/uYjwaNqObVOt6?=
 =?us-ascii?Q?K2nHG2htARlwVsfDj/OOks3V3KThHpYVKDMP8m8dujxo3EJZXYHFAcfcSErW?=
 =?us-ascii?Q?hpZIKyAc27EFNtxbotR/S4UfQFbyQxb17sOoPzsBFY4VABhjKWTdjYzX7ASh?=
 =?us-ascii?Q?Q7qAewmlyamzUfrZ23FHERrnxGAlW6lEX77K7/q0xZe1OMUj5DQAMbIQny9K?=
 =?us-ascii?Q?h767aFsdU0YPF1FVyq+jm2mODQ/4oSWHu4vAPYKH+mctcTC6u9HvL+NdeuhZ?=
 =?us-ascii?Q?KsEpwqXkusVkj/55hDAUG2lZNNiJxhSOxlphPVR8rn1NzCLaLxA+z1XOp8Dq?=
 =?us-ascii?Q?l8a46TuVjzn18tcq2994kBeqQ22zM25QFlbIPToHx4i4Y6BuROve/jUlYdmf?=
 =?us-ascii?Q?v8Pp2ZXAYTEZ2w1pIXzXiEvUzAA4JwmE7aySGhqUQQemuyjh0bGBYe08vLd6?=
 =?us-ascii?Q?AA1JEnwq91HC6t73rY4iYr7uyXx94hSB6u8X5jneEDj39vWqNNCyN5sdFiCb?=
 =?us-ascii?Q?/tzBE7MmdtLkcnQjYza7PaujtIcldi9nmTsk70i05AYseZueJxfU1KeSY4Pw?=
 =?us-ascii?Q?zqtzL0pT?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b902b479-c19b-4e33-ab7e-08d8c8290263
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 09:49:33.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAd2elmHAVG1RppTYBKYaweysOgtFaMnBhcaLwUarnLJMOooG5YiVdrLnWjcYK7aAoLs9Grf12lY9MxR8Mo3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6361
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we do local TLB flush on every MM switch. This is very harsh on
performance because we are forcing page table walks after every MM switch.

This patch implements ASID allocator for assigning an ASID to a MM context.
The number of ASIDs are limited in HW so we create a logical entity named
CONTEXTID for assigning to MM context. The lower bits of CONTEXTID are ASID
and upper bits are VERSION number. The number of usable ASID bits supported
by HW are detected at boot-time by writing 1s to ASID bits in SATP CSR.

We allocate new CONTEXTID on first MM switch for a MM context where the
ASID is allocated from an ASID bitmap and VERSION is provide by an atomic
counter. At time of allocating new CONTEXTID, if we run out of available
ASIDs then:
1. We flush the ASID bitmap
2. Increment current VERSION atomic counter
3. Re-allocate ASID from ASID bitmap
4. Flush TLB on all CPUs
5. Try CONTEXTID re-assignment on all CPUs

Please note that we don't use ASID #0 because it is used at boot-time by
all CPUs for initial MM context. Also, newly created context is always
assigned CONTEXTID #0 (i.e. VERSION #0 and ASID #0) which is an invalid
context in our implementation.

Using above approach, we have virtually infinite CONTEXTIDs on-top-of
limited number of HW ASIDs. This approach is inspired from ASID allocator
used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall, this
ASID allocator helps us reduce rate of local TLB flushes on every CPU
thereby increasing performance.

This patch is tested on QEMU virt machine, Spike and SiFive Unleashed
board. On QEMU virt machine, we see some (3-5% approx) performance
improvement with SW emulated TLBs provided by QEMU. Unfortunately,
the ASID bits of the SATP CSR are not implemented on Spike and SiFive
Unleashed board so we don't see any change in performance. On real HW
having all ASID bits implemented, the performance gains will be much
more due improved sharing of TLB among different processes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
Changes since v4:
- Rebased on Linux-5.11-rc6
- Used lockdep_assert_held() in __new_context() and __flush_context()

Changes since v3:
- Rebased on Linux-5.11-rc4. The previous v3 patch (almost 2 years back)
  was based on Linux-5.1-rc2
- Updated implementation to consider NoMMU kernel
- Converted use_asid_allocator boolean flag into static key
- Improved boot-time print in asids_init() to show number of ASID bits
- Access SATP CSR by number instead of old CSR name "sptbr"

Changes since v2:
- Move to lazy TLB flushing because we get slow path warnings if we
  use flush_tlb_all()
- Don't set ASID bits to all 1s in head.s. Instead just do it on
  boot CPU calling asids_init() for determining number of HW ASID bits
- Make CONTEXT version comparison more readable in set_mm_asid()
- Fix typo in __flush_context()

Changes since v1:
- We adapt good aspects from Gary Guo's ASID allocator implementation
  and provide due credit to him by adding his SoB.
- Track ASIDs active during context flush and mark them as reserved
- Set ASID bits to all 1s to simplify number of ASID bit detection
- Use atomic_long_t instead of atomic64_t for being 32bit friendly
- Use unsigned long instead of u64 for being 32bit friendly
- Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
  of context flush

This patch is based on Linux-5.11-rc6 and can be found in the
riscv_asid_allocator_v5 branch of https://github.com/avpatel/linux.git
---
 arch/riscv/include/asm/csr.h         |   6 +
 arch/riscv/include/asm/mmu.h         |   2 +
 arch/riscv/include/asm/mmu_context.h |  10 +
 arch/riscv/mm/context.c              | 265 ++++++++++++++++++++++++++-
 4 files changed, 279 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index cec462e198ce..caadfc1d7487 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -41,10 +41,16 @@
 #define SATP_PPN	_AC(0x003FFFFF, UL)
 #define SATP_MODE_32	_AC(0x80000000, UL)
 #define SATP_MODE	SATP_MODE_32
+#define SATP_ASID_BITS	9
+#define SATP_ASID_SHIFT	22
+#define SATP_ASID_MASK	_AC(0x1FF, UL)
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UL)
 #define SATP_MODE	SATP_MODE_39
+#define SATP_ASID_BITS	16
+#define SATP_ASID_SHIFT	44
+#define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
 
 /* Exception cause high bit - is an interrupt if set */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index dabcf2cfb3dc..0099dc116168 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -12,6 +12,8 @@
 typedef struct {
 #ifndef CONFIG_MMU
 	unsigned long	end_brk;
+#else
+	atomic_long_t id;
 #endif
 	void *vdso;
 #ifdef CONFIG_SMP
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 250defa06f3a..b0659413a080 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -23,6 +23,16 @@ static inline void activate_mm(struct mm_struct *prev,
 	switch_mm(prev, next, NULL);
 }
 
+#define init_new_context init_new_context
+static inline int init_new_context(struct task_struct *tsk,
+			struct mm_struct *mm)
+{
+#ifdef CONFIG_MMU
+	atomic_long_set(&mm->context.id, 0);
+#endif
+	return 0;
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 613ec81a8979..68aa312fc352 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -2,13 +2,273 @@
 /*
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
  */
 
+#include <linux/bitops.h>
+#include <linux/cpumask.h>
 #include <linux/mm.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/static_key.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 
+#ifdef CONFIG_MMU
+
+static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
+
+static unsigned long asid_bits;
+static unsigned long num_asids;
+static unsigned long asid_mask;
+
+static atomic_long_t current_version;
+
+static DEFINE_RAW_SPINLOCK(context_lock);
+static cpumask_t context_tlb_flush_pending;
+static unsigned long *context_asid_map;
+
+static DEFINE_PER_CPU(atomic_long_t, active_context);
+static DEFINE_PER_CPU(unsigned long, reserved_context);
+
+static bool check_update_reserved_context(unsigned long cntx,
+					  unsigned long newcntx)
+{
+	int cpu;
+	bool hit = false;
+
+	/*
+	 * Iterate over the set of reserved CONTEXT looking for a match.
+	 * If we find one, then we can update our mm to use new CONTEXT
+	 * (i.e. the same CONTEXT in the current_version) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old CONTEXT are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved CONTEXT in a future
+	 * version.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_context, cpu) == cntx) {
+			hit = true;
+			per_cpu(reserved_context, cpu) = newcntx;
+		}
+	}
+
+	return hit;
+}
+
+static void __flush_context(void)
+{
+	int i;
+	unsigned long cntx;
+
+	/* Must be called with context_lock held */
+	lockdep_assert_held(&context_lock);
+
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(context_asid_map, 0, num_asids);
+
+	/* Mark already active ASIDs as used */
+	for_each_possible_cpu(i) {
+		cntx = atomic_long_xchg_relaxed(&per_cpu(active_context, i), 0);
+		/*
+		 * If this CPU has already been through a rollover, but
+		 * hasn't run another task in the meantime, we must preserve
+		 * its reserved CONTEXT, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (cntx == 0)
+			cntx = per_cpu(reserved_context, i);
+
+		__set_bit(cntx & asid_mask, context_asid_map);
+		per_cpu(reserved_context, i) = cntx;
+	}
+
+	/* Mark ASID #0 as used because it is used at boot-time */
+	__set_bit(0, context_asid_map);
+
+	/* Queue a TLB invalidation for each CPU on next context-switch */
+	cpumask_setall(&context_tlb_flush_pending);
+}
+
+static unsigned long __new_context(struct mm_struct *mm)
+{
+	static u32 cur_idx = 1;
+	unsigned long cntx = atomic_long_read(&mm->context.id);
+	unsigned long asid, ver = atomic_long_read(&current_version);
+
+	/* Must be called with context_lock held */
+	lockdep_assert_held(&context_lock);
+
+	if (cntx != 0) {
+		unsigned long newcntx = ver | (cntx & asid_mask);
+
+		/*
+		 * If our current CONTEXT was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
+		 */
+		if (check_update_reserved_context(cntx, newcntx))
+			return newcntx;
+
+		/*
+		 * We had a valid CONTEXT in a previous life, so try to
+		 * re-use it if possible.
+		 */
+		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
+			return newcntx;
+	}
+
+	/*
+	 * Allocate a free ASID. If we can't find one then increment
+	 * current_version and flush all ASIDs.
+	 */
+	asid = find_next_zero_bit(context_asid_map, num_asids, cur_idx);
+	if (asid != num_asids)
+		goto set_asid;
+
+	/* We're out of ASIDs, so increment current_version */
+	ver = atomic_long_add_return_relaxed(num_asids, &current_version);
+
+	/* Flush everything  */
+	__flush_context();
+
+	/* We have more ASIDs than CPUs, so this will always succeed */
+	asid = find_next_zero_bit(context_asid_map, num_asids, 1);
+
+set_asid:
+	__set_bit(asid, context_asid_map);
+	cur_idx = asid;
+	return asid | ver;
+}
+
+static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
+{
+	unsigned long flags;
+	bool need_flush_tlb = false;
+	unsigned long cntx, old_active_cntx;
+
+	cntx = atomic_long_read(&mm->context.id);
+
+	/*
+	 * If our active_context is non-zero and the context matches the
+	 * current_version, then we update the active_context entry with a
+	 * relaxed cmpxchg.
+	 *
+	 * Following is how we handle racing with a concurrent rollover:
+	 *
+	 * - We get a zero back from the cmpxchg and end up waiting on the
+	 *   lock. Taking the lock synchronises with the rollover and so
+	 *   we are forced to see the updated verion.
+	 *
+	 * - We get a valid context back from the cmpxchg then we continue
+	 *   using old ASID because __flush_context() would have marked ASID
+	 *   of active_context as used and next context switch we will
+	 *   allocate new context.
+	 */
+	old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
+	if (old_active_cntx &&
+	    ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
+	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
+					old_active_cntx, cntx))
+		goto switch_mm_fast;
+
+	raw_spin_lock_irqsave(&context_lock, flags);
+
+	/* Check that our ASID belongs to the current_version. */
+	cntx = atomic_long_read(&mm->context.id);
+	if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
+		cntx = __new_context(mm);
+		atomic_long_set(&mm->context.id, cntx);
+	}
+
+	if (cpumask_test_and_clear_cpu(cpu, &context_tlb_flush_pending))
+		need_flush_tlb = true;
+
+	atomic_long_set(&per_cpu(active_context, cpu), cntx);
+
+	raw_spin_unlock_irqrestore(&context_lock, flags);
+
+switch_mm_fast:
+	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
+		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
+		  SATP_MODE);
+
+	if (need_flush_tlb)
+		local_flush_tlb_all();
+}
+
+static void set_mm_noasid(struct mm_struct *mm)
+{
+	/* Switch the page table and blindly nuke entire local TLB */
+	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | SATP_MODE);
+	local_flush_tlb_all();
+}
+
+static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
+{
+	if (static_branch_unlikely(&use_asid_allocator))
+		set_mm_asid(mm, cpu);
+	else
+		set_mm_noasid(mm);
+}
+
+static int asids_init(void)
+{
+	unsigned long old;
+
+	/* Figure-out number of ASID bits in HW */
+	old = csr_read(CSR_SATP);
+	asid_bits = old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
+	csr_write(CSR_SATP, asid_bits);
+	asid_bits = (csr_read(CSR_SATP) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK;
+	asid_bits = fls_long(asid_bits);
+	csr_write(CSR_SATP, old);
+
+	/*
+	 * In the process of determining number of ASID bits (above)
+	 * we polluted the TLB of current HART so let's do TLB flushed
+	 * to remove unwanted TLB enteries.
+	 */
+	local_flush_tlb_all();
+
+	/* Pre-compute ASID details */
+	num_asids = 1 << asid_bits;
+	asid_mask = num_asids - 1;
+
+	/*
+	 * Use ASID allocator only if number of HW ASIDs are
+	 * at-least twice more than CPUs
+	 */
+	if (num_asids > (2 * num_possible_cpus())) {
+		atomic_long_set(&current_version, num_asids);
+
+		context_asid_map = kcalloc(BITS_TO_LONGS(num_asids),
+				   sizeof(*context_asid_map), GFP_KERNEL);
+		if (!context_asid_map)
+			panic("Failed to allocate bitmap for %lu ASIDs\n",
+			      num_asids);
+
+		__set_bit(0, context_asid_map);
+
+		static_branch_enable(&use_asid_allocator);
+
+		pr_info("ASID allocator using %lu bits (%lu entries)\n",
+			asid_bits, num_asids);
+	} else {
+		pr_info("ASID allocator disabled\n");
+	}
+
+	return 0;
+}
+early_initcall(asids_init);
+#else
+static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
+{
+	/* Nothing to do here when there is no MMU */
+}
+#endif
+
 /*
  * When necessary, performs a deferred icache flush for the given MM context,
  * on the local CPU.  RISC-V has no direct mechanism for instruction cache
@@ -58,10 +318,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
-#ifdef CONFIG_MMU
-	csr_write(CSR_SATP, virt_to_pfn(next->pgd) | SATP_MODE);
-	local_flush_tlb_all();
-#endif
+	set_mm(next, cpu);
 
 	flush_icache_deferred(next);
 }
-- 
2.25.1

