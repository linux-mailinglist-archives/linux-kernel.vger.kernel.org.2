Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B112737600A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhEGGIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:08:36 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:53703
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhEGGIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNtM4rZHBips78j6EVy6AwQFIg8RZJwNg9ghK++cW+tNaQ58r7KXcHyKvjsEr42LaG+s51BfCdymJ+9ithNPh26Tlw6kc2ahWjTU4WryxfAt15Xipang6J7L/zdKEBxWUwkj/R0fJzqMDkRqngV9n6FEkKprho0h8S5AAiDzDDDibeDx2N7vm+32u7soEv495vR3jJItZKDp/wrwtOtyERLizTNzhVTLWUNZuSIryNL+2W3ipQUaH+b33JkTRAxTgFsSoBTsiDwTSEQJU7pu7Rq8kTmNr+hFJhLivP9311PnFlLd+zp5fdA4usjX6smu5eU3QqDWblB5XRAEWOrR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCTBPDPX8/0vTAoGMcXmXpJy1gb3uaA63b9lgXF0qBE=;
 b=FPDA+lkOkd1zIfkcLdUVZy46I9N7ZwXpZvvW0fs5FgbPutRymX3AYOd99nKzOEvOihVtTQ7Zp7PuTBsLjC5ZAheeEoSwQ7jDc46t0J1sxL8P9I4EpiA7Y4Y7GkO0OlPqoZo3F3tVT8X0QQG5tonGmQuZMuBxRCkh/bb3cChl582nBlivMdUiZ187j+Bc4UkXuvgi59BlfbRjod04n+6h9tII87zQaIJkcNLBb1tFjwdCeFXgosEfIRHwny8RvI6A3VH36yMJkhLPanl2L8x8A9IXNiZT4ZGzB6QIJ7H96bYRC8Qz5FRrfzDgJtyUeelFHeiGb7eLZqPLdvi7QEX63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCTBPDPX8/0vTAoGMcXmXpJy1gb3uaA63b9lgXF0qBE=;
 b=quKCZP9mXDhpuex2jfB+VmRw5JwMvVyT9zM/RgIT9JzRxSa82m5CeQu6W3/GKVMydDSKbC8U40RdQhZ/BZI3I1mt/blgXQ38bDu5T3pcerU0VJ4rYR4xUslmw/o989wVYWRn7sHCSEJTprZybFWBWt8drlyxEpb0yFLPyBfcNzseJo/HIB993FmELQHt56b2ntjeVPogtemm5ygjawGkwG+xaPUaBLdoBKsxO/ZfbMzTDKChk3kRA9W2qC/7ZBTGIGx5mm81sJMyR/0X5JnGs0ooaqQvQ6wcLB18hVyJUpToNkOPdMod5WT+CG4d+XJq0cTMuG+Ofp72EWum4C3DEg==
Received: from DS7PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:3bb::15)
 by BN7PR12MB2628.namprd12.prod.outlook.com (2603:10b6:408:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 06:07:34 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::13) by DS7PR03CA0070.outlook.office365.com
 (2603:10b6:5:3bb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 06:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 06:07:33 +0000
Received: from [10.2.61.66] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 May
 2021 06:07:32 +0000
Subject: Re: [PATCH 2/3] mm: gup: allow FOLL_PIN to scale in SMP
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Michal Hocko" <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210506232537.165788-1-peterx@redhat.com>
 <20210506232537.165788-3-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a270cf3a-ffbf-de77-eff0-4a4da8864978@nvidia.com>
Date:   Thu, 6 May 2021 23:07:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210506232537.165788-3-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cee4b5af-8403-426d-80b1-08d9111e67b3
X-MS-TrafficTypeDiagnostic: BN7PR12MB2628:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2628F67D87B3EFBE7D1E7596A8579@BN7PR12MB2628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOju0rEScSMpNo164GuHVVB2RFkB9yWhd0+fiGpHqeOJAM4MaF7N6xXnBpJ8yqgL3cu8eQnjI8A5LHBmjdxHtAYDgzDQWjvcH7DvHB9o56vObJtDmadqQzZqX8aS6aVa5KLxCaCqvEoto0AjApAPNm00DaEDP12LGUEbtPMMGsyHZ8u+PU+ZIl+Pb5cmCF1dFzzPG6DJO2dd0f29nLRQb48+bfBpPG2HzOk/BYgvHSHoxE6kO64CWObgTGZWvVy3/ReuvfY4Ve/KfkEGRLPDgeqfiJtse1XPbmhW1PkEy0SmF+GTh2FRNdgC+VGUH31JZJfdlq8MJNf+A6wSb9mqHmwVnOO88ZecpPhwxxsJT/THmLStlWAIxRjuuWi24cVSUZS/1YL3hYKia5Q96zjIyaU/xUccAnpKZuTAuo9i1jxyqdNbNOaEb93RUUOz9MAxL5Pu0+lmaVIcIzj3z/5VybVhHJaphgr8l93ZDNvtae8UZqk/H1JizEtprehwzJtT/PQ/NxrlngVdhiuBRy7x7X4j+RsZNFI4iQCNQpeuDCGDEt1UrjpaOV4qZChwi3vc9sPPQBsJOE8Iw8bM283E1qfjvNqHlHcJSOlbyDGJbXzAiSSzH7Cnj0WnNHfhXkCU+JPT7VWa/QJM0/wAIXaTn69BYmaQiUFDVSYLcD4I0gDuTIh166hsneBRlnCgICk8ZAQflrLWX6sKZtYKKqO0fA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(4326008)(86362001)(31686004)(47076005)(356005)(2906002)(70586007)(186003)(110136005)(8936002)(5660300002)(316002)(16576012)(26005)(31696002)(82310400003)(8676002)(83380400001)(53546011)(54906003)(7636003)(478600001)(7416002)(82740400003)(36860700001)(16526019)(36906005)(426003)(36756003)(336012)(2616005)(70206006)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 06:07:33.5034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee4b5af-8403-426d-80b1-08d9111e67b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/21 4:25 PM, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> has_pinned cannot be written by each pin-fast or it won't scale in
> SMP. This isn't "false sharing" strictly speaking (it's more like
> "true non-sharing"), but it creates the same SMP scalability
> bottleneck of "false sharing".
> 
> To verify the improvement a new "pin_fast.c" program was added to
> the will-it-scale benchmark.
...
> 
> This commits increases the SMP scalability of pin_user_pages_fast()
> executed by different threads of the same process by more than 4000%.
> 

Remarkable! I mean, yes, everyone knows that atomic writes are
"expensive", but this is a fun, dramatic example of just *how*
expensive they can get, once you start doing contended atomic writes.


Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Other notes, that don't have any effect on the above reviewed-by
tag:

On the commit log, I will add a "+1" to the idea of deleting the
pin_fast.c contents from the commit log, and just providing a URL
instead. No need to put C programs in the commit log, IMHO, especially
when you have them elsewhere anyway.


thanks,
--
John Hubbard
NVIDIA


> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   mm/gup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 63a079e361a3d..8b513e1723b45 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1292,7 +1292,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   		BUG_ON(*locked != 1);
>   	}
>   
> -	if (flags & FOLL_PIN)
> +	if (flags & FOLL_PIN && !atomic_read(&mm->has_pinned))
>   		atomic_set(&mm->has_pinned, 1);
>   
>   	/*
> @@ -2617,7 +2617,7 @@ static int internal_get_user_pages_fast(unsigned long start,
>   				       FOLL_FAST_ONLY)))
>   		return -EINVAL;
>   
> -	if (gup_flags & FOLL_PIN)
> +	if (gup_flags & FOLL_PIN && !atomic_read(&current->mm->has_pinned))
>   		atomic_set(&current->mm->has_pinned, 1);
>   
>   	if (!(gup_flags & FOLL_FAST_ONLY))
> 

thanks,
-- 
John Hubbard
NVIDIA
