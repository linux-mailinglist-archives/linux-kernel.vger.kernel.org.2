Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABE3B7D77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhF3GiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:38:15 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:31830 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229933AbhF3GiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:38:14 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U6ZdC8031786;
        Tue, 29 Jun 2021 23:35:39 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-0064b401.pphosted.com with ESMTP id 39gf0u0592-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 23:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLDzlLiV0QBWoKqV0WGtDTtzhRkW8Xa6b3yCmv8xRirPGd4fKfTdmB955xYpNlDvqBMU6sJjrucLX28NduBwywDLFvSI8IDWmGHUt05nhr4mQn7Wlagd0bNM1SVU6cJeYbkLvjE2tttcC4tFR6tfy7vF9mQbRcQxc4A2KZOJFURSlTejBjoLLd9ZCzZul5nK1fpT30AVf1dq5oDQjivWIBnUZ9yEu03WO0rN8dumRkujT+WoInUccaU/8JLd3oTyXBQdWNXT/luzzlX0W7cGYgMWft6VOmXmRf/O0j+kfGN6uGbpYpyN9e1//OsjpNvIa5pYHVE56x93MBHJvqet+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsGaAWHVElG0P1szsLpd0KiC3dd+oVTqtf4+HPqbU14=;
 b=F7koJplz7GZmkxdKywIFJxNfpZGtRsldSubvotjC6v+69Hij8tlIcwofOuiOosDAN+ZPn/Rr9LxzqWmvw0SMufyx2QKXzeAD/KtM+2gAbDiYkgAPQxKLubdpnPMhGm6zsfHGoGfSImT9SS23l/Uhe2SbApijIuHt5BpzlwCvPN8iOQbaY7biBMIhDdCN6SGapFG6D7beUxvaS+2v9xigIHI6QKXOqExOaTjVKwjkVvHK5TFr1GzDAgv0AFu1GPSf6NqIqvMsw8l21/QMIF9omc2UQ/TwO7L5orQ+/jB0ipQST0QuUvE/kJFoxZCDpsENq5dck1cUEx4b8Welr1wSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsGaAWHVElG0P1szsLpd0KiC3dd+oVTqtf4+HPqbU14=;
 b=I6DDEQRpoeI9+eo21/9bL3jbP60JZk1Py5gV3nV8BjGauIjnt3kwgQvIH0e3dl0Lm+ZoB6DmFshGVWxUR+4UbqftuxXln0y+q6HWYEhPJff7Drsq6b91xVf7URKfOv0IJIM8QDd9IUBIqhgDfeqIDXd/mfNurO6KkPw2Wz2gIKg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 06:20:47 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 06:20:47 +0000
Subject: Re: [PATCH] locking/mutex: fix the MUTEX_FLAG_HANDOFF bit is cleared
 unexpected
To:     Waiman Long <llong@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210628155155.11623-1-yanfei.xu@windriver.com>
 <e914d4fd-5afc-35f9-c068-7044ceda53dd@redhat.com>
 <02691c73-6ba8-241c-6ec8-486d9d549c23@windriver.com>
 <78f45c3c-191b-bd14-3b38-522907d0e24f@redhat.com>
 <d48fdbae-4b79-9039-4577-d3aaa18d543d@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <8241576e-ac92-1a0b-b1ad-2372b61759ea@windriver.com>
Date:   Wed, 30 Jun 2021 14:20:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <d48fdbae-4b79-9039-4577-d3aaa18d543d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR02CA0032.namprd02.prod.outlook.com (2603:10b6:a02:ee::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Wed, 30 Jun 2021 06:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c5d238-6493-4ea7-260e-08d93b8f3311
X-MS-TrafficTypeDiagnostic: BYAPR11MB2632:
X-Microsoft-Antispam-PRVS: <BYAPR11MB26321E698E480E4FF4407048E4019@BYAPR11MB2632.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oz0AXKgJl9nXZEg2LZSPRJRCxh/dCyB6p2+Qky3Ak2KXv0VOPVh32yy+iDgRdTAaZiaHv/JQmCbvCdD1259BWbVVoYSQgyhcplzgfvfA/xPBmCQGe5ss2vRjOrLakBr4B8jYyPzmcf2GtUf+657nBcVOE93YS5Bxz5kzHxvhnzZJDJHu8iSer0NqRs7kx/HK+9bhiqNBTe+Cc4jHaMHnzXuHqKaBWeU2kgodQvN8R7zAi8qJ+H7rRest9iFZADFH3yre3h+gvoUhph0ynLqAZNiJTlt+gzAY9PRb/N3XhRc9AI2UehIBjH3oqX2wX0+dKH5/znh0MjKdhxlajLjq0Nc2OJKyTJJv5yo0FI5GuTR79YdmjnAm4OCnqBFaUdRC8Hokamo2sgr6cgADupH5IBMDXUEXUEoB9t0yzZ/oRoU5lsG0rrD0xkrGea5kawSsa8gOL2T0fCL3CGvwBfWl7ZaQxzmcq3UBg+6nBkHGH3ASGFn3TrpVG6fFndwUxxzl9wQi6PCLHRQkvfHTwXDQXRdgDbPe3hZEbFXu2ypYSz6p9pU3kWX19LIVq848lAuifvoNhKo2SK8dQSRCg7g7VjmlBcFML4fTKpHgq8cK1AzRRvuVZKBpH43Uvu+D6YWoPqtHWGpI2vZdVSZ3ZVbcXlh8vmiXKd09qIV2h2rn76vm4CdES8PBwtM/7BRm57fVflfzWszDq+MeBlItkUMD8U+2zItcnA+LFQt3eCa2bsf027ys/yumGJcda7qwUMzDnzWN0ScEmwWSUjnxGOxEhhwY/MossqrSQk1WkwOuBzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(346002)(366004)(396003)(376002)(4326008)(8936002)(31696002)(186003)(16526019)(6666004)(956004)(52116002)(31686004)(316002)(16576012)(2616005)(8676002)(86362001)(38350700002)(6706004)(26005)(83380400001)(478600001)(53546011)(6486002)(38100700002)(36756003)(66476007)(5660300002)(66556008)(66946007)(2906002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2F2d2RPeCtIdnZDZE5MY3pZYXJPWmFHRWMwM2dnbmdta2d4ZmoxYm5FaHdq?=
 =?utf-8?B?ZExPYlREMitnZzQwaGZlS2pmYkR1bzdIWW83R3UwQXF5elJ2QWUrbzJjUmFt?=
 =?utf-8?B?WDFjeFNsMjMxcHdpSG1BQ1EvREFLQm5EZ1ZSeSttdVAzaVdWYTRtUkZDRVlm?=
 =?utf-8?B?YjdxYjMzRzdOMnRLb1RxSGRoSFhlNFMrNk0yUEtYWjQ5WTV2dllGeUQ1ekt0?=
 =?utf-8?B?bmZyOHo3cFpPcVhmYklZUzVoQmwvYjNtNWJQOWpUSDVrRmt0RE1aOEVTOEdS?=
 =?utf-8?B?K3dXcFBmR1dmeGduQmR2SHJNTlVaTjVCamFtYXRkU1ZhUTUrM1ZrSkZTUlRY?=
 =?utf-8?B?Z2ZLQWt1RWc1ZlMzOGlCdTVPRWh4Zkg2TmRsRWRTY3VSL2V3N0VISmpGeDFs?=
 =?utf-8?B?ZGQwUTkyS3ZVQXEvUDMzSlQwam1jbW0zZkpITkx6dTBxOTNQSGhHTkVWeHlQ?=
 =?utf-8?B?UVFCSXE0UmNSb0RrZS9hNGlhTXlnOTNOaGsrZG01VTNaSi9NbFcyOFowS3FC?=
 =?utf-8?B?dUZCS3FaemZVQktITmZmRHgwNmszTUZ0bHcvRVBrcnh0Y1NPb295NkJ6K0NJ?=
 =?utf-8?B?OE5MdjF6LzAyVmJ1WnIzRTZ2WWIrTEJhNGU5TWk1ZGVSb0hjYWFvY1pZb2tD?=
 =?utf-8?B?Y0tHUDR3M202alZGNDlsS24yaVJUU0lvN3I2SVBZWkxBMW5FYkltYzBnVisz?=
 =?utf-8?B?WVpseUd5Mmc3OXArdWtvdGxNaVBVaFMxZ2FvZXNtRWhBQnFqRnoyTjBvdWw3?=
 =?utf-8?B?eEwwdnhsQklrT2lsUzA3VDBvckVmeUJLUFpBbmc0amF2VzN5amlhcDhkWEhY?=
 =?utf-8?B?d094RmwxNUh4RjhkcFh1U3FTMTkwSnFxeXRQbk0zSWVHcEFQc2duZm82OSs2?=
 =?utf-8?B?bmJWTkUwV2E4bDZQV0Q4K2oyRzZHRGt6SmpMWjhkOHZsWnVZaC84NTNWeHJ0?=
 =?utf-8?B?bzl3SVBPbThSeFRUZStvQ0htMHlPbkdJSWFseWQyUzJaR2U3bDBVNktTdUZI?=
 =?utf-8?B?ZWlsZUYvUytKL05wYncrLzRjOWRrd3N6Zkc4ZzJJNzd0ZDc2czMybThmK2xX?=
 =?utf-8?B?amh5cTFnVS9NNTFyc2ZqTExENXhHa2E5NWFaRjdGTXVPNGRBOThnTVJ4M05O?=
 =?utf-8?B?MldSUHRRM3Rpem40VmpoV1A5LzRJcXY1cCttOHZ5R3Z5bk8xOHlOL0VjTCtQ?=
 =?utf-8?B?SGJqK1dKU21aL3ZBekJuSUNmOUZnZXhSN3Qyb0NNeWt5R2hVSEZ6MGhGSFYz?=
 =?utf-8?B?UkNxamprUnUvUnNabUllU3NZRysyLzUrNE5VS2o3V2FRL1hld1UxYmN3Umhz?=
 =?utf-8?B?SWo3Z3ErVzF4eGovd3p1M1RGRnk3VEkyR2pnSW8vazFrUm9BNWc4RDBDa3Y2?=
 =?utf-8?B?Qyt4OWN6eDZzNDN1aXlYQjRCVFBQalF5VWRwSHNab0lKTFNPcWdrOU9FeG0z?=
 =?utf-8?B?TmlrTE0yTmhxcHZQekNqdnpPZGttRVM1STlQclZkNTZTc2pCK1J1ekk2NjRP?=
 =?utf-8?B?SEpWNHlVTE84NEpzd1VMazlpbnlFZ0lhcUlWUzNiaDQyUDB6ZFdBd3QwazhD?=
 =?utf-8?B?TWFSQzhpOHcyQnR4Ly9FSE9nQ3NUVEVnZE5HdTdoTzhsa1FBdnJ3dk5Cck5y?=
 =?utf-8?B?TEl1bU1xWk0xV1pUTVl1Q3lTd0xCc0M5SGlNM1dNYTVHVFI0dnRHczVsdnRp?=
 =?utf-8?B?ZzU4Zjc3a1RYMkNDY3NMZlpja3RlREFuY0hmZzZDM2lWamdCZTI4MEFRU25r?=
 =?utf-8?Q?BqvizwSKhgl6MAYCyx9Qlpmu4HrIv8BZRQW3hO2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c5d238-6493-4ea7-260e-08d93b8f3311
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 06:20:47.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2cpiZaVhy3MmE5SgfytjmqdWQK+iZYukeS4oEEXyk6k08dvNGcVhFBqp65xHQaiWawNmrWRJ9r3TI5NGMXEKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2632
X-Proofpoint-GUID: FzFb6zgHI7MhmTtDbx1v9ldyW3r3st95
X-Proofpoint-ORIG-GUID: FzFb6zgHI7MhmTtDbx1v9ldyW3r3st95
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_01:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/21 11:18 PM, Waiman Long wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 6/29/21 10:40 AM, Waiman Long wrote:
>> On 6/29/21 5:52 AM, Xu, Yanfei wrote:
>>>
>>>
>>> On 6/29/21 1:57 AM, Waiman Long wrote:
>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>
>>>> On 6/28/21 11:51 AM, Yanfei Xu wrote:
>>>>> When the mutex unlock path is excuted with WAITERS bit and without
>>>>> HANDOFF bit set, it will wake up the first task in wait_list. If
>>>>> there are some tasks not in wait_list are stealing lock, it is very
>>>>> likely successfully due to the task field of lock is NULL and flags
>>>>> field is non-NULL. Then the HANDOFF bit will be cleared. But if the
>>>>> HANDOFF bit was just set by the waked task in wait_list, this clearing
>>>>> is unexcepted.
>>>>
>>>> I think you mean "unexpected". Right? Anyway, all the setting and
>>>
>>> Right. It's my fault.
>>>
>>>> clearing of the HANDOFF bit are atomic. There shouldn't be any
>>>> unexpected clearing.
>>>>
>>>>> __mutex_lock_common __mutex_lock_common
>>>>>    __mutex_trylock schedule_preempt_disabled
>>>>>      /*steal lock successfully*/
>>>>> __mutex_set_flag(lock,MUTEX_FLAG_HANDOFF)
>>>>>      __mutex_trylock_or_owner
>>>>>        if (task==NULL)
>>>>>        flags &= ~MUTEX_FLAG_HANDOFF
>>>>>        atomic_long_cmpxchg_acquire
>>>>>                                          __mutex_trylock //failed
>>>>> mutex_optimistic_spin  //failed
>>>>> schedule_preempt_disabled  //sleep without HANDOFF bit
>>>>>
>>>>> So the HANDOFF bit should be set as late as possible, here we defer
>>>>> it util the task is going to be scheduled.
>>>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>>>> ---
>>>>>
>>>>> Hi maintainers,
>>>>>
>>>>> I am not very sure if I missed or misunderstanded something, please
>>>>> help
>>>>> to review. Many thanks!
>>>>>
>>>>>   kernel/locking/mutex.c | 8 ++++----
>>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>>>>> index 013e1b08a1bf..e57d920e96bf 100644
>>>>> --- a/kernel/locking/mutex.c
>>>>> +++ b/kernel/locking/mutex.c
>>>>> @@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock,
>>>>> long state, unsigned int subclass,
>>>>>               }
>>>>>
>>>>>               spin_unlock(&lock->wait_lock);
>>>>> +
>>>>> +             if (first)
>>>>> +                     __mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
>>>>>               schedule_preempt_disabled();
>>>>>
>>>>>               /*
>>>>>                * ww_mutex needs to always recheck its position
>>>>> since its waiter
>>>>>                * list is not FIFO ordered.
>>>>>                */
>>>>> -             if (ww_ctx || !first) {
>>>>> +             if (ww_ctx || !first)
>>>>>                       first = __mutex_waiter_is_first(lock, &waiter);
>>>>> -                     if (first)
>>>>> -                             __mutex_set_flag(lock,
>>>>> MUTEX_FLAG_HANDOFF);
>>>>> -             }
>>>>>
>>>>>               set_current_state(state);
>>>>>               /*
>>>>
>>>> In general, I don't mind setting the HANDOFF bit later, but
>>>> mutex_optimistic_spin() at the end of the loop should only be called
>>>> after the HANDOFF bit is set. So the logic isn't quite right yet.
>>>
>>> Thanks for your reply.
>>>
>>> Why the mutex_optimistic_spin should be called after the HANDOFF bit is
>>> set? I think the HANDOFF bit is only related to unlock path, and the
>>> mutex_optimistic_spin and __mutex_trylock don't actually use it. （Or I
>>> missed something? ）
>>
>> The purpose of doing spinning after the HANDOFF bit is set is to
>> eliminate the waiter wakeup latency, if possible. Before the HANDOFF
>> bit is set, the lock can be easily stolen and there is no point in
>> adding pressure to the lock cacheline.
>>
>>
>>>
>>> Maybe I described the issue not much clearly. Let me try again.
>>>
>>> The HANDOFF bit aims to avoid lock starvation. Lock starvation is
>>> possible because mutex_lock（） allows lock stealing, where a runing( or
>>> optimistic spinning) task beats the woken waiter to the acquire. So
>>> maintainer add HANDOFF bit, once the stealing happened, the top-waiter
>>> will must get the lock at the second wake up due to the HANDOFF bit.
>>>
>>> However, the fact is if the stealing happened, the HANDOFF will must be
>>> clear by the thief task. Hence the top-waiter still might starve at the
>>> second wake up.
>>>
>> I think you have some confusion here. If the HANDOFF bit is set before
>> the lock is stolen by an optimistic spinner, lock stealing can't
>> happen which is the point of having a HANDOFF bit. Also the clearing
>> of the HANDOFF bit isn't done by the task that steal the lock, it is
>> done by the current lock holder (i.e. the task that held the lock when
>> the HANDOFF bit was set) in the unlock path. It can be a lock stealer
>> that stole the lock before the HANDOFF bit is set. Of course, it will
>> be a bug if the current code doesn't actually do that.
> 
> Oh, you are right. The current code doesn't actually prevent lock
> stealer from actually stealing the lock in the special case that the
> lock is in the unlock state when the HANDOFF bit is set. In this case,

How about setting the HANDOFF bit before the top-waiter first give up
cpu and fall asleep. Then It must can get the lock after being woken up,
and there is no chance happen stealing lock.  And I sent a v2 with this.

> it is free for all and whoever gets the lock will also clear the the
> HANDOFF bit. The comment in __mutex_trylock_or_owner() about "We set the
> HANDOFF bit" isn't quite right.
> 
> One way to address this issue is to enforce the rule that non-first
> waiter can't steal the lock when the HANDOFF bit is set. That probably
> eliminates the need of a separate PICKUP bit.
> 
> Alternatively, we can let this state happens similar to what your patch
> proposes. However, we should clearly document in the code this special
> race condition.

Yes, the document is obsolete after commit e274795ea7b7 ("locking/mutex: 
Fix mutex handoff").

Thanks,
Yanfei

> 
> Cheers,
> Longman
> 
> 
