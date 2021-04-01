Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C090350E52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhDAFE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:04:26 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:7760
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhDAFEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlIk0fYFpxSAKdZMPEhMoZ0aVNdQ51rjjYomm7qCQYgnBcrbw4fIdoPBGJRBqBaT/GZehUuI/jT5TXhTbBwAyBSjW/0GqZxHM0kjMCE1HPpED7dlHo43RPh5Wt3SqhfWDic+zCY6owcdVE0lALXGVzIRdAjSSzWae3XKQW/ufVH2quWwnsfhXGEYujkjiu1of9DXiBwwqjSjh978dmeJTQstq/YY5MbpS4VLNY9jgswkbt9GAtqldxQO2ssoktEqkSY4CrAg1m7vxwwGBN72NbU61oRmA8cJ0PJkQhnaMsgr0X+HdHGTuySO7xL/UGQTpe/FpEiVELZt84lBrqdo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPu6f0G6/Jfscqg4arDWLcuRUOFxVGIEI1sAXQhRMgg=;
 b=AeZsIACexYIyXLVLq7olzejwVDC7uN8af/MV6OnGVmJOMHN448iQAcbfonHUHHxqJvcA4GqkAdxc+L/5z4X4BYHZGA9XqpepQgFZ21+YulwUIkGEX3RA01ZOasdAh39bDM/Kn43rAhM7nQqoXpgQXMKu65j8nUeZl3TlFxCcHbMwJba3wS5nY7QlAApHm58CDcmyRJs3ilpUeGxLUf9oEAI1inpKhsAXy5UxZKHbS7JYXPibFvEFJj+1rlCHfdDZv2V+pWxOHqecEvZdVhWB1StMbDuRWpi+bOK7aUUskq3Yxpn1VdCsveDs4+fa3CyhuJ87Lqicpw8+jVp/LRZBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPu6f0G6/Jfscqg4arDWLcuRUOFxVGIEI1sAXQhRMgg=;
 b=XIcrvdlzYgfp/KuoSmLYqgGrB5V0qwXZ0GDelmRhCyQbbXZv8HJPnfX5aZT697s1/MldhnlWq38sQ5XXnCUXZHBwLWKItJ+9Fd+6cJ8Kdb9hg+wqqK5vlLFA3fPpV4iY60u1M84E2wd9uZAnT1q/t+dXJMYF7FBFlf/w10DEU1ibsu2uEpyclCcVx4GTIEsw2Ld7qPEeBW0pU5siw948diEoh3wr7z/Xv8NacJthataBmj7Lr7OlGfSGso1CNy07EiJT9hLb12RZstxYAjRaZ5onADdDcJZn5hJ/s9VeKNobdPJNABUL4bmN49eech6CJ+gRpe7d+6otPXtTvhmfhg==
Received: from MW4PR04CA0045.namprd04.prod.outlook.com (2603:10b6:303:6a::20)
 by BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Thu, 1 Apr
 2021 05:03:58 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::3b) by MW4PR04CA0045.outlook.office365.com
 (2603:10b6:303:6a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Thu, 1 Apr 2021 05:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 05:03:57 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Apr
 2021 05:03:55 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Muchun Song <smuchun@gmail.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <david@redhat.com>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>, <linux-mm@kvack.org>,
        <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] kernel/resource: Fix locking in request_free_mem_region
Date:   Thu, 1 Apr 2021 16:03:53 +1100
Message-ID: <5357782.nCMeKBJ0AR@nvdebian>
In-Reply-To: <CAPSr9jGNQ+cVMW12CDt3xTT4HJXDkxeqCTv5Gv=y4G-iRKEi=g@mail.gmail.com>
References: <20210326012035.3853-1-apopple@nvidia.com> <CAPSr9jGNQ+cVMW12CDt3xTT4HJXDkxeqCTv5Gv=y4G-iRKEi=g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19626c6c-2573-4e2a-d1a6-08d8f4cb8e8c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2791:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2791E48A054B14F022B79E1DDF7B9@BYAPR12MB2791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kqxntH1ZT9s0wTFLbwbl6aza+lafKfmmHZq3j7SKdnBvqSxESD8mvG8TgcseMatSkGrsoscVsf2d2p1D3r2tdQxG7RgrmjtPGF8TXd6ojqiX8zhvpY4ZAiqzUNpFrfkynunTXDhLIeLwJSmkGwDrgmwODfi9KuQmUD5WWvbKCvFONlbFMkgFGQjIL5v0tyDIoSa43YFnp0bzgieAEnGjNdjJQU2/IAmqobsiVwlVD3/AQKvenYkrFbvhyRp8GY3LIYgoW8tQpAKNzeaYEQg/08WJGDpyASmsVbUIUdPabTqvLCkCNNFCgM8NxnBPPdGvGOolb0UBs4mR0jY6hEd6xoYDBT8zBNn0tvtOhRNUuy8ajLDYeIY1Gpw43fjSawMKN22JRb1jEC1UkGa7+QceGlgIUKtLkTU/tfIDcRWnoCow+cdZrqvm+ImYH3Aj2xZzTkYwXrKR5NGPwxmHbwSFZ2gJjl3fKsvHITq+Rtj+KNluL2YyZa5rpV3OqJFx5RVCMWYwPz9GvXqlEIV94QdnVIml3Z7LPKjrYLA6kl9ZLAcPS6ujb7KBwLcg5z3PPdcJqDT6G8mdZbYOXoz3VWyJvz7do2Xi+WSzaylG40UMgmUU0DwPHwx1a8YPcPazLEliTU0wtTWywf/ni62PRvbD3CENjZFsilAJEgN87QOsKaHYP4sdEycU4VwbBSSVd3Lt5vI3S765T5QKkJx/w3o2H2ON4A5pmREdD67hmux7Nwflp3sxPoI5/Mp0hC/rOd2EYBaFz4CoCoUfXs9BWgZIA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(356005)(26005)(316002)(7636003)(36906005)(8936002)(33716001)(478600001)(6916009)(82310400003)(7416002)(47076005)(36860700001)(70586007)(86362001)(8676002)(83380400001)(426003)(4326008)(9686003)(336012)(53546011)(16526019)(54906003)(9576002)(2906002)(966005)(186003)(5660300002)(82740400003)(70206006)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 05:03:57.8747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19626c6c-2573-4e2a-d1a6-08d8f4cb8e8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 1 April 2021 3:56:05 PM AEDT Muchun Song wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Mar 26, 2021 at 9:22 AM Alistair Popple <apopple@nvidia.com> wrote:
> >
> > request_free_mem_region() is used to find an empty range of physical
> > addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> > over the range of possible addresses using region_intersects() to see if
> > the range is free.
> >
> > region_intersects() obtains a read lock before walking the resource tree
> > to protect against concurrent changes. However it drops the lock prior
> > to returning. This means by the time request_mem_region() is called in
> > request_free_mem_region() another thread may have already reserved the
> > requested region resulting in unexpected failures and a message in the
> > kernel log from hitting this condition:
> >
> >         /*
> >          * mm/hmm.c reserves physical addresses which then
> >          * become unavailable to other users.  Conflicts are
> >          * not expected.  Warn to aid debugging if encountered.
> >          */
> >         if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> >                 pr_warn("Unaddressable device %s %pR conflicts with %pR",
> >                         conflict->name, conflict, res);
> >
> > To fix this create versions of region_intersects() and
> > request_mem_region() that allow the caller to take the appropriate lock
> > such that it may be held over the required calls.
> >
> > Instead of creating another version of devm_request_mem_region() that
> > doesn't take the lock open-code it to allow the caller to pre-allocate
> > the required memory prior to taking the lock.
> >
> > Fixes: 0c385190392d8 ("resource: add a not device managed 
request_free_mem_region variant")
> > Fixes: 0092908d16c60 ("mm: factor out a devm_request_free_mem_region 
helper")
> > Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using 
ZONE_DEVICE")
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> +cc my email (songmuchun@bytedance.com).
> 
> Hi Alistair,
> 
> Thanks for your patch. But there is a deadlock that should be fixed.
> Please see the following scenario.
> 
> __request_region
>     write_lock(&resource_lock)
>         request_region_locked
>             revoke_iomem
>                 devmem_is_allowed (arch/x86/mm/init.c)
>                     region_intersects
>                         read_lock(&resource_lock)   // deadlock

Thanks for the report and apologies for the breakage. The kernel test robot 
caught it pretty quickly - see https://lore.kernel.org/linux-mm/
20210330003842.18948-1-apopple@nvidia.com/ for an updated version that fixes 
this.

 - Alistair

> >
> > ---
> >
> > v2:
> >  - Added Fixes tag
> >
> > ---
> >  kernel/resource.c | 146 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 94 insertions(+), 52 deletions(-)
> >
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 627e61b0c124..2d4652383dd2 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
> >  }
> >  EXPORT_SYMBOL_GPL(page_is_ram);
> >
> > +static int __region_intersects(resource_size_t start, size_t size,
> > +                              unsigned long flags, unsigned long desc)
> > +{
> > +       struct resource res;
> > +       int type = 0; int other = 0;
> > +       struct resource *p;
> > +
> > +       res.start = start;
> > +       res.end = start + size - 1;
> > +
> > +       for (p = iomem_resource.child; p ; p = p->sibling) {
> > +               bool is_type = (((p->flags & flags) == flags) &&
> > +                               ((desc == IORES_DESC_NONE) ||
> > +                                (desc == p->desc)));
> > +
> > +               if (resource_overlaps(p, &res))
> > +                       is_type ? type++ : other++;
> > +       }
> > +
> > +       if (type == 0)
> > +               return REGION_DISJOINT;
> > +
> > +       if (other == 0)
> > +               return REGION_INTERSECTS;
> > +
> > +       return REGION_MIXED;
> > +}
> > +
> >  /**
> >   * region_intersects() - determine intersection of region with known 
resources
> >   * @start: region start address
> > @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
> >  int region_intersects(resource_size_t start, size_t size, unsigned long 
flags,
> >                       unsigned long desc)
> >  {
> > -       struct resource res;
> > -       int type = 0; int other = 0;
> > -       struct resource *p;
> > -
> > -       res.start = start;
> > -       res.end = start + size - 1;
> > +       int rc;
> >
> >         read_lock(&resource_lock);
> > -       for (p = iomem_resource.child; p ; p = p->sibling) {
> > -               bool is_type = (((p->flags & flags) == flags) &&
> > -                               ((desc == IORES_DESC_NONE) ||
> > -                                (desc == p->desc)));
> > -
> > -               if (resource_overlaps(p, &res))
> > -                       is_type ? type++ : other++;
> > -       }
> > +       rc = __region_intersects(start, size, flags, desc);
> >         read_unlock(&resource_lock);
> > -
> > -       if (type == 0)
> > -               return REGION_DISJOINT;
> > -
> > -       if (other == 0)
> > -               return REGION_INTERSECTS;
> > -
> > -       return REGION_MIXED;
> > +       return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(region_intersects);
> >
> > @@ -1171,31 +1180,17 @@ struct address_space *iomem_get_mapping(void)
> >         return smp_load_acquire(&iomem_inode)->i_mapping;
> >  }
> >
> > -/**
> > - * __request_region - create a new busy resource region
> > - * @parent: parent resource descriptor
> > - * @start: resource start address
> > - * @n: resource region size
> > - * @name: reserving caller's ID string
> > - * @flags: IO resource flags
> > - */
> > -struct resource * __request_region(struct resource *parent,
> > -                                  resource_size_t start, resource_size_t 
n,
> > -                                  const char *name, int flags)
> > +static bool request_region_locked(struct resource *parent,
> > +                                   struct resource *res, resource_size_t 
start,
> > +                                   resource_size_t n, const char *name, 
int flags)
> >  {
> > -       DECLARE_WAITQUEUE(wait, current);
> > -       struct resource *res = alloc_resource(GFP_KERNEL);
> >         struct resource *orig_parent = parent;
> > -
> > -       if (!res)
> > -               return NULL;
> > +       DECLARE_WAITQUEUE(wait, current);
> >
> >         res->name = name;
> >         res->start = start;
> >         res->end = start + n - 1;
> >
> > -       write_lock(&resource_lock);
> > -
> >         for (;;) {
> >                 struct resource *conflict;
> >
> > @@ -1230,16 +1225,39 @@ struct resource * __request_region(struct resource 
*parent,
> >                         write_lock(&resource_lock);
> >                         continue;
> >                 }
> > -               /* Uhhuh, that didn't work out.. */
> > -               free_resource(res);
> > -               res = NULL;
> > -               break;
> > +               return false;
> >         }
> > -       write_unlock(&resource_lock);
> >
> >         if (res && orig_parent == &iomem_resource)
> >                 revoke_iomem(res);
> 
> What do you think of the fix below?
> 
> +       if (res && orig_parent == &iomem_resource) {
> +               write_unlock(&resource_lock);
> +               revoke_iomem(res);
> +               write_lock(&resource_lock);
> +       }
> 
> >
> > +       return true;
> > +}
> > +
> > +/**
> > + * __request_region - create a new busy resource region
> > + * @parent: parent resource descriptor
> > + * @start: resource start address
> > + * @n: resource region size
> > + * @name: reserving caller's ID string
> > + * @flags: IO resource flags
> > + */
> > +struct resource *__request_region(struct resource *parent,
> > +                                 resource_size_t start, resource_size_t 
n,
> > +                                 const char *name, int flags)
> > +{
> > +       struct resource *res = alloc_resource(GFP_KERNEL);
> > +
> > +       if (!res)
> > +               return NULL;
> > +
> > +       write_lock(&resource_lock);
> > +       if (!request_region_locked(parent, res, start, n, name, flags)) {
> > +               /* Uhhuh, that didn't work out.. */
> > +               free_resource(res);
> > +               res = NULL;
> > +       }
> > +       write_unlock(&resource_lock);
> >         return res;
> >  }
> >  EXPORT_SYMBOL(__request_region);
> > @@ -1779,26 +1797,50 @@ static struct resource 
*__request_free_mem_region(struct device *dev,
> >  {
> >         resource_size_t end, addr;
> >         struct resource *res;
> > +       struct region_devres *dr = NULL;
> > +
> > +       res = alloc_resource(GFP_KERNEL);
> > +       if (!res)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       if (dev) {
> > +               dr = devres_alloc(devm_region_release, sizeof(struct 
region_devres),
> > +                                 GFP_KERNEL);
> > +               if (!dr) {
> > +                       free_resource(res);
> > +                       return ERR_PTR(-ENOMEM);
> > +               }
> > +       }
> >
> >         size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
> >         end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 
1);
> >         addr = end - size + 1UL;
> >
> > +       write_lock(&resource_lock);
> >         for (; addr > size && addr >= base->start; addr -= size) {
> > -               if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> > +               if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> >                                 REGION_DISJOINT)
> >                         continue;
> >
> > -               if (dev)
> > -                       res = devm_request_mem_region(dev, addr, size, 
name);
> > -               else
> > -                       res = request_mem_region(addr, size, name);
> > -               if (!res)
> > -                       return ERR_PTR(-ENOMEM);
> > +               if (!request_region_locked(&iomem_resource, res, addr,
> > +                                                  size, name, 0))
> > +                       break;
> > +
> >                 res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> > +               if (dev) {
> > +                       dr->parent = &iomem_resource;
> > +                       dr->start = addr;
> > +                       dr->n = size;
> > +                       devres_add(dev, dr);
> > +               }
> > +
> > +               write_unlock(&resource_lock);
> >                 return res;
> >         }
> >
> > +       write_unlock(&resource_lock);
> > +       free_resource(res);
> > +
> >         return ERR_PTR(-ERANGE);
> >  }
> >
> > --
> > 2.20.1
> >




