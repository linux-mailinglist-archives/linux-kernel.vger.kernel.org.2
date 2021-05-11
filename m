Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AA37AC08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEKQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:36:31 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:25153
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230315AbhEKQga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQIPfSum5YkYdlzwtdn6zgeo0Bpvt6dSOqUcjB0gNOl4vILZjBZP/ucxak7U9fynuU80QFJ1AvxDduacDnETIuVz9qPCPZiLAM7HtsYXf9T+iCJzLXYwMGTXLzZjdr73N6uUCzR9V52loh03SLaCLaxdzEUIjah7ajimgAC8bUmdGScejelSUCw+ILDCxg02Pda5ChCXyYAVE8E7RJhcRuicyL2soe+Ce8SYqElspMAf8eByQwnBm4lY71EUQoflcQGpMAH1bmKZzDOToR0/VtrulfHpS6BGvYdFUrGhkLW8gt2CuhfYRaF7zQSTbkYPrCNjvkLOHoAQ+wZjK1AC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+rIacrHvrrgUeWexhjJmh1Wujz2ImysTtRGLP1AMYg=;
 b=IRnrUKRakVqOCnVPeAkc0LXFoqoHZctaFyRlWFZC+TRQh7f74DBKKLVqkgufe8DSMNMQxQva3iZcrMvdPLTTXpCM0uRZBzFz60JMgZvee62fsoCRLxj6tW9p1YMIcg1Rdb1qcJEYSqBPHh9y6GSKPlNRQaYwV8OVqN+W3raws1VIfen8zt+w+2VYwr86mpPo5GnsNivIfGQA9xbCOdkJazWZl6ZuapvRahrXgN9J0SErfWswVMrqBaJbFVflvq+k0fvvDfomnSeSbq+WOR7kGIRc/E31nMsDPE76+7qGO875kWgbv7Rp0eJHTsOqsMQjbC+WExhlyvMrjh9YtBvvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+rIacrHvrrgUeWexhjJmh1Wujz2ImysTtRGLP1AMYg=;
 b=jI+mXqdBvXT6VjCy+d03KQ3UlqYrkNc8+ipysQE2Epv5JnoCsqSvzhjQXpxojQ3SzM++co2STnIgvlDMNUFSKhGLsO9Ktcr8bUFoAX9NdKUz3vUuRBRjGff1/vnOslrDnmhm0HlZ6T+CkdFhPwUBEU90BryVoOe6cnalpJlDt7VnszPLE0EcHNGbaAqX1K/St53UE8vdGk2bqBNgu/rPLBm0/NVVhv+RwFCW7odG4eKJ/Lul1zVHWDZnNnIeivgSPmXPSlbDIsbRLvT/M4ulau6UtT0QyALuIQ3gud+YKJu3XAy+bb1d1QeoIctjID4OWgxg+a4YgLTTDQiZeQkQfA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 16:35:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 16:35:22 +0000
Date:   Tue, 11 May 2021 13:35:21 -0300
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
Message-ID: <20210511163521.GN1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511091452.721e9a03@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:208:23c::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.50 via Frontend Transport; Tue, 11 May 2021 16:35:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgVLt-005Ovp-Fw; Tue, 11 May 2021 13:35:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 290f0070-c1eb-468c-3f80-08d9149ac5d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28605C6482CAF0DE42116E4DC2539@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USrIS9rtYKPWZl+HtLt4Lw4ngtk6XL0ZnrgzM4F/DbsiAeNUhjdPRyPW2YkugJEyJJrden25DWtWAQCPSiIlVKlsOx4YfxCOTHc8I7TAhVOLqrxg9/H1QPeuS60kR8AmSg9ankdU5TH2lJC23txIeArsCmALBxwLQvS5Abz0ka3xr/Lnqpy45zyZCRVrBn257mExHH/3QgVxxEbRJfmu6AQArrVESqMPdOeMXaZNo3kc6lYtdTQSp9geGIwabttjcmSFHIWtsITc5hctotx63K7YfBjT3ntL+8RYSkXfl6Q/w3pPDuKeAoN+/PXsCZYSPMrmXH9GAcW2O+W4750ecRUtiAiKGaxCa6WfEob1KlXRZkHOQUhRB+HoE9tj6OVvWlpC0pjKQ0nnIUEvWYiTqaAd+jWxUWyJNykC2slYWUuVPNfnHaIAtOKbvhHEMsf2hQyu7kQd/9YJaxaUQUU/czVvwN/q+M9xRj2HU6uMQiJxCM7TsjTnMDRBSwqFH66rZRPGJ4e8TDYg3hH1eyFJNJwTrNNqPZIA+UW9mYUeFygKgeBnhkjX8ttZCghgFzwKhJ3bbGztRVxIPqOJmM0xGfhh/i+Y23HVd14s49ZsTBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(2616005)(6916009)(38100700002)(4744005)(9746002)(1076003)(426003)(9786002)(66946007)(83380400001)(2906002)(316002)(5660300002)(186003)(7416002)(8676002)(4326008)(86362001)(478600001)(66476007)(36756003)(66556008)(33656002)(8936002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xSBW7fBfFSlPftBoe1rNO5HLF9XqCD9lJGoazh+OHW++5fUcVCzpjH2FBHq4?=
 =?us-ascii?Q?Mm+xpub9MNpODHjODBDSiUnFPNG4Jue632O1LLsG1V49R6utz+aXT1BasuG4?=
 =?us-ascii?Q?pJQrntUt4fWbjXe4p0dk5/2nQNdXN6ZKW8MLTLPCXWU/NV4iiT3amPpyEu29?=
 =?us-ascii?Q?7aDP02Mi22mNONlFQYao9rPSXAQWX3Rp1CD/9klXWdSNPlE51hScCejXJvVM?=
 =?us-ascii?Q?vBfTt2Cg9LPDcWbHLHzCuuy8hMAjvzh/rIcsbggkfgGijgTpDUYq3C25B/d3?=
 =?us-ascii?Q?UytMtp1TEyXlcFu6Kd7VLwxcDC4QIfLz3Vlp71Hv05DoMH0cF02ljfDSN27+?=
 =?us-ascii?Q?08QUY9+hBfFZ8lxInJaMV9sCzg5l7IUMvj6lHz7UDDvIwndmW9VippJJL6f6?=
 =?us-ascii?Q?ib+B2aJ89tkmP6hEV4RR3LU9ircuByF2GeUQW0xpYu5j4b+g7ETp57/0Bx2E?=
 =?us-ascii?Q?pqctVyRKI3olQjse/g1tsnby5Cn/Wx0ZkGe9HQz7uhHeLjDJaS9wcB2Cu451?=
 =?us-ascii?Q?SbS+xTHMUX771Hz9sKw7je6QGu7r4/JngEj1Tvrf8IM9wqsxiCmmCyMaZoHE?=
 =?us-ascii?Q?CAnyi4pwq0wKvj9OHzRl0iNqI62PN2a+5CemnDGFHiqvO6zBiDFBvGvzvnRk?=
 =?us-ascii?Q?4qdWLCVsNSbi/rkpTrpI04JTACWCvyavYJodH73eOHMKnjNvP+/ZRL7ATJfY?=
 =?us-ascii?Q?XpTflG1upefI0CHIjfhuCmQ/YxuVb4rtonW8SoBpJ7HE2ZjAF3BQcdk92yVO?=
 =?us-ascii?Q?4gnkW0MAbgGCgJzHZBHmBIeiuZPdYwP0GjOzCy5KWlwcMRwwMiKdfN2ogjhe?=
 =?us-ascii?Q?rLzJ726MgJla4Pa9NeTgO+4S7bkq/brbQHpAgc7hzyL51JtEzIaiiK1A9yGp?=
 =?us-ascii?Q?+ZpG5dvV+IZWFJ2ryPBmV9nQWO4F1T8VtNqVRTgfrLzBFeDAM0MUL5IVvrLL?=
 =?us-ascii?Q?PRYRfhHgE41RfCpexRAdYVtPXgMn2Wf5nk6A7Z6iHcjZvSkaes2JZbO6ZyqH?=
 =?us-ascii?Q?knFAozwjnjzMGwG0M14Vr1nvZIdtMLFR0TahDkZy2kk+VJmzge0xvDZEdPlj?=
 =?us-ascii?Q?GGiFJgeMmrvOjg0sHdtfWN6Q9h3/w3WPMwjac/r1XUPapmca/cOjdmcD95Ay?=
 =?us-ascii?Q?bJRvi2D8CUiQPc3Z9VFE/gKwtQVoXqJNRTvbaeEODG5EgJ1i3Ev6V0DYK6Fo?=
 =?us-ascii?Q?10JT9hV2IgbCkznAGCpr64CJOGUB/KVI///ZUoUNalybe71FMCDMgXJ1NJcl?=
 =?us-ascii?Q?zoJGB7N1xPDA8v/KMGgbZyFd46fbzZR6+60p9xZa3CUjEXIWz15crZ3uIl8e?=
 =?us-ascii?Q?vF9KoDQ3bR3TgZn637xJh6NF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f0070-c1eb-468c-3f80-08d9149ac5d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 16:35:22.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NztL9+2lECG0MzzC1wITde0xUEd9JCY5DbNBI0ox3rJdkUk6moVxGmR1X8m0rJDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:14:52AM -0700, Jacob Pan wrote:

> > Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
> > does IDXD use normal DMA on the RID for kernel controlled accesses?
> 
> Using SVA simplifies the work submission, there is no need to do map/unmap.
> Just bind PASID with init_mm, then submit work directly either with ENQCMDS
> (supervisor version of ENQCMD) to a shared workqueue or put the supervisor
> PASID in the descriptor for dedicated workqueue.

That is not OK, protable drivers in Linux have to sue dma map/unmap
calls to manage cache coherence. PASID does not opt out of any of
that.

I dislike this whole idea a lot. A single driver should not opt itself
out of IOMMU based security "just because"

Jason
