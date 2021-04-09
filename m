Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753E359CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhDILIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:08:15 -0400
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:14484
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233681AbhDILIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBR2mfWm/zTcx2YqPlBYaJYEby2Nhcvu9BIkgEeS/y3kfIyzP48PgGaiqrXGd7PXYYGDnIZT1sJG/ZtIiZh4dnKS+Kq26du+KnM7tJmntZ/2dSeo+PdA3cYyT5jgLgZ49+ba7QCUl/BO+NONw75sbYhOo4tYCzE0AzBiTlDxcI4s3egGLKE/VQNSpBjzuyq+EOVNPIYjwTZPr+/I2NkkFXoqhBba0AnouRTPcVILY+l41Mr2kqgly4kPdIbywr5N1xYmFI4YwPoN1DAvPymESTgaX6cEcOJmjrsm6nBDMk3cqCQgGzn9x5Kywudy4mg2bTPDwPlMeXaBKWpmpWH5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIbM3iLEuWRcfaXjvJDp1zKFn+QX48gkUQBwX9122E4=;
 b=gI/DaMQxVmX4S+gnSMEXKa82J9i7ZGYaKXgs5Lrs9cYblMwW8tVAh/L6HnJgMoMRp4Niml4tBF/U7mYkSoJ1g9Df8bOkm115ongroRqqMXPRoakX9vZY7wZuW3oT8Da1q/f5NPAOc37XUeTLXe7axel+dXE4us7EXMJjtcwvWN/dTGObwW1z6QfRxIQ7qFAFt3qZehC+RKkLjnXF56TvCLnX9z4wUgvHHu54iQHtt8/xM24XsGjgzvcXgO3WOgULYLQUe8M1HMiL1lgxHC1RdhRaK+PpAuEeheO1z9qUGXohEc61CILbeheFwaP05jdp0kGER308eLiR1PdxRQXe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIbM3iLEuWRcfaXjvJDp1zKFn+QX48gkUQBwX9122E4=;
 b=J3x3q5685YJ001cSs6g7rNXMvqUWbUHfAmJdUqSxVTYMqUbw6YKPz9754qGoUD11iw2rfvn2BL7uc/IMDl1PocIq3ju5ijLoEk4x+Q5Qv1ZLOfp9Rb5gJii+Z/UAseFcPYQQTnVP59VOF0GAt783XocMdVMUq/72DemCEi93YXk=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Fri, 9 Apr
 2021 11:07:58 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Fri, 9 Apr 2021
 11:07:58 +0000
Subject: Re: [PATCH] drm/ttm: cleanup coding style a bit
To:     Bernard <bernard@vivo.com>
Cc:     Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <AJ6AJwDpDj4OHkToJ0s9uKqk.3.1617242344627.Hmail.bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <42293377-a934-fb07-2677-3a8aff1a3ce5@amd.com>
Date:   Fri, 9 Apr 2021 13:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <AJ6AJwDpDj4OHkToJ0s9uKqk.3.1617242344627.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ffef:9b69:ce50:8284]
X-ClientProxiedBy: AM8P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ffef:9b69:ce50:8284] (2a02:908:1252:fb60:ffef:9b69:ce50:8284) by AM8P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 11:07:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69af80a3-c76a-4374-08a2-08d8fb47bb46
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566EC6BD0C259959341F14883739@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZ1wx5oZ5xng8Z2pXP1HRWZBvcigAQS4G2mIHiZBpomN7ojG3qk45NFfdLgfPCEJaMgi96RfJUZMuWX3kIgRNuf6K56LS/dCUkrIyNmdN26PE20Zt2r6LHOWKvDcALGZzNJggeOAXjo2ohwqUPCmRwYh3G2dNxd6398dIhVp1mYhlfsn8mMWPe64yh2TlSmAqlLU1Rf2/FL1RbzLeenwf/oJi7dNtYXdu6PynEBc29QcLw1XWNutKcEEqhFCCtiWbJsbAKlLfD14jPvc5fWnb4B/cGYqG37YMgg2QDDJ0Nrxh008Kd1vKr+cOpt4mW7DTtKEpwAyWLOI7f0FafwaPma0kS9meivjZ4Fur8o/9gsiKU6WTdrcXXlARjD4oHV8vrSrAe6QK5pAAeDCSQOg9J8VU/1TtH+hv+Z/ivIQV0zh1oAMCC8/TDekQClWP0T0isM52LykcftR7cWcgVWQK2BXaRacBv5fWfMNjB6/ZmPGZ9TKHEsNau1EMaAPxy11vafpVkovgq4lzaDweINU7fFjic5A9dZULmM+PDD74NK8OTO+BG3bGDiWLOv34CrMpOhnosqJXJhzMX47oQcrN45NoeUXU/bcASMj1Xbt9f9/rJRRDiuNB8evvhb9Nuo7seOPTy2KfuYjHerr4ScY9pMM6sEU/TCkupS8SA11MpxGM/cPI9f3z7qkI0E7zdgct/WrYFZB9QMF8gwfMdyXfhNjh5KgX02obOkZRQv75xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(31696002)(52116002)(2616005)(5660300002)(86362001)(4326008)(38100700001)(83380400001)(8936002)(66574015)(6916009)(316002)(8676002)(66476007)(66556008)(31686004)(478600001)(2906002)(54906003)(36756003)(186003)(6666004)(6486002)(53546011)(16526019)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ek5wb2dlV0lPOEdXK09FM21NbW9QS0UxZnR4aHdSQ1ovc0J4M3U5aklmN2Jt?=
 =?utf-8?B?eURUU0Y3eEJwbEY3NEF4NXJnZzdqMEJxNDc0M2FvZlB4UTEzZHpEVVNwN3JB?=
 =?utf-8?B?M1RhM3VCRjF0aEROWFdlRFpKOVdPVVE1Vmd1bEI4ZjJkNEdaWS95aDMyZzdo?=
 =?utf-8?B?anZoYWtGRFhkVEozdlRaeGFMY053UUNMM1hOSW5COUpZc3hqd0QyM3FxSHYv?=
 =?utf-8?B?ZWdLOStuSU9DemVVbUM4SUg5alZIVkpNZWY3SDlaUkdCeXpxZW9hVW1xcGl6?=
 =?utf-8?B?bFc4bkVlVXp6blhYYmRvamw5ZE9IVnJvaFRIZForTUIzbVBEVm1FTitZd0JY?=
 =?utf-8?B?ZjB4V1FIcHJ6elJqZk5ObVpmenU5ekFhb3U2KzFaVGxhU0FMT3gzcGdMNmsx?=
 =?utf-8?B?VGNyNElwM1NtL1VyL0VoVVM4cExSZk9Od1VzR1pKazkyVW5MbVQyQU9Bd1I5?=
 =?utf-8?B?dUlmekErdWtUZlZ5SkpJVmRndWx4Z3FYVldWZUxRdVNySjBhNFg2cFhER0ZF?=
 =?utf-8?B?MHcra0VxN0MrNmJhQnJEcEV6WHFqdEg1ZFovdmt5dmZISnlFMnpvV05nbFI4?=
 =?utf-8?B?cWprR1dHY1l6c2lBY211Tk4wT2gwcjgzWDVid3JNQkFNbjhJRTdPS1pFRTlV?=
 =?utf-8?B?TGRrajFTUkJyeWRRRmVnd2E4eWZybnBPcDhHejh2dHk2R1ZJNTlOdUphWVFH?=
 =?utf-8?B?NWZwK1VVdjJTOVowWjRWYk9xLzBseEhyTjBGWFdHUTdYN2FDYzlTbSt0eExl?=
 =?utf-8?B?VmxmSXZXZjhEUnlhcG5heDZ3TXdsZHNVckVtcE9ySmFrZFptTDlUWGlFdDZh?=
 =?utf-8?B?dWFFa1FtemNGQlJRR004RkpFR1EvTCt5VERmUDFiTHhQbGU4VHM3TnJBd1pm?=
 =?utf-8?B?M1c5UUhITnJvTVZkWktORndkSVppczBUMEN2YWM2NkRqWXhsVlRML0NVRkVx?=
 =?utf-8?B?WjVmMWd3WmxUZnFIaDduU3orV0JycURRejF2QkxBOE5weUhWN3piVzBPY2Jv?=
 =?utf-8?B?TkxvSm9qYlNFd2V6ZG1MTzRnZUJMWEZML3psQXRVZVA5bmQxU3N3RHk2OXpT?=
 =?utf-8?B?RGJjeEZVMWFXRHpoYWVZMVVnc3FLbGJLZE9VQWpBbldjeUpmTk5BdUtZcGRF?=
 =?utf-8?B?TEp4RUpSYU1EQW5nM3NpOFdMMTYxYkM5bVEyUm1CNVYrS1RpTXdCbHVpd2ZX?=
 =?utf-8?B?OEFqbm1SUjIvdFIwK0d5T29jdE0wK1ZobEZHVnRZMEduZkdSSlJYNXpSSGIy?=
 =?utf-8?B?aXlGNGhnUmhiMW1YRG1zRkJkVHp3cndUSWNHNWwvMEdBWXVOMEozWVUzcHJp?=
 =?utf-8?B?OHJlbW01WFFGMzFXQXZyNUJ4dTJHQzc1Z2tFV3Z4cnBDUExZSzRwZ1F2MHhJ?=
 =?utf-8?B?RGtSSFlTZlRCTG9CZUsvRzJaVVV5czk5UzJOdmd3UC9hdDdaR3JFOE92dVhZ?=
 =?utf-8?B?T3RxZGc4SnNRUk1GK0trV21TdHpJbThFbjJHb3EvMEVXSmNqU2xzS1RiMDQ0?=
 =?utf-8?B?SEpncm5tMGo2aXlmMWJNd0dKRGRQZ0I2a3FkT0pvaFRORm5Eb05SSU1uSHJz?=
 =?utf-8?B?bmpJYmplS09xclBpbFRVdGtKVHFDNHV6UVVaaDg5VHZCbk9SY3V3bUpndnpa?=
 =?utf-8?B?Sk5QTW1WRzZ3U0pZZS8rR2lYU2lOODFMZ1RlUXB0eTFueE1XS1JmditYRVNL?=
 =?utf-8?B?WkNScUlMOVJpdHZnTm1XYTkzZ2hQZFhZVS8yazE2ckZRTU1adXllUkFRTHpV?=
 =?utf-8?B?WHd4RnJuOWtEMFVlbXRnMTF0djIwYzhOSFphT2wxaXBIOWduWitldVZsRksr?=
 =?utf-8?B?ZmhzWDRjWW5HVU8wQzVmS2xMakZHbWhyRnk3RlM1UjdSMVMxcnJJZzdWOTJo?=
 =?utf-8?Q?PQGDrjQRoLUKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69af80a3-c76a-4374-08a2-08d8fb47bb46
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 11:07:57.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bm3gqhA3bmec+4NvgR1Rwen0NyTg9lTQ2Kw8bOaOHUTy0FtMGdJenHg8X156iQYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.04.21 um 03:59 schrieb Bernard:
>
> From: "Christian König" <christian.koenig@amd.com>
> Date: 2021-03-31 21:15:22
> To:  Bernard Zhao <bernard@vivo.com>,Huang Rui <ray.huang@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
> Cc:  opensource.kernel@vivo.com
> Subject: Re: [PATCH] drm/ttm: cleanup coding style a bit>Am 31.03.21 um 15:12 schrieb Bernard Zhao:
>>> Fix sparse warning:
>>> drivers/gpu/drm/ttm/ttm_bo.c:52:1: warning: symbol 'ttm_global_mutex' was not declared. Should it be static?
>>> drivers/gpu/drm/ttm/ttm_bo.c:53:10: warning: symbol 'ttm_bo_glob_use_count' was not declared. Should it be static?
>>>
>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>> You are based on an outdated branch, please rebase on top of drm-misc-next.
>>
> Hi
>
> Sure, thanks for your review！
> I will fix this and resubmit this patch.

Found some time today to do it myself. Please review the patch I've just 
send to you.

Thanks,
Christian.

>
> BR//Bernard
>
>> Regards,
>> Christian.
>>
>>> ---
>>>    drivers/gpu/drm/ttm/ttm_bo.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>> index 101a68dc615b..eab21643edfb 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -49,8 +49,8 @@ static void ttm_bo_global_kobj_release(struct kobject *kobj);
>>>    /*
>>>     * ttm_global_mutex - protecting the global BO state
>>>     */
>>> -DEFINE_MUTEX(ttm_global_mutex);
>>> -unsigned ttm_bo_glob_use_count;
>>> +static DEFINE_MUTEX(ttm_global_mutex);
>>> +static unsigned int ttm_bo_glob_use_count;
>>>    struct ttm_bo_global ttm_bo_glob;
>>>    EXPORT_SYMBOL(ttm_bo_glob);
>>>    
>

