Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9F3FCC17
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhHaRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:11:27 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:58048
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229602AbhHaRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAP2Yxngb7hQc3hVKhcmgzyk9GUkmy7oTLOwrshdzt9GMrGa4ZrARdGtPsXBjOxTZAsxybWGWPoDEBCrwCYzB/bj9o/VukE6eZd1ZCTPCwN1EzbdgJGVGUO6jZuhTzUtr0df9dU7RqSCiTxIO977K1SLMgtsRHsNTYe7YoXXO4yQ3DfxNwc0LY6rIo1ySb5T1GgV5wcfSbnsjcIKwVBiRHJU4KS+MjW5AEL3Kv0QU1XFTIPM4jlH4NUYZA2Gl1VaDIfdDXMTZuI0Fo6MhaB2SgVT4zmrKlZjgOHGZUYuRlmoSESAYnyxHGtXj9tx0AkmpwRI5tnVke8aobqF/rnUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHixhUzY2dkzyyMyvr/KpGzRWKacvYcdemma8K1SjM0=;
 b=jsJwWB49A2FNir2SFfYHRhDfIZc3LompgA5/pIHMJtDePtjEimqwWXwOdYp0B7klaP8ifdDHIXH5NJGu50o0ScpKF7EJbgtroqS2L7OIK7TNYo49jCuWb9rswZZArBX0Am0oiZK7gCe5oDAA9vDDSTEBKuDzYiCqf+99/AoHLiptv9hnkLjwTySY69SRVIjHzUmJythCAw7IYO/HxGBeL0R5Yl1O7E11sAqfBxCF6sMkQmKoLve5yDTfTPoVj+NITyzbzRmAayQCbDyYr//00uQXWFf5xpbg4iosVAg2GcNB7UB9X8ZnXlTKBi96KylISDAVnao5wmS8sS2gG+BLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHixhUzY2dkzyyMyvr/KpGzRWKacvYcdemma8K1SjM0=;
 b=jjdqAJrotgAh8uicofwGx5Vvdr1gm2MQji120WYqF1juy1vQqTGZ8pR3U6TMDMcTPHLWfBVcehvA565DAodcqHf96msLR/FRiQixYibgyDvoOYj9+g/nTxym9PGfbhX8eZdhcLtBvLQmxmu1l7yXnWfBl6OR4Qa0/A//uDqCd+E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18; Tue, 31 Aug 2021 17:10:29 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::4549:89a4:aa6:6fa4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::4549:89a4:aa6:6fa4%9]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 17:10:29 +0000
Subject: Re: [PATCH 0/3] iommu/amd: Fix unable to handle page fault due to
 AVIC
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, wei.huang2@amd.com
References: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <f2ec4e5c-3bb1-b703-8842-34357e084bad@amd.com>
Date:   Tue, 31 Aug 2021 12:10:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820202957.187572-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
Received: from [172.31.20.86] (165.204.53.104) by BYAPR02CA0040.namprd02.prod.outlook.com (2603:10b6:a03:54::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 31 Aug 2021 17:10:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1818a751-b982-4096-25b1-08d96ca23b96
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5360F4F39EF0A7766A0A24ADF3CC9@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/vqOXHrScY02mZ2J5tNdN6ovkn6Q8fbTXMYJn7GLT3FYDPCoJ8uAwsFM/npbWrYaGiB4DWBLlGD8ShDkKg1k3Q4HU/fok3IpH5C1CIbsIXmVqyPpm8pbPvKYG1INO8nPFaSYiQFQFrG7BWPYCJMxEqZldyPHHNXSRNvrYQDpuLAeUvB9ZofKXYfFdCbqQq/+GdoSRIwHCp3j0mxJveh12mhVsE6lumOeFLwfhO6YhDfTAPtOelUNHAZ8x9udDKe7l3WOjhvZy9mWniwtInv17lZ7RIauY3tBXtI1avPB6ZHKrhfeskRubrXyW43nABkpvJ6M3uENSI9DYCVoQj/7LaXMDfkXaq8cRM86v96YAuE5UiuUApgx+iCR6aJXTZ3szPi/LyVe+umeZLpaHNxIxOmY4UmQa/hzq3EMeK5J1zErZSTHnEplkyb7Spym00Rhd4MyiTQkW0MVZw8hw/t+rG6DKd2GZI/OCVgxrY+8lg4AtXqmM5cFWmx8LOYkF6m1ZRare3llo8ldq/b1VG66VczTuGDtv3MmIyC0GmqRidT00pdmqhvViEdb7o2Qx4FdEv/WoapQTV4g07nd76uDvmec65HxyIgkANu2CoKKav2c2NjyVi61Ljg2zvbduyDQ1tmc/Yo4gApIWcVbAubHlcfCbGvBlYCiNHu4RFBkmQDSFk4/sJm9u1J3VsePsa2weOpFLWBPtsG1E6WW7xRcJeWy2NvHfPVWrob1RrjoCmnLzggj2BvdFnB13F6E1S+si9BupYT3V1j0Zc6FJBX5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(6486002)(2616005)(66556008)(186003)(66476007)(956004)(83380400001)(31686004)(316002)(2906002)(31696002)(8936002)(5660300002)(66946007)(26005)(38100700002)(52116002)(53546011)(16576012)(86362001)(8676002)(36756003)(4326008)(478600001)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXU4cHZYTlArV2N4MmJKVFJXSE93eG5qQkVwWFZtajhPZXJFNk1waWF3dFM4?=
 =?utf-8?B?Wmx6SEk2WmwvUnd1YmR0SEF5Z0dpeDVsaVlVYWIveXhWRUJKRS9vUTdpWTNz?=
 =?utf-8?B?ZGc0Q0dDdGY1N3UvV0ZJQ3F0VmlndWNTS0c0MWtDSnBWSzRPam15VFlDUjNU?=
 =?utf-8?B?cStvUnFRRDErMmNEaC9YZ0MxUHo4Qlp4TTR4a3NTQmFTNTJEaWc4eWxaeWlO?=
 =?utf-8?B?Qm1hQ2JqYTRjUVdtK2dVYmQ1ZWZ5OVQyRGtZMjRkeUFpc2psZndLMlM5VHJU?=
 =?utf-8?B?MWxpS1p3MElDUDZNcGZPSExrSUliWUU4aWxWVHhlbDFjZ0RzZXRHMndCV2pn?=
 =?utf-8?B?eHowN01iaDJTK0tOME5ZaEgyYnh1MWhScWZ2c1I3OVJlaFlkd3d6VGh1YS9D?=
 =?utf-8?B?cjdvdGZqZEJhYStMTnVGTC9PM29QSlFYYjNMTWgyZEk4S2UyWGZEYjVnbmUv?=
 =?utf-8?B?a1hacGNmNXp0SGdtY0NzOUIvMFdTZ0t2V2ZBNSttT3BaZ2VOcTBkYjJWanha?=
 =?utf-8?B?dXc5ZE5kTjBQZW83RmRlS3dLV3JmNkhZYWlrN2NvM29RdCtkbFZiak13MTA3?=
 =?utf-8?B?WEltMjV2R0M0K2lxdU1BbG5sSGxKMlBza1cvZnd4RzRjTW1aS21mSVMyaTBp?=
 =?utf-8?B?T2J0Y3VoQ1g3bUc3aFRHdHVXMjZKcVNKLzR6RnBEbHBLWndpbTBaR3Zpa0tI?=
 =?utf-8?B?WU5lNTdnc3duTWpsV0JaclhGTk1tYnc3V0hLTzdYUG9FY24rMjNUSndDalpv?=
 =?utf-8?B?cVJ0cnpUREgvYU9pRlRsMURFajN4djNWQnZFaWRndjZGUEllRG5hVnNxYUxW?=
 =?utf-8?B?QkJCejZwT2VJbXQ2cE40TTBUSExuemN1bVVqSUFXd0JDZHNkbUI4MnhZZzAw?=
 =?utf-8?B?UjE4UW9QRTVJVnFySjBnZ3ViRUZDQ3lWbUxtMVFlNGMvZXBDQXFBMDQwNVV4?=
 =?utf-8?B?RldDQzRKcGZtOE5EZ0tUZXpoT0s5ajdjMkdzM1NvSlNiZnIva2VtamdMZjdX?=
 =?utf-8?B?S1dwSzJXZUFScjBiQTNEcXFVaE00VHJMeDQ3c3dNQTV1QzQ0b0xNc3Rla3dp?=
 =?utf-8?B?SVExQmVpSllaLzRSb29yb0JqUkRPOUFuL0pXMEJ3eWVta3ltZDdUNmVQZmE1?=
 =?utf-8?B?K2E4VUlxdU5uY1lYNmYzYnRrVlNXcjRzbEdCcS9iMzBKRWgyMzAvMnNVTWdL?=
 =?utf-8?B?MG4waER6UEFIQUhuTDJjOGlEeG43YWpKMU5ma3Jta2lYNEtjM3c0bWpXVU9F?=
 =?utf-8?B?cTV1N3Rsa1hRTFZ6Y2hKWVBCS256ZUhjdjdjNjBEbUVSaC9WNTFSSlFGUTRh?=
 =?utf-8?B?OVhuaHhuREphb0NTQTVEcEtpVksvenZqWG45WmVhT0h4VnRGem1lYUUrSGtS?=
 =?utf-8?B?VFRYL2M5SGs0cGpFTUFxR00zN2NKNkRvYVRwS1BBcGhuVHBrRyt0Y0tKMCtF?=
 =?utf-8?B?NENVekRDMkMwTFNDYzlOOHdNblZlMDZhQzZ5UWNrNkpEVFNzRnM0dDdyWEh5?=
 =?utf-8?B?NU1hUm41TmNKOFhlTHdCdUxndzlNZElJN3ZyNGo0aVo5WkJwNFJub3hQS1BT?=
 =?utf-8?B?d0VwcmtWMkxiZzhBcmZmdVVDRUJwN0VDYStlZ29HZGxmcEI0VkpXODk5L3RY?=
 =?utf-8?B?NGJpc3NXMTRETmZBbVhKQ0p5cms2VlBwUlpWaWxya2p1WU9ONFBWeVpUYml5?=
 =?utf-8?B?a3g1WVc3ZDNjMEJxT3VkKzJrRjRnSm1wK1RYTG1hODJwZGJYV1A0UFNETUwv?=
 =?utf-8?Q?D7cMHbtz7VSRyOlnI3ptfbpjdpbqTbu6ZeuCyER?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1818a751-b982-4096-25b1-08d96ca23b96
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 17:10:29.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlzry1MN8s/Wobt41w1pW+ER5GQLjezPEZ7oAx4yH/jchd2JsolSzedkXgSjWqaFwn9QXETzZdRAWVsd3w+Drw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg,

Here is an dditional tags for this series:

Fixes: 8bda0cfbdc1a ("iommu/amd: Detect and initialize guest vAPIC log")

Are there any concerns with this series?

Thanks
Suravee

On 8/20/2021 3:29 PM, Suravee Suthikulpanit wrote:
> This bug is triggered when rebooting VM on a system which
> SVM AVIC is enabled but IOMMU AVIC is disabled in the BIOS.
> 
> The series reworks interrupt remapping intialiation to
> check for IOMMU AVIC support (GAMSup) at earlier stage using
> EFR provided by IVRS table instead of the PCI MMIO register,
> which is available after PCI support for IOMMU is initialized.
> This helps avoid having to disable and clean up the already
> initialized interrupt-remapping-related parameter.
> 
> Thanks,
> Suravee
> 
> Suravee Suthikulpanit (2):
>    iommu/amd: Introduce helper function to check feature bit on all
>      IOMMUs
>    iommu/amd: Remove iommu_init_ga()
> 
> Wei Huang (1):
>    iommu/amd: Relocate GAMSup check to early_enable_iommus
> 
>   drivers/iommu/amd/init.c | 45 ++++++++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 20 deletions(-)
> 
