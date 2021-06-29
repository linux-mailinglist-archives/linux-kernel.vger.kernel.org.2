Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99CA3B7053
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhF2JzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:55:12 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:61934 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232661AbhF2JzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:55:11 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T9g2O8007026;
        Tue, 29 Jun 2021 09:52:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-0064b401.pphosted.com with ESMTP id 39faenry3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 09:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzTbbLrgoQjYxi+w0+PD+SoJGMWNjoy4w4qt7hnyGg03Quo+S7xgWmvYRXEoiUmfA8uCuCXwjRVbh1OIiHMlf3MtHxx7MiMgpw/EGPCBgedX5FG8Sc96/IJZDamLbGfoPTO95iZI/qHkBwxr83jqbQLjT6J3K5jfy8vJ6mDHB3xMKOUdTX1PS38FTlMRGyGr54wtyG7LuLYvKhFH8bWTNKU6l4Ok2hp9LLoGznuh4Tg90DhAFITKP4SmyDGQqx/ZLD1OBr2rhW4vYN/WWGyROaa6V382MJ8zPBZiezVLVMNRQljCpzn+yMvWh5z9YBrrzmxQi/aA/WZzUTbFkEoU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8Psv5eQSu4etHyRAYrK1DLD0ZK8LXriGAJX1V+zw3s=;
 b=E0q2pdVaW/daXnccW0yngh0WZyCtjAvp2gOPixOqG/Dgxg2dgeq0W/SnKr/uUyUMXIENmevsSIiRkmci0b8ukveunk/EV3AvFv9kJDGJ9ZP8+sU9D+1+ydByopmBYQgOVyswG05Hho858sZ1eAaV1LBdyqI1RkdXAzE1dCcoDM5zKG9+GvwP9HK+qTHjRt8bCUoLJUKS8hNzIpcIah56lqtxEMaN6++q1Ma1gElldhfrURbHLzvzTUoMtaZ03OHv9GneUR6VAn6WtYz9gTrzb8R59klq18QOKxJjv/ZPvT8msDzrEZAGjNAvgEpQK/tYIykC4pn/OWh2CGjuQxMtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8Psv5eQSu4etHyRAYrK1DLD0ZK8LXriGAJX1V+zw3s=;
 b=NrIAdR9o/lpYpI2+9OAZqM47XeAy/aPw8UmISenC6pyvuggkvySwP5GZ8CxF3OPJKLjkL0Zt3cLPCf891InxcaqFFZqr4ipedwk7Mh/3Q6SrplN5gKdFHlp+6US0mvMnyXs1I6BA34j4Me8GIAI61qaMk6yRKY2lKfCVELDHet0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3255.namprd11.prod.outlook.com (2603:10b6:a03:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 09:52:31 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 09:52:30 +0000
Subject: Re: [PATCH] locking/mutex: fix the MUTEX_FLAG_HANDOFF bit is cleared
 unexpected
To:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210628155155.11623-1-yanfei.xu@windriver.com>
 <e914d4fd-5afc-35f9-c068-7044ceda53dd@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <02691c73-6ba8-241c-6ec8-486d9d549c23@windriver.com>
Date:   Tue, 29 Jun 2021 17:52:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e914d4fd-5afc-35f9-c068-7044ceda53dd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:a03:80::45) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR11CA0068.namprd11.prod.outlook.com (2603:10b6:a03:80::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 09:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d197dc-b5de-4eb7-c2fd-08d93ae39c65
X-MS-TrafficTypeDiagnostic: BYAPR11MB3255:
X-Microsoft-Antispam-PRVS: <BYAPR11MB32552086E68590BBF1DE5616E4029@BYAPR11MB3255.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k63pqASpEfcHitr27O/9oUGmadh4RdK82RLWZdmYSL8ce5aUX3/bIrkwPF9v63DEXGcQ2ZShAJ5iApbeS/KJ5XXmNvl0v9zFqVYKvce1pLOmWapWyzIun01m8x41xWm4XoYEvlIzFsn3xoNYhJzGeupTJ+NENAhDMwWDcmj6+Qq2Z9ztsDDgRnLqHn4pi1YioaW9+QlQgkRoZ50JxuRFHKARD0wW4QPO7bWiyx7GEn4S9g1kWngzKyryzvCWJMJFKP7c1IvuH2923qsuB7V6Z4oInoUMqfMdZLZNHT9m3xngEohj5m9Zd/G5POiZSv6HNdNMUs3ZKv3wFEzdc0X9BgTea0xpDSOHRrrcVescX+RfrlWgOm+s04bhvI68YBLVDWaIwMdn+CtR8rq8fGaLGCSsQ0dAPrSy7SG67Hk/5VYpVO5Z7Eo9iYjij3HuZTkXyxJfzcjWS60H0DjcV8ehA6ytVWIxbk3ttXoGv9fiVaVqv8xX/tTdE3YulpH6m+JPm59cXBRzDJbxePHwpBFeLFe7gxl0dHzT4yHS+Avt/B6YZzkdLe6zZSHWo8Js/wwZ7BS8u00jeVKUQHGxNPydK2RDm1jQTyJCvTCeGyomg0TeB50IWL89x2MhezrgtpbJGwcX/OYEX1Q+xjULKsvgMz5zBvysK1CFhW0sw1CY8UoJyRW2xoBLU1c6oTUBvnc10amObjjkk5hszTq3YOkW5eYMMIPUXCS2stZe4bI+Ov9gJaVS5ev7rn8N9kAm5tX7YEvjSE/89sXz83roaf+Q6f7Pi96A9Fkpq/+dpPQgPkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(186003)(83380400001)(6706004)(8676002)(16526019)(8936002)(6486002)(36756003)(38100700002)(38350700002)(26005)(2616005)(956004)(316002)(16576012)(31696002)(6666004)(5660300002)(86362001)(52116002)(53546011)(66556008)(66946007)(478600001)(31686004)(4326008)(2906002)(66476007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1B4d3A5cHZDeGZ0MTRJK0VPZXFYZnR1eU52dDZmMXE3Kzk3dDQ4MW9rK2tP?=
 =?utf-8?B?bXh1N29mSUFPc1lpbHFIQnVlV2FKYWZYVW1CNHd5Zy9NTWZnaTZ0VWV6NDlQ?=
 =?utf-8?B?NW1QNDFhQXBLVUVVUjA5S0Q4MEVLOHVId2UrRkl6MmhORTBrNGlIdDZuMDZE?=
 =?utf-8?B?MGxjU1RBdHBrbDd0N2czendDd09HN3NURjNFNWxQYVBsZDUwYmZBVU9JeWdo?=
 =?utf-8?B?R2pTT0Q5Q1kvR1lpMUJiK21XWVUzWCt2anZOVld1V1M4Q25PTThOWG9jMTBO?=
 =?utf-8?B?ZmFhbk1kQVZaZURHNkM2RlNmL2Q3dXRyUERQNWl3Qitobnp3UlNWaXlET0FP?=
 =?utf-8?B?QUVRb1BuSHhtQXJTbkdmbUFsRTkxOU1ncFBjSVozSURJWURzQ0FzWW5tTDh1?=
 =?utf-8?B?L1pTVkNMUUNTQjBRZzVLaXQ3d3N6aVF4TjhIcW9rVEhid1liRE1YdTNTTDNS?=
 =?utf-8?B?cHN6VlNxQXkyVWFyZGluWEdXMTVYWlRxVGZGUzJlQ1l2S1NRS0dQN2VBUFR3?=
 =?utf-8?B?L0tMbU1TSHZrcXhORk9pbmd0bi9OYlJTR1VtbWNlRzJvc012MVZXWGl6ZVda?=
 =?utf-8?B?UVFKM3lpa2FaM3JGWk40dTF5TklYcVNiOEllMCtETTF5RzA5V0dUUlZMOXc0?=
 =?utf-8?B?eS9RYUJSWVhmY1d1aTU2bmtUaUxaWUVjVUNlYUw5QXA2MnFFWVVCemdKTWh5?=
 =?utf-8?B?bHIzRW5Lb1dkaUxiN1YycUxrUnF4YkIrSks5a3pHeTFtckx6KzJwRnUxamQr?=
 =?utf-8?B?eFlmUVRaNEgyYWt0N0hGMzA5M2Z1VGVrZ2xPTUVzb21tTjhDY0xSaHNzc2sr?=
 =?utf-8?B?aUNqamx6ZktCK0FpbWgzU21TQVFnYWRWNSs2RE5memVIZmEvYnc1dG9wSmFm?=
 =?utf-8?B?S0dlWE1zYUVvT1l3ajJrYi8wUDcxYndyWUE2clQ3RW93cm8ySno4aytLZFY2?=
 =?utf-8?B?OXJCS3BhejJWSkhWS0ZMamZSSmVETDZxeXF5bzYyM0xRdGRUZDg0dFNvOGY2?=
 =?utf-8?B?U0ZOK0pCQ0Y4UkROOE00RC90aVBPdDJ4cjdHenNaR2RhTmZuNTdlWGw5cm1o?=
 =?utf-8?B?MjFzSlhnRm40OWJtN3RveFd2S0dtbkU3ZElqVUl6ZEtKRzhPT1RlNXdyVGlS?=
 =?utf-8?B?enNaeTJzZTdSQytqTmM3Q0RxYWkwYnRsaW5jd2hiMG4yWmZsL0Z3M3B2eDdK?=
 =?utf-8?B?bzNVaGxua3phM1Nqc2xLTWFCazZBbVk1Y0lGMlZZbUZpcHk1d3JDcnN5NTJ5?=
 =?utf-8?B?bi9IdkRNWlhxZUU0UERpVSt6U3NuTk9kYlNnMHg5M1R4c1YwdWZra2lUeVV2?=
 =?utf-8?B?aGdWQTNBdUwvQ2RrRHV0allNWnBOUE02OVRsampUWUVEY0duVEwvTm5jMkJW?=
 =?utf-8?B?em14RFdZQXcyaFB6NnFBdExvSDlGSXNTU01HWWxJYWhjeFRzNEVnS0VLd0Rq?=
 =?utf-8?B?TC9sM2E2UnB5bnNhUTFPQk9MWDV5MXlDNWNzU1VZNVkxaEJrNEhGSWc2N25Q?=
 =?utf-8?B?WVRVcFZ0UVgrSUJzYWNVVWo1VHp6bmhwWW5pcytYZklYTmhTdHlwdlpCOXVQ?=
 =?utf-8?B?TFQ0R295V0dwV0laVWdrRjJobGtOTkc4eXFiMGVxcTVHeU5yNWFLNkJGMlRt?=
 =?utf-8?B?UHNYcWFvbFZsQTR5ZDBTb0t1OEUyZHV5am42b0k0ZWdzUUlnL1ZUYk5jKzc3?=
 =?utf-8?B?c3A3VlhROXQzR1doNW1qTUV3Y0NtTHRkNmRYZzVZUXkxa1c5TExNcllYK3Ri?=
 =?utf-8?Q?6LDZppGEc8Zg6M8ECkbRFWSxzedCl817UwcX/Yy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d197dc-b5de-4eb7-c2fd-08d93ae39c65
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:52:30.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zz1Szz5BxTTWnn0zJBiefovDOODLjP6SKkOcgNRa2knKHbw6z12JO8ta1mKWu3KMm8+iOxQupQwNHUhzD25M7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3255
X-Proofpoint-GUID: S199ukQRAfciHser6aV7afzn2selZ2Mw
X-Proofpoint-ORIG-GUID: S199ukQRAfciHser6aV7afzn2selZ2Mw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_05:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/21 1:57 AM, Waiman Long wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 6/28/21 11:51 AM, Yanfei Xu wrote:
>> When the mutex unlock path is excuted with WAITERS bit and without
>> HANDOFF bit set, it will wake up the first task in wait_list. If
>> there are some tasks not in wait_list are stealing lock, it is very
>> likely successfully due to the task field of lock is NULL and flags
>> field is non-NULL. Then the HANDOFF bit will be cleared. But if the
>> HANDOFF bit was just set by the waked task in wait_list, this clearing
>> is unexcepted.
> 
> I think you mean "unexpected". Right? Anyway, all the setting and

Right. It's my fault.

> clearing of the HANDOFF bit are atomic. There shouldn't be any
> unexpected clearing.
> 
>> __mutex_lock_common                   __mutex_lock_common
>>    __mutex_trylock                       schedule_preempt_disabled
>>      /*steal lock successfully*/         
>> __mutex_set_flag(lock,MUTEX_FLAG_HANDOFF)
>>      __mutex_trylock_or_owner
>>        if (task==NULL)
>>        flags &= ~MUTEX_FLAG_HANDOFF
>>        atomic_long_cmpxchg_acquire
>>                                          __mutex_trylock  //failed
>>                                          mutex_optimistic_spin  //failed
>>                                          schedule_preempt_disabled  
>> //sleep without HANDOFF bit
>>
>> So the HANDOFF bit should be set as late as possible, here we defer
>> it util the task is going to be scheduled.
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>
>> Hi maintainers,
>>
>> I am not very sure if I missed or misunderstanded something, please help
>> to review. Many thanks!
>>
>>   kernel/locking/mutex.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index 013e1b08a1bf..e57d920e96bf 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, long 
>> state, unsigned int subclass,
>>               }
>>
>>               spin_unlock(&lock->wait_lock);
>> +
>> +             if (first)
>> +                     __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>>               schedule_preempt_disabled();
>>
>>               /*
>>                * ww_mutex needs to always recheck its position since 
>> its waiter
>>                * list is not FIFO ordered.
>>                */
>> -             if (ww_ctx || !first) {
>> +             if (ww_ctx || !first)
>>                       first = __mutex_waiter_is_first(lock, &waiter);
>> -                     if (first)
>> -                             __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>> -             }
>>
>>               set_current_state(state);
>>               /*
> 
> In general, I don't mind setting the HANDOFF bit later, but
> mutex_optimistic_spin() at the end of the loop should only be called
> after the HANDOFF bit is set. So the logic isn't quite right yet.

Thanks for your reply.

Why the mutex_optimistic_spin should be called after the HANDOFF bit is
set? I think the HANDOFF bit is only related to unlock path, and the
mutex_optimistic_spin and __mutex_trylock don't actually use it. （Or I
missed something? ）

Maybe I described the issue not much clearly. Let me try again.

The HANDOFF bit aims to avoid lock starvation. Lock starvation is
possible because mutex_lock（） allows lock stealing, where a runing( or
optimistic spinning) task beats the woken waiter to the acquire. So
maintainer add HANDOFF bit, once the stealing happened, the top-waiter
will must get the lock at the second wake up due to the HANDOFF bit.

However, the fact is if the stealing happened, the HANDOFF will must be
clear by the thief task. Hence the top-waiter still might starve at the
second wake up.

__mutex_trylock
   ->__mutex_trylock_or_owner
     ->flags &= ~MUTEX_FLAG_HANDOFF
     ->atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags)

The next unlock path will not see HANDOFF bit, and will not give the
lock to the top-waiter. The task starves.

May we could add a parameter to the __mutex_trylock to judge if the task
is the top-waiter. If yes, pickup the lock and clear MUTEX_FLAG_HANDOFF,
if not, do not clear MUTEX_FLAG_HANDOFF. Like this:

__mutex_trylock
   ->__mutex_trylock_or_owner
     ->if(first) flags &= ~MUTEX_FLAG_HANDOFF
     ->atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags)

But I think the cost of this is higher than my patch.


The other problem my patch solved is separate __mutex_set_flag（lock,
MUTEX_FLAG_HANDOFF） out of the if statement which is "if (ww_ctx ||
!first) ". Or once the HANDOFF is cleared by thief task, it will never
be set again.

if (ww_ctx || !first) {
     first = __mutex_waiter_is_first(lock, &waiter);
     if (first)
         __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
}

change to

if (ww_ctx || !first)
     first = __mutex_waiter_is_first(lock, &waiter);
if (first)
     __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);



Thanks,
Yanfei







> 
> Cheers,
> Longman
> 
