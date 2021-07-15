Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36343C9ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhGOIrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:47:46 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:16660 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhGOIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:47:44 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F8ib27002039;
        Thu, 15 Jul 2021 08:44:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 39tcr8g5cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 08:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOoRjWXC1NSeC/LnWR0WoXhz8TQSh0bFqM4YV4W0PZMUrVry/9fNjTx8m8Nt0mvnhCFU2BbxXEAp1T4cQO+IJIVS0ozc8gN2y46gen/p/+u/kTqyzht6NCokPvFEpcaqk7T4nddgWOFYXLvCMwingu3BxkaKWUAMqOBTLkvCeqJZD1HiGXZx1hrNGMbgoA61133KwuGqqnuWtPXoF4AveNm718a0hCbhZZQLeXqFZ6Lgkk4zvWE0tcecizS03gRecLKWxYRLiVcV266Jq0RW+xm1Ut/TN1g2yyAxmq9PQes9KYXLqV1YFtEmcntpJJ9GMyMFsyihC2eXJWDBqgVcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9n/V9wnYxo0IoGmC+JzFfD/TYQOlEgjdEM4iNsr6kA=;
 b=EpgE6Jh2nBcYeOikEw59lfTcYh/5kA8PfVJHsKUs9XYDq2XKQXmH9F+SFikGbHvOnm4iT8PQxV9zzTOcI2iF4j7qKgUYs3zg+d49ntbnKkMDHqK/83wXEvQ4LVlR8h0MhaTtveiq7NdzsE/mJa0j2wprnVGiFKkXE5hcr8RATkEHirN+0TX3hWYTW6vz/px9H1pToggxx7J3ZME28CRPHUNCiId7lvriICg54UTirY93RNFOCBlO1yN9IXkmA8e4tD/fxBfrBg7BN+0g6WAKpJetx7pxC8IpLKrXWj71qHmDQbJzL2M7iwSbVWkmlup0DYWXtKw6lRfxFyYBcdTxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9n/V9wnYxo0IoGmC+JzFfD/TYQOlEgjdEM4iNsr6kA=;
 b=VKN8awfy+l9v0Dfg4D4b9RWguUrwXUJ2y35HszEVD2dwaslRUJ8ccn9B+22wl6XWEpPiq/TwLaEg5+eimudVZUfiYEyPqkPdn39MrYQeNFxXE47dG5wfGdANa5XcbKxIYMWmiHzGnpJswXoK+fROWomliGVqENKrrqzRasMMwxo=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) by
 DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Thu, 15 Jul 2021 08:44:33 +0000
Received: from DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f]) by DM8PR11MB5637.namprd11.prod.outlook.com
 ([fe80::e172:8ec5:1d86:844f%9]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 08:44:33 +0000
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <ab85cd9e-f389-0641-8084-cdfbc5c91e0b@windriver.com>
Date:   Thu, 15 Jul 2021 16:44:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a56ddd50-2cd1-f16e-5180-5232c449fbd0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To DM8PR11MB5637.namprd11.prod.outlook.com
 (2603:10b6:8:33::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK0PR01CA0054.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:44:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 037694f2-1574-406f-51e2-08d9476cc4c4
X-MS-TrafficTypeDiagnostic: DM8PR11MB5670:
X-Microsoft-Antispam-PRVS: <DM8PR11MB5670FA8E60602C8895E003268F129@DM8PR11MB5670.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aydHkZ1uT57gI+PE0Gu0qPoQiQw1P+yXW1G3QGLPZUUSSBT1T+APvR9MUaRnLmvxH6P+UIl6AyE9O1xu+Z9cN51k7cDQB2bsHPaZzaxzGlvx25gU+7wpybLzKstCIRBnpzRUw8/fLDBFW0McB7dKEAwZqYksCaUjY2ugWMm+RqffRxpqFgwPwq8eCFUHjDnRds0VzUyENAuTR9n1mQQZsuZ7yUxMmHn1qGK8fTi2StFbbX2hzf9VQFeesfPz09MU2v7KIahdmWiNQ/kvgcDxDNQOcBOgU3yUcZZ/hax9KzWFzj0ft++C5mfPR9DVSjIOYmAitzvduMeK28BagVqPDdeTDfbULwxObxTMe4/HMa8KElkjWk46w8ae2u/HY98lB+HRLzwXndRY+jA2ruJDUwlRRfpe2OMFmXhbvipI3NlkiHM2pBswDO+nWUZuPi4s700BYPSdCDDx/jurzv1IqM1gRGl7S9/+iiGoblUpI8X+6AiZ3WLB6nt0BIwmId7AEagW+DwZ5FNDfySURPiXePag0k1vtqrR/zAYM7jXuX5z4UyTpFHrhoiBqwbBBoWtxakCW9oLBgFZy+fsc6oevTsDjJVWNOLw4sgMdRkL2IJZfsXFHht8A58EHpVymDVASiwYZm/2NzOIBe/Ja2iYkJB16/cz1isdOuY40KRQ4jawHhmPqFGfetefL6FuUqsAp+sMx4E8ivVpPgzhtVTclo0zfEriDW4TjpyAAIJtqng6/yMIvsvGwZMeJrk8bj0VG8R4dxsvLIPbkAd9kb4AYqQLURAnRpGlZyEH7HwhjmvBYQdauSM8ZG0d+1d35vjz1eWkB4vRYSdUDBXT2WLNzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5637.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(366004)(396003)(376002)(136003)(346002)(8676002)(8936002)(316002)(16576012)(36756003)(83380400001)(2906002)(53546011)(52116002)(54906003)(31696002)(6706004)(956004)(2616005)(38100700002)(26005)(6486002)(186003)(966005)(478600001)(66476007)(66946007)(38350700002)(6666004)(86362001)(31686004)(66556008)(110136005)(5660300002)(4326008)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0E5L2JnNDJQbUdxRzVLVjRkOUsxS1dOdXFhZ3ZKTHRyMXhMelNCbHg4V0Ew?=
 =?utf-8?B?NUsrdzBiUU9QYURHRmNzN0t0UnFXS2hSZHlUUndocm0raUlvdi9VVEc2WGEr?=
 =?utf-8?B?SDhrdnZUQU92TWJPSXIrYktOY0lVTHNBbnEvcHpCQi9jMXRYYlk5QitkK0Vo?=
 =?utf-8?B?WW9jOGFoRzlDQ3lnbVQ2Q1pRVjBOYmNvZUdQbndNN3ZEdUNIcDIvUmNDS3pX?=
 =?utf-8?B?Y21DRU1yR3NrbWo5RlVoQThCZlZZVlVMOVFCNlR5MERJR3ZqS0pUNDRqTG5T?=
 =?utf-8?B?OEtVbGp5V0xBUUNDQ05WTm1oV3BQWm5icCthdno4TTlzMnNWSmtTVWZzaVpq?=
 =?utf-8?B?bmYvRDBRRUFpaXZHdHByLzZjUURJVk9BUVhLWU5QZWtwZVA4bURleHBhcEN1?=
 =?utf-8?B?OWJsRnA1WVBsMXc0S0RiUlc3SnF3cjVVQ1BSRWtIdWNxRDUrZkNxUkJwWElV?=
 =?utf-8?B?cFhqeWFGMXltOThPNVQxTlFoVzBPNTh4b0ZtUVMxaklSakRaT2h3Vjk1MTIz?=
 =?utf-8?B?WUJMMDJScDFoaWpSd2paYzJwNlAzRndMakhBQW9FWmwxVXJNRmF0S01QMVhG?=
 =?utf-8?B?dUFiRjJYdVRUOVR5N0dSTFk2NWJnNXllU0daSkxkWHc2QVd2elYzRWxuc2g3?=
 =?utf-8?B?YjFJSmVHeUh6ckpPVitCWnVaMG5aUkFtckEzM2ZZYXhBODJua2N1aElqMGNw?=
 =?utf-8?B?ZnJ5WWZiclRlZ2hqVDRpaGxBb29SU05CWGVMNVZVakpUa3BTc0lFYWdSa3do?=
 =?utf-8?B?a1NiZmdkVEM1ZmFMMGwrTGM5aHdqREFCSTY1K0xaTFhJcWlxY3FleDhnN2F4?=
 =?utf-8?B?R1dBSmZBMWJvbFhEanR3V0FTZmdJQk1aSWNFbU5BUzdHQ1RRcHBkaGt6TFR3?=
 =?utf-8?B?bFZCL29CM29qNDhlaE1lWVUwYjVnbytKamRVVHhqUmFnVTN4NXB6TG9IMU1v?=
 =?utf-8?B?QXNwVEE5NkNadFk1ZkVUSmRGTVpOcVQ5NS8vZXRlcFRLcDlWTENWYnJJcHVy?=
 =?utf-8?B?OWlBRnZPVWNCZFdVS2tKN3puYk5Od0tsL2Rtb1c5STdrZzJ6RS9UR0hzcGx2?=
 =?utf-8?B?UEJTMHdLN0piMHpudERQVkRmbXA3d2Z2amcraStETXFTTE1pcit6bkVXUjVV?=
 =?utf-8?B?bi82VmoxWEpkK2xlN1Zvci9URitCYVMzRVFKMXlITk9pcm9OTXI3eTJ6M0I0?=
 =?utf-8?B?WmVwTVVVNGY4Y1JSbC95amN0VGUzYTJvSTNkV3JTREhRMjF0NXM3K0g0TDJC?=
 =?utf-8?B?QVd2YmVrWDMybHFCM05Jc0dUQmJTc2grVnl1cCtoajIwVzNMeG1wc01ndUdN?=
 =?utf-8?B?NnlDcjRMM001ODZNYjFjUHlsLzZqYjlhKzBWdk9LVDBvQk94dWJDTFROUmhw?=
 =?utf-8?B?eUtUWDQwZjBiVHZxYTRIcElpemhGaHRUYU9YTVBrdTZ3VWhvODdqWHo1c3Jz?=
 =?utf-8?B?WEVMT3RxU252SUtUdXdmK0JvUW54bGVONmhkQVBMV3FRbm9Rck45ZUhnUWJ2?=
 =?utf-8?B?M1ppWUh5M1NVQXorVVFlZGJRaWx2OUp1QlZ1RWt5Vk5yWnZJTWRidE9XOG9i?=
 =?utf-8?B?VXJ0bk5rV0t4MnhmNmVpaWprbzRNY2NCWFFyZkxwVjIreDArMU9CYzk2S2gw?=
 =?utf-8?B?c20zaFJIM3dwTUZLcVEwdm8zd1FJTm5sZExPZmNTR1VEWnRVdEFsU1hPMkgy?=
 =?utf-8?B?Qk5CRkRQb1drZi9OQWw4RzNOMis4eDJncEZ6M093ZzJLTEx6U3MvVThxamlz?=
 =?utf-8?Q?NPnOXWNY/WjCSD/ITj/00Y+seS7oMFbeH5LcIt4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037694f2-1574-406f-51e2-08d9476cc4c4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5637.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:44:33.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3Gkpd88W2iCgu99mgBBPGF+grFnHC2NghzFvok7QIXJDB2SVKTmVKB0r9dAdCGqbHHYqUnAlexi+bHiPdR8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-Proofpoint-GUID: 3almBjcQaxbLuE-U7-2_yy4Ju-jnN_i8
X-Proofpoint-ORIG-GUID: 3almBjcQaxbLuE-U7-2_yy4Ju-jnN_i8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_04:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/21 4:22 PM, Daniel Bristot de Oliveira wrote:
> On 7/14/21 12:35 PM, Paolo Bonzini wrote:
>> On 14/07/21 11:23, Jason Wang wrote:
>>>> This was added in 2020, so it's unlikely to be the direct cause of the
>>>> change.  What is a known-good version for the host?
>>>>
>>>> Since it is not KVM stuff, I'm CCing Michael and Jason.
>>> I think this can be probably fixed here:
>>>
>>> https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
>> That seems wrong; in particular it wouldn't protect against AB/BA deadlocks.
>> In fact, the bug is with the locking; the code assumes that
>> spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
>> increments and decrements the percpu variable inside the critical section.
>>
>> This obviously does not fly with PREEMPT_RT; the right fix should be
>> using a local_lock.  Something like this (untested!!):
> the lock needs to be per-pcu... but so far, so good. I will continue using the
> system in the next days to see if it blows on another way.

The original patch was created before preempt-rt was fully introduced into
mainline. It was to increase the recursion depth to 2 so that vhost_worker and
kvm_vcpu_ioctl syscall could work in parallel, as shown in the original commit
log.

So the event_fd_recursion.count should still be 2 to fix the original issue,
no matter how locks would be tweaked accordingly.

Zhe

>
> The patch looks like this now:
>
> ------------------------- 8< ---------------------
> Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
>
> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
> non-preemptable and therefore increments and decrements the percpu
> variable inside the critical section.
>
> This obviously does not fly with PREEMPT_RT. If eventfd_signal is
> preempted and an unrelated thread calls eventfd_signal, the result is
> a spurious WARN. To avoid this, protect the percpu variable with a
> local_lock.
>
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Cc: stable@vger.kernel.org
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  fs/eventfd.c            | 27 ++++++++++++++++++++++-----
>  include/linux/eventfd.h |  7 +------
>  2 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..9754fcd38690 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -12,6 +12,7 @@
>  #include <linux/fs.h>
>  #include <linux/sched/signal.h>
>  #include <linux/kernel.h>
> +#include <linux/local_lock.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
> @@ -25,8 +26,6 @@
>  #include <linux/idr.h>
>  #include <linux/uio.h>
>
> -DEFINE_PER_CPU(int, eventfd_wake_count);
> -
>  static DEFINE_IDA(eventfd_ida);
>
>  struct eventfd_ctx {
> @@ -45,6 +44,20 @@ struct eventfd_ctx {
>  	int id;
>  };
>
> +struct event_fd_recursion {
> +	local_lock_t lock;
> +	int count;
> +};
> +
> +static DEFINE_PER_CPU(struct event_fd_recursion, event_fd_recursion) = {
> +	.lock = INIT_LOCAL_LOCK(lock),
> +};
> +
> +bool eventfd_signal_count(void)
> +{
> +	return this_cpu_read(event_fd_recursion.count);
> +}
> +
>  /**
>   * eventfd_signal - Adds @n to the eventfd counter.
>   * @ctx: [in] Pointer to the eventfd context.
> @@ -71,18 +84,22 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>  	 * it returns true, the eventfd_signal() call should be deferred to a
>  	 * safe context.
>  	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	local_lock(&event_fd_recursion.lock);
> +	if (WARN_ON_ONCE(this_cpu_read(event_fd_recursion.count))) {
> +		local_unlock(&event_fd_recursion.lock);
>  		return 0;
> +	}
>
>  	spin_lock_irqsave(&ctx->wqh.lock, flags);
> -	this_cpu_inc(eventfd_wake_count);
> +	this_cpu_inc(event_fd_recursion.count);
>  	if (ULLONG_MAX - ctx->count < n)
>  		n = ULLONG_MAX - ctx->count;
>  	ctx->count += n;
>  	if (waitqueue_active(&ctx->wqh))
>  		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -	this_cpu_dec(eventfd_wake_count);
> +	this_cpu_dec(event_fd_recursion.count);
>  	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +	local_unlock(&event_fd_recursion.lock);
>
>  	return n;
>  }
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index fa0a524baed0..ca89d6c409c1 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -43,12 +43,7 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
> wait_queue_entry_t *w
>  				  __u64 *cnt);
>  void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
>
> -DECLARE_PER_CPU(int, eventfd_wake_count);
> -
> -static inline bool eventfd_signal_count(void)
> -{
> -	return this_cpu_read(eventfd_wake_count);
> -}
> +bool eventfd_signal_count(void);
>
>  #else /* CONFIG_EVENTFD */
>

