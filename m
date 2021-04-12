Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040AB35BA96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhDLHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:08:50 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:52769
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236672AbhDLHIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqPV51Ikm25X9Fgld92Zu4bWpSn/nJeDQCUEx7De4MKEEUYCHbHlkXW2VV62QG98vogbPN3hgGngR1K6aHEKHKbsNK4NZ4e8S3QtKlGJ3lro1HgSqH6muqiLsOiH5zR+2zMtbcE3pc4v1c3n2kdnwngIOgy76TAI2XaWcpw+8W0lUULfRUGz/iNsJCSJZl/PwLKir/WWsD/d8EWpURyYm/+C+BWYBpB8pSs/sIDPmMxL8a+YLrKewdx4o71pACXP83XzIGG1SxKVJaVtRBROjy+MyanJKEeyo20xiTPrlvxuhEetaj4WNCMnbVP7DYKmY2/l2nFOxh7WpE91DUQkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYeMy7JMc+3/DVrStAyOW6mC50f9Pv9mydUCwpPprkE=;
 b=gDie6Vwe4yId+oE2a4ea5TUF9bfGWby8oNEPTwWuKj5xJgbWhj6S+j6gcTnWExnH0l/FftpgmY5r/uIndFOg1iwAbw9OIVfrEl24lcHylyPG6rPuUNkiULbbenvUvDjBh5PMZS422n5pZCN4xStRz2xM+WiNsIAaD/oD0Kk0TmxzYSO+VL8vjFI/ELlCa/NP+o0hl3W4Y6h8vsnsc9LH9UgdVaSZmvx/puc+XbBj/aRqHJm3lzf5lqAjq4WkWaK2y07NZ8npBNkSHKA5JG0y/q2tPyz1OBxgRyzhRyQmAdkYU+QYx2w2P2l43pmVYV/4gRt/62UgsWl9o6NBRv08jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYeMy7JMc+3/DVrStAyOW6mC50f9Pv9mydUCwpPprkE=;
 b=kUDowaUKKHaVLL9BS6d9bNXMWAnDF1ULr/NZP55EBNVVsdPlj9U0xpkDiKYrdvttYArIJ6WUOlBqYWrjF1beqe43uDWbOi5J5vFqU9mUZawA2eLFB+0CODxRxrvGJOOeT664XMZs36Df/u9zovBpCEe0jYRZ43isM860KUVnGtE=
Authentication-Results: jiuyang.me; dkim=none (message not signed)
 header.d=none;jiuyang.me; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5920.namprd03.prod.outlook.com (2603:10b6:a03:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 07:08:25 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:08:25 +0000
Date:   Mon, 12 Apr 2021 15:08:17 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jiuyang Liu <liu@jiuyang.me>
Cc:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement flush_cache_vmap for RISC-V
Message-ID: <20210412150817.33f49be8@xhacker.debian>
In-Reply-To: <20210412000531.12249-1-liu@jiuyang.me>
References: <20210412000531.12249-1-liu@jiuyang.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 07:08:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 820b690b-013c-474e-ed3c-08d8fd81c404
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5920:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB59205AB793EF9687C9CE9132ED709@SJ0PR03MB5920.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GM//3I7cLbfvIMqcjwkH6GSn6YNkGJlcEBsmG+E/sipPItnzVc+b4XCY4cUcAtVy9KrZQPpbT0TIOURiv81HwQkN8pgMvxjO7SF9H4wMwL3eI1JchlkhYNmuL6w6Hssm00vCeS45O1OKV91UZ6mReYszeVlhkdyt5o10//5dZefuFBH7CwSHaQHrKMku2CeKQpyxXSF/qf+U1iDqgy+isM5OURjyYWIrXwyOGQ5OBI2Y7Jn4Gu2eTowNyg0ZHE3fz+dD59i9uHtS1IYTn8QbD8BuiQb8d0rtX0Zqr4RXgQ7euzeGzLmm+JWlgqsypBAlGcqYkyZanj9d7fj/Kz8Be8Cvciy4uP4CQVKeiMy9nqOa35P6dQMEeVSjOf3j7A6nR5i90tlXaL0/ly99eReTBSI3h0DB3UXomnRJmP24J9eUHFeHgu+wlSQHPAjX9a4KlB1jaj9dS0gPm63opyX5SONyOEEoVBnD03lOc8pOgMBjuGwWri1CAJwGg0xTgcW6gTi6vgDR9pb2+whxqDeaFmEpIk8CY/seV8IClNPk88Lir4zMuo9LrifPPxcZ+zuRm9OG3rzcZLDKPz3rKlhMEHYMAgK3s91vMZyuGJhZiovUljo3Zsk0I+Uu0fXXM8XLYGYGC5IS4nJvS0Z0IEKFnaz+sqe20KiKQ6OkIcZLwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39850400004)(346002)(396003)(366004)(1076003)(16526019)(5660300002)(6916009)(4326008)(2906002)(55016002)(7696005)(6506007)(8676002)(26005)(38350700002)(6666004)(66556008)(66476007)(54906003)(66946007)(52116002)(186003)(7416002)(956004)(316002)(478600001)(38100700002)(86362001)(9686003)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zhIHM93S93ebo42MS83QwAfeNk7oRy93MdlTtVCBBdR8i4Yfv2OXnKcM8+/T?=
 =?us-ascii?Q?9LF4gQO9xQI+UHUS2KF2Aap/0GoFL9GCe4e4lvrGI36vM3y++7tG3Nmv3ljb?=
 =?us-ascii?Q?9LAYzXQEUVVKQ/f/cCgjk/y9k1ZI4ObzQdi2BgD0jPGzeAYfxKFy7laT8LKX?=
 =?us-ascii?Q?Jow7+1bmecYqiKRmV5FSNnERcgKyiqGX0NzlE7DacvhktXVvL1wWtFF9e0vx?=
 =?us-ascii?Q?A21lAsAUDbSncziy4LgZKk5skWesWgL/z2ROgUT7BMmW2BYe6xxGYPRuc0dZ?=
 =?us-ascii?Q?0wO4UeKjlUv+MvjRhZB3wejtmgCj3ewTztgVe5ICZ79DLreY7Dm0BukcFp2o?=
 =?us-ascii?Q?X7aBuAVj3Mz/EwXi94GDTvhIlwqtzmm5P1yk1XIv5f+ggbuv3oz/4UKUc+/L?=
 =?us-ascii?Q?KiNkN1sALlI1c4cZvUl4GguyZ4MpS9ts6niX0aWG+ot8jc2pbutvIlya7wXa?=
 =?us-ascii?Q?Vtf8/4iNpptx+JErhK/cI+hXKr3R8wtILNLgNIprM/5YLBjsFKFgEFpAzZlw?=
 =?us-ascii?Q?tZrNICMRswYgvn3bewN4k2Hr4PxdadlouBKb4V/VdGoeVIWTWhJ/EuOQ6c7H?=
 =?us-ascii?Q?3ENKVgMd3QTDV6Bm9HzPfz6W/re9ke/9lMz8udShP8HTtMKbzjV+0Frnecv4?=
 =?us-ascii?Q?UuMWs994xGKbPcOp0sGzyjyIwPLrAzIZTO2yrjvhoHOsTJ0DnvsC6+uljaCE?=
 =?us-ascii?Q?IjZvInPCACECPjlOTrTNKPzSmk270+Yxl82lyXweVtRTBWeYYrYd+ZCQ3PEh?=
 =?us-ascii?Q?Yc1zteDAoB/uG+O6+dXA7iRm/tJ3Bb1t6z4UGhsCD4l7z3feMaXvFzKVmlMH?=
 =?us-ascii?Q?ZidNcks83omb9n8uFltQLabvBSu4clLGLIBiX6J36F2F3hiJcTXfEC2Q2LBD?=
 =?us-ascii?Q?PSoB/klFfvu2MsYpaTvMYf/V3fjvmv1/FAqxMzIBijuW8bdv8H9N/ZLtZh7e?=
 =?us-ascii?Q?tjf9amCBHI8ix30AIU36+4a50kMFd3yydQpP+ZNK+460+G5pQKeOMdqRQEnA?=
 =?us-ascii?Q?i5wI6R61lIA7ZeNBUhScRvMgPNi0tnBOyu/cma3DtKw6Ud2luhMBq1kKRmvP?=
 =?us-ascii?Q?Z2fhnkBLUYS0H9fN8wLNkUlevAQ0P/H0i5p4hLK2Uhhq8yCxwU+FkyUr2fvq?=
 =?us-ascii?Q?elWZdF8oIdRfLIsxStS0VygjtGENFUYifasrrqiWZJvT1o4TkCDaa1e//lwj?=
 =?us-ascii?Q?3hQ50XaOdg/CCEyoFxmp8DO8FHbkmPKcdWq5xaeHXTYrmGw5z08rXBsUAkhH?=
 =?us-ascii?Q?A1rxdLsOp3yrs+9WouiIz3Dhp/QRtv7SPSDyzbEQ2g9kU9DHa1A4XGJu1MfI?=
 =?us-ascii?Q?mabgY8oYvk7OVjKQ7lyaBN1s?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820b690b-013c-474e-ed3c-08d8fd81c404
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 07:08:25.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpGnqFDqTCvdWymxGw6EVL+trwX0j0EcNe629XBYX788SAawugap/leA0MssmO4csn/icSJdrt1gODJ6YexcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiuyang,

On Mon, 12 Apr 2021 00:05:30 +0000 Jiuyang Liu <liu@jiuyang.me> wrote:


> 
> This patch implements flush_cache_vmap for RISC-V, since it modifies PTE.
> Without this patch, SFENCE.VMA won't be added to related codes, which
> might introduce a bug in the out-of-order micro-architecture
> implementations.
> 
> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

IIRC, Palmer hasn't given this Reviewed-by tag.

> ---

Could you plz add version and changes? IIRC, this is the v3.

>  arch/riscv/include/asm/cacheflush.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 23ff70350992..3fd528badc35 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -30,6 +30,12 @@ static inline void flush_dcache_page(struct page *page)
>  #define flush_icache_user_page(vma, pg, addr, len) \
>         flush_icache_mm(vma->vm_mm, 0)
> 
> +/*
> + * flush_cache_vmap is invoked after map_kernel_range() has installed the page
> + * table entries, which modifies PTE, SFENCE.VMA should be inserted.

Just my humble opinion, flush_cache_vmap() may not be necessary. vmalloc_fault
can take care of this, and finally sfence.vma is inserted in related path.

Regards

> + */
> +#define flush_cache_vmap(start, end) flush_tlb_all()
> +
>  #ifndef CONFIG_SMP
> 
>  #define flush_icache_all() local_flush_icache_all()
> --
> 2.31.1
