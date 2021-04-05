Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17B2354820
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhDEVXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 17:23:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46478 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhDEVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:23:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135LEDHH167331;
        Mon, 5 Apr 2021 21:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UtHfavI9v5Lxf4s+9ihYnhOf7Hs5ynvEV1X4ndWpAMw=;
 b=uf9SVkEo10EnURRRzQ8YLUzUzQoNN2BU7SIdD5mYH8qLEBHg35fVhbOlfP8SCaqH9Jnr
 wMbXTkDuq4frTibYSHpe6azoPIFiFu1apdohAWcL37DosajLa6k9UAENANHmNp4PCmpU
 qJK0X5gpmnNT2BS6j7gVHFEzEAelt/kNehDpAop7ayB4VsGvP80SYqpObcbPttWIsB34
 ZsUA/X69UAY53k6kd3Y9i8vg3Ylw/c5ddJGisbWHfL7QSqiniU/beTJTZD9KRrGMeIEU
 lld1omDVUxC84DS+wf80ody7edQSHlaLN79trnmCQPBW5CdMNrW15Yi7enKOLSTJ0Xg2 rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37q3bwkdy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 21:22:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135LFDUs107092;
        Mon, 5 Apr 2021 21:22:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 37q2pwqht9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 21:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjEOtMKUwQSrOVbbPsTbnzA5OSeGMoyMrgpZbNBwvop/KX+JeNzUHvel/5xmNO4i/96xkadGygW3viGLdvxT2gJHGGbnH+aWIjFpLhHtgJEQXhX0q8oO1uwD9bKBRZCPCRXiy426yomMATYAeZE7LfQ7xx2TfLQF85hVfbrcJqaC6n5xjRrfri10/3oVYQZVbz1XLJksCNKXGKm61VHNF6ZiGCIamqaMDOJwsiZbwbJFPfh/UErxGBPDDSMGRHgGkQODmvcVPpKnSdmjaph7efTq44c9vbu9IcncNeKHwrq0bDJ/+exnSxY/cbnoi4C7m9J68i5hm/QMOx0BAKcINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtHfavI9v5Lxf4s+9ihYnhOf7Hs5ynvEV1X4ndWpAMw=;
 b=RdLorjHTi7sUf+Vjpkuyv79Jad8AMDGVivFFK52zfxqhJbBFmBxxCWeZfjrAEbX10UhU7cJOsroh6qp3EAIK9KYminpp1MQBALH2tnBd3L4GoDjhcGnf2MoQ1TthbtfNjQtjRkl1uPiLjdATBTEE8IWJFhOb4Y5R37WlCFSw9IzcG3kFx5RyU7anyaLUSUdQOxoRh+koH0/aG5DuRgVub3qdCu8AJp//+cqFzYiCgKm0fcRg0DD+eQyCH6aPR2Qjr+bj0s1NREVx0COIIxrsdfFavmbw97T1bapZHjjA5duZiq9PL5NeSqVlmeOs+5+SDr6MHWlY7UkAKQhwUrGfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtHfavI9v5Lxf4s+9ihYnhOf7Hs5ynvEV1X4ndWpAMw=;
 b=ZdIurJb3WlqKO/RJeYggX6I7QwNDumH8SN3Tf7ZQeYXQA6cGsB00cORSXO2bWTzvBA6Jl3cSHJS8DpTEfO7uR2xhYmumyzjO/2+5UdCeH+m8RTCePpcgxxIJ+m2hb4d2ew5n3uYPCMta9m8Jfl9EjGBbaIArvzl53dqeeScmax0=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB2774.namprd10.prod.outlook.com (2603:10b6:a03:8b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 21:22:04 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 21:22:04 +0000
Subject: Re: [PATCH RFC 1/1] kernel/cpu: to track which CPUHP callback is
 failed
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, qais.yousef@arm.com, peterz@infradead.org,
        mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com, ethp@qq.com,
        npiggin@gmail.com, joe.jin@oracle.com
References: <20210310070837.17674-1-dongli.zhang@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <40a7be6b-0603-a2ab-afaa-339e88a03210@oracle.com>
Date:   Mon, 5 Apr 2021 14:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210310070837.17674-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2601:646:c303:6700::d22a]
X-ClientProxiedBy: SN6PR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:805:66::48) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:646:c303:6700::d22a] (2601:646:c303:6700::d22a) by SN6PR08CA0035.namprd08.prod.outlook.com (2603:10b6:805:66::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Mon, 5 Apr 2021 21:22:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1579f616-bf0c-49c0-87d7-08d8f878dbb2
X-MS-TrafficTypeDiagnostic: BYAPR10MB2774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB277492B22A5A5ABA0C464A5CF0779@BYAPR10MB2774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9BVQKfQK//1z1wNvZ/EBopwR9+22imqwMZvB4c+xabl53q+2BoW64eEQgSbAUeVEeKgwBsIMWsAC6H94putbhJVZZWpdFw2FcgiBlT28rAt5R69HjAziYNmT9YpwqhbePl6tQgQYM9GldlMf7dFgQt2vzVsGWLZxDs9VFoeAyQGh2D+MCdImc3pDQu1NagBLwLEk8A2kL5NoQ/lSctpqsJVCGvqS6pzynAtsniX4ppGUyanK6rei9z96WF0ZWFYIYyU1xgX3ozSLHZ2S2sMtj7Nn4DBD7Xr1LU+ur83wxRe/7DW7s0ssHFIqDej94CKJPGCoHXWAqdYSVlL3mMVUbSX3UWrK44jGXQO2xL4k4wofz1LPLD5lOvsi8E5Xpa9bxeWc4CS0H9fYc3PKOgZl26+9mmGI40Y6EfMJB0qbPgtrEs9T7vKjvvIj0jzlfqQdjASmH0Jo0yZql4XgstipeZNrdfIJQhlNGLP6UqA1YT37FsUz146lrabBPp8waKQtPsXp5DrDihvyaeVcJT0O6tZLGj5203vzns7vpITJnXWIpBopCSL0l8rB+jUUVDFclDyulAqfAoWt6l5AcUxhTsCOCH5pUo6jvc5L0ki1OvzfySEZ4zHc8tv1B375nyCwRXGZqOi22XfSpkQu2c6rmUltmu+/FPeXQ5DOeFtON3U3Ym1YcCAYlFoS73EcEEjifrJwNKRyYhGst8eHJlclGkZ/7APPen1/SqxBVlNEIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(136003)(366004)(2616005)(31696002)(107886003)(6916009)(8676002)(5660300002)(66946007)(6486002)(36756003)(66476007)(66556008)(8936002)(86362001)(2906002)(83380400001)(38100700001)(16526019)(186003)(316002)(4326008)(44832011)(31686004)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0tmcTZyaGpROGFoRDFhUFBiRVRDOHlWRTZNZmJjYW4yTkkvSDlBQzN3TDcx?=
 =?utf-8?B?Y0xqT0h1c3V4YldHTW1JU0l1ZEVKVmxFWFlIU1FWQURYeEtsb3FwQ055U1Rz?=
 =?utf-8?B?THExazNsanpCVS9mOE1Od1BKMlRkTUk3NGVTMjJhRTJvZFpiaFNlV0ZRTmIv?=
 =?utf-8?B?K2V0RlVlcWlvT1NaMjBadTByOGl1dWVDUUlpamNQMGFqSVRXT1JzNTA2UUFk?=
 =?utf-8?B?bTNadm9Kb1V0WkVwYi9FUUVJZlRBVWhlZjZHbGllSW5naGpjTkNCMFlwa2tT?=
 =?utf-8?B?clZJcjRkUWI4RUNleGlETWx0cXQwbW1sUEtWZGFqb3Zrck1YL0FZVHBYL3Nk?=
 =?utf-8?B?ZFFRai9VeUNUSFZrTmZzaGdoNHVIRlpNUDBBeGRiL1pDWm41cUl2dmt0ZFFj?=
 =?utf-8?B?T0RiQ0JDalFIU3RTMjQ0VzAwZWc5bGVDeldZVWFKemxoWGlPeEs5SEt4OGNL?=
 =?utf-8?B?ak1yOGoxS2F2YW0rTVgzbkpEMERIZU92cGFNWlJIWXhPWGdSaWpYTXZlKzk0?=
 =?utf-8?B?ejlPK0F0Nk1XbFkrYkwrWU56TWN4eFE4a3Q0TzFabHFxVGo4QkFQWWZ3RHZS?=
 =?utf-8?B?LzA3dTQxblNsMTgzZnBzK2h0SVNoblBtakdSNzVzMHJHeVJhM1R0UzdYMnU0?=
 =?utf-8?B?OHk1TFpZV2EydkdKRDJtRUQ3VDVEUFZpWVRjY3ZSSlpJWUVMZ0N4ZVdIeGdv?=
 =?utf-8?B?dnl3WGMrRE1URW1SNUQzTjZXTE5iL1U5YUFiRVQ2MVNydkhpU0RWN3hOd0Vk?=
 =?utf-8?B?eXp5ME0vZ1N4YmkzK1B2SlVvdHpNeGZhOVNTYlVJck5KaHc5aFV6MDUrQTk2?=
 =?utf-8?B?VEx0Ri8xSlhPMHFmT1R5emphMFF3cWo0WklSbVBZNW9sdE9HREdzNWpwL09r?=
 =?utf-8?B?WjFmY1NMdDd3T3lGSUUxNS9sY2hxc2dkUWZSanRBcDBoaERHV05sTk1LQVpp?=
 =?utf-8?B?VG5NSDNtdnU3Q0cyVHpKVkpCdXR5MSt5WnIzbFRUTHdKUnUzRmhOektTVFdU?=
 =?utf-8?B?WGJlNmw3ZE1LL1pQWkNuVGxuSWk2TVdxSnd6aTh6VlFBYkNBb0xwbmZ6S0I3?=
 =?utf-8?B?OVN0NUpocU5pUmMrZzJxTVNYYUtCNHhKdWEyWVdoS04xK3N0bXhsZElPNVRh?=
 =?utf-8?B?MGVHbDVSYlFMQ2JMZUFpcXlNWGpvalU2Nm9WcUNabUJCVzU5WFEvRkE1WFB2?=
 =?utf-8?B?eUZFZnRLcm9hZ1ZlNkRhME5hTytSdEV5Yk02TDA3bTJTaTEvSWpBendMZ251?=
 =?utf-8?B?OE5lcngrZXZBTFhObEdLbTl0aThGMXRFalg4cW95WTh3ZWFHbG02V001YSt2?=
 =?utf-8?B?THpPNkkxV1oxU0doZ2lSa2FWYXZFdnJCdmE2b3dZN1gwZHlsbGErMTVhdTFi?=
 =?utf-8?B?dkRrVFpVV0JOK3pJZTNSaWx3bDRCcnlWejF1dHI3TXMzd0xaZE0wR09SbGg0?=
 =?utf-8?B?b3BrS2d4Qmo0TDZIallmTy8zWnVHUVJoelplWUVLV3ZFUWpmN0FOTmsveFdR?=
 =?utf-8?B?ZlRNVCs2a1ozLzIvNHpWWGFCZ3gySmtmb1l4TXFhRVlEMkJ6MnBEM1dWWEJP?=
 =?utf-8?B?M0kwYllIZEQ5a2k5K3dtSFNJajlFYWdaV0gyK1NpeXlwbWd6K3NPdVkzSjU5?=
 =?utf-8?B?VXJ3M3dQMjl0WE1OckFkdXFiMjRxM2hPRW1ONGE0dkhvYUd4Yno2OUVLb1dZ?=
 =?utf-8?B?MGUyWFRqZHE2MnBTY3FpVDVRYjN0N0IzUFdicURjQzhpOUtsNUFoeWd5cjEz?=
 =?utf-8?B?dkRqWXR6ZzlDbWFUWUU5N1ZmYnVTbENCaGVoajRNa3VUN0xYTWNISHB2K1Ji?=
 =?utf-8?Q?8q6EbZuKApt2kPAfcPYXcmvRFBnwff3ux/vG8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1579f616-bf0c-49c0-87d7-08d8f878dbb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 21:22:04.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozZ4ZMzGwHjf1BbhiOp0XfzcOSGu9krHipIe1rkEwz/kVagC2d3ZIWCWBkOwJcO7o6ij8EyR1xPnKq/giTDSHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2774
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050141
X-Proofpoint-GUID: XVzs1pRuXbAYk19ni3RqeXfaYmANrshp
X-Proofpoint-ORIG-GUID: XVzs1pRuXbAYk19ni3RqeXfaYmANrshp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I have if there is any feedback on this? To pr_err_once() here helps narrow
down what is the root cause of cpu online failure.


The issue fixed by d7eb79c6290c ("KVM: kvmclock: Fix vCPUs > 64 can't be
online/hotpluged") is able to demonstrate how this pr_err_once() helps.

Due to VM kernel issue, at most 64 VCPUs can online if host clocksource is
switched to hpet.

# echo hpet > /sys/devices/system/clocksource/clocksource0/current_clocksource


By default, we have no idea why only 64 out of 100 VCPUs are online in VM. We
need to customize kernel to debug why some CPUs are not able to online.


We will have below and know the root cause is with kvmclock, if we add the
pr_err_once().

[    0.693112] CPUHP callback failure (-12) for cpu 64 at kvmclock:setup_percpu (66)

Thank you very much!

Dongli Zhang


On 3/9/21 11:08 PM, Dongli Zhang wrote:
> During bootup or cpu hotplug, the cpuhp_up_callbacks() calls many CPUHP
> callbacks (e.g., perf, mm, workqueue, RCU, kvmclock and more) for each
> cpu to online. It may roll back to its previous state if any of
> callbacks is failed. As a result, the user will not be able to know
> which callback is failed and usually the only symptom is cpu online
> failure.
> 
> The error log is printed for once to have confirm which callback is
> failed.
> 
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> I used 'RFC' because WARN_ON_ONCE() is always used for the result from
> cpuhp_invoke_callback(). I would prefer to get feedback from
> maintainers/reviewers. Here I prefer to print the cpuhp name and state
> value to help confirm the specific callback that is failed.
> 
>  kernel/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 1b6302ecbabe..c7a719079272 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -621,6 +621,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
>  		st->state++;
>  		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
>  		if (ret) {
> +			pr_err_once("CPUHP callback failure (%d) for cpu %u at %s (%d)\n",
> +				    ret, cpu, cpuhp_get_step(st->state)->name,
> +				    st->state);
> +
>  			if (can_rollback_cpu(st)) {
>  				st->target = prev_state;
>  				undo_cpu_up(cpu, st);
> 
