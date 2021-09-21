Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6A413963
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhIUSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:01:39 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:1568
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232120AbhIUSBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZNt9D5uJiGBY3Mrcl4ggP1f1fyd1ISldxjM/a6HaUpJQshU+8wNvMLO3DcjhNIN3mKuj6Vt2JZbPW/9+hLZbHlwARo1FnHHsX7L6c/Ab1s5tShzHheRTCraYh7DxjLgZN+1km3sH00WYp6n77fUrj3izdzKIHTls8q0RXX2EpwyYvEvdUk17NtyYEKrA8oYDNPRz8Krd1TSjjMSCJuX/V7QRdogqGKWR9s/1f48Cd3UE6mzO3OuSI7IGV7+4Khed0CqpvWHKX6hW3J67IxkFVxCFgmXVnHT+fzDykKR4UaU4CfDg+uFkqp+7DNXzN0mbCCPOgvR6b2NCmxrnmVmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PJF0zZIBywKijuH2ZLfcrJciDjSi0KUu3lbso4PkzUo=;
 b=DsQluuz/Xqc3Bpa9oppU33o/mHxGUlIkYAaOf93jS2g95OFbvdNH9O4TeCY3mO81ZXhvGLuWj7jNVyzzh81IaRPwzogqXGpPW0K1XqABoImacFoHc3TauUnnsEnMfAmgz4clzXwDik0mvJx5TFEHaPN55FnxoybqKuWpuDEu9Qi/Oth+89cUjHD1rH+QJL+LC9tzmJlV5hei44W7O3YpCK+bSjoztgTfxevKPKiBkS0v6jMmDRtOxwK2Tf1dW07w1to8Knz2Z+oD+8EW/x8CfmKF8upN7gkBfBDnNr/Di4V5NSKzGxNJgaBG5D76+/Yl9RHiUEhGdcfKd1SbkXFzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJF0zZIBywKijuH2ZLfcrJciDjSi0KUu3lbso4PkzUo=;
 b=FUk7S6prPv3aW9aHfsHP8O+281g8IucWOyMz59F3Hww2I9vM1OzTCVo9kBS15xHc8wqkmKmPcTN+kh8Mt+qlZpNhJMDhhxhbdiTmXJIiT9sKNAvif7i8iLK33+8TgN9TcUyJHpfdP2fbWQTVgnB0pl4vXX8y3i7/nzCHxEw8ucMIK4lmujWbHOZjrTXJEM3V56/99jBjN1lv5nMiaw/ztTjBPXk2vjcVt2TkpoUcs+XlI/K7j8X5T0wpZ7HTvp869GKYGxgOe03rh+3gKbNXmNXl5k/wh16gmBC8pcxPUeEC8sZxU7IPILnVHCZw4qHUkC+8SveXCoVifY40XSm5Lg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:00:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%8]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 18:00:07 +0000
Message-ID: <384b551e-28f0-ca7a-61b5-78f238de6e4d@nvidia.com>
Date:   Tue, 21 Sep 2021 11:00:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Weizhao Ouyang <o451686892@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
References: <20210921064553.293905-1-o451686892@gmail.com>
 <20210921064553.293905-3-o451686892@gmail.com>
 <87mto676fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d57aaff2-b154-4462-1a7d-3d288ebabb6a@gmail.com>
 <87ee9i6n1w.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87ee9i6n1w.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.51.141] (216.228.112.22) by BY5PR17CA0022.namprd17.prod.outlook.com (2603:10b6:a03:1b8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:00:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0915cbec-e724-4831-ffdf-08d97d29a4d0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB26805AC298280C743DFD3BC3A8A19@BYAPR12MB2680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8gbj9wALace0XaUUJaxFh3N38Qh0hr2oKz7/9P7/PZYsBPAT76M1jevJieu7ZMZtQ8XfbrNI+P/l0fK2KHpb0zzgDZnix5E0fJ6Ad3gEQ8l92/b7Zxa8D9HdrryGhT8ql4fFW4GsPJzPbyFq7yhcq3zfF5JLLVkuapVIEgOSzzIk0/YZuTR2/RrVmdlN8EYJUtNv5khqVctiyDkiptIBlFWSc08Qgo5IhTVyOokp9urA/moSd2NKt1bcjHoNWxnfcGWz+sTdIz12vCwTkG8os1q8DUpUnSCtsG+VIqdf13sAhwzqrXBUdrgVxii9w7rOtc8twDAhDggniUhIRl8/bvPHoRyzSo/053XoyC5qZ3/M11b2+8Ymm8hLpNKXrLiwFiyvuLe9RVAzzIFIt0AQL+fA+P/KIaxwA7Uk1vaVzbDTRwzsR39zZq2rPSLbDXl+vjTKTbo/0eqda521ru8t48xkNPLHL78jZH1SzphI7sD6zJtPfjfmAjn8OFsOhWWhPbleDMr2KjkxtSYQbBEgyT1bXYyi1lpTizNcjj/6DKWIDvLrOrTXHp1WSuMcbGg2nGcgP/Wf6RJ65GaKG/GLo0tfDW5CeCyn0YCzWObbz1TJe2K36aIvkO0BafSqI+lO9WXTl1DTtB/XTTxKcQ6Nc+xri+kdFweG3HxTvEddZpjqk3EkPNGjgCmZza0M8WiMn0DhaL6wPp1MmDXI1bSdf9KQ2L+fgfBXUoeQbeejpdpl33culaWBCspNzLzp09U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(38100700002)(31696002)(86362001)(53546011)(508600001)(36756003)(7416002)(186003)(26005)(66556008)(6486002)(2906002)(16576012)(110136005)(54906003)(956004)(2616005)(31686004)(83380400001)(8936002)(4744005)(316002)(8676002)(66476007)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBNSExMMktEZUpnMmJzdTRZSzhINWxTZlR1QnI2ZFJBemhCQmdUOWRDdERB?=
 =?utf-8?B?cnJKTmZqaEFYa2E3RFFpK00xNGlOWFNLNjZvdzFHNWxYNHptYzB0YTNWV3pU?=
 =?utf-8?B?V2ZEYlVONUFtYUdaOW5LaXluSVhXOVRBY1RrRFgzSDFyS3NhTXN6L0hUcGwx?=
 =?utf-8?B?ZDdBRlk0blVZUTVpSTg0S0E5SkxyUm5ieDIvMmxoOXJTbVdYZ1Nxbi8rSVhB?=
 =?utf-8?B?ZkN6YTJEVnJ0SCt5UVFTWERSWlhHY1o3djRSdkpPVjl1aG9mRlAvN0VZT2Fh?=
 =?utf-8?B?Smt4eGMzR3REcTByMHZHMVBqZGR5Nkk4cksvV2E2ZFZoMVJtSjErVkVCaDlZ?=
 =?utf-8?B?NlNGMDRFbXZRZWpZVE5XeVlTeWtvZlhCUkFOdWNZUnJOZ3dEUUV3M1hMVzRP?=
 =?utf-8?B?UXJFZGlSRTRTNDJsQmp6OUVIOUJEcjlFZW9BOVdWZ3QvbFRVWHU3Y2FRTlpo?=
 =?utf-8?B?ajU5UHh6U2FoOFJ2MGw1VTdnbkZxWGFndDZEMU9YM1l3TEE0K3VGemlEbXZk?=
 =?utf-8?B?cGFDMjUxZ2FCTi81aHhjWEpzMGxaWUtKM2lkaU9tRHpOeTNNUU93dkVEbXpY?=
 =?utf-8?B?WFJzbzAxLzQ2ekFZazNYRU1LYzdQYjZ6M21UTngwOGZxRnNuNVh4YlpQMlRp?=
 =?utf-8?B?SkpSVVRCeVRQWEcrSFJGM01SWnhNa1RQMXd0UEZzMmdCdDdHMDZNbHdXTjVG?=
 =?utf-8?B?aG9IUTU5aDN0S3NyNHQ0eFFSMlpHT3NUb1hTOVIzN2ZKWVQ3M2NHdE8zSkw2?=
 =?utf-8?B?UmVGSWphQ1BEcGtmbFlHcmpiYWd1Ri9UMG5zaGFuZXI0NzgwNW1lbjQ3d3No?=
 =?utf-8?B?VC9ZdFNHa1lFd0orQ3NtalRrQTd5dFNuVThoWTZzTXpsSWdZaFZnUHg2eVVz?=
 =?utf-8?B?a29qRWJ2b1ozbzhibk1wNkJBSW9abHN1bVQweGhtMHVsSmFPS2wyUmo1cGpq?=
 =?utf-8?B?OExlZFJNNEdNS3dRdnBJUnBwWCttS3BhMlNob3Z4SnB6SisrbmpnN2gvWXY4?=
 =?utf-8?B?YURsN3hQTVR1SG9aNWxQdTlQd3ZXK1AxL2xsVm1Mc25vcllDZ3I1Sm9nTzdT?=
 =?utf-8?B?SnYxUEZhWkpkQVd6dWZoREp5V0N1WHpDL0JHMCtNVEExaG9RMGdaY3ZHTkVD?=
 =?utf-8?B?eTE5NjRxWU1FLzBBNkJrNW9SNEsrV2tBOUt0Y2Nmd0xnK0JYUThBSkJDaG1u?=
 =?utf-8?B?N2luRVBSMGVXblJtQkFoWENEcFA1ZXdUTU5PdUNCU2VOOFNpTC9NR0ZBVUtx?=
 =?utf-8?B?NDQwOG41MmdjSnlPaFE4SGZETERxOGdUbkxPeXlyRGExcEhaY3dDczdYbUE0?=
 =?utf-8?B?cHpmUG1LYjBMNnk0eWVDOGovM3FOeG9qMFhOYzZhM0NTSXhYRlMyN2NZWUkz?=
 =?utf-8?B?R3FpQ3gwVGJBcTlNVnFjUW1Ebys1UHgwTUdKQm5vbWFVUlBLUzdMeWVlYXR2?=
 =?utf-8?B?M0FkbUJuaFNKa3dtTlJJNS8vdE5RWTZXbkZzbHE4NTFNZS8zT3ZGRzJWc0ls?=
 =?utf-8?B?VGM2U2ZnVURPdWNpYXNWdEl4TU13aWRFZ3QraFAycUllTk5uZDY4UmNidXhR?=
 =?utf-8?B?ckhHa1lCS3pWelowR2pYRkx1MmE4ZzFiSElsMmM4dlRXV0ZVR29COThxRVBM?=
 =?utf-8?B?akt3STJBc3VMRjBoMGJ2Q3BDQU9pUUhsOVc4Y21UZERmYlZuM3hNQ2lUUkZr?=
 =?utf-8?B?NDBydmdPQkFFZk1FVDh5c09CbHR6Nkw4eEdIb0VVVE9ZUmQvMTJIQXlIY3pH?=
 =?utf-8?Q?2NcOVmiolB0/ZvpB3wd1qnJlRyURA0N3VAGIJBV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0915cbec-e724-4831-ffdf-08d97d29a4d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:00:06.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjTuQ3jJ9220NzNUIyZVPZCkGAsm82ipseMD5WrwmZ+mVLOaZgQu+PkikYDIN/6Sr+kIEG8UAgl9e/zGonT8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 07:06, Huang, Ying wrote:
...
>>> Can we add BUILD_BUG_ON() somewhere to capture at least some
>>> synchronization issue?
>>
>> Hi Huang, we discussed this in the v1 thread with you and John, seems you
>> missed it. Now we just add a comment to do the synchronization, and we can
>> figure out a more general way to use strings which in trace_events straight.
> 
> Got it!  And I think we can add the BUILD_BUG_ON() now and delete it
> when we have a better solution to deal with that.  But if you can work
> out a better solution quickly, that's fine to ignore this.
> 

I have a solution now, it's basically what I sent earlier. There appears to be
some confusion about it. I'll send it out as a patch that builds on top of
these two, hopefully in a few hours, if no problems pop up during testing.

thanks,
-- 
John Hubbard
NVIDIA
