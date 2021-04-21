Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2542366E40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbhDUOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:32:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38398 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhDUOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:32:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LEP348078186;
        Wed, 21 Apr 2021 14:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sEu50YRiQKs5l/6L+aXeb1yCkP/+jQboBKA977TW2vc=;
 b=yWibfUKVW4rUlq0dyCAjOMOsDggcuVX12zvwVvqz5eqBJlyVK9PgX9GbKt7YZUUmJUOW
 QxqDKZX3HH1F4a4i7s0137sz/gnB30W1cCOsBhW78X5uaF4SI9IJaq+coMF/GUkgUlyn
 7uu/XbJQZJLp9aDkdfpjMVDTndF/nLNMLxDxNgZcAi0R/bh1Q6u38hM8lE3wQvwV72/4
 P0I7xF+2vTBbNeJ9uLMMPUMV8pWnFYUwohL5XbjQOQDWrG8+CE7uXvipJpa41C53odS8
 vTXvyRcmZyw5dsdA8MYrKfYGgey0KM0D5feqKCy7sgdMZtVGdT0X3n/qcVOiCmfGFHKl 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37yqmnjg9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 14:31:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LEV2qp014902;
        Wed, 21 Apr 2021 14:31:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by aserp3030.oracle.com with ESMTP id 38098rte5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 14:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv/wpquYgC+23pzqC4cTvRzL3VTEh6x8wxouuxfqSyRovTqf0jYJwNIAYWYu5Xd+QaWz5iIOL83+6WLSTb1qwRNg7BqdJE49kRZwjM0cNqkuTukelHm0X3BX5QAyUbDT+5Ho6LNWQeTCt2+QkbW0L12OMVfWDP50xq1oRj73AZch5jkezPoxKJU+0JCOKo3K9jqa1cinfupVN0usLztph3f6tXYgkunvJG55Sqr5J240Jx68pjaRm80FR5BHzLNEHoLuUAEdElX0wOlm8cmTpel+d+nt7nstsst487wLN7at2JP1Pu/EWxRESAIrfPsAp6SV0PyGqr4/ldetpVBO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEu50YRiQKs5l/6L+aXeb1yCkP/+jQboBKA977TW2vc=;
 b=QvU4Egzy+vf4E8EapmN1Hb1pmeJp14RQfAGftzIMiPeN8WVVGPTRU7kgbS8ignzWnCqx91nPVqDOZm7w/IxIL28KEGCVRN/6G3kzRPhpTIE4DbZyeQ71CSzKgQqP78bAbYQeVhLlWgrUXqZHs2GUzWK2jVL6Xz9iJZ5Ie4Me+PKeOjyZ65egSwB5ye3QL9o4zBQu8TfKg0GXkPUztM18LlGsKpyFzfTDlmQUUCVfZl1Yi0j89sDUByPUaU20GjadQ298wqD//WWCpKcMPblzDkOPyS2uE/b8i96vG9gwKa1UVcXkYAbSlH6F3ifA7nuS/gJRbbt7M3GHY6oY6Q1eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEu50YRiQKs5l/6L+aXeb1yCkP/+jQboBKA977TW2vc=;
 b=T93KaaNy0gvlWTzFduEJ4orOvzJJt5Y0MbBeS9P+CtozJuK11Z5034OfsmDRbSXCEx6LdEBmqLHVweFE7gfOMrMWSzO+YvqlWt4j1legY1J83dCt0Z6NACHMJvkBiVFAysYRU3K70S5F9Emiv+OEBeVM5eMIoKWSkUE1A1ElFqA=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR1001MB2318.namprd10.prod.outlook.com (2603:10b6:301:2f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 14:31:12 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:31:12 +0000
Subject: Re: [PATCH 4/9] sched: Default core-sched policy
To:     Peter Zijlstra <peterz@infradead.org>, joel@joelfernandes.org,
        joshdon@google.com, mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
References: <20210401131012.395311786@infradead.org>
 <20210401133917.291069972@infradead.org>
 <YIApkMU+2jZHUVD7@hirez.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <663c45ee-e946-961a-d850-fc75d11a357d@oracle.com>
Date:   Wed, 21 Apr 2021 10:31:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <YIApkMU+2jZHUVD7@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.242.218.156]
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (67.242.218.156) by BLAPR03CA0097.namprd03.prod.outlook.com (2603:10b6:208:32a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 14:31:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b38b9c3-7232-4bdd-2ecc-08d904d21cbb
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2318:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2318CD9E15C619FC3D491A7E9B479@MWHPR1001MB2318.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ms9UEwLvsp6/80nRXe8bjyNxYPgEc0pma5ULBSupbsnmcNULcAeOD9DPV6oldVx2vUeIqKaEfQ5zQeKWMfN3VRo3sXCsoFsnz8tfBo7WwtzRNfZWNq5oQrD+X3aYJ5eVeNQJX81ZuJUcfDMWHsId2Joobkwi0gjF/b9ibzuYERq2xcZEELIDu0+SNISaJg9ZA5/qliZJNsNd1OCwottSO1MtERky4fW6aW9o7+nn3Tr0iyOxdaUP3RJlvhJj75D5b/y3E1gluhT/+GIN7f5F/pw7cD0ISSCK8+2LY5KFPnQSP97Kro48+cTvOMvp6Q822aDgqHMmUn8bul0TSlecz+b0ffECOOQJc8ew0vhezOVW1RSk5vLpLqOBlZ0kH2QtIj4s3kx7mifffQ6bsqjQ3RAml/x47GyLo5SXtn/xEBdOWUx89Bf8kdVW65eD+moCm/e55rWMbdkUqZ8ncsU+ChtQ6+lSXVEJp7jcbiyW/VaU9YHP6Riv8bz6e6SoHmXfv/FZR1iaAv8LtmqyyKcf2Q6bKRX++jkmp0vO6tA58RuRxWYVCVJtgptQzdvwvOM4wPBtQwmUDwoPYC7xV88FKbkQVkTuoAB27TlT5fF//MTYnrVOqQpe3JWt+WP7TUDC1yZE3jn390FLOnp+WbtpcL6xbIqK6IsEENYdynjMlbg3npHpIXf9f+09y+f8XT/Ss9rINhvr6afKFq8/a/ddHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(66946007)(478600001)(31686004)(2906002)(6666004)(16526019)(36756003)(66476007)(83380400001)(44832011)(4326008)(31696002)(26005)(5660300002)(16576012)(186003)(2616005)(6486002)(86362001)(53546011)(38350700002)(38100700002)(8676002)(52116002)(956004)(316002)(8936002)(66556008)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RDdVZ3NHVzdyNkNJNzJ3aEpHc2FFNCtHM3lxcWx6VG8xRzRWT2xTa011bXFj?=
 =?utf-8?B?anE2NE5qaHRRUUZzdyszOWVJZnVLbUN4Tm12QVJoK0VoRHFmaFltSEZCeUdn?=
 =?utf-8?B?MDB0UlM2dVE1QVd2MWxGMWVIQkxGRnBSVHk4NTM2QXpocHZLbVF5eDZCNFV1?=
 =?utf-8?B?ZGxSL0Fyd3NNa1ovWFNveGRyT2R6bDFnejhyblk2SGZRN1kwdDhOVWFGL1dK?=
 =?utf-8?B?SUNIREt6SXZUdjlmeUpLd0hDZ0ZuK0JmQnhJUVdTWnZsMHJNZXhrc0NqbjNE?=
 =?utf-8?B?Y3hIcDZ1cDl0dmxPYlg2dmZkdUFTV3h1WWRZTzBNaEhjVy9yZHVGUDJ3R29M?=
 =?utf-8?B?d0RXdWdRMWQzeWVDaVVrT0ZtWUs3YXZ5ZVRVTXI2eW5jRW1zdENhRDFBQkwx?=
 =?utf-8?B?SVk3U2s4QjN5R2gwN0VqTmJPTm9sWERuRHdvSTBtR3BhNHpzcTNUaDVlMlk0?=
 =?utf-8?B?L3YzZzlUVDRsTUJsMVBCaU9DeklJaWVaSWNqd0Z6N0JwV251STdiRHJVMFhz?=
 =?utf-8?B?b0tzUFlDUndpQURzdEIzWUxUd0xRSTQ0N2NTdVEza1loYUhoTXNBbXdpV21M?=
 =?utf-8?B?OWU0VHNOd0JmWVVMcGw2eGNIYjFjKytZbjhJV0dmaHkwTHlHSmtMY3VDU1Vo?=
 =?utf-8?B?Q2dZUDBPa243VFY0YU5iaXFibThmRlBTd2RZZXdCZm9YeU5Hc3JyYXFMS1N2?=
 =?utf-8?B?YW5ZeFpKdXFZTjhRUlMzUzhvOUhkSnlHa2NoZmtFKzdvOGYzYlJXL1VtbDlm?=
 =?utf-8?B?TEVjLzBVZU9ySXVEUWxzRlZ1UjRnNGNHQnAwb3FsSmpLV0pYbkF5YlJFVWhs?=
 =?utf-8?B?VG9DMTBFUHhTcEZaNFVUSkhVMUs3N1I0N1hnalJPeXBqUmt1SkFhb040eU1p?=
 =?utf-8?B?cThoZ0JNbmdoK3VRT1hOYzl3ajRiNTVpQkFROTg4QXJPQ0xVRUVQWHBISmkx?=
 =?utf-8?B?WXFqRW54OG9vYW1ETTFKeWRQZUUxWmlCZUhKRjd3dlRlSkZkeitYbnJyNWMv?=
 =?utf-8?B?R2tlYTkvcEdUOEJYeHFtczZvM1IyZmZWL1E1MGFNS0NTS2Q2NFprY09JVHdG?=
 =?utf-8?B?cEoxQk5SLzlna2lkQzlHSFJBd1Bra2RBMWtIVG5taWoyQ3NQbDRVeWJXbXpo?=
 =?utf-8?B?STh1d3F4OUc2bzNLT2xpZDJBdUVReWl3V1NxaXluNnRHNkVUcmJUakoxOHg5?=
 =?utf-8?B?TVJ4RTVocHJvTlNIVlFCYXNrUGRIbGY0UTZzbmFYZ1pJUWE0RzZJSEdYQ3p3?=
 =?utf-8?B?RTlOMlF5OU50WDFIVnFSNVhyUUMwY2tIY1VhYWhQMlpqTFNxR3E3NHBJYVZX?=
 =?utf-8?B?YlpIUTJKbDE0dTAwN1FaZS9aVFB5dUxldEVGRk11NUcvYUlCQUloREtUZ0Vs?=
 =?utf-8?B?Rm5Jd3B0MmVnaWVMejNXQjN5dXB3NnlLdkVidUMvbzdTWVptQk9IT3ZMcGFF?=
 =?utf-8?B?bmJSQmdDQmhZWWV0M2VGMjhTTlVjWE9pdXEzUzNIcVBma05PT0M4ZndwdnJo?=
 =?utf-8?B?b2tLUnVKcXhJSHVCRGxtM1lGL1ZkcTJ6cDNGaUNqMHdtTWJ1L2NWaGZLUEx2?=
 =?utf-8?B?OEZ3MzNyWE8ySGU1S2dPV04xVmRVWnZ3WHdoOFBQYXBzNi9rRUh4blFrUCtw?=
 =?utf-8?B?WFFjRjVKUFBmTFNyQnJBYU1QNnF1MlcrM29oSDVWT09TczViQmtFc0c1dEor?=
 =?utf-8?B?dW1BUTlEY0JORHRPK0NQS0NsOFJ5K0lZTDlvdEJQMER5NzZQYmlUMDZtYjRN?=
 =?utf-8?Q?H8CD3aK1A+V2Yc1L96acPk9W0VGVqloWB0c0/7c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b38b9c3-7232-4bdd-2ecc-08d904d21cbb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:31:12.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p74koECmQNB6aQ54/Yn0GBU3C43j94dfNIQ+fhHmmIpQEsVKwatzSxQgn4/zjR2CJKBaGwuwOaJvk2F/CAmbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2318
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210113
X-Proofpoint-ORIG-GUID: npkOKL5EqC_NZH7kMjuP1L3H1leLyA24
X-Proofpoint-GUID: npkOKL5EqC_NZH7kMjuP1L3H1leLyA24
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 9:33 AM, Peter Zijlstra wrote:
> On Thu, Apr 01, 2021 at 03:10:16PM +0200, Peter Zijlstra wrote:
>> Implement default core scheduling policy.
>>
>>   - fork() / clone(): inherit cookie from parent
>>   - exec(): if cookie then new cookie
>>
>> Did that exec() thing want to change cookie on suid instead, just like
>> perf_event_exit_task() ?
> 
> Talk to me about that exec() thing; I still think it's weird. Did we
> just want to drop cookie on suid instead?
> 

The choices for fork and exec were for security. A forked process or thread gets a copy because the code is "trusted", 
but execed code is not by default (that was the policy choice) and so it gets a new cookie. Dropping the cookie on suid 
was not considered (an oversight on my part), but seems like a good idea, but I think, also orthogonal.

The biggest issue with a new cookie on exec is that makes it difficult to construct a large process tree of all the same 
cookies like the cgroup interface does. If we remove the cgroup interface, we either need to remove the "new cookie on 
exec" (inherit cookie from parent from fork) or provide a global/per-task policy for controlling that. Probably easiest 
to just drop it.

-chrish
