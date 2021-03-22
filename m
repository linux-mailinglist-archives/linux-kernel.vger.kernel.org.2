Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43F3344EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhCVSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:38:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCVSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:38:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MIP2De025745;
        Mon, 22 Mar 2021 18:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mu/QLNu3R4dI/0Ntpm89fRm50qo3AJ9/skzAhKgKcwU=;
 b=r/FMS5MuLiDFekyNcyMErS7zrxqeJvAkyHIq94rebl4DAV956Z0a2IxuNBmy7ieEmhwy
 g3q/R58ehyZ3flg06Z0Ypn+a+AYAv4o+XC3vPK2hTT+91QgeM+jAEUEBOHwYPsqfHNNs
 aCO7kC3NmacvPXbdj8Pf7bNKVJ1us95CcOQQc49XbWXeWejle8GKKX41nKDvl9sMVTAD
 zBmFB/iaOKyxscsPQcL/FWMip+Ocvh3sfCYbD7CxXXveFHTnIoDWqLaXp6fQ65g7kT5b
 sPwUBfAD7uTJ4t+mg7jV7jOhZsSEgEfCRq/eQFD8IORKI++h1WxkGKaNqVKhn9CYGe4C Cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr4fvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 18:35:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MIQL36048948;
        Mon, 22 Mar 2021 18:35:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 37dttqx9cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 18:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkAfvMAee1hmX1xJWzlnOiocjnQr9fGNVXm94mMCuOuWKb54S7Iwmat41MvIwsPgEBf5QitH2rDGMTO2E7DOJd6KpBv5teJfigNnVPwOOuAhA3cMpb1eLy/ruKIgviYgF1F5zmJcrLhtl44CBAjqJAyTTc4EE1sfdw5fHheTLH4LPtIV3U30OTKt9zlNeHkUBKO8GPkpRJChQw822DxMs11rXD+p+JAOKfvpmdoeeqsWxfrd3cn2D/4uBKkEbixbLSyExJHCarOablnNavl3zS0VVY6jV2nkl4yGeWUBNpIjQKTJZv7Dx8OanS0LtvBZIJHbI0YJvj6OvF4d00Bg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu/QLNu3R4dI/0Ntpm89fRm50qo3AJ9/skzAhKgKcwU=;
 b=b2ygd0k22g/tj5HIM2K7O5cKX1DmOvAARNhdfi/ycmvce9N8dbiARWyrzaukLKusLwfzi2bWjyusOf5SLjbWpRwaVHSO6kkiQpDN0LcaAViDZQ4ZlskHTU8d65NC493vNyoL7cN5eQnJyxnIIgu06DC4sdKcYqYXJLMy3HACTWF3OllvkCDMDkFr8LnaGdXHAiUZ++KTKXkg6eA4PetAeMFle0T8b1Rb1N5UeYqqVgn1HoGVCr4nJTqVm8rr0WZ+1OwZzmfbYEkw+sYnwmYlYiT2fz5h37Mfgj21YRUyNz18/yDM1cRan4MXvnR3mshDED28frhuXM+YUi6VDG2YlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu/QLNu3R4dI/0Ntpm89fRm50qo3AJ9/skzAhKgKcwU=;
 b=J97kDzzhKYNXaaNbVZIePzpaMd0+Awnu7ldC5HnX8ZHrNplg3RmzeKuwj0n22adMzRVJYSr4HObwscB8zl4iGPqnmmBWH6QtSlbgJH6WuHBYBOlSDuCeT7dAhuR1aa8HRZH0k+j5wbvdphDN2sTnjmzO+GXH+TYEDLMJqcoxR1Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:35:53 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:35:53 +0000
Subject: Re: [PATCH 2/6] sched: tagging interface for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-3-joel@joelfernandes.org>
 <20210320154632.GZ4746@worktop.programming.kicks-ass.net>
 <ff9c63f2-0953-03c1-9b1c-25cb90954dee@oracle.com>
 <YFjjECKVskE01076@hirez.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <b30102d3-b0c8-2335-92f5-7bb98f3799bc@oracle.com>
Date:   Mon, 22 Mar 2021 14:35:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <YFjjECKVskE01076@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:610:b0::20) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:35:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3dec13c-49b4-4f55-63de-08d8ed6152b2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB465857A5CC9E59A19F00D6769B659@CO1PR10MB4658.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOrMnFTjCZ/np5vSwbtISW7trA4hK+NsK1QxU77N9njnxxa1it7k9o7XTNxHf/hGimQuAHJADIKt22Rzz9iL7WpqB5L93m1GfLW1ryXIQPaOAOrFtGr+X3BANcrJc9ea8iALXv5pwFhO+koYJ872FSJVCFvpb4CwFoizXzw+KGQexs0UbvuTYpwVXa7M4NcrnZkpM7FqZT9+U9W1ktk0G+b8BZZPu2Z9bx20v/s4T5rl9tdXoVT65RSTyJ4j09qF4IAZ15UonNeixZpjda/znoE8b6QAWLyn6Tbu/u8quxzAgYy2izC2yq0TCNrqERQ48WusRVVYNsqc7qHhUlFpCFKLmQLiY72ZA1ytQ1iMWIH2uRta69qZ8pVbWHzawm8HR1ZekaureJc52V+YFw/7ZJW7/5bqEYqLJ0I/5uhMS1lsdQQb5149GvfuWTMALh+lQgEZQiAgDW34y/VMwDenf+D6y7SLvd2Syjyx6AgwMt1askSQOI0V1JOKR+kCdfbtLoHtov/xoY2Zh9T1AGeI1TCeLYWXcYoSWWQ8gztA6RUiMHmDqE8s6Ut2AeRp/CNcuNMoAC2DluEHa6lintaD5/0KxSwwl2UK2lLyUJrSr3/TNQtOhqz3fAhYlGE33xRZMVWbRv2+1XYV0HryYNpWFqLqm1QCxZD8r5flJN53s7GJ7nFV3l31zRzfri4m2FAiUsnqkpNGz9xjeZyrdD5shg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(83380400001)(44832011)(2906002)(6486002)(53546011)(4326008)(66476007)(478600001)(66556008)(2616005)(66946007)(31696002)(16576012)(316002)(86362001)(956004)(54906003)(26005)(186003)(16526019)(8676002)(5660300002)(6916009)(36756003)(52116002)(8936002)(7416002)(7406005)(38100700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmErSStMYjJsbFFCcm8vMnVtWjFZL3BiZ1BCQ2RpVUkyNjJ5OTlDdTg3cm8w?=
 =?utf-8?B?L25pY281Uk8ydWdBVEtScWRLQUVHVlJPWnZjNWx6ZHdCQkRBbVhqamtKdFRz?=
 =?utf-8?B?cXhRQi9DeW1BVDVwZ1lBUzdoL3ljUVIrTmxHL1dxRk43cVFUTHdETG84ZWMr?=
 =?utf-8?B?S0VHZWNHK2NxM1FQUFZ0c25JTWYvaS94Z2d1Nml0c0ExSU9XZXZpTzBrM3kw?=
 =?utf-8?B?RkovZ3Z2ckE1dmIweWNOZTVHdTE2NHcrMmtXa0hyQVRnR0EvdHdsTVlrRkdr?=
 =?utf-8?B?UzBzS0krelVYUDR3d0lnV0l2NmovNUJRelVjd3YyWnlBS2M0djlOUDNLbm9Y?=
 =?utf-8?B?azRLWkpTTWNYY25yM001R29tMzIrTWhDeHZHcGprSThXcTZYZ0lDWlNsZmtN?=
 =?utf-8?B?VXppbVovL3pXUzFtMUhYU3VtUzFvWUxQOW9IcUdHWlZxUnI5NWJOZVM2VUpl?=
 =?utf-8?B?TXF6eEsxVi9rSndOVUkrNERIMHFOdzRhRnNHV0pTOElDTFlTMDVvaWNEUlFX?=
 =?utf-8?B?MzRzZ2xmemtDcG1EVllNZ0U2cVNGbEFKT0xvN0NyZmZFVHlPNTh6ODFFVjlq?=
 =?utf-8?B?c0svWmx0RFBhUUJPRVk3UXo2MVR0UHBhbEJTSm5zUlpua215WW13bVJ2dmRr?=
 =?utf-8?B?NEpodFdVMElLUkY3bjNzMFdqY09LMk1nTWdHUm1vUzhWWkRFVFlxbnJpQThs?=
 =?utf-8?B?VVpWbDJFV0tXN3lPeEIza2FHNXMyRFlab0NEVlNOQnhYcDQrZXM1bXdhcjBw?=
 =?utf-8?B?TXIxVFlRSVB2UTd3S2tYSHAySU5hU0o5NHdOZkVFOGJEVjV2ck1JWXJYRnBI?=
 =?utf-8?B?Y3dlbFpoV0RTbXJNblhQREFUT1h4WjRra1lmNmVDek9GNXUyN2Y0WXlsZlBx?=
 =?utf-8?B?Tzg3NnpndURSczJkdXgvLytHSThTWmdjOSs3ejdSZDQxSWJwT1R6S2RuV050?=
 =?utf-8?B?bGh6MnV6bnFUbkhCaGp4RnVXa1pOT0gwNXVCK011UEVITmszSU1vbzdzOVdW?=
 =?utf-8?B?MVRkbldwcFYyL3NnTXg3K3ZGS3pWZGRISWxiVnVuTVhTT3p6WHduc0k4TFhH?=
 =?utf-8?B?a2RtNkhFVS96NHc2MEJGbXh0L0s2cWxhaE51a1JLeUZZNmZzUmFtNExWUTRm?=
 =?utf-8?B?Q3NGL2doanF0dmhpL3JXWVhFQWxySTJ5S3lGY2tEVG9mT3JSK2h1OFJrdko1?=
 =?utf-8?B?M29YWVhCOUdkT1hwYUNxUUpUQmpnclZBMGxsZzNVSHhSVi90YjJoaFZ5OHJa?=
 =?utf-8?B?V2M5bStXYk90RTk1VDQ4QWFyZXlKNXRUdTJYWHJIb2l4aHRuSXJZZ3FWKzJi?=
 =?utf-8?B?MkJwdlI3QXlGLzd3ZXNQM1Y4SHBQejU4OUJiRUw4Vk9lY0lLbWY5T1QrcTFu?=
 =?utf-8?B?OTJRZWtDbmg1a05odFJwT21FTEFMWmp3aFEzVWpZTWVCSFJySjVteU5DVUZZ?=
 =?utf-8?B?MXNPaEtTaFZWbnVnajNJdC9mR0ZqN2swMGQ2V1M4TzNhb2JoQlRGbDRkMDll?=
 =?utf-8?B?Q2w3Um00REc0aTVEVTJ6cG5vMTJicmNiTm42Q2tiOFB2MjBxU2RlWUpxcWhV?=
 =?utf-8?B?a3ZLaXd0RWlKTlNlVys4bWZSQUo0bUNSamxwMTZaY3lVelF4N0FHNGR6akpS?=
 =?utf-8?B?SU1NUUVVNmp6cEJ5MWFETi9ReHl0bXpEZVBhYUI2bWIwV2oyTFZWb1Y5UVZq?=
 =?utf-8?B?Z2pWSG9IWXZRdlVWZXhpckFEazFqb0wyMTdOa09UM1UydE91dGtmT0g0dzFl?=
 =?utf-8?Q?fAQzPCL+Zvlq0nnN7SIrH2919xwrRK/tHHmn/xA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dec13c-49b4-4f55-63de-08d8ed6152b2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:35:53.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54tAeyGN2wJzfxnghi/8OAks0+rzOrrJAFoJpVo7iqVgjZdHhIwzuS8HCzpdv6daRfShMg5HzY7FPTEdlnLFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=844 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/21 2:33 PM, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 01:57:48PM -0400, Chris Hyser wrote:
>> On 3/20/21 11:46 AM, Peter Zijlstra wrote:
>>> On Fri, Mar 19, 2021 at 04:32:49PM -0400, Joel Fernandes (Google) wrote:
>>>> From: Josh Don <joshdon@google.com>
>>>>
>>>> Adds per-task and per-cgroup interfaces for specifying which tasks can
>>>> co-execute on adjacent SMT hyperthreads via core scheduling.
>>>>
>>>> The per-task interface hooks are implemented here, but are not currently
>>>> used. The following patch adds a prctl interface which then takes
>>>> advantage of these.
>>>>
>>>> The cgroup interface can be used to toggle a unique cookie value for all
>>>> descendent tasks, preventing these tasks from sharing with any others.
>>>> See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
>>>> rundown.
>>>>
>>>> One important property of this interface is that neither the per-task
>>>> nor the per-cgroup setting overrides the other. For example, if two
>>>> tasks are in different cgroups, and one or both of the cgroups is tagged
>>>> using the per-cgroup interface, then these tasks cannot share, even if
>>>> they use the per-task interface to attempt to share with one another.
>>>>
>>>> The above is implemented by making the overall core scheduling cookie a
>>>> compound structure, containing both a task-level cookie and a
>>>> group-level cookie. Two tasks will only be allowed to share if all
>>>> fields of their respective cookies match.
>>>>
>>>> Core scheduler has extra overhead.  Enable it only for machines with
>>>> more than one SMT hardware thread.
>>>
>>> Oh man.. I'd soooo hoped to first see the simple task interface and then
>>> see the cgroup patch on top of that... I'll see if I can flip them
>>> myself (on monday).
>>
>> Peter, given we need to rebase this and we have some cleanup, we can go
>> ahead and flip the order if you have not yet done so yet.
> 
> I didn't get around to it yet :/ So yes, please! Also can you then split
> the selftest thingies?

Will do.

-chrish
