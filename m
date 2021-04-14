Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A797735F261
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhDNL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:27:05 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:55776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346583AbhDNL00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfLdK6ZD/ku3OpsnVkrOgtyyyHpa3Pn4poSMgUuDgKDbLx14AvOEom9OwOS6zKN2b8NeLngjw95XfQvbPXJhuLpGTto4584LgXwZs9jW6pCYKqLIMFPb/UMHSYfCXh7bvP/ygFOvabv3doXaCMg7ovPImKG6C4sebCmNa+8P0IL0UQf1KxSl/dp2OOxSaoH8vouufewTuZsSoK3GIl0qfuWaCSLhjJBWit9rp4sefUJGUiINAdqXssLtzxyAR9dOytwZ+x+dy0OXz+9kIMRvNMJN9gLoQocJ499IvrbYxO4YmJKK1Rln4SCGJvdlxdaleztXhAbGkGTyZ/NnIf8+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76i6l+cvAAnAb9Nhd+jhna5Gr8bMOlYByZlpNECA0pQ=;
 b=CiDbR6bgXRYuPP61oTjj6B157BPlVrDlCYf6gsbrvAl3Sqqswm59XorbS1CYCmrCBtNulzYv5xPxH9Db6lysqneWGnJT03kEFEAAU2XmStcCNJJ3asvadmd6sbWA1c733Qfd7HXO2GWv39icKOnbGXZO00ywGHZrOK/qLkiqghau6IeYwTSYBxAwuNRioQbp9xWnELDKlGmS3y9YPabMjOV2+GGK9YWBDG+5mNXF1br42BLv2QVOTMkrPyVapJgwDsyP3o6N8PLA0g4qVddz2kl64SN0FO9okmQ5ygOHwwVJyNBOUoSdaShl9gOMPk8q7xfdSDvheFzmMxR1gruVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76i6l+cvAAnAb9Nhd+jhna5Gr8bMOlYByZlpNECA0pQ=;
 b=HZSg0iCl/jtCWlQeUViDKQyHOVyncDB/zuOelrUVScfcJ6Tf9MbwYqaE8uU4GH4dHb+Iyn02A/nlEpk/AnnhZ4Sa0LBq50arjLajkR0BCR3vUG4mwwkHJaQRdaa1oXFWjdqwg7AHjK9UL8Qy4v0FssSpXF6CD5y88r/8cnnaD+0GYUCHf/9SAOPCkkZPpJJSHmWm5LtX8Eh+mwLfJKvmUdRP7Ne4pO3qFnd3CUnCT1FV2fVaDQOwhT0n5WaWmyWxiQQwbUY9Q5W2lW+QltFttgldV5EX+xhAN4+nKgHr3dmGKYLrW69ZIKK+HPImFNt9/uNHZ+mSiLN2Im17Wu+6Ug==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 14 Apr
 2021 11:26:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 11:26:03 +0000
Date:   Wed, 14 Apr 2021 08:26:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210414112602.GA1370958@nvidia.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YHAoY9+w2ebYZ7VV@myrica>
 <20210409110305.6b0471d9@jacob-builder>
 <20210413170947.35ba9267@jacob-builder>
 <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41433d99-e413-f5bf-5279-695dae6c58ba@linux.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR0102CA0006.prod.exchangelabs.com
 (2603:10b6:207:18::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0006.prod.exchangelabs.com (2603:10b6:207:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 11:26:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWdek-006316-1w; Wed, 14 Apr 2021 08:26:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70b777b0-b08b-489f-135a-08d8ff38166a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435660DB9D4F3FA28033787DC24E9@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wMdUJOnVkg9RVQFYjbiNHltuh3kc0F9TvlKi0jpXYJKtKEE7K71xvaF3NEEnvvIRF8Tvh4drMEWcEs7Nbi3JzJGB8Cby9Le6uoC7zsjqTVvwmkPXs3xicwOZO+Sh3qpt5Eblch/d1NdtT3niuXOVQXMG+I/KEozVIwOuQMBQqn6IIIopYIGlTKs87ci2f1+7dMhfyD9P7tSHGiGfE7hqOmVxKqZMOjT4jFVm3PI4o2Xkj3Mu1e7t06+41XxFfQ/8/onm49U8z998NEcqqARFoFThD+FV4u4GnWPZspxO1aP1upCsGKQHJmVhtC92G0i9D/2LzNtTnpGgt0i+kM65jeFRKUTlGvvORB0RjnMENwqu2Gm6ASBNAqlb1CdRbq7EELbWMDKD8m1ccBMJWLy4mZ7/jrfWSN96LivOoBh0VoL4LDYu2DvK3ss2jCOZiQD3Kpn4HxF7NgJwpSNKdgQiP+lHuOvCAP6Nq/99vXZDpDqPPKpXvpD2egeAYTTdsGgptrA9gxfUTBTysjgd8ClJQFTGqga9fqpiYhGbBlJBrCNwtNNp9jN7NwuI05bkx7FxPsU9jH8wqiU7K7ZLpR0Oz+VlOFKT/R2fHiwnL9pxz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(8676002)(4744005)(7416002)(316002)(6916009)(54906003)(2616005)(186003)(2906002)(426003)(478600001)(36756003)(38100700002)(4326008)(1076003)(9786002)(66946007)(66556008)(33656002)(8936002)(9746002)(26005)(5660300002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dzvIaYp7FaH2rawdwXHLKultTWb/m1dNpkpBs/toRxXjT2KHExxRqojGkdyA?=
 =?us-ascii?Q?49v5ZtyfhX4HhVorOSIbjzjtmhM/Sg9VO7d970B3eKpiRI7kqJvJak3KLd2p?=
 =?us-ascii?Q?1Ey/41MJYh5i3IzRjpMvpjqzyCcTGn8p+GVdFEIwM5CVLxbJVl4CgW3BGsqQ?=
 =?us-ascii?Q?79ihtms/purHwVHYaQbcAsRfnQzFKq39rZPX0gLzmB6ZdlTI9iQHnMSuC4XQ?=
 =?us-ascii?Q?rqvJn7v74MujMmJfolc7X0eoARmcRktrrGmxy+Ero3NpEOEgPYQfejQyZc6a?=
 =?us-ascii?Q?Mcm6muz8pzB0pzEVTTmA3flHzuwzvnxKO8slOJK5ald6Q3HoJsBP0db0QVpz?=
 =?us-ascii?Q?kw1EzGIHR0Cz+vGOm+l5nr8QNXGf/xKJgAzlgAmbYpVRrpylhefV785njQfw?=
 =?us-ascii?Q?cyCzOZ99OhHzR9Sv1gBtqBEUiC6QImaERwWm1Fz7Obp8wx6nPe/vuYI265CX?=
 =?us-ascii?Q?nwcoCGvgUDZHxW2b9ipUEUfX0lrftpqcBLyl2xvK+jR7+zqq+iKF5qmZC5fh?=
 =?us-ascii?Q?nff9t49XeRFdfeWXNKs+qs8nK1QO40ovn8zu/nq++JS8l86R6LHML1FnJuD+?=
 =?us-ascii?Q?5EjL6jeVIKx09pC5kWiNJ8bqoefQby4SqGJ3J/HYGvEdLuZUtbPanQPWLrGl?=
 =?us-ascii?Q?kXafIldOePDmGA+KB2M0m4NwCybFXIuqPQMi7rflVq52CYgcuOYf7YWPzpXa?=
 =?us-ascii?Q?Xuelq5tF5lZlw1q8d0gstCOyL7hp+WdFyt2N6b+hFm3JbpgLRG+Oj1ZOIzTt?=
 =?us-ascii?Q?/uTT68+FxI1PvsCiUHZBxpgK6jT5y+gHUTr++y3xVnc1eGO3QYG0NZ/I9Z36?=
 =?us-ascii?Q?6Eja6NbdXx6tLlHOnGEV1zzhhhpQTKpjO366koDEuexyC8+pq8oS/vuvG6By?=
 =?us-ascii?Q?CEbrB+q6cjJY7q2KgU59LKioQKCWSDWa/ty5mX1//4JdXutIkZehIUqJdbuO?=
 =?us-ascii?Q?mLwM6sddZYF9EZV+5XdhIfM02OrqpR9W/RqTZzGcfdMjWSt3yMtAK2twfNdL?=
 =?us-ascii?Q?WMe3zZIvZBW/XQlNAF6bafKOrOaQg/PU6uxUyhwUF2HioWGjvYDDkaRs8ppP?=
 =?us-ascii?Q?aFENCjMqSEV5BxKbOCqMZIF3COE3mUM7GCQEC+1736kCGM80uxlSv81dZLAL?=
 =?us-ascii?Q?a+/fh1e8HPdfUXcFvS6EcNY01T/Tejie/D7WT4YphWO4tphsGjTKrbr5Jfom?=
 =?us-ascii?Q?JMicPeQFjVxmH9uboCh+SOTfeMqcH0TUI4G8xDBo1P4NF9yPiGK8lqSRM4mD?=
 =?us-ascii?Q?JnuRalhjuaTJ8AhfAvfcEQQ5ylHLqArYXZCujoR41hsWWEtdpsBMX9I1AeUL?=
 =?us-ascii?Q?IpTWx6/wQpSlZ203j8W1Ff78?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b777b0-b08b-489f-135a-08d8ff38166a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 11:26:03.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFKs5kPlyI9E5FZJVfnbrvDHU/vsbr/DLAgsXxm8ydFP8qgnKPHjONDJHmik13Ld
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:22:09PM +0800, Lu Baolu wrote:

> I still worry about supervisor pasid allocation.
> 
> If we use iommu_sva_alloc_pasid() to allocate a supervisor pasid, which
> mm should the pasid be set? I've ever thought about passing &init_mm to
> iommu_sva_alloc_pasid(). But if you add "mm != current->mm", this seems
> not to work. Or do you prefer a separated interface for supervisor pasid
> allocation/free?

Without a mm_struct it is not SVA, so don't use SVA APIs for whatever
a 'supervisor pasid' is

Jason
