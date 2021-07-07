Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32BE3BF255
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGGXQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:16:55 -0400
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:41449
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhGGXQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azigrMnSO0kRoh5eTdhX5zjHq7K/F+ZTWgj5ZNHeUmQGXCYut+mvXVBV4wVQ0/+OxnbCtgH0PPGw75SMqrx9C5/eK6z8O2YmSZQiqNUwpwyiEWZyFxsE2hJMz2UfJzEIn5bQKRtjo2jAIU9y20YQ7H3WVinUD0jIFTx8jedQsdvysWabZES7h3NIJJnTdiDYJI7pIjQBvCx3SSnf47GBHtiZlYJUBYQ255qFdw4WlydoR/nezUIQU1TkZy+jLY0NqHYYbrd7VeBS9X03zfkadYAEK8NUxBRb6cfopASa2yPZcUD0B97Nuri2G8evFDD8BJEcmVzr7fxeWzRleF82Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkA1cnZkfDDGC/9hJ5nMoBPj6iSQNRssCXASm7lWqUE=;
 b=g3Ml15DPoE6CmvlpAO2vqhob/rexWEp5N7lU6xjxsJII/ZMgMtXnBfytsU/ERaSqDKPeNl0XVkG/f/74viZDSkB3EoMmeQNfQ0rIoWDXIjnhzN1FmjXWZimsxWZQXY+/22ZMHnTqiPJfTZL3sxrQ8BIlALOE1VnukVCjNAbS/CY5/sNTX6DXV9OK6HlONIM8UxQ9hDtgSqwePHbG96eWYsBJ8lisJKxNkMIC/+C5fqokAaOI88bacvtih5lHobGETmNh7TjitYxGNtq/pV3t5UbpwlNlf8AV1jljzgyBglgC/QJ0UNGk2zgxz4SiNCwdvYln2I5GH91dqBnjMdRzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkA1cnZkfDDGC/9hJ5nMoBPj6iSQNRssCXASm7lWqUE=;
 b=Z+L4taMq/7BxGxc/U6PtEu+DNEeNM7QClDo9qDYX/nwKBszmks/437OJ95qYW/ajUC1iitrqvUfo6WOUwh8VSpru9yHq3V6k11r+zTafFWTrzKJQfGdFjk+BnMvyyksyqLBpYVtIZVWxmV1ksbSEqd/On/GRQ+44AhZ3hSQuagakHiPSUnrH3ulxfsw9323ehU+j+h4tjuAJeE3TFlWmOWk58+zONYX5CMhue7jt/OtnNwInsmSpB++kLTfggXORXkNLAqwE2k0+F0UdaHHv4X++JzorO3MgP+p8wYZNXrlz+yT+Yn6Idx7/cPxwD6tGG5MrIJy36l8TIuXIXzjcpw==
Received: from MWHPR17CA0068.namprd17.prod.outlook.com (2603:10b6:300:93::30)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 23:14:08 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::ac) by MWHPR17CA0068.outlook.office365.com
 (2603:10b6:300:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 23:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 23:14:07 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul
 2021 23:14:05 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] mm/rmap: fix new bug: premature return from page_mlock_one()
Date:   Thu, 8 Jul 2021 09:14:03 +1000
Message-ID: <5771626.u1GIez9f9F@nvdebian>
In-Reply-To: <f71f8523-cba7-3342-40a7-114abc5d1f51@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <f71f8523-cba7-3342-40a7-114abc5d1f51@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 738e14d1-5cea-4225-94ec-08d9419cebfc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1433A38FDA0AAD7176C78D26DF1A9@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHhyHE1SSN4Z0yvif5hHsRvnIm4ZjCSIjw2R7n9C+DrS27gGWsJwnX41Sxfcrrs2/XBTSIqZF8ZwncIxueMlynpNSU968XXMDEWybplx2Mup+muKcd+I2BCjvReh9iw0802xd8zZsKlzfGZkiurEgnL/hqfPRuO4x5E9Eb54vEnxnAL5vVCrC/skR/frRZ5uEPlQ3/HLEL3GOdLUs5rkGIckEptZcDcmB8Epcgt94at64CpXdLNQ6v4jSjZHUkBqf/XKIgimiXNv9nIuEa+ZZciM03Padyk+KXldOyUnah6VRB8/jMCKNvq+zXmjiQC9VG39H3q9NNM1FmLfmlVRx6hCvj1FN8Qc2Ydvn0CyliFzM/18B96gTAC2t/rBLZ0ajEA8D/voRSsnF4LY3cFu2lW6zSZhAL+4i2XwLiS8FNm/siLrrQ8WMcD8FchROtYqquAane/f2SqSFkrAwsslBh/to3TGfiBKWN6ZQy4pO1mgZLXYp3mZ0y2tdd3fSa8XP8EtSX9oPvpQB4DdjoWRLpcowniUSdsuiERgJ6Hk8dM5kAPVpu4XglgbAUgwaVdN1Sx42yc0GGa3H08HeWwDRF4KBf3aO3vLeEoHm6B0rjWLyzKYFpBsMFaF1rbBu8C7WLOiCg3UUhAod5UORJ6qn6HOe+kIXXAI6Maq0JsR0qjbHuaZ+JH8nWZJ3jBTA8p6E2nZaEVOWVcBVd9784ETIVBIn4Ic713uglPKOIWxCyI=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(36906005)(356005)(6916009)(16526019)(7636003)(8676002)(426003)(47076005)(70206006)(316002)(2906002)(4326008)(336012)(70586007)(5660300002)(36860700001)(9576002)(82310400003)(83380400001)(54906003)(82740400003)(478600001)(86362001)(9686003)(186003)(26005)(33716001)(8936002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 23:14:07.8708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738e14d1-5cea-4225-94ec-08d9419cebfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hugh, evidently I missed this when re-adding the VM_LOCKED check
back.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Thursday, 8 July 2021 6:11:24 AM AEST Hugh Dickins wrote:
> In the unlikely race case that page_mlock_one() finds VM_LOCKED has been
> cleared by the time it got page table lock, page_vma_mapped_walk_done()
> must be called before returning, either explicitly, or by a final call
> to page_vma_mapped_walk() - otherwise the page table remains locked.
> 
> Fixes: cd62734ca60d ("mm/rmap: split try_to_munlock from try_to_unmap")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/rmap.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0e83c3be8568..1235368f0628 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1990,14 +1990,13 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
>  			 * this function is never called when PageDoubleMap().
>  			 */
>  			mlock_vma_page(page);
> +			/*
> +			 * No need to scan further once the page is marked
> +			 * as mlocked.
> +			 */
>  			page_vma_mapped_walk_done(&pvmw);
> +			return false;
>  		}
> -
> -		/*
> -		 * no need to continue scanning other vma's if the page has
> -		 * been locked.
> -		 */
> -		return false;
>  	}
>  
>  	return true;
> 




