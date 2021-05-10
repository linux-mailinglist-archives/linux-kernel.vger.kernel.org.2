Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F319379949
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhEJVjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:39:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhEJVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:39:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14ALU2VM057074;
        Mon, 10 May 2021 21:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3nM7arm8YiRSjRVr8pCxto2X4xDNZ9LKK18OXZ7+n/U=;
 b=XUiMiKD03Fua9M3SX95mTEfoTymK3tvaKltML9haAXuVproo4VVWb915P1eEMQn3JtUd
 jnaPoeppuON6Bd7v9LwxiDb9CXKIUJjbV4jOBnSYUQ3BfzkaTD5oiIO7iQaxR/dMxeQ8
 PYmyT4lxt3E+E6EjKSNot5qXL++07Kdtyizi0ecmzEA1NKT+Bf6VS9peU5IBSp6vBmS8
 tRVSexsaV3oUunDF7KsLFrOyEQMeoEHqui8y+wUq5VuIFKBZFdVt+wC9InJ5O++4EfDS
 IqMZeAzqpjSwHdKxyOvukpljAr2DJEEgqHbHpBm9C6wh/RTy8LtWU3meBkSS2w7NnUED 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38e285c159-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 21:38:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14ALVY5c019993;
        Mon, 10 May 2021 21:38:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by userp3030.oracle.com with ESMTP id 38dfrw55qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 21:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq14YYwXOHpc2X6AX63Zt4NziZTYW/op8rKdurudH6gdhFFR8j3KX8rvuhJUZ0b4/6rFpAnfv6MvG4G7XM8pDX7v05SdqesVE/kLjBVnoYCIIQtVCAogT8rWT6finLG8m6lgVxBCo5AQJXYsQSMB/GWgV2xSgPPPNWhfikbOXokRouywk9s1TSsExKcrsB3oxYQdKXAmhtYWJldyIgD5Zfu5pU9KaT+tNzaYpvpUzBDLWAmT55kW9yUKeb8uFlEhKsSnqD6qitTbqRcXsP/Yu8+FqVhkMAjO7vTDV6A7B2c00vMhCxQ9uHnSR9ZQs0GC7ZLDH5PrIcbBmHl7pnbFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nM7arm8YiRSjRVr8pCxto2X4xDNZ9LKK18OXZ7+n/U=;
 b=dJsRJhhjylvuaIG/7fgdFIgINlqAwvHFXovw6tI6xYSeew54R7Ljn8meYR1YhjStMKbtgjUAo5QRJbHh1OHuCS4lXiNbNPMbVbaDDuwstnntdvena88dRmNkl1lTGoTvtTemK9ySQCZwV3s2q9hDmkawEPDIBMRA+AaFzNtjv4/B4oFfRp74vcEV276Ai/w/qAs1Xh8x+R1znLQ0uPTFiBO9OWteCpzhsLWiuCTDQhMNk8DCquJJ8C7GRfxXqF9Sv30Psiz8wVGlPvmnz1A2fQc0KPAg48guMi7U9Ic+YGQ0TdizV+yC7PmjHzmLao3XCVaYv3GbAbkMHDcYs661CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nM7arm8YiRSjRVr8pCxto2X4xDNZ9LKK18OXZ7+n/U=;
 b=hosEypIp5WDaBpFWW0wS0s8KG21My5WOuXW5PAYqUJpnYPjqjgIadxsyWTptH27MlNsdwQ/2TuSdq1uSXP9F4BwcCovn0S9gbBv71r412vySt+qABGdcg+4z/TV6C/FuZYcegbeP+4a5BY/mn/696yZObHhODbjuAHJiOInJhIE=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1374.namprd10.prod.outlook.com (2603:10b6:300:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 21:38:22 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::9db4:4706:8a20:f069]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::9db4:4706:8a20:f069%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 21:38:22 +0000
Subject: Re: [PATCH 17/19] sched: Inherit task cookie on fork()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.980003687@infradead.org>
 <CAEXW_YTHZF69YHD-r=ST97sagjnxEDy6492nDKaaJtkKMoQN9Q@mail.gmail.com>
 <3dbce4ff-44ed-73ca-2ea1-97b126dd664e@oracle.com>
 <CAEXW_YSX79vR9hdkjKcf08uZk85xhC8nOnesf8s6Cvp2kqKoFA@mail.gmail.com>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <2b4ae2b4-62e5-96be-ddae-b261139842c1@oracle.com>
Date:   Mon, 10 May 2021 17:38:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CAEXW_YSX79vR9hdkjKcf08uZk85xhC8nOnesf8s6Cvp2kqKoFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.242.218.156]
X-ClientProxiedBy: CH2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:610:4f::36) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (67.242.218.156) by CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 21:38:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4eabad-16a6-4b81-1faa-08d913fbef5d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1374:
X-Microsoft-Antispam-PRVS: <MWHPR10MB13741BE9F9D5736193E51B959B549@MWHPR10MB1374.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JLbPjTP/iGYOASzVUs+WpdFJheSq9RlbwZesy0FSXgye0zCiuAlWgqmceY+yYeIpNLeGwXwnYI4PH0F2DSPlpkHP1jG45OK0pJH87wvwxfSXsUwXXkyTDr+h+9FSw4rq/Lsogmq7UVpEAxoEIJkybIcgM0ckxGT5LEn435yhn70TgBCQBiyNgWOMy8EyZXhkuGmxwYCvj6IFQauenne6Jbyn8q5M15HM+pCRvJn2DugXq0ZKRpIcUJgHBw5BzK3FJQtjBTpn4+1O97oznwLXHdizgs2tFRk05/SqTwfxo19T5UJNjOM4e3qeuEzGS1bxO4357cHgPW1susY49HkDQ2FaWyV3Oml1A6kpMCNGncegC89Aya5aVlm7OMqc1onBPnqJU6AuqVHLCxaUVOfyAxf6UQ9GvH3YFmeeTsh9E4beflVTuTHoomFsoMPgVR08sGoX3wvLGEGbrWAd9tX4eAI5UGZ2TvxYmZXuhG8dlFwk1p/7Hgkt2FXLKwgWoawIa86uJq0lesr7zAy6y9szG/nH+CLpJeN4gwVUpJX3gJt9y7JcEDuKkOHMaveLau/f4ew4vd5A311sCxktpn0csK1c/OH3Axbi9nQiPze7xKo/Yd5PwesOwjeBlmGl7YEnJCicFv8fUp4VEIg3baS8dI51PAXK+pk4kK660PRl9vhBuAYa37gRQsSE5MWRLqfgVjhlUCkKUcuPPgbzO3ZaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(38350700002)(16526019)(186003)(38100700002)(26005)(31696002)(53546011)(2906002)(8936002)(4326008)(316002)(66946007)(86362001)(66556008)(66476007)(5660300002)(8676002)(83380400001)(2616005)(6916009)(956004)(478600001)(54906003)(31686004)(6486002)(52116002)(44832011)(16576012)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1dOcHRFQ3dCL1Mvb0NrUmNtWTFGODZSa0U4bC9icmo4Zk5MbVNJM0cxZFUw?=
 =?utf-8?B?Z2FSNG0vZDJyN0x2bmswaHlOMXpPbjhnOFdJdG1QZ0hhNG81d04zUkpjWlBE?=
 =?utf-8?B?NzhHQ2d6Y1YvMVE3ekZBRGZnNmd5SmRTME5VSnFWRThwa2R1U0VObnRUbFlY?=
 =?utf-8?B?VG53anB5SlowQWN4MUg2Z2V0VUd3QTFFMVRTTnVOWEJUS0tLSzRrbmU2akV0?=
 =?utf-8?B?ZE54SjN4eXlPYXhXSUY3TDE3bE5hV3N5bWdCczQvTkc2RXJaNHh2c2JBeXBJ?=
 =?utf-8?B?c2FYOTNDanVXK0xJcEk2UllrcU9iY2RQN2xNSnR4K1M3M0ZXR3ZVVjdrYjd1?=
 =?utf-8?B?aXgzc0pwK2FneHBLZnR6RStzSFRodTBKR3pSeldjQytDVW5wV2hZbTRrR3Z5?=
 =?utf-8?B?RkFQc0FqZ3BOeDFoaHpsYTV2OWloY1lsS0Zzanp3UXdlcWd5K2VlNEprYjBa?=
 =?utf-8?B?UVcyalR1OEVJaDFoVG5ZWk9PU01Id005NkhSZjBCaFRiSEVEN1ZwRlBRd0lv?=
 =?utf-8?B?V1JNdGppWndSN2pZUWFXYXV4MDRkNjFEazZ4NVVtaHRpVkMwZysrbkZXL2RY?=
 =?utf-8?B?WEFmT0hZRzdQSG9DVTdIUXpkVm9aRC9TUld3MjUxZVA1ci80ODdTakhDTGhS?=
 =?utf-8?B?UXh2T3lSeWIweW5BQjlSUEJWRkRIQWl4QnJCUXkwTGJuTXM3ekQ0aEJ4c1BU?=
 =?utf-8?B?MExhcThRbFVNa3I3TTlOOGpnTllNSWFjRDJvSDJST2VyMGQ3b1pSVHVEbENw?=
 =?utf-8?B?OU4vdzJZQlpBNnhoeGl1Q1h5cW1qUnhUL3ByYkM2enJpdUhuU3FQcmI4ekpZ?=
 =?utf-8?B?QXQxNG5Ld0VmUTd1NkxlcjhyNlRvM0dOZ0lhSmxoSEpLZExzUFRXREFteDlJ?=
 =?utf-8?B?SDltcW8yZzFxZHR2ZW9ubGYxWEpvZDUzK1QvVm1XYlJDdnZTOTZnS3hVeGRx?=
 =?utf-8?B?T0dmVEpjSERSRVVjcVg1dlZ2SmZuczJsM1NHem1PRHVZeWt5SGVzUGRGbEEz?=
 =?utf-8?B?UC9UYVRuOEc1TTFTMHpxemFXMTdoaTA3T2lvckVWQlVPSlBVSGNja3R4bWZL?=
 =?utf-8?B?ajJWYU1lbm9SVjYyUDJqQ2dybEdKaEdNb0lyajdGNFJDQjFHRzdiY1Q3akIv?=
 =?utf-8?B?TGpBTE1aMzFHRCtLQU0rZEhUTUxQZUpPYkdUVVdoRm0rN1FVc3N4V1pvWlEx?=
 =?utf-8?B?V2NhM0x0TWp5ZVlHeE5WTnVST1h4cGJqUENORzIrbXN2TVRhb2JFdmg2WktZ?=
 =?utf-8?B?R0lFeGIwREk4RHdVSGkrbmc0aUVPeTRDeldkcmV5RGNWZU9WT1p1VnIxUExi?=
 =?utf-8?B?NFg3QWNjR3h2NzEyamdBQldxNWpQTndiOGEwZkw5Z1VFV2Eyc1Nhbk92TzFU?=
 =?utf-8?B?QnVpV1hjRDdFQUtjb0JZNENIVlovNXBvRTd1dlQ4YS94bFZQYjJjT1pFby9J?=
 =?utf-8?B?NXFaY1FRL3hFdjhNM0VQQVVvUHRqcG81bkkwWkEzTHVLSDNJTHdzNENveTd4?=
 =?utf-8?B?bGVsdXE3cFJRL1drWVdxeWRWWmd6bzU3NHZJSC91SHJXRjlNVWRBYUkwWC9D?=
 =?utf-8?B?UmNaM3JxZjV6SVQ2S1ZpaHloY21lNzBYQVI0c2lLb0FHMWlkZG5nOW83Qzhk?=
 =?utf-8?B?dVJEbUZ0Y3kxajJjOGFqd1lpbHV1Z245akRQZGVObHhyTTV4WmNTTmN3Slc5?=
 =?utf-8?B?a3p4QU4vamhWTkdEejZNc2o3SWhhQ3VDN3Rwc1Q0S1F6WngrMjBrY3I1WnI4?=
 =?utf-8?Q?Ihy1os2uEeKGgUDqZuULXnoXkXNsbj7lMq+xQ5k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4eabad-16a6-4b81-1faa-08d913fbef5d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 21:38:22.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOQwrB1LG+0O4n/vCWVNghQ0Mc9MKrVPbVLfmYvG1d/buTMcy8oUN2DqaW8Y4SgQLQKdzPTYe9+IJND4AT1mGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1374
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100147
X-Proofpoint-GUID: KeZLJFKB3f_lxL62mzHsQ0mMS8b7y2pr
X-Proofpoint-ORIG-GUID: KeZLJFKB3f_lxL62mzHsQ0mMS8b7y2pr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 4:47 PM, Joel Fernandes wrote:
> On Mon, May 10, 2021 at 12:23 PM Chris Hyser <chris.hyser@oracle.com> wrote:

>>>> +void sched_core_fork(struct task_struct *p)
>>>> +{
>>>> +       RB_CLEAR_NODE(&p->core_node);
>>>> +       p->core_cookie = sched_core_clone_cookie(current);
>>>
>>> Does this make sense also for !CLONE_THREAD forks?
>>
>> Yes. Given the absence of a cgroup interface, fork inheritance (clone the cookie) is the best way to create shared
>> cookie hierarchies. The security issue you mentioned was handled in my original code by setting a unique cookie on
>> 'exec', but Peter took that out for the reason mentioned above. It was part of the "lets get this in compromise" effort.
> 
> Thanks for sharing the history of it. I guess one can argue that this
> policy is better to be hardcoded in userspace since core-scheduling
> can be used for non-security usecases as well. Maybe one could simply
> call the prctl(2) from userspace if they so desire, before calling
> exec() ?

I think the defining use case is a container's init. If the cookie is set for it by the container creator and without 
any other user code knowing about core_sched, every descendant spawned will have the same cookie and be in the same 
core_sched group much like the cgroup interface had provided. If we create a unique cookie in the kernel either on fork 
or exec, we are secure, but we will now have 1000's of core sched groups.

CLEAR was also removed (temporarily, I hope) because a core_sched knowledgeable program in the example core_sched 
container group should not be able to remove itself from _all_ core sched groups. It can modify it's cookie, but that is 
no different than the normal case.

Both of these beg for a kernel policy, but that discussion was TBD.

-chrish
