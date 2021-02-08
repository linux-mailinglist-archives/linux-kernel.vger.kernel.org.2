Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49837313256
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhBHMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:30:31 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:34304
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231148AbhBHMPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:15:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM6EiUZs71SgnFYE1ns+0wDl4tmIrd1lxi1p0Hc2KXsIs3zKLlExWSDas5+pjx3U2CF/lAWs4y2sZujnZq35Ksaf6P3BqntIYKQcyV1J6UmVgzbN+ziZzu10FTuZ8CVfIVFmINXt+d9S+/FlhVZqUqM62bdoXgVL4LK8ZF2qp2KntQ+YM5l7Cvaionzq+8fh7aNYIOkCHyIFEP4e3tLGOTD3B1+p6P8JplTUnNBEZNgEtNJ8APfEYSWWz33Ja+1Mt6PQa+YosC6rdMuj2wpq5PcxKqxrkovmiNk/McMJYOmN4/nPM/GxFnlnPsSygjhgbMmogAfT47J8OQJzXZbAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7cp3d5PdEbwJD96QXJ6NN3uF8k8qzXjcQ1n1dC/U4M=;
 b=Ky15JuauYGy4rsP5inwOlYPVxYCRxBr+QJByy1eZ6Y+URzWJxBSJfXXoHAR8Se01Xh7PnyOnyLtMjqz697OH1etG4+uoDbYRAuiSd+6EaJe4QZIrxQcyiiVYFdRynZLuplHjKg2NOl3lZ3kYyAkQMrVKvmMnWNboo+JwqznUAPrU3THn19Fg8Phk1IkldEGl2Fx+siPL7zyF0ntqyJGDXwHCTB+FcA7RIGEr+gWw3+VZZByXM78sCqV6IOeALaC6z9AHcjzBF7FLzeuoLohecYrulEzrlas7KU5WlfzUarcagXar2KPdf4B2bL9m/ii2pIQ1ApWz1/byTW/Fvoyuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7cp3d5PdEbwJD96QXJ6NN3uF8k8qzXjcQ1n1dC/U4M=;
 b=On3XXYJycuLoQL+S2ug2DqK+0VfsDaywBb6tpJzXAnA/ltZck8tzk2rfDWKNzKEemEFHki/hiYivVrF8h5fA06PlwOtQhXvxJtpUkxqtPVAvex71cKip2qgC3oE28VR/mgqQPQ5bBTTDeZt83ayQKMDL5lSjAY8lv+g0xvEEDuw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 12:14:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 12:14:55 +0000
Subject: Re: [PATCH] drm/amdgpu: fix potential integer overflow on shift of a
 int
To:     Walter Harms <wharms@bfs.de>,
        Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210207230751.8576-1-colin.king@canonical.com>
 <c6c99dba-aea9-304c-2246-e24632955479@amd.com>
 <3aed86cfb8014badbcbc4ee9f007976d@bfs.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <877bdf13-08d3-b471-40fb-02941cce3e4e@amd.com>
Date:   Mon, 8 Feb 2021 13:14:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3aed86cfb8014badbcbc4ee9f007976d@bfs.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:205::41)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:205::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 12:14:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f643ca1c-307f-4a66-a7af-08d8cc2b2526
X-MS-TrafficTypeDiagnostic: MN2PR12MB4343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4343A284A015D17CEED93379838F9@MN2PR12MB4343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spGpbA4CIkWtOQ9ynagqgpYWCs2jVUlF1/bvuSlsIHautJJDZ8yShf424guU2OBTxGn7Dg0MITVvb7lbuezdzHR64NSloBtW6DJcQv/gpkbDdEBpwEKWg/grOBwnmnzWetg6yKCG4o2s3DJg5dV04zXWI0dM0aTxcQRFJArToZwsfMTXE1ORVN1vHf9ulRT1T0K33Ppql7HUw9EgUGheuhAnD1SKT85MdceLXbwhyoqHhZKalT0peJMCCGKSDhJVBr4wJqblAaVGxs65Vnp2qLsZuqx+JcD1AWKuXu5KnHRu36eX/dDyQ9MIx7hMxDOqrFWYgTkEltny9Utp0nmbV0cD1IbkWEwnFdKoIG6IBQJSIraSab9A/a9RqdSmR9CY8b12LytmKdsYqBFVgMwa8AbTI5e9RQUajaoyqDgHlGIWGGMk+cCAHJOws0GZ8SwbQLDXWRnHThRZoiPQSQHnadWAFwGsDwl12l5HDukZYZ8gPyUHOeGUgWqYUz9K4zmRtSxA4LL2MgaMJ1DbnZUowo52WZJxohYc14EgNrn92O26Hi9isA99QSAuitI3bTpyVbkMY5ExW3PQBijp4aPI1WbaCytK0gOn86fTFBnJ2XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(36756003)(54906003)(5660300002)(186003)(8936002)(2616005)(478600001)(86362001)(6666004)(16526019)(31696002)(110136005)(66946007)(316002)(4326008)(66476007)(31686004)(66556008)(8676002)(66574015)(83380400001)(52116002)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akI4eU51YXNmRFk4eEY4UmFveFVaTm1EMnNLVS9zM3NWbXpKMWxPZ1VJbU02?=
 =?utf-8?B?eW1vRGorVUZ3eFQ4U1psV0ROQVZnQUtZZTZpUnBUZXdMSTdKenhJVDdFMjFa?=
 =?utf-8?B?dkF6dHZCbW9rTnpKWjB4QzZxbUFjVFFhV01QL0RUaUtuSWVZTkpRamthZERI?=
 =?utf-8?B?RGgrQ1RCK2NTNHRLVnpNMnA3ZWJXcjl6RWdwN2s2TmhOeXV3Q0xuL3NTbHc4?=
 =?utf-8?B?OVhla0FaMXhtcXVlOGdqdUVQWklKd2E3S08vKzVPamx3NTNPRS9lTzJVTzhk?=
 =?utf-8?B?cCtRY0NQTzViK3FJY1NvMThVbXRxSjRSd1BBTzlYU3pXenYxcGk0MXJpNVB4?=
 =?utf-8?B?dk1FenVhS2MwR0Fnd1ZRZVlacWpCNjl1VVpzOVhzOE1nUC9WQi9ST3BpYURZ?=
 =?utf-8?B?MkdzN01Fak5PUHBpOGU3RzdrOTRCTmVzZGd1QnRDeGJNd3RRa0pIZUJtQ1VP?=
 =?utf-8?B?OWVwRE96aXhDektNREtOWHN5Z1h5TDNjNC9ZQzZwejg4WXNyUk9YOVQ2OHV3?=
 =?utf-8?B?VFc5NjFtb2hXejlQT3YxUXQ4cjNCSHc5WGhjSjdyOTdEeElDTjVyRkhEeERk?=
 =?utf-8?B?bzlETTh4ZnhLMFBwZGlOUDJIL0IvL1JYMzg3ZWx0SGNPaGhwMjZpUjJzcGNw?=
 =?utf-8?B?WHhRRFZpVXlkcGFVcWE1SFdiWnd5aTNSWWFuZnpySGdQKzZqREd2ME9hNzFT?=
 =?utf-8?B?U0lwSjdrS1ptZ0krdjlQRjAwYVJkdHZ6VjdaK3ZSQldRem14RWJwbnNVc0k4?=
 =?utf-8?B?OEZIUFMyT1Jza3AvSWpwVG1MdkVZbkZsSXY4WlorekxwWExHOFYxMzdnK1pz?=
 =?utf-8?B?cDJ0THRNUU9qdXFVa0laWGh4bmFFRUlZTlBCMFNBOVAxaks4SFNBN3dwQmQ1?=
 =?utf-8?B?dHZzWXJPbUZMYVV5TDlQSHBmWFRHMDdDZUVUalhIUU5tMlhVTWtpN0tsVjVY?=
 =?utf-8?B?QzJRaHVRemhQOTg1Y3dhR0dTQk80YlJMd3NEMGYyQWxhWmJjN290VElIMkRr?=
 =?utf-8?B?SUtKZFRrNTZlcTMybWFkNm5jTmx5TTAvakJNaEVGZlBHRDkyZFlFVUF5SzA4?=
 =?utf-8?B?UHkwSzdWbXhPRUFPNmpoaXVRb01BeTBzdm1LR1VMRjY0MEJ6N0pDb25Jamoz?=
 =?utf-8?B?a0hZUlpDQWpQYmZjVlNyc1BySUorNVJqUzEzNVBkUVBxeGJ0c1JQSEEwVFk1?=
 =?utf-8?B?bDZ3SHBsOEFWS2VhNU4wc3MzRGF4VTFqcHhkN1M4eHMxdjlDMDlISVlkQm1z?=
 =?utf-8?B?NDFWeEdwTjV1TmFDc1JDZkRWK1dQUVNLSjhLa1pQdlF1YnZYWFhKeXRwaUxR?=
 =?utf-8?B?aTJZandxYmo1a0drMm5jd2RISk51amp2SjdQNFBseFc4L2VMSUV2RkF1dHI2?=
 =?utf-8?B?T2NNcCtYbzZVbWx2REFSOHFmQ094dVIyaUpNWkxkVDB5V1VWTTVaMUxJRnJk?=
 =?utf-8?B?eWQwQnN0RzhUUEpPTTlvdklxY3hSQ2JEUExidGZLTmdWakhBVmN4N2ZobjBM?=
 =?utf-8?B?ZW9qOEVSbmh6RUZsSElPRzErejNnMjhuT3RmNnlwZndtL2tGNU9BOVExekps?=
 =?utf-8?B?dlRsS01ranZjdjZpbWVOZWhVc3IwSno1bi8vaVdHRWI4ZW1VYkZnVlg4MFZR?=
 =?utf-8?B?SklMZ2Z5VFZWRlM2WDdXMjlpT3lnejFENkFDZlA4Z1dHd0RaWnVEVjN3Vllw?=
 =?utf-8?B?MEdYREgwSGlabmFjSEFWaC9POVM0dS9pVlMxNEVvL2RzU2VTRmhzUzVJMVl5?=
 =?utf-8?B?QUgxTTRQdXZmVHo4b1p1NWxyc3ZKUHZTaVh6NTNtVTlVOE1iRkViT1hxS2ph?=
 =?utf-8?B?R3ZRbEIxSmoxUkxWZG1UOWtDbGxwY1ZDOTBxZXJmNS9idUxFWmM2eUI4b0kz?=
 =?utf-8?Q?qJ/lpnMZWwSOy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f643ca1c-307f-4a66-a7af-08d8cc2b2526
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 12:14:55.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRQoA3+6S55jpvZitHIQsLu6zmRZiCo/bjMnBNjhlTuTtaAEgnpqittC1LCYky1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For start and end?  The hardware has 48 bit address space and that won't 
fit into 32bits.

Only the fragment handling can't do more than 2GB at the same time.

Christian.

Am 08.02.21 um 12:05 schrieb Walter Harms:
> i am curious:
> what is the win to have a unsigned 64 bit integer in the first
> place ?
>
> re,
>   wh
> ________________________________________
> Von: Christian König <christian.koenig@amd.com>
> Gesendet: Montag, 8. Februar 2021 10:17:42
> An: Colin King; Alex Deucher; David Airlie; Daniel Vetter; Huang Rui; Junwei Zhang; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Betreff: Re: [PATCH] drm/amdgpu: fix potential integer overflow on shift of a int
>
> Am 08.02.21 um 00:07 schrieb Colin King:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The left shift of int 32 bit integer constant 1 is evaluated using 32
>> bit arithmetic and then assigned to an unsigned 64 bit integer. In the
>> case where *frag is 32 or more this can lead to an oveflow.  Avoid this
>> by shifting 1ULL.
> Well that can't happen. Take a look at the code in that function:
>
>>                  max_frag = 31;
> ...
>>          if (*frag >= max_frag) {
>>                  *frag = max_frag;
>>                  *frag_end = end & ~((1ULL << max_frag) - 1);
>>          } else {
>>                  *frag_end = start + (1 << *frag);
>>          }
> But I'm fine with applying the patch if it silences your warning.
>
> Regards,
> Christian.
>
>> Addresses-Coverity: ("Unintentional integer overflow")
>> Fixes: dfcd99f6273e ("drm/amdgpu: meld together VM fragment and huge page handling")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 9d19078246c8..53a925600510 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1412,7 +1412,7 @@ static void amdgpu_vm_fragment(struct amdgpu_vm_update_params *params,
>>                *frag = max_frag;
>>                *frag_end = end & ~((1ULL << max_frag) - 1);
>>        } else {
>> -             *frag_end = start + (1 << *frag);
>> +             *frag_end = start + (1ULL << *frag);
>>        }
>>    }
>>

