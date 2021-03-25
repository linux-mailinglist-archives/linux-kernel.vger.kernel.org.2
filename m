Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC80349973
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:24:55 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:10208
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229989AbhCYSYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:24:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScNHyoBsZoTNWfhjtb0YmD8QeeTtJZcnmtUuzyj1agyp/Jboonu62fE9UobVKdpRPQppmdoSnz4yB/xdJFR9Ak5mXqSzKLyrJxE2N42egGJD9L4kSAEOalWHTGIRzIF5AwdOLQwImllyhChAaJaaDuqPPw17KrVZj4FhB/3HOLNo6oyRZO9LegRU5aipMHh3ee5aAQ35op9R67eqUOmw0uFpSKL5aBaY2kc8SBbjkckDYrEOAT/+E177AOWqq6tHXTqXk3R44gq3kRZRRQpgo4gIdRW0X/7yk1ClOT9Eksjf3c0WgMM+vWUHDj05wqTNFCwvVBtav98jD2ngd2SR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SqROZLZCOOjBoKMVH+WjvAQ7Q0h2QgpzUijtUHTYMM=;
 b=S2g9JQnQgNbTIsEzJvNp/QPlDuKZcJhENHrGys/mM4F50v2Hp++XRdgiAjcm8qNKAxN5lpu4zA3tb31FxpslObFRnjXUDAqXnqOfvBARwkqJL08Dazvo/K48p1ytEN2tHy7KqL7CfmhSmTWgvOiLuMQpwt2jHy6V2MFeah6onuQBhRTE92fdR1Qgdx7TrPPUBvPeQdseyh0fd9jD73Xh0TrmyS9bta0uvX049ctjjUy01kBJMrJC2bkjjhvGAgs55htKF/9kdS51jXDxjVrArvdik0sV9ZZqXvbzEsbYbKm6tw85CGikPHs9bKVH2yet/KWyDCUwjSpoUkwCS93z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SqROZLZCOOjBoKMVH+WjvAQ7Q0h2QgpzUijtUHTYMM=;
 b=F0l8XvZAJJO8/y5M1bbNLbZUZEl1mas9T/K689DSfyxzW1Gsu7ugw7BrgaEDKqVUtc+JENbf/MiRhxpuiqdEGfIJ8zhhPIWnluElM1FILtqNFX7ZWhbHlnwQdD8l0X696Cf1DDh6ARgPx+LAh3MI1aCwDo1s4FLMbZKOxYC9/34KmYsW4fyB9GQN5V2ITEYpCi6Er9wjxwSDBh6FXECYxzhbcZ8F9cD7mbpIKLMTXyr4mu6lkevGtiTkt48qpPYXnLWfezZaHWZ0kGUS6/ntnrMVJAkAQyscwNOkj7fzEu1hoh9+KesN/1kmsCZZ9XkBMlVpRAmM2e3sYhwdN4upVQ==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Thu, 25 Mar
 2021 18:24:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 18:24:44 +0000
Date:   Thu, 25 Mar 2021 15:24:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210325182442.GI2356281@nvidia.com>
References: <ec99146c7abc35d16b245816aba3e9d14862e624.camel@intel.com>
 <c2239da2-c514-2c88-c671-918909cdba6b@shipmail.org>
 <YFsNRIUYrwVQanVF@phenom.ffwll.local>
 <a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org>
 <75423f64-adef-a2c4-8e7d-2cb814127b18@intel.com>
 <e5199438-9a0d-2801-f9f6-ceb13d7a9c61@shipmail.org>
 <6b0de827-738d-b3c5-fc79-8ca9047bad35@intel.com>
 <9f789d64-940f-c728-8d5e-aab74d562fb6@shipmail.org>
 <20210325175504.GH2356281@nvidia.com>
 <1ed48d99-1cd9-d87b-41dd-4169afc77f70@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ed48d99-1cd9-d87b-41dd-4169afc77f70@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:610:52::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:52::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 18:24:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPUew-002xTZ-P1; Thu, 25 Mar 2021 15:24:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b372a8-7844-4409-9ba6-08d8efbb4359
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351415345898F8D07145D8BEC2629@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYdPxnX5s3a9G9N7ZgYZQH+Ez32r3RXm8u9k1vyQe1rmCkkZL2F0RKub8tApqXFuHWkw6h+Pgdx0Mz7139Qz45LiHlpEwbd3Xp8KHT3CQUyl5JXwRs7pnVRm9mxkdc2X2/fZcLYcvxGdvXvsZ85SGrM5MHp310rXxtzO0w02HNbY99Cg56Tfe++CIwZZCZZLSbraHwidtF+RaKRrJ5C5O8Jy4VfC6w401dqtFnl8tW5bYrv/bhFZkmde1z9vgzYQqyRwNImE/NmdJ1ulg+cAlo9wKqm/mWFgUe6szIBoDqUG5EQvHe6yXP6G65zN25KBKShK3ww5yKUtVsT3GqkF2XGnxrrdcVKUxZCQkGo/AtoAYAUA61ePwmC0/G/VRpJ+DqBULf+6MycJMyjOLvVoa0VCMno8yjSj94zkx6Vze5zh/up+LWF1LwgN+ilyRVVHyxP5FcbRkrgVyv7vRjNE49n5qwZdVzPgKr6HallaJondo/qkAA5gk8HT1zUgxVxdB1Iat7Kle4blCr1mBrqiHnFtLqVqbm4GJHDVhnh43U5vQdMKtTa8w7XQP+57rHho6KVv1U8F53ZO/nbvjp3xAwFmGzTsFQqvbmL3qdwQn/iq0y4Fh4A/KLzMR078Ud74fzchiopCa/1XgB5+ib0kqteSWMiNNsYE1xjWk2d9plmCi4HVNB9Ok58mIumKNOzm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(66946007)(8676002)(86362001)(36756003)(66556008)(66476007)(2906002)(33656002)(4326008)(54906003)(478600001)(316002)(8936002)(426003)(2616005)(9786002)(9746002)(83380400001)(186003)(1076003)(53546011)(5660300002)(38100700001)(6916009)(26005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0c0djdQSS9QZXRuVnM2ODlySEExYlU0L2VpQ3VGbi91RjZOZWVHYm4xR1hS?=
 =?utf-8?B?SHVCc29hN0ZBMnIrUXI4YlM3REJXT0JHSmdsTlhLNnNmUlYrQWdGVlRpbHg1?=
 =?utf-8?B?WE9zUkt6ZmkwWGcxWjZ0VUZoekhick94RHd6WWwyOFVOc0pnd2UrNm1TM3pi?=
 =?utf-8?B?RVpvQXVNVmJ2bGZVdi9NdFc2NzJGWFV4RCtpYmF1NUoyNk9hRS9abFVjd0J1?=
 =?utf-8?B?bG5IOW91ZllMdDZBTUFjRkhhcG9ycmludDJodkJ6eEx0NTV3TUtFM2JVMFpn?=
 =?utf-8?B?dXZEMytRYUUxdDM0S3YwSFpOZ1hCQU4vY3R3b2d2Zy9kWURtN2VIMThnNmNv?=
 =?utf-8?B?SkE3OTNyeW11VWpIbFJKZkdVNExrYlRhWEpuT0dpTXFMSlZiVHh5UnF6aGc1?=
 =?utf-8?B?OEZNU3hqVENwekdFSmZKUDNOMk01eTAxS2daejl1UDZMTVlseGd0YVNMamhU?=
 =?utf-8?B?NW9nbk10Qng4ZlFpQklSSTNjOWhwL1U5ZFlpSVFHZDF0S3c0NjRjOVRqSVo3?=
 =?utf-8?B?N3gyanlRUTEzVXR1L1FpbjRpUGhkUkl3b0tOSG4reU9yS1R6blVXcnpRTnZu?=
 =?utf-8?B?bjJueWhqMFVaeGFHTXR6WWFMbXlUOWVHT1JPRUJUcC9GcDR2WlMzL3ZOS3Q1?=
 =?utf-8?B?cDFVM2dtdXVJZ1VCRmQ0aTRuWU5uZzkraUp3TE5wQS9DdTRKcHRkd3IrRk9j?=
 =?utf-8?B?ODgxUHo5Nm9KSHdFRGpFbEFDRFJXcDVSWmg4cGdmaXg0eDRxckNjY25waHNo?=
 =?utf-8?B?dXF4MTJBTmtxbnFJa1hCMHhVRzFkL1diYmoweVhObkxqNVFXNnNkS3V2N1F6?=
 =?utf-8?B?YzFWT2ZER2h5L1lXUENHVkxnTWFrRGtscnY0Y05iNEdZTU9MNDdYQUNYb2NS?=
 =?utf-8?B?aU5RNXVjN3cvb3pSY2UzRWdVVGxFTk13b1BFY0ZqcEZBbWRwOXYxMTRLQUlH?=
 =?utf-8?B?bVBvQVdWOENDeTBXeEc2cU4rRHRSeGhabGdwTThyQXRaNkxrOWdtdEFJOHB6?=
 =?utf-8?B?OEtCa0hiUVNLZWFTQnMzY1M0eE1JcW5QWnFMN3A2eE0zS0xiU0ZpS3FsY1ds?=
 =?utf-8?B?aU95ZEZGd1dwdEliL0NJQ091UTY3bTNUY3FadXBVUE5vSmZ1SEloMDY5b3Uw?=
 =?utf-8?B?cExCSlFBcGxoU3docVNndk5BSUlqM0xYdFY2WFkzNEJxN1dzTlNRWk9tTm5K?=
 =?utf-8?B?elpkbk12Z0dJbGFsdEFXRnZZd2xka3d5WEpIZ0NaVDN5NHhzdEdkeGJ0NG9h?=
 =?utf-8?B?UHNXeFUxRWhKWVIwREV1RDhQM2d4NU8rMnJXUkVsVk5NblZDQmd1bDF0TW1a?=
 =?utf-8?B?bmRHaWw4VnhZZEk1Y3BMUzZXZ3IxNVp6cUtJMXEvNEg5VWNRQWJnemxMSldG?=
 =?utf-8?B?dUlGQlJPRGJNck9qenh5QUFTV290bk9hVFBQY1ptODB2eE5aVENUZHViUy8y?=
 =?utf-8?B?VGgyamlzNnpzZnBsUHRqZmduNWJUQUVSTlBGeVQxbi9LOVU5UHk5Y1RrMlFp?=
 =?utf-8?B?VEtCTjlEQURaRTZOb1lsYjRHaS9UdC9FQ25OY2RVL21ZOGh6WTR1bjE3c1d2?=
 =?utf-8?B?RG1zcmpEcC9taEhTTXV4RlVvbUI5bGhqNUpPRG1qcmthQXdZWXdCcDZodDYy?=
 =?utf-8?B?Wmt1ZUg0OXRkdEsyM3NVbVhhM3UrYkVxYVV5cFNZRlZXV3dYclFEWHZPd1dS?=
 =?utf-8?B?eE1GMVRQNnJYU3hvNFhtUXluQ0VFcHJ2SUtXMFpZZnJQV0Q4QVBLcHJUTVRk?=
 =?utf-8?Q?yEr38YIpfxn4fmwtZNdR2GXWg4j+cE1NgRUbxM/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b372a8-7844-4409-9ba6-08d8efbb4359
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 18:24:44.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ0SUKQ0zxs5emj9lVs3SfnFZaxGIeYa+ZNOPWJi015r2d9/D5XOgAlS6HGw9L5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 07:13:33PM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/25/21 6:55 PM, Jason Gunthorpe wrote:
> > On Thu, Mar 25, 2021 at 06:51:26PM +0100, Thomas Hellström (Intel) wrote:
> > > On 3/24/21 9:25 PM, Dave Hansen wrote:
> > > > On 3/24/21 1:22 PM, Thomas Hellström (Intel) wrote:
> > > > > > We also have not been careful at *all* about how _PAGE_BIT_SOFTW* are
> > > > > > used.  It's quite possible we can encode another use even in the
> > > > > > existing bits.
> > > > > > 
> > > > > > Personally, I'd just try:
> > > > > > 
> > > > > > #define _PAGE_BIT_SOFTW5        57      /* available for programmer */
> > > > > > 
> > > > > OK, I'll follow your advise here. FWIW I grepped for SW1 and it seems
> > > > > used in a selftest, but only for PTEs AFAICT.
> > > > > 
> > > > > Oh, and we don't care about 32-bit much anymore?
> > > > On x86, we have 64-bit PTEs when running 32-bit kernels if PAE is
> > > > enabled.  IOW, we can handle the majority of 32-bit CPUs out there.
> > > > 
> > > > But, yeah, we don't care about 32-bit. :)
> > > Hmm,
> > > 
> > > Actually it makes some sense to use SW1, to make it end up in the same dword
> > > as the PSE bit, as from what I can tell, reading of a 64-bit pmd_t on 32-bit
> > > PAE is not atomic, so in theory a huge pmd could be modified while reading
> > > the pmd_t making the dwords inconsistent.... How does that work with fast
> > > gup anyway?
> > It loops to get an atomic 64 bit value if the arch can't provide an
> > atomic 64 bit load
> 
> Hmm, ok, I see a READ_ONCE() in gup_pmd_range(), and then the resulting pmd
> is dereferenced either in try_grab_compound_head() or __gup_device_huge(),
> before the pmd is compared to the value the pointer is currently pointing
> to. Couldn't those dereferences be on invalid pointers?

Uhhhhh.. That does look questionable, yes. Unless there is some tricky
reason why a 64 bit pmd entry on a 32 bit arch either can't exist or
has a stable upper 32 bits..

The pte does it with ptep_get_lockless(), we probably need the same
for the other levels too instead of open coding a READ_ONCE?

Jason
