Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDB3B80AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhF3KNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:13:45 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:64110 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhF3KNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:13:43 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UA9OZW016880;
        Wed, 30 Jun 2021 03:11:10 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-0064b401.pphosted.com with ESMTP id 39gf0u094r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 03:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPc4Ol2IG6OpPo7s+/XoQA0LUV8ES6nWKVKVfJSQyE2D4eQ4AuYuwtTyKeJ8bL8FHuwRiC1PbZQ2ABlz6LRVJcCounzCzuDgHO/yCpg7MrsPFBb5GzX0Y04mJGJuyHXmfXZFEZ3GHwMNPdntOLl1Nud7mAdUNbpFO04bS/UXaAdfehQrn26jzzYs1mmXzhqvRKOngvtzjTZ3cZ94Bf4S1hyLi3jUHOSXbi/Al6xlvMLSPAH+Ex8wp/jEMUpzOlTXJ3/MPWmGz31rbgrrJG/OSsR9gYCUNvb7QGbMqvZGj0IL7erdDjeFtDCRRRZRjpF7wjExzYVL07i9HnkUroatwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEq3hzSf0Srb/8hZUoKrtImp5tN4mbC7/0NtoN34zHY=;
 b=ULeAmIVmuP9PSUVugbAqZmYkoaYc4TebQK5fSER9ESlfrQAajq6gfJkA3D22DEaG9QCTQflYpIRFnxHFUAb+O/CBLgytamU4+InhSbLJhJujZtdSLZk86x6viv68i64KGgOAHiHBzTfgIzk6RNVO7xbTxBK96JSoDTNdWDIjfkJkOB9++67c80vFaDkKfIq4rqk3fXQsalRMVlKCUYtTHGk0t53FDO0AgQRjCnwUaMNJjoz+schdQW4pPGOWHn9rasyzURe9mm8kXQ4lDl0sEnSp41AapjsUsBcb2UNJTygHdz4f4Ny3+08F9z5G3YqUiqTew3ixoCPfE7OcT32sbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEq3hzSf0Srb/8hZUoKrtImp5tN4mbC7/0NtoN34zHY=;
 b=IijKvxIYMUWDS0YOUH5/j9fPZTODRg9OES9yneQJcHonl4xB4Ks3jBFMHwpr0Zfv7gZSMd3EOSEacmh1XaZ2dW2a+J13AD85beCNcfgv4Zy4YUR6GwEQ8zKn5JuHVI6bT7QHh7mSkUtDFS9tZL4btCCSLS505B8N8c1g4D7R8sU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4252.namprd11.prod.outlook.com (2603:10b6:5:201::26)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 10:11:07 +0000
Received: from DM6PR11MB4252.namprd11.prod.outlook.com
 ([fe80::c0f2:cf50:3404:90ac]) by DM6PR11MB4252.namprd11.prod.outlook.com
 ([fe80::c0f2:cf50:3404:90ac%3]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 10:11:07 +0000
Subject: Re: [PATCH v2] locking/mutex: Fix the handoff mechanism doesn't take
 effect
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20210630054224.13495-1-yanfei.xu@windriver.com>
Message-ID: <af83d70f-67ad-3480-9e03-e2363add1f31@windriver.com>
Date:   Wed, 30 Jun 2021 18:10:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210630054224.13495-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To DM6PR11MB4252.namprd11.prod.outlook.com
 (2603:10b6:5:201::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR03CA0110.apcprd03.prod.outlook.com (2603:1096:203:b0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 10:11:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f79b000-95a6-4b28-9320-08d93baf6052
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2249885CE54FB377DE67D3AEE4019@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xKPxSd+xuUMrwyPAUDfOoAV9b6FFuGBGO0vk5YjjKllYSFfhd/hP3PAiyo4LKADU+GhLuNkD7AFpBl8UAHPj1ho77yvVSJE7kKnUzQbgbwTub7hvmMeQeZDjowxqpJCpY6q2C4pmneKAzm9kLfsF6ek3qBI39PRC8dwY62RfVLa3XDPpPYa+F+7uLxEowC3Hmu3ulqgJAbtxynBuvfgBSLm1W9ekvF1F7TSux02QpZ28+VAN5a7l3P12OagnoPIpjy/OVie9Rw8ruAzm/we02pI3HrmE247kKlNqvq9CO6m5eohCeE6PrMVsjWiHEz2wTt62XaBwoYgeh+wl+53599bszcEQW+wnz1d1h+e/9hqPYbhv6CL92A5XIwdrcbp8PebXW99tX6pOcyKXMNW+G5v7dmxMpgB3FdGhxwpi+j3RhKqbbBI3b0htXPeuwHaZDPYYGMu+msEKIkCN+h9xm/97Gxy3bWIGP7ZsQkQdjiavEqCIfeL60lo1jvOhAvUccQ0rzV7U/jXI+rh4CTPvky/byg1iaSMHrXmE98Jyt0EmryUqFkfiF3oDaHC56zcbbAAr0/72rO9H9TLP2cK8HC2dWF8GAqjhEAMXv4ebreCuIgKIcEnkgI/tOLp5/sVYVWHVNxRN+nxt75pMbBIQHYjxmC/SFueHIRy6kJ6bQ9CIudXwVaQ5CPYYzoCuOatjOeUDZ+N/0uQOx7UkD4gdt0fNrCxggku5qdd+AigzlJFmDDWXZram2VH8HypgkjaRVyWA7prbwfKzWlfXdvubw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(136003)(346002)(396003)(376002)(6666004)(478600001)(6486002)(38350700002)(38100700002)(31686004)(83380400001)(86362001)(31696002)(2616005)(2906002)(316002)(16576012)(36756003)(5660300002)(8936002)(66946007)(26005)(8676002)(4326008)(66476007)(956004)(66556008)(52116002)(6706004)(53546011)(16526019)(186003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFUxajhnWG44bEI3Q1c5bjhyWmlzZnIxaEJ6SEdJYmNnTEVMNjJkZUJyTkFG?=
 =?utf-8?B?VDV2UEVLUmVYKy8zeUJFRTdnK0I2VGtsMktFRXBGZWJSQ1ZqNno4RGI0QzYv?=
 =?utf-8?B?L1ZjaStVcUc5a2VhN2JTcGdPYXRDWGU5T0l5QUxNckY1bjcyZnBnZEFZSG54?=
 =?utf-8?B?WThBUE5FK2s3dlpOR2ZQc0FpVHRtZ1RBNWRWMGZtbDFkWjNwME5ET0FLNWxK?=
 =?utf-8?B?NGcvQ3hWRThIbDFUd0FuM28yQy9aUkQvYkhRTHlDcThPUGtTZ3NSRHI2K3Ja?=
 =?utf-8?B?SlJTVnBXdGZGYW1zWENJaEFodmlPMk8vZEttNzZvLzFRWnJqcmJreVV2c2tZ?=
 =?utf-8?B?OFBwKzZmeXZGNTJSYXo3cDdXTVFNTXpTejV5L2tFckpralNuN25pVWhaSTlG?=
 =?utf-8?B?V25nWTVMWjA2cDB2azhYZWV6RGNEMkRqUjR0ajNjb3RQdDFSS3hhbnpXQjF4?=
 =?utf-8?B?M0dobjVTR1FSNTRCTVBTeFc4U1RJQ3NoWDJmNzZGS2ExbXd2NXdYRVlDL1BK?=
 =?utf-8?B?OWR0QlZCQTZJU2hJbHMwc0RZSVBOeTUzVjc1c0pqaFpYZVlEUmNWbDdqMFBK?=
 =?utf-8?B?RXA0b3lRcG55cnNZLzBmUHZ6VHhDZk9WbVdwV1k4VDkxbHhsOFBDNTd6U2lS?=
 =?utf-8?B?VCtvMHc1OFNMbU5ZejlBNVNpMWRLa3FhOFNvbmtydUFLa1R0blJOU21kYjB4?=
 =?utf-8?B?bkN6MUJBQmV0RCtVaUlqaUhycVlrYmNDSHFIZmozK2Y1QUpTelh5dXIvUE5J?=
 =?utf-8?B?K0tBMzFtWFN5dzdRY0hxYVBmZXhhYW1CTEFWZ01GekhidEZ5RnZndWV0RDk1?=
 =?utf-8?B?ZFl2SUV4K2tKWHVuc09CZU1iZmFyZDQ2djMxQUt6S3RXR2lxVk1ndVhhcVQ1?=
 =?utf-8?B?bGFiUG1Na1pqLy9yTnA1eDkxdWlNOEhybHY0RkpIYnBqSGhCaEtOOUlFUmdW?=
 =?utf-8?B?cEJ6aUhCT0daM1FBdS9qbFk5WjlwVTg4Qk5hQUtEYlA5dE05MGhlUmJHYzJo?=
 =?utf-8?B?SFNZVVBwVGZFRjA1dFc5ak9jbk5mWithVVhmNTJFTjBVSERORFpYMFE1dVJJ?=
 =?utf-8?B?UWdrcHRrODFodjNSTmh5S3Z2djRPMjc3Q0Vla1E0SkU1SHN1TG9oWHhpNm81?=
 =?utf-8?B?UnY0TityelFpL0ZobE9RR21EaVg1UkpLbXlHS1ZXMlFQWTByVlRkaGpQVUlM?=
 =?utf-8?B?ZklJWUg0Uy9UTnNOa0N3T3MxVzh4WDBBaWNVcmhVQ2hJZGlxV2ZKVGtEYzNi?=
 =?utf-8?B?RkVlTTB6OS9TRGRNa2FlM0ZtN2RMbUJFbEhLWmgvbVhHdHRnMjZxbXVCOFg4?=
 =?utf-8?B?b1ZONnl1VC9XaWdQMFNQbDJsQk13UElNRDBCWEc2S0IyR2hmTUpoS3ZSTG9z?=
 =?utf-8?B?UDMzempzc3pId3F0VTV5dkpKLzFGUHFvdlg2MERFTzJQeitEbjNEZnNrTHpK?=
 =?utf-8?B?YnhzUyt1UjIvTzNBa01QMy9nUk1LZFJDYlVmRG1WOFo1VVBhZU9xWkhVSThL?=
 =?utf-8?B?dXlYRVovemVKQXIxejFOenNweS8vZTBkaWFIa20zQnhxNFE2NUYzTTJZVGQx?=
 =?utf-8?B?UTMrYktKRHpvYmhmYk9ZR0lQczFobHBsTi9sRndwSS95UFYwUGhkcEo1R1cr?=
 =?utf-8?B?Vm5SdE00TzE4amNsOUlVQlQ3b3cxOElZWnZxRnVNUEEyOUtFRXpWNEEwaytT?=
 =?utf-8?B?UU1WbVJiYjZxc2xHTkZhNU5xMGFnWi9rUGxtR21aQVZMazJGcURDN1oyU1Zv?=
 =?utf-8?Q?aF0O3EjnFcEeCQZVflGcm1ChUKZqJwU9Xj6ltMp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f79b000-95a6-4b28-9320-08d93baf6052
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 10:11:07.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfjWJvtfN9wFMoKslUuEUvRl3KNPVfQtwwMBV98ltgeiTUCsdaHwKMz/JpfHXNWzsmermtjLo27xtl11Wb1Qrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
X-Proofpoint-GUID: AVxogsaG-wSYUHxuiaIhU4LGwAC2Yu-n
X-Proofpoint-ORIG-GUID: AVxogsaG-wSYUHxuiaIhU4LGwAC2Yu-n
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_02:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this.

Thanks,
Yanfei

On 6/30/21 1:42 PM, Yanfei Xu wrote:
> Commit e274795ea7b7 ("locking/mutex: Fix mutex handoff") removes the
> judgment of "handoff" in __mutex_trylock_or_owner() as blow, it makes
> anyone can clear MUTEX_FLAG_HANDOFF bit when it gets the lock, even it
> is the stealing lock. That makes set of MUTEX_FLAG_HANDOFF by the
> top-waiter in vain.
> 
> -               if (handoff)
> -                       flags &= ~MUTEX_FLAG_HANDOFF;
> +               flags &= ~MUTEX_FLAG_HANDOFF;
> 
> We could fix it by setting MUTEX_FLAG_HANDOFF bit before the top-waiter
> in wait_list falls asleep, then It must can grab the lock after being
> woken up. Instead of probably being stolen lock by a optimistic spinner,
> and being cleared MUTEX_FLAG_HANDOFF bit by the task which stole the lock,
> and probably fall to sleep again without MUTEX_FLAG_HANDOFF due to the
> task which stole the lock falls asleep.
> 
> Note: there still is a very small window that the top-waiter can't get
> the lock after being awoken because no MUTEX_FLAG_HANDOFF bit is observed
> in unlock path and then wake up the top-waiter. But it doesn't matter,
> the top-waiter will optimistically spin on the lock or fall asleep with
> MUTEX_FLAG_HANDOFF bit again.
> 
> Also correct a obsolete comment in __mutex_trylock_or_owner().
> 
> Fixes: e274795ea7b7 ("locking/mutex: Fix mutex handoff")
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
> v1->v2:
> 1. Bring the assignment of "first" variable to the front of
>     schedule_preempt_disabled() to make the top-waiter can grab the
>     lock when it wakes up for the first time.
> 2. Correct the comments in __mutex_trylock_or_owner by Waiman.
> 3. Rename this patch name form "locking/mutex: fix the
>     MUTEX_FLAG_HANDOFF bit is cleared unexpected" to "locking/mutex: Fix
>     the handoff mechanism doesn't take effect"
> 
>   kernel/locking/mutex.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 013e1b08a1bf..ba36d93e65e8 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -118,9 +118,9 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
>   		}
>   
>   		/*
> -		 * We set the HANDOFF bit, we must make sure it doesn't live
> -		 * past the point where we acquire it. This would be possible
> -		 * if we (accidentally) set the bit on an unlocked mutex.
> +		 * Always clear the HANDOFF bit before acquiring the lock.
> +		 * Note that if the bit is accidentally set on an unlocked
> +		 * mutex, anyone can acquire it.
>   		 */
>   		flags &= ~MUTEX_FLAG_HANDOFF;
>   
> @@ -1033,17 +1033,17 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   		}
>   
>   		spin_unlock(&lock->wait_lock);
> -		schedule_preempt_disabled();
>   
>   		/*
>   		 * ww_mutex needs to always recheck its position since its waiter
>   		 * list is not FIFO ordered.
>   		 */
> -		if (ww_ctx || !first) {
> +		if (ww_ctx || !first)
>   			first = __mutex_waiter_is_first(lock, &waiter);
> -			if (first)
> -				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
> -		}
> +		if (first)
> +			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
> +
> +		schedule_preempt_disabled();
>   
>   		set_current_state(state);
>   		/*
> 
