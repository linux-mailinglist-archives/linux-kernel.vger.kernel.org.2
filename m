Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CAD32D8D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhCDRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:45:56 -0500
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com ([40.107.93.75]:46432
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232304AbhCDRnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWEH04FZtanj5ankI7cJFnIAQaVvfOyLV4tZKCokR/gol4AY+UYAVmEU/bJaJpOw8H7Atf2Dt1orN4K5RUb+CmhDP6SxUgv8G4a6UMcHQrmi1eKjS1CvrMh99lSQCenl6u5DuuLpln7o+Zr+i6sgwcbckpUYHWq1uQ1orAAi4pDY2FCqk5oyWNJn3LyHmaIxHOA6uV4U1v9Xruk2kYdEO6i4nXK1ZcTf6FdMlIGY2fuWV0vPLTvWAumGnRi/UsJhiDNwIuXgEzDAXksx7WdDHJepqflTxeqQXqUTrtr3iMsMokYEKBBc9AkSQVsMiOoXfZymYl2gUJ5wo4oHmSyxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuCTdFruX/hNTlCbVVQsTE2rH1DSKwjSxvhj/FRSsBg=;
 b=aTL9ads85KK3rh6thCCj7whs6kvXTRoi18hPDDTQWO4aEBUknzxRNjOk641OLDUmqyLr7bduoUCTO3uVAjho9Ytj8rU7BhwfTCk+1Udg78Dt39rDS8RHWzGUJUp9adwLFoy8jhyBEWop5Py/4IdobAZ7G9RdP8IF+q0vi0+l7R7rIsvo/wfcixVal3JNDSxGGeib9sfa+jOmPWGTGS9EEDzvmoljR1UP1mhbYRWjqa/DwzqyjTx/usf9VFNYVlEZ9Gy+SEoUzYgPthJkQsnIbOD52+S25y5p4PQT06wPznbhof0YDuKX6ec6x/YaO4KcH7jqDpm8nYEISHl5h5wK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuCTdFruX/hNTlCbVVQsTE2rH1DSKwjSxvhj/FRSsBg=;
 b=jybahngfkdfRXniDCCsF29WN5y41MUAya422nxSKg87yMZfAALrwWlZKXfRfGdKEnLi4TrgNvy+zABPjwZaabMn+aLP2kSCZRIplTjfHawkCuYYsECwDf8V6zEPI89s4nS2x5LLAICz5Wu5K8BAtLcCz0dU6BOSr1WFtJtOrrcE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 4 Mar
 2021 17:42:27 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 17:42:27 +0000
Subject: Re: [patch 1/7] drm/ttm: Replace kmap_atomic() usage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
References: <20210303132023.077167457@linutronix.de>
 <20210303132711.340553449@linutronix.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <404173f2-62ff-7953-2ce1-20ac9fde2aed@amd.com>
Date:   Thu, 4 Mar 2021 18:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210303132711.340553449@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3d04:4b7c:635f:3a0]
X-ClientProxiedBy: AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3d04:4b7c:635f:3a0] (2a02:908:1252:fb60:3d04:4b7c:635f:3a0) by AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 17:42:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a810a88-a751-4f52-0bc2-08d8df34e03a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB435822A425E234BFB42E95AE83979@MN2PR12MB4358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x105muguRyANhtP/sRsG2fwn9kbm/JsWUi3A4GbUZpeDVCJIdB5biplzk9vWGowG9EBE3uV+ZWM47dEHmF4UgebcbRBTVrsL6b/Iho5Fg6wbWNuRRYfU6PvCRMl7CItKjALPNWTQzkXPILIxs8X81EI6gcuXw0iez3RUYdNz5dPdHVWZWKKnD8YqjKoJlnxhx7rf3isIkMdt/q5Yo+oAw6YbrsZtqAD7HzTuYG0+/s24572i0nGX6DW6t+OM2KBWyaF5TflcoKbSa0fyK3LkMoC7C0zSH/gao1U2mregeocqTlptd36vCHDZlbCsJbKMqVdx9BFmj89pMsr/9iGp9LYr8/nR6vVZGvrwuo3Mxaz11r02heHPf0UvWZXQ+GK7C4U0qpNGqyVDCy+ARSGKA0uy9VZoiNKC9Iy3pxKAz20ZX01W9lP/6lyeMWD7Z1mibTbNwETnk/66CMV1ngiUdewSXWzuhDbKzRqHG4s/FntlhM2/Ej5eaLjF4a5CUdp/ZTise55y/UsXXnIIOgw3iehKJDoq1MxGc0Rzx2WTygmc6MUTQ+YX6BMzo4LZ+z/5vUkLSPOnFeLenGFz8X5+OiNWPrYrdjcFNVgd+YeaHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(66946007)(7416002)(66476007)(66556008)(16526019)(8676002)(2616005)(186003)(8936002)(83380400001)(6486002)(5660300002)(478600001)(31686004)(316002)(31696002)(36756003)(52116002)(86362001)(54906003)(110136005)(4326008)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RXRqRXVKMGFTaEEwQjFqUjA3T3FTSmVBaUFFTWwweUZDK1lQaTVFcStBcTZm?=
 =?utf-8?B?R3FzcndFNTF3TUhLQTNuZFZiSVpleDVrSHlZR0l0Rko4Mmd3K2hIb0VWVDZU?=
 =?utf-8?B?N0pDd3RmaVNDdHpiZFY3b25nQ01uYXNmUldoTm5TY2tjd1loeXcyZUZTSWto?=
 =?utf-8?B?MnliUDIyL05JOWpMNDJIMjJ0U08yTG8xU3hERlg3elNhVVhqVFRvd1FZaWVh?=
 =?utf-8?B?SFMybjJ4WllPZHhVL3prMStBbnRCaFgxWFk5dFZuUytsRFUxQUpYUEoxemph?=
 =?utf-8?B?T21lYUJBZXVjRWtjMkFIeTZvbDhJUmUvckV4MFQra0srWVgvUkNvSVAyUjRL?=
 =?utf-8?B?S0VBTUJIQXdzR0tuRXh6SlExektyZXhIOTBLUFdyK2pYNTRGaC9mdVl1R250?=
 =?utf-8?B?RXQ4SDNUODV5QUE3MlJiOGRqbGlZYXA4RWtzZGZZY3laRGNDMzBCR0VsaVZm?=
 =?utf-8?B?VHlmWVpmZVZpSnI3QU9qeU9EZ1M2M2V2T1cwS2w4TlpLb2VBalhuOC80S1Z3?=
 =?utf-8?B?RytLdEpScWU1bzYxcTlvNDZua2hYU2MxMmZZSjNnOGx0Qnp3UDFtaVRtWEhm?=
 =?utf-8?B?UU4xZU9XSjBud1lJOUlOSnZlalFQTDdCbmlidVAzN3FnajNDS2crZHVCOS9k?=
 =?utf-8?B?STBGVTdtY3RobFFXZW5MeWdseEw2YWNFT3BFRDFGR1NrSHE4VjhDQWxFeTRt?=
 =?utf-8?B?T0tVcGZXWTJMQ2YvTENEZ3NYeTJEYkpZOWtkVmpVRS8xbEllbzd6THdxbDF5?=
 =?utf-8?B?cDB0SWpyMnFtZWEvSVpUUnBmMXROUDFmNy9ZaW01T3B3WG5rMkVQZi9HSG9l?=
 =?utf-8?B?b1RmM3h3Z0V3cmNCNWllNXJaSUtSZG9hd0ZSc0w2dEN5YnFTR3dlMkJwWUUw?=
 =?utf-8?B?LzQ4SzJvNU10VTVlWWtadzFnZVlqTHhoWXh2akJyWFRNekp5MmNpcWZsUG1r?=
 =?utf-8?B?dVJNU3JIQTNoeDd0by9GQjkwSWlPdEkrSlkyTnhxUWxKYXRDUloxdHlHaThM?=
 =?utf-8?B?K2VxMnlqQWhqWi9JNldEWDAzSFhQaVF4em1tazNOUWNDMVEzTklkTnhiVlJn?=
 =?utf-8?B?RDhOb1dCOHZQOU1ZRG9USHNGSnh4azZRVXkxN2VENHBYSXJMSnBMRUxLMCtK?=
 =?utf-8?B?cjU0ek5TUEQ3WXFGQkM0bEd6cDhxV2dJNkIzazFHcnVtdDArcWV4L2xVc0Ri?=
 =?utf-8?B?Zzl2UGcwSXFlYXN1N3hVZERpUDh6Ujd2bm9wR01ONGVqSFJrRkZLLzJ3TDNH?=
 =?utf-8?B?N0ZIZEVRUUFJN0VMSG5HRkw3a24yK05ocmw4ZHpnZTRxVEdlN0NycEVSTm1S?=
 =?utf-8?B?ZGUvOGtCcEdmVWNJN0JRVnBzTmlGY0hhdUlDSlRyWExpNXM5cDlBd3FnTW4y?=
 =?utf-8?B?SkhZdW5KMkFHbkRLTnlpYTF6SlVOM3pKaXdndytUSjhIZnAwN3JaRVl5ZkNv?=
 =?utf-8?B?WmVRZ0NsS2J0NDkzVlkyaDg4RkFyOWFBUWU2N0pXYm4wWHczc1RpN1ZYRzdw?=
 =?utf-8?B?Q1pyU2tURDlJaHFKdW5ySzBabWtsZVA2VEVQTVczeVowVGlJWGtpUmN0cFMv?=
 =?utf-8?B?eDRCWU81Mk4rWFJESmI4TFBnaml4OEVkaXl5cmZDa29ZOFRiY2w4M2lZdkFJ?=
 =?utf-8?B?UTZOcW1HK1VUOGhKekI1Uk1uVFdaUkNRam5vNDVlRkNFdFJrdnVQZFpzVGEx?=
 =?utf-8?B?b3hNZk51TE5lVy91MVdKekxLRWR5cHlKMjV1R1VkWnE4UEcvbitZMGxVOFl3?=
 =?utf-8?B?Y1hCd2tSS1h6WE53cnM5Vkp6V2pmWFEvWWROeFc4Ums1L0JYUmdIWTdnZ3JU?=
 =?utf-8?B?STZxUW84WExEYkRkcitRTTZ2RHlxMWFrcnhKcG5pMUsrWm81ek5MNFlvUENr?=
 =?utf-8?Q?sr1ev8N8jOCfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a810a88-a751-4f52-0bc2-08d8df34e03a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:42:27.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGR8CC9O4Cu+fJtQ1v/lKcc6hV/F1RvbCHsnkkTORnQFLHiRsiIsRi6RMf8wx7BZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 03.03.21 um 14:20 schrieb Thomas Gleixner:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> There is no reason to disable pagefaults and preemption as a side effect of
> kmap_atomic_prot().
>
> Use kmap_local_page_prot() instead and document the reasoning for the
> mapping usage with the given pgprot.
>
> Remove the NULL pointer check for the map. These functions return a valid
> address for valid pages and the return was bogus anyway as it would have
> left preemption and pagefaults disabled.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>   drivers/gpu/drm/ttm/ttm_bo_util.c |   20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -181,13 +181,15 @@ static int ttm_copy_io_ttm_page(struct t
>   		return -ENOMEM;
>   
>   	src = (void *)((unsigned long)src + (page << PAGE_SHIFT));
> -	dst = kmap_atomic_prot(d, prot);
> -	if (!dst)
> -		return -ENOMEM;
> +	/*
> +	 * Ensure that a highmem page is mapped with the correct
> +	 * pgprot. For non highmem the mapping is already there.
> +	 */

I find the comment a bit misleading. Maybe write:

/*
  * Locally map highmem pages with the correct pgprot.
  * Normal memory should already have the correct pgprot in the linear 
mapping.
  */

Apart from that looks good to me.

Regards,
Christian.

> +	dst = kmap_local_page_prot(d, prot);
>   
>   	memcpy_fromio(dst, src, PAGE_SIZE);
>   
> -	kunmap_atomic(dst);
> +	kunmap_local(dst);
>   
>   	return 0;
>   }
> @@ -203,13 +205,15 @@ static int ttm_copy_ttm_io_page(struct t
>   		return -ENOMEM;
>   
>   	dst = (void *)((unsigned long)dst + (page << PAGE_SHIFT));
> -	src = kmap_atomic_prot(s, prot);
> -	if (!src)
> -		return -ENOMEM;
> +	/*
> +	 * Ensure that a highmem page is mapped with the correct
> +	 * pgprot. For non highmem the mapping is already there.
> +	 */
> +	src = kmap_local_page_prot(s, prot);
>   
>   	memcpy_toio(dst, src, PAGE_SIZE);
>   
> -	kunmap_atomic(src);
> +	kunmap_local(src);
>   
>   	return 0;
>   }
>
>

