Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59521311AC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhBFESC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:18:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhBFDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:10:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115MJGPU171361;
        Fri, 5 Feb 2021 22:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EmEW8zpjWCZ43DLnsMdkFxi7bn3tIeKuFct15B27RDY=;
 b=kXMu76VkarwIeDtIEJaPk8ImaW2Y9PE9Uvt0TtCEitZK+CfcyfCb6bT8WmPIIu4vUGKc
 PvOaPgMQ7KexxvUJJ+e2s7bcrNpWWhuvSHAL6Vj1OujslLtvbR/sHfEZSuPzjYstH9oj
 0s8IhORso80S6lqIOudOOg8mqUU4TSmqNehVH5Sx1StP94tTu875cy5tPZE33kSPd8w2
 9nhPZ25wKAm94Vypwds2v0crQptz9TGO/l9OgsUiQfWlelAINcOk32xOcYaQWgZ6f8YD
 hUMXxV9dXtxFofMJtft29J3IiUh0ciAiXiE0YmA1Bqoky86IBplT7ZKT3tw+b6PjuvpF 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydmb92v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 22:19:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115MFAg6118619;
        Fri, 5 Feb 2021 22:19:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 36dhc4s6ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 22:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko6z5gJhoTqvXeFZBAlz+JKSAEAPhoJeBb6WccQJLqHOk6QKNy8IGUldyw2xjHmU4TCWT2tcKeicEmOw68tN/3VTs9BW21v6khJlX31v0givdHQbY9Jlib5v2BlwBxWQVBIGDpN9laO4iLoXmwXOyRoib5YxE7HUmc9a60/bcFsgLSxhcq69WbwglZ7oNaM8y7uu0VSjm4ZGA7tQzFcpxbL0oWVN2hNCyM6oQ+VXDrTcA7cGHHj1A3Z9KjQ20QozJVUNKGZQWoMtF8cKEmUjR4qyPWkrpEkieTDuB2QgLc4oM44VOwOgBYL4kliP3xg773vw8SRc+0mvTxoo5d2pzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmEW8zpjWCZ43DLnsMdkFxi7bn3tIeKuFct15B27RDY=;
 b=fN0B3Rjd3wON9dUc1aPu3RaLSMQDiGKKKJWc2EbX5tjfuOsoLkJ7ox0EW8k4zpsj4UQYuOBl8lQP4wHQmaT3WLdwKX5UX4Aosxt+/zCLvaC2qpVMjg9JCg4wNyFkQ156XcsPeq5XlMH5vAZqKLC0wVTXhDyP0FkWDbwJGWjoXT2bQCXD9ILhuVnONabsMOX6d0VkWIjUuSbMoczSMAsPVj7vUCP6K80oOeVc0Lln25qUNgQkFI5I3VTrVrZtAHwfCwUE6l7Nz28ZSG3D74xvPECju3XlAHn8xX8wZhF3cEx569iP9C2ac4hm1luXi5o3EYzXbVoTrLxjKgM7m9YRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmEW8zpjWCZ43DLnsMdkFxi7bn3tIeKuFct15B27RDY=;
 b=ZXD72zrWEKn7zc54SruHGnoLKVaRqL7vy9yMcBVwtllpTd7jWDeTvvo6IrIHbLjSVU7DHdcYE4qfOOfD602xIg2S3ZiDOoOAp96GgZEaqM2PEsPAyvXCBYM2u0JSF9b1cI2vdGclna+rHmDiCC1MkgfMAqdtAJ7/Ai5Ueyg/GTQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 5 Feb
 2021 22:19:13 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f%4]) with mapi id 15.20.3825.017; Fri, 5 Feb 2021
 22:19:13 +0000
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
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
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <YBv9Uy1dyv8E2LAz@hirez.programming.kicks-ass.net>
 <94bb9424-008e-6d3c-dff6-a1329c16551f@oracle.com>
 <YB0hN5XG5dB0xiBh@hirez.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <7c5d083b-b722-76e5-37ba-ccd1c1a03e13@oracle.com>
Date:   Fri, 5 Feb 2021 17:19:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <YB0hN5XG5dB0xiBh@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:610:ce::31) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:610:ce::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Fri, 5 Feb 2021 22:19:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07515cb-cdd8-4fa5-1fa7-08d8ca241105
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45008A848B51B6212735B1BA9BB29@CO1PR10MB4500.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJFCu4kMVmVfHjbc2S9jMl3y689WlRWoAOCqkA4OwCccF5fpOUmjmcRk533asrWANtMUu9htcs6tPJxjuTDL1xeJaJaChTxTk5tp0AVJmqSkRqf+AHJzBVt3IZiu4An61C5ZivuUIM8aP6oSotK8TqmDJZZkel3kXM+34+AYtDvIop0kIeBLtdzWomggUE2KRDK3EIuqKIrvVavpsysfY2oFUl1eXkuR3CXP0MduvVnQau1AV4G32VTPu6PaHf/SDqJ+n9FLeylTReV2lgVlnBrmgCFCHw9WCrYTY5D5Tq3DAsrXlZa5hUo2vCBfioqfxKiwAs7SCVRvFLykOgcajz23tXWogzBHnphHwxDziMP2xZJi9owd8VEVHG7OEkTxGDuYPEHlJuByQQ+Hezz92PvxSoDy7Pp56jmWXyxnPj4k8LjuUOWr/eK2W9wG93V0A5IPUxrjip+MGpqqhDWS2FJ4q6W3l9MwPdT+8dcZ+O+zpjkHx2W1Vh62hM5z5TRC6JTj8KMMmWZE0XMPJzS9X37xKwT9ClBusyf3bsjRPG8GEzfSLd0a7ewYenggJ64l7hyBSWeMOhtbl8xl2XW+oTzQs/R9z803TLItpVlYLtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(66556008)(52116002)(8936002)(956004)(478600001)(2616005)(66476007)(86362001)(2906002)(31696002)(316002)(7406005)(83380400001)(16576012)(6486002)(7416002)(186003)(16526019)(8676002)(54906003)(5660300002)(4326008)(6916009)(36756003)(6666004)(53546011)(66946007)(44832011)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGoyOHRtajNseHhlMEhCKytUV2xLZXZvbE4rblBYOWNRNG9ucm9wSHV4WXBN?=
 =?utf-8?B?c3ZJQ1VralZTYnJKOXVmKzFkU0ljSkMvT2x2SzdnK0p1SWFnYTc3NDM2UE44?=
 =?utf-8?B?a3V5WmFzUUxXWi9CRnB3WExCT3Z6ZVo3N0JMYWlhdXV0OVVIaHU5ZXV6SWFM?=
 =?utf-8?B?MUdGaGtlNTkvcGhCMEY3WnpZc3Y2bnE3RTBBUWxnRGxEYllkRmRhbm12akFN?=
 =?utf-8?B?NGdoYWs1Y2JtRm5mZTZNYkNuZ0hsUTJyNUx2azBVa3RoamU0R1creGxhSkFO?=
 =?utf-8?B?L1NHS2JKdTl3c0daKzQ0L2xwOGdGcUR1V0FZaVgwd1pEa2lFZU5BbWJsZU1y?=
 =?utf-8?B?WmJEYzZpMzQ0akx6cGdHWnVFeGU4MTQvT0ljdFZ6MDliOWhPaUlVMkQwak4y?=
 =?utf-8?B?M3Yya2Y1WkF5Rmplc2d5YU02OHhRTWkvckhsdG5ZYmwwdzI4Y2ZEbThGTi84?=
 =?utf-8?B?WXFCWXhtTmpuc3BhZHkwQ3ZEQ3hITlJ6ZlZwMHNzMDVpWkNCRFJwdUZuM0ZI?=
 =?utf-8?B?TmdoZWVROEtoTzhvbU5OcC9BSVZCNWU0NGV2ZmNzaExRNEdnc0RKNTl1b0s3?=
 =?utf-8?B?UEtiYTR5cnBydXNMNW1WaDhlTlhodVZKcjd4OXJ4R0hrVGlEVFA1NW5ZOE9K?=
 =?utf-8?B?bjM4TGNoZVZJQ0dmRWt4VUozSjA2bWZzelhZdnhjUmZJWXNQZUIyc1NpSlZ4?=
 =?utf-8?B?SjNlNm1VM0l3WWRiQ0s3UlpZKzlCVWF4cUMvRythVlJja2luVU1YZmF4Y1p3?=
 =?utf-8?B?QlVLbEdwbHdDWDRrNnU2WlIvWlpvbGpoNEQxNkd4bjZoNVlBTXRjRlNQWnNi?=
 =?utf-8?B?Z3FVblgvUTJaaU9saTlGSDJqMWpLUXBSd1NlQmI2RDJ0YldDbzlrVGpqOTJX?=
 =?utf-8?B?UnJqZ2JNcU85dUpkL2VJVGlOeWtncmdTek5HUmxrYzFEZ2htcWY1RHYzendV?=
 =?utf-8?B?T2FWTVVmUUxVdVo5YlE1VkVIYmJXYlhGem9TWERJVE43MElRV2x3Z29UNis3?=
 =?utf-8?B?b1ZobitnTlBmRDVNZjFaV3g1dGZhUXdyamU4Q2ZrYkNmeTZ2U0dMTjNaMCtj?=
 =?utf-8?B?M0w0RHVnNlppMG9FbDJUdXMzdkg0bTFJSlBiY2VPMmJ0d09aazNqTHR0MUQ1?=
 =?utf-8?B?MnRCZEIwSnZLT200ZW1WMU56cm5SV0lRaC9vTDJwR29SSlpmMm1aUEdiTXFX?=
 =?utf-8?B?L1o0NWFOOFY4a0NDcmRCTjAwSjY3RkgwZ0w4SDh0dGkrMTIzdytwMzR5cU1S?=
 =?utf-8?B?bUJDYnMycmVkSFQyeUtKcWwwNW9aWTFnMFpPSkUrYUNmZWZFVGNGUU5oSHpm?=
 =?utf-8?B?THZLMkFxVW9CMXhFcmY2bHExYzBsVmpmSWw0QW9EVjIzZW5IZEd4c3I0bkZN?=
 =?utf-8?B?eU45a3BlSDR6K0psYkxOWXV3V0o5R0ZHUkVLUGN2ZzBPNlYxSlViUWdqOGV0?=
 =?utf-8?B?ejZZVlZvcDlnbmZURGk4M1Q1VnlXeFB3WTVOMUs0bE9vNFZkckp3aVRxTWFX?=
 =?utf-8?B?Ym9kMVVsaU1vemRlQkVEcjlKb0dUWmVLWjVaWE5TbEp0bjVES0hRVzNlc1dJ?=
 =?utf-8?B?NytvaVRzVHhocTZsTDFSWTgwbEE2VTNpNndvRzVCNGg5RmdvQ0Fod2RRNGIw?=
 =?utf-8?B?UzVuTHkyeE95ejd3TW1qMGpwRnUvbExoZCs4NXNuV3NFczQ1T2dnTE5HdVZP?=
 =?utf-8?B?U3d4WnhpNHQ5YUtSNWVBN3dibkx0YXNCdXQvSSs0U2RXTHRGa2crUkRJQk5T?=
 =?utf-8?Q?sKkWpD53LxIgsHIs++zo5Q2qX78jH/f1FeYjedX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07515cb-cdd8-4fa5-1fa7-08d8ca241105
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:19:12.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGGbgevBB86oURoACRFN/H4auL/waO2fIzTlT6f0KBhQS2b9fxeVVOUXgev1fLrqu7hR32zfmor/dYwoHRJxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 5:43 AM, Peter Zijlstra wrote:
> On Thu, Feb 04, 2021 at 03:52:55PM -0500, Chris Hyser wrote:
> 
>> A second complication was a decision that new processes (not threads) do not
>> inherit their parents cookie. Thus forking is also not a means to share a
>> cookie. Basically with a "from-only" interface, the new task would need to
>> be modified to call prctl() itself. From-only also does not allow for
>> setting a cookie on an unmodified already running task. This can be fixed by
>> providing both a "to" and "from" sharing interface that allows helper
>> programs to construct arbitrary configurations from unmodified programs.
> 
> Do we really want to inhibit on fork() or would exec() be a better
> place? What about those applications that use fork() based workers?

I like exec-time as a fan of fork-based workers. I suppose the counter argument would be security, but the new process 
is in a state to be trusted to lower it's privileges, change permissions, core sched cookie etc before it makes itself 
differently vulnerable and because it is the same code, it "knows" if it did.

>>> Also, how do I set a unique cookie on myself with this interface?
>>
>> The v10 patch still uses the overloaded v9 mechanism (which as mentioned
>> above is if two tasks w/o cookies share a cookie they get a new shared
>> unique cookie). Yes, that is clearly an inconsistency and kludgy. The
>> mechanism is documented in the docs, but clearly not obvious from the
> 
> I've not seen a document so far (also, I'm not one to actually read
> documentation, much preferring comments and Changelogs).

Understood. I think we should split this patch into separate prctl and cgroup patches. The rationale decided here would 
then go into the prctl patch commit message. We can also use this split to address any dependencies we've created on 
cgroups that you mentioned in a different email.

>> So based on the above, how about we add a "create" to pair with "clear" and
>> call it "create" vs "set" since we are creating a unique opaque cookie
>> versus setting a particular value. And as mentioned, because one can't
>> specify a cookie directly but only thru sharing relationships, we need both
>> "to" and "from" to make it completely usable.
>>
>> So we end up with something like this:
>>      PR_SCHED_CORE_CREATE                       -- give yourself a unique cookie
>>      PR_SCHED_CORE_CLEAR                        -- clear your core sched cookie
>>      PR_SCHED_CORE_SHARE_FROM <src_task>        -- get their cookie for you
>>      PR_SCHED_CORE_SHARE_TO   <dest_task>       -- push your cookie to them
> 
> I'm still wondering why we need _FROM/_TO. What exactly will we miss
> with just _SHARE <pid>?
> 
> 	current		arg_task
> 	<none>		<none>		-EDAFT
> 	<none>		<cookie>	current gets cookie
> 	<cookie>	<none>		arg_task gets cookie
> 	<cookie>	<cookie>	-EDAFTER
> 
> (I have a suspicion, but I want to see it spelled out).

The min requirements of the interface I see are:

1. create a my own cookie
2. clear my own cookie
3. create a cookie for a running unmodified task
4. clear a cookie for a running unmodified task
5. copy a cookie from one running unmodified task to another unmodified task

So from your example above:
 > 	<none>		<cookie>	current gets cookie

could also mean clear the cookie of arg_task and satisfy requirement 4 above.

"Share" is a fuzzy term. I should have used COPY as that is more the semantics I was thinking ... specified directional 
transfer. So we could have a single command with two arguments where argument order determines direction. In the v10 
interface proposal, as one argument, current, was always implied, direction had to be specified in the command.

So a single copy command could be something like:

PR_SCHED_CORE_COPY   <src_task> <dst_task>

to replace the two. The very first util you write to do any thing useful w/ all of this is a "copy_cookie <spid> 
<dpid>". :-)

> Also, do we wants this interface to be able to work on processes? Things
> like fcntl(F_SETOWN_EX) allow you to specify a PID type.

Yes and creating/clearing a cookie on a PGID and SID seem like useful shortcuts to look into.

>> An additional question is should the inheritability of a process' cookie be
>> configurable? The current code gives the child process their own unique
>> cookie if the parent had a cookie. That is useful in some cases, but many
>> other configurations could be made much easier with inheritance.
> 
> What was the argument for not following the traditional fork() semantics
> and inheriting everything?

The code just showed up with no explanation :-), but I think I know what was intended and it touches on the same 
security policy type problem you mentioned in a comment on the CLEAR code. In a secure context, you can't just allow a 
random user to clear their cookie, i.e. make themselves trusted. At the same time, in a non-secure context, and several 
use cases have been put forward, I can't think of anything more annoying then being able to set a cookie on my task and 
then not having permission to clear it.

The fork scenario has a similar problem. A child inheriting the cookie means just that, but not inheriting is likely 
different depending on whether its secure vs non-secure (and obviously we can't use those terms. Who wants to advocate 
for non-security :-). For non-secure, don't inherit means the child gets no cookie; secure means the child gets their 
own unique cookie and not the parent's. In the absence of any way to set a policy, the current code chose the secure 
default which makes sense.

So I guess that raises the ugly question, do we need some kind of globally scoped, "secure/not-secure" core sched policy 
flag?

-chrish
