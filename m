Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1713567FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbhDGJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:27:27 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:16416
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234982AbhDGJ10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeifyQVtryZgdtoKtxJA9LaYGhNDom29fX7pbgtSw7hstXjpXcsqiF2RnuByiGZqcNcGKvR1EbitSTLe+qKBVbEfFeItbfLi/ZXxRQcAz441JoOOONgZad8ZcB4vcJ1ctuRW0asXfGmNhj7HirxMtp7prwT/nQdc2pKNavG2l68yD0caRxIkzbw3/Zz0/ke3TqrmKC/8dENDU0Yf2VtxWs+1y9kWi1w3Jym5bcC+MLLJbgmNF5HBWrfo+GqyNN7VlTW0FXrqhgd+mS+KrscXW5LyRgVcyeaekVdSJN4KeJjcPJnVHmoDNAl0oYhI782sIEqwAU4gppQc9zO90Uw2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzSIZwMjHhUHeK8sPOO7fLQjXxSnQyg7RLQoMLSbYaE=;
 b=F79/Pkfm7jt6m49ncPHc7wBDcqy+61ep36e5EWuiER8Lu/EGMLJDxJfl1l0kYSjS78sVAFb8z1SmtkyzFcntcmcFYfcmzc1SeodPAAXwdAVfeYonJA69aStNt1n/CiHpGhijon0cPEBioNnckyUhFywmKKj7mdPTGzs+iQx7mKnX9P6alI6rQABanHBkcPBWFBMPA9T0qPLvqvO/IbNefBcATbDRIZYPPeBfikEJYzrFGWn2wmtPLu8kj+VP4siTd+o8DdLKDDJQPasGRSyEcj2aacfx/gjuIYKCHR8AWysjbTAxQmtQ+7dKYFB2oC1C8Eu376gT0YjAMBZBLPJePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzSIZwMjHhUHeK8sPOO7fLQjXxSnQyg7RLQoMLSbYaE=;
 b=cmppgQ/CRUnWV6EaDCWtNR4KmTTJFav/mlBzQz/yiC7FAFm6SM0tohOa+Gb9GtSRep53kPOCaELc/n77it5k2xhhzBHujDbRcyPWtFOfbmRXgs/rEQYdX4bbU4dWPJYLD3vLh5EXSIRUQXSmb8Qx88vGmIP8y81iOfnLHxjuk0g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3665.namprd12.prod.outlook.com (2603:10b6:a03:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 09:27:14 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 09:27:14 +0000
Subject: Re: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
To:     Daniel Gomez <daniel@qtec.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dagmcr@gmail.com" <dagmcr@gmail.com>
References: <20210318083236.43578-1-daniel@qtec.com>
 <MN2PR12MB37755DAAB03FC0065E98EF1183699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <CADnq5_MMTBXt50sqJvYmXWn0uBALz2fNvpSrCfjSuMa99VLa=w@mail.gmail.com>
 <375f0915-83b3-c729-b95f-939d828d24d0@amd.com>
 <CAH1Ww+TNMpk-LYYaM=SG9XGK4wcGY3+w8rJzihUw=4EpzVV9EQ@mail.gmail.com>
 <aae87a0a-d643-8ee9-d0f8-e983f8613a88@gmail.com>
 <CADnq5_NbGz3UaXeTybZBeCSUwxaV8bNxKkaVwtLoZQGSvkbYYg@mail.gmail.com>
 <CAH1Ww+TSv3_LR_sf6hm_-i27=1Wb8Aay5FjOQq2Csh9jvKheCA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <605b85ab-57ce-86ed-1899-8874450dd318@amd.com>
Date:   Wed, 7 Apr 2021 11:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAH1Ww+TSv3_LR_sf6hm_-i27=1Wb8Aay5FjOQq2Csh9jvKheCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c8cb:bea6:b85a:47d0]
X-ClientProxiedBy: ZR0P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::20) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0] (2a02:908:1252:fb60:c8cb:bea6:b85a:47d0) by ZR0P278CA0087.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 09:27:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68dd5e89-cf66-4713-8eb3-08d8f9a753f5
X-MS-TrafficTypeDiagnostic: BY5PR12MB3665:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB36651E3D8A7864538C06839883759@BY5PR12MB3665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pj1fXVji84x/B8TJd9GWI8J2qNgP2deOdRTvschKFurAOVP6l7Bfd+lcKWA92QuPDDKxJczmkNI9rpsc4Qva/BD/5SZ2e2G0VICjx508g/z+fWlpKakEyV8TYlxVqW6uBQEGZDQ5+mEyrfQyyzIAa2TPVOB6HJ1dzUhaTj316ZavNSs1EZGSsypLDUoYhwqM3D+TZMlsyYPoF7cnbbDDBsAdDfVYDhOPkTSeD5HCr4/kplWvtHNq9vdBuMB3z1n7B/Y+rzlMFWNiZxv20puWPAcTmSZz4Cx0UwXRFZIYy0XL5dDFA6+60yr40zbQkxd5jbnNyTahMRIIyiXmhM0mHR4jQ1n32hD+0L2DzNgqaLUh7pF6xR/HaEIv6YgU0pMVqcvk9GsZAlGIc402yHqeduQi4hoPkcloOYinDxqwRSge9nYVBmokNVlYzzgRyF0C4GFBwGPb9vfVnTdsU0zFYISAiITph9Y106UpCYmIiMmBB7ueI2134h8plQHwI7JXXkbQH+8RN7ZK03Hz0klPr5B60i8ZBvbVE7ROEaBF10eaR7svnkxXPsYkgUsepmmZQh6ErxKSsbgQ81CMnFXNgiy7EnMNEoOGFjVVcUwO3fX/mseCTtrp7oENrp/yaJHteHBjiNTVKgMJrub7CwaN2wA4dar+jVr5+N9xr3Hh4QC8NQeRFxp+RE34jUnCCD+FoPGDeyQt6oCFAfOWVa3toLH/ZyG64JAO8zLbIpmH1htoUbwg+SNC/in5/69PARVzHcSn3GCsK0hD2NAw9hhbHlg8EIUUUOp8rA9ml3swEQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3764.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(66556008)(6666004)(66476007)(66574015)(478600001)(53546011)(52116002)(966005)(186003)(2906002)(66946007)(31696002)(5660300002)(16526019)(4326008)(110136005)(38100700001)(86362001)(316002)(2616005)(6486002)(54906003)(45080400002)(31686004)(30864003)(36756003)(83380400001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bW5wN1d0b1pKVzFvOUVhZW9FRWhxVGdhbHRPNFFyVnZRTVJ3M3RsSGtQVk5V?=
 =?utf-8?B?L09KZnh3eHRXWUhLMFlWRGg3R2c3a0U0TnBSYmk4czgzdk5haEYvL0tTbnFS?=
 =?utf-8?B?SGR4VDAyYm5aeFBzOTZxcGl1U2JXRzljWFZNM1dJeWwxdTJrcnNaY1plOXlm?=
 =?utf-8?B?YnVOeWRabmZkTzJNcVFrV05WTis5UThiclVOZ0JkakxyN3JpcE5zby9vSkZm?=
 =?utf-8?B?TkttdzZJaWhRSGZISFVyS1NzSmNuMExCM2c5cGlLendTTWxxZ0s5cTdrdTI5?=
 =?utf-8?B?U2xBOEd3WnFscXlaRW5la0p6UVJnaTlGcjVwZGo3N1gvdnYzMTFSRGFpWDF1?=
 =?utf-8?B?dVNML2pwVUwrUDlleHJEUGp0MmtFS2pnNGZMYS9uS2hweDRqZlg3d1NvS0JN?=
 =?utf-8?B?U1VrRjNGUTVGNHJZakxLZVpkVjV4bHBTbE91SUFYV1ZtY2JPdTFqYkpTYW9K?=
 =?utf-8?B?ZXR3bW4wWEFiTW04aFpjcHRDenRyWnY4SXllU1V4UU5vTW1IaXFjK1R6OFg3?=
 =?utf-8?B?NXN3TzkvbGxJeGVRV3BXWk5YS0F4WlFacFVMYUVNQTh4YWdYanMzVU5RU3M2?=
 =?utf-8?B?R2g0M0JyQ1lJeFlvcmVlMGU5bk51Z1ZXaHkwWWpnNC9rNU5PYlVQdjc5Ti9E?=
 =?utf-8?B?OGx3TnpFSzAyV1NVTm5IajYyVVRGWmtEdEp2Rmlvb3hSd1c3T3lTWHl2N0VX?=
 =?utf-8?B?cElPK2xHRTBndjk4UWxqQlpFeW54dUd5elVGREpmWTdhQjJIQ1JKbWFXKzJw?=
 =?utf-8?B?VnRsbHpkSkdnSmY0VDZpalpGOUpKRTF0RG56RHRRLzg1dlBHbmU0MC9tQ1RD?=
 =?utf-8?B?TUVtUHpiUmFjRHBka0xQOTdJQTVJUE9rajBLSkU1QVArb1MzUU1oZmxaelVr?=
 =?utf-8?B?THlLdVVmbG82UTBtTElFSzEydnVCZi95QTYwR3Z0Nmp6WnRmcHk0UVdHcDYy?=
 =?utf-8?B?SFdyTG5aenNSRGlaUWNHSC9LMm55WjhsejhEMDJSazM3dU9qMUNON0kzdEdr?=
 =?utf-8?B?dEdRUUNCa2dzVTQ2Q3BFalJ0aU1IcVhTSjhLQnozQ280M1poTWhPdXBwMCtS?=
 =?utf-8?B?WFczRldheWUwVG51bFhkQXk0L1FRSHR6V0tycnRlc0NQNmx4ZVFYNFphTFV5?=
 =?utf-8?B?MjY3SW40WmU1QmRFZFZkRmVld1lPSTZKTWhXZ3lDcDFIbDMyeUNaUktBREJP?=
 =?utf-8?B?YnJrdlVGUzFhdXlIbTlYd3kyY2dheHpiVjM5R2ZBbVBDK1J1OWtPZE1jRy9j?=
 =?utf-8?B?dVZDNEsza0laQS9lbWd2QVlNTTdHUEZPOTU4b3J6eVRPNzQ0TTVlMjRLVHp5?=
 =?utf-8?B?aEhhM3MvS1JhRzFldDd5cmhaNElPVXFma2djak9MQkN3YndpZVdiZmhXKzhK?=
 =?utf-8?B?aS9remdWQlBzYVBobm1kS3pOUkFSbTZadFlSaWtpQ1RTRlRrOXdQNmVudmRs?=
 =?utf-8?B?Q2Y3amZIcmVGcGpoZXBZZHc0VHgrKzByNFg1cktjM1lJYXpERFRzdi82ZXFw?=
 =?utf-8?B?bGFhQjZYVnNxeVV2NHJJa1psbWtDMWR3bytaS0QyK1VSbG5wMEVFMHowVUxj?=
 =?utf-8?B?L3l4M3BmczNqdkFCam4rNkVWaFJ2ZDJaZjdSb09uT3FiaHd3S3FISFBVNENt?=
 =?utf-8?B?VGlIMFRndEtMTjZ4NGJpc1JmRkowWlBGR25nSElTcVdFN2tSYnIrQ21WN3hX?=
 =?utf-8?B?b1JxTjZzaHNrM2tZQlZGdVF5aU5ZZEd1MVg3MDlyK3hTZWU2ZVlKc0c2cHhp?=
 =?utf-8?B?N0tHeWhYQldJTzJiTmozQTJtMUVUSDRQR2o5Si9pOFNDcytwYk1YbCtoWFc5?=
 =?utf-8?B?WnBuTjNtVFBsbWR4dk1nUDd2YmxCR3pWOVJDNE05UUkwRjd0TVQxY2NiMkJL?=
 =?utf-8?Q?L/0TyxJHTBb3s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dd5e89-cf66-4713-8eb3-08d8f9a753f5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 09:27:13.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir14IWUw71AZecdWFgmuy6rFUuIrtAWB4LCJ9Gbvcs3X4Jp60pWj/BUaoZX1gJry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3665
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.04.21 um 09:47 schrieb Daniel Gomez:
> On Tue, 6 Apr 2021 at 22:56, Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Mon, Mar 22, 2021 at 6:34 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Hi Daniel,
>>>
>>> Am 22.03.21 um 10:38 schrieb Daniel Gomez:
>>>> On Fri, 19 Mar 2021 at 21:29, Felix Kuehling <felix.kuehling@amd.com> wrote:
>>>>> This caused a regression in kfdtest in a large-buffer stress test after
>>>>> memory allocation for user pages fails:
>>>> I'm sorry to hear that. BTW, I guess you meant amdgpu leak patch and
>>>> not this one.
>>>> Just some background for the mem leak patch if helps to understand this:
>>>> The leak was introduce here:
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D0b988ca1c7c4c73983b4ea96ef7c2af2263c87eb&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C65d21b6f02da409ac7b508d8f9997367%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637533784761980218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FeOQf12NBkC3YGZ7QW66%2FT%2FpyM3DjEb9IMbqUvISMfo%3D&amp;reserved=0
>>>> where the bound status was introduced for all drm drivers including
>>>> radeon and amdgpu. So this patch just reverts the logic to the
>>>> original code but keeping the bound status. In my case, the binding
>>>> code allocates the user pages memory and returns without bounding (at
>>>> amdgpu_gtt_mgr_has_gart_addr). So,
>>>> when the unbinding happens, the memory needs to be cleared to prevent the leak.
>>> Ah, now I understand what's happening here. Daniel your patch is not
>>> really correct.
>>>
>>> The problem is rather that we don't set the tt object to bound if it
>>> doesn't have a GTT address.
>>>
>>> Going to provide a patch for this.
>> Did this patch ever land?
> I don't think so but I might send a v2 following Christian's comment
> if you guys agree.

Somebody else already provided a patch which I reviewed, but I'm not 
sure if that landed either.

> Also, the patch here is for radeon but the pagefault issue reported by
> Felix is affected by the amdgpu one:
>
> radeon patch: drm/radeon/ttm: Fix memory leak userptr pages
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Fdri-devel%2Fpatch%2F20210318083236.43578-1-daniel%40qtec.com%2F&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C65d21b6f02da409ac7b508d8f9997367%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637533784761980218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HSMK%2FqYz%2Bzz9qbKc%2FITUWluBDeaW9YrgyH8p0L640%2F0%3D&amp;reserved=0
>
> amdgpu patch: drm/amdgpu/ttm: Fix memory leak userptr pages
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Fdri-devel%2Fpatch%2F20210317160840.36019-1-daniel%40qtec.com%2F&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C65d21b6f02da409ac7b508d8f9997367%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637533784761980218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UsUZ4YjCSjHmzlPB07oTaGrsntTrQSwlGk%2BxUjwDiag%3D&amp;reserved=0
>
> I assume both need to be fixed with the same approach.

Yes correct. Let me double check where that fix went.

Thanks,
Christian.

>
> Daniel
>> Alex
>>
>>> Regards,
>>> Christian.
>>>
>>>>> [17359.536303] amdgpu: init_user_pages: Failed to get user pages: -16
>>>>> [17359.543746] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>> [17359.551494] #PF: supervisor read access in kernel mode
>>>>> [17359.557375] #PF: error_code(0x0000) - not-present page
>>>>> [17359.563247] PGD 0 P4D 0
>>>>> [17359.566514] Oops: 0000 [#1] SMP PTI
>>>>> [17359.570728] CPU: 8 PID: 5944 Comm: kfdtest Not tainted 5.11.0-kfd-fkuehlin #193
>>>>> [17359.578760] Hardware name: ASUS All Series/X99-E WS/USB 3.1, BIOS 3201 06/17/2016
>>>>> [17359.586971] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
>>>>> [17359.594075] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
>>>>> [17359.614340] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
>>>>> [17359.620315] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000000000000000
>>>>> [17359.628204] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff950eadec5e80
>>>>> [17359.636084] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000000000000000
>>>>> [17359.643958] R10: 0000000000000246 R11: 0000000000000001 R12: ffff950c03377800
>>>>> [17359.651833] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000000000000000
>>>>> [17359.659701] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) knlGS:0000000000000000
>>>>> [17359.668528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [17359.675012] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 00000000001706e0
>>>>> [17359.682883] Call Trace:
>>>>> [17359.686063]  amdgpu_ttm_backend_destroy+0x12/0x70 [amdgpu]
>>>>> [17359.692349]  ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]
>>>>> [17359.698307]  ttm_bo_release+0x278/0x5e0 [ttm]
>>>>> [17359.703385]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
>>>>> [17359.708701]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x7e5/0x910 [amdgpu]
>>>>> [17359.716307]  kfd_ioctl_alloc_memory_of_gpu+0x11a/0x220 [amdgpu]
>>>>> [17359.723036]  kfd_ioctl+0x223/0x400 [amdgpu]
>>>>> [17359.728017]  ? kfd_dev_is_large_bar+0x90/0x90 [amdgpu]
>>>>> [17359.734152]  __x64_sys_ioctl+0x8b/0xd0
>>>>> [17359.738796]  do_syscall_64+0x2d/0x40
>>>>> [17359.743259]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>> [17359.749205] RIP: 0033:0x7febb083b6d7
>>>>> [17359.753681] Code: b3 66 90 48 8b 05 b1 47 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2d 00 f7 d8 64 89 01 48
>>>>> [17359.774340] RSP: 002b:00007ffdb5522cd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>>>>> [17359.782668] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007febb083b6d7
>>>>> [17359.790566] RDX: 00007ffdb5522d60 RSI: 00000000c0284b16 RDI: 0000000000000003
>>>>> [17359.798459] RBP: 00007ffdb5522d10 R08: 00007ffdb5522dd0 R09: 00000000c4000004
>>>>> [17359.806352] R10: 0000000000000000 R11: 0000000000000202 R12: 0000559416e4e2aa
>>>>> [17359.814251] R13: 0000000000000000 R14: 0000000000000021 R15: 0000000000000000
>>>>> [17359.822140] Modules linked in: ip6table_filter ip6_tables iptable_filter amdgpu x86_pkg_temp_thermal drm_ttm_helper ttm iommu_v2 gpu_sched ip_tables x_tables
>>>>> [17359.837776] CR2: 0000000000000000
>>>>> [17359.841888] ---[ end trace a6f27d64475b28c8 ]---
>>>>> [17359.847318] RIP: 0010:amdgpu_ttm_backend_unbind+0x52/0x110 [amdgpu]
>>>>> [17359.854479] Code: 48 39 c6 74 1b 8b 53 0c 48 8d bd 80 a1 ff ff e8 24 62 00 00 85 c0 0f 85 ab 00 00 00 c6 43 54 00 5b 5d c3 48 8b 46 10 8b 4e 50 <48> 8b 30 48 85 f6 74 ba 8b 50 0c 48 8b bf 80 a1 ff ff 83 e1 01 45
>>>>> [17359.874929] RSP: 0018:ffffa4764971fc98 EFLAGS: 00010206
>>>>> [17359.881014] RAX: 0000000000000000 RBX: ffff950e8d4edf00 RCX: 0000000000000000
>>>>> [17359.889007] RDX: 0000000000000000 RSI: ffff950e8d4edf00 RDI: ffff950eadec5e80
>>>>> [17359.897008] RBP: ffff950eadec5e80 R08: 0000000000000000 R09: 0000000000000000
>>>>> [17359.905020] R10: 0000000000000246 R11: 0000000000000001 R12: ffff950c03377800
>>>>> [17359.913034] R13: ffff950eadec5e80 R14: ffff950c03377858 R15: 0000000000000000
>>>>> [17359.921050] FS:  00007febb20cb740(0000) GS:ffff950ebfc00000(0000) knlGS:0000000000000000
>>>>> [17359.930047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [17359.936674] CR2: 0000000000000000 CR3: 00000006d700e005 CR4: 00000000001706e0
>>>>   From what I understand, the init_user_pages fails (returns EBUSY) and
>>>> the code goes to allocate_init_user_pages_failed where the unbind and
>>>> the userptr clear occurs.
>>>> Can we prevent this if we save the bounding status + userptr alloc? so
>>>> the function amdgpu_ttm_backend_unbind returns without trying to clear
>>>> the userptr memory?
>>>>
>>>> Something like:
>>>>
>>>> amdgpu_ttm_backend_bind:
>>>>       if (gtt->userptr) {
>>>>           r = amdgpu_ttm_tt_pin_userptr(bdev, ttm);
>>>>           if (r) ...
>>>>          gtt->sg_table = true;
>>>>      }
>>>>
>>>> amdgpu_ttm_backend_unbind:
>>>> if (gtt->sg_table) {
>>>>           if (gtt->user_ptr) ...
>>>> }
>>>>
>>>> If you agree, I'll send a v2 patch. Otherwise, maybe we could return
>>>> within amdgpu_ttm_tt_unpin_userptr if memory hasn't been allocated.
>>>>
>>>> Any other ideas?
>>>>
>>>> Regards,
>>>> Daniel
>>>>
>>>>> Reverting this patch fixes the problem for me.
>>>>>
>>>>> Regards,
>>>>>      Felix
>>>>>
>>>>> On 2021-03-18 10:57 p.m., Alex Deucher wrote:
>>>>>> Applied.  Thanks!
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>> On Thu, Mar 18, 2021 at 5:00 AM Koenig, Christian
>>>>>> <Christian.Koenig@amd.com> wrote:
>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>> ________________________________
>>>>>>> Von: Daniel Gomez <daniel@qtec.com>
>>>>>>> Gesendet: Donnerstag, 18. März 2021 09:32
>>>>>>> Cc: dagmcr@gmail.com <dagmcr@gmail.com>; Daniel Gomez <daniel@qtec.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>>>>>>> Betreff: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
>>>>>>>
>>>>>>> If userptr pages have been pinned but not bounded,
>>>>>>> they remain uncleared.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Gomez <daniel@qtec.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
>>>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
>>>>>>> index e8c66d10478f..bbcc6264d48f 100644
>>>>>>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>>>>>>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>>>>>>> @@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct ttm_bo_device *bdev, struct ttm_tt
>>>>>>>             struct radeon_ttm_tt *gtt = (void *)ttm;
>>>>>>>             struct radeon_device *rdev = radeon_get_rdev(bdev);
>>>>>>>
>>>>>>> +       if (gtt->userptr)
>>>>>>> +               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>>>>>>> +
>>>>>>>             if (!gtt->bound)
>>>>>>>                     return;
>>>>>>>
>>>>>>>             radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
>>>>>>>
>>>>>>> -       if (gtt->userptr)
>>>>>>> -               radeon_ttm_tt_unpin_userptr(bdev, ttm);
>>>>>>>             gtt->bound = false;
>>>>>>>     }
>>>>>>>
>>>>>>> --
>>>>>>> 2.30.2
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> dri-devel mailing list
>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C65d21b6f02da409ac7b508d8f9997367%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637533784761980218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=aU9ZAl66EOLKphjWFPXJPR%2BTM%2BZeeMv%2BVJC6vliEqrs%3D&amp;reserved=0
>>>>>> _______________________________________________
>>>>>> dri-devel mailing list
>>>>>> dri-devel@lists.freedesktop.org
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C65d21b6f02da409ac7b508d8f9997367%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637533784761980218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=aU9ZAl66EOLKphjWFPXJPR%2BTM%2BZeeMv%2BVJC6vliEqrs%3D&amp;reserved=0
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CChristian.Koenig%40amd.com%7C65d21b6f02da409ac7b508d8f9997367%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637533784761980218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=USmYbhfkSfPcE1npvsMfRwBr9Ijresh1fH4cAeNEr2M%3D&amp;reserved=0

