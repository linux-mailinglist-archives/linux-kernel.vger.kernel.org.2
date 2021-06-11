Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF763A4780
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFKRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:11:20 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:48096
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229685AbhFKRLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:11:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+mF3U6nbGpG+0cBToApAnqASH9cLB+poGLD3LPOhEFV7M6Iob8doPz9cFZjphl//xj+HUTyAMVOYmD89egr4C+SmYT+ffJkfpSU+098/TvsC5eAFJS9/WwawphkZF6eMaSZgaHkmcdxnxonW2ks4QCs+krLCpieV9IpbGNrGTuq0d4kPSGHi7pziaNcT20C47s3s7akhKV4OglqgIvCsCQ6cdqnGB1/F3ERv9Mu4WLHSAIypmVlgSciU+Wka+NCHrlXrJIy4wHNhuNE9r9pyidlqDHFpiRCta3Otnb22AE8lPs7ZCQKtFxIBRDrFP2xW/PaRjiuxr+NPh3pn9bnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRo/X9411qMuvEae0vk8b9MIE0QT0JQ4M0U6oQjg2zY=;
 b=b2y6T+RfvrTjPMlK5CRTEYom4pzL3YGVNdMl9JyeBJk0TtZGVe2rJsXxi8Meuq4lgccY4uNpjZcaR5OEPt9c/65Q7uNiqIqKFuU8EBmc8WKIDhlplGlwqkC1WWPt0p1oliMio3iJMRl0eHXn/l5BIJrYwVBJcfD4MfIeNmRPTkNxr6QaikpBNut3+ZvLJYnfzBzrgpkdeeFVBocY8Iac3rZPsQM2kG2OM7fXY71Z/tsyD3fkli9tsHzmkatiEbZ01nMOwXu6YAMU1dkKuaWlaDsPR411nIrBHoma7e7BTzc8ja42+auFGZ8xSUvVUvtS4w7UXDibMgTAAKKqR8Ij8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRo/X9411qMuvEae0vk8b9MIE0QT0JQ4M0U6oQjg2zY=;
 b=OFAMDJWyOYfZ4GMXzIqU7NzLH0FQpnuJ8lmWq9uwvtNt8YWNpDw+JZEz86pWkTiHHKwGzCXf8gBdybxTNoCeNnpJKPiJ14Qa699j1dSsuSCbDgnKQvEyEN8QpUX58rR2EvT90w69BEkFvrCEslAQHaovtuhy0EvqoDi1RdvT+9RQtECAlxr+3I23o2sRJKLBGu0ikqNq1wr3Rl1BQZ9Z+3hUvWA8bA1QM0pg+mQG6C4zNLjoUtU37acY8VE1GUjpgDm2HzXfxlLzQ7hClhsqYt8Qqgak07JUgsmtWlN9xtxaWx+pWCOxdgVEcyT8b0c7GlMa1W8QDMg/ZLSXv/OoHg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 17:09:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 17:09:18 +0000
Date:   Fri, 11 Jun 2021 14:09:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm: relocate 'write_protect_seq' in struct mm_struct
Message-ID: <20210611170917.GW1002214@nvidia.com>
References: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR17CA0014.namprd17.prod.outlook.com (2603:10b6:208:15e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 17:09:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrkej-005h7p-7c; Fri, 11 Jun 2021 14:09:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba271ce3-1c72-42cb-fcc5-08d92cfba60b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320D55F2B680F75D6EB8C98C2349@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37w/+lrKCoSGKgQSfU/FkE9PdHXDBe+WKO0OMcrsskPY0mbbJoBvk9Ri7ID/xXssjx5eFtBVyLQz/1Hg41OypwV3lA/WhkufNcFeTuIsJiuKxrxuLVUDqfibgFi9eJj3OAfIB1dsgFZLftASheIzhwdvvXXgFrY9j6SwBRB2mWZJOZ8YGLpcw7CrPjelYQa9/Luj/jB9bpj1vZhY3v61QRsbyTzMOu9WaNPT1AiFpPL/uhKf3e921RqvWUs+qv7YzOirPloDV/XWIHRYH3+ifx0xW8i0sTMfeXqWMmplLnO4JY9bxtSKu0COlNaqFTtuGexDesqXICqE1ZY7trY2auZUpyh3eP+02H997UrEFC44fjt6tOLWNpn0ZeU2GP448QZOoix1ihUm0lCU6sr+jo1xYNN5uKiVLt6qd+aHIjgcaQwFycP1Ms6bDIpsNQEn+0Aj/qqBZZZbMwiguo4yeZwgJS0ng94klXavyQqLjKjP+iUKrwWoe2DLwcrKnurHX8tL+nr9PUYiPWfiSmhFVIok2B7v2EJeRztd1XwA0oYwbMaHXti4MUYcBULNHxYSp0mHJN6PpRykDdbTb5I/l79IXjV570aGG93Ngep/9tZtaay66m1++mo3ZStRmlxYRZMfS/iQ8HsArkwFqs/V7QVWUY7W+LFXlJy2DBKUKKZjsrBMBbdIEdYuuJV/iJf5Godm7YkPe85Ql73ZRy3ape8Hpp11NLCu+I4NAgg9Mje6jutWufrulDlZ9QofCn2WDVkMakVu66skqryhJ+Vflw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(83380400001)(9786002)(9746002)(4326008)(38100700002)(2616005)(316002)(2906002)(36756003)(966005)(426003)(26005)(6916009)(478600001)(186003)(8936002)(5660300002)(54906003)(8676002)(33656002)(1076003)(66946007)(66476007)(86362001)(66556008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mialFvDXpEZ/kLw5U0Hvkuk01anx3D9PJBVneTxBDUbgtg5dkWnCgy1u8cVa?=
 =?us-ascii?Q?ucdU+6vGbXc0v4faTwWqG8cGHPg23ujrYWZMRXU5/3a6jzDbk58ADxLv5EEc?=
 =?us-ascii?Q?GgffU1BD/7d+0cocDCCA7Z44NabS0IaPiS3UlkKPV/eBZDJEAg2IdqUdOiQ+?=
 =?us-ascii?Q?A4ti2CD9W+U2iGr91+X0OCSJyqF/zm7O3OrImRAZsG0X+BsZ6lkA3GXItH25?=
 =?us-ascii?Q?WExm3dj0zIFzvk0GZaZp+IjkRLdhp1RFK0wKfCot9nfdotXeS8qt+uola+QS?=
 =?us-ascii?Q?YGUvVi0MYezesi1WOAFAnpvLbWhXt9HPIZZKqaCWBEi8cF1L4IbxwiYRsrv8?=
 =?us-ascii?Q?w5E5UQ1JkhswwOgj6DOoK02F7gOKWxem1R9UULkudOOgFFAao/B/nWtCCgVq?=
 =?us-ascii?Q?R+hrB+Q2vL1CDSqRvhXmU4AbKLFgWWuSIxvj1RjKfsyXjQNTCyDpKBW+Bu+l?=
 =?us-ascii?Q?UH+V4KxtDJ9tjVrFnLEg+WUzscEWJUiJYfB8x3y7R2kKD4yD7BzmeYSn7Mlp?=
 =?us-ascii?Q?a5gHeIFW+pFZnGqSo4Y1L1vnHKxQAHTSac0KNdXpfarBdqYUuADKCWQXqqBm?=
 =?us-ascii?Q?GZO7KBRmkX05ESYBmqM+0izkjUG7zOD4Se4lfINKfwn9lH6bU5zopR+kgDpE?=
 =?us-ascii?Q?PfjdBHgi9+LjIg/jEItbflVEtUAn/Gi1Phz9kBQEWMA6ASIahPn4Jf7YiFlp?=
 =?us-ascii?Q?Wk+LSeC3Zzvz7JyzkHjMSHqbN1EB0oogrC/s5pyo/sLnT4pzjYeSnfuphS38?=
 =?us-ascii?Q?Dp4jWfxGmVFWx8ZoBihtmfh+hpxgZVYLtlAYvOX/P/xDYASJayzt1vdOsSF9?=
 =?us-ascii?Q?dg5XHbvxzKJXGM6UVCUItZLMqqFiRS3xqBEP/CFdQ3YeMjyobyUJwlV3+UyB?=
 =?us-ascii?Q?kzqDojBfA8Kht12zR90YbBK/Nk8Sfcf4hPkPvaBZUEGCYB+wTYsfLtYRI/lh?=
 =?us-ascii?Q?aLCJKFdywlXDlzgeJ8Bn/a3uExGPYbfJgAMsEBHxCaTq15y0KK6wKsTYiu5I?=
 =?us-ascii?Q?ZmpOwfoMaxngo1fb8X47ydBIcT00H4G7+U05At/bpMr0k9Avbf4mZCJDnNRz?=
 =?us-ascii?Q?qT1aCvFecubenmeFHCYAeU6bN6rQ5lTSTDh7mpHHRTAW3fN+u86NJMnYL7CJ?=
 =?us-ascii?Q?Xag83mti/rbRa1t8jeRwo2My1jYp0siPAzE9OykQHbCjOIJo3Fxnqg1AyWEt?=
 =?us-ascii?Q?kZtKL/inwB9kZqqd8ISOv7qs8cioS6FR86Vb2AN8F6p4IQ6lWwef4L8xK73q?=
 =?us-ascii?Q?/AHBlqR/bwQgDG0x4hNv1acA3+HihqupYHraoemYPzEbMgx01n8zvOwQeNTp?=
 =?us-ascii?Q?LLMkB31GLy9c7J8HsGnToP5P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba271ce3-1c72-42cb-fcc5-08d92cfba60b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:09:18.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M17st7DAvS8qREXzH4KXjZX9fbbl5qxxwZ4m8rI4oVEymSa6iQt3L9v6hMbrM+ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:54:42AM +0800, Feng Tang wrote:
> 0day robot reported a 9.2% regression for will-it-scale mmap1 test
> case[1], caused by commit 57efa1fe5957 ("mm/gup: prevent gup_fast
> from racing with COW during fork").
> 
> Further debug shows the regression is due to that commit changes
> the offset of hot fields 'mmap_lock' inside structure 'mm_struct',
> thus some cache alignment changes.
> 
> From the perf data, the contention for 'mmap_lock' is very severe
> and takes around 95% cpu cycles, and it is a rw_semaphore
> 
>         struct rw_semaphore {
>                 atomic_long_t count;	/* 8 bytes */
>                 atomic_long_t owner;	/* 8 bytes */
>                 struct optimistic_spin_queue osq; /* spinner MCS lock */
>                 ...
> 
> Before commit 57efa1fe5957 adds the 'write_protect_seq', it
> happens to have a very optimal cache alignment layout, as
> Linus explained:
> 
>  "and before the addition of the 'write_protect_seq' field, the
>   mmap_sem was at offset 120 in 'struct mm_struct'.
> 
>   Which meant that count and owner were in two different cachelines,
>   and then when you have contention and spend time in
>   rwsem_down_write_slowpath(), this is probably *exactly* the kind
>   of layout you want.
> 
>   Because first the rwsem_write_trylock() will do a cmpxchg on the
>   first cacheline (for the optimistic fast-path), and then in the
>   case of contention, rwsem_down_write_slowpath() will just access
>   the second cacheline.
> 
>   Which is probably just optimal for a load that spends a lot of
>   time contended - new waiters touch that first cacheline, and then
>   they queue themselves up on the second cacheline."
> 
> After the commit, the rw_semaphore is at offset 128, which means
> the 'count' and 'owner' fields are now in the same cacheline,
> and causes more cache bouncing.
> 
> Currently there are 3 "#ifdef CONFIG_XXX" before 'mmap_lock' which
> will affect its offset:
> 
>   CONFIG_MMU
>   CONFIG_MEMBARRIER
>   CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
> 
> The layout above is on 64 bits system with 0day's default kernel
> config (similar to RHEL-8.3's config), in which all these 3 options
> are 'y'. And the layout can vary with different kernel configs.
> 
> Relayouting a structure is usually a double-edged sword, as sometimes
> it can helps one case, but hurt other cases. For this case, one
> solution is, as the newly added 'write_protect_seq' is a 4 bytes long
> seqcount_t (when CONFIG_DEBUG_LOCK_ALLOC=n), placing it into an
> existing 4 bytes hole in 'mm_struct' will not change other fields'
> alignment, while restoring the regression. 
> 
> [1]. https://lore.kernel.org/lkml/20210525031636.GB7744@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm_types.h | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

It seems Ok to me, but didn't we earlier add the has_pinned which
would have changed the layout too? Are we chasing performance delta's
nobody cares about?

Still it is mechanically fine, so:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
