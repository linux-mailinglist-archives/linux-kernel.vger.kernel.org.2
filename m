Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5B43D8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJ1BiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:38:23 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:39979
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229534AbhJ1BiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:38:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoqOuTx3Y8Fw0/b1LdfG/5wVqHYFGHnQNeBUPgT+n9czWs0wcImauiY3xLsnvfS5K0/71Y22/+VyFfvWhOm+A2VIJ3T9KtWM7gDg9cIU1RokCv4SWTLu4TaffIA9cfXPDOjsQCSdOK5WxKYGe/P2Zd6LO5fthvLY4W/MbcZMvjI722O7Cv9g0225NrPtCCvc9n4NPMoZFeX8TKDtKlqbr/tSMZK6yHCSToH/2cKZo+pKy7tNqvJJh+CFo3KgOY+jR20Jms44ooenDQLRq0RoEU4raoCT5fblWw/Oa0v6EslFbJitKqvQRi2HL2Du89YYwMZLYMKmopV6E5WOuVn4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9+CRJoGAS5aw7CIQG4gBxEpV9giODhqPR45bMJNhyk=;
 b=Rro9dQ24AMBzXdJZArP2B9tI94Iyeai1INutKtRI63ENeGUQYZElQcVuLGO2R/ncuNkJVKcLhFTR8x5m6S4Lytfw7CyNWsTlzAv1BMu5v0h/4g89j6H1aGMPG9vuwFI+qDNw//pVtBVrHZPmwuURYyNMS9dOZ61iYVXwB0rOK7llOcxGqAy5ZTIW/qoqh3HN41oR82uKBKMcZ8+1xTGHihZ+1r48fR/0IpTNSoPdNrPyF67B/idE8EaAJAP7VqYXpuOc5PVxPOMGDtEJc5IeUn1Jz1qgPupyB9Nld7549ktn444EHjlRY1gVGEQAVr54XjkQdDK5kkIhx189M0h7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9+CRJoGAS5aw7CIQG4gBxEpV9giODhqPR45bMJNhyk=;
 b=cXGanOn3x+dQute9LHjRJyi0V5tfIujhJqExeCMpckkpyTfXGVsuB8VlZstXoR454xkrwhXWjtohH4MF3NkorGRnpHE5WkMpKjqohdJ3F8FX7HfA77DXRKgL1ia5AXdLQ3fzfy6aWq27U0isQHsVJzIsY1c2TZ0UKZsbA8WkNMpNYV8KV/uLgdOmvN9Y6nsgYoy63Bsjy7uJb6gfnS2Ldl26bcGLxiCCdAO+8a+zejJRKdvBs4xpEN2e6zEyDde1aoszGcaQE4pPJ5kJ5cVVix+43jvbfCi4C8HAhYWwRuALNf3qB4vMN8PDA7+05ldLBWwF8yklA1chWEC5r8ngIw==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3464.namprd12.prod.outlook.com (2603:10b6:a03:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 01:35:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 01:35:46 +0000
Message-ID: <27b7177c-71be-9ff2-716e-caaa5035d451@nvidia.com>
Date:   Wed, 27 Oct 2021 18:35:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in
 set_page_recounted()
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com>
 <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
 <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
 <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
 <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
In-Reply-To: <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by BYAPR07CA0067.namprd07.prod.outlook.com (2603:10b6:a03:60::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 01:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e49d38ea-0ff1-4ee6-5632-08d999b3435f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3464:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3464A8A6BD53CAA3E34F9E76A8869@BYAPR12MB3464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOu2girlRJ7q8LM3y68zyBtT9SDEtPafiGP8IcX7pLm7kp9XAf+A3RWR3Ne0lnsyPCIte3vz0TjbxKfgtE4Kuy65QoL0pxsK2cnY6nQpQAEWhVG/3APoOQVsQX2llhiUQEm03xIJhVbKnL/PqIO3VUU/hJtPZwelhx5plQR6P8xwmLxkDtoJPQsP1ARVJ6PkFmqjGR2laxsGt1Zcq03Wqw7WhjzaTLlgx9Z28djs1XmCJQq/TLwmLAWXnTBwMdPB/c0TTRydH04CxD6LUILua2gEOJ6fvBdfJAwcAyZjxOhCau7XLrEP5DH/jiaaZBuYZrxRWJYsYhPLnRwqLAeKOpmxf95KWxN6pf+ugY9RPY5kMINKlSfOoAAIqCMzJOSp43OO8k3L6j55KYgUbi7Ce5esw6rxShzb4hJt05WRKLEpIfq/fSeCJhUZy2GLyjezr31ao7pSiWEdSQxuDD76z8rtPm2t2RGeMMHTbggLItWpHxv6ydSsgfn74t1FtrbhFagwkHjhaTHfb+n+J8TeRP9wKB7PsYqjbGEBuKKX8MRa2a4czsFDLogSfQRddlMstEZfwg0z8VdDol1SSngj3havqZkzpZ+qA8Rb35jWVyn/pql+VnQHKa/Y+pF+qstd3ptk//Rx1g6lueplf+CadvJWRKvGEjhjW46dV7w0vO7EvOh3JydyQUD0KdcRl7YG6jm010Vaj5nnbYB9iw37XHpxSeRCxsEzWFHN7MjjxBZMAzFS8esEE/UygUfuB3q3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(66476007)(66946007)(16576012)(83380400001)(316002)(8936002)(31686004)(54906003)(6916009)(186003)(86362001)(53546011)(508600001)(36756003)(2616005)(2906002)(26005)(38100700002)(4326008)(6486002)(5660300002)(7416002)(31696002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBCQno1ZXdseVViYU56eXp4Ymc4b0xqNWJSSVZXaXZVSTAvdWVOMEtablpt?=
 =?utf-8?B?WFd0bkQ1b1FUaGppQ005bVhETFR1V3F5dkFMZTNkbjBOdllzcTBaemo4RHp2?=
 =?utf-8?B?V3hRMVplM1M0T1hNMk9HRWxZL25uZ09WMnNuMURGRTJIUEdVZFdoeWsyd0Zj?=
 =?utf-8?B?WDBxcFVzQW9vSmpPekwyQlpiTVFBWnFyOTJ2bTFwRlFDTExCdjA3RXRJSU1z?=
 =?utf-8?B?TFdjWFpGczlzYnVSSk1nZklVMDczNGZlMEdEdUF6UEpzMlBKTDIycW9XcVNV?=
 =?utf-8?B?TjZzWGtHc2FZd0NTSG1lMFY3ajRUY1JtbWFMWTZyRWxaMDNhSUZ3cUhOa2hz?=
 =?utf-8?B?ZnV2RCsvdVJFZmhuQXhua2w2ZVZiTnpGdER0akNPWExCVlladlZ2bHA2cGlI?=
 =?utf-8?B?cUFRSVJjSkJOcTRYbjdTdjN0WStya20wUXB1K3R3SzJMSGp0ekZjckVyU1dm?=
 =?utf-8?B?akxOZEdWcGo2bXdRVWVmRlEvUHByMzNDRlBYL3ZHV3NqK1pqdHZDK0RnemtU?=
 =?utf-8?B?amQ2NCtKTlJHUlpHTTdrZGN6Qk9DQk1oTUUzT1p6ZGQxamh6c2oxbGw2Qk43?=
 =?utf-8?B?THdlS1BaUmR0MjdTUkVOUGFiY0tlVFJONzMvWDZ0RzBBR0ZKTTJFSTExdWZL?=
 =?utf-8?B?RExRUDNkT1hHaVFxT1RVUkJFN2wzNEcrQ3FFVUVhME9IZURENjJla1QvZEVr?=
 =?utf-8?B?K0lZTFNPWVZxRWFRSEVaSlFMUnFMS3VnOG8zV2dmMFVaWnhuVWhCNjRSdllL?=
 =?utf-8?B?YkJORzd4RVRyano5SFJkVTBKYTNsOUJqdXIwM3pjRVNJOEtzYjdsRjRKTjZv?=
 =?utf-8?B?UDhVMkNOVjBsb0NwaTJDSFFVZjhDOVZBT29vbEViWnllRzY2ajd0VkhFUGRj?=
 =?utf-8?B?S0pHbWU0clRlakgvRUJQdUtWblVPTXdBSHF1ZUpXbXIyc2NqOUhuSWZvRHB6?=
 =?utf-8?B?bkFqN3BEMnMxSzgrSUJ2a0cveVFWSWMzd3dpWFJIUzRNejgyTGJvN1Y2RjdR?=
 =?utf-8?B?YXhGdVN4d2JOTUp2YWY4NjhXVXpHaGR0V2VjY21oNU9ucThmcU1MYXUyTHpC?=
 =?utf-8?B?aXprMWFkS1R4L3ZhL0hpWlRLTWg0S1M0eCt5aWhxVDE1ZjhyU3VQOGIzNXlO?=
 =?utf-8?B?cXJxUjRlcVRtSkoyQ0piRVUrMHh0SjV4K2JWZnpMbHZqYVpJajhkZWpqdXAv?=
 =?utf-8?B?SEN2K2diaHk0TkpYMnJSZk1mZHUzMkVkdkVLaTM3UTZwcE1KS2JJRVI2OGdp?=
 =?utf-8?B?NVBId2Z2Q3VCU2FDTGdjaEdHbHF1dzJ3c3FWb2pHS1FDV0pOT216Q3dJVjNC?=
 =?utf-8?B?NkFPRXMwbm5ad2NQS0g3TFg0by9IRDU1VElsM1E3cjhuUnVSQnNJbGI0bHA4?=
 =?utf-8?B?ZWlwaE9UQmFBTzhUZXhwTzF6MTB0ODhMa2VCRitacGZucEp2cUlHZmMydUhQ?=
 =?utf-8?B?K09NYlkraHJGUG9GdTRPYXNYVWFsMFR2T1hQUThhTEpTQiswNXFsSm9kZ1ZU?=
 =?utf-8?B?VVY2RklLQmZ0MDJNK28rbGdXUVlPcFNRL1FxTWE4NVg0UGtEeGl4R0RuQXBx?=
 =?utf-8?B?RWQ1c21ZTEhwNTBNUjgxWmVsd0JkWjRpNzA1alZwQTZGeFRyb2ZGYzFQQzFG?=
 =?utf-8?B?M2RVZjVGMlQxbE03akttOGNuTUlWWmlpNTNiaGI1ZFBRNHVqTUpIemNNUzI5?=
 =?utf-8?B?dmtzVVlxQjM3N2FXSFRpbmtkTTd0d3c4R1ZwaElEeGltMkVQYUdRK3RSRlVp?=
 =?utf-8?B?ZzN5aTVmaVdxRWEyeFlFOW9Fd0V0bE9xMFhEb2RZdTFFb3A4TTBxY1VIZlIy?=
 =?utf-8?B?WVlnM3J3U045VGtVUTg2M3RaRkZTTjloR3RsQ2J1aE9ubDdQVmp4cnk5TkZm?=
 =?utf-8?B?Z0ozVjU4SzJEd3pHWElmaFUzYnlaTTBuanc2eDJISVJjbWd0K3VPV2tyNlRw?=
 =?utf-8?B?R0xEUzViK1JSanlxeGJVRlN1dkZaNzNsU1RoL2Z0SU1qYkttN2NTc2NYQnd5?=
 =?utf-8?B?SVg5cGFDdU1na2tqZHVWREFPWTNRWUFQbUFBajcvR0JieXNNS0lRbjlQeW5Z?=
 =?utf-8?B?TzZmMUkzaEdRTEM0eFR5eHlKTERzOU5sd0ZCTmhOb3d1Q0RqYXMxNG00NzdY?=
 =?utf-8?B?NmF1Z3IzWUhOWVZVOEl2cTRoMW1JcGxaVyswWWdpdENUY2F2cFc1cGlCbm1a?=
 =?utf-8?Q?N3Kz24k9zjSfQKzQJcGaad0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49d38ea-0ff1-4ee6-5632-08d999b3435f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 01:35:46.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p8rAsvQJWY4oDjDDqgdAq2oW5g4/iJy1HtnCkbvGhfG2Wc0giznwiGBNLIfAdUy4c5gPVT+3mC+qjVGbXZOGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3464
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 18:20, John Hubbard wrote:
>>> But it's still not good to have this function name doing something completely
>>> different than its name indicates.
>>
>> I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
>>
> 
> What? No, that's not where I was going at all. The function is already
> named set_page_refcounted(), and one of the problems I see is that your
> changes turn it into something that most certainly does not
> set_page_refounted(). Instead, this patch *increments* the refcount.
> That is not the same thing.
> 
> And then it uses a .config-sensitive assertion to "prevent" problems.
> And by that I mean, the wording throughout this series seems to equate
> VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
> however, in CONFIG_DEBUG_VM configurations, and provide no protection at
> all for normal (most distros) users. That's something that the wording,
> comments, and even design should be tweaked to account for.

...and to clarify a bit more, maybe this also helps:

These patches are attempting to improve debugging, and that is fine, as
far as debugging goes. However, a point that seems to be slightly
misunderstood is: incrementing a bad refcount value is not actually any
better than overwriting it, from a recovery point of view. Maybe (?)
it's better from a debugging point of view.

That's because the problem occurred before this code, and its debug-only
assertions, ran. Once here, the code cannot actually recover: there is
no automatic way to recover from a refcount that it 1, -1, 2, or 706,
when it was supposed to be zero. Incrementing it is, again, not really
necessarily better than setting: setting it might actually make the
broken system appear to run--and in some cases, even avoid symptoms.
Whereas incrementing doesn't cover anything up. The only thing you can
really does is just panic() or BUG(), really.

Don't get me wrong, I don't want bugs covered up. But the claim that
incrementing is somehow better deserves some actual thinking about it.

Overall, I'm inclined to *not* switch anything over to incrementing the
refcounts. Instead, go ahead and:

a) Add assertions up to a "reasonable" point (some others have pointed
out that you don't need quite all of the assertions you've added).

b) Remove set_page_count() calls where possible--maybe everywhere.

c) Fix any bugs found along the way.

d) ...but, leave the basic logic as-is: no changing over to
page_ref_inc_return().

Anyway, that's my take on it.

  thanks,
-- 
John Hubbard
NVIDIA
