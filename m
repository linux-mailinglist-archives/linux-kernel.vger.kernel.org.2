Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5B41CCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbhI2Tli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:41:38 -0400
Received: from mail-dm6nam08on2043.outbound.protection.outlook.com ([40.107.102.43]:36512
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245483AbhI2Tlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:41:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1YOHFAwFltQ/HJUkqFbGtGuHyAZz4TylMcGu8uFpv5vKP9J5KAyRZPZk9EAcvz3HIeZtSpmkSaKONCa7eueYcjFQY5nWfaehnqjf9wPdS0CjhA7+8FJ7SKOrnvi/fDRK/pbjeXYXvCkMMt+i8UL8fixMGlVj1ovW9pk8osAO0mc/o+1VlwdFWPjd3+shVInMaSKz2GeMSaTaft4mvwy0gmoWhaWi90j2pe1kYDZQ9LkQ64Ahu4p9UNFd0Agc75LfzASmC9iVBSAWJRt+2ES/entGncVWMKcmgn6stqKBUBFia+cMJ84UlnV0OPdkHUTc0Pt46pMS+F4MM08eXCO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2vVce5wkXyrwxVU9xY9nSOZT3cQuvFwA61m41gwwiYc=;
 b=R2YVXsMAGElBN4heLldSg1Vo3tg/6sH0fkqgYnd+oXJo1faO0CkNRWyQ/FMHNKHMT2veoqqgq+jcm5t7lsZMtUEWwyUtAcnPK1iMyH4LXjXt5+ux3gYoBRfdkv8Ak4Ryr/t5qZpX2S0LRftZ43fEJB2TlOOT91iGBImCUibGXk2PkbJ/oKHh2tNmHW7sD4hnPgcj/N/2RERdfAx+WYudgMEayBsmcXMOeqMYVSW/TnXtYdOIzpMGx3nVKRoRIZMyGh+RhfKBLIEJoO3ivBdMZjWg+kJaLxwzGO9pkdTgP+GgM5HYVpA5T70qq513rRT9g8BvCKA58u9zzPoUbudsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vVce5wkXyrwxVU9xY9nSOZT3cQuvFwA61m41gwwiYc=;
 b=n08kE/ylsSo35lZMSwsd7fnlinRC2VrlgxCA5CjOy/qxY9jbvHdq5Q7mstSasLJE056pH/saph5ZThnSawHxZXVzzjPlCE5yReo4WjlkiRcG/viNKL01h/JjA+SmWcZ0Y7ckwHv2kZm6YmiLDqnWpk4RzowRW0EPPyHfIDjHkuAh0NO4++B8arTbyLCuguGvoxleDJjGStdruhr5HlmzEEytdWmdgOIiwsV6tJDCLq3FIsvV0yLlEkbdc8yJhXUsgloLXgmQ0x5FFLEiXDKHC5t4gmo/DblUeqFT2rOpy0ycSzsoMcLB5oad/+MWyx9gh8yrT9ULOSnE/735C6+9fQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 19:39:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 19:39:54 +0000
Date:   Wed, 29 Sep 2021 16:39:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        mike.campin@intel.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210929193953.GX964074@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210929123437.721991dc@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929123437.721991dc@jacob-builder>
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 19:39:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVfQn-007fUk-4r; Wed, 29 Sep 2021 16:39:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b7d437-511c-4835-0013-08d98380e990
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51748E24F8C6703DE9FCAB0DC2A99@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xF64HQ+JDdS+tXS7Pe5/ihuJEmzRUwjWcGWbOldRLHiCaw1dIDfgjg1nObWwE5ffFMbXF16tsG/JpRku0coiaE55eGz6+NSp5kf/+fAxH/lVZC0PaAeRo9XdwC5SPDG5FqgG0vQnnQiMlMs/CMRqJmmf4yCEyE4/wxOGMLeoRE1g7gqwiUbQLxG6qYXi2w/o55w2NivnPIY7+dkgZ31SMPTPZT67emZfv/aYqMHwlJiI6oL75kJzPWrIsNiaKkHX9KYWazjMW6XtMY8saMr7tSpnhAsuHndnze8mlauFb+KSfXbSRTfDpvqiiHpMBF8h4rHcgl+zIKnVl43eY54Fbmw4ie0PlvPWKjiYQX6gbu6nkrCQeEdaPiQ/dTgRoywXU1QuXB0EERsoObdoE43ASnErAzsWN9UlS0jCQ9IriIZCcEPpqpg7OfiNmHDNuHtGA2MvXfd5Btl3uV3bTv6OpCva4wkyqvvX7GiekqGtbm73/82pf8C6WQmmDE5M1LwfSmLmRPuUFd2oILlTxfKo4/uBDNrW3ub4xCIEzH1Y9d/kWV1ss0bbvwvivdm3+wS84+upO4z1bxVzwLfk/2HR1vgMd3YtpThDsx/2xpd2kaNH00UE5c8gQt+NSljbZ7CoSnBSmJLPTjJ8czT0pvlSNw8HDiZqAQ2SEIoy6KSQQg9iZ3YmiT/thyHBet6assPQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(4744005)(36756003)(26005)(1076003)(9786002)(9746002)(83380400001)(186003)(33656002)(5660300002)(4326008)(8936002)(316002)(86362001)(2906002)(7416002)(38100700002)(66946007)(426003)(508600001)(8676002)(2616005)(66476007)(54906003)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yhzNSW7PVjl2zek59jqODy7uJaOZD3o5Ku1DGhi2O5ohxDJcuKu0sFhAqRQt?=
 =?us-ascii?Q?i54Wn/161RkBJpXNCuoC9X7aYUbNEXnOXUrhmxzdAggUBZddcNIVpifNzzOL?=
 =?us-ascii?Q?PxrZnJ6lbDiFFaPU0TYm0b6tba/wnYfOrVVDe2hGXtA7c1quFrMPy6cXVLUQ?=
 =?us-ascii?Q?RZmhW1W+SLm+PL6rUVms6UQkGdhD9pe76d3jg1DGZo3fSGweJUdHSNGRhXN2?=
 =?us-ascii?Q?S6jCD3QhdtkerZ/5/taSNkUB6cppQ6gbYSMrAn5CQJ4LaKbJYDvasjAchgxc?=
 =?us-ascii?Q?zqADoQdKVWDz7Qm8tmYlSvp0bbCAgSNUKalQ4XzHoxYFP43DlnvcsNV6ll+L?=
 =?us-ascii?Q?ndr8lkLygDhsvK7BUCNfG5XV/Momws5zbJvsA91bPgnDHBf8iYX1hJOz6OEK?=
 =?us-ascii?Q?XVwMgb5cElZ3TZ+CW76gnSAQcexO32DMlBokCpvtQlg0B1rIcSRceysW8F1G?=
 =?us-ascii?Q?/y6TKuSQAHtQmUyDj/2dSgYESscX+xm5mAWhToaintELXHD/sqlaMqxQUMqN?=
 =?us-ascii?Q?mJ0nW7lQxQAuyyfwmZ0QXXPF4KJNmHyyssFKsUrck7O6Pcj3zgnjviNSVgFy?=
 =?us-ascii?Q?YP9H/8ay0rODLoZ8uCpGGU9ahEtqUGOv2vCIcLqO96QBDeV08QeJ/E67dSPg?=
 =?us-ascii?Q?PAlwEMUSY7t/X/yyIExbYfw1cd/NExVAPPxR60CdOsZbRFA9QWqvSgltiSPB?=
 =?us-ascii?Q?dsKXVAiiTaVR5Wfv3xefw6ThMKNzt9J5jmQUyFd6VvtzSwe9Og2KJ0uObuM7?=
 =?us-ascii?Q?O2dpE/AooE2Gw0oY9uFIXncRppvQBJbaszzLtEPijCTze39rXg6uw+LsJDpj?=
 =?us-ascii?Q?MzsN0Qct/ptUckXk83F9XwsdCixxYB93SASkFj7HKitVDxorpo1VSloUS+3Y?=
 =?us-ascii?Q?W23IovdE5JeuClDcpoGiIYQLuGWwXUZVoSY/pUPs6fCXLzMo0YJnhI5pB9ZU?=
 =?us-ascii?Q?YAmm43406cHtoir0M6fr9Ep6qA2voS6b/rAhejHnYa85NWzIfkcIdm3rqAsW?=
 =?us-ascii?Q?vu8e7/UYWW7A8cqGjcqFdQ1dWhF+GALO8lSby9UK6oJQ4h1gL61h3J8vBk9C?=
 =?us-ascii?Q?uF9xxjQAL2w9Nyz/2YPG1Mj1iYXxnZsYD4mtt+pLrc1m6Rs+aQM38/Qr8Aqj?=
 =?us-ascii?Q?6nLf+n6QURDHt12x0f/51X1NXMSZBakeF8C5xTVk2My6281tdV9I96zu3SdD?=
 =?us-ascii?Q?PbKrG0KAlQavzVVRC1n3FAS9PdioIM1ymQSM3mdEBom1dCHpxrlWvmB3hYgl?=
 =?us-ascii?Q?Ab69HgVjTCPTe6WdUmg6gHXvhgbtSFlzEne/jN3CTqVAvh+YVNkjUq3HnWR4?=
 =?us-ascii?Q?Sb1n+LH0e6rYVBka61O/dL5o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b7d437-511c-4835-0013-08d98380e990
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 19:39:54.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6guRSAC1N3UQADoWR1VBaXUn5Svv0upyo+9SPinhlvZM1yN0sjXkBPZnbZuv69A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
 
> For #2, it seems we can store the kernel PASID in struct device. This will
> preserve the DMA API interface while making it PASID capable. Essentially,
> each PASID capable device would have two special global PASIDs: 
> 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> 	- PASID 1 (randomly selected) for in-kernel DMA request w/ PASID

This seems reasonable, I had the same thought. Basically just have the
driver issue some trivial call:
  pci_enable_pasid_dma(pdev, &pasid)

And then DMA tagged with the PASID will be handled equivilant to
untagged DMA. Basically PASID and no PASID point to the exact same IO
page table and the DMA API manipulates that single page table.

Having multiple RID's pointing at the same IO page table is something
we expect iommufd to require so the whole thing should ideally fall
out naturally.

Jason
