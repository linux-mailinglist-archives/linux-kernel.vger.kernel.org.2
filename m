Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0A38BC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhEUC1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:27:11 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:21889
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231681AbhEUC1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK9Gk5tmlbWSrA1eq2lpiKx8hGIJH9bEe5D1VGJhCOnfvboTU4XCs5iQLVfn9aSIVjulb+W4YrBbTxtY74dcXw+zCkmKvLDxpw0YNdIblSrZX7t9Ne8B/58fojvBMWjrM9FUrp1VmISuZayta4d/f1+MA/BHYZdDtD+F7zxc/Rq/MRLvfqiP4VQ10qfXOkI2coBbeqq+kEmHSJetjlryVrQKmpX+ew+Ymg/l+0tS9UHcDkuQh3z6L0giVW9RTD/EiIy49JJoPxZkotxUzxuawiaxMo/0vjJCqxncvuCEMUnFJfCZKqpeG7pr86uCg3vun3Xy5bnCK+/AFAq9FrQoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzy/wIc3CCw5pCZlnRiyiuIIuirH9npfwPrPsllwiOg=;
 b=KnL3RV5EDolzNgjSzbH/y2+oZjeP0vsQp2a+AO7thpG86WaNWCS6Y8p2Gl1JH0PyTIbiup1n8GYObPLa3pD1gRskXx59bXESUuMkr+2sH4Z+vdVgKPa9ZRKYanbx5Rh8bEtxeAGnSDPadJvNCzhVwf8q5Ef2+xI1wkkWsc1BY+tsnVsJrOFf1lReOd2iuIfXNR+NODDI5SNvDrvhpdhmnMFc2oN5TS5x/FSI8FAl6fcZtnfrp7SOFiYinAr2jF8kOFt8cEuxh4tqv98zWIOO1DQzpzvdyx/LH/hxRJDYPv5DWkJnQDYtjafhGPcPJjcUJPicNuR9LhVCegJP2shT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzy/wIc3CCw5pCZlnRiyiuIIuirH9npfwPrPsllwiOg=;
 b=r8j++TEc1kfDptJfSsi1BBkeX0MwNNdHjYPwn2aPsUgkxlN7D/1WZYMabuNyy5wYvNOvnnbseKk9XrfpD4ZlFYfKtYubVxBzGrXDulCGqsPXTQ37RNhtZakFydZF6LJcCl9KI6Xa3LMs3LUrrrfzPtpTpqznVTjva6UtJt3A9Vw=
Authentication-Results: android.com; dkim=none (message not signed)
 header.d=none;android.com; dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB6PR03MB2855.eurprd03.prod.outlook.com (2603:10a6:6:33::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 02:25:45 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239%5]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 02:25:44 +0000
Subject: Re: [PATCH 3/5] tick/broadcast: Prefer per-cpu oneshot wakeup timers
 to broadcast
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
References: <20210520184705.10845-1-will@kernel.org>
 <20210520184705.10845-4-will@kernel.org>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <a269c869-b966-75d5-5fe1-6ed6921c1b83@nextfour.com>
Date:   Fri, 21 May 2021 05:25:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210520184705.10845-4-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [91.145.109.188]
X-ClientProxiedBy: HE1PR0901CA0058.eurprd09.prod.outlook.com
 (2603:10a6:3:45::26) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0901CA0058.eurprd09.prod.outlook.com (2603:10a6:3:45::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 02:25:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8210c94f-f0e7-47a8-0cc6-08d91bffbc8d
X-MS-TrafficTypeDiagnostic: DB6PR03MB2855:
X-Microsoft-Antispam-PRVS: <DB6PR03MB2855456B44B764E3D2B2F36183299@DB6PR03MB2855.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXr62MsCtzn7W0JX4MHrc0xtfaAUIjqw9vlTsaKPeHaSOAjsqfeuo0+FuvfGvh5UecjGhdw1HMJtSpafkTtrHcJr73rEVf/mfWhFyMjF+0HQQ9/KmLu3THT/ZENiKiRhzaageT/hPpJp+LzX444b6Dz3Kz43sDoV6J2HOsd2Xx81H17Ekhk8dGhGx5kls/pa9i5vgQ+ZcBvjUwsEdX0sdMwaVMXVdwUf5rBPpmVfITowcp/Qu7rjeplQ15QYfEvYKN91vvtWE4QBIrNh8uzmtTfaWz+kchAR0N6ZxzvKS087M5imGZR9g+i3i9OpvOsaacqYgc/APUPiTPVMbEnbd0SjiRy/o/IwJBXQS2iPHgKZcsyW4QU5LoYHJJQIilgTvNQ4hPhKW2fpYeG4LIa4Fep90M8b4N6Z4cxnD6c9oqisun8VW5Xy1hp/tqLxn3xIUVP59cIr3fglitzwKgwIo74zKqrdbTs2rnLRSmOV97S0mUcJROalBZNo/yUsikB2hOVONPgVqdfWUiBXA0qHv4WOMo+AOWHih39huVRm+YrAvpeSGY+sPemf9WFw06G6iRLyUFqsZFPorYTaL7b8RdCamTctSmrCO52xtO68PFixTZ/HJFdKWbVxfOPfQ5zygnO18KfKRv/Yuibwud1ocvpTwdwplKlZv/Nws68T1TXjdgsoKCLp3dFWFPlk9cZQ6FW18/nuX5cxUNXbgF/RmM4Wnj5alDn3hSyeZTaR91c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39830400003)(366004)(54906003)(16576012)(316002)(5660300002)(26005)(52116002)(31696002)(83380400001)(2616005)(36756003)(956004)(86362001)(16526019)(186003)(7416002)(31686004)(8936002)(2906002)(66946007)(38350700002)(38100700002)(478600001)(4326008)(6486002)(66476007)(8676002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmtSMVFYV24wQ2dnM2pwNXNpKzJnVEUwTE1QcGlrRlhhMnBKdTRzUk1VVndR?=
 =?utf-8?B?N3lRSEdPWDg5eTk4NkhsUFFMMGNrcHBIN3QxSTgzenNyMnhWTkkvLzYyS0VB?=
 =?utf-8?B?Y2YvQWw5dnl4WGErak1sZnFFSENUS29kTmRuaDVnLytPV1gvMURRODJSblB4?=
 =?utf-8?B?YkIrTzlVRFNDOEhSWDl3ejQrZlV3eUVlWFEvRXUzRlFXV3ZsZWxXOHhwZmxR?=
 =?utf-8?B?STJsOC91YVdrSWIxVlNCa0hvSFZLSVB6UDZTOHpBbU14M1UrbEFOdE5hYWp3?=
 =?utf-8?B?YnkrV01WUHoyV3BIZmdtbEtKL0NQaFRuL0xPQm11S3ZVd1lKajdQRXVoeVM5?=
 =?utf-8?B?ZXUvRk9QY291Zll6Y0VQSjYyUTZwck9neUhPM2w1aTlSRk41RU9kVU9uTnRR?=
 =?utf-8?B?ZjcrUUxpZm5kT05hYU1OTks3YVNGSnE2WWdnNnBsc0I0WjhyL3l5UlBtK1FV?=
 =?utf-8?B?QlgyNU9oSDJiY1l2dTY0eHAxZW9ydlJsOUlENW9wQStJRHc5WjBzeXRqNysz?=
 =?utf-8?B?cFZaQXNJT2NZSHd1UmxwMk1wanJ1Q3R1NUdXemRjdm1ibjJRM25lZ0c2eS8w?=
 =?utf-8?B?QU4zdzVzTk42YmZKdFJTRmhmTE5yRUREbTVHMVFxWGlQYzFUWTJqM1ZocFNI?=
 =?utf-8?B?M3Q5UVVaaG9Zd2ZKSmovMHZYbzVSQ2lhc0U3MitMMzZKUDhGbTBKb2gyWERQ?=
 =?utf-8?B?aDlURFBXbTJQTE8yZFAwVkZsQVJDWkFIUUxwS2Vva3lLTUJ4STR4OVMvMnln?=
 =?utf-8?B?TUs0TzE0bUlPMDZybTZoVmdJaEpEcmxvM0dValRiTVdyYkNmakFsTU5uU1FH?=
 =?utf-8?B?REQwVTB6L1NNNmtaaVNtd3lJMlRNaGNNZUY5WlV1LzU4M053ZSttYzJ1U2U5?=
 =?utf-8?B?YTQ5MlQwWVJVZUlIb1pCc0dseUo5eUw4d2NCMHRYS2tuVUpsT0ZvRXp4V3dC?=
 =?utf-8?B?N3RVT05Vb3JlY2h0b3NhelpCL1R5MkZobVRxd09HZ1MrY21reFJoeGsxVndO?=
 =?utf-8?B?WU9ianFpNVp6SnJhakFKWUJsNFI2Nk5VNENtU21EdUNqQXcydjFtR3ZJSXJy?=
 =?utf-8?B?dS8vRHJxc0YxRjRNQURBUjVDL1N5V1JvN0IrUmQrb0Fab0tLeFNLeTJ6bGNE?=
 =?utf-8?B?RlpHcTBBU1BuOXdXRHQxbG9CbkI5OXUrb3J1dlBSaXBMaGh2S09LVjF0emxN?=
 =?utf-8?B?MlNPZllFbmVJRFFvUlNKZnpDRVV0MmhSTHZxV2tkeHdKYnZEYWluSm5vWWJj?=
 =?utf-8?B?K3lMSnkwUU9nanhQOFp6bjB5TllKM2g4NEVZNGc1NitjalQrWEt1eElPdkgy?=
 =?utf-8?B?Wmo4Nk12RjZGRm5ZY1MvM0M2NlhSNFZXSEJvdjF0R1d3ODBRd3ppWEU5cmQ3?=
 =?utf-8?B?Qk9lQ3c3aEc2K0FXbjFxTnE0ME5HR2ttSXdCeW02SFVvaFlBNlhUMGw3dVU5?=
 =?utf-8?B?Z2ZZbmI1cXUxbXMzeW5BRklGWUw2TXhzVHZxUVdiQ3pyUjVRTkd4Y2R1a0NS?=
 =?utf-8?B?RDY1QXVqNDdpazJSWmNVTkhDamlPMlJpaEFRWG5NbjlRd2p3RTY4ZlhqUTMv?=
 =?utf-8?B?SlFUbGJQRjRKOVE4R3NvSTI4YnQ0bWpCa29PdlV3QzRHK29CV2htQU1mRk1r?=
 =?utf-8?B?bExseExubDMvWTZDT2kxRkYxOXU4d0g5VTBRdDhQYmhjdlpEcHorRTYyaFN3?=
 =?utf-8?B?VkNvamU4VzAwYlF1WFRydytIVWROajFqMTZuQmFLMGduSHQyWEl5b0hwRnRN?=
 =?utf-8?Q?Mk7Q6WkIOCeF7K4c4pLej/feTByzOoddFYgtEQM?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8210c94f-f0e7-47a8-0cc6-08d91bffbc8d
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 02:25:44.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2+kfpAr4KBPeVtQWV/i66iQeeUtFQLYuKEs6NDEo4Z+tTtkEjbc+S+I6yuFkDIQeu7Mxgt/NIivDENTHwwIUp9z4IQ2zalCblpVYWEOOy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2855
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 20.5.2021 21.47, Will Deacon wrote:
> Some SoCs have two per-cpu timer implementations where the timer with
> the higher rating stops in deep idle (i.e. suffers from
> CLOCK_EVT_FEAT_C3STOP) but is otherwise preferable to the timer with the
> lower rating. In such a design, we rely on a global broadcast timer and
> IPIs to wake up from deep idle states.
>
> To avoid the reliance on a global broadcast timer and also to reduce the
> overhead associated with the IPI wakeups, extend
> tick_install_broadcast_device() to manage per-cpu wakeup timers
> separately from the broadcast device.
>
> For now, these timers remain unused.
>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   kernel/time/tick-broadcast.c | 57 +++++++++++++++++++++++++++++++++++-
>   kernel/time/tick-common.c    |  2 +-
>   kernel/time/tick-internal.h  |  4 +--
>   3 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index f3f2f4ba4321..8bd8cd69c8c9 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -33,6 +33,8 @@ static int tick_broadcast_forced;
>   static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
>   
>   #ifdef CONFIG_TICK_ONESHOT
> +static DEFINE_PER_CPU(struct clock_event_device *, tick_oneshot_wakeup_device);
> +
>   static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
>   static void tick_broadcast_clear_oneshot(int cpu);
>   static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
> @@ -88,13 +90,59 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
>   	return !curdev || newdev->rating > curdev->rating;
>   }
>   
> +#ifdef CONFIG_TICK_ONESHOT
> +static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
> +{
> +	return per_cpu(tick_oneshot_wakeup_device, cpu);
> +}
> +
> +static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
> +					   int cpu)
> +{
> +	struct clock_event_device *curdev;
> +
> +	if (!newdev)
> +		goto set_device;
> +
> +	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
> +	    (newdev->features & CLOCK_EVT_FEAT_C3STOP) ||
> +	    !(newdev->features & CLOCK_EVT_FEAT_ONESHOT))
> +		return false;
> +
> +	if (!cpumask_equal(newdev->cpumask, cpumask_of(cpu)))
> +		return false;
> +
> +	curdev = tick_get_oneshot_wakeup_device(cpu);
> +	if (curdev && newdev->rating <= curdev->rating)
> +		return false;
> +
> +set_device:
> +	per_cpu(tick_oneshot_wakeup_device, cpu) = newdev;
> +	return true;
> +}
> +#else
> +static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
> +{
> +	return NULL;
> +}
> +
> +static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
> +					   int cpu)
> +{
> +	return false;
> +}
> +#endif
> +
>   /*
>    * Conditionally install/replace broadcast device
>    */
> -void tick_install_broadcast_device(struct clock_event_device *dev)
> +void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
>   {
>   	struct clock_event_device *cur = tick_broadcast_device.evtdev;
>   
> +	if (tick_set_oneshot_wakeup_device(dev, cpu))
> +		return;
> +
>   	if (!tick_check_broadcast_device(cur, dev))
>   		return;
>   

Does this disable hpet registering as a global broadcast device on x86 ? 
I think it starts with cpumask = cpu0 so it qualifies for a percpu 
wakeup timer.


> @@ -996,6 +1044,13 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
>    */
>   static void tick_broadcast_oneshot_offline(unsigned int cpu)
>   {
> +	struct clock_event_device *dev = tick_get_oneshot_wakeup_device(cpu);
> +
> +	if (dev) {
> +		clockevents_switch_state(dev, CLOCK_EVT_STATE_DETACHED);
> +		tick_set_oneshot_wakeup_device(NULL, cpu);
> +	}
> +
>   	/*
>   	 * Clear the broadcast masks for the dead cpu, but do not stop
>   	 * the broadcast device!
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index e15bc0ef1912..d663249652ef 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -373,7 +373,7 @@ void tick_check_new_device(struct clock_event_device *newdev)
>   	/*
>   	 * Can the new device be used as a broadcast device ?
>   	 */
> -	tick_install_broadcast_device(newdev);
> +	tick_install_broadcast_device(newdev, cpu);
>   }
>   
>   /**
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 7a981c9e87a4..30c89639e305 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -61,7 +61,7 @@ extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
>   /* Broadcasting support */
>   # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>   extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
> -extern void tick_install_broadcast_device(struct clock_event_device *dev);
> +extern void tick_install_broadcast_device(struct clock_event_device *dev, int cpu);
>   extern int tick_is_broadcast_device(struct clock_event_device *dev);
>   extern void tick_suspend_broadcast(void);
>   extern void tick_resume_broadcast(void);
> @@ -72,7 +72,7 @@ extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
>   extern struct tick_device *tick_get_broadcast_device(void);
>   extern struct cpumask *tick_get_broadcast_mask(void);
>   # else /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST: */
> -static inline void tick_install_broadcast_device(struct clock_event_device *dev) { }
> +static inline void tick_install_broadcast_device(struct clock_event_device *dev, int cpu) { }
>   static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
>   static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
>   static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }

