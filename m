Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D64447288
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 11:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhKGK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 05:28:45 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:27105
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232211AbhKGK2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 05:28:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr6/CBdaxHoLTYp4r0R9c0jLXTPm2ZnOrRyRh82GxhdWruIYZJcY7TD2wCMqZ+0GHm/dawww12zeCdcIxL5HAa3KH+ZVOo/6sVXEjyKeaTv7+HpqWndmjNdadEd+6UhUtkpoM3IJLwDTBrV2SljY2i9m2GFb3KEk59FP2OayKiBDZCAbLVjbXyGH/jJF7nJlStKT83dd4dSsT14v68/yL/Uxvo9jrKwK+7Peac+vYQFqh+Ob/pEy4JP+Gqs4puBPfa69Exry4wXXxz8DiaMBfhrpNuSW+eXg4CAQ3FGrLOLq0NXmLNWR2yflovoLC8DcREMrRlI+YWK/VIpFCoV2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vftBk0un3nyz+LMDRzxecfRHAaLWxRNUgMMsa7fLkd8=;
 b=FjHAzv6vd50oBlM4hpaaURYzWTcTlcIPtfryl3zUamxdSDhBxG+VpQJEAPRL71c3k0msdg1zBL0FuPaOIQfHyUr/Qxxw7F+FXv5xDu5ghUoZB6BjR8728rSM099U5LdAUvOkq2DxbBx+5W3bmlOnJdjXaisMuEniJcgbyeEAUrzqPurFxM5K0RqfWwTRiGlFY3xpSyrcu9Wo5QVAnGSdGxhZt3TDvuxUtZw2J7HlALriXYYkS4I6+gQxOFnjKTTEW/2ebo5T176tNnFqOr0IGSFDlgGHH67WJAVQed69GpEap+WddYQiYWNV5KxxDftEHwJgmuW/LjNmVa09OKwqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vftBk0un3nyz+LMDRzxecfRHAaLWxRNUgMMsa7fLkd8=;
 b=G5XU1PWDBZgC5KvcvjllSYsXBHbK1tUGlAQPBpQtrkYfa8IJ8cllzixseaeEAXgRAOG/3agSbnyle828MeE45jzgqH1yZcjGtJhzPpsYkCyofWwOVBH1ZMUG/8v5NLODaZ5dx2xmoVpWIIXHPJZcZAR+jHB3/3bESqeS6Hq9fSU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sun, 7 Nov
 2021 10:25:59 +0000
Received: from SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::906a:a3c6:9f9a:5fc6]) by SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::906a:a3c6:9f9a:5fc6%5]) with mapi id 15.20.4669.015; Sun, 7 Nov 2021
 10:25:59 +0000
Message-ID: <11a4cec1-8169-0891-b9c8-4d3a7b689d86@amd.com>
Date:   Sun, 7 Nov 2021 15:55:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20211029224929.379505-1-namhyung@kernel.org>
 <20211103072112.32312-1-ravi.bangoria@amd.com>
 <CAM9d7chQH+Br6NJhDdjjOdV7FsODS0_Rj+w-UsfzUud27iPNbQ@mail.gmail.com>
 <YYbWUetkc6keL/Xa@kernel.org>
Content-Language: en-US
In-Reply-To: <YYbWUetkc6keL/Xa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::22) To SN6PR12MB2654.namprd12.prod.outlook.com
 (2603:10b6:805:73::28)
MIME-Version: 1.0
Received: from [10.252.93.92] (165.204.159.242) by PN3PR01CA0070.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:99::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Sun, 7 Nov 2021 10:25:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad470cce-a546-4db0-f5e4-08d9a1d8fd8e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28469EE31488364FF9118AF7E0909@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2pYoBYu38wyk9vZpoapbDZIDH5ekgAg253iaO+ue+JQXk00GmSxr3LqIeko63Kf9srzM7BvYRFdRaFR+10PpXplPIegjo9GKwQFqQxnmsW1VcX/K3Fabb1k8ptQb6RIU9jXp5IvI9wkSmqfpN41ywMpXoNuHIKGY6e994WtekKRqR/idF5gDaBe1Nvh6RwWU8OstCrikUFPhZImWGTQC2q6UR4HyH2/2XZ0RhQUMvGHcv3X3yCfn9Cu/Dbw3/gd2gA/wjgSr0R6lPmiPiutQj36XB+/SuL0/RfbfGnS8Gs9OPsfYpO5MmPXcb8HKcgt5GQVjI/oBmR/oB8+NBTG796ZZhIQRgE3oSDEggogvRI9N97WGNM4mJY4NX3RpYraMvL0uki/6nCeddJhKCNSnyA5Cuig5zqpNWOsSpZmQJ2JRZsh+0OLJp0j9aQLfbyOGL8xXMESIpXOccj8BNIoGeLA6hJ/UYInt0dDDRb9UyAMjIymq4YGJ4ZT8sYpqrgGf+vL3ogbusYtJ+2w98JUnST39lpbBILBBYmW5ah5UorykWR/tPmbU4x0c5gzXNBzGwhWcHqy2G7PdsbIuzYpVzJicGVcTKTLBaueqL423R4sOV174u3a8ECX+FulvwYspSkmMl/KgYv2DuGZmRXA8rKMlReAvp3rGQqBnpi13bSQ9iT2hDOlUlROwQJN0kVd6PI3dR/HPAMWm40E1SchGt/v8ZuWsifcU/XM/ITN4JU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2654.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(16576012)(2616005)(508600001)(8676002)(8936002)(6486002)(110136005)(316002)(31686004)(5660300002)(956004)(2906002)(6666004)(44832011)(38100700002)(186003)(86362001)(26005)(54906003)(66476007)(53546011)(83380400001)(36756003)(66556008)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZxd3Y3Nm9vN0I5eFJlRHlUOGk3MmtTbWsrT3B0MXRyN1d2ZnNxRStzb1pu?=
 =?utf-8?B?ZEd0Uk9oaCtPNms1UjBUR0ltVzJraEY0U0FBeFVOM0c2Uzg3Z3BRcDdPZ0kr?=
 =?utf-8?B?UkFvTFIxc1lkR0xGd3RzWWdEblpJVGd1VU1ybWQ1L0ZzTklObVVENy8zTC96?=
 =?utf-8?B?UklSdWtQSWptYUhiOXRsZjUyckQ2NTI2dTdaczduMzRUV2doZGN5N2IxZkRX?=
 =?utf-8?B?QmZNQjlxZWdjVUVvbUxMWDhUNVV3QVBha0RJT1FjemEyL2FPYXdoQU5MWDJ4?=
 =?utf-8?B?YjhLcTRlcnkvblFYdHJpU3ZVSVMwWGo3Y0hnRzBSV2l6RklUbCtIU3NRY0l0?=
 =?utf-8?B?RlFySVFMZ2t3T2QrU1N3c0FYUFc1eWRBWDZxOGovWDVUZTRIb1ZpOVlsd2Rq?=
 =?utf-8?B?QXFzTzh4dHVkRVkyWi80TWhacDdMc2JabmVuZmdnTkh5QzJnVkhjaTg1a2lK?=
 =?utf-8?B?clNmVlBvU0l3aER4eFBTUTFhYTl6MEJMWVB0ZTAwUlI1a3pUWWg1eUlCTnpM?=
 =?utf-8?B?blRHamFja2g2cDhlcUNPWTV2bFRhU3JocTFBMTErcU5BeDJURnFEcFQ4RFZG?=
 =?utf-8?B?SVBTQ3pqTmpuQllRdmFUTFgxNjVaTXpPL2hvRVpLVnFrb2JPamwvb2ZFc2RL?=
 =?utf-8?B?eVNLaHZPTzhRSlhxbG9Fdy9RUGJHOCtGSjBJQ3JKaE03ZlRMaG85UDd4ZWhV?=
 =?utf-8?B?cHVGVnE4TDVUYmw4L0VEcUlyVENHTWJEZ1lLcFUwTzdxTm5INEp1NURrT2s3?=
 =?utf-8?B?OFdKOFNSc0ZwMVB3SGFYYW53R3dCRzBIL3pRaUltZUltdHhyMmZlV1dJdXdJ?=
 =?utf-8?B?RkF2cFZMQm5DSStRU1ZDTDI3U3ZHOTd3WkR6c3JuNkJCdHlTQ05JNXZnY3Y4?=
 =?utf-8?B?SE9XeFIvcG16Yzk1T1Qxc0gzc3BGcm9VNk9SMWF1bjVrQ3BRb2lhTWQxNE1W?=
 =?utf-8?B?bkMzTndtbVhyVmxKTzVqMWFkNTZEYmJ4UHNkKzloelAvMkd1Yjd3Um5odEF4?=
 =?utf-8?B?dHpVQkxsYVN4L2luQW5qNTJRSkVGbW1JM3U0Q3grNFYwc3pOWmtaQVZjcnd1?=
 =?utf-8?B?VTRrZTBML1VCbU94OEFUTncrTVdmK1pqVnE0aHJNYlZtYkhLdG5HZU5rZjJW?=
 =?utf-8?B?MGRuSG1JUWNQL2J1aDBpUnBKQWlnNzRzYldTZC9oR3FxaTZnMnpKSUZKdGdu?=
 =?utf-8?B?cUoyVzE0QjFHaFhjWkVVcFVDeDdDQ0VRcTdmZWNRU2Vra3VJMmNIZFcvU0hk?=
 =?utf-8?B?ZW1KclB5MVNCVE8vVjRGcDZDWmhUQ2Z3T3AvdW8zdU5Ta09wemhkS1VwWm5T?=
 =?utf-8?B?ZEdZTmloZmNmUERjbU84K0g4alBhcWRLOFBiUFg2NVhtTCtPMkg0d1pKSnZM?=
 =?utf-8?B?VTJqZ3NxV1BWdUkyYk5vQWFwTW45R01qL0loeVRIK3R5TEI3UlV1WTVUNHp1?=
 =?utf-8?B?bzlKc0JpaCt1K2IzUTM3MUdUZ2I5eEJCZXZKbytzSW15OWlodDFIYjhLb2dB?=
 =?utf-8?B?SEJWVU91YUdlc2Y2WVZSU1J2QklOTitNL01ZbDZQZ3VyOUw5Vm5SelRHTmNV?=
 =?utf-8?B?UjhGSmtibmh2M04rdVpVeHhVYXRDQjZzenBHUXh2aGtsdVVqdUVza3ZWTEM2?=
 =?utf-8?B?elNtVFptM0ZwMFc4SVgzbzNsU2JYV2JYcGdId0ZVMWR2azI4ZjI1TTZ1M2ds?=
 =?utf-8?B?ai9YdkZ5Y2taOVd6WklPcG5RZng4blNZMHgzaEJaQ2dGSXhzZXZsZm8wWUJM?=
 =?utf-8?B?UFpsRDdWdlAzSmdFa2tkWFVtK2x3S2xDbUJFeGVwYk45ZURuTGtUUnZ2QkE5?=
 =?utf-8?B?MWtkdEdIUlVYbkZuTDVmTTJnZ3BhUDEvWVIybWc5YTVna09QR1VmZTd3b3ly?=
 =?utf-8?B?UWlZNUNDV2dsOXF4SE54REJOaFUxc1ZWV1V2OXJJYnFkTmFKeGxnSU5nSWxz?=
 =?utf-8?B?MDEzLzhJYWtpNzNRcFRKTXgvTlRVQTd5UVZHMUJ0QUZHbGdCUGJkTkVEaCtz?=
 =?utf-8?B?QTc4djZZZk14ajdncVVQd1JpZHVwT28raUhnM1hkR0RjK2Ewb081alQybmR0?=
 =?utf-8?B?V1pvMmxDcGtwSW1BNzRPYU8xL1pUOWFrQnloaFZ4VTlBN0E5alBGSnNNY01Z?=
 =?utf-8?B?WEJwOXB0bHI1NVZURHNDK2grQkZaVTZtVDFvZ0FSZFlqQ1lyMk9rQ0dCQ2JT?=
 =?utf-8?Q?fcpiuhewwzTiUKYyi8XnXqQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad470cce-a546-4db0-f5e4-08d9a1d8fd8e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2654.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2021 10:25:59.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzAKOhlDyunxurjBDDDd15P+M02nFt0jCIJTlIIZp49YCHjh5QEOGWzs6P3VFAnR0Wy8kJiwM367gsDRTkBlrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-Nov-21 12:54 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 05, 2021 at 11:00:29AM -0700, Namhyung Kim escreveu:
>> Hello,
>>
>> On Wed, Nov 3, 2021 at 12:22 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>
>>>> The current logic for the perf missing feature has a bug that it can
>>>> wrongly clear some modifiers like G or H.  Actually some PMUs don't
>>>> support any filtering or exclusion while others do.  But we check it
>>>> as a global feature.
>>>
>>> (Sorry to pitch in bit late)
>>>
>>> AMD has one more problem on a similar line. On AMD, non-precise and
>>> precise sampling are provided by core and IBS pmu respectively. Plus,
>>> core pmu has filtering capability but IBS does not. Perf by default
>>> sets precise_ip=3 and exclude_guest=1 and goes on decreasing precise_ip
>>> with exclude_guest set until perf_event_open() succeeds. This is
>>> causing perf to always fallback to core pmu (non-precise mode) even if
>>> it's perfectly feasible to do precise sampling. Do you guys think this
>>> problem should also be addressed while designing solution for Namhyung's
>>> patch or solve it seperately like below patch:
>>>
>>> ---><---
>>>
>>> From 48808299679199c39ff737a30a7f387669314fd7 Mon Sep 17 00:00:00 2001
>>> From: Ravi Bangoria <ravi.bangoria@amd.com>
>>> Date: Tue, 2 Nov 2021 11:01:12 +0530
>>> Subject: [PATCH] perf/amd/ibs: Don't set exclude_guest by default
>>>
>>> Perf tool sets exclude_guest by default while calling perf_event_open().
>>> Because IBS does not have filtering capability, it always gets rejected
>>> by IBS PMU driver and thus perf falls back to non-precise sampling. Fix
>>> it by not setting exclude_guest by default on AMD.
>>>
>>> Before:
>>>   $ sudo ./perf record -C 0 -vvv true |& grep precise
>>>     precise_ip                       3
>>>   decreasing precise_ip by one (2)
>>>     precise_ip                       2
>>>   decreasing precise_ip by one (1)
>>>     precise_ip                       1
>>>   decreasing precise_ip by one (0)
>>>
>>> After:
>>>   $ sudo ./perf record -C 0 -vvv true |& grep precise
>>>     precise_ip                       3
>>>   decreasing precise_ip by one (2)
>>>     precise_ip                       2
>>>
>>> Reported-by: Kim Phillips <kim.phillips@amd.com>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>
>> It'd be nice if it can cover explicit -e cycles:pp as well.  Anyway,
> 
> Ravi, please consider Namhyung's request, a patch on top as I'm adding
> this already.

For explicit :pp modifier, evsel->precise_max does not get set and thus perf
does not try with different attr->precise_ip values while exclude_guest set.
So no issue with explicit :pp:

  $ sudo ./perf record -C 0 -e cycles:pp -vvv |& grep "precise_ip\|exclude_guest"
    precise_ip                       2
    exclude_guest                    1
    precise_ip                       2
    exclude_guest                    1
  switching off exclude_guest, exclude_host
    precise_ip                       2
  ^C

Also, with :P modifier, evsel->precise_max gets set but exclude_guest does
not and thus :P also works fine:

  $ sudo ./perf record -C 0 -e cycles:P -vvv |& grep "precise_ip\|exclude_guest"
    precise_ip                       3
  decreasing precise_ip by one (2)
    precise_ip                       2
  ^C

Thanks,
Ravi
