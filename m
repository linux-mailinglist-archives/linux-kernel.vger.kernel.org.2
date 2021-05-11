Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9227C37AF89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhEKTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:48:37 -0400
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:17158
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231808AbhEKTsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b84D05Q7ahsb0Blbxif9lTLe3UeUcvaoTi1hqtsRyl4vacjx8u0kFGItXGLrriIJEvhvLHprnvGlhZ3tXJspiTi6S6T9a9uQC2zWq9+UgKxAqVOajQZVriAVeKxFlewqlNdYcl86LYltGyHOqP7D7CyGFUkLdcYm1qmUedJwN+EWB1X0G1+kV48Zizjh2YOIS6oDVgyk8Utp+R85DujNNGTok2++wNMKSOz1u5Iydi/9kJo/Am+KLqdemWCRK6SH98Q6HNVsRmBgcoINIrAXsIQRK1hnPEn2vMZVl0GTiJ4zN1yQodAdnYQZEnbv5u8vi7j+uV/RBuROZcrBUNEZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6QAxh+/iRr3oXa2J5WVszT6Ap2DJhJSv1DfY1BudJE=;
 b=RxQG/hRHd85/LR7rWAbK7zastloAxFEvrdEpUaZId+bs6MvQjQOJy2KVMBPRMgCNV/HMrfsxZDf5cP1jqMKSEyeB7sUWufFjIEPQobPNnPsfSmFBvI8AR1BImrCKaqCe85/w4OCii2C0lyYAYD0s+BDr/zzwpqaxAMEtpUuK9HjioITNC9AyhFzvLWGIPVgi3KDCihIRxnkH6wYj1glluxS+gbt8MisIqvN5fQbZPdHaTrt2xKxuR2Q20GPrmVQXcDP6C4Wtjc/FTfFT+BiAUeJ5EH3wWkjDOqwSOMTwU/8Z9LkL9KoYwdt+aDyDhIoLCAR+sV/m6bfDlTcXprKbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6QAxh+/iRr3oXa2J5WVszT6Ap2DJhJSv1DfY1BudJE=;
 b=rYtdxKR1gSsWTBHPI+E2K9W80zcPRV/6DlhcGwRl00VOJUEkc7F5flLYYPa7c7BsqaHs6aoj01ieMQVHwpgwhOuA0qEfrSYmIW3eiRQVET8wyaQkaxfIqMxcJUuNBmtj6Ns/fI1nBRSZYAw2at8BqwYApKkW2Zwn1Ux/0Jfyb1CKG0ulmJaeDBUkHCRYoS79pLOx0KgpX+7hpPTPBDV+AF4HE+/eiux8y/+lDnNk7sOqKKy6w2eUzkYit9Qo7+8k0pxs29hh4ZBD0uMj4bwb5CFfHg9dFhq721Y24Wu4CKDW6socNpW4pg9y/ga2bn6xxhLHMwfBBkJlg3R7IkG24g==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 19:47:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:47:27 +0000
Date:   Tue, 11 May 2021 16:47:26 -0300
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
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210511194726.GP1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511110550.477a434f@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:208:32a::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0095.namprd03.prod.outlook.com (2603:10b6:208:32a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 19:47:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYLm-005WbS-7u; Tue, 11 May 2021 16:47:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c64dd7-99e9-4462-8d38-08d914b59b39
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30180C2EF9C0A0788CD141BAC2539@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGtlAZOcDBhZZrk1kBAPj1bz5JpOJPwDYTrh5/QObo79QMyzoT9JPaYZq1U9ye0eFd2MJRd8yI0HC+r+W/+zv4D/39ChFI7WlogtonwK32pK/ed5qGvbGvTasVCYsbqTNJRttEJx2kyWPhF16Srb7pU3ew5yoibBi7F5orEa68JR7Vi953IZdyS1ktOkq3pRh6xLuG0Gcz66jl8hUoAUSsdPUs5Ii27b07rvFL5cMYHfQcJkZ4IWKJPHapfs/rzFZCtpunO/LT69VppHvktP5bbW1WtsrJgtSyidmaD8VkceKDKundCi4ZEZ4dwWRobkuYl2UfmuYqWgQ+O9mNZURVrXGcHczs7Fb6gL/WtPhgn6SQzwtggLmC6MQYXy4y5I7+ivpox+HCdVz+DStdTsSyHjxHGrOJQJfymTUs00WaWU57gx/qJOJRTb6ofD/muhqHZr5HREH9utpDn09YdpEQBlW3fYrx2TwUZVXcGv5gniu16FrZAAoDOt7jDpIBGlyDgsO1e/Pp1Jrz9dl/8XU3rXgBdpAnBKMSstJm00AtePY51BgnJFUwE4e+Ql/2YUg/X8r4CUFa3lfAZDUfsjmNXFuHIi6i7kLnDhyemxGVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(9786002)(9746002)(86362001)(186003)(8936002)(36756003)(7416002)(54906003)(5660300002)(38100700002)(26005)(33656002)(83380400001)(66946007)(66476007)(66556008)(8676002)(2906002)(4326008)(6916009)(1076003)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LCVzMU/HPTpxS4qbq4pU7rWmKNHOIBiMnR8wCisAXNABPC0T+HfOHtUO/Ywx?=
 =?us-ascii?Q?GJxgaQgzptTX7mNtLwZjVdJx6eAAUrS17bPdNqJdlmPZOzruacq3Yv/IO+bF?=
 =?us-ascii?Q?Ht054aNwxlo9/8DMrAlX/BK3Uq90c02qmmHqGCq4NYBTMnDwO6/sCShMLwP+?=
 =?us-ascii?Q?SL+btWCQmYiYKVIKX+g+HMU5Yu46Mx94HS5Upg4C9BivCWDN+FGCRZ5vGvHz?=
 =?us-ascii?Q?PyY7XY4kFabfEBoltmHAUKqxu3x2bXSc28VL3DvsfP1uRG8mhG4OaGAmF6I0?=
 =?us-ascii?Q?rDwOmGPhSVxk/cKo18C+ZNArSiXwu4qV4IWR40yDj485w0Dviq3n62+nGecs?=
 =?us-ascii?Q?/qGZs9X3TUJkH/N8KkabdhpneJXJtexcOUMPXj28peBNczUOIvO0R3hbuPi0?=
 =?us-ascii?Q?QH/tceP2cFlmoUbIcW/EGBToeAGkIKLApq/jNwuFAPXtZZYwisQV7lgdXNoB?=
 =?us-ascii?Q?ndF5VQZNJvCYTA460dI6BeY1f70w+w3N61QqUvUBVqkI3w0IUs2K4nh+wvsH?=
 =?us-ascii?Q?wlZJ39nZq/IeJG3y/ecrILokifa/enpBeBW6HI7BOHLlfkUAjFNQXZVps5y7?=
 =?us-ascii?Q?brWzO21qe1Acfi6p41o/6XQz9qPQHm/4fT4cmSHEKraV6aEzW7vrTcBri+ii?=
 =?us-ascii?Q?etA5s7D5Rr3gcDgadmc18NXRII/quOQmOyqiw1oF9WBAJ3rwhmsFlu1y5ZI8?=
 =?us-ascii?Q?HPeWYtjBlNyUWKxOUAWKdM9kqbrAzS58lgXzfKiAf9UlUnrY0hTbi1L7pedW?=
 =?us-ascii?Q?8pD8l0KhCp7BspGO9qdNdS8YaxSpPNzKyf5rBOacI1PG3XT+Dw9h1uHaIgcx?=
 =?us-ascii?Q?G/BTh+OH67g4nv+9bJ6S/eA+bNtqIxFXCP5cDnUPf7Tk0GrfrKyiL/d9PQcn?=
 =?us-ascii?Q?9UW0PvNi9oj7oQ0/DHUr/cfwP0z5XOmVJ61QENJt11yUwewRdgYgrGDQaefg?=
 =?us-ascii?Q?SvG5peqiaXnqyCYN0/bsMWfnx0qNpH2xwFK8YUfkv6J9IxbYp2ALtTsOi5Ws?=
 =?us-ascii?Q?Xi91qFEfxcEJmLnlKFbnvX5CAWLUsualVREJfI6CDfnwspRHbO6PsgeBO8Ff?=
 =?us-ascii?Q?8va4jGCpFPo0RhC+KK9GvQa2dGgVGRS5ZbkRD+PidR+9q/mYkM+5CbfcLqTu?=
 =?us-ascii?Q?kkcueSrVg3UTxdrFdbWL4puiDW5ba1eikKhcjOzZknFfZ0W0SFN+FGUN1+U/?=
 =?us-ascii?Q?08Hij1Ef0p0Mx++detB+SveHdZwOD/Dx4BhnY+fVTEMdUQhasp5re/9j6dmU?=
 =?us-ascii?Q?7RKIWEi+i93k1XnzEhnvQaWLnGaAE+OMT0z8C+oELGLD/voO/9JXw0vL3fWd?=
 =?us-ascii?Q?qsHo0wRQiHe9TqCtGLbB7NIH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c64dd7-99e9-4462-8d38-08d914b59b39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:47:27.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkUtFUpYAHcKX3mRbpeE2MQy6GZiwhkxMVuWbsZSz9zS9ws9Ejdm5657pNW3aWH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:05:50AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 11 May 2021 13:35:21 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, May 11, 2021 at 09:14:52AM -0700, Jacob Pan wrote:
> > 
> > > > Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
> > > > does IDXD use normal DMA on the RID for kernel controlled accesses?  
> > > 
> > > Using SVA simplifies the work submission, there is no need to do
> > > map/unmap. Just bind PASID with init_mm, then submit work directly
> > > either with ENQCMDS (supervisor version of ENQCMD) to a shared
> > > workqueue or put the supervisor PASID in the descriptor for dedicated
> > > workqueue.  
> > 
> > That is not OK, protable drivers in Linux have to sue dma map/unmap
> > calls to manage cache coherence. PASID does not opt out of any of
> > that.
> > 
> Let me try to break down your concerns:
> 1. portability - driver uses DMA APIs can function w/ and w/o IOMMU. is
> that your concern? But PASID is intrinsically tied with IOMMU and if
> the drivers are using a generic sva-lib API, why they are not portable?
> SVA by its definition is to avoid map/unmap every time.

Kernel explicitly does not support this programming model. All DMA is
explicit and the DMA API hides platform details like IOMMU and CPU
cache coherences. Just because x86 doesn't care about this doesn't
make any of it optional.

If you want to do SVA PASID then it also must come with DMA APIs to
manage the CPU cache coherence that are all NOP's on x86.

> > I dislike this whole idea a lot. A single driver should not opt itself
> > out of IOMMU based security "just because"
>
> Perhaps I missed your point here. This is NOT a single driver, privileged
> access is a PCIe spec defined feature. We are using IOMMU sva-lib APIs, not
> sure why it is by-passing.

Until today the overal security of the IOMMU configuration is
controlled by kernel boot parameters set by the sysadmin.

This magic PASID effectively disables all IOMMU security and allows an
IO device unrestricted access to the entire system memory. This is the
opposite of what the admin may have specified in the various boot
options.

I don't like it all. Kust because the PCI sig defined this mechanism
doesn't mean it is mandatory for Linux to use it.

If you want the performance gain of no iommu updates then use RID
based access and boot flags that have an identity translation for all
RIDs.

Forcing the system to create an identiy translation in all cases by
having a single kernel driver create a PASID feels really
wrong. 

Especially since there isn't any real gain in functionality or
performance as it it just exposing the same things the normal DMA API
would expose.

Jason
