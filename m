Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D144C315
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhKJOlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:41:52 -0500
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:40801
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232222AbhKJOlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:41:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/tyxK20dx/4opqIMqwz8T20m11D1CQ5np8Mqi9dPZsQB0se1FXEN+J6YQBdW3NOFkBmnWLQnOuJDsYdjgQlmVEGlhVVJQKeW9EfhD5SJS45510ZF5dXMsBq4zdpykjtpmo3cvGek4/TwFqYFLPIE5pXiSbePfWh4x7lfmEL39oet3gKVPvQBRI0xfcsOkG9BxxBnazDixS3DA6uY7FnAINXQb5X0Vda6zst2vMFiWGxVEmexyqq321rJvD4MpGpPb6N9klXR35uw13uV59ZTiBDKxZgowU2nMNNLTXgiVt5FKOM0gC36e0q9TTyHSC0T+JrSH2+FffswIvM07GxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlZgLgOE0DLI+pr8l/rd8zaoe2CbSAH0uAJhvW7zBsQ=;
 b=OgIC3+o9GHl4Y3S50hnX3Q23Xw7wD5GAUlCr2E+0q1Pdn8Bd/JmOVgcQuNFnKfpPHikDegeKFIaMRDBf9GiR44wYDUKFKBaOsvcGzR6oGuZ1CZQyRVC/CksiCTmTu4vEeBwzbccJyLkV9e6ntGCjiiIUtdr9m8lQyOx9jH5yCFd55hl/jz+DXdtBgO8ABd5TvbyP+g4Ncaw0zpou10TfLNUDZYCio/xHGLcoCwH1eKFKVqAlKXfKXt2g/LVEDqW/WWmUu108kOEjLKD4lOK6wLl2tAA6jEQWt8Dtqtz4oBEYje73C15G7+7DrX/wCpJriCIBurl2ZADp74hjWsRkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlZgLgOE0DLI+pr8l/rd8zaoe2CbSAH0uAJhvW7zBsQ=;
 b=Y1AiCvzvnDPpwWcOK3/z0dsa682Fy8z8NEAKXSZfZewGh4Xc4Pk5qlZN1vVFRqkTFgdzxfhpYLXRkLOrokGwmd8KB3c+RhXki8p7UZrbihqxzKja2cRrTxkb9vwBIfh4lNaC9ub7xY7YiFopgxxyk43KqEcGT/ZImw5MPFOvNG5CwhgVHeQueU8NF0CUN9djsxRRkf/WCivxrnVFTsJl0Jpx2b8Zk7bwb0VwdBRi08Prc1qSyi6Mg2NADajSZrNs4GVLLsY0BQvVJF3jAn7euE5ZwxGGSVThS6Nyda1tKo8K+HcjR427epr93l9LeeBc5NyUifdggahd3cOj0Tc7yg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 14:39:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 14:39:01 +0000
Date:   Wed, 10 Nov 2021 10:38:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
Message-ID: <20211110143859.GS1740502@nvidia.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Wed, 10 Nov 2021 14:39:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkokd-007zsv-IX; Wed, 10 Nov 2021 10:38:59 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427194ea-c918-474e-cdf9-08d9a457d5e8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5062508415F91C169B708357C2939@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QJ5cHC8QIGXoy1uRhiO7IQFzwRhcEXJnHtCQrBPAqqvUpo29vcyzjKrpeU3qeW/vE77q14blb294IIGQUcxlwFERCUNvIX4xMsUmpXykxOwq8Bx9LfMZ068dTuiWSMAeSj80aCS9K9TOkKyuy4UjLiMnRewqG28wqTcGEN9r3Vys4lWfPfZtLe/uKs9cmi5SsA8d2rtt5H9m4Y70yxOdpPCVezhsJknHqAaAjdylncYBvvKkyUtFE6HAsV/eZTzvXugMH6vx6R8ZnooNQtaMcwyy/RE00LdodZThnkX5mxKBSoweG36I3iIPCQQGdOJV91xRMDu+N3IQ+/wU5miafn4B3Q8NOqUuv3qQELfCdyOfmuWSfnJJWhMBl5p4clCdPLDw+v/2XllxFXbHg55da1vNp7OlGFMc2qDDp2TmR23FdEulJdDvsA7g2RawmOk2il+iQ9PT+msW0gNJ6iCUbttHBuLYiHGriFRDHH5QVexU2HvHvNVBmkxYC9q/F1LFD8KgqIKfpck7JhNrKad6UoLZYVJxtNPOiG4wjTSnlaskj5edmU5LCMaXMY8VMxaSaKgaY+Rmmrkq7joNcyXk8giQ5WIh9aAkQ2McRLskv0xMBQB5L9vE25Gl2sDl2C2mnM++BMeJ2Lvn3qhLDEEHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(9746002)(9786002)(5660300002)(33656002)(316002)(8936002)(2616005)(186003)(36756003)(1076003)(4326008)(508600001)(53546011)(2906002)(6916009)(83380400001)(66946007)(66476007)(86362001)(66556008)(7416002)(38100700002)(26005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fC/eaefKFf79S2V/KEqOTGw3NFz22niZI87CaaK3VWXzn9FCpGlx3Td12hVH?=
 =?us-ascii?Q?c82frrW80kbQaPOEV+buOsSEguXlYoHeMz9d16mIkcAfNrzeOPJysELysvDU?=
 =?us-ascii?Q?CFLK1FBYA07issjBOkl20hUECIr/XcrAjKAomBK5Hv/n3T4R0OFlFzK8f9CS?=
 =?us-ascii?Q?bsWogS5s7WdlVeILlsfd+PvyFz4vnwCvRp/DiZdnFBtattFQGHpVamvr3De0?=
 =?us-ascii?Q?DGahEwsc06LvPZu/CJ48xWhoeUvNP5MlHbtwVwkmtS4Q5Op0kHXc+Lvn+6DT?=
 =?us-ascii?Q?flYsjEQgA3Ze7wsixZjMWz0Cr7r3jRDT/yuH5wX4Vpo/irvDfj2NyEIPHx21?=
 =?us-ascii?Q?OPye81nAFIshKKNS88gM4UkUDWryyDZ1rRwRtmljvmhhYNoc5OTGXJfv5LGI?=
 =?us-ascii?Q?CzE2fVhHa2JO5c3rW9Vq6uMO3UEf+3uKZVhoweIOz1G20oDmD35SBIL0NCQg?=
 =?us-ascii?Q?Ks8vi0a4frWOZutvHwz+7fbvtHQ5Mnw0aabSJK/9P4bPcJgBehnxOK8IGRdt?=
 =?us-ascii?Q?mFQIXVsrRs5KRVukedpYLOapWJbY1r4KxIgjPQpOMhGAK/BZ+m7b4kQUFgN7?=
 =?us-ascii?Q?POFwzaSU/YA58NwNr2IrtP+9xAjEVQGW3UXcaRdv01g9sp92/8Rxmf0oL0x+?=
 =?us-ascii?Q?FHhhk6h6zud+JxowhJ0L1F/EI+REFBY14jJh2DgcuZZ1CnkVz6GQWamjeqBg?=
 =?us-ascii?Q?gNGGSVYzLbxKbw2ZGslZO5I9HqnS6to3uY0zrOmOeGdfkCP03AErSW7K6a78?=
 =?us-ascii?Q?ZqAoUmnk+OV2fdmiyZ3T5s5VpAUzVuZznhYIJvw4NBLDj7xLK1Bux/ZnrBeF?=
 =?us-ascii?Q?rWVifzdLEkTk6SmUvBNDKP8RsAyUovvFjIFZJv3nHc4FQNOvXjW2Sf5eehcl?=
 =?us-ascii?Q?/Oj/L1xn3bA0FdEjiKQB4wFxaIJ3V7je3INAqX6D7jNrdadIxcJjbgh9LN2u?=
 =?us-ascii?Q?cieqxWGDR0d6EpS9BXaAh9CZNU9QLNVUTr833woF+4ewMSCfmRlxbDettfvp?=
 =?us-ascii?Q?YhdTksP2dilkWGtWfIhksix6j7gz7C/ZOB+/dAbPVJRT4B2JIeJXTACZq+EE?=
 =?us-ascii?Q?Evx0GJP61+AsuSzsjsIx2ipcEyQO+g7RuQGrjN3n/Xr4qRvRNWW/6LcDoPG9?=
 =?us-ascii?Q?pSKdDVDbOVtW+Pfbue3jzI6NozaiLSo88lIj0NWGCbmtlhOVEFWPHpJ0Hd/s?=
 =?us-ascii?Q?YUFfWRa52de7ZotWcYGRW2+ZHop0RlgqtaAIkoWcnOE3pqb4RCnwi65gA3ZL?=
 =?us-ascii?Q?m6Jq/WQT8KDpabUf0WJRx2YYgXBh/HkqBG+BuoVLbd99eGmbZTWJqFuwIMAB?=
 =?us-ascii?Q?4E7OEeY9BqIj2d9Vpn1gTsH5J+PM4ExKXyCHQydcbmRjec45Sz3TVefpcZ0L?=
 =?us-ascii?Q?mIXjt0PrjD3ZEaILSV9ef/8gkHy9DKkJfsIVCUbm6AxCN420LHj+bHSG6VYZ?=
 =?us-ascii?Q?oLHiK95Dasmas/I7wGEcx3//m9WkSuW+3i0CXMI7RDvmeilG8r9U4ZqGrjUr?=
 =?us-ascii?Q?eSJNExmKg7E52eOk2YjZm9UQ6UqUWAC6IkYbRDX9yQeoDFw0nEKdhKXsmcs9?=
 =?us-ascii?Q?u9WQGmHmDvg+nLsl9Yg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427194ea-c918-474e-cdf9-08d9a457d5e8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 14:39:00.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg1eg5AYS3bf+X7xSaFlFpwrLUxfvMjKQaxNSquUfMaOQ4xbsSA/I1xS1po15G9z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:25:50PM +0100, David Hildenbrand wrote:
> On 10.11.21 13:56, Jason Gunthorpe wrote:
> > On Wed, Nov 10, 2021 at 06:54:13PM +0800, Qi Zheng wrote:
> > 
> >> In this patch series, we add a pte_refcount field to the struct page of page
> >> table to track how many users of PTE page table. Similar to the mechanism of
> >> page refcount, the user of PTE page table should hold a refcount to it before
> >> accessing. The PTE page table page will be freed when the last refcount is
> >> dropped.
> > 
> > So, this approach basically adds two atomics on every PTE map
> > 
> > If I have it right the reason that zap cannot clean the PTEs today is
> > because zap cannot obtain the mmap lock due to a lock ordering issue
> > with the inode lock vs mmap lock.
> 
> There are different ways to zap: madvise(DONTNEED) vs
> fallocate(PUNCH_HOLE). It depends on "from where" we're actually
> comming: a process page table walker or the rmap.

AFAIK rmap is the same issue, it can't lock the mmap_sem

> The way locking currently works doesn't allow to remove a page table
> just by holding the mmap lock, not even in write mode. 

I'm not sure I understand this. If the goal is to free the PTE tables
then the main concern is use-after free on page table walkers (which
this series is addressing). Ignoring bugs, we have only three ways to
read the page table:

 - Fully locked. Under the PTLs (gup slow is an example)
 - Semi-locked. Under the read mmap lock and no PTLs (hmm is an example)
 - hw-locked. Barriered with TLB flush (gup fast is an example)

#1 should be completely safe as the PTLs will protect eveything
#2 is safe so long as the write side is held during any layout changes
#3 interacts with the TLB flush, and is also safe with zap

rmap itself is a #1 page table walker, ie it gets the PTLs under
page_vma_mapped_walk().

The sin we have comitted here is that both the mmap lock and the PTLs
are being used to protect the page table itself with a very
complicated dual semantic.

Splitting the sleeping mmap lock into 'covers vma' and 'covers page
tables' lets us solve the lock ordering and semi-locked can become
more fully locked by the new lock, instead of by abusing mmap sem.

I'd suggest to make this new lock a special rwsem which allows either
concurrent read access OR concurrent PTL access, but not both. This
way we don't degrade performance of the split PTLs, *and* when
something needs to change the page table structure it has a way to
properly exclude all the #2 lockless readers.

So evey touch to the page table starts by obtaining this new lock,
depending on the access mode to be used. (PTL vs lockless read)

We can keep the existing THP logic where a leaf PMD can be transformed
to a non-leaf PMD in the semi-locked case, but the case where a
non-leaf PMD is transformed to a leaf PMD has to take the lock.

Jason
