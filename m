Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D303A151D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhFINIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:08:54 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:31265
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230261AbhFINIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE/TN+DLt9Vg29AeScZ4olbPvwSLJPlsjeX4coCqMKSOSn+3QPxy44P8Fv74zdJup+aSK1jOZfYy8BNFd3B3AjhinJ6hjSIBQKyeHlS+gaooN7W9QAQCVVG+hZF3060RikTzC/0r8QhjlT6l34XyO9v/p2pKYP1QZ2E5b9auQz3GSn61Dxt3URRB510UvG5XPKA/89uaXA88lI5FRp0030u7LVjClWKj3S0SelmBsgTQuQFNvZ10J++Cv3VacKe70x4maBSfOin74RS5/HTuEjidzrSzep6XzoGy0eimqp8fnk1cvM0kTyJZfN+FKzQo9WrSfYYvG24DJ04rK5aZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpotUobflb9T+6yJuYhamxp8vBiqcxVKvb8Yofqt0Ug=;
 b=VYT8c1XvlHuwA/c/ekB3FQXyzPGEwx9QH9C9vVSd2R898kCbFBZ9U+VDVwW1zDneVDhKWThIrP/YibpFlN8EOWHvOP6cvIl2XkWmm5oncgY5xzrKHVyYpfPw2sf/4bLUqzSOm1vChkv5lU6SeOPs2WgR/x0fzG8N8EMWWMicm/+N8KRj6qfNm7t9cJ5ylUIt0PCdgYFnWg9w00NBZzaYqZpsfLtBYq92WM2sTHQDmX/lwhvEytnnRu8H0xcO7Mkcuh+aKodpIayIL+A4HCMCYDuhKaj/2ONn10KjpnVqobe8Jr8g7G3sLjkeJA6x8e8MQpKALO2PcoGW0Zm6ojvbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpotUobflb9T+6yJuYhamxp8vBiqcxVKvb8Yofqt0Ug=;
 b=HimHTXX2Co3in7ApaSw5q/Ro7+zAJn37mY/agKKfvm9IBLSO+liy8qpkCaKi+6yRq00Ld6v7MsvSOqsj0h8RvALWRuDkru7S4Mr7KmxNUz+ulBZ/h5zxjsYbMqEt8eXqvxuu0tVDXTBt55YF68NCFFi4cstEb4yYpvw2/p2kE6dEyxKiAPrj34TF6EZLFF+GlMWeaVQeLxXCFS1D3px3HiWP4AS3aXyXcKax8K3g0r0GM+5kLanhKy3nXsBuH4ARuNj8sTvzqXXsf1TboOdAg4dgQmSniPQ6GB9KwyLDDgyJHqY+sUF/2+EYVzp+6zRjMMx6KdNRdCfbcOJS9z+Zcg==
Received: from DM5PR1401CA0012.namprd14.prod.outlook.com (2603:10b6:4:4a::22)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 13:06:57 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::f1) by DM5PR1401CA0012.outlook.office365.com
 (2603:10b6:4:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 13:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 13:06:56 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 13:06:35 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for unmapped file-backed mem
Date:   Wed, 9 Jun 2021 23:06:32 +1000
Message-ID: <2227669.OCfziWJ48r@nvdebian>
In-Reply-To: <20210527201927.29586-5-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527201927.29586-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7212b9d-5714-46ca-9980-08d92b4775ee
X-MS-TrafficTypeDiagnostic: BN9PR12MB5323:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5323041FFD67CB6084B68D4ADF369@BN9PR12MB5323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chbxAz+AItrU+daO7XAOyn0K5tERcEhW6ojYuft/7+iv04Ohm1c9Ae1kA5PivyJt2ScD+xQ3HvbNJ29XNibl/4gJS5km1+bd0NiYGc4/PDuG93k/5vx6L9ra5wg1feifKxd0hOtCWkIx2+KY39qqWNNn/rznWmWXPk/wO9Iy1T4ds1FnPyQSXRx/1pXQSTn+v22uGXnUuDtHv1o1EIOPCPcUbvYyoJv+SY4BugwD5hl+/rD3S+MxxqdWMpNA67j51I3pYKBX/cm8HsOWfNc8hyFcwuOlKzmvPgBtgBkyh01mU5e/jkgfm4Mts0y9Cug0qlh3WMgkHP5bD0mSeGl3uSYcnlQREDkw05MP6NzqhFWPeiRgYaXkpHCUqnHCIZf9W0RkY/+ab7skaGksdq5uDHZh+7J+p4llaLKmM6PDGVjhGlzEg7rNQmGjRL17cbEJ2bzEeEXm00KNvUhKBjNgYxZizO5O11D4RoXW2mNsO4pTxHsMxTuhzD3lJVGDiUdho1SOjpSDmgL0hzPp15HWB8D9qjm6nX78GJWrf1uQ6/Y6cILOBjAnxPDBmQI2Kb1NVObFQUAlL4MNkH6KEkggLyVFO9ifv1DpJBLPqnMekuhmBjPjzlZicygvWGcvFS2FLEdpdV9XwmlW/i4LYc7+jMhdrZOQWK0GuptpnygX6YwbOfMAShOIQIWG01Gko+cZ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(316002)(7416002)(86362001)(70206006)(36906005)(4326008)(36860700001)(26005)(16526019)(356005)(6666004)(82310400003)(70586007)(54906003)(5660300002)(6916009)(9686003)(83380400001)(7636003)(8676002)(8936002)(478600001)(33716001)(82740400003)(186003)(47076005)(2906002)(336012)(9576002)(426003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 13:06:56.9869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7212b9d-5714-46ca-9980-08d92b4775ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:

[...]

> diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
> index 828966d4c281..95e9811ce9d1 100644
> --- a/include/asm-generic/pgtable_uffd.h
> +++ b/include/asm-generic/pgtable_uffd.h
> @@ -2,6 +2,9 @@
>  #define _ASM_GENERIC_PGTABLE_UFFD_H
>  
>  #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +
> +#define  UFFD_WP_SWP_PTE_SPECIAL  __pte(0)
> +
>  static __always_inline int pte_uffd_wp(pte_t pte)
>  {
>  	return 0;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 331d2ccf0bcc..93f932b53a71 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -145,6 +145,17 @@ extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
>  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  				       struct list_head *uf);
>  
> +static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
> +{
> +	WARN_ON_ONCE(vma_is_anonymous(vma));
> +	return UFFD_WP_SWP_PTE_SPECIAL;
> +}
> +
> +static inline bool pte_swp_uffd_wp_special(pte_t pte)
> +{
> +	return pte_same(pte, UFFD_WP_SWP_PTE_SPECIAL);
> +}
> +

Sorry, only just noticed this but do we need to define a different version of
this helper that returns false for CONFIG_HAVE_ARCH_USERFAULTFD_WP=n to avoid
spurious matches with __pte(0) on architectures supporting userfaultfd but not
userfaultfd-wp?

>  #else /* CONFIG_USERFAULTFD */
>  
>  /* mm helpers */
> @@ -234,6 +245,16 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  {
>  }
>  
> +static inline pte_t pte_swp_mkuffd_wp_special(struct vm_area_struct *vma)
> +{
> +	return __pte(0);
> +}
> +
> +static inline bool pte_swp_uffd_wp_special(pte_t pte)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_USERFAULTFD */
>  
>  #endif /* _LINUX_USERFAULTFD_K_H */
> 




