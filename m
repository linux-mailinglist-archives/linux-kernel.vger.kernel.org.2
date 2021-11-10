Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9D44C1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhKJM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:58:54 -0500
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:10912
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231510AbhKJM6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/EjmvFThnuR8GLbZA7StZ4+ygEXAEioMTgPV/KaicMtkofehlDH/FPz5OvKY2WkGcHfs2G/Ma/LJGX9TE2AndpQjndw6cjlAH2fA6pV3f2vETJecjLI0LwC4rQd0oZD+8nBFPYh+tYwqv2g1S1NI611LfYzKAvqeM3XoaG5aYY3NK8V819a/3ZfiTA6en6FaugzL9ZkIctFIII0bRvmkO97v2CBo3xDhfyxYfb9U+tDXDoH2B56W7s4YJaJcACzKWzuz4OtZNJ09ZAfT1gYrtE9pMmjgN1epGsTgMH27sDCUiuq6B1YtzTRHXLf6D/EnjkJsJ40GLoHsQSCD5BPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N43o0QJsdCFlL0MP7tSi4n2XLpD8cg8xLWZeE07nbTE=;
 b=MDxQM+G3VW4ZtxlltjdJvzxSPrSebKerBW/FkF+RQNgX0DocbpQlnFYArLWTXLqJvQU3S1bn2+zRSAo5I+7swH6bbMpL5LBHu86PvGmSb2sRJ/04k2/F8Gi6OxRMT5HX3BkzGwtCXyUisi1BJ5+0bS8ERBTTv1qqXU0IoI5vjvrGUtjq9hOnFvXheVUZZ3CB6Fy8LuWvlVOy5g5Wha3cpA3t4MnvZDYQKQg2RPmr2N6XyiTQPZKpFEW4z/ZZHQD0fX873AEtP68ShSDYP9zu5MS6QODqOWQ5nn5R90DqZz3Wz/naj8ME/+bd+VtlKihqu3oCRPOQtCTVTyJNjityQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N43o0QJsdCFlL0MP7tSi4n2XLpD8cg8xLWZeE07nbTE=;
 b=FNFJXFAUHryqbNaoQzpVJvb5CAVQ5N0wHZgrmhWLhrbLIMkLWI0v5HnydB0eK8aj3zLZrFZlFY7EPjsvoEwS90i1epUUDl5L7xZstZqbxyxYZkkslun2vGo3/jRHy9zpBh6sUWuRQ5Vrx3uLnTaBN0NBtlJLEyxgzQWLfAfb1XQEMaUsRvYh3X15RXV57ixUVeVzQy2YwzvqS/GI6Z3Snx4Cs18RiA9jDsHlOEtvOYRQUekBI36j2ccW4uQ2hZUw8Av+kLudliWPzdKVJOldIqGMg/82q/N3iaP534rvkCDDs5wINZvJ5D1G18HV+sk/VkShZ83mIf9IW8pjx+L/Kw==
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 12:56:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 12:56:03 +0000
Date:   Wed, 10 Nov 2021 08:56:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
Message-ID: <20211110125601.GQ1740502@nvidia.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 12:56:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkn8z-007xsO-EX; Wed, 10 Nov 2021 08:56:01 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9f13bd-2c85-4be2-eca9-08d9a449739c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-Microsoft-Antispam-PRVS: <BL0PR12MB550568C3E2933D2D6D6A0617C2939@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoESDqcHBg9pgW3qe6NZ7Y990mgMtjoTSKBlDNWyaN/HqIJRZOYWEphRUK/YYYU1UNg6Xnb9cBiE5BYarI+vPlubIQbGN6khOk4XnQAfi60TYyIfajA6NXErrmL+FMhBI5S/XuqAdzqEHV28sIbpUcxl2hCeEij7SBUa9uPujJxwv2bXN02WEZEVfwlW8DNySdA+mS23z6hx0PB6LqNKWqjgKpAbQ0BQuWbInoj4kW/zGv76W5PoCBP4leXnPO6HW+iF1i9oxYJeV6IZyyYTiRa1DQF2UpksXR/UKwjz4OnhYxiw9+gXl2Dzl7hhjnaWaAQjzyQD86U55tWvKhaA7lo5zYTArnWaMIu5981UFTEkh4RuHKom0vEmNmyjxRWTuvn30+hBuCbQ5bL58nhv2Bfxe93M8GAG+sDVO8EvtHDxj0bliqXpYnOQUnb7zlbLcJYyW//s7f2psbwVTsKbAqSAfhCD2ebuNCMAy0EIfcXKdv8vz0MNdh5Va5Mr73ONvtnAP5ynRoyNyvhWrmU3kSEKxSx4obfSRFAy1ewQd5h5d8MvnvZVXstw/xRTJ5ZdMIHZR3cFUd5ISWrdBIzxxQer0j6Dz3D1QzQjEG7MVcWzHENrDeDL3A2OXMUBdRLY9PVl2d6FtMO871krRobaEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(7416002)(66556008)(6916009)(38100700002)(33656002)(1076003)(508600001)(8936002)(8676002)(66476007)(36756003)(2906002)(83380400001)(2616005)(86362001)(66946007)(426003)(5660300002)(26005)(9786002)(9746002)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzil/l9ET96mgnLcJBj3f7AXJcoBPgrgADsAsMbtSogKNPzGZDCuz6CRev1b?=
 =?us-ascii?Q?xhYPM6Jd5P0b6d3g2FaW7IG+jsXj0+OZQJPUj8LXZUn31YqvUiuy8DafJieT?=
 =?us-ascii?Q?yJAXqcq+QbT4W4hmG6w0cufE/lsJIU2sdPBPrXIWAjdUmgEN+wPmndaV47bL?=
 =?us-ascii?Q?hGEZGhoPZy6IiQpj/3k9wdQK9TyGJ2fNVVu5bof6I1c27N0zBOrhEH9cz6yb?=
 =?us-ascii?Q?BZH8fPd3Sua9ozhkkeLn9Y2PPX3V26nI56CzMGfXqndG7vUSB0kz//ksiYUw?=
 =?us-ascii?Q?IxPvgVGv/QMPMlHsEs5glYvxRD2UpPJ+NP0c5pZlCa6Zzj0bEmXz+5nUrtcw?=
 =?us-ascii?Q?JbOuU4M7uXeuOwmgkjISkGxcGJk6Hm6+iMw9/eyhExdiQHujJ5cPkH8qAc9H?=
 =?us-ascii?Q?67symdBA+1QC+gyJHKC8Nx2h9iWJ3hli+Rw5qZVuEJD3BBAmfgL1zktG5Yzx?=
 =?us-ascii?Q?Z10upu+FfJRmSwkGrtLE0mB4NI1ANC1AiBEn/53boDQeAdW3pe2bkp+ORAiJ?=
 =?us-ascii?Q?KJp9Qodf08l+S7f2ruyfBGoRgKAAh5Iu1Nbt8uflWGsuxu957SRGfF63XEra?=
 =?us-ascii?Q?nDglTyeU6CoQR7dFOkA+vgVq3cb3lu3bJ5zo5NIZSne7lLnsGeK9i6Gbd19j?=
 =?us-ascii?Q?83evTb/9jfTh6cvFWK025epdpvcKUHTC2A0xTT0QuPwC1DDL4r44oYQKV9Cj?=
 =?us-ascii?Q?VyA6+A/4b/CGOqfmheE2aq6hWjbtvL8EW01gO9oaN4Zy5iGJTzuHAzLReFRv?=
 =?us-ascii?Q?CPHCB1freT/KFbqfN38FG6/p8CqD/gQD4Rf5QTZZvhgoIab0j49ltfWmmh6f?=
 =?us-ascii?Q?LoKYZo36o4ETBXTWyxPJZJuj60xNNv7GUMxagunKdVm2YdlTBwK/a08A1UuC?=
 =?us-ascii?Q?JYReZhamwIorBHtSm/PDssUQaTkchyRTBy1copSAPMiERCN6Gc8nRgbvnjJh?=
 =?us-ascii?Q?j1PFrkwC5xkW8wAcSgwMsCNfDkO+lXZhXmC40gPnx2cadsGH0z+ZXUc/bbYX?=
 =?us-ascii?Q?kDhG7EaqmbAXA6FVlTnQoSffaQhjelMN6lw6meXCjvNfKdeNAi8KcO02PXlZ?=
 =?us-ascii?Q?Yp3vZ01P5hvt4Ii/6qQyLxDqX1oCFt5z0lwwdo33UuPj0upULdsYH1EUWw0D?=
 =?us-ascii?Q?Q8SXWnOpJLuzw23m1imRVjm8uO+ngN+uPKph2XoISCrz4/VDKRYZqTD0PLFm?=
 =?us-ascii?Q?dX7526RquuLw5JcY4OwBTaqFVXWim4N1ivw5Av1yof+S2puWRaE9NLn9jHLD?=
 =?us-ascii?Q?jfthX2n3atg0OF8uTQl/aFDVXpzZrP6mXQXFZt/5s1Qs7+T8JdVNib8Lfauq?=
 =?us-ascii?Q?mx1TPZXB4CYQK6LzaIufaEkL5K7GIEnAby8PEMIydXY0OzUV+kslS3wK7K2C?=
 =?us-ascii?Q?GN6OUhAgRPeBaLFpSGJBTtKBRbcrf213n5Hgx7KJ0tipMqL3IMa3c21inhR9?=
 =?us-ascii?Q?v0cAmTV1jcJ8pfLJwQyWPx870XqoIme9YvvjoKzNoQXzMx9nEpg6nwJpzCVq?=
 =?us-ascii?Q?EVH7+SHthuq8L/cAZr5Ny1W1eW8PFnKLiCEtcExe9jcfQi5kUMcVo2Y45B9a?=
 =?us-ascii?Q?37jLXT3DMURM7wS1JHM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9f13bd-2c85-4be2-eca9-08d9a449739c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 12:56:03.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NCjXxYPVuIi5lhdpHXNcTuk+o25lpqtL/tDzf/yQKOtoKl6DOe4cWZI7tcAM1f5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 06:54:13PM +0800, Qi Zheng wrote:

> In this patch series, we add a pte_refcount field to the struct page of page
> table to track how many users of PTE page table. Similar to the mechanism of
> page refcount, the user of PTE page table should hold a refcount to it before
> accessing. The PTE page table page will be freed when the last refcount is
> dropped.

So, this approach basically adds two atomics on every PTE map

If I have it right the reason that zap cannot clean the PTEs today is
because zap cannot obtain the mmap lock due to a lock ordering issue
with the inode lock vs mmap lock.

If it could obtain the mmap lock then it could do the zap using the
write side as unmapping a vma does.

Rather than adding a new "lock" to ever PTE I wonder if it would be
more efficient to break up the mmap lock and introduce a specific
rwsem for the page table itself, in addition to the PTL. Currently the
mmap lock is protecting both the vma list and the page table.

I think that would allow the lock ordering issue to be resolved and
zap could obtain a page table rwsem.

Compared to two atomics per PTE this would just be two atomic per
page table walk operation, it is conceptually a lot simpler, and would
allow freeing all the page table levels, not just PTEs.

?

Jason
