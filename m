Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CD31D2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBPW7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:59:05 -0500
Received: from mail-eopbgr110118.outbound.protection.outlook.com ([40.107.11.118]:20363
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231128AbhBPW66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:58:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe0oxRCHEpjrEJKWM8o2+0qMh9D02FlE6hjhdoOGAndGZvjrnydD4fgV+H1OFHQp9rs/SF5PeYU4u8C4SAjhUhlJ+9ChaVpqjjEjV7Zpf6LjTReb37O0OtPm2Sy6H7uUlOWT4lA5XReneXEAMB7SlQzc7Ha2qhjM6J0rG0qZlTOFZunGf3HZCPS6gziO/tvVXs+77fR9V6bnNacaNGKNicsCS7jTbMbiWn1Bj1rlooqgvOROSPbIw2YMaaDsMDO1o/1yaC0B9wNpISDiQxxSCd0w57027qGPKbq2yNlMOx3XwnbIiyW9lPuP/70fFbXT0XJi1C7BqPhvDvJhzsXlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBPG+rfDH2+bra0HO4paeXFU8COh77nb1U0EI4ENLXE=;
 b=jAKISGBdcpor+8dfITVFGlrfeZofo/oFVIvfp9milQVr0lxvvjhY7PuFe/W/Eqbrq1dCmVnYYPA5QyMrULhy91DwcbG2y2YIZYHjglI2vtnA7UjcGqbmo3VMSwLNRrmewzPQxhGYjJ1xKQFSmsnhRHyUVC8XJO9bLYBPLr2wXShVVauc16Bdwda88AK4AxqHDZI4VGoMZW5etsswwoJ8GM8Nax5Gdo/IXuqw3pUs9DK1bxCfQumnuY/jzwYiRxOxDkbH4ZJPf8JMXIDAO9PejqoklqUp/YZONAIEfZDTz7H9pVhfeRTuQwTmHfhDqqGO52NHzakkQwJ97w9kp5N2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBPG+rfDH2+bra0HO4paeXFU8COh77nb1U0EI4ENLXE=;
 b=pqmgfq0X1vb0M/Y0xLlzZUEEi4WkWNxp5Mw3ToFQXtwr3OVFi0mMe6KAV9G7/A/thP5vFbnEa6ZQHfuxdDy5dwh8hFN4dfAIpGJvZumzUcpPXWZB/xLqNdtqOPr7IEFl/0ZsTSTrtvFzATwxbnMlYenrRO+Tj2kjlxCP5nu94H0=
Authentication-Results: garyguo.net; dkim=none (message not signed)
 header.d=none;garyguo.net; dmarc=none action=none header.from=garyguo.net;
Received: from CWXP265MB0744.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:d::23) by
 CWXP265MB0584.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19; Tue, 16 Feb 2021 22:58:07 +0000
Received: from CWXP265MB0744.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d4fe:4dc4:65f1:b066]) by CWXP265MB0744.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d4fe:4dc4:65f1:b066%7]) with mapi id 15.20.3825.039; Tue, 16 Feb 2021
 22:58:07 +0000
From:   Gary Guo <gary@garyguo.net>
Cc:     Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Nylon Chen <nylon7@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Date:   Tue, 16 Feb 2021 22:55:51 +0000
Message-Id: <20210216225555.4976-1-gary@garyguo.net>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2.99.171.246]
X-ClientProxiedBy: LNXP265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::13) To CWXP265MB0744.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Gary-PC.localdomain (2.99.171.246) by LNXP265CA0073.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.35 via Frontend Transport; Tue, 16 Feb 2021 22:58:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193f93c2-35a5-42f2-8bd8-08d8d2ce5348
X-MS-TrafficTypeDiagnostic: CWXP265MB0584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP265MB0584F371FFED5D7C527EE225D6879@CWXP265MB0584.GBRP265.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VySP2Jv1hAvfIoHtJsWgmsFFFnyW7Go9ZeYfv8Eu9K9kWSv2LhVDIhEXwLXXl1hkJr64/mN/FRkQHLNy2+/XZkgY+nlrgGA9BSbnURj0B0ATRTF1sKF8FMlg+JY5TrSmy+vvTFyiDGnDxkXPKYA6wnVQtaYxT52Rbs4FAimzrE67o/5hBuTBT8y3J2cNy2L+it4FljdkWP2gi4JiBb1Ucilp6AN3/DU8Lftwl0zUqWk9EOK/2jEnnhh2KnMd1p0A/e+CH4Dl4Nv0EuBMHE4W9IxnDBC2GabvYJEztS1jzGGPuxjtwRmWM26x7AxVAEs2lD/qX77PfCq7X7oWyFYyw/rxTfVIZZRvPPLUgZ9mvQmtD8jEZCE2HoUXUq1sN3aDU8U+3IbNzx8s/TRn9mpg+lqjCfDOgKF/ilt0VBT6nA2+5/zhtTV2VegrHHuVtsVrhps1aImKy3ZwxCUB8e803wzYk61Wexe2g0YLAQ/lg+5Mlq00vf57scvy/2w9jF0D1V2lUAp4JMWxGMa67jPLOV7YkjwCSgJfEWvdAgjK5thGBxOv//TKrk2Ych+r6qA1ZPMpJ6b/42Byg46lGWMkfgtfM09tm5hNDdG4mnEKueI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB0744.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(2906002)(66946007)(86362001)(6666004)(30864003)(6486002)(66556008)(52116002)(55236004)(508600001)(109986005)(186003)(26005)(6506007)(4326008)(66476007)(6512007)(8936002)(2616005)(1076003)(54906003)(5660300002)(36756003)(8676002)(956004)(83380400001)(16526019)(266003)(16060500005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZBjdxp6y0WH7TnvGgMwpysb4r/NpSl9AoiNXo6sChOfDJqc5y/bvLqKEVnHs?=
 =?us-ascii?Q?5lvqDML471oYbXffTjsVQd1B/cfCNuXK2WEiT5RrZHwcECs/RjczlWYHSYIN?=
 =?us-ascii?Q?aWqifLZwQb0Bl92Z9BA+MVnqEKH/U52CG4iS65TRgAhy7WT/mLSiyoDgjeVS?=
 =?us-ascii?Q?iAqMRaiV3BuKV0WZz9gKeOO12/DYNVNJPGDqE+53FHku5I8TKX5kPhmtDPe/?=
 =?us-ascii?Q?jVjwXnkzZygoIkMQbVlJtcbqAulJ36SrBOkw91zFmeBuuioHkG195IBl2LbY?=
 =?us-ascii?Q?thFEuLlX8r7sA2eMBxIPVjfBcTsn9QPcURFkU51+vFdJ2ioT0nQnhlBOeuMx?=
 =?us-ascii?Q?mIdrXAAbqMdVPV9GQtO/lwS+lmBV+OEj5PHIZHJgn6SEEmbSKdb0kSf46uAC?=
 =?us-ascii?Q?F5qL4bE4W58j3h0fieoeyY20yro3EKG26+DIXOX5vVkJxhfasymFjbovHd0U?=
 =?us-ascii?Q?tGuyNus46iQ0OG4NYhBhmfzzsnfaH9lyZ69xgpiCrDx8+Okrfwx83PVM6vJZ?=
 =?us-ascii?Q?tUIqL062p8gXKrXF/h8wfQnC8Vfdw19+rA+vxEwiVs4cu6Puw4XumJi848fR?=
 =?us-ascii?Q?cbIQOxmThLDTp6XkI+lhKyWnRPbhc/hvCvI7Pjf4LZgaxetd8nwPnITWDPCs?=
 =?us-ascii?Q?tB8OKJnHCMNwolqByu1s7X9FKuUHKxTib8OWVT7uTzfB9/VTYpfRUl9+WwGx?=
 =?us-ascii?Q?xkKEoJRPu5Dyy38hkwmbEfsXzmZRB29P/U5M0j7xH7wRqNb0hklUX0zJLDfw?=
 =?us-ascii?Q?PraZzMgDKkHLkac4Xfm5J6wSqYuO/QRR1q5/3MM049+3lrLUrO+j1uHsIzi/?=
 =?us-ascii?Q?DYOPn6Pv/pKgw1yhU+cDRNRxLg6ARlJbJaw5xMhZvwk4biR9x5Nd43mjf1DD?=
 =?us-ascii?Q?qHbwEC49GzptVOi1ut37tjYIV2uiaqV00uajAAaWa/WFkuOw5w1PFKJM7Cz7?=
 =?us-ascii?Q?xmLazhNYBu3kJ1BgM3gCMWyfs9EeUVCTCBNdFQhID9444U4vW/yONzvNb0jf?=
 =?us-ascii?Q?7UK6Nm8awEIkEvHS7+otDi30Rp0dV5K49mH6owOxtF2CDbbeGBzbP0LudpLj?=
 =?us-ascii?Q?8UKG7Tv4/64uxSoW+Sqw+RT/rRRN7iClmN6u0ZiWUmiu5W36vvYnXgPwKJw2?=
 =?us-ascii?Q?sGbmY/wlOIdSGM6zcGUrL4XAJU0eLAO3xCiI2VtNliuGc4Wi1gvnmXKZTJTp?=
 =?us-ascii?Q?v+sndrcEWY37PB5szQxJ2/gafONvD/bWIjABl63LG5R51wPJlb4GIn65oPNd?=
 =?us-ascii?Q?TAN5VHOv8oQg24FghuDr3inBlbegfCCpEo2sp480EJMp2QTpzwg0YXMSzFmZ?=
 =?us-ascii?Q?W/7Ix22Une/KFXMshjXCcTM6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 193f93c2-35a5-42f2-8bd8-08d8d2ce5348
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB0744.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 22:58:07.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrINwuNBEersxBTwtWN5Kkf4tgLjyAuOXYavJ5/4p7FtKzda99N99uYwpwzdGUdewzovg4uz4f7zIncm7d9J/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB0584
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04091d6 introduces an assembly version of memmove but
it does take misalignment into account (it checks if
length is a multiple of machine word size but pointers
need also be aligned). As a result it will generate
misaligned load/store for the majority of cases and causes
significant performance regression on hardware that traps
misaligned load/store and emulate them using firmware.

The current behaviour of memcpy is that it checks if both
src and dest pointers are co-aligned (aka congruent
modular SZ_REG). If aligned, it will copy data word-by-word
after first aligning pointers to word boundary. If src
and dst are not co-aligned, however, byte-wise copy will
be performed.

This patch fixes the memmove and optimises memcpy for
misaligned cases. It will first align destination pointer
to word-boundary regardless whether src and dest are
co-aligned or not. If they indeed are, then wordwise copy
is performed. If they are not co-aligned, then it will
load two adjacent words from src and use shifts to assemble
a full machine word. Some additional assembly level
micro-optimisation is also performed to ensure more
instructions can be compressed (e.g. prefer a0 to t6).

In my testing this speeds up memcpy 4~5x when src and dest
are not co-aligned (which is quite common in networking),
and speeds up memmove 1000+x by avoiding trapping to firmware.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 arch/riscv/lib/memcpy.S  | 223 ++++++++++++++++++++++++---------------
 arch/riscv/lib/memmove.S | 176 ++++++++++++++++++++----------
 2 files changed, 257 insertions(+), 142 deletions(-)

diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
index 51ab716253fa..00672c19ad9b 100644
--- a/arch/riscv/lib/memcpy.S
+++ b/arch/riscv/lib/memcpy.S
@@ -9,100 +9,151 @@
 /* void *memcpy(void *, const void *, size_t) */
 ENTRY(__memcpy)
 WEAK(memcpy)
-	move t6, a0  /* Preserve return value */
+	/* Save for return value */
+	mv	t6, a0
 
-	/* Defer to byte-oriented copy for small sizes */
-	sltiu a3, a2, 128
-	bnez a3, 4f
-	/* Use word-oriented copy only if low-order bits match */
-	andi a3, t6, SZREG-1
-	andi a4, a1, SZREG-1
-	bne a3, a4, 4f
+	/*
+	 * Register allocation for code below:
+	 * a0 - start of uncopied dst
+	 * a1 - start of uncopied src
+	 * t0 - end of uncopied dst
+	 */
+	add	t0, a0, a2
 
-	beqz a3, 2f  /* Skip if already aligned */
 	/*
-	 * Round to nearest double word-aligned address
-	 * greater than or equal to start address
+	 * Use bytewise copy if too small.
+	 *
+	 * This threshold must be at least 2*SZREG to ensure at least one
+	 * wordwise copy is performed. It is chosen to be 16 because it will
+	 * save at least 7 iterations of bytewise copy, which pays off the
+	 * fixed overhead.
 	 */
-	andi a3, a1, ~(SZREG-1)
-	addi a3, a3, SZREG
-	/* Handle initial misalignment */
-	sub a4, a3, a1
+	li	a3, 16
+	bltu	a2, a3, .Lbyte_copy_tail
+
+	/*
+	 * Bytewise copy first to align a0 to word boundary.
+	 */
+	addi	a2, a0, SZREG-1
+	andi	a2, a2, ~(SZREG-1)
+	beq	a0, a2, 2f
 1:
-	lb a5, 0(a1)
-	addi a1, a1, 1
-	sb a5, 0(t6)
-	addi t6, t6, 1
-	bltu a1, a3, 1b
-	sub a2, a2, a4  /* Update count */
+	lb	a5, 0(a1)
+	addi	a1, a1, 1
+	sb	a5, 0(a0)
+	addi	a0, a0, 1
+	bne	a0, a2, 1b
+2:
+
+	/*
+	 * Now a0 is word-aligned. If a1 is also word aligned, we could perform
+	 * aligned word-wise copy. Otherwise we need to perform misaligned
+	 * word-wise copy.
+	 */
+	andi	a3, a1, SZREG-1
+	bnez	a3, .Lmisaligned_word_copy
 
+	/* Unrolled wordwise copy */
+	addi	t0, t0, -(16*SZREG-1)
+	bgeu	a0, t0, 2f
+1:
+	REG_L	a2,        0(a1)
+	REG_L	a3,    SZREG(a1)
+	REG_L	a4,  2*SZREG(a1)
+	REG_L	a5,  3*SZREG(a1)
+	REG_L	a6,  4*SZREG(a1)
+	REG_L	a7,  5*SZREG(a1)
+	REG_L	t1,  6*SZREG(a1)
+	REG_L	t2,  7*SZREG(a1)
+	REG_L	t3,  8*SZREG(a1)
+	REG_L	t4,  9*SZREG(a1)
+	REG_L	t5, 10*SZREG(a1)
+	REG_S	a2,        0(a0)
+	REG_S	a3,    SZREG(a0)
+	REG_S	a4,  2*SZREG(a0)
+	REG_S	a5,  3*SZREG(a0)
+	REG_S	a6,  4*SZREG(a0)
+	REG_S	a7,  5*SZREG(a0)
+	REG_S	t1,  6*SZREG(a0)
+	REG_S	t2,  7*SZREG(a0)
+	REG_S	t3,  8*SZREG(a0)
+	REG_S	t4,  9*SZREG(a0)
+	REG_S	t5, 10*SZREG(a0)
+	REG_L	a2, 11*SZREG(a1)
+	REG_L	a3, 12*SZREG(a1)
+	REG_L	a4, 13*SZREG(a1)
+	REG_L	a5, 14*SZREG(a1)
+	REG_L	a6, 15*SZREG(a1)
+	addi	a1, a1, 16*SZREG
+	REG_S	a2, 11*SZREG(a0)
+	REG_S	a3, 12*SZREG(a0)
+	REG_S	a4, 13*SZREG(a0)
+	REG_S	a5, 14*SZREG(a0)
+	REG_S	a6, 15*SZREG(a0)
+	addi	a0, a0, 16*SZREG
+	bltu	a0, t0, 1b
 2:
-	andi a4, a2, ~((16*SZREG)-1)
-	beqz a4, 4f
-	add a3, a1, a4
-3:
-	REG_L a4,       0(a1)
-	REG_L a5,   SZREG(a1)
-	REG_L a6, 2*SZREG(a1)
-	REG_L a7, 3*SZREG(a1)
-	REG_L t0, 4*SZREG(a1)
-	REG_L t1, 5*SZREG(a1)
-	REG_L t2, 6*SZREG(a1)
-	REG_L t3, 7*SZREG(a1)
-	REG_L t4, 8*SZREG(a1)
-	REG_L t5, 9*SZREG(a1)
-	REG_S a4,       0(t6)
-	REG_S a5,   SZREG(t6)
-	REG_S a6, 2*SZREG(t6)
-	REG_S a7, 3*SZREG(t6)
-	REG_S t0, 4*SZREG(t6)
-	REG_S t1, 5*SZREG(t6)
-	REG_S t2, 6*SZREG(t6)
-	REG_S t3, 7*SZREG(t6)
-	REG_S t4, 8*SZREG(t6)
-	REG_S t5, 9*SZREG(t6)
-	REG_L a4, 10*SZREG(a1)
-	REG_L a5, 11*SZREG(a1)
-	REG_L a6, 12*SZREG(a1)
-	REG_L a7, 13*SZREG(a1)
-	REG_L t0, 14*SZREG(a1)
-	REG_L t1, 15*SZREG(a1)
-	addi a1, a1, 16*SZREG
-	REG_S a4, 10*SZREG(t6)
-	REG_S a5, 11*SZREG(t6)
-	REG_S a6, 12*SZREG(t6)
-	REG_S a7, 13*SZREG(t6)
-	REG_S t0, 14*SZREG(t6)
-	REG_S t1, 15*SZREG(t6)
-	addi t6, t6, 16*SZREG
-	bltu a1, a3, 3b
-	andi a2, a2, (16*SZREG)-1  /* Update count */
-
-4:
-	/* Handle trailing misalignment */
-	beqz a2, 6f
-	add a3, a1, a2
-
-	/* Use word-oriented copy if co-aligned to word boundary */
-	or a5, a1, t6
-	or a5, a5, a3
-	andi a5, a5, 3
-	bnez a5, 5f
-7:
-	lw a4, 0(a1)
-	addi a1, a1, 4
-	sw a4, 0(t6)
-	addi t6, t6, 4
-	bltu a1, a3, 7b
+	/* Post-loop increment by 16*SZREG-1 and pre-loop decrement by SZREG-1 */
+	addi	t0, t0, 15*SZREG
 
-	ret
+	/* Wordwise copy */
+	bgeu	a0, t0, 2f
+1:
+	REG_L	a5, 0(a1)
+	addi	a1, a1, SZREG
+	REG_S	a5, 0(a0)
+	addi	a0, a0, SZREG
+	bltu	a0, t0, 1b
+2:
+	addi	t0, t0, SZREG-1
 
-5:
-	lb a4, 0(a1)
-	addi a1, a1, 1
-	sb a4, 0(t6)
-	addi t6, t6, 1
-	bltu a1, a3, 5b
-6:
+.Lbyte_copy_tail:
+	/*
+	 * Bytewise copy anything left.
+	 */
+	beq	a0, t0, 2f
+1:
+	lb	a5, 0(a1)
+	addi	a1, a1, 1
+	sb	a5, 0(a0)
+	addi	a0, a0, 1
+	bne	a0, t0, 1b
+2:
+
+	mv	a0, t6
 	ret
+
+.Lmisaligned_word_copy:
+	/*
+	 * Misaligned word-wise copy.
+	 * For misaligned copy we still perform word-wise copy, but we need to
+	 * use the value fetched from the previous iteration and do some shifts.
+	 * This is safe because we wouldn't access more words than necessary.
+	 */
+
+	/* Calculate shifts */
+	slli	t3, a3, 3
+	sub	t4, x0, t3 /* negate is okay as shift will only look at LSBs */
+
+	/* Load the initial value and align a1 */
+	andi	a1, a1, ~(SZREG-1)
+	REG_L	a5, 0(a1)
+
+	addi	t0, t0, -(SZREG-1)
+	/* At least one iteration will be executed here, no check */
+1:
+	srl	a4, a5, t3
+	REG_L	a5, SZREG(a1)
+	addi	a1, a1, SZREG
+	sll	a2, a5, t4
+	or	a2, a2, a4
+	REG_S	a2, 0(a0)
+	addi	a0, a0, SZREG
+	bltu	a0, t0, 1b
+
+	/* Update pointers to correct value */
+	addi	t0, t0, SZREG-1
+	add	a1, a1, a3
+
+	j	.Lbyte_copy_tail
 END(__memcpy)
diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index 07d1d2152ba5..fbe6701dbe4a 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -5,60 +5,124 @@
 
 ENTRY(__memmove)
 WEAK(memmove)
-        move    t0, a0
-        move    t1, a1
-
-        beq     a0, a1, exit_memcpy
-        beqz    a2, exit_memcpy
-        srli    t2, a2, 0x2
-
-        slt     t3, a0, a1
-        beqz    t3, do_reverse
-
-        andi    a2, a2, 0x3
-        li      t4, 1
-        beqz    t2, byte_copy
-
-word_copy:
-        lw      t3, 0(a1)
-        addi    t2, t2, -1
-        addi    a1, a1, 4
-        sw      t3, 0(a0)
-        addi    a0, a0, 4
-        bnez    t2, word_copy
-        beqz    a2, exit_memcpy
-        j       byte_copy
-
-do_reverse:
-        add     a0, a0, a2
-        add     a1, a1, a2
-        andi    a2, a2, 0x3
-        li      t4, -1
-        beqz    t2, reverse_byte_copy
-
-reverse_word_copy:
-        addi    a1, a1, -4
-        addi    t2, t2, -1
-        lw      t3, 0(a1)
-        addi    a0, a0, -4
-        sw      t3, 0(a0)
-        bnez    t2, reverse_word_copy
-        beqz    a2, exit_memcpy
-
-reverse_byte_copy:
-        addi    a0, a0, -1
-        addi    a1, a1, -1
-
-byte_copy:
-        lb      t3, 0(a1)
-        addi    a2, a2, -1
-        sb      t3, 0(a0)
-        add     a1, a1, t4
-        add     a0, a0, t4
-        bnez    a2, byte_copy
-
-exit_memcpy:
-        move a0, t0
-        move a1, t1
-        ret
+	/*
+	 * Here we determine if forward copy is possible. Forward copy is
+	 * preferred to backward copy as it is more cache friendly.
+	 *
+	 * If a0 >= a1, t0 gives their distance, if t0 >= a2 then we can
+	 *   copy forward.
+	 * If a0 < a1, we can always copy forward. This will make t0 negative,
+	 *   so a *unsigned* comparison will always have t0 >= a2.
+	 *
+	 * For forward copy we just delegate the task to memcpy.
+	 */
+	sub	t0, a0, a1
+	bltu	t0, a2, 1f
+	tail	__memcpy
+1:
+
+	/*
+	 * Register allocation for code below:
+	 * a0 - end of uncopied dst
+	 * a1 - end of uncopied src
+	 * t0 - start of uncopied dst
+	 */
+	mv	t0, a0
+	add	a0, a0, a2
+	add	a1, a1, a2
+
+	/*
+	 * Use bytewise copy if too small.
+	 *
+	 * This threshold must be at least 2*SZREG to ensure at least one
+	 * wordwise copy is performed. It is chosen to be 16 because it will
+	 * save at least 7 iterations of bytewise copy, which pays off the
+	 * fixed overhead.
+	 */
+	li	a3, 16
+	bltu	a2, a3, .Lbyte_copy_tail
+
+	/*
+	 * Bytewise copy first to align t0 to word boundary.
+	 */
+	andi	a2, a0, ~(SZREG-1)
+	beq	a0, a2, 2f
+1:
+	addi	a1, a1, -1
+	lb	a5, 0(a1)
+	addi	a0, a0, -1
+	sb	a5, 0(a0)
+	bne	a0, a2, 1b
+2:
+
+	/*
+	 * Now a0 is word-aligned. If a1 is also word aligned, we could perform
+	 * aligned word-wise copy. Otherwise we need to perform misaligned
+	 * word-wise copy.
+	 */
+	andi	a3, a1, SZREG-1
+	bnez	a3, .Lmisaligned_word_copy
+
+	/* Wordwise copy */
+	addi	t0, t0, SZREG-1
+	bleu	a0, t0, 2f
+1:
+	addi	a1, a1, -SZREG
+	REG_L	a5, 0(a1)
+	addi	a0, a0, -SZREG
+	REG_S	a5, 0(a0)
+	bgtu	a0, t0, 1b
+2:
+	addi	t0, t0, -(SZREG-1)
+
+.Lbyte_copy_tail:
+	/*
+	 * Bytewise copy anything left.
+	 */
+	beq	a0, t0, 2f
+1:
+	addi	a1, a1, -1
+	lb	a5, 0(a1)
+	addi	a0, a0, -1
+	sb	a5, 0(a0)
+	bne	a0, t0, 1b
+2:
+
+	mv	a0, t0
+	ret
+
+.Lmisaligned_word_copy:
+	/*
+	 * Misaligned word-wise copy.
+	 * For misaligned copy we still perform word-wise copy, but we need to
+	 * use the value fetched from the previous iteration and do some shifts.
+	 * This is safe because we wouldn't access more words than necessary.
+	 */
+
+	/* Calculate shifts */
+	slli	t3, a3, 3
+	sub	t4, x0, t3 /* negate is okay as shift will only look at LSBs */
+
+	/* Load the initial value and align a1 */
+	andi	a1, a1, ~(SZREG-1)
+	REG_L	a5, 0(a1)
+
+	addi	t0, t0, SZREG-1
+	/* At least one iteration will be executed here, no check */
+1:
+	sll	a4, a5, t4
+	addi	a1, a1, -SZREG
+	REG_L	a5, 0(a1)
+	srl	a2, a5, t3
+	or	a2, a2, a4
+	addi	a0, a0, -SZREG
+	REG_S	a2, 0(a0)
+	bgtu	a0, t0, 1b
+
+	/* Update pointers to correct value */
+	addi	t0, t0, -(SZREG-1)
+	add	a1, a1, a3
+
+	j	.Lbyte_copy_tail
+
 END(__memmove)
-- 
2.20.1

