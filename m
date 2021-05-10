Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D03793A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEJQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:24:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhEJQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:24:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGEelQ118153;
        Mon, 10 May 2021 16:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Siu24R5+O13DTUFCYn1TLihg4et91Dx73Mg8kW9PyXc=;
 b=GISl2xsYaV1o0TORA7m7LgERO70UnkAWHY8ngLfSyGu/1WATJWMyuODFlN7iyAVrFYYN
 i7AG2E8JHIDGWpD19Ngk91BnrnMCMwEeurrfqoyJPQQuM4ta891ZV4Vp+RRcA5ZrAbuq
 +LukNVJ09n5Fs8vYGrrNr8fZxtG6B+0PYSwMr/giTSkwONr0j3D49+fnmLlpmThqZQnS
 WXKh0h56lWtopERn/x4IoCRvlQt+gUBBoLLvm8UVvH2toHAWBlAkCVp9Kp3+Nr2//28F
 KKsfkyiaHVEXHIBR0Uw1+L6kjmnEeAKnwlWMt1k+nxc1eGejft0ggS7HvOHOVXyZ52Lu Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38dk9nbtev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:23:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGFwYS052100;
        Mon, 10 May 2021 16:23:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dsj026-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjh1R/S8dqQKW9slXUwg/ut11rxsqstG31H1AcZ8/11yhHE9jsW0w+zYYLZsiuL2wfpkksQCHwh2cuT9OWmDPWK6fnSJR701h0+cehRHqlqDqQk7sGrcebYqekwfluYXwFx6IK4QE42UUW6y3pCSYPsGAAcQX48n9qbhkv64J/ovsI2LmxxcqQ0z28jgZjeBu3CVUfuNmJSjx+VZedL9qVrhQXjP7d4ZgVS11W9dgB0ep/pvP0YBFFM2qUvz8i5uBpiTsIFup2h6bQnIu0ZTohUzwZcYC/uVySX7PYuHFMTb7ZLsxlVa5aXaWCsyF374+PCdQ9Djj62rwKRKCqwYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siu24R5+O13DTUFCYn1TLihg4et91Dx73Mg8kW9PyXc=;
 b=J/8bEVkPrJAfRkqwVOnlfyDY2wZNu8nHruuDteOQk4pEVgC+i5PEmN3YpxxAwzQxPg/+l2pTWCkUWWrOXjATh7K0j22kIKwi0llns2B5lnecwgjf6QNVNzBVd2vpfnlBaZidoAvKMenyK/H9WZZW/3uow0qliUe1Fls9EegNlnOBqbhO2twPQs6AHv0EaOBTJI/2JduvCaV8N3YLqknfG+AnwZqLdeXXsXIvtKESDMEoruX95Sz8w6mTNj49E9eCSKsfMZl1+wR3TITd+jJbHHeUvgwJDlp4hxPIgHUEknGUOe5m3RrxSUtRC/5yWwQAUD7io8ugsxfBcAWo+AvkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siu24R5+O13DTUFCYn1TLihg4et91Dx73Mg8kW9PyXc=;
 b=MnSuSzYy0OMtSC4q5yfKQjI+FHbTr1jLMoHwiKsHnuG+DBATyiSOukN4cbKi6ewtxY6EAQlxHHjS9WC9la+ylrFq7rYWUEZpCsrlKIewjG9yuqS00EltXVKgyWO8dECow29OpOLhajq76K9Wi2h72QZl4eHsWIUv+4A/MGUIcmQ=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:23:02 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::9db4:4706:8a20:f069]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::9db4:4706:8a20:f069%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:23:02 +0000
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
To:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.980003687@infradead.org>
 <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com>
Date:   Mon, 10 May 2021 12:22:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.242.218.156]
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (67.242.218.156) by BL1PR13CA0280.namprd13.prod.outlook.com (2603:10b6:208:2bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Mon, 10 May 2021 16:23:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ac67d5-5cf6-47e6-e885-08d913cfe21b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595A35F82184006456262F99B549@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOkdFiMfsJhdoAxfJra59KDwmhnLm70KJJTiYSqdx3Z4vhRudEEovazOUp+D+btAwq7HU+1uZhwmJmOO/QYuULcZSrTCN3KuTtP+oMmN09SIf4tm0nd4eQmkjDm8YwF3Z1+Tf168IPZyjrO1+O+x+RxrNNz3lEluHJPDIE0Hsxyv0sAkIfDabUTM0dMVJ2s98E9KJAPGSRVazxHcZj5jWJW9TM/s38Ze16+K7OXGEHP++OBurVeIST46Nu5R980EK1E+VqI7HuevLiTeRDQLsA7JhkmFt6dU8QLAyBJ0FeMyogQwh6VQ7T1v0ObmWXopUkDHhItVIoI+eoc77ao4f+jyqm7s3Xi1mgjePuVGoDL0KjdibFPJD4kn8u6zmbKA0kt6r5s3Ce8KbNc8dfyE9YDgATg6alGwkQJ6vxQujGGvsNXnZMM8N1y2eU2dAtV4Yo3BP2GIgambtDYBGOKh6HJ3E0lGSoR5VvyclBTo1Adld9Aspjt26+lqM6rkXo7AfREMXVM/dr0A2/PmtpfkgTB8hWDoCCI+dJv6igmbBrhbd3+W4dqNXGnMo6ZgTDCruJlD6lKMevh4YRS+32GaKL8fA7yt98jhaQBoPBNHhMJpjLvVv1Cov5As9TBVbreXO84xq97nhGA7P1vAxVaWfPlaTXzqFfzKPEj/IjySgS1brOV4Dv6qXlc1QmScatg3nZzr7H7EG2NMo1uxb/bpIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(86362001)(478600001)(2906002)(38350700002)(38100700002)(66556008)(66476007)(4326008)(53546011)(52116002)(66946007)(16526019)(186003)(110136005)(36756003)(8676002)(2616005)(956004)(6666004)(83380400001)(8936002)(54906003)(316002)(6486002)(31696002)(31686004)(5660300002)(44832011)(16576012)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NGV6czh0eitWMmluYnBURjQ0MGVNd0RYbmhMQ0dXbnV1aGVOc1hzN2JSU2VM?=
 =?utf-8?B?NW1tWjlsV1hCVWoxT3FlMmJ0Vm1RRk5BRzBFRk50QjY5aXNIV3lWKzJWeng5?=
 =?utf-8?B?WU0raWVmMkNXaXYyNmRyRzRlYW9tWnFCTEkrUEJKZ3p4SitRZllvMXZEMS9t?=
 =?utf-8?B?UVFvb0toUEhTNkZZbTFhclhOWFVnNEUyU2ZVY3FoZkZkK3FubVlucW9SamY5?=
 =?utf-8?B?eGpkb1dDY2VtdDhQRmdMNU03NHVUSktpL0RhWTVvQUtoOUxRbVRIWVRVMzY3?=
 =?utf-8?B?S2ZCZFpVQ1lBZkhtMkVBaEVld1BuVmUxK0M1ZU9QeVJvdk00cm5UZ2tiUUhw?=
 =?utf-8?B?KzBxa0ZyZm9wc2VpbHhNa3BnS25kRGZhUmJuS0ZxYjRFVlRvejI0Qm45NXV1?=
 =?utf-8?B?MVRRZ1NNeEoveENubEUyTDVvdkRTaXBNaXRCbFZoN3lRa1dlbGVyakZwZ3BZ?=
 =?utf-8?B?cU45T3REYTVicEtaMUtPUzV5TEtsTkNGVmFocytWYStBZkZUWFlsL0lnTXdS?=
 =?utf-8?B?L2NtR3ZvcXpjekJjamZXWXRmQkdmTHhENGVsNGNVS0ZzNDhtUCtsSGduWFpS?=
 =?utf-8?B?cjd5MDNMUU5sWmh3OGJndWdMbGFFUnRQZllDN1h4ZzFzL1RYd0M0WDRJTXAy?=
 =?utf-8?B?cFJXWGxGMlk4bUU5QS92TmthUEsxZHpmNWYyOUtiajVCWGt1c0JTZ1BySGo5?=
 =?utf-8?B?VnpUanZJZTQ1Z0ZubHVGLzkydEdKU2hkc2VmblJ3SWY5b09mT3RndjJjalV0?=
 =?utf-8?B?SkkvWW9IOHl6YlB0WTB1R3ZwY3BFMzFzOWhpa1BVV1NQalpiWTkraC9TVlpl?=
 =?utf-8?B?dFRWR0dzMzdYNFhtTXUwS3BpQzhFaU9jdm9BVlJSMCtza0xvZGVxSy9DTHEv?=
 =?utf-8?B?Rk40K0hZM3RQaXlFbEk0OHI2WW16N1hhMk5SYWlLOGhnWW1lYkRqSXFXaXZz?=
 =?utf-8?B?TUI0ODNNeFJROVpHOGJHaFg0Y2UxNHp2M21Ia0VpaEdCbk5MTDBoYXpHVjBO?=
 =?utf-8?B?R1NDMmNqbk5NWHMwbkRXTXR5TmtKTkFzUjRMZkFyWDFvakRnVDU1YjA3eXRx?=
 =?utf-8?B?V0w2bEE1MlVjT0EzNUlFalZyQ2c5NWkyckNKK29XOVRXMy9JYlJQQk5lYS9D?=
 =?utf-8?B?YmxiQkcvSC9vTUNHNHNtREhJVkhZS281dkhtdURNV2sxMDNhaFZ6cXBnNi9a?=
 =?utf-8?B?eTRRWnU4QUhUaFBRM1VuamRQOFp6UU9wVW11dGFsTWNIM2V5VnBjZEdRTDYv?=
 =?utf-8?B?c21xR29jSGJIdEFDSmtkbVBsZUpEK3pkQk51aVcyNVdMVzJMQlVtT0M2MGFB?=
 =?utf-8?B?TktoVFl3SGRxUSthMkYyUnF3V1g5NlBSZEpSTUZvVkE4eWVEaHc2S215azhx?=
 =?utf-8?B?Kzh5Zk9pcGR5cE1WRmY0SEZpZVpDaXZrejFjRStzRnV0eFdtU0xaM2x1b041?=
 =?utf-8?B?bnpJcktvbnB4MVJiK2s0NlV3WVlFRWVoT2Z3Z0JXUUZyaUdURHh2VHMwaGNZ?=
 =?utf-8?B?UjdXVGNLdlkwMmJyemVObzlUNlBaTGVSa1RHL2ZwOUdzUnF3SGFzOW4wY2Zz?=
 =?utf-8?B?TnBjZXVFYk1FckdDTjNXWmRTYUFoenhuWlZROVdnd0RIa0pXb1FrWmVJNkw3?=
 =?utf-8?B?b1N0TGp6OTQ1VG9USW5hWDNYZVY3VVBvSHNVK1RycVRObGNhMEhieHpzSG9T?=
 =?utf-8?B?NmNiYW41SGxnY0VXSi8wbEs0RUpRTzR0SWdCWEREUXJWak1MSFZ0Nk93ZHlx?=
 =?utf-8?Q?yykxNtTckriH3av4x7k/ip53iOa0P0r/Oeyc3yB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac67d5-5cf6-47e6-e885-08d913cfe21b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 16:23:02.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Wp4HOJzO/18NhQIux6SZC6CGsgcSp1MxHuFDeZqPHFmWp+xNqmmFBjK3b8ZsdYll+xHd0jP4M7NNAI89DcmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100112
X-Proofpoint-ORIG-GUID: 2l4JX-hNFWyeQ3nKp8MG1NHIKUxhHsFu
X-Proofpoint-GUID: 2l4JX-hNFWyeQ3nKp8MG1NHIKUxhHsFu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 12:06 PM, Joel Fernandes wrote:
> Hi Peter,
> 
> On Thu, Apr 22, 2021 at 8:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Note that sched_core_fork() is called from under tasklist_lock, and
>> not from sched_fork() earlier. This avoids a few races later.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>   include/linux/sched.h     |    2 ++
>>   kernel/fork.c             |    3 +++
>>   kernel/sched/core_sched.c |    6 ++++++
>>   3 files changed, 11 insertions(+)
>>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -2172,8 +2172,10 @@ const struct cpumask *sched_trace_rd_spa
>>
>>   #ifdef CONFIG_SCHED_CORE
>>   extern void sched_core_free(struct task_struct *tsk);
>> +extern void sched_core_fork(struct task_struct *p);
>>   #else
>>   static inline void sched_core_free(struct task_struct *tsk) { }
>> +static inline void sched_core_fork(struct task_struct *p) { }
>>   #endif
>>
>>   #endif
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2249,6 +2249,8 @@ static __latent_entropy struct task_stru
>>
>>          klp_copy_process(p);
>>
>> +       sched_core_fork(p);
>> +
>>          spin_lock(&current->sighand->siglock);
>>
>>          /*
>> @@ -2336,6 +2338,7 @@ static __latent_entropy struct task_stru
>>          return p;
>>
>>   bad_fork_cancel_cgroup:
>> +       sched_core_free(p);
>>          spin_unlock(&current->sighand->siglock);
>>          write_unlock_irq(&tasklist_lock);
>>          cgroup_cancel_fork(p, args);
>> --- a/kernel/sched/core_sched.c
>> +++ b/kernel/sched/core_sched.c
>> @@ -100,6 +100,12 @@ static unsigned long sched_core_clone_co
>>          return cookie;
>>   }
>>
>> +void sched_core_fork(struct task_struct *p)
>> +{
>> +       RB_CLEAR_NODE(&p->core_node);
>> +       p->core_cookie = sched_core_clone_cookie(current);
> 
> Does this make sense also for !CLONE_THREAD forks?

Yes. Given the absence of a cgroup interface, fork inheritance (clone the cookie) is the best way to create shared 
cookie hierarchies. The security issue you mentioned was handled in my original code by setting a unique cookie on 
'exec', but Peter took that out for the reason mentioned above. It was part of the "lets get this in compromise" effort.

-chrish
