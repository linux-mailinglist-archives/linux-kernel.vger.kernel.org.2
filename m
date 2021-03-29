Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC534C185
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhC2Bzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:55:54 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:29692
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230039AbhC2BzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:55:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVOWKrb3VETlDxlgvZ4KVKdtAfbGKVOXoP53pi72qZIul+DOnPBIY9Ah923ZTWni+FLicrt97ro0I4NB45TABHKVUOPhiq1SZcMnMr433L/5Nd9fPwqxSNv2SmDYBYXthuN1w4gG/ghr2NuuUb3ygrUKj/OrwJmAPxFBoCrgbUxNbmIqzBKypHO6TyQXKR84V4kPcgk84soe65ypCkY0QlB0VH76rlhKj2rLWQfdHAi9qo6akT9GMBRZyf8797ggLHdXOR9AqgnXHXBDRbg1a6cdViH1kiLqaMxZeIFCTzzXE4hc4SFCiGAQR412G6MRX/k1JAu3QTiLt+aLAwNo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKC2qvIHV8cF7aT7GrfTdCUcZQvYiqQpGY3Ju8K0u40=;
 b=HqF1k6k1ka6vnzz2TYPzCYSd88GCBVNuzcaQsEYsj7gQeSSGXPErYND3CeRjY+Pnq25/kAztsnoToCxltMOC66vABn6Sm5a2Fj579LA/dv47AYsatH94Z6oFJeMRiwXjbfeVsdeNH/yG26f8yzuY0vnk6zg5MlsPtQtLIBsjV0V4+NiOBUhmYFEnumuj/znCdPslvcEiQPG2s1g8H3Yi7cEeh428Bf/Yzpe3EvZmNIUiJa469SnpDrBBCHAalOD/aee1QiJIVZTpqxRy/nP4SsS64AQqPX2QxUoaRNl+AQAeWSgpawm3MSNupTZ+XmMF6srxExUar69SYTc9T3g2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKC2qvIHV8cF7aT7GrfTdCUcZQvYiqQpGY3Ju8K0u40=;
 b=I2Yd9aCrOcZO7duPcawcml7w2muY66KIwlkulyKdwAggN5g08sTVJF1xxPjUkcwwDw/M72k+PXxrUOYle3oPNB3ATkdgAe4oyLR/sbRlUddEsybgS+GdQPednGUWthVhrfJ3zO0SOi+y78DIaZ9YgtO1XydgZ7mIA4GJ8aFTRodMlwW/wqIFPKScHfxtphqy41OxXMHY8LBenZTSL65n/Yw6UqCYVlDs1d8cgeU/eR5cmmyrh8oA0xK2wNq2tgvIiiQgsJedD5jI4LSV2DKP3deYK2sNmD1HerscU5/zU1k5mBtImihuTgWarrspgF84/mmuVggSQuPL7qLiATM+Bg==
Received: from BN6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:405:2::24)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Mon, 29 Mar
 2021 01:55:21 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::a4) by BN6PR11CA0014.outlook.office365.com
 (2603:10b6:405:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Mon, 29 Mar 2021 01:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 01:55:20 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Mar
 2021 01:55:17 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Balbir Singh <bsingharora@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jhubbard@nvidia.com>, <jglisse@redhat.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] kernel/resource: Fix locking in request_free_mem_region
Date:   Mon, 29 Mar 2021 12:55:15 +1100
Message-ID: <2574877.iCKU5I5uxK@nvdebian>
In-Reply-To: <20210326051536.GN77072@balbir-desktop>
References: <20210326012035.3853-1-apopple@nvidia.com> <20210326051536.GN77072@balbir-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de2c259c-abf9-4e04-d975-08d8f255b59b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3771E69254F8D244267E1DC3DF7E9@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtUS0D6Ya9tzSWunXEQK16EjmsAP7eJbIZHlWiTccz445y37+GLXLcq8KI+JvQHeJ8n1kO550ex/qZVVgBhho8Yb2titMghDBDo3uTcr0NIi9UdHsAtoDsWOdUp3ADqwSk6YOdLCXVKXkovH3zhvYO+6CfTICRnu7OaFeR5L/ijyyfF1TMl3qK4IkePOIf6ZGdWMrZmyeCpMhFWZa/Mjlg8vyHqmCAaxzGQVRVnD44ZO1OozmNH+fPDc26l7eB8xtfMjsZ+/+wiiPf+smsxfPD0UmVT1Wr4djmLEkBR7rleQ+0GrBxoBx5OYPKEypNwtLie0KwdXOEmTocKerV1rf0C3ee02X9Vgu8nTiFrYMjw6UpdgQUE2szXZ6IdNjz7qfbCt8RH5SJEOL173XyPJiIEH3zyD6St2UBoac79w2MxM2rg9lhzsDeLtUOIsQpCfdljImEB9H8IB0tvc2V8Vj3S/sZR7Z/xC3M+VZKhV6Cx7yD8hBp3ELsK7GV89vfMot49Dyc+q4XROXe80cwTMdrBRgb51xCiRHTXR+F2+Y9+3+dpSIbGXER02la1nOtn2l6qvPWBPPWu2vegSIa6hz7d8q73Z4WBx10dSjOLFrwcaIhSGU1AQDcOqGY+qR9lmfZOVxEFwAV68NpVbLHn6zsERx1PTckOvDRgbIWFCSXjrbHravN/7HaDtxtrPdlOo
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(70586007)(36860700001)(6916009)(82740400003)(70206006)(47076005)(33716001)(82310400003)(26005)(426003)(186003)(2906002)(16526019)(9686003)(54906003)(8676002)(4326008)(316002)(9576002)(36906005)(356005)(83380400001)(478600001)(7636003)(5660300002)(8936002)(86362001)(336012)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 01:55:20.3608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2c259c-abf9-4e04-d975-08d8f255b59b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 26 March 2021 4:15:36 PM AEDT Balbir Singh wrote:
> On Fri, Mar 26, 2021 at 12:20:35PM +1100, Alistair Popple wrote:
> > +static int __region_intersects(resource_size_t start, size_t size,
> > +                            unsigned long flags, unsigned long desc)
> > +{
> > +     struct resource res;
> > +     int type = 0; int other = 0;
> > +     struct resource *p;
> > +
> > +     res.start = start;
> > +     res.end = start + size - 1;
> > +
> > +     for (p = iomem_resource.child; p ; p = p->sibling) {
> > +             bool is_type = (((p->flags & flags) == flags) &&
> > +                             ((desc == IORES_DESC_NONE) ||
> > +                              (desc == p->desc)));
> 
> is_type is a bad name, are we saying "is" as in boolean question?
> Or is it short for something like intersection_type? I know you've
> just moved the code over :)

Yeah, I'm not a fan of that name either but I was just moving code over and 
couldn't come up with anything better :)

It is a boolean question though - it is checking to see if resource *p is the 
same type (flags+desc) of region as what is being checked for intersection.
 
> > +
> > +             if (resource_overlaps(p, &res))
> > +                     is_type ? type++ : other++;
> > +     }
> > +
> > +     if (type == 0)
> > +             return REGION_DISJOINT;
> > +
> > +     if (other == 0)
> > +             return REGION_INTERSECTS;
> > +
> > +     return REGION_MIXED;
> > +}
> > +
> >  /**
> >   * region_intersects() - determine intersection of region with known 
resources
> >   * @start: region start address
> > @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
> >  int region_intersects(resource_size_t start, size_t size, unsigned long 
flags,
> >                     unsigned long desc)
> >  {
> > -     struct resource res;
> > -     int type = 0; int other = 0;
> > -     struct resource *p;
> > -
> > -     res.start = start;
> > -     res.end = start + size - 1;
> > +     int rc;
> >
> >       read_lock(&resource_lock);
> > -     for (p = iomem_resource.child; p ; p = p->sibling) {
> > -             bool is_type = (((p->flags & flags) == flags) &&
> > -                             ((desc == IORES_DESC_NONE) ||
> > -                              (desc == p->desc)));
> > -
> > -             if (resource_overlaps(p, &res))
> > -                     is_type ? type++ : other++;
> > -     }
> > +     rc = __region_intersects(start, size, flags, desc);
> >       read_unlock(&resource_lock);
> > -
> > -     if (type == 0)
> > -             return REGION_DISJOINT;
> > -
> > -     if (other == 0)
> > -             return REGION_INTERSECTS;
> > -
> > -     return REGION_MIXED;
> > +     return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(region_intersects);
> >
> > @@ -1171,31 +1180,17 @@ struct address_space *iomem_get_mapping(void)
> >       return smp_load_acquire(&iomem_inode)->i_mapping;
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
> > -                                resource_size_t start, resource_size_t n,
> > -                                const char *name, int flags)
> > +static bool request_region_locked(struct resource *parent,
> > +                                 struct resource *res, resource_size_t 
start,
> > +                                 resource_size_t n, const char *name, int 
flags)
> >  {
> > -     DECLARE_WAITQUEUE(wait, current);
> > -     struct resource *res = alloc_resource(GFP_KERNEL);
> >       struct resource *orig_parent = parent;
> > -
> > -     if (!res)
> > -             return NULL;
> > +     DECLARE_WAITQUEUE(wait, current);
> 
> This part of the diff looks confusing, do we have a waitqueue and we call
> schedule() within a function called with the lock held?

Good point. schedule() does get called but the lock is dropped first:

		if (conflict->flags & flags & IORESOURCE_MUXED) {
			add_wait_queue(&muxed_resource_wait, &wait);
			write_unlock(&resource_lock);
			set_current_state(TASK_UNINTERRUPTIBLE);
			schedule();
			remove_wait_queue(&muxed_resource_wait, &wait);
			write_lock(&resource_lock);
			continue;
		}

This isn't an issue though as it's only used for request_muxed_region() which 
isn't used for the ZONE_DEVICE allocation and by design doesn't search for 
free space. Ie. IORESOURCE_MUXED will never be set for 
request_free_mem_region().

> >
> >       res->name = name;
> >       res->start = start;
> >       res->end = start + n - 1;
> >
> > -     write_lock(&resource_lock);
> > -
> >       for (;;) {
> >               struct resource *conflict;
> >
> > @@ -1230,16 +1225,39 @@ struct resource * __request_region(struct resource 
*parent,
> >                       write_lock(&resource_lock);
> >                       continue;
> >               }
> > -             /* Uhhuh, that didn't work out.. */
> > -             free_resource(res);
> > -             res = NULL;
> > -             break;
> > +             return false;
> >       }
> > -     write_unlock(&resource_lock);
> >
> >       if (res && orig_parent == &iomem_resource)
> >               revoke_iomem(res);
> >
> > +     return true;
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
> > +                               resource_size_t start, resource_size_t n,
> > +                               const char *name, int flags)
> > +{
> > +     struct resource *res = alloc_resource(GFP_KERNEL);
> > +
> > +     if (!res)
> > +             return NULL;
> > +
> > +     write_lock(&resource_lock);
> > +     if (!request_region_locked(parent, res, start, n, name, flags)) {
> > +             /* Uhhuh, that didn't work out.. */
> > +             free_resource(res);
> > +             res = NULL;
> > +     }
> > +     write_unlock(&resource_lock);
> 
> Should the function be called __request_region_locked?

This is the name of original function, so this is just maintaining the 
original behaviour by taking the lock and calling the inner function 
(request_region_locked) rather than having it coded directly there.

__request_region() is rarely called directly and is mostly called via macros:

include/linux/ioport.h:#define request_region(start,n,name)             
__request_region(&ioport_resource, (start), (n), (name), 0)
include/linux/ioport.h:#define request_muxed_region(start,n,name)       
__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
include/linux/ioport.h:#define __request_mem_region(start,n,name, excl) 
__request_region(&iomem_resource, (start), (n), (name), excl)
include/linux/ioport.h:#define request_mem_region(start,n,name) 
__request_region(&iomem_resource, (start), (n), (name), 0)

Thanks,

 - Alistair

> >       return res;
> >  }
> >  EXPORT_SYMBOL(__request_region);
> > @@ -1779,26 +1797,50 @@ static struct resource 
*__request_free_mem_region(struct device *dev,
> >  {
> >       resource_size_t end, addr;
> >       struct resource *res;
> > +     struct region_devres *dr = NULL;
> > +
> > +     res = alloc_resource(GFP_KERNEL);
> > +     if (!res)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     if (dev) {
> > +             dr = devres_alloc(devm_region_release, sizeof(struct 
region_devres),
> > +                               GFP_KERNEL);
> > +             if (!dr) {
> > +                     free_resource(res);
> > +                     return ERR_PTR(-ENOMEM);
> > +             }
> > +     }
> >
> >       size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
> >       end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 
1);
> >       addr = end - size + 1UL;
> >
> > +     write_lock(&resource_lock);
> >       for (; addr > size && addr >= base->start; addr -= size) {
> > -             if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> > +             if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> >                               REGION_DISJOINT)
> >                       continue;
> >
> > -             if (dev)
> > -                     res = devm_request_mem_region(dev, addr, size, 
name);
> > -             else
> > -                     res = request_mem_region(addr, size, name);
> > -             if (!res)
> > -                     return ERR_PTR(-ENOMEM);
> > +             if (!request_region_locked(&iomem_resource, res, addr,
> > +                                                size, name, 0))
> > +                     break;
> > +
> >               res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> > +             if (dev) {
> > +                     dr->parent = &iomem_resource;
> > +                     dr->start = addr;
> > +                     dr->n = size;
> > +                     devres_add(dev, dr);
> > +             }
> > +
> > +             write_unlock(&resource_lock);
> >               return res;
> >       }
> >
> > +     write_unlock(&resource_lock);
> > +     free_resource(res);
> > +
> >       return ERR_PTR(-ERANGE);
> >  }
> >
> 
> Balbir Singh.




