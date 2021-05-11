Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5E37A606
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhEKLuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:50:00 -0400
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:30855
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230400AbhEKLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2I1hR35i+cuyqYtw1xdqNojy/qm4jubiBDDqSaRZQkD86Kvhggdh18qWLqaOAXAC+Ma2JcUfJ5woNehq+FIzXDVK8NW1gXqIrXnDW+yYgssz51s3R3Vd9mWZzBFiBprti+oNQAi3VOyWB3R1kuMAXVFtzAhP5kjrA9jBE4sMggCQjkYpO+p1tDDPXgXc0HuTPltHfyt18tSK+M9Of08JJPW6iPgcQDWJ0rBB1pNvpfP8eN/XZ003Fe0woXVm0iC3g+04VRu42uS+weCqMVXjgBVz7on9hkvOszu+bT84gNBWkpqi6D5Fo+Yr+rDYcgDXLQmSIOI9nDfiFDjB9wyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1uu4WWF+Y9oEfI7PCwJNR8A1DC0pNqF02DFNORbzQs=;
 b=GgZ2w3EkfGJkwquE7SHp/4Zf8O8A5uaIBuUMW8zpxwTBCmcRbMp8uaBKCTdKv/VMCLv2FzxNtQQr1+DMoXuxoTrKOEtTe2Y43GLrD9kF9FWMGi0UImRFGfvEOK2CofKcbrP1gsUxp6ab6tQlae2RsZPxcnIfjM/F73sUqRXKw/t/byu2CKV0MId2zKSxrdU+iY2viVtCBh0S4Aw7a9puHwSKcC8ltl6CzXjyQPw3EZK9uhrOsMJkAE8aUyLGmqvX8zes8EL2vRmBkahdGbThMB7gZ8mxUUQJ4Cp/fCL3xScn1QmUuB7L4CvTLb5QjeHpMhjQ31CWpV9GS5LuO2jBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1uu4WWF+Y9oEfI7PCwJNR8A1DC0pNqF02DFNORbzQs=;
 b=Zy6FMHgY3Vi7PQufVLqBcfw+D11c8ORDYx/uLjSHo7qzhKOff9wShBlZgRUUe9GzwGeP5A8s9ydDGuMQfC38Ncd+iRC+ujDk1IyLNAHCEpIrXvxYWZgakda/pE7f32GD5943Ly5XNyM0G9RKtnlbPI48x3PYxmIEWJ1kqphPd7GDahdMcL0ImWApOHR9GiJNOJbDfDndBkIMrwvcreeqw3Mrsz4s7kMX2h6AkY6Z/R5yVEGvIKs8RO3iXGZ3qOwBsOQwRV+s36qgwK0L2VV2aRIxKWFwzOtkJcTFaNwBj9iE1OYQcALXbgAJAjjIEuu4N8Mqo3jS2tNwofWRfJ4fsQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 11:48:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 11:48:49 +0000
Date:   Tue, 11 May 2021 08:48:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210511114848.GK1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510203145.086835cc@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 11:48:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgQsa-005GS9-AN; Tue, 11 May 2021 08:48:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5318360c-f9f2-47c4-3aeb-08d91472bdee
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860B063A97B0C2D85D735A6C2539@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55XKXK9sDad7oO6+tkQ+RZbquJVHGOzskbCqsAjDhHmnLyRsqBPv5xWfkw5y4cOSTT/zH8bv2sBBVhH78TZoN+GEpMiT346RaJzdxvBMaYtOgxtw1YZEb8+6R1137IRNzUVUEawwbfsx+BeXnu+dY4DAl9YFZXAMm9XBqS3uzyXS3+/PMYzHKMVDwZCN1JB/3VCICBhDZLefE0KlR0v9q48TTnPTHlxtW+Oc21RmZnQEsbLIatVXva8LNO8NPnjeUO8syRJnnv++Od3Sk5hlB/SAsljvS14ibQxciTU5pZbNWVNArpm3gM9cgd8Nm/SKhNzl3BsaEIdE4WH2Nk+4GAHLngrhuBL9FPN1L5PM231BQ2b0uqqLOcTozEV5klJTbJoRuuEQfMVKPwvH8XNsqhWWARaofmjcTb3vQyPcOXIEucLBV3CKrftIrf8UQy43PcM168csgd6GxrJHfPhO227Y3pdp4SqM7EqD0q6NQMTr5kX/4PzjTiLhhT/jg+KYflMHgcX4no3cA4b4EOgmZUa/2uxWrd5QkbwfxoxHLLN+5d/0BZzM9RAyn8L6Veot1MumO1YauUrl8UmYAlrFIX2ypLWE3Z99rnjhOKJPkjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(8676002)(86362001)(4326008)(26005)(54906003)(33656002)(8936002)(66556008)(478600001)(66476007)(36756003)(7416002)(9786002)(426003)(66946007)(38100700002)(1076003)(2616005)(6916009)(2906002)(316002)(5660300002)(186003)(83380400001)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUM4TmhmN0pHN09nbWx1d3RoakI4RmlaK1BvUG1IeCtYTVFaTjdTWXpZTWow?=
 =?utf-8?B?clRNY0M4eDdIQVd4N3hWUzIzU0xpSjl5MkxySUhBaWNxYW1XWXQrQjIxUjBP?=
 =?utf-8?B?Q3NTUGs4QTNmbkh6SWlNNTlsNW9iWVdWbW5HZlkzcGlDcGU2cnZIQVE1QWtK?=
 =?utf-8?B?RTB2VVlaWDgrdFo2R0tYQzVrcDQzVUFlKzBNS1hQdndUSTU1eWJmOUJxbEQ5?=
 =?utf-8?B?bmtiLzBhRzlmYXI0aXM5WU40OHRQQmFOQjIvVW9OWHVtSWM2ZXJLR3dieW1I?=
 =?utf-8?B?MC9nWHJvVm01ZVhxektiYjlWVklSQk05V3hUQ2VoMzloSzEvNFVSa0hwV0pn?=
 =?utf-8?B?enpHdUc3V1VLT09hNjh2bzRDQWVJeTRyWlJvN3E3azhabzBKREMwMWFxaUJv?=
 =?utf-8?B?M3ZiS2tZeVFCTGFkbW9OWmdMRzZLS1NkRFM3V3NZOSsvQ3Q5R29iNGdYUlFZ?=
 =?utf-8?B?TFlhQnVIcWVubkVLb0hYS3lxNTdPdmkrNzdjaEpEb0I1Sko4TnVRSDNYUVB3?=
 =?utf-8?B?dDBLenlEQTh3UWdxWlJkS1NYVkpnd0U2RWFzeGhyaHVqUnhvZDJVOTNvelQ4?=
 =?utf-8?B?b3NoT0laWGVyWUFTTFBDTjY1ajlRM2dNaEgvVXlKSzErTVNHZE01a291dUZI?=
 =?utf-8?B?cWFJakZPM21nZE1VbURCKzZPRkRBejNteWxRTUxQZGY2T2hNYWdvUFRWc2xj?=
 =?utf-8?B?dDdhVEtJUk12ZXlnNVlxRzdqV0cxR095K2RCUHd4bmJPRHdnREVSZWx0QXNZ?=
 =?utf-8?B?N2JMRnRXWHNTRDBLbGVzYVYvcU1FVklySDNyWmp5azgvMHFIS0tWRHl4VGk4?=
 =?utf-8?B?Q0FxSEEycDJ5b09ROU1aRGZtSXFKZkV1cWpZK0gzS0RteEp4ZHVoVHpWYVhX?=
 =?utf-8?B?bkNzT2htelRHNkttRVczWXlEblFFR0NPTEc2VzJqYjV0TTRRdFdqekdFMWU4?=
 =?utf-8?B?Mlc5RDdjYjJWL3RST2VkTlNvVEx5bnNtWDZFL0Z0cFJYZE45cTNLNXlFWVFV?=
 =?utf-8?B?UDBDWko2blY1MmtaMW84Y1lOZG9pWVdXY3YzaWwvdnRPTnVwT2dxaVJLaXpO?=
 =?utf-8?B?TmlOK1NJS1N2UnJOb2lhTUN2V2hkcDBlRjM3dmVLMDZBNEVLa1lZWFFhSU04?=
 =?utf-8?B?eWFEaldZK3lPWm14WHc0R1JSaWVhbTVLRjJwMjh2T0p4ZTN6M3lUb0ZrVXlX?=
 =?utf-8?B?SUtVQTVaM3pibG5aZ0JzalRTS3Y0cGVhczBvcDNnUUZ3QU9pSzArVXlLNGx0?=
 =?utf-8?B?ZVAwT1F4T2dINlpBRnJ0RldBRjJhRGhTQ2VVWkhNZmNTdkdnNlZZR1JWM0px?=
 =?utf-8?B?U20vTTVKTzkzL0hvKzdJcFFHL1NlRzkxWVRkMUpicmd6cGFDdnFFQWQybGpZ?=
 =?utf-8?B?RjBNa2J1NnFlTWgvNkI5VFJwYzYydEdxVDJVOS9SRDIwa3Y5MzRtMTR1L2tU?=
 =?utf-8?B?R3lUY2N3ZzM5ZnJWQWEwdFloVytnRXAzSkUrWllEbmVQbWtKZ1NvNWkrOXNX?=
 =?utf-8?B?OG9zNm9UclJFMEd0M3pudDJXQ2czVHE1anZiRDFpRzA3aFFmdGVoUmRzdTVQ?=
 =?utf-8?B?V0RlWTUwdTZ1bjdZcmUza0NwbUFJMGxIcW5IR01HZGsxZGt5VWRBOXFTNVhO?=
 =?utf-8?B?dVFlVkpCWWw5UnNDTVkrVVE1UlpvRjJDVHduNzAySmprbDU1TEFkeWlBMjR0?=
 =?utf-8?B?d1Mvb3FqdlowalpuRnNQMEFneGdnWVZGaGRvRXVtT2x0UzBwMnFjWDFyVEQ2?=
 =?utf-8?Q?LaE+zNzoUZOK2u3lTlZ/GSaf1ywmjiWOxRH16SD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318360c-f9f2-47c4-3aeb-08d91472bdee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 11:48:49.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir6URekscKE0P7ddugSm8A/8yKTAGVvOa/ZP2BFJuHjlFm9tJ7/no9f4wIoq2f+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 08:31:45PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 10 May 2021 20:37:49 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, May 10, 2021 at 06:25:07AM -0700, Jacob Pan wrote:
> > 
> > > +/*
> > > + * The IOMMU_SVA_BIND_SUPERVISOR flag requests a PASID which can be
> > > used only
> > > + * for access to kernel addresses. No IOTLB flushes are automatically
> > > done
> > > + * for kernel mappings; it is valid only for access to the kernel's
> > > static
> > > + * 1:1 mapping of physical memory — not to vmalloc or even module
> > > mappings.
> > > + * A future API addition may permit the use of such ranges, by means
> > > of an
> > > + * explicit IOTLB flush call (akin to the DMA API's unmap method).
> > > + *
> > > + * It is unlikely that we will ever hook into flush_tlb_kernel_range()
> > > to
> > > + * do such IOTLB flushes automatically.
> > > + */
> > > +#define IOMMU_SVA_BIND_SUPERVISOR       BIT(0)  
> > 
> > Huh? That isn't really SVA, can you call it something saner please?
> > 
> This is shared kernel virtual address, I am following the SVA lib naming
> since this is where the flag will be used. Why this is not SVA? Kernel
> virtual address is still virtual address. Is it due to direct map?

As the above explains it doesn't actually synchronize the kernel's
address space it just shoves the direct map into the IOMMU.

I suppose a different IOMMU implementation might point the PASID directly
at the kernel's page table and avoid those limitations - but since
that isn't portable it seems irrelevant.

Since the only thing it really maps is the direct map I would just
call it direct_map, or all physical or something.

How does this interact with the DMA APIs? How do you get CPU cache
flushing/etc into PASID operations that don't trigger IOMMU updates?

Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
does IDXD use normal DMA on the RID for kernel controlled accesses?

> > Is it really a PASID that always has all of physical memory mapped
> > into it? Sounds dangerous. What is it for?
> 
> Yes. It is to bind DMA request w/ PASID with init_mm/init_top_pgt. Per PCIe
> spec PASID TLP prefix has "Privileged Mode Requested" bit. VT-d supports
> this with "Privileged-mode-Requested (PR) flag (to distinguish user versus
> supervisor access)". Each PASID entry has a SRE (Supervisor Request Enable)
> bit.

The PR flag is only needed if the underlying IOMMU is directly
processing the CPU page tables. For cases where the IOMMU is using its
own page table format and has its own copies the PR flag shouldn't be
used.

Jason
