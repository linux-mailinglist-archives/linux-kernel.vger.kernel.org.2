Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85B366E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbhDUOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:46:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45756 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbhDUOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:46:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LEYrEo095527;
        Wed, 21 Apr 2021 14:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R4oXjPLXdiq8elUPDMG70DrNyemYMYAWRUqcQxdRT0g=;
 b=qCUcYVO8gjYZmF3W16sEbdagknIY15WroxE//D1gpmyxvUSq36EeYbDks+34FGqnT3ue
 jhzp4363QoiybLWQu4IV8uNfpsJMenIRSe20JPSg5sxSvmlP+TAihzrdKcnhWx2BqSqR
 eKAHy1O7aHcSfxy/oYrTVYnOHak849sdikByQafEsbYaCrIZasGiqcfEP3h6g3C9mOoo
 4yBv/ODBYgJv3nKmIoQ575kSf2I8pm4Adk3o2N7raxqPAvKbB4b7+ywshOsOH/aANyZS
 PxnCAxDpj5+x/Ju6pVjmfkXBdBCcC+AQ89u5Hi5W9KP4CDnRrqCXtVvpwxIo6W8hdCGG 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmnjhss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 14:45:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13LEUHiC054765;
        Wed, 21 Apr 2021 14:45:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3809k20r4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 14:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY7tmi+VgFIzMTske+/cCjDV6qXmwhftKzz8HRu7fY7RFn3dKb2dMIozg9jxoOE2aszJgKyAl3qS3HA/Poc1Tzfs5PBCJDlKmdaWvPoP4XaSXcSGF8eRrTJkmJhJAdDEiGhEEULlnrf80vYv0aqwvTZVQ5pIUHe9xdRMSjPhph6WKHsukFB5CyIfVt1D5RJQgY11HjAP1YoK2JWSurp4rJ2nYC0p0zjsmlmASu04yXhMPkHbpjXPlP7yHFIqeWzBQkVeD6orKxIeuPIvnlKwGP3qUUKpqI6k5BPUxbr4wYtUX/zhXC7m9dTEm7q3OTvBP3lU+t1wfW+tq2ANS4gpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4oXjPLXdiq8elUPDMG70DrNyemYMYAWRUqcQxdRT0g=;
 b=ciJiAWIOVi5jSD1meexsbPr4JeihUucRJZsfPm6zLzw98SvBI4N6ViIIXk4KNCIe+8Ac+ocgPwWf9V7iPu05T7zYKBDlAAV4AcWWYehYbdCBUMq6FeD4Ctrs+xM1cs1777wVk3Pq1t/Ckd/McJSylY8euXuPRYpaTd5ywZseq5zdiSMXrGDONKtA3Gh7zPMHcaot7CNaK6+90dVbfbm/7jJyuJ4doaNcmx4wGknQM5u3a1e2/166e15980Tzg8UkECpRsfaXqv0r3vqlJDBESLb0yGx4RnPsmQmoFAEbdZB7XQ0tf5P08pthlIih+zFgTiiU+UPYgmAN1tfgZR4xmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4oXjPLXdiq8elUPDMG70DrNyemYMYAWRUqcQxdRT0g=;
 b=gdwf311ax69cEKKVcF43Dvveyv8WHw8GWZ6MljAT8YufO8a2VWgT1oJ5/jKYyxBT6GJpX6rqikW2g/qmZ80A49kRBNcI2ndXbLR/iPmHZhUYUvabm/Dk8xPCwuxUkHWT0lFMJ9zqLNLgyBqTqoGTvhgCy8ZluO6rWe93sCula7s=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1373.namprd10.prod.outlook.com (2603:10b6:300:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 14:45:22 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::7cf5:7988:6b5a:9b33%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:45:22 +0000
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
To:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
 <YGxtLOxCb4LO8kN0@slm.duckdns.org> <YHuMy0o7gRd+kIVN@google.com>
 <YH1GyFA96tioW4kZ@hirez.programming.kicks-ass.net>
 <YIAqC5su75GGu+Qx@hirez.programming.kicks-ass.net>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <7703f6ae-51b9-8bc4-a3c0-70f534451014@oracle.com>
Date:   Wed, 21 Apr 2021 10:45:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <YIAqC5su75GGu+Qx@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.242.218.156]
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (67.242.218.156) by MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 14:45:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7172952e-a57c-4d02-2a40-08d904d41754
X-MS-TrafficTypeDiagnostic: MWHPR10MB1373:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1373C62C9C497D8938F312F09B479@MWHPR10MB1373.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzQlV1AJRg/fSpzziMtbA5e5ca/EaAbx5cMcXighmyifCiAlfgJTMkYggZmfkQyz20r1+P0jS7Il1n4pBh+1BHzXld011TnRuTqcfKvLbpyCwhaNjHcyQSKFMAH8g9xvHnRps91WQHMnFIdA1qjbQ8K8nCm2HrxgqRZm4OZmEbfm0jjord7an8nPtbnCduxzzNil4z9H5kmOdok8sEEKVOXFw2QZgnOvsscPCsB9ViXKgn8OwzTWWc7atCWNeIKU+DKwkwhicrEryJlQoyhgYr+RgNRDmJsP2O+3ZQjUQwzQwOuSdw1u6w79AS07ME2hZIj87Hg33l36De/bsWR2tUDCvuH0EqKgmXLNw3CImLGFs0zTYfWo29u9uU2DwrDOXptfSADJP+wbn6xTjSgSCZPsxi28NkvJixh4uCBRpOnKUC8NuKLG3cjEtf+aehwMhgiFRTZCG8ACqIPa7xtVnVpxEqKJN6wlMiViuBs9Piawi9cqIgr/feNH6CASAV7HfhvRBWr4yZHRpCbI2CO7vKukoDUe8mmNTRY0gjkIIhmwa8OXbkH1qEXj7Rp+PlqiMBiUKbyc1ho4TSdJKPMRK1B6xJ68yCLBIz5KcVD5JQ6P8dqy78zYu151WbJiq2boDGiiMn7iyj0jeMr8xFspsQ/x/b55ximCIUJaXFXu+H8S4SPjs54i54p08CvxdIUiV+c+hELbg42imz5RSqLluQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(44832011)(6486002)(53546011)(5660300002)(478600001)(4744005)(86362001)(4326008)(52116002)(54906003)(110136005)(956004)(2616005)(16526019)(2906002)(316002)(26005)(186003)(31686004)(31696002)(7416002)(36756003)(16576012)(66556008)(66946007)(66476007)(83380400001)(8936002)(8676002)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZzVzWjV3Y0RVNHVGUm91UGQ1bGlRdEQxVS9KMHRjOFJETE1mUXVGdmFYTnRs?=
 =?utf-8?B?aFlrRXQ5VkIwT1I1S05RNHVuSWZjYktmejVLOXUrVmxwRVZFUlJqUTV3K0tE?=
 =?utf-8?B?K2pWYnd0TXRhbEZUdXVwSVY4WVZDQkNaWTF0SWtvcm5zajBZR0JoVW1IRmRu?=
 =?utf-8?B?anJuT3cxUG9VQVZyZU80TnJNeWVHMklqaGhtTkg4NWNONHlSd0c0bTM3dnEx?=
 =?utf-8?B?b0pMMlIrNVZxNjRROWVNUGtyY1NraFdhWWxyczJSYlVZNkdPU1lYYUpxWkdR?=
 =?utf-8?B?RlM4eEdFUkZrcFhnUXBpZjhzdGM3d3BHUmRQa3JERDA2Q0ZnaTdIUWsyUElO?=
 =?utf-8?B?UHo1V2V3eHhURmIvaUZNRVNaMDY4WEJNR1k1VW9WWnM2ZHFEb0RiVzdBSUpQ?=
 =?utf-8?B?eXZtVVZETmdHQTAxWk5wVE9UOFBEWFpKTzUzMWtnVHIvcFpOMFMrOXZ0Vlln?=
 =?utf-8?B?UXhIejd5REtHQlMxYWw2bUhlMnE0VUg0N2NTTTlBVTFLaFJLN0tOTEJCV1h2?=
 =?utf-8?B?U2V6cXZsM3RCMWx0d2NEVktHVVpUVWdaanhwSndxbEg5b0Q4YTNXaU4xZWJt?=
 =?utf-8?B?OUwzQng2emxlakRIYi8yYmpObnR6YzBvRklyTGRrai9GbzJOVnFzRjBMVmls?=
 =?utf-8?B?T0JGVXFFZGFDaTZjc1RQTDkyNktsMnk5NjQvQ1RNL0pLOE9pbFZzaDRNRkJk?=
 =?utf-8?B?MHZkVjA1UzBac04yY0RsRWxrTUlGR0hLZnF6M2psL2VBVmNGZ29zT21VRnVo?=
 =?utf-8?B?eStzRFJvNytNUmY4VFY1eXJZQW5Ca2ZZNERkVWgvYS9GN01JMG8zUEEvUXFt?=
 =?utf-8?B?YjVaYXR3UWx3R3hNUVRLZWQ5MlMwYjJVRXJNb1pLdVFSWklDRU0rMHJ5TFp1?=
 =?utf-8?B?Z05uMkhNRndzSTFpa2V3RDJsT0VNanlVS09DblVkRmpUeDJhcjNvSy90blZM?=
 =?utf-8?B?bGNSSW81TjIySWU5NXY0Q2hmcjdadXBZUjFlSVhEdVREWVZFWnQrZTlqbjlU?=
 =?utf-8?B?YXN2NHg1eElId25LL1hTOGR4SjJsSmk4aGVXYWZ3cktqNXF2MmhWL2szeGZX?=
 =?utf-8?B?OWhGVmxweGNaNzJYeUlGdmUrTHc1QzMrajZheE85MEFmSjF6OXQrWVkvTk94?=
 =?utf-8?B?WjdhTmgxN3ZnczJqbHhGaUZFVDJpMk9OSEpWUTFxVXBYcUhNSTd0amdNR0U3?=
 =?utf-8?B?K1d5Tm51YlNKbE1FQUtiOWNEM2ZJd1ZOTHNaWlYwQlZ0U3hGZFhyM0s5b3hF?=
 =?utf-8?B?alRMaE83eGVTTXJ1Tzh4d1g3VDNDRXM0K1FDL3hzT3BrV01lOUZGeXNNamhE?=
 =?utf-8?B?U3dDRWI3TGd2bGJSTlQxa09UWThIZEx6S3pjWmNZaVh6V2dRQWRnTis3LzJZ?=
 =?utf-8?B?TkpiM2xQSVBSME03SlN2SVY1aXZIVkhXTUgzRmJvRFh4bEl1ZVVzQU84SU42?=
 =?utf-8?B?TnFlMERDOTJGMFRtU0tldWxGU3NVL3NLVjByc1NwSTBVbXpqK3NQVEJKZjM5?=
 =?utf-8?B?ci9McDQ1SEtXajVWVFNYaWNYL2x1aUFkZm5uRW5RNnV1S0JBdkNNOWNidmZr?=
 =?utf-8?B?VGRVSW13ZXczTG5tYlYySEw1VllhRGVsb2grWjV0M21rcW1vckRKc2dTWkla?=
 =?utf-8?B?QWJiN005Y3lDbnNlNHdiNDdtQW1oOTFyT1pOenQ2VGlwN1Y1c0J4dGp0Umho?=
 =?utf-8?B?RjVZd2pSblZUSDlLU3IzaExzRXZJZ29QdXhkemM4bHBOeXhSYld1aDJhVXAv?=
 =?utf-8?Q?ZxY84i2yXofzzBSehTcEwYP4gMspnn4HR2GY8aM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7172952e-a57c-4d02-2a40-08d904d41754
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:45:22.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGMmOQmm5ISJhzny/td/FqKwBuOtM8M7VVBJAFmfnqZEa5gpKu3T+iRXnchUdVvk52bgr1to+oat6ecmbMpfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1373
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210113
X-Proofpoint-ORIG-GUID: 7OLw0VzrPAEGTVYuXVHc4iwZmlWbjYr8
X-Proofpoint-GUID: 7OLw0VzrPAEGTVYuXVHc4iwZmlWbjYr8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 9:35 AM, Peter Zijlstra wrote:
> On Mon, Apr 19, 2021 at 11:00:57AM +0200, Peter Zijlstra wrote:
>> On Sat, Apr 17, 2021 at 09:35:07PM -0400, Joel Fernandes wrote:
> 
>>> Peter, any thoughts on this?
>>
>> Adding CGROUP_SHARE is not sufficient to close the hole against CLEAR.
>> So we either then have to 'tweak' the meaning of CLEAR or replace it
>> entirely, neither seem attractive.
>>
>>
>> I'd love to make some progress on all this.
> 
> Can I comment out CLEAR so we can sort that out later? I suppose people

I merely added CLEAR for completeness. Ultimately, I think having to kill a process because a cookie got set by mistake 
is bad, but it can absolutely be sorted out later.

-chrish
