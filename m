Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F3D3B852D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhF3Oqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:46:32 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:34458 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235215AbhF3Oqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:46:31 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UEdEK7024547;
        Wed, 30 Jun 2021 14:43:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-0064b401.pphosted.com with ESMTP id 39ga5r8mps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 14:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS/hq2cxbSQ9kCuQ5Gdbb7CVkjhU4Q1/+Fq3ZamnDDcTrJFWp1rk2FP7ksMSpsXvPSbJcycD76XOsnHbLx2K5sJE4/ce4uXeoK48RnH6MSBXlBl3iWoIYKOLyhYhFG5MfTPSr6D09+AAK8TCdZoygzSrzx8N8/FraCKD8ySLPLECXWMJZbtCNiOqs6ah4HgZ1zMJuqgML3OCZvzSxRE7j4ILk85eXpYLoENwSIOkIZfjyk7doib+9s8sHaMlpyNCgMCcXWrLG7ZexpwZDb+/UHTYOeack8OGcvx3kd5kpj1YKBNSHJv6lYxVihxncQSIG5AA7bC5aTDJaEnvx9OjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do2Tkw40hN0k0TRHS6czT+DyI7wXffFsVWRv/MqSGxw=;
 b=DrkQ52wDbUSRvL9JMu3drltVYXXTmY803vNkOMgWbgjp3gj927OtIA40gjq2ZjykYoWEC0uzROPbFqUjSZwb2rUQIWj2kTyZKEqY60nnnNgZddWpdi1f8kkg63Q38pTXNfeOWnshhe9LBStO5gzOpl68Ma2kXYDLHBzREOqyBCSTNkjBN5cxqjVYjhyPmiSo8rClN2oUsDQ4ECCBDaMe/lNDwXUb2/4GDkH9ruj1o/8kp3r8OYg7czP7HzF1bCxKGN/mG24rK9SWp+SxhrbQyDEEfpSQcalgFDRyMY2h+0IHkuM7czptRQ45J3WsAZ/5ZZtd47j9/PhGqcJIR/Prwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do2Tkw40hN0k0TRHS6czT+DyI7wXffFsVWRv/MqSGxw=;
 b=VhgwAYHL5O+V8MQHFUqs4K8YcAto3UCGu4IsmgeGo2ldNUEJkplp6WavjrIG4M9YJndbXI3m4Sr2FBrQ98539LEj98qfZHMJwcHOYedRlmImna+HgoWefoMdFdTBs2yiSD7kXwUnajybaTML65qEPN6ZfBBZ8D1KeEVCeqCcBSs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.26; Wed, 30 Jun
 2021 14:43:44 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 14:43:43 +0000
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20210629201138.31507-1-longman@redhat.com>
 <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <dbd002b9-d266-0f69-1c55-eb4e5d4d6a57@windriver.com>
Date:   Wed, 30 Jun 2021 22:43:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:a03:117::31) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR08CA0054.namprd08.prod.outlook.com (2603:10b6:a03:117::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Wed, 30 Jun 2021 14:43:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb7666d0-293c-4524-55b9-08d93bd5756d
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4960:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4960FE45FC285797AAC21AB1E4019@SJ0PR11MB4960.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mP9Ccn/7UxfH81ewKTiOpt1+CDYO5V55t49zLMgIRZO5WmZ+8RliDOcS3rDP7CUWf/1CHWPzWQhIMsIe0/rbLkYYrHeXD0sA56D8VhgmECI/JoNVFHFfzpqHq73v1T0DhzSkzQjVAJmP/07JEFGJriECbv4HMrVn9Py9T0lS3/bvKj+nb2qHNPuDKtHah95/8XERyoHqSCRklH+WOiH00ZcSSZLnXoBXto77ZUlda3YqlOENcUPHu9oLF5w8ynPy5SqP/9SsWitHJtecNIY0mXjFmtXyQSaHGH98NMApj+b1l5q6HbBaQpG4W64Sz3gia1aOtRFJRIT7O+Th9Z6Q+9Jou/G0U8LWj6ItWf7PsyLkzOeNSmT5xtLEhd17k9tIYNS/1Fz1pjerFbhAT2i5SgRrmWy97BbMLFLL/0sBHQFON2WVEE88pshS8ARPyEmU9Y3MxR0S/KtHmQrIyI8ESrLBmOjWnt0DodaQW5JYsaQcxIFRnMjDtGyMtzXSV3wzbvZKIhJTxfMQR00S1OmGOobfEgpnvn5kMsxwNVR9At1LpSfTO3ZvjLG63WV4Kk/vzbfne0QJuEOIZCRTuWx5tWI5jNdtKYXiiZ71tgZVQyPuNL/fPRcbMB52nAEbpVCiKURCZ+qSV5oEEOHWXHq+b50kCgv1pHcD0eZErfbhOacbjHLKOCy68xVFRW4sNCZB0msyICz361mZFzeYHP2HyKmt7Ub4RpnJRwtJ+SHevfw6MgmycX+afXOP4bT5Lo9gOAOV7jFounie1fQ8wtXeIZm3L87utA3k1ghCiGgoboRFeOOWZDNKwNx5SHl05SCL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39850400004)(316002)(2906002)(83380400001)(8936002)(31696002)(186003)(26005)(2616005)(66946007)(6706004)(66556008)(66476007)(16526019)(478600001)(8676002)(86362001)(4326008)(5660300002)(16576012)(6486002)(38350700002)(38100700002)(52116002)(53546011)(6666004)(110136005)(54906003)(956004)(31686004)(36756003)(21314003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9weEc1OE9SMzFZMzZxYzhUakw5a3RnUCswL1pTcEJtRE9laGtsWWtXaWp6?=
 =?utf-8?B?eUhGd0ZNdkVWNlV5Y2k3a3daa1I4YWdENTgwMHd6RzNXTkJwWGdnNUtScFhK?=
 =?utf-8?B?NGZ6Y2doYUUxSW5PY1lVTzNOMVljUE13eFhqWWdNR0M4akVuYlJEbVgxejA0?=
 =?utf-8?B?OG5NNXVJMjlLc0RkUnJGWlA4WkRjWWFEYWQxY0N4T3ViTEg4cmpldTJPYVFR?=
 =?utf-8?B?dERZcG1zVFBsbkpxc0NWcGhZL2xPUnpBZFdFWDg5emgvZVlibktQVndVSDJG?=
 =?utf-8?B?U21aN3hJNFBTV1pVTkNZS3lvU3o1Y2YyK3lvbEQ4QlNXWVNmdjIxYlJxVWVw?=
 =?utf-8?B?dGNtbndyZzRUQ0xPYzVBSkVEYzZwMnRSSDlwSHVicEtCcmlNY1VqUFN4bXBm?=
 =?utf-8?B?b3dHUS82bklmU2U0ZCs2bXRuVklXSFh2bEtBY25wOVBQUUluNFNqUnZ2YXlC?=
 =?utf-8?B?NngwdGo1S2ZqalhBeTcvcGUwN2M5U2dPQjUvUlAxRmVjZVFCeVV4ak41blJ4?=
 =?utf-8?B?YWc1eGVwUHl5ZzJCZUEwQzlHakIveXVwZUlmQ0NIdjM5T0IxY3lHcExPVm0w?=
 =?utf-8?B?ZXF5MHpoVjN0ZXhjL3pMdHJJcThFM2RVQnJKRHVTRjlyc1ByOWMrRWxqcmZB?=
 =?utf-8?B?ckZUWG1pazlzbUNkYkUvbHVZUzlGbGo1eHNRYzVMaWlkeUkyL2J4N2dURy85?=
 =?utf-8?B?UzRaZXdqMlZjUkJxUTRFMEYyVjU5Sk9BSUovUVIwNU1KQkExTm8rU2ZyV1Vl?=
 =?utf-8?B?MDdZZ29TZjUraVBHWU8yUjFJRDFxSmtnSlRlUGxobHJleGU2QjFOUmpwL2p5?=
 =?utf-8?B?WHBlM2ZiMS9DbklIUmVrREpITFJOUkhYMW5RTlV4emhtWk9wT3ZYbmZPZ1dX?=
 =?utf-8?B?M3BGVDJZY1NjUUJtWFRTUkRGb2dMVi9ZSWk1SkZrZXZEb1VUbGpraWJYTkdV?=
 =?utf-8?B?Rk1RL3ROLzhqaFppeFQwV09CNVVSKzNYRURkSVIvVERnK0RPejRoZlR1TDhQ?=
 =?utf-8?B?V0J0amZUOFR6QkE3UVdmNlFhTmVPTFYxaTl0OEVHTHZSZGhoSXVrRldTL2Ju?=
 =?utf-8?B?dDEycTFFQkdOUDFHTjljYVhDWlZudk1OS3N3bU5qTVZ2dWI4c0ZVdDFSc3Nk?=
 =?utf-8?B?RE5jV0huaEk2WlNObWhMR2xkZVB2MEhzVlJqcHZmKzNOU3p3MDNlUXFRL0RB?=
 =?utf-8?B?cU4yZmJ1dU1ld2EydTFJY3A4NGo4NTJzdEVUYzQ5ZGsrRmRKVzVrdWxxcEdP?=
 =?utf-8?B?TWxKcW5zWm1IZFlNamp0RkIxd2gxSWFuMWxxYytlZlZyR3l0MUxBL0tNVHJE?=
 =?utf-8?B?YXNDaUUrSkRSd2FKcUwzUGVUM3ltd3Y5OGI4dGxPZXZaaGMxRW1QQ2NINGls?=
 =?utf-8?B?Rkd2N3RmTHhjSWhLTWxVVUVMOU9IQk9SN0RYNjBBM1ZBMEQrWjlsK25YOHZy?=
 =?utf-8?B?VmgyeTd2NGNaVTlKcUE2eEh4V21LWEErMXQ1ZWowOFd2eTIvYXpvaVZFRUdH?=
 =?utf-8?B?elFyTkFrRnBOR01tSVRmYUN5Ny9ScmJjd0ZyZnFwMmZTUGZJS2h1TzRCemVM?=
 =?utf-8?B?SzVmcCtQdXhzMFZWcVBsekFPUFV1eldVRmRWNUpEd21lSDFqd0RqaHJzdytv?=
 =?utf-8?B?K21PNFpjWVA3UmE5dnR3cXJSUllydXorOGN4MzhZcmcvUlpYaExMLzdqOGh5?=
 =?utf-8?B?TG9hblExbnowU1psdCtQY1lsTFBUbHNWa2lQQUNJYlZSelZ0b0IxOTRpTnVx?=
 =?utf-8?Q?wSHW6Rz7g4S/fh7Mwr3xGVNZIfPkEtZgqENMIkF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7666d0-293c-4524-55b9-08d93bd5756d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:43:43.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pfxXjXpO4DpEhdQ80bs5nmwqHgviF2s4yl914jfL2t5LZuC547tloq0cdxIGJq5d2eNIsv7Yky6IjFmvk2+2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-Proofpoint-ORIG-GUID: DplogRVfyEUJs611nQHlGFVjeKz2CJco
X-Proofpoint-GUID: DplogRVfyEUJs611nQHlGFVjeKz2CJco
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_06:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/21 6:21 PM, Peter Zijlstra wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Tue, Jun 29, 2021 at 04:11:38PM -0400, Waiman Long wrote:
> 
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index d2df5e68b503..472ab21b5b8e 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -118,9 +118,9 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
>>                }
>>
>>                /*
>> -              * We set the HANDOFF bit, we must make sure it doesn't live
>> -              * past the point where we acquire it. This would be possible
>> -              * if we (accidentally) set the bit on an unlocked mutex.
>> +              * Always clear the HANDOFF bit before acquiring the lock.
>> +              * Note that if the bit is accidentally set on an unlocked
>> +              * mutex, anyone can acquire it.
>>                 */
>>                flags &= ~MUTEX_FLAG_HANDOFF;
>>
>> @@ -180,6 +180,11 @@ static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
>>        atomic_long_or(flag, &lock->owner);
>>   }
>>
>> +static inline long __mutex_fetch_set_flag(struct mutex *lock, unsigned long flag)
>> +{
>> +     return atomic_long_fetch_or_relaxed(flag, &lock->owner);
>> +}
>> +
>>   static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
>>   {
> 
> Hurmph, so we already have a cmpxchg loop in trylock, might as well make
> that do exactly what we want without holes on.
> 
> How's something like the below? Boot tested, but please verify.
> 
> ---
>   kernel/locking/mutex.c | 89 ++++++++++++++++++++++++++------------------------
>   1 file changed, 46 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index d2df5e68b503..53f7fcadce85 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -91,44 +91,54 @@ static inline unsigned long __owner_flags(unsigned long owner)
>          return owner & MUTEX_FLAGS;
>   }
> 
> +#ifdef CONFIG_DEBUG_MUTEXES
> +#define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
> +#else
> +#define MUTEX_WARN_ON(cond)
> +#endif
> +
>   /*
>    * Trylock variant that returns the owning task on failure.
>    */
> -static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
> +static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock, bool handoff)
>   {
>          unsigned long owner, curr = (unsigned long)current;
> 
>          owner = atomic_long_read(&lock->owner);
>          for (;;) { /* must loop, can race against a flag */
> -               unsigned long old, flags = __owner_flags(owner);
> +               unsigned long flags = __owner_flags(owner);
>                  unsigned long task = owner & ~MUTEX_FLAGS;
> 
>                  if (task) {
> -                       if (likely(task != curr))
> -                               break;
> +                       if (flags & MUTEX_FLAG_PICKUP) {
> 
> -                       if (likely(!(flags & MUTEX_FLAG_PICKUP)))
> -                               break;
> +                               if (task != curr)
> +                                       break;
> +
> +                               flags &= ~MUTEX_FLAG_PICKUP;
> +

Hmm.. Should we also clear HANDOFF bit here? I don't find where it is 
cleared.

Regards,
Yanfei

> +                       } else if (handoff) {
> 
> -                       flags &= ~MUTEX_FLAG_PICKUP;
> +                               if (flags & MUTEX_FLAG_HANDOFF)
> +                                       break;
> +
> +                               flags |= MUTEX_FLAG_HANDOFF;
> +
> +                       } else {
> +
> +                               break;
> +                       }
>                  } else {
> -#ifdef CONFIG_DEBUG_MUTEXES
> -                       DEBUG_LOCKS_WARN_ON(flags & MUTEX_FLAG_PICKUP);
> -#endif
> +                       MUTEX_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
> +                       task = curr;
>                  }
> 
> -               /*
> -                * We set the HANDOFF bit, we must make sure it doesn't live
> -                * past the point where we acquire it. This would be possible
> -                * if we (accidentally) set the bit on an unlocked mutex.
> -                */
> -               flags &= ~MUTEX_FLAG_HANDOFF;
> +               if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, task | flags)) {
> +                       if (task == curr)
> +                               return NULL;
> 
> -               old = atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags);
> -               if (old == owner)
> -                       return NULL;
> -
> -               owner = old;
> +                       break;
> +               }
>          }
> 
>          return __owner_task(owner);
> @@ -139,7 +149,7 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
>    */
>   static inline bool __mutex_trylock(struct mutex *lock)
>   {
> -       return !__mutex_trylock_or_owner(lock);
> +       return !__mutex_trylock_or_owner(lock, false);
>   }
> 
>   #ifndef CONFIG_DEBUG_LOCK_ALLOC
> @@ -226,7 +236,7 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
>          unsigned long owner = atomic_long_read(&lock->owner);
> 
>          for (;;) {
> -               unsigned long old, new;
> +               unsigned long new;
> 
>   #ifdef CONFIG_DEBUG_MUTEXES
>                  DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
> @@ -238,11 +248,8 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
>                  if (task)
>                          new |= MUTEX_FLAG_PICKUP;
> 
> -               old = atomic_long_cmpxchg_release(&lock->owner, owner, new);
> -               if (old == owner)
> +               if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, new))
>                          break;
> -
> -               owner = old;
>          }
>   }
> 
> @@ -662,7 +669,7 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
>                  struct task_struct *owner;
> 
>                  /* Try to acquire the mutex... */
> -               owner = __mutex_trylock_or_owner(lock);
> +               owner = __mutex_trylock_or_owner(lock, false);
>                  if (!owner)
>                          break;
> 
> @@ -928,7 +935,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>                      struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
>   {
>          struct mutex_waiter waiter;
> -       bool first = false;
>          struct ww_mutex *ww;
>          int ret;
> 
> @@ -1007,6 +1013,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 
>          set_current_state(state);
>          for (;;) {
> +               bool first;
> +
>                  /*
>                   * Once we hold wait_lock, we're serialized against
>                   * mutex_unlock() handing the lock off to us, do a trylock
> @@ -1035,23 +1043,18 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>                  spin_unlock(&lock->wait_lock);
>                  schedule_preempt_disabled();
> 
> -               /*
> -                * ww_mutex needs to always recheck its position since its waiter
> -                * list is not FIFO ordered.
> -                */
> -               if (ww_ctx || !first) {
> -                       first = __mutex_waiter_is_first(lock, &waiter);
> -                       if (first)
> -                               __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
> -               }
> -
>                  set_current_state(state);
> +
> +               first = __mutex_waiter_is_first(lock, &waiter);
> +
>                  /*
> -                * Here we order against unlock; we must either see it change
> -                * state back to RUNNING and fall through the next schedule(),
> -                * or we must see its unlock and acquire.
> +                * We got woken up, see if we can acquire the mutex now. If
> +                * not, and we're the first waiter, make sure to mark the mutex
> +                * for HANDOFF to avoid starvation.
> +                *
> +                * XXX spin-wait vs sigpending
>                   */
> -               if (__mutex_trylock(lock) ||
> +               if (!__mutex_trylock_or_owner(lock, first) ||
>                      (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
>                          break;
> 
