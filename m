Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230934DF84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC3DnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:43:09 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:63073
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229950AbhC3Dmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAlBTaEbdMk4xIXsrG9EnJVA4V0eHs+6n9rvzpTL2dA1+sbOjmzT0694o/sUCO7e4N/Y+VogS18SSI+UKeW8H+ipMDEFi1yZPfAcFV2g1pnZNYnfDL2QDo0WYgZo8CpOQO3/EDQXO00hcz4/zt+zO1f9WFxZngKABZeSne6xmR7a2dcPW6Y2SxOSbKR/4OLPNq4iSjWSx8w10sobEPfD+x9ozqTVA5pFXelWYnTCNH46mtfDyYZFDy5Ke8oojLIeP5hqQSWBXprjdLumAlEKn35ODC4gvDGNLGyvpXabT9rwaX4dLKu+SNnL04UWZK20EKiRP/eN0nWeW1+C3rHPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIVenkAQeJ+qT0V7zoLNEtEtybltqiSPrzVUwnhOrrQ=;
 b=mlaWgCWk/PDs1itzoft8NrUaHeDxxaeWCG/e+BiSRea5A7qPgDTBoqv1pcZKhYTdycVdpcrocp/UpA5nE5Z41xBvoU1PosE19r2+XLLsJwL70A6uMCBIrCP9xjRIgsvinylr8jQUlW81y06f/KedZQ9gtQe+uN1keL42WWU4ob3OuO1iotmNX9IL7dHNgUV+1EY9Lcoys7dBxRlK5/sCfRCzVbcrk27zXmcKTsaCAY9QGaWW+0mCPtmKYQ7xU6yuo51r2Tvm3M0gAxud4jJ2C1ozBBiU0uVsgmzmIGtNF0Q3YQw4Ep0q4rNhMaPSyLGqlcCyaxooldF7YCbj52ve5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIVenkAQeJ+qT0V7zoLNEtEtybltqiSPrzVUwnhOrrQ=;
 b=l+k5tdk8RzlwIW61m7NDT9+heRCyeiFLw0jSwK5tWXMSFhXGp/qk5NQ6vbZmSoglBNmIq+OOM8/qO+CEEZ46i2N7LHO0/IlTf81OfL0sxpSjgQdI5hvYTkOQMN0z2/lxKT1rNGFDRSMdIwMHi9NDRIY257EzvHyNKHuMYbORHMkZj41BzHsyemYno8xW/hkYII6ZofIghDsJxRzVcodDtMt4y+SK3/nLnjzOIO4idvR+OeBwkiNKI96pQo/MCvbdYcsWnfHb2sCddmVV+XxxROGuBs8uT4isFDpmr8zrfdPdJtaGeKWL+dDAOh76U+djE7gMUPQCe2OnqNmJqME0XA==
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by MN2PR12MB3021.namprd12.prod.outlook.com (2603:10b6:208:c2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 03:42:36 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::fd) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 03:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 03:42:35 +0000
Received: from [10.2.63.109] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 03:42:34 +0000
Subject: Re: [PATCH v3] kernel/resource: Fix locking in
 request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <daniel.vetter@ffwll.ch>,
        <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>,
        <jglisse@redhat.com>, <bsingharora@gmail.com>,
        kernel test robot <oliver.sang@intel.com>
References: <20210330003842.18948-1-apopple@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <801cd23e-9ac0-adb6-88ba-63ad18d4664c@nvidia.com>
Date:   Mon, 29 Mar 2021 20:42:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330003842.18948-1-apopple@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86fbf2c2-6eae-4227-4714-08d8f32ddb9a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3021:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30211AF07F6690E7F51290EDA87D9@MN2PR12MB3021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h98wmcvCd2C2qzNYe7wrz4auHptNJPRTY7OJU3RJ9DDQfynLaCUHzsDUI5ZJcOojldGUBkboSCqJIk8oC/PCrTJmnhqxLHPDgs7CZTzwzQ/IWISXhVjRW3GnOsb0wTQtE9ECzFjiuy3V0D6zUPGpObqM3yaY25EYtDNbAcT+Jcw5FrStRqKBzUUXxJ5uW1Ui06Ol1vJ42eIUdkwHm0ZRcHILLm3vmKtZgD4/28cRnpbZWMnTWjGpNEDwqva1lemAIhYzve41JqU2wIa3nQEncm1Kpo/Rx333F5PiRPmgILfkqboj78AfD3oDC1X7aDHZVqeb6A1V+OBpeK++Qwr05CmjjYR+FqNOCMRFkTJmqzDsIAMfxHlEUswqBYDjR3/a5Pmt64Re4YwafxG6EJ7ki1sqP0TA+2AhRK7snIybWVIsIYgAI0uV1MNLmUeZNRpQzALseRAnHbBWxvqR9f2gTVzxKtfpbCvAq1pvfsEvy3aSmAp8mIvl961KOkjgYO2GnIjPhQNOAwlgsUJiI9+nM+MDf8psEIA3zOPMcruwx3TWzKHX8ildq4zBZ4KD80iHMfa+9Dud6VR2amSNd/NVGiD6h/X3UF6ReA3TMzaLPY/7AN3SJ/PfJnY1WQ56cOiJKpxzTSIkQqFjVBBvAwJRHyN7F43YtnjCtnFYwvAxnwt+Xbvp7V0lTwGuMaTGOh22z7TKylgHoLpyPITL1QzHQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(47076005)(316002)(110136005)(36906005)(16576012)(31686004)(36860700001)(426003)(54906003)(5660300002)(36756003)(8936002)(2616005)(86362001)(26005)(336012)(83380400001)(4326008)(31696002)(7636003)(186003)(53546011)(16526019)(356005)(478600001)(2906002)(7416002)(82740400003)(8676002)(82310400003)(70586007)(70206006)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 03:42:35.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fbf2c2-6eae-4227-4714-08d8f32ddb9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 5:38 PM, Alistair Popple wrote:
> request_free_mem_region() is used to find an empty range of physical
> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> over the range of possible addresses using region_intersects() to see if
> the range is free.
> 
> region_intersects() obtains a read lock before walking the resource tree
> to protect against concurrent changes. However it drops the lock prior
> to returning. This means by the time request_mem_region() is called in
> request_free_mem_region() another thread may have already reserved the
> requested region resulting in unexpected failures and a message in the
> kernel log from hitting this condition:
> 
>          /*
>           * mm/hmm.c reserves physical addresses which then
>           * become unavailable to other users.  Conflicts are
>           * not expected.  Warn to aid debugging if encountered.
>           */
>          if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
>                  pr_warn("Unaddressable device %s %pR conflicts with %pR",
>                          conflict->name, conflict, res);
> 
> To fix this create versions of region_intersects() and
> request_mem_region() that allow the caller to take the appropriate lock
> such that it may be held over the required calls.
> 
> Instead of creating another version of devm_request_mem_region() that
> doesn't take the lock open-code it to allow the caller to pre-allocate
> the required memory prior to taking the lock.
> 
> Fixes: 0c385190392d8 ("resource: add a not device managed request_free_mem_region variant")
> Fixes: 0092908d16c60 ("mm: factor out a devm_request_free_mem_region helper")

Hi Alistair!

The above "Fixes:" tag looks wrong to me, because that commit did not create
the broken locking that this patch fixes. Therefore, I think that particular line
should be removed from the commit description.

Another note below:

> Fixes: 4ef589dc9b10c ("mm/hmm/devmem: device memory hotplug using ZONE_DEVICE")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> ---
> 
> Hi Andrew,
> 
> This fixes a boot issue reported by the kernel test robot with the
> previous version of the patch on x86 with CONFIG_IO_STRICT_DEVMEM=y.
> This was due to the platform specific implementation of
> devmem_is_allowed() creating a recursive lock which I missed. I notice
> you have put v2 in mmtom so apologies for the churn but can you please
> use this version instead? Thanks.
> 
>   - Alistair
> ---
>   kernel/resource.c | 142 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 92 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 627e61b0c124..7061b9f903ca 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -523,6 +523,34 @@ int __weak page_is_ram(unsigned long pfn)
>   }
>   EXPORT_SYMBOL_GPL(page_is_ram);
>   
> +static int __region_intersects(resource_size_t start, size_t size,
> +			       unsigned long flags, unsigned long desc)
> +{
> +	struct resource res;
> +	int type = 0; int other = 0;
> +	struct resource *p;
> +
> +	res.start = start;
> +	res.end = start + size - 1;
> +
> +	for (p = iomem_resource.child; p ; p = p->sibling) {
> +		bool is_type = (((p->flags & flags) == flags) &&
> +				((desc == IORES_DESC_NONE) ||
> +				 (desc == p->desc)));
> +
> +		if (resource_overlaps(p, &res))
> +			is_type ? type++ : other++;
> +	}
> +
> +	if (type == 0)
> +		return REGION_DISJOINT;
> +
> +	if (other == 0)
> +		return REGION_INTERSECTS;
> +
> +	return REGION_MIXED;
> +}
> +
>   /**
>    * region_intersects() - determine intersection of region with known resources
>    * @start: region start address
> @@ -546,31 +574,12 @@ EXPORT_SYMBOL_GPL(page_is_ram);
>   int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>   		      unsigned long desc)
>   {
> -	struct resource res;
> -	int type = 0; int other = 0;
> -	struct resource *p;
> -
> -	res.start = start;
> -	res.end = start + size - 1;
> +	int rc;
>   
>   	read_lock(&resource_lock);
> -	for (p = iomem_resource.child; p ; p = p->sibling) {
> -		bool is_type = (((p->flags & flags) == flags) &&
> -				((desc == IORES_DESC_NONE) ||
> -				 (desc == p->desc)));
> -
> -		if (resource_overlaps(p, &res))
> -			is_type ? type++ : other++;
> -	}
> +	rc = __region_intersects(start, size, flags, desc);
>   	read_unlock(&resource_lock);
> -
> -	if (type == 0)
> -		return REGION_DISJOINT;
> -
> -	if (other == 0)
> -		return REGION_INTERSECTS;
> -
> -	return REGION_MIXED;
> +	return rc;
>   }
>   EXPORT_SYMBOL_GPL(region_intersects);
>   
> @@ -1171,31 +1180,16 @@ struct address_space *iomem_get_mapping(void)
>   	return smp_load_acquire(&iomem_inode)->i_mapping;
>   }
>   
> -/**
> - * __request_region - create a new busy resource region
> - * @parent: parent resource descriptor
> - * @start: resource start address
> - * @n: resource region size
> - * @name: reserving caller's ID string
> - * @flags: IO resource flags
> - */
> -struct resource * __request_region(struct resource *parent,
> -				   resource_size_t start, resource_size_t n,
> -				   const char *name, int flags)
> +static bool request_region_locked(struct resource *parent,
> +				    struct resource *res, resource_size_t start,
> +				    resource_size_t n, const char *name, int flags)
>   {
>   	DECLARE_WAITQUEUE(wait, current);
> -	struct resource *res = alloc_resource(GFP_KERNEL);
> -	struct resource *orig_parent = parent;
> -
> -	if (!res)
> -		return NULL;
>   
>   	res->name = name;
>   	res->start = start;
>   	res->end = start + n - 1;
>   
> -	write_lock(&resource_lock);
> -
>   	for (;;) {
>   		struct resource *conflict;
>   
> @@ -1230,14 +1224,37 @@ struct resource * __request_region(struct resource *parent,
>   			write_lock(&resource_lock);
>   			continue;
>   		}
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * __request_region - create a new busy resource region
> + * @parent: parent resource descriptor
> + * @start: resource start address
> + * @n: resource region size
> + * @name: reserving caller's ID string
> + * @flags: IO resource flags
> + */
> +struct resource *__request_region(struct resource *parent,
> +				  resource_size_t start, resource_size_t n,
> +				  const char *name, int flags)
> +{
> +	struct resource *res = alloc_resource(GFP_KERNEL);
> +
> +	if (!res)
> +		return NULL;
> +
> +	write_lock(&resource_lock);
> +	if (!request_region_locked(parent, res, start, n, name, flags)) {
>   		/* Uhhuh, that didn't work out.. */
>   		free_resource(res);
>   		res = NULL;
> -		break;
>   	}
>   	write_unlock(&resource_lock);
> -
> -	if (res && orig_parent == &iomem_resource)
> +	if (res && parent == &iomem_resource)
>   		revoke_iomem(res);
>   
>   	return res;
> @@ -1779,26 +1796,51 @@ static struct resource *__request_free_mem_region(struct device *dev,
>   {
>   	resource_size_t end, addr;
>   	struct resource *res;
> +	struct region_devres *dr = NULL;
> +
> +	res = alloc_resource(GFP_KERNEL);
> +	if (!res)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (dev) {
> +		dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
> +				  GFP_KERNEL);
> +		if (!dr) {
> +			free_resource(res);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
>   
>   	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
>   	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
>   	addr = end - size + 1UL;
>   
> +	write_lock(&resource_lock);
>   	for (; addr > size && addr >= base->start; addr -= size) {
> -		if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
> +		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
>   				REGION_DISJOINT)
>   			continue;
>   
> -		if (dev)
> -			res = devm_request_mem_region(dev, addr, size, name);
> -		else
> -			res = request_mem_region(addr, size, name);
> -		if (!res)
> -			return ERR_PTR(-ENOMEM);
> +		if (!request_region_locked(&iomem_resource, res, addr,
> +						   size, name, 0))
> +			break;
> +
>   		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
> +		if (dev) {
> +			dr->parent = &iomem_resource;
> +			dr->start = addr;
> +			dr->n = size;
> +			devres_add(dev, dr);
> +		}
> +
> +		write_unlock(&resource_lock);
> +		revoke_iomem(res);

This is new, and not mentioned in the commit log, and therefore quite
surprising. It seems like the right thing to do but it also seems like a
different fix! I'm not saying that it should be a separate patch, but it
does seem worth loudly mentioning in the commit log, yes?

>   		return res;
>   	}
>   
> +	write_unlock(&resource_lock);
> +	free_resource(res);
> +
>   	return ERR_PTR(-ERANGE);
>   }
>   
> 

thanks,
-- 
John Hubbard
NVIDIA
