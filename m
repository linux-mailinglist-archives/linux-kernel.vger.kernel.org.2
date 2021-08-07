Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1FA3E3554
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhHGMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 08:22:13 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:23342 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231922AbhHGMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 08:22:12 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 177CFAZ4032308;
        Sat, 7 Aug 2021 12:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=6QvACyaJYDhDuZQy9L2Bu8AzVl0gbX3jnqADaaHt0yw=;
 b=o2HSvKxviCriZuJwyFjQO/2vapQXPUhkvxFV8LE91+rSJnbKKqv9FSpwfrkTG7gXk3b0
 Sjfsa68xWLdo3h4PHtMPZKKsSos+b6jBASoXilNXr/pyz+pNRlio89bi5XEJspgNpiD/
 LvAlYGelW0pFZzzsjDMJmf96mjhieHu9RV8NNXxMRIsQ3zv7XB8XZ5B3DH2BpZ++NZXv
 XTappwhbQ/ktkiO6TprbwVsm77es6qG27N+k4AwqmmoB9tEljZ2SaQXYJF1aSqpsNUuv
 Zs6sEUGm5L7h8am93z35nnbu7lxz+wlZ2gcOPw7UzUVmNdQvIBrfvEaRlc8GANxWe26S cg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-0064b401.pphosted.com with ESMTP id 3a9fd2r92h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Aug 2021 12:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9xKqKynr4ArGKriyIdaTVT+XemE33jiJ+7zoqVbpfBuE6daH7MukujvrMAtuu1/jSJq5411hM0dedaOqebgQDNnCeBvIUXT7Nm1tDjZJJJKd+Hlrz/rRCJSeZ8ar+2+/cLRbtjy4rnpOt7pPCU6x5hMQikWYxsplWFktVchg3dGsHIVmFCmdtDAuQJbhiW1CE/we6IuHq3JJhfbFksRSQtfoJ9aJ76BJlRPdtoTZ3Vw6YJO/JiqrikoZFAokZhqreH8RfeWarebgJhIxtjFVDWxl2pig1x7zr5U52U/eXHya1s93A1G0YpKbZUcleS0FSacXVUMBNGGOWllweGOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QvACyaJYDhDuZQy9L2Bu8AzVl0gbX3jnqADaaHt0yw=;
 b=HBHB76zeOll9kQPc0HwZWaYX+Ly2PEnYjWv/a8f1yWWnqSGLU7IX1OFiCQF3hvhUcSFcrwXaxMGrHk/wkesGm86Tn+uL+uEWcrc/r+KVMdJm2t2S8U/DxkD5ZfMlMWj5VPGW3PDxc13yjJTLWn69M54i6hrxApJRf7XwVLFntO3kuYAqx9ubCZC5k5dwXYwB0hxoTnAtst6nMfgUVMcPMhseseJthILrQGkVy+Bh+/Tlv8m9kAlT635us8FFDrZbKIOpkkg9NEe1IPzOLMSzUhhcniK4Ab+7ZaFk8SoAbQs6Axqbw61GFNlyN9HMrz07YFQ65ke3nkZn88eMR720vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB2555.namprd11.prod.outlook.com (2603:10b6:5:c5::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.25; Sat, 7 Aug 2021 12:21:35 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::8ccc:636b:dcea:7a5d]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::8ccc:636b:dcea:7a5d%5]) with mapi id 15.20.4394.019; Sat, 7 Aug 2021
 12:21:34 +0000
Subject: Re: [PATCH] kernel/hung_task.c: Fix a typo in check_hung_task()
 comment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        deller@gmx.de, wei.liu@kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210806114049.649909-1-jun.miao@windriver.com>
 <CAKXUXMxrE=OO3K6fafU38GDp3cvEtRYrqo-w2-hDO6OrvHe26Q@mail.gmail.com>
From:   Jun Miao <jun.miao@windriver.com>
Message-ID: <c40abc2d-2343-2eba-a5e4-4309a2577908@windriver.com>
Date:   Sat, 7 Aug 2021 20:21:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKXUXMxrE=OO3K6fafU38GDp3cvEtRYrqo-w2-hDO6OrvHe26Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.214] (60.247.85.82) by HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Sat, 7 Aug 2021 12:21:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c61ee4f-6d03-4d7e-1ae3-08d9599de58e
X-MS-TrafficTypeDiagnostic: DM6PR11MB2555:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2555A808FAF157E6452FA2428EF49@DM6PR11MB2555.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUPCxzODLViypn8gNMOXlbcdRybKmY5y5VXspGNdMgVCiGd0QDZVci8h7fF+z5hKHAcqXf1HxxYNEU0IPz0rNlskka/YhXmbSZedJXQE5788LKzQYJU9BY5coVPeNhFqN5Skdz51qsJT94kJLktnEcgUbzYYCuy9M7h0vINwXqUrG7aW7Zebsk3inyozMRF8oF5bXZcsqKeu2rpoyJA44XYvFXUQ02FvNRy78MGjMBd8FNl0R4cKzOP9FPD+ehWQeHz57KQiWhANRyifQXdyOl+H52mGaTcaxGKv8Me58ztyIqnhi920/kpEhRHDZHwmas5ji6boZGdGsaPO7h7Id5U9aZGYNI4KgbVATcEyTPKUcd8kJFJSfCmTo0sjnsVbQRSnJ3am3u1sisCpJpfuxfKAgZRZUN0XOgHF1gDHsGMLcykdoOPTD0mWYdP/eoubXlScsid1O8qL0p9+WFEYubE32zcYxxLcHJjAZO4Z9M8YG6EWI49+agTz6IXXY7iFFH51Orou7TH62fscXpEP1S+OUfSmnG/LVCq4dgDPN3fhJC6cBbUh1TPomwqNKwnyBaGGYeERkyr4ZDfX/z7LSP7zaW/HD6UzNBVqe5VXJV1CLXxb8z6T2i5bKYer33I50qlWGRhQn0nL1s9kpL91pKmr+j5yUDtvEzl1hFMeAK843/fisBJ8uHQRO3RoXMVH3OpjapExZoqlVCQ4sfhGF/c6sViAhddNEOV8GUBDnk0G92IDcisFjJP/1FSewwRTEVAuZuxZtZWa0eG4XZ9Vl2JKrTeNm5BVneiEQgqvLh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(346002)(376002)(136003)(52116002)(38350700002)(38100700002)(53546011)(2906002)(44832011)(6486002)(2616005)(186003)(16576012)(54906003)(8936002)(956004)(316002)(6706004)(66476007)(31696002)(478600001)(66946007)(66556008)(86362001)(4326008)(5660300002)(6916009)(31686004)(6666004)(26005)(8676002)(36756003)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVERVBURjBkdENzNGd0eGs5Y2M0TEdueGhUTUNBeGNCSG9ra2Fob1VNUHFq?=
 =?utf-8?B?NHhuRStUSWEzcFBkNlZOakpuSHZPU3VDbUtEUmFYZHAvQmt0ZXZueCtKQm1I?=
 =?utf-8?B?TnJYb2x0WWhUOWorMTBhbTF4Zk9MemFXeCtvU3EzN25JZml2QVppMEhMcmVi?=
 =?utf-8?B?akIrSDdtelNSOTBma0k2MG1LZFVlSjk1dlF0Q3hhc1I5VENuWGkzQUFhcWNv?=
 =?utf-8?B?TEVJb095aCtJbmNRMnF5c29PUGFaWjR1Wi8zWVZCR2RENFI5bGc4VnlybEQ3?=
 =?utf-8?B?Z2hDaEIza1U3TWQ4K3R0M05xQnNlOTlLcUFVamtCN3FYaUl6djlhTEszY2Ro?=
 =?utf-8?B?WitUSXJsSGUyWGg5eHNVVVhxeWVSaUNWMFgySGkyVTFCOU9CN1h1RUpvbUJq?=
 =?utf-8?B?YzFKWHVOeDFYajdNM01RSVpINHhxQmJZYUQ0dmZ0U20yTWtxWENYSkFVYTBp?=
 =?utf-8?B?bG9TUC9EK0xHUFVXZFpNTFRaSkxVaXE2Q3JaeUQ5Ukk1RUhadm1YNDY5WWpm?=
 =?utf-8?B?Vlh2dy9wZmtKenpRZzUyU3JUSGtqaHdwZXdHemR0dXJ0emFtMDJnWXViVXNW?=
 =?utf-8?B?bjVUSU9GVFJSeno1Mm5mMWorODV0UGN3RWdyVjZjZDBZWkZ6MFZiT1ErZWlq?=
 =?utf-8?B?WFZ5aVNlTm5vSGQ4cjRvTzlIVExpRU1nOExsdUE1WVpBdGxBSHNpckN2Wmhj?=
 =?utf-8?B?cGNYQldmMzcvOGs2cTA0c1hYdVVQQk1NWUw1WFRscEhQMFNiRHVlUWpYWC9V?=
 =?utf-8?B?R0VlNXd5bVVBR2hGM2lORXdDR1FwSUdwaGlYZHpDSmw0TGdXZ1pFemhYTTFW?=
 =?utf-8?B?dG8rdUw0U2lteDlIUnFXaG9jcG0zaW5jRzhDelRpU3JMOTVSZXBIVEdYcjlX?=
 =?utf-8?B?dXQxN2l2ZkIrOGpsV1NFaDdCVkNGbWVpK1NSWTRqRG1HUXNzS2RRN1JsWGlv?=
 =?utf-8?B?bklGU3dHL0xLOVduQU0xQ2p1dENrbmU0bUVpT2RORVhlbjlIajhBbzZtY2sv?=
 =?utf-8?B?SE45M2N2WDY0bUNJS2VyV0NqcmdGbmx5dEZLeUdid05XT0taVWJsZnEzSlFC?=
 =?utf-8?B?R3JvNnJCd00yY0tlZ09OL0F6RGlBbUFDRjgzK0crWHZHTXUwaS9MNWFvMTd6?=
 =?utf-8?B?L3E3d0YyelphRFdzREtBcHdKUmd6MVdsWmtpcU1HNTM5ajJmaWUwUC9kUWJt?=
 =?utf-8?B?VkdpRFhZbWVITVBUN1hSalFxajN1L0FmZ2pGMktqVTJjVzM0M3MxUWFuNDBn?=
 =?utf-8?B?SWlSL2tHbGIwRnNrd2RPVjJielZMdFFsSUlGK2N4NW1BeE8xQ3NTNFRGSWJ3?=
 =?utf-8?B?UmFXQkRuRi9xQ2VFenFZWHgybURyNittYWVWL2p4c0Fqbm1WdDhoWXB3ai9p?=
 =?utf-8?B?VUFhVGYxSnhGZUZMZGNZMWFrWnc3bkF2RHhFNWloMmFWSHpqeXFnanhRZ0E4?=
 =?utf-8?B?YlhpRGFZNWdFWUZ5Z2YrWnNIZkUvOXc4N3RNWTNtSDNIRlozRUUvZk9nU1pD?=
 =?utf-8?B?eXI3d00zR0ZqaWV0NUV3Slc3eTVnMUV4RXhqYm9DOFBpOUFGSnBqa0NSTU5w?=
 =?utf-8?B?ZGlDdHArd2RLQmNNTTB0bGk4Q0tERVFMeG90NkNZUTk1dlU0VWtoeDNDVDYw?=
 =?utf-8?B?ZGp3LzhTekRUOUZSNEc4cDc5VXUraUlWMXg0QTJCN01lK3ZUSnRSSGg0ODJi?=
 =?utf-8?B?emdWcXNzczJqSHVJZklkQjR2NWc0cko3TTdVcjRIYlVBWVlrdXJsOVN0ejNy?=
 =?utf-8?Q?EwH0R+q5g/rzLkFqQfxtC3ie50ScT4ZN6znsX5J?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c61ee4f-6d03-4d7e-1ae3-08d9599de58e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2021 12:21:34.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6ym8ij1/RG97bcoY+08ayzALEIoTNrRHJ8aFo6Wdcmd7F4A5PN7B6ggayoFEBDWMyDJTL2d95xblsYqCMcOqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2555
X-Proofpoint-GUID: VbmkTqb7OxHi2yT13wYuKKxQV9750ca4
X-Proofpoint-ORIG-GUID: VbmkTqb7OxHi2yT13wYuKKxQV9750ca4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-07_04,2021-08-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108070085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/6/21 10:27 PM, Lukas Bulwahn wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Fri, Aug 6, 2021 at 1:41 PM Jun Miao <jun.miao@windriver.com> wrote:
>> It's "mustn't", not "musn't". Let's fix that.
>>
>> Signed-off-by: Jun Miao <jun.miao@windriver.com>
>> ---
>>   kernel/hung_task.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>> index 9888e2bc8c76..ea5ba912db06 100644
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -99,7 +99,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>          /*
>>           * When a freshly created task is scheduled once, changes its state to
>>           * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
>> -        * musn't be checked.
>> +        * mustn't be checked.
> I cannot even parse this comment.
>
> Does "When a freshly created task is scheduled once, changes its state
> to TASK_UNINTERRUPTIBLE" mean "When a freshly created task is
> scheduled once and it changes its state to TASK_UNINTERRUPTIBLE"?
>
> Does this "it must not be checked" read as "it shall not be checked"
> (as in "because if you check it, something goes wrong") or "it is not
> required to be checked" (as in "usually, you need to check it
> (otherwise something goes wrong), but here in this case, you do not
> need to check it, because it cannot go wrong in this case")?
>
> Fixing spelling mistakes is okay, but it is even better to check the
> sentence you are correcting and try to comprehend it.

Hi Lukas, thanks for your advice from my heart.

 From the context of code:
---
  90         unsigned long switch_count = t->nvcsw + t->nivcsw;
  91
  ... ...
  99         /*
100          * When a freshly created task is scheduled once, changes 
its state to
101          * TASK_UNINTERRUPTIBLE without having ever been switched 
out once, it
102          * mustn't be checked.
103          */
104         if (unlikely(!switch_count))
105                 return;
---

It should read as "it shall not be checked" (as in "because if you check 
it, something goes wrong")
. When create a task and set it as "TASK_UNINTERRUPTIBLE" we don`t need 
to check "swtich_count=0".
If check will report a false positive.

 From a history commit cf2592f59c0e, there is a detail explain:
     - the task is freshly created and scheduled
     - it puts its state to TASK_UNINTERRUPTIBLE and is not yet switched out
     - check_hung_task() scans this task and will report a false 
positive because
       t->nvcsw + t->nivcsw == t->last_switch_count == 0

     Add a check for such cases.

Thanks
Jun
> Lukas
