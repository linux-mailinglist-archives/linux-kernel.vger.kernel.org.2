Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61C37FDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhEMTV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:21:28 -0400
Received: from mail-dm6nam08on2066.outbound.protection.outlook.com ([40.107.102.66]:18913
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232014AbhEMTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:21:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyB217KQEm7AvlSJPpqQ4ba8X4mC3rvoRIQb1wI7jd0HUYt1Mz+Y+bmSqPRw7BhBZF1+ijuuQqBEGz8qJadGpx4CSuVxAXORBLRk6i+iM97794sNqMqg0M7SFfj4JLFobD18k9PPzCF0ulJEYViCy+3JY25KxkLBMTKGFbauK3A4pPsKpfe722nHmOI3OCLOBDHUZy/ce1ALE61WWeO9fFv1LyXj3LTyMZLmZ4wcKwoPPTxs8dqEGRDNlwnm+G2Ugwou/4rJG1yYdjuBeKnL556ViQTWz4u03DV/bcSAYC0TjNhwUx17u5tmHmkYLkmn5RKTBSwfnm5l3+9JaVNHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJVmC+ZqGRpXsBL5rf3iWbTnRiRD6KTm67xZzwXOJqY=;
 b=jPreL4P9tLGMpa/XG3C3Jsh4Gy9l5AROZ2+98B/3sXoAGMZNyETR6FOYRe2hf7t1ges4Irl7zXzFRbCAAlWN9CHA7q3OxP2TC7sDX4FaFK8hoIrP9wso+pzuej9ggxm+oV6eG04uorjg8VRH80pCUPMNk8vsIvdRNmikGG/se66r4wbgAnz/P2Mya7za56HyjGOxEkUCx2uY58bD9KwmeygnMnKMmkd2CiOqBUnR7Xv/61UGdfa63RBTBvfLfbr5+F84e7lW/IvE7WVsuvWl1Jc1kUXBoNqTwDOYe0nighupYtmte8ueDJ2I13qKTfz9lud42zLjv8/32UzUVhjuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJVmC+ZqGRpXsBL5rf3iWbTnRiRD6KTm67xZzwXOJqY=;
 b=UFx15eE08KZkZpfYel8zaalNV7uUjc2Xhef/nx4EjqFq6ryfE6nNx+OOem0EF3KSisCVuuVWQcWPixt2AHN7mcWFUZiW4pjs6nPNTrgvck4h2Qbjj7DiCWH2cm+vsi4Vh71dOwExaSNDfpBQS5f74/DAFAUzDzBTFSEvPtKMnpGo3f88rKL+/ukVFw/tXGqBSRz52v9AvcTKbHIeoKkczZokl+aqiQ3SznpuMqeZNbDWBGK+BrXxpZnaO3HY8M89bQzoi0i6eTszMSbqc133go1UVbTqT3XMAYi7vA9K5eDSw0ZJ4qeZL0EOiE62b/V3hvsbdOEEF6tEp4F6QQgVqA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 19:20:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 19:20:15 +0000
Date:   Thu, 13 May 2021 16:20:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210513192014.GU1002214@nvidia.com>
References: <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9dd39aa8a144c23beffa5ca58936385@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0387.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 19:20:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhGsY-007A2z-7X; Thu, 13 May 2021 16:20:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd28664-2fe8-4194-6d06-08d916442338
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2490029C94FD3E5D79F85E0CC2519@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZg/ZI2ia/VeaGKuE3g/BEEv7A/6LsubGzeO3Ug8JQoQlHL/L3+GfpbN38TgRWwCmdS/adlzYAswKqQLdD03UPP9gYpz8AsRe/EMR1MvXRh8KQNy7+aHCj2reNHIcABsfzW0HhD4JwIibXLZRDAv6dXK8yVJr2OoQ3k4s5+NfEiVBhn2h4CHbBA7rHSjXB3my3UE/jTpv/+zcKPdOsLJqN5BQrr+tdTfKO+AG6P+kO9Njeir3MOspZxNxPDyOUd1tBGNRXoJmVi4gKlAGV3PEC+zGIwx9VJLCQRsTimo3PQUvigRvh/Tlnnk2iB97/MTxxUhTXSvOGQ7ffAAOWF6J6G8Kd2B5Kh1mENfpcA6XbQqOLLF1ydYVlkQ3ZImyRE+/VwhUDRBpFOBhXK4C0B8ePejaCDvjmfwXIabVVbgIEKdr0LsJk79zF7UkuQgkGKxDYABtUT4HO+j73elgmu03xSN6a0TqICU2uoUaadwSW5G1royqsWNK46yHoDPEE/viyTdfTt3h3TuLkn+oVarYG+5+B9V/QGr9lVeuwRwb9u6iFbtS+oAl+V7LDsPSimtW3O4vZVNfXVm9MkhvR2XRhzkR3Z6KYnBgzF0gJKHfnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(86362001)(2616005)(33656002)(26005)(8936002)(83380400001)(54906003)(9746002)(9786002)(38100700002)(4326008)(6916009)(426003)(66476007)(66946007)(478600001)(8676002)(36756003)(1076003)(5660300002)(2906002)(7416002)(316002)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3Lp8PxsqBJAFYnoASyfrKlkYINtmnrEyw2uWTWE+oWq7j+SZrh/0iMM/cJmN?=
 =?us-ascii?Q?x8oC6jJJLnmvWNjhsbnuBR6/FSncimQ7r330QOd9R2eBY7R/UkrWk+ghhCk8?=
 =?us-ascii?Q?JuFKFTNCYWadsotiNU0EH0lp0l2hvMDkg86cgSdvKod9skZyWuB4Exm09WhC?=
 =?us-ascii?Q?wGnFzIVECJ1CvofsGxODndptyYc3SWskUt2jYtFbIm+dtMtAe/vvmwUwjoZu?=
 =?us-ascii?Q?D6wsh4pAencTHgTkijH4EQgrihsU/unPI839OA0MfCLje5w9FFXabauSVYnT?=
 =?us-ascii?Q?hijcoFeCzXxaqYWpp7AekhVt+CF+K/iFOOEQuNkRdXUvfaa/azWya+s1wilc?=
 =?us-ascii?Q?AXU9YWMdP/fSS1qYozBN13ze0CpFQtdn85Q70yB+lXJlKW7LhBmrLKr6XzyP?=
 =?us-ascii?Q?gZMVr/ng6TrO+yAF11+fW/fReyyTcPdFDLPvwc9MpTaeet8JiHREyPQsrY+n?=
 =?us-ascii?Q?8Cnh18b3z0ywYlxye1vHeL2opWH1QymXiqqAc/MEr9m1M8/xiiO3E2oFoZn3?=
 =?us-ascii?Q?8pGS2ANTDmd7s25EemUCuLet6+MvQePcAf+OiKDjzfT5Lh0tUzqILC2aT7AU?=
 =?us-ascii?Q?3m0gc0XHYiowoMlwVaVHEuCeK0ruqaPMJbKnIdKTxHnMBECfBFjBFg/VcgUR?=
 =?us-ascii?Q?RPx5SxY32awA2LZziCX0J9DKix4GlDwPTKwQ/2I7VwVsiQgXBhnWWq2GkXPm?=
 =?us-ascii?Q?+C3axbXjGEjC6MgwXVUrD91O6eEupdVs9aNsUQKl/s+KqNyH8/VZps4rM6NL?=
 =?us-ascii?Q?oxY9NsfeFP6cGzlB/SPOWw7p8OvQoyjPNtm08kRnbBwF3bB7bk7TQQSk7dVR?=
 =?us-ascii?Q?StlGbHbBiptZlo9mHCqN3DmMHXLx5aNKkk4HGrZ/446O2nlol3C0DvQisWmU?=
 =?us-ascii?Q?rOr50RvwJpWgDlDNiXzrM2sXJdAheM5OlAVeGMhU8TKTR4hddDT7xX2zKX2n?=
 =?us-ascii?Q?aWgTrNVCT9iKfqto2wapR36HPWwmkXKVpBMJ7Km9MrPZ3YVuX+nZI1Nm8CZx?=
 =?us-ascii?Q?WJNjEWG5SGTKSQTCiHIrMeB8Lcst5mBSIea3X3PU+oZOUpEqgvt3HDyvPLJH?=
 =?us-ascii?Q?g5wODyLtPhlWw/qp502MVF7TBNtFZx2Zx/bfTywUY8MS5l5bGM/DW7vdJM80?=
 =?us-ascii?Q?kpe1aXSFg8Cxohter3C1KGpekqGblSqvJIFWLyUdMnAe9Bg6sG7B769qVtBC?=
 =?us-ascii?Q?AAItk2HedfgzhFf86LsBJIsw/y1c2SEtND1OYxFQD1vVjSnVLNJ6r1gYh+2R?=
 =?us-ascii?Q?F+WgAnvsxdKGI5O4DJeuhXksduXb+HtVZfCuc+3lmKDKZVx1ApHtMS9XHBmp?=
 =?us-ascii?Q?Dqw2S8HkwdX2x30MPCacM/J+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd28664-2fe8-4194-6d06-08d916442338
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:20:15.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oGuPN9U+t67HQzNY1lpQFL2vx0QD/gmfd8tomulbxxvYkuUwxO0oqem8E/oSOpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 07:14:54PM +0000, Luck, Tony wrote:
> > If you want this then be explicit about what it is you are making when
> > building the API. Don't try to hide it under some generic idea of
> > "kernel PCI DMA SVA"
> 
> So, a special API call (that Dave can call from IDXD) to set up this
> kernel PASID. With suitable documentation to explain the scope.
> Maybe with a separate CONFIG option so it can be completely
> stubbed out (IDXD does *NOT* "select" this option ... users have
> to explicitly pick it).
> 
> > I could easily see an admin option to "turn this off" entirely as
> > being too dangerous, especially if the users have no interest in IDXD.
> 
> And a kernel command line option to block IDXD from using that
> special API ... for users on generic kernels who want to block
> this use model (but still use IDXD in non-kernel cases). Users
> who don't want IDXD at all can block loading of the driver.

A generic IOMMU API should not be IDXD specific, if you want to allow
some special "integrated to the SOC accelerator PASID" mode then it
should be a global IOMMU API and any security toggles for it should be
global and unrelated to IDXD.

Concurrently it seems necessary to have a solution for secure kernel
PASID use under the DMA API and reserve this special mode for getting
higher performance.

I think you need to come with a proposal, and it is a bit alarming a
noteworthy security hole was added under the guise of "kernel SVA" :(

Jason
