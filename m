Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86118323ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhBXNuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 08:50:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55320 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhBXNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:06:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OCwiwX178356;
        Wed, 24 Feb 2021 13:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=g4YaTSdXkR8G19uhricGPulObX9SaB/wYDMPCp9YOoY=;
 b=dlPmgTylp80vhn7VQOm6Tj6aklmf7Z57AckdLPU3diWg/ZpgkGp9pcanFLogf6uz2zW+
 84xG4sOV22FQWLNXLwlI0L+ouDR2QrVTe1l8YB351BETcEv9KLQH0LmzrcOUyQhCA2f5
 3wfr7kq+Ok5YnGsDEeMvCdY5BEXaATmaZkdEEZBeeUOxmS7v0rABWm5DEVu1ZBS8FhME
 cjBKErjswcultdnpR5UbDp7PWp35eZKUQUeG/yrHeGtw+qiFlUcBJue2GBcUbih5xGNB
 iyFmNHRyaaZ0/vZY9I2drp8p6u7b5paDbfCI/cthynNyRRI633Cz9O/7EZUI9Qe8qoYG Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36ugq3hq19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 13:03:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OD0X6b074514;
        Wed, 24 Feb 2021 13:03:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 36v9m5x5xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 13:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz0qAl93/0wO+v/4g4ZyVyOnBNXoIKKuR8RimpCtnuxNpxCwwEeCdGcRwGGJjGo26A2e0cmvmZ+6PS8yQDbpSkQSZvhcIuJ38didJTp72HBUW6R4indGjZ0chYTdL6vFYxG7omfZqjFi/vl6qEzFfHzWnyliR4to8fRYJXilp43cvt5ORgCk6HsOWdeWxm9aFSG8mcdJtKO40I+HWJvhouJEBjRGDU4y739pjw8wxZIpGtCN4Wiey+1aTCyRc72WdvrQa9hFGAeVLhM5psQZ80CnEZJxjHPr09g+ma3Ekb8iBKqhtdSARR8Lg1X8iUTf8nAht+pbcLH1STfowaX+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4YaTSdXkR8G19uhricGPulObX9SaB/wYDMPCp9YOoY=;
 b=GKC0yQtxP1KvnSHpt+aDF43WIRcvY8ExKC20apeReHgc/qFlLEpWCwYzexWlDlDOaln32xcpPpS7EAOLEbGlF6HkS8XanIfiasC22zFVc4TI60kbDPo3B+/vnCKkV1cP5vWjX+7zYT37tte1jDrBTRp5t5l5dl7pw7rlBsBKAR8eKuLqhKLSuUoRAB5Aff8PzxvcmReqRNgyJzOJEe+USp8J/I+uViiTsz8RVW+Iu3q1ZXBDyZEN6/B6qzZC6mP0Kx+oc+gsQNRm2Ns4iUfJq6oBZTRJx9UpHJOTNyleMTwjf4lS9D8BejXSVZnSmdPTNCUvMNCWwvgtdr1eiXOrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4YaTSdXkR8G19uhricGPulObX9SaB/wYDMPCp9YOoY=;
 b=JtNTBcVQuoJsmtsFdgb4B32hV2CmxHkeSVpGaH/Of3g6SUlggJe9STRgmEmLnDhQmIgLTnjed785BZD507QoUrXSORUbza+2tSSPddRrPHu0DoWY798WV/Kt+fUW8jcL67/FqNcQb+ZiK+a6r5vmtDljMWnxZ47ugSEV73WCANQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR1001MB2367.namprd10.prod.outlook.com (2603:10b6:301:30::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 13:03:06 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 13:03:06 +0000
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
 <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net>
 <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
 <CABk29NvX9_RxpZ71ihR7Y_Nhpg0TpBfdXzehptO52VuwOmS2Ww@mail.gmail.com>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <c65bde1e-bac9-e6b6-e6c8-78b93f27b8e4@oracle.com>
Date:   Wed, 24 Feb 2021 08:02:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CABk29NvX9_RxpZ71ihR7Y_Nhpg0TpBfdXzehptO52VuwOmS2Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:610:58::12) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 13:03:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 322c04b6-6aa3-45b7-98fd-08d8d8c486e6
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2367FFF0ADEE64B035B899949B9F9@MWHPR1001MB2367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQK6t+eAZMSxLEKgFe1jTW7rrZR/bEWq4hQdbQus/glWIRWw9Jrxt+ukcwz7KG3uBgBT0XJyPtO6OKkOo9ptqV91YhaLZoEhsRjeccdWI9ezWqty2HKTxEEGIwyBcO1xIbCENXhhXuA1JWtjjSb++oM5arXiVZV9e8Ypl0e3cuU9hSRfudCl6iAS4CLSVt4vSUC9xPUYQlZzp+YK9x/uI8Gz6gkPCR5EvhPmhbGXfkbAI/V6LDPKXH/1+ubXPEpLWcp2hHXyr4RD8SqOOu3OW4JCYrHcdPn3ImbYEDEwhFI87ZtqWbwQVumxJGSV6MZ0aHQdmrS30AzyVLQiuFOYH0D5WBl6RW5WUlKw71EC+GS76aGLvY7GuRyXwVfC8oj8RcnsrUFse0zNkG3RkHqoITbuoxyIStCSTnNSe07F0o9uXWT013H/K+y0Qc7OKMhgSeRqz3yu0mybQnO/948Xql82zmp8BSE3+TiVNMFK3Nv0fB0j1LxkKAeavHOZjsOOLC7oVCT7MbLYPZ7yZMgOS1iFggOx3bGd+M58JZQ8XcCgOX2fdHyTg6oa3a+POl9tYbSnLXYBtmYjJa2MP7aH0jSAzuUPqhinxL7OAWyH+AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(31696002)(6916009)(86362001)(478600001)(7406005)(956004)(26005)(5660300002)(31686004)(44832011)(7416002)(8936002)(2616005)(53546011)(52116002)(36756003)(54906003)(186003)(6666004)(16526019)(66476007)(66556008)(66946007)(16576012)(83380400001)(8676002)(6486002)(4326008)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bWQzaUhnMHlNUE1jUUtZbnQxbDJ3SjlleVliUmpKMC9sSnAyTzdJZGhmVHRu?=
 =?utf-8?B?Rk9YWEM2eURqSEZkMUl1M3A0ZUQyamw2ZWlrdW5nek00VkF2Q3NMOG1nZWVh?=
 =?utf-8?B?QjNvSXVmK0hrYnRKRVdCZXFIcGdRTDgzc3NIS3JiOUFIK1luTG04SnFSallU?=
 =?utf-8?B?bEFLWWRkMGFYYk93Zk1GbW5WQXNza3RDNDE2THlTQVluaE54V1pQL2hzcTd1?=
 =?utf-8?B?Q0FteXJnQ2pQcVJaa2xlYTlTSTM5bU5NVG53cjVWN0lJZ0J1UkNQUEtrZklK?=
 =?utf-8?B?QVVxRHhvVDdFV21mSUZRWlZJNzlTZUVwcjZUNG5LM1ExT0toUGhGS2tIQ0hB?=
 =?utf-8?B?MlNPa3pBcjZRWld0UkozR1JNL3VPdlhJdUlrM0JJbEFjZUdRYkhhUjZtZzl6?=
 =?utf-8?B?MmsyWkpIWFk0Uy9ILzY2N1gxZG44a0s0c3BhMWozN01CTVdQbEU2dHBYbFpC?=
 =?utf-8?B?OUtNT2JkNXNBejVFOVRVbDdEb2NxQ2VGZFZsUlQxL1NnT3VKZEdTUjlwSlJT?=
 =?utf-8?B?dVo4OWM1cDA3eDVidENsTVFIVmlyVms3czVtOEwrTVNZdW92bUxqUnk5RnZn?=
 =?utf-8?B?VzhROXluck1kWDVZb2grTVV3ZUhrVjJGdElqZzZuTXlQSWZ4bFdRSnZWTFp3?=
 =?utf-8?B?amF2eGdSRUV6SmJoYzM5WC9nZGxEQVkxVjV0NUJLUzhpU1VTVnE0TXp3dlNU?=
 =?utf-8?B?VTRMQ1hxSkd1WXBPQmxhMHUxemd3bUo0clc1Q2NuV2xGSTdoekNIWHJOcnB5?=
 =?utf-8?B?KzFZQXduY2h3SGRjV0hBK2Q5cEVYZnFYTitTMS94TGc2UEQyVUh6OEQwL0U2?=
 =?utf-8?B?YWVoTVEzcGRYQmZ3VE9DckhCNFpReS9RdnFraStYWjV3eWt3TmRYYlREUDVW?=
 =?utf-8?B?L0crQVRPeWczR1BpeERHUlNPWE5weUhkanBQeTlRUzJTMktXL2QybFRHOE1T?=
 =?utf-8?B?enYyaUE0OExBQ1JXQkVhRkV4Z2dRMnVCK3NZc3R4eU1abVhSMjZZamFOMjlk?=
 =?utf-8?B?bFZVYjVIdldlblFDTU9rV2RTZkpaQUVlaTVtc05NTlgvTkdQNllzNkNCNlpN?=
 =?utf-8?B?dnpqcjlXamRtNmxuV1NnVSswaENwTTFWWmRpRHZEZjgyTXNtRjl0UjMrRjZI?=
 =?utf-8?B?UGRkYmF6dGRqK2NCc0EvdGFuUGlsT1d5c0swVE5Kck1pdUJFbDFOZGp1aVYx?=
 =?utf-8?B?V3B3cW1ISFlweU41bGp0K1hJdDdVYVlsdmRnVTZFb0lNZWdacDJwbmxRSld0?=
 =?utf-8?B?V0diVzBmdzR4ZkVBWHYxQUhSS3hJZUJOa2E1R0w2azgwQVNRWkRVb3ZDTm4y?=
 =?utf-8?B?UjlYSW1yQUhnR2c1U3dIS2k2QVhzS3l3QTB1ZHpEYjJhQUZqc1BMenR6azE3?=
 =?utf-8?B?MEk3R0ZUaml0YWxNY0gydGlESGR4TGJiQnNjYWtYcW8yWkltSWtNSTdzcG04?=
 =?utf-8?B?bVJ0amM5U3ErRG9yRk9MR1JOTUJyRTBhSGJ3b2RmMVRabGNzcFdGMzFVa0t4?=
 =?utf-8?B?UjVOcWdDOE9wb2pQWTdNTkFwQmFlSHBPUGpsdUNZQnR4VzRwd3RDQm44UzlI?=
 =?utf-8?B?VFBRR3FsYXZMem5od3JKVEdvempqa1hJTk13VlAwcm1DTkV4QVM3WHJscThP?=
 =?utf-8?B?SDhxZzVSVWJJalhLRHlRVXR0cmpOSTc3MEk0cGhPU0NUakRzSTFtSGtUSExh?=
 =?utf-8?B?K21Ob1JDSHBtKzhxd096OERZRWJNeXhIN1NnNjYzbVk0MjA1NUV2N3ZDNXBG?=
 =?utf-8?Q?VIJrRsIvHa/O+PKLs5IgczQszUzdgEqZqKN2cgi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322c04b6-6aa3-45b7-98fd-08d8d8c486e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 13:03:06.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR24elTf6F+8G5VEJr5rDVD8oj5osk0PfmXv9nDBsmSS4pvwfsmKSGytt8Jhwe+FSD0iSZXX2Ouxj91z+JuX7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2367
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/21 12:15 AM, Josh Don wrote:
> On Tue, Feb 23, 2021 at 11:26 AM Chris Hyser <chris.hyser@oracle.com> wrote:
>>
>> On 2/23/21 4:05 AM, Peter Zijlstra wrote:
>>> On Mon, Feb 22, 2021 at 11:00:37PM -0500, Chris Hyser wrote:
>>>> On 1/22/21 8:17 PM, Joel Fernandes (Google) wrote:
>>>> While trying to test the new prctl() code I'm working on, I ran into a bug I
>>>> chased back into this v10 code. Under a fair amount of stress, when the
>>>> function __sched_core_update_cookie() is ultimately called from
>>>> sched_core_fork(), the system deadlocks or otherwise non-visibly crashes.
>>>> I've not had much success figuring out why/what. I'm running with LOCKDEP on
>>>> and seeing no complaints. Duplicating it only requires setting a cookie on a
>>>> task and forking a bunch of threads ... all of which then want to update
>>>> their cookie.
>>>
>>> Can you share the code and reproducer?
>>
>> Attached is a tarball with c code (source) and scripts. Just run ./setup_bug which will compile the source and start a
>> bash with a cs cookie. Then run ./show_bug which dumps the cookie and then fires off some processes and threads. Note
>> the cs_clone command is not doing any core sched prctls for this test (not needed and currently coded for a diff prctl
>> interface). It just creates processes and threads. I see this hang almost instantly.
>>
>> Josh, I did verify that this occurs on Joel's coresched tree both with and w/o the kprot patch and that should exactly
>> correspond to these patches.
>>
>> -chrish
>>
> 
> I think I've gotten to the root of this. In the fork code, our cases
> for inheriting task_cookie are inverted for CLONE_THREAD vs
> !CLONE_THREAD. As a result, we are creating a new cookie per-thread,
> rather than inheriting from the parent. Now this is actually ok; I'm
> not observing a scalability problem with creating this many cookies.

This isn't the issue. The test code generates cases for both THREAD_CLONE and not and both paths call the cookie update 
code. The new code I was testing when I discovered this, fixed the problem you noted.


> However, it means that overall throughput of your binary is cut in
> ~half, since none of the threads can share a core. Note that I never
> saw an indefinite deadlock, just ~2x runtime for your binary vs th > control. I've verified that both a) manually hardcoding all threads to
> be able to share regardless of cookie, and b) using a machine with 6
> cores instead of 2, both allow your binary to complete in the same
> amount of time as without the new API.

This was on a 24 core box. When I run the test, I definitely hangs. I'll answer your other email as wwll.

-chrish
