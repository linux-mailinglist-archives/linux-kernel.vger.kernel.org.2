Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5695938D7A2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhEVWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 18:24:28 -0400
Received: from mail-eopbgr110099.outbound.protection.outlook.com ([40.107.11.99]:25568
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231414AbhEVWY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 18:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azqPVKYrQPqJ0Gj1+t85Cn+V/3jzvMnhgDVMibvOSPOS7V5yAGoL/DZRToEyVLHLxYOLhpfSDOPtJDX+SNnMxuklzReYkoG0bELjEZJHHFIkEsu8vpztvjs4kWQ1XcarXpZzYpvjgrYEeN3oK1SwcGZ4sKAWE3lTWIVqj7zO35kX/GBpKgzWWUYLB19sTdwHyzdIm2jISOeO2EPNBzO3ONRKUEm/7Pig1nKVmgTORS58wYpqkiPxP5miptuukAqjhfB5pG2JPsIiHYlBEb9OR7pA/IE6gPk+lYkZs1rM06eZdkbFnPE3qTNGX9dmVN+hrSHhQAKAsojBXPIy8WqkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zduXBbqjJFPsWVcfbBmTG1Vmc12SlRGmtqXuY1yW2cM=;
 b=hYs4i4sOcoZK8KVBX0+i4O2g09Zlfo+MwaqN8AvCpUCVUzma1Kqk4VRwZniyDgrFvgWPclhj/Y4TyV1MIbbmZwpz6GO69zPtBqW8XgLMT2pLxk1/J+51HT3TtZnxmRypHLXBbBIO46WtvCOjBFMsCO13ThdhxoQ40xUnRLdqQoFdqhU+D04GQhxLrsqmHHfC0XmFQO/WMRvdQf87DfAWZloChIdap7fTDkZrwaXVitL3Dkcmr0lf+dqw0mHdbq2cYNSIa7CbtqnFpk7TIsxwW9tYjol5fLk823PiQuqSMpFGnd2+eKvRE2EbSRWcqx/lf5Ai/qUWajJD3deM3aH0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zduXBbqjJFPsWVcfbBmTG1Vmc12SlRGmtqXuY1yW2cM=;
 b=CujfIX4loFrT3LMYiUC1GEL3qLq8VhKVbyfZXBAy8g5qVstw7/qIclF+dcgQyIpEF4l3BtGxySVNAtCCv4o2rmUv4CUy/fOLCP6at+tq6pOj45pb3mDFlokOYNWXoD+coUVj/Jjk42NqL+R6AHKHCJWHtM7Axa/Og0eF+0BeEEs=
Authentication-Results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=garyguo.net;
Received: from LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:16::23)
 by LOYP265MB2256.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Sat, 22 May
 2021 22:22:59 +0000
Received: from LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
 ([fe80::944f:5a46:312d:8099]) by LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
 ([fe80::944f:5a46:312d:8099%3]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 22:22:59 +0000
Date:   Sat, 22 May 2021 23:22:56 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Nick Hu <nickhu@andestech.com>, Nylon Chen <nylon7@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix memmove and optimise memcpy when misalign
Message-ID: <20210522232256.00003f08@garyguo.net>
In-Reply-To: <20210216225555.4976-1-gary@garyguo.net>
References: <20210216225555.4976-1-gary@garyguo.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2001:470:6972:501:6160:bd41:88e8:6965]
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:16::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2001:470:6972:501:6160:bd41:88e8:6965) by LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 22:22:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5ea012-3227-4ae1-dda3-08d91d7027ed
X-MS-TrafficTypeDiagnostic: LOYP265MB2256:
X-Microsoft-Antispam-PRVS: <LOYP265MB2256B87E04DF5F0D4012A7D3D6289@LOYP265MB2256.GBRP265.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgSpwaDyLRumOAdj9VGN8YU+pDKHQi3Syeo2zSfBWvQaFRfkS+y+2q0fjMg8kyCgVwiTn/CQHuJkuNc/z4oRCw3xkBAWOwy59AoEIKpFm6NWmrPJ7lIvsmwSmSwnVs/oqX5s41v2AMEVkjWDdM/ICVacGruTQlz8b+U2UX3hY1H8/Yy6fnPqfmpzgD8WWRXjQfZY1UxxMlMlapf7M7Ot1J/PeKCk5Jo0rbFCZtKxiV5B0CCtKPzGoTJ6Ews6JN/JyXN/TdNFbG4eAnmjq37FIO6f8X1d29CYEnlT/nkteX0+Q5+J3bcJJfInqRhRJPgjBLAmDUj4c+pCVohERugC0sXCMkDm8rDaZVRBvsPX2wKvBbknCVGZiMYwO5/4fB6zuP8G8RMTvgha5l4RI/7Z8AXac8Sl+n8fq8tuAtQGt0I9hSAP/4zswVXw6fci+8BFmL8saUyz/0mbAk3dH+5patyCNVCkBwq+s4M0/lo2EauGZlPOTiNM/F3t/bx4IuOjo78ejPN1HRP+dN/SmM8Mylu46K/Ayt61Nwru1RyyZCLVT6rxxa1mKPU33WWZyh/LfQpnnuwf8zGpfyTJUG+jy808Oj1GIhmKN11eHTCYPG1oshO7obipt73NORdzwp2i1s5YHat0Ut2Ei3BUqDr6hO7sguF4HIHx38QCV6jh68SWKvzKWqJgbZXOxdrBguDLMfVgMAkAzV7yUFXrIlBu1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(39830400003)(376002)(8676002)(478600001)(186003)(5660300002)(30864003)(52116002)(83380400001)(66946007)(316002)(36756003)(6666004)(8936002)(2616005)(66476007)(86362001)(54906003)(2906002)(38100700002)(6486002)(66556008)(110136005)(4326008)(6496006)(1076003)(966005)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EP1WZNi4FXi2fpJWcZDT1+zh8GynvjENHC2QXNT/muIefNA6piypE70u9ECp?=
 =?us-ascii?Q?vqGk14xie3T/sq02YN8vWkIzlmXarkrGgos/ki9vWW0e+/UL5rpX550d0oT4?=
 =?us-ascii?Q?6HYgOwzj/Onf89O+kP0g6RGWEmVSNKY/jK5ogs2ftpDD7peWMRSRJJGIcClD?=
 =?us-ascii?Q?RYKM5da9/4bbRwYcFfvgHYEeGIcUX0jg3cFsu/BIKUHT6XnRcSxMpSI4ttWd?=
 =?us-ascii?Q?Nb/aVWQ+JMMTujw5aWrUYigTS8j2jDLN6Qbz16lJ8bsytBA7munylEPgHmJU?=
 =?us-ascii?Q?5i9Q2VVs3p3fjdNIaSsiQrL1+n4tVsqomW9yioxUmMrYPm6aYcOJGnEB+K7F?=
 =?us-ascii?Q?oteDYu/WegQOk5V134x3azrTxoe4WWzwA85dy1Ynuh1C55PEgmgx6N6FsjrL?=
 =?us-ascii?Q?SwqQL1W9DUSV6kP9jSFJ6pGxApYx9f3+sZi4OYYXk50bPuSVKULmuvU+EH0f?=
 =?us-ascii?Q?+jl4iO48xqorRhT1G6eHAx1sNc3rKIefLnO1yMewjU9Fr86FrcbnwgGZNGVQ?=
 =?us-ascii?Q?cKtHlWJTZmW18Y6fcSjVcDBCup3BspDJEjHH16pBDmbSA389ElfaEjKxpMoe?=
 =?us-ascii?Q?3n4PQub4hDOWaXRZv7BMJrwU85MrKY8U7d0LYqI+kNl6qS5VH7vIoxkUq8v9?=
 =?us-ascii?Q?7M+pd8NzVRFV8rzubt7d7x0EZGWujV2BItA6Nz5O95u+EgN55mknCoujlgwJ?=
 =?us-ascii?Q?SSjhcXakrOrv5WpPCopn2sZe+6M/z4tF/KdOlMtn4GrsA9xHO6UTX2AB139m?=
 =?us-ascii?Q?oYA4ddO3gvHxrTM9K9SdPem5NFy99JttoFZbv4HmzfR6drFCGLM3ZQYLL+Ud?=
 =?us-ascii?Q?UDY+BjEIHV27Q1YH9PMUiB/Hq0KvnuRipsVi8SYYwQEM8EI9AjyrSIre6nTv?=
 =?us-ascii?Q?rY5mN9yLOIposDRjqC5pI7W+tIFSzCROcrA7jODqyMInrofwE4U7C5RoWGD3?=
 =?us-ascii?Q?XSG3GxP6e3G8bJlQmrhji0vLiD7QslBDnFEU+FaMB7vfYDnaWPt3si3Vn5or?=
 =?us-ascii?Q?BqZwSv+YBmdFVTAEDg5qlDOthxNxuB/s9rPuuicf1dsRUKPS9DLZnjBYX3vM?=
 =?us-ascii?Q?gWWt/umL7PeXj7lZjKV4KNp2fIvUwfK6HZS5bjJwQMeR9exhgkiPQhxR29Bh?=
 =?us-ascii?Q?E4ELqBB3PMykD2tpE86gmq2YFXePirwkqNUm1/jh80Q12KBL9tsWb1MvPd+x?=
 =?us-ascii?Q?FpBt0ztFLZvJc+ANK+ERLtr+cWnWDgT6Nf24ioNPgilunZZSX/rMkT/iGdqC?=
 =?us-ascii?Q?XfA8aoFB831QADGDnQ5aNKtYOzUNMclWT28424p5VSCnGfd1BbF/WymP9+R8?=
 =?us-ascii?Q?7G+4XxgpeIkDB2oTy8nRwQT/eKED/uh5+95/Xl++nS1R0gZu4rvNytb4F79X?=
 =?us-ascii?Q?RnEC+PyWlW4oGCwwSAc7zEB2n5sZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5ea012-3227-4ae1-dda3-08d91d7027ed
X-MS-Exchange-CrossTenant-AuthSource: LNXP265MB0746.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 22:22:59.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWMKeALjCrqu2NNBDeS4ZHQTL45MlzXCSVX5kYE37ekJta3XTOVPOAS396OhNRS6uPQkaf4ndULFRJ3vPl/Omg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 22:55:51 +0000
Gary Guo <gary@garyguo.net> wrote:

> 04091d6 introduces an assembly version of memmove but
> it does take misalignment into account (it checks if
> length is a multiple of machine word size but pointers
> need also be aligned). As a result it will generate
> misaligned load/store for the majority of cases and causes
> significant performance regression on hardware that traps
> misaligned load/store and emulate them using firmware.
> 
> The current behaviour of memcpy is that it checks if both
> src and dest pointers are co-aligned (aka congruent
> modular SZ_REG). If aligned, it will copy data word-by-word
> after first aligning pointers to word boundary. If src
> and dst are not co-aligned, however, byte-wise copy will
> be performed.
> 
> This patch fixes the memmove and optimises memcpy for
> misaligned cases. It will first align destination pointer
> to word-boundary regardless whether src and dest are
> co-aligned or not. If they indeed are, then wordwise copy
> is performed. If they are not co-aligned, then it will
> load two adjacent words from src and use shifts to assemble
> a full machine word. Some additional assembly level
> micro-optimisation is also performed to ensure more
> instructions can be compressed (e.g. prefer a0 to t6).
> 
> In my testing this speeds up memcpy 4~5x when src and dest
> are not co-aligned (which is quite common in networking),
> and speeds up memmove 1000+x by avoiding trapping to firmware.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  arch/riscv/lib/memcpy.S  | 223
> ++++++++++++++++++++++++--------------- arch/riscv/lib/memmove.S |
> 176 ++++++++++++++++++++---------- 2 files changed, 257
> insertions(+), 142 deletions(-)
> 
> diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
> index 51ab716253fa..00672c19ad9b 100644
> --- a/arch/riscv/lib/memcpy.S
> +++ b/arch/riscv/lib/memcpy.S
> @@ -9,100 +9,151 @@
>  /* void *memcpy(void *, const void *, size_t) */
>  ENTRY(__memcpy)
>  WEAK(memcpy)
> -	move t6, a0  /* Preserve return value */
> +	/* Save for return value */
> +	mv	t6, a0
>  
> -	/* Defer to byte-oriented copy for small sizes */
> -	sltiu a3, a2, 128
> -	bnez a3, 4f
> -	/* Use word-oriented copy only if low-order bits match */
> -	andi a3, t6, SZREG-1
> -	andi a4, a1, SZREG-1
> -	bne a3, a4, 4f
> +	/*
> +	 * Register allocation for code below:
> +	 * a0 - start of uncopied dst
> +	 * a1 - start of uncopied src
> +	 * t0 - end of uncopied dst
> +	 */
> +	add	t0, a0, a2
>  
> -	beqz a3, 2f  /* Skip if already aligned */
>  	/*
> -	 * Round to nearest double word-aligned address
> -	 * greater than or equal to start address
> +	 * Use bytewise copy if too small.
> +	 *
> +	 * This threshold must be at least 2*SZREG to ensure at
> least one
> +	 * wordwise copy is performed. It is chosen to be 16 because
> it will
> +	 * save at least 7 iterations of bytewise copy, which pays
> off the
> +	 * fixed overhead.
>  	 */
> -	andi a3, a1, ~(SZREG-1)
> -	addi a3, a3, SZREG
> -	/* Handle initial misalignment */
> -	sub a4, a3, a1
> +	li	a3, 16
> +	bltu	a2, a3, .Lbyte_copy_tail
> +
> +	/*
> +	 * Bytewise copy first to align a0 to word boundary.
> +	 */
> +	addi	a2, a0, SZREG-1
> +	andi	a2, a2, ~(SZREG-1)
> +	beq	a0, a2, 2f
>  1:
> -	lb a5, 0(a1)
> -	addi a1, a1, 1
> -	sb a5, 0(t6)
> -	addi t6, t6, 1
> -	bltu a1, a3, 1b
> -	sub a2, a2, a4  /* Update count */
> +	lb	a5, 0(a1)
> +	addi	a1, a1, 1
> +	sb	a5, 0(a0)
> +	addi	a0, a0, 1
> +	bne	a0, a2, 1b
> +2:
> +
> +	/*
> +	 * Now a0 is word-aligned. If a1 is also word aligned, we
> could perform
> +	 * aligned word-wise copy. Otherwise we need to perform
> misaligned
> +	 * word-wise copy.
> +	 */
> +	andi	a3, a1, SZREG-1
> +	bnez	a3, .Lmisaligned_word_copy
>  
> +	/* Unrolled wordwise copy */
> +	addi	t0, t0, -(16*SZREG-1)
> +	bgeu	a0, t0, 2f
> +1:
> +	REG_L	a2,        0(a1)
> +	REG_L	a3,    SZREG(a1)
> +	REG_L	a4,  2*SZREG(a1)
> +	REG_L	a5,  3*SZREG(a1)
> +	REG_L	a6,  4*SZREG(a1)
> +	REG_L	a7,  5*SZREG(a1)
> +	REG_L	t1,  6*SZREG(a1)
> +	REG_L	t2,  7*SZREG(a1)
> +	REG_L	t3,  8*SZREG(a1)
> +	REG_L	t4,  9*SZREG(a1)
> +	REG_L	t5, 10*SZREG(a1)
> +	REG_S	a2,        0(a0)
> +	REG_S	a3,    SZREG(a0)
> +	REG_S	a4,  2*SZREG(a0)
> +	REG_S	a5,  3*SZREG(a0)
> +	REG_S	a6,  4*SZREG(a0)
> +	REG_S	a7,  5*SZREG(a0)
> +	REG_S	t1,  6*SZREG(a0)
> +	REG_S	t2,  7*SZREG(a0)
> +	REG_S	t3,  8*SZREG(a0)
> +	REG_S	t4,  9*SZREG(a0)
> +	REG_S	t5, 10*SZREG(a0)
> +	REG_L	a2, 11*SZREG(a1)
> +	REG_L	a3, 12*SZREG(a1)
> +	REG_L	a4, 13*SZREG(a1)
> +	REG_L	a5, 14*SZREG(a1)
> +	REG_L	a6, 15*SZREG(a1)
> +	addi	a1, a1, 16*SZREG
> +	REG_S	a2, 11*SZREG(a0)
> +	REG_S	a3, 12*SZREG(a0)
> +	REG_S	a4, 13*SZREG(a0)
> +	REG_S	a5, 14*SZREG(a0)
> +	REG_S	a6, 15*SZREG(a0)
> +	addi	a0, a0, 16*SZREG
> +	bltu	a0, t0, 1b
>  2:
> -	andi a4, a2, ~((16*SZREG)-1)
> -	beqz a4, 4f
> -	add a3, a1, a4
> -3:
> -	REG_L a4,       0(a1)
> -	REG_L a5,   SZREG(a1)
> -	REG_L a6, 2*SZREG(a1)
> -	REG_L a7, 3*SZREG(a1)
> -	REG_L t0, 4*SZREG(a1)
> -	REG_L t1, 5*SZREG(a1)
> -	REG_L t2, 6*SZREG(a1)
> -	REG_L t3, 7*SZREG(a1)
> -	REG_L t4, 8*SZREG(a1)
> -	REG_L t5, 9*SZREG(a1)
> -	REG_S a4,       0(t6)
> -	REG_S a5,   SZREG(t6)
> -	REG_S a6, 2*SZREG(t6)
> -	REG_S a7, 3*SZREG(t6)
> -	REG_S t0, 4*SZREG(t6)
> -	REG_S t1, 5*SZREG(t6)
> -	REG_S t2, 6*SZREG(t6)
> -	REG_S t3, 7*SZREG(t6)
> -	REG_S t4, 8*SZREG(t6)
> -	REG_S t5, 9*SZREG(t6)
> -	REG_L a4, 10*SZREG(a1)
> -	REG_L a5, 11*SZREG(a1)
> -	REG_L a6, 12*SZREG(a1)
> -	REG_L a7, 13*SZREG(a1)
> -	REG_L t0, 14*SZREG(a1)
> -	REG_L t1, 15*SZREG(a1)
> -	addi a1, a1, 16*SZREG
> -	REG_S a4, 10*SZREG(t6)
> -	REG_S a5, 11*SZREG(t6)
> -	REG_S a6, 12*SZREG(t6)
> -	REG_S a7, 13*SZREG(t6)
> -	REG_S t0, 14*SZREG(t6)
> -	REG_S t1, 15*SZREG(t6)
> -	addi t6, t6, 16*SZREG
> -	bltu a1, a3, 3b
> -	andi a2, a2, (16*SZREG)-1  /* Update count */
> -
> -4:
> -	/* Handle trailing misalignment */
> -	beqz a2, 6f
> -	add a3, a1, a2
> -
> -	/* Use word-oriented copy if co-aligned to word boundary */
> -	or a5, a1, t6
> -	or a5, a5, a3
> -	andi a5, a5, 3
> -	bnez a5, 5f
> -7:
> -	lw a4, 0(a1)
> -	addi a1, a1, 4
> -	sw a4, 0(t6)
> -	addi t6, t6, 4
> -	bltu a1, a3, 7b
> +	/* Post-loop increment by 16*SZREG-1 and pre-loop decrement
> by SZREG-1 */
> +	addi	t0, t0, 15*SZREG
>  
> -	ret
> +	/* Wordwise copy */
> +	bgeu	a0, t0, 2f
> +1:
> +	REG_L	a5, 0(a1)
> +	addi	a1, a1, SZREG
> +	REG_S	a5, 0(a0)
> +	addi	a0, a0, SZREG
> +	bltu	a0, t0, 1b
> +2:
> +	addi	t0, t0, SZREG-1
>  
> -5:
> -	lb a4, 0(a1)
> -	addi a1, a1, 1
> -	sb a4, 0(t6)
> -	addi t6, t6, 1
> -	bltu a1, a3, 5b
> -6:
> +.Lbyte_copy_tail:
> +	/*
> +	 * Bytewise copy anything left.
> +	 */
> +	beq	a0, t0, 2f
> +1:
> +	lb	a5, 0(a1)
> +	addi	a1, a1, 1
> +	sb	a5, 0(a0)
> +	addi	a0, a0, 1
> +	bne	a0, t0, 1b
> +2:
> +
> +	mv	a0, t6
>  	ret
> +
> +.Lmisaligned_word_copy:
> +	/*
> +	 * Misaligned word-wise copy.
> +	 * For misaligned copy we still perform word-wise copy, but
> we need to
> +	 * use the value fetched from the previous iteration and do
> some shifts.
> +	 * This is safe because we wouldn't access more words than
> necessary.
> +	 */
> +
> +	/* Calculate shifts */
> +	slli	t3, a3, 3
> +	sub	t4, x0, t3 /* negate is okay as shift will only
> look at LSBs */ +
> +	/* Load the initial value and align a1 */
> +	andi	a1, a1, ~(SZREG-1)
> +	REG_L	a5, 0(a1)
> +
> +	addi	t0, t0, -(SZREG-1)
> +	/* At least one iteration will be executed here, no check */
> +1:
> +	srl	a4, a5, t3
> +	REG_L	a5, SZREG(a1)
> +	addi	a1, a1, SZREG
> +	sll	a2, a5, t4
> +	or	a2, a2, a4
> +	REG_S	a2, 0(a0)
> +	addi	a0, a0, SZREG
> +	bltu	a0, t0, 1b
> +
> +	/* Update pointers to correct value */
> +	addi	t0, t0, SZREG-1
> +	add	a1, a1, a3
> +
> +	j	.Lbyte_copy_tail
>  END(__memcpy)
> diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
> index 07d1d2152ba5..fbe6701dbe4a 100644
> --- a/arch/riscv/lib/memmove.S
> +++ b/arch/riscv/lib/memmove.S
> @@ -5,60 +5,124 @@
>  
>  ENTRY(__memmove)
>  WEAK(memmove)
> -        move    t0, a0
> -        move    t1, a1
> -
> -        beq     a0, a1, exit_memcpy
> -        beqz    a2, exit_memcpy
> -        srli    t2, a2, 0x2
> -
> -        slt     t3, a0, a1
> -        beqz    t3, do_reverse
> -
> -        andi    a2, a2, 0x3
> -        li      t4, 1
> -        beqz    t2, byte_copy
> -
> -word_copy:
> -        lw      t3, 0(a1)
> -        addi    t2, t2, -1
> -        addi    a1, a1, 4
> -        sw      t3, 0(a0)
> -        addi    a0, a0, 4
> -        bnez    t2, word_copy
> -        beqz    a2, exit_memcpy
> -        j       byte_copy
> -
> -do_reverse:
> -        add     a0, a0, a2
> -        add     a1, a1, a2
> -        andi    a2, a2, 0x3
> -        li      t4, -1
> -        beqz    t2, reverse_byte_copy
> -
> -reverse_word_copy:
> -        addi    a1, a1, -4
> -        addi    t2, t2, -1
> -        lw      t3, 0(a1)
> -        addi    a0, a0, -4
> -        sw      t3, 0(a0)
> -        bnez    t2, reverse_word_copy
> -        beqz    a2, exit_memcpy
> -
> -reverse_byte_copy:
> -        addi    a0, a0, -1
> -        addi    a1, a1, -1
> -
> -byte_copy:
> -        lb      t3, 0(a1)
> -        addi    a2, a2, -1
> -        sb      t3, 0(a0)
> -        add     a1, a1, t4
> -        add     a0, a0, t4
> -        bnez    a2, byte_copy
> -
> -exit_memcpy:
> -        move a0, t0
> -        move a1, t1
> -        ret
> +	/*
> +	 * Here we determine if forward copy is possible. Forward
> copy is
> +	 * preferred to backward copy as it is more cache friendly.
> +	 *
> +	 * If a0 >= a1, t0 gives their distance, if t0 >= a2 then we
> can
> +	 *   copy forward.
> +	 * If a0 < a1, we can always copy forward. This will make t0
> negative,
> +	 *   so a *unsigned* comparison will always have t0 >= a2.
> +	 *
> +	 * For forward copy we just delegate the task to memcpy.
> +	 */
> +	sub	t0, a0, a1
> +	bltu	t0, a2, 1f
> +	tail	__memcpy
> +1:
> +
> +	/*
> +	 * Register allocation for code below:
> +	 * a0 - end of uncopied dst
> +	 * a1 - end of uncopied src
> +	 * t0 - start of uncopied dst
> +	 */
> +	mv	t0, a0
> +	add	a0, a0, a2
> +	add	a1, a1, a2
> +
> +	/*
> +	 * Use bytewise copy if too small.
> +	 *
> +	 * This threshold must be at least 2*SZREG to ensure at
> least one
> +	 * wordwise copy is performed. It is chosen to be 16 because
> it will
> +	 * save at least 7 iterations of bytewise copy, which pays
> off the
> +	 * fixed overhead.
> +	 */
> +	li	a3, 16
> +	bltu	a2, a3, .Lbyte_copy_tail
> +
> +	/*
> +	 * Bytewise copy first to align t0 to word boundary.
> +	 */
> +	andi	a2, a0, ~(SZREG-1)
> +	beq	a0, a2, 2f
> +1:
> +	addi	a1, a1, -1
> +	lb	a5, 0(a1)
> +	addi	a0, a0, -1
> +	sb	a5, 0(a0)
> +	bne	a0, a2, 1b
> +2:
> +
> +	/*
> +	 * Now a0 is word-aligned. If a1 is also word aligned, we
> could perform
> +	 * aligned word-wise copy. Otherwise we need to perform
> misaligned
> +	 * word-wise copy.
> +	 */
> +	andi	a3, a1, SZREG-1
> +	bnez	a3, .Lmisaligned_word_copy
> +
> +	/* Wordwise copy */
> +	addi	t0, t0, SZREG-1
> +	bleu	a0, t0, 2f
> +1:
> +	addi	a1, a1, -SZREG
> +	REG_L	a5, 0(a1)
> +	addi	a0, a0, -SZREG
> +	REG_S	a5, 0(a0)
> +	bgtu	a0, t0, 1b
> +2:
> +	addi	t0, t0, -(SZREG-1)
> +
> +.Lbyte_copy_tail:
> +	/*
> +	 * Bytewise copy anything left.
> +	 */
> +	beq	a0, t0, 2f
> +1:
> +	addi	a1, a1, -1
> +	lb	a5, 0(a1)
> +	addi	a0, a0, -1
> +	sb	a5, 0(a0)
> +	bne	a0, t0, 1b
> +2:
> +
> +	mv	a0, t0
> +	ret
> +
> +.Lmisaligned_word_copy:
> +	/*
> +	 * Misaligned word-wise copy.
> +	 * For misaligned copy we still perform word-wise copy, but
> we need to
> +	 * use the value fetched from the previous iteration and do
> some shifts.
> +	 * This is safe because we wouldn't access more words than
> necessary.
> +	 */
> +
> +	/* Calculate shifts */
> +	slli	t3, a3, 3
> +	sub	t4, x0, t3 /* negate is okay as shift will only
> look at LSBs */ +
> +	/* Load the initial value and align a1 */
> +	andi	a1, a1, ~(SZREG-1)
> +	REG_L	a5, 0(a1)
> +
> +	addi	t0, t0, SZREG-1
> +	/* At least one iteration will be executed here, no check */
> +1:
> +	sll	a4, a5, t4
> +	addi	a1, a1, -SZREG
> +	REG_L	a5, 0(a1)
> +	srl	a2, a5, t3
> +	or	a2, a2, a4
> +	addi	a0, a0, -SZREG
> +	REG_S	a2, 0(a0)
> +	bgtu	a0, t0, 1b
> +
> +	/* Update pointers to correct value */
> +	addi	t0, t0, -(SZREG-1)
> +	add	a1, a1, a3
> +
> +	j	.Lbyte_copy_tail
> +
>  END(__memmove)

ping. It's been 3 month since submission and I really would like to see
this applied or at least have some feedbacks.

Link to the original patch in archive:
https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/

- Gary
