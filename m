Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FAA34E07A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhC3E73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 00:59:29 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:5490
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhC3E7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 00:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTTUz3FX9FWpFUWbc0+mLIXV1iaih46/4Rj+Iw15cNxME1+AQHR7aBcprmjKxGBvEWn2Q/YnYUm8D5rt1rZMA1Ei4Gb5sLGnqunJQM9+P+DIa74FLw/MNyinQ572F4Ht4DJlW5UpKhBFoQy7iltjnSaIDG+oqlQeJ9VtSRGY8jsQpb8kHqHQvYMb8pyqZZEpOdPFCKECCwEbbjSPoEINo7jX6XGeTdAzOMML9yuprotteMyhdmzPJzsDk1k1xOu8/pHK4c++5xvix5iBe1R8LXOaN6ZAgMuNtQ7Ne1vQ6qil93sUCwoDEdQf21AQrdFw3crCah2gNBdOpUcP7jdz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX/ec5sDNUOuzlnoaQFKxxKlCXNpk/qCYnLA4noNdlA=;
 b=QWbGdAnpejypee1WUdGvyFwGQqDdMdfvumhVFoFXplriiDAqDqwAiDxqMeaxMTqjIruHHFlVcIjQ8HJLEGEXEHwnughl9bef0+1gXSdapfAwKCmGXzPFLDlcaTT4/rG9mT0w+yYftYVS27RCQ2HV6EtPhiloEbGzWlLv8MN3oR18mA91pIjHdZ3HWhInfbKDlCKci+znbq0iuYQDB/DPC1jIBrxmMLin+uP21fVujhYhzGl2pqbuDL8dOEKijpJ+xbJXd4bJ6xaFuypANHQIsSxCCOJw/ZoeuKY7mFjFlNNKZZwfcATB/yq97qN4SR5j51ypnsdqJSIzRhxsKRvftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX/ec5sDNUOuzlnoaQFKxxKlCXNpk/qCYnLA4noNdlA=;
 b=HjKnk3LbOaU/YKnogpiG1F86+ubLNLwVhx94Lp4qFlubNoP3GbsMqlqDRGusxoI0sOYiSAaHHr9A8cL8TQJmH6FxBkobK5Q4eZ74OV0xx0NDR34Biv+POUJg4EevypFp3BEcoYhzj4lnCSE0DCDHA9RSz+yllohe8zOkMluC4vKKI/sHGyV0ExlTWPh884uFqkeEOd+XU2ayRLxT1xkCXm0x8MQCmMnaBh2YSZe9fXksn4cZDY7+7OWU0MKs7UE7g29p7wU0yXvYTM7Qv6RgAvSAyVdPT8po9xMvv0QxIvJ7hcoQqgnkoxIsLRXEoKU+qMHInKNYSug4Lph8NcCFbQ==
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by CY4PR1201MB0151.namprd12.prod.outlook.com (2603:10b6:910:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 04:59:23 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::3c) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 04:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:59:22 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 04:59:20 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <david@redhat.com>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] kernel/resource: Fix locking in request_free_mem_region
Date:   Tue, 30 Mar 2021 15:59:17 +1100
Message-ID: <7635785.yHxt4vaozm@nvdebian>
In-Reply-To: <801cd23e-9ac0-adb6-88ba-63ad18d4664c@nvidia.com>
References: <20210330003842.18948-1-apopple@nvidia.com> <801cd23e-9ac0-adb6-88ba-63ad18d4664c@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc0c9898-754a-454c-b3d7-08d8f33895ba
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0151:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0151915AA620A36FB92021F6DF7D9@CY4PR1201MB0151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQY/2wU1Jihq4cExMmuR1mwzDObDWXBQYloErdkqnU/fKRIkmoRNZVj14b7XlnIQeYNlQF/KuD0hE1n/OaJQgGcBTUy6jaSdUDr1WVCT9XZ2S/fN3K3O1mk8nNpv9HksAzVORgYOrJGKZjbCqvbsdkr/5n771mbFqNEhegKbbUO3J5Yqsp8NLoiyNsUCzXpoie/SCfB2JXgfXeW4P76V9MQRr0x7cnetHtQ5ysLAvnl64VQhr3CDy2lhRO9JprqgHKRPxPmrrw7rsC6MetRL7d3KWIg6NIkXBlW3wvvie6nfleWExgRin3saW1X8wLyDIH6Nez7Zd10Yo7ARE8Iu6+OND4OFUQym2Q9iWeI1mstCpgGaS0Dz3jJlwvoDqT+/1wsl8I+eXfP+iYusLwKqwMJOuOCvBn+fmUnIge1gTwPltbdY1GFnhlnzvv+k/Wo9lbHxM10ydFcvXuc0W6tlPXGs5jjcq2tcJzGGxHfYuOD3EVa2+3Zpjt6A5/av80ZRVeK+9+9/hnxjuqEX3UBlII2m/HIqQZG9U8qlfsKcFq7bQmNbgI+XfoWwQDKPnpW93NlHLGCASuvAduRwGUTVGHR2gAxV+qQku9yzf1Og66FOC863vM35BaAr9R5Jxx+nr9zDs4T5c9ed+wYgWYTJu8wqtcZ9REmf+9StHEejHmdf4qUC90Z95LupIh/xux1L
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(83380400001)(336012)(86362001)(186003)(36906005)(82740400003)(36860700001)(26005)(33716001)(9686003)(6862004)(16526019)(426003)(7416002)(316002)(4326008)(54906003)(7636003)(2906002)(8676002)(53546011)(70206006)(70586007)(6636002)(47076005)(82310400003)(478600001)(5660300002)(9576002)(6666004)(8936002)(356005)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:59:22.6485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0c9898-754a-454c-b3d7-08d8f33895ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 30 March 2021 2:42:34 PM AEDT John Hubbard wrote:
> On 3/29/21 5:38 PM, Alistair Popple wrote:
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
> >          /*
> >           * mm/hmm.c reserves physical addresses which then
> >           * become unavailable to other users.  Conflicts are
> >           * not expected.  Warn to aid debugging if encountered.
> >           */
> >          if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> >                  pr_warn("Unaddressable device %s %pR conflicts with %pR",
> >                          conflict->name, conflict, res);
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
> 
> Hi Alistair!
> 
> The above "Fixes:" tag looks wrong to me, because that commit did not create
> the broken locking that this patch fixes. Therefore, I think that particular 
line
> should be removed from the commit description.

Right, the last "Fixes:" tag is the origin of the bug but the refactoring into 
different functions and files made it non-obvious how this patch was related. 
Happy to drop these though.
 
> Another note below:
> 
> > Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using 
ZONE_DEVICE")
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > Acked-by: Balbir Singh <bsingharora@gmail.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > ---
> > 
> > Hi Andrew,
> > 
> > This fixes a boot issue reported by the kernel test robot with the
> > previous version of the patch on x86 with CONFIG_IO_STRICT_DEVMEM=y.
> > This was due to the platform specific implementation of
> > devmem_is_allowed() creating a recursive lock which I missed. I notice
> > you have put v2 in mmtom so apologies for the churn but can you please
> > use this version instead? Thanks.
> > 
> >   - Alistair
> > ---
> >   kernel/resource.c | 142 ++++++++++++++++++++++++++++++----------------
> >   1 file changed, 92 insertions(+), 50 deletions(-)
> > 
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index 627e61b0c124..7061b9f903ca 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
> >   }
> >   EXPORT_SYMBOL_GPL(page_is_ram);
> >   
> > +static int __region_intersects(resource_size_t start, size_t size,
> > +			       unsigned long flags, unsigned long desc)
> > +{
> > +	struct resource res;
> > +	int type = 0; int other = 0;
> > +	struct resource *p;
> > +
> > +	res.start = start;
> > +	res.end = start + size - 1;
> > +
> > +	for (p = iomem_resource.child; p ; p = p->sibling) {
> > +		bool is_type = (((p->flags & flags) == flags) &&
> > +				((desc == IORES_DESC_NONE) ||
> > +				 (desc == p->desc)));
> > +
> > +		if (resource_overlaps(p, &res))
> > +			is_type ? type++ : other++;
> > +	}
> > +
> > +	if (type == 0)
> > +		return REGION_DISJOINT;
> > +
> > +	if (other == 0)
> > +		return REGION_INTERSECTS;
> > +
> > +	return REGION_MIXED;
> > +}
> > +
> >   /**
> >    * region_intersects() - determine intersection of region with known 
resources
> >    * @start: region start address
> > @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
> >   int region_intersects(resource_size_t start, size_t size, unsigned long 
flags,
> >   		      unsigned long desc)
> >   {
> > -	struct resource res;
> > -	int type = 0; int other = 0;
> > -	struct resource *p;
> > -
> > -	res.start = start;
> > -	res.end = start + size - 1;
> > +	int rc;
> >   
> >   	read_lock(&resource_lock);
> > -	for (p = iomem_resource.child; p ; p = p->sibling) {
> > -		bool is_type = (((p->flags & flags) == flags) &&
> > -				((desc == IORES_DESC_NONE) ||
> > -				 (desc == p->desc)));
> > -
> > -		if (resource_overlaps(p, &res))
> > -			is_type ? type++ : other++;
> > -	}
> > +	rc = __region_intersects(start, size, flags, desc);
> >   	read_unlock(&resource_lock);
> > -
> > -	if (type == 0)
> > -		return REGION_DISJOINT;
> > -
> > -	if (other == 0)
> > -		return REGION_INTERSECTS;
> > -
> > -	return REGION_MIXED;
> > +	return rc;
> >   }
> >   EXPORT_SYMBOL_GPL(region_intersects);
> >   
> > @@ -1171,31 +1180,16 @@ struct address_space *iomem_get_mapping(void)
> >   	return smp_load_acquire(&iomem_inode)->i_mapping;
> >   }
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
> > -				   resource_size_t start, resource_size_t n,
> > -				   const char *name, int flags)
> > +static bool request_region_locked(struct resource *parent,
> > +				    struct resource *res, resource_size_t start,
> > +				    resource_size_t n, const char *name, int flags)
> >   {
> >   	DECLARE_WAITQUEUE(wait, current);
> > -	struct resource *res = alloc_resource(GFP_KERNEL);
> > -	struct resource *orig_parent = parent;
> > -
> > -	if (!res)
> > -		return NULL;
> >   
> >   	res->name = name;
> >   	res->start = start;
> >   	res->end = start + n - 1;
> >   
> > -	write_lock(&resource_lock);
> > -
> >   	for (;;) {
> >   		struct resource *conflict;
> >   
> > @@ -1230,14 +1224,37 @@ struct resource * __request_region(struct resource 
*parent,
> >   			write_lock(&resource_lock);
> >   			continue;
> >   		}
> > +		return false;
> > +	}
> > +
> > +	return true;
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
> > +				  resource_size_t start, resource_size_t n,
> > +				  const char *name, int flags)
> > +{
> > +	struct resource *res = alloc_resource(GFP_KERNEL);
> > +
> > +	if (!res)
> > +		return NULL;
> > +
> > +	write_lock(&resource_lock);
> > +	if (!request_region_locked(parent, res, start, n, name, flags)) {
> >   		/* Uhhuh, that didn't work out.. */
> >   		free_resource(res);
> >   		res = NULL;
> > -		break;
> >   	}
> >   	write_unlock(&resource_lock);
> > -
> > -	if (res && orig_parent == &iomem_resource)
> > +	if (res && parent == &iomem_resource)
> >   		revoke_iomem(res);
> >   
> >   	return res;
> > @@ -1779,26 +1796,51 @@ static struct resource 
*__request_free_mem_region(struct device *dev,
> >   {
> >   	resource_size_t end, addr;
> >   	struct resource *res;
> > +	struct region_devres *dr = NULL;
> > +
> > +	res = alloc_resource(GFP_KERNEL);
> > +	if (!res)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (dev) {
> > +		dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
> > +				  GFP_KERNEL);
> > +		if (!dr) {
> > +			free_resource(res);
> > +			return ERR_PTR(-ENOMEM);
> > +		}
> > +	}
> >   
> >   	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
> >   	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
> >   	addr = end - size + 1UL;
> >   
> > +	write_lock(&resource_lock);
> >   	for (; addr > size && addr >= base->start; addr -= size) {
> > -		if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> > +		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> >   				REGION_DISJOINT)
> >   			continue;
> >   
> > -		if (dev)
> > -			res = devm_request_mem_region(dev, addr, size, name);
> > -		else
> > -			res = request_mem_region(addr, size, name);
> > -		if (!res)
> > -			return ERR_PTR(-ENOMEM);
> > +		if (!request_region_locked(&iomem_resource, res, addr,
> > +						   size, name, 0))
> > +			break;
> > +
> >   		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> > +		if (dev) {
> > +			dr->parent = &iomem_resource;
> > +			dr->start = addr;
> > +			dr->n = size;
> > +			devres_add(dev, dr);
> > +		}
> > +
> > +		write_unlock(&resource_lock);
> > +		revoke_iomem(res);
> 
> This is new, and not mentioned in the commit log, and therefore quite
> surprising. It seems like the right thing to do but it also seems like a
> different fix! I'm not saying that it should be a separate patch, but it
> does seem worth loudly mentioning in the commit log, yes?

This isn't a different fix though, it is just about maintaining the original 
behaviour which called revoke_iomem() after dropping the lock. I inadvertently 
switched this around in the initial patch such that revoke_iomem() got called 
with the lock, leading to deadlock on x86 with CONFIG_IO_STRICT_DEVMEM=y.

This does change the order of revoke_iomem() and devres_add() slightly, but as 
far as I can tell that shouldn't be an issue. Can call that out in the commit 
log.

> >   		return res;
> >   	}
> >   
> > +	write_unlock(&resource_lock);
> > +	free_resource(res);
> > +
> >   	return ERR_PTR(-ERANGE);
> >   }
> >   
> > 
> 
> thanks,
> 




