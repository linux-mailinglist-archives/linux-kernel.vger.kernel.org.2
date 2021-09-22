Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1FC414EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhIVRGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:06:11 -0400
Received: from mail-dm6nam08on2057.outbound.protection.outlook.com ([40.107.102.57]:22880
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236537AbhIVRGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHHNhp/9Rj8O2OYjLl53wjLqeJudYSDjmBCYpu6zrl52nErJqgvH0X+TEQxGjGaooKYnu8AzdBC/j2MpJTvE2f8iDQhikQUuhv62NO57Nv6PQDMwY5AngQKsU4bPTUGv/U36HeZ4nGJHftQFaqwBuBIcxr4JSQO430xB/QRe5p+TeizNLv5Xew39KT9ya3iGmfmIeWnyXlSeVqI/aGyJuZT2rRRJSTDzLLwRymqqwkLDOgIPtXPAhyGLftaEyV9Qzt9xw71N0DZq3cjhuDsSlrnFYnUivmNK4XEL+PjC4Pq8Eggfh3gDvPZsxAkIjmcpuTTyYBoV+IuQorWpzZAU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HwWQTiLgXXMe4EmdsE9DecheSGn7Hhk3UxZXa4Vjs3s=;
 b=JI9xnIHL67vh+0M4Ou7WS3cEY21JBlW3zkl1NIrRxaNH4O2Jf1gX5n/0UFGFgwaJluCHrmtQkN4QB3Ag3DvpF3N2SHEc6XSZeEuqXv7h1FPgc1yAjfHaHOJdvLB837b7DOKE7IP24tGdAkCzxquYi2z0fefJyD4TuKEeqwsz6aqACQyoZxc+DT2KoIkSJGo7SEdEnZF4yUtQMZa+1WtAMxB2KT8WseJA2UzLJ7hOpvFUzRx34ELI60AGyTj8WGxpNeXAVCKobmqTTzWFhZ0+I7ZAYyCYl6EmfvP4P9fXU+8wnLgyZW49ayfqQkZCm2hgBgYY5itZ4xN+CpcpWM+32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwWQTiLgXXMe4EmdsE9DecheSGn7Hhk3UxZXa4Vjs3s=;
 b=p/oyJnNPW4fFvzpuLZMGhRcpK/meQocZPlGTwvTbT4bKiJjO0cwCDkW7xF24bfK19sjqj6daPtxAo2UVeP69nEM/j9w8JIL6j7qDXEtCEVkbdv+fApH6+0HWWjtVqfUidEqQ8FBDFDjqfP/4XHFldYYtT+lUICSJDR9aDswl6Igw6Yrq7X6bgO5YIsuc5Nny6/T0rVE6AHxRSYIbzlSw6Sa/ac70ihH+kvkrWlHG29qqFckrPk+gymNcT8O7nFHpjgXqJGyR9TVWLpYSlqEgh6i5dJ/9Vk9yQhndh6d3lcHLdaD4pOocsa7xU5fH+VlCgAgI1qWeuTzg4Db3LgUpJQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 17:04:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 17:04:37 +0000
Date:   Wed, 22 Sep 2021 14:04:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210922170436.GX327412@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 17:04:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mT5fg-0042S3-6K; Wed, 22 Sep 2021 14:04:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872ed5e0-d824-4115-3ed8-08d97deb0f0c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52566062D648427B48312712C2A29@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TuXeS/73a/N2mPuKcEiLFbBZDzVEsvWawdSaJ5picgoHwjMmG6l4e0If+WU+Ou6dXi/1DXX4N5IJjvpEt7rU8RSlt0eVoViMlLUpw9tWJWv7sUQ+J1f1nS8hksAmrWPb7eqlP3uzyjXpEDD8mJ4eIeVy4PxWM+Ln1Cf+VgwYi2+Uw118XBURYmeg+iNvDa7COjVkb+eWal+avHO5at0VaYSxmAN0fN/ux8kMJreBuBTiRFhRRtORJTFlIwMLl3aMyOWgU4XQryCR6POlvTlNMklM1tcuJWhWFVT273J2Eig99W35fyz/Z23VWftFZWiVz3kbm0E1if4Pn0qp9I5AZJcu497hmPTasvs2KFz3S1mzY0aN4RPqElxgny5ryjnRaHeKTWVrTZZy2WzdPi4S/nX/aTkb//Ic+neE3NUTpneWRAetiZomxn+QOsrjAzzCk7EzE2xJ4ba66BCoQiJqY9DPwmrvI0LmPqxVC/IMZERgcEwEACjkfFFk8IqUayzxg/445Xfzhy+g84twaQaNJ/w1WQhGIMQVHH/LAE66BlPY4JeJr3itHaf4dn3keG7tTN9Cqg+PCMeMtalqKWx0ZXxLi2UZQP81wdP561x3OTsfxxMV2I7t06autSTKYZkrvmLz2G/4q4qJTAJTuL9/PyqhWVRYsBURWkrCF6BgVe4bLjqjjApYrWGHYC3AUeJZgU9VZddl72UHBZLAY5mdxmHJc1oVzrt8KrmMPdD/Z2xWJSnUNmtCNIbiA5uE7pFYOHzsNZZDe0hoIZuspSOicQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(8936002)(8676002)(83380400001)(508600001)(86362001)(54906003)(36756003)(4326008)(66476007)(9746002)(9786002)(66556008)(1076003)(26005)(186003)(426003)(5660300002)(2906002)(2616005)(7416002)(66946007)(6916009)(33656002)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5aL6IjgeSTqLu3WX/NibVJoHkilW2JL2xYukOb9a3e6P6ihYx7pqqGwl1QCY?=
 =?us-ascii?Q?nEr8E36yoya8pgc+IYGBDV2U0grEAEIEqWmhdqF7t4TRMPDgU0UTcqpjSkRO?=
 =?us-ascii?Q?XZZ0kI9hH6ElWh23zVFJY5+GtWiex86UKr93xiHq0yoPUbuLIKm6pyFwczvu?=
 =?us-ascii?Q?A77KJ4FhPeKVMR7gpxHB1NCmyF2d/6zIlsj6DrKK4D3Rv0EismB6WIjw0KNh?=
 =?us-ascii?Q?/L/JgEPMqfp6URm3HIA+/NNc4H2T5nbuTW3oH7ztYxaaNBDmfmkU7k41EIVX?=
 =?us-ascii?Q?2qCVxD62d2gBZT+n9kVWDSagaq1R+WCMThylUqN0sn3b5KFsScEKGMuUoxlz?=
 =?us-ascii?Q?qKmRFg4YBMbczG1hVVDDiPL8QqZhTDAsO7SdZjcLfk3P8dDm+ATKB3Qpa6oB?=
 =?us-ascii?Q?WwDpSBmKDuV2mfaGV+y8sA+mGMslouOMNO5TPS00EuEcEsN5z7a2TOSaXGFg?=
 =?us-ascii?Q?e6TjI2KAaz3DdZEZzdmzbr0uMVxwitOa/Ch0AWSSwrwXwhb8F9oOkBb+uttu?=
 =?us-ascii?Q?2xZgs7FoNPLp0oTyiYBL0ISIGANGAdYMn25SybFnuNPNvSRu7WkQFD/+Yguu?=
 =?us-ascii?Q?Q+llCqHSRozc+QLznZhCrhFmKioGBhmm5B/EnCvWdS5tBdEQebcp/0yXZ+Sq?=
 =?us-ascii?Q?Ta1Y+9xGdEMtFssHCVMe9Je0nSznokVAu1Qt59WA5FHoIKUZbuOzdpqLXJSr?=
 =?us-ascii?Q?Tytdn4W8nGtsexo0HYo4yVtUjc0oP1msN5WnZ08HIG4+viWrmz4GHyFiXrNi?=
 =?us-ascii?Q?NBNjOYi0st6Tw2WkYzjAVZxs5qvKBNPl8RSPn2kJnsIKfbbjufCaF2t+f9e0?=
 =?us-ascii?Q?oMSXVmkYCOAD4kBFWms6zDQXb3jKjg7VTADYVBFTXr6i7UNbrwBejw0k7a2K?=
 =?us-ascii?Q?57LV5tB1DULXDv4jwJPDryM+vvWdAGcXAxpagnPJPIPI8lRC0+EHFaGHY8zn?=
 =?us-ascii?Q?Kj4VllqMX1hhXxjGON79XVRisYII4jMCTiewcwKkvOQbnVv3/oe+/0D3FZ87?=
 =?us-ascii?Q?LSnEWOjuEqGB1KRpdpGxWmEi/K4ZcUrC+2yxjWdk/prEUPfPi7wnlyGEsgfc?=
 =?us-ascii?Q?I7cVY58A8df/SGth7jgGC+XfbIPj1Y8mZ9ShnzddiSBss2guf55A7o8uvLsF?=
 =?us-ascii?Q?4gApm2uW8O9+0DNm9HYZlrqrC/eijXFU4Tbc2eNGTbo4bO/BhEPjNe4UdBqj?=
 =?us-ascii?Q?1IW+RReOSolglYhAUgSe5wIgFW911IiTqeFdeUH/UHaNybRSNoj3b3iky/ry?=
 =?us-ascii?Q?Vr9I4uIJY3v30GOCNenCg9omNHvc7W62GNBVlslthPFlQtexz7jyLIkJDLRU?=
 =?us-ascii?Q?Uz/wZ6qYP5WBFaeC43UEyIbH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872ed5e0-d824-4115-3ed8-08d97deb0f0c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 17:04:37.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNrHlD5BupxTOv1atVoSfPfkUc7544KhcP1fiyUWIRIRxCi3vEit6wdaxoeLaTjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:29:34PM -0700, Jacob Pan wrote:
> Hi Joerg/Jason/Christoph et all,
> 
> The current in-kernel supervisor PASID support is based on the SVM/SVA
> machinery in sva-lib. Kernel SVA is achieved by extending a special flag
> to indicate the binding of the device and a page table should be performed
> on init_mm instead of the mm of the current process.Page requests and other
> differences between user and kernel SVA are handled as special cases.
> 
> This unrestricted binding with the kernel page table is being challenged
> for security and the convention that in-kernel DMA must be compatible with
> DMA APIs.
> (https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
> There is also the lack of IOTLB synchronization upon kernel page table updates.
> 
> This patchset is trying to address these concerns by having an explicit DMA
> API compatible model while continue to support in-kernel use of DMA requests
> with PASID. Specifically, the following DMA-IOMMU APIs are introduced:
> 
> int iommu_dma_pasid_enable/disable(struct device *dev,
> 				   struct iommu_domain **domain,
> 				   enum iommu_dma_pasid_mode mode);
> int iommu_map/unmap_kva(struct iommu_domain *domain,
> 			void *cpu_addr,size_t size, int prot);

I'm not convinced this is going in the right direction..

You should create/find a 'struct device' for the PASID and use the
normal DMA API, not try to create a parallel DMA API under the iommu
framework.

Again, there should no driver in Linux doing DMA without going through
the normal DMA API.

> The following three addressing modes are supported with example API usages
> by device drivers.
> 
> 1. Physical address (bypass) mode. Similar to DMA direct where trusted devices
> can DMA pass through IOMMU on a per PASID basis.
> Example:
> 	pasid = iommu_dma_pasid_enable(dev, NULL, IOMMU_DMA_PASID_BYPASS);
> 	/* Use the returning PASID and PA for work submission */

And why should this even be a choice given to drivers?

Drivers do not get to self declare their "trustiness" - this is only
set by the admin.

PASID tagged DMA is no different than any other DMA and needs to
follow the global admin set IOMMU modes - without any driver knob to
change behaviors.

The API design should look more like this:

   u32 hw_pasid;
   struct device *pasid_dev = iommu_get_pasid_device_handle(pci_device, &hw_pasid);
   dma_addr_t addr = dma_map_XX(pasid_dev, buf, size)

   'tell HW to do DMA'(hw_pasid, addr, size)

   dma_unmap_XX(pasid_dev, addr, size);

If there is any performance tunable around how the IO page table is
consutrcted then the IOMMU layer will handle it transparently from
global config, just as it does for every other DMA out there.

> 1. Lack of IOTLB synchronization, kernel direct map alias can be updated as a
> result of module loading/eBPF load. Adding kernel mmu notifier?

I'm deeply skeptical we should even have "KSVA" and would want to see
a lot of performance justification to introduce something like
this.

Given that basically only valloc memory could truely benefit from it,
I don't expect to see much win, especially when balanced with
burdening all valloc users with an IO page table synchronization.

Certainly it should not be part of a patch series fixing kPASID
support for basic DMA, and still doesn't excuse skpping the DMA API -
that is still mandatory for portability to support cache flushing.

Jason
