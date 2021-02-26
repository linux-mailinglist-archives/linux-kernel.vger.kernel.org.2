Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63F8325E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhBZHxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:53:42 -0500
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:28352
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230022AbhBZHx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXHSlDfLtwsv5oDCMHk6OtUK2eH+hdHaIXSzDM1t9nVWmczdapzxCqZx6+U1KO3fsxh/+CjKLEJKaHVqOUB/Ae+qbI5NvzdEd9s4zmSnMYKym18DQ+6ZazOFFndNynZHd+3IvxcP6o21k5ZprzriI2MeH4pTQxpIA6PZ3yruw6z6fiKj2gORKn2d1Yds/Xj6PEeeB+GsJ3ivhoKRp5WVsT7IhfPUtgJ/n/dDSqG6+Jo01SvHlCmGG4DohljHl3LKTUvEKT9DTQTr6cbmQ8I2qGVmCSmIyduQ3oFJSD7beIX2sML0asGzMswhNd3gdgWolbWxhg/AWwMXA0Mxx0IqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBH6Rmgmdubjj9KCMSI3FkvN0Xcijp+GpeaNa8cgpFQ=;
 b=S4iM9NrJrZ4eNVJh94PdtfIs15tRUkgexn0dQjvjJW1gvwDGve54Rg0aF6vOsG+eZwKtI6A8nOSIdoqN33lwCYZ6ZxTwemhwkCA1m8LX3wRjqTZkVEYLS9khs/giW6vhWafAHTMJi0QXYHs+SIq03Tf1xQx3U3B8/9EbHsg4LtAFYBV1lmElTRcR4mLtgapChlrSo9qO1JiON0h2sG1JArVz6HrPbdndyHYKqMUnP/RRW5WmDFX1j31FFaUftulg5FVYOMusF3ti5nqwoOFZOKm/aTCJnbA/veLy2n/eOGat3976MPuApyixaK2rGMVfXxfDJeNxrVv1oh+xZHeESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBH6Rmgmdubjj9KCMSI3FkvN0Xcijp+GpeaNa8cgpFQ=;
 b=0K8ND9u9bdzFuJAghuLCnKXS6NYhGVu8UAUcrA4K1Gj+SKQzBHQk0MHdnFgZwQS+GfoRr6ATomYMswhqE75TNGMDo8zPk3Jl2Lj9ook9qY+gGCM2/zxLVHuPcDAMFe0Q3AlcUfmpIiKTq9EOYvrKQLTYB3vLbOA/hp+91OwZ9WE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 07:52:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 07:52:37 +0000
Subject: Re: [PATCH 0/3] drm/ttm: constify static vm_operations_structs
To:     Alex Deucher <alexdeucher@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
 <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com>
 <YCPcIwxso67M3VqR@phenom.ffwll.local>
 <CADnq5_PPeNxBSryxJbT1sX=n_m_3HxKtGk5QRxtczU9qdae3cw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ebcc73e-ed35-7bd6-5b4e-993ffbffb868@amd.com>
Date:   Fri, 26 Feb 2021 08:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_PPeNxBSryxJbT1sX=n_m_3HxKtGk5QRxtczU9qdae3cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:bcf6:4057:c09:be71]
X-ClientProxiedBy: AM8P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:bcf6:4057:c09:be71] (2a02:908:1252:fb60:bcf6:4057:c09:be71) by AM8P189CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 07:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b43910ed-7e7b-47d2-06fe-08d8da2b7bb3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:
X-MS-Exchange-MinimumUrlDomainAge: lists.freedesktop.org#0
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40479C03DA628165C44502CC839D9@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2G2ty0oW3VOSOD8qE0Rq2mtyUXlWd+moOdti82uQli15x2NZJ1zfYuFwbXR66Hl6G4ExPP45eJPmxQC+rQPccNUgRxvYkDcwndUkiFJ0F7552irG/tXfVBhexPmbCcD1Ib4lLR+X28RO4GVt3513xKwZ4J30GsPcaO7sh0SV4a6edt1TgQsO3ErtG5653lcWBj7SgNpEavcnfqsfoAJ7MUU0ph9c/PrB3GNjVbn/fEOUpRgpLhmDTsYryL4D0TzPglET7MxdJI/QKBI+cftkvn1qR3Wxu1S4fPq/mAf/weFGxGZNmSzb1E256pHomqEM3Y0Ku5AuzPON0LLQ6q8PEg7l4wIybu1ioLUJz2lH+FpyhnWglOo8rpuJQ6I90blh6iy1m13OgXhNFTcpfkIrpeAmdWByp6Aq9pW3gms01tbVJzbTX5okq0RX7HPj7HvH/Je9TwVoVo2whytHRXwwVnhmRVIznR2ED8wNAHC8Yvr6m7UcR/CbQq13cxGBCBj6M5lgMrmTWS1d2+1nqGyTeo1Q+5xTV7qVz4NccfxRyhWm23js+kuwkRlPmvqAe192dwCO1POO0/df+Ez4hunQUPMocfcxk+D15hD73DMdS3RDzYpxmV+fq82jmRyiEKa2TnO3Ousoxv6RNiAwG4RvmAquthppVWab00BC1BoTtC/A68+x4dAqSnsAg9ZHjOFx0zJ8JzQeRuluCXK3o2rDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(83380400001)(45080400002)(478600001)(186003)(2906002)(2616005)(36756003)(110136005)(966005)(921005)(66946007)(6486002)(31686004)(16526019)(5660300002)(6666004)(52116002)(8676002)(86362001)(8936002)(53546011)(316002)(31696002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGsxYWpPZUlSL0w2QWFYSU5hTm1LU3F2UmhFUHIrV25PZWZLMkVYVzNIRW91?=
 =?utf-8?B?dGV0bUR0bHNsSFQvUE11RnRwUU9sOE11MXVDZkE2eis2b05UWWZlRklhSE43?=
 =?utf-8?B?Rzh4bXBwcVZ3cGUzQWNEV0laaWV1Q0JSSEZjN0FOanI1YU04T3VjbEwwclN5?=
 =?utf-8?B?NE03dTF3R01kcXZMZ29MQ2FKK1ViMXJ0QlZLRFdQNzhkVkQ3SkYySC9SdDQ5?=
 =?utf-8?B?U09yN3pacXZPY3dkaWlYZjJpRmNJL05EZjZqQmo3YnBBOTMvaTRWbGJQeXBt?=
 =?utf-8?B?cDNxUWs3V29HMXpydk5EWHBveXBkS3E5a3lCSER4VnFyc2Q5YkxsSlhTdVl6?=
 =?utf-8?B?SXJ0UFc0bGw4MmcxbGQ4R0I2QVlCejV0cXltdVpZU2N5bDFGSm5Hc01yWDRh?=
 =?utf-8?B?cTIyZElLTjljbWJpcmpxU1VUc2Zwcno3OEVUWlh0TnUxMktCTWZhSFA2Zzhm?=
 =?utf-8?B?cW5GUEdWVlB6NmM1aHJ0cVNzUUVtWGVRcGx4K2xraUIzTktORVhoazhLbEdI?=
 =?utf-8?B?RlhEVjR4N3lSSUQzd1N1M3ZDMUQvbDZiTXVvWndURFF6VFQ4bm9FZEk5MUpJ?=
 =?utf-8?B?MUtaUmttNFBaakFuTm8xVzdydmIxSEJNMkJMdEw4RVdRczdpTitydEFiNzZx?=
 =?utf-8?B?M3RVWTdCRm95K2hQckdlQVhnQWZETHg2eG9GNkIrOW5QQ3FCYTQvb1ZwY2tj?=
 =?utf-8?B?VlAyNGNZbnJBVnVQK3pEa2pSbmlHejh5a1Rlem5UUmx3UkpYYmVJbnZlVGEx?=
 =?utf-8?B?a25veS9SQWZ2Z0lvUWF3VVh5a2dyYlRXdkxHUjJraHNmOEZobjcreitQdC83?=
 =?utf-8?B?SmQ4ejNWSFB5YnlkOW9MTTQ2TTQ0VGY4Wm5jTW8wT0VVZWtnMzV1bTZMYWRh?=
 =?utf-8?B?bE1ZNzE3YlJmcW5aMXJjR2pxRHE4R2V4djBsSEw1WmVvU3YxakZKajZMMGJI?=
 =?utf-8?B?bTAya3c2SGUvVnpMRzNsTWl0a1p6aFJkcytONjY2Witac241YVdMbHMvelFo?=
 =?utf-8?B?MGZRN3VlNXdxRzBOTWRNeXc5Myt0SUJ1U0ZQYjVnWHFGL3E2Sk1Hc1ppTXpm?=
 =?utf-8?B?d25MNFpKRHMyZjF4M3E3YkVnamZFWmZDNGVpRXA4VVNKYXJyT285dzZmbmlC?=
 =?utf-8?B?U1h5S2w1UUJqTkZlV3RPcTlmeXVCM24xYVlqa3o2clRFSFdHMGFJQU83QzBw?=
 =?utf-8?B?V09DM0srR1VtZVk0LzB2M0lJQjhPdXhreWpvNTNuUnljdVRFT2JFSzFFd2pW?=
 =?utf-8?B?Q2prOGZ2MnZ3Wk82dUgwbTJ4bUQrWERxWkhJR1huV0pTS1NMWUN2SjV0UTBy?=
 =?utf-8?B?a2JsYjdjSjF4SzFETEtGV1pDNFVEMS9QUXZKYXN3b1M2ZWRXQ3U0WWYxUDJj?=
 =?utf-8?B?OGxoYU82Qk91TXNDejdUc3BndHBnZlBERjNqYWp6bWhWSjFXNkljTm1oUWpt?=
 =?utf-8?B?eDRQNEx3TUJ0dVA5cDJtcVpMRFZZNG1vb0xySzF6bUNjZjhyeVdMWmcyNXFr?=
 =?utf-8?B?RFRaMnBoUTZISTNld3IraXVqejlZT3lXRXFPQlQ0eDY4MXJkZkw0ZXFRWjAw?=
 =?utf-8?B?bHVzaDAyU24rVmM4UG11TElMMHZxOTBNa2ZjVHB4VFVseUVRMnk4VnZWbGd4?=
 =?utf-8?B?MXR4R1E5ZjcxZUUwWFdEcG90L3o4bmhwd3VOTUVFUlBseHVpaERyQUxzT3Na?=
 =?utf-8?B?d2FnTm1XYm5HbUk2TFdvaTMwa2NVNUpZbk40U1RXL0tXU0xmaHlSMTBVamF6?=
 =?utf-8?B?ZllndUdYN3VTVXZ5aEhyb2tNZFg0WjRta3o0M3JIYTcwR2FMWDV6V004cmZW?=
 =?utf-8?B?UzlIdU1PY3hOZGY0Q3BsRDNWUWJ4THB1MUk1RW5MRXp5Q3plSktZK2ZTSDFp?=
 =?utf-8?Q?+GpgKuQA31dow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43910ed-7e7b-47d2-06fe-08d8da2b7bb3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 07:52:36.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdYQWc7WvKrzG9bW1N8RZiLEesexYC7OLsVSumoEshS0ACu2z/Dmny3VgC0ZULxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.02.21 um 18:31 schrieb Alex Deucher:
> On Wed, Feb 10, 2021 at 8:14 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, Feb 10, 2021 at 08:45:56AM +0100, Christian König wrote:
>>> Reviewed-by: Christian König <christian.koenig@amd.com> for the series.
>> Smash it into -misc?
> @Christian Koenig did these ever land?  I don't see them in drm-misc.

I've just pushed them to drm-misc-next. Sorry for the delay, totally 
forgot about them.

Christian.

>
> Alex
>
>> -Daniel
>>
>>> Am 10.02.21 um 00:48 schrieb Rikard Falkeborn:
>>>> Constify a few static vm_operations_struct that are never modified. Their
>>>> only usage is to assign their address to the vm_ops field in the
>>>> vm_area_struct, which is a pointer to const vm_operations_struct. Make them
>>>> const to allow the compiler to put them in read-only memory.
>>>>
>>>> With this series applied, all static struct vm_operations_struct in the
>>>> kernel tree are const.
>>>>
>>>> Rikard Falkeborn (3):
>>>>     drm/amdgpu/ttm: constify static vm_operations_struct
>>>>     drm/radeon/ttm: constify static vm_operations_struct
>>>>     drm/nouveau/ttm: constify static vm_operations_struct
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>>>>    drivers/gpu/drm/nouveau/nouveau_ttm.c   | 2 +-
>>>>    drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
>>>>    3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C9d730e56efe54d3215ee08d8d820d642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637496982837619645%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=b4UU8bzeX%2Ba1VfObe8mta7fwtjVv%2F1wo4%2FPVuGZFW8Q%3D&amp;reserved=0
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C9d730e56efe54d3215ee08d8d820d642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637496982837629638%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RKJh6p%2BTxaD0lH6M%2B0s3nah3tBatRFqoTvy3Mh7Lz5M%3D&amp;reserved=0

