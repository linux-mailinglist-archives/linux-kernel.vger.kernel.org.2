Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4535A1F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhDIPYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:24:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:58661 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhDIPYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:24:24 -0400
IronPort-SDR: s5xmFU35fj0vCrnV7gDGPMAGsXFo43O48J1GoDAF/eu47Bn64wYbHbWCD6Rxo2rKer1z+3VKYq
 /NYjc8w3AtPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="191633880"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="191633880"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:24:11 -0700
IronPort-SDR: 64FeR+A9AM7s7F/bpibesvL7muKJ/ITBdbZ+3A2KYTqrtierNopootqgzgU0AUk9wEwpV+c3pk
 zoXUDCb0EhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="613747171"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2021 08:24:11 -0700
Received: from [10.209.7.33] (kliang2-MOBL.ccr.corp.intel.com [10.209.7.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 468D6580812;
        Fri,  9 Apr 2021 08:24:09 -0700 (PDT)
Subject: Re: [PATCH V5 21/25] perf: Introduce PERF_TYPE_HARDWARE_PMU and
 PERF_TYPE_HW_CACHE_PMU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-22-git-send-email-kan.liang@linux.intel.com>
 <YHActB+bkgBesWM3@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <11ed193e-75f9-c060-b757-350612b694aa@linux.intel.com>
Date:   Fri, 9 Apr 2021 11:24:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHActB+bkgBesWM3@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2021 5:21 AM, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 08:11:03AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Current Hardware events and Hardware cache events have special perf
>> types, PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. The two types don't
>> pass the PMU type in the user interface. For a hybrid system, the perf
>> subsystem doesn't know which PMU the events belong to. The first capable
>> PMU will always be assigned to the events. The events never get a chance
>> to run on the other capable PMUs.
>>
>> Add a PMU aware version PERF_TYPE_HARDWARE_PMU and
>> PERF_TYPE_HW_CACHE_PMU. The PMU type ID is stored at attr.config[40:32].
>> Support the new types for X86.
> 
> Obviously ARM would need the same, but also, I don't think I see the
> need to introduce new types. AFAICT there is nothing that stops this
> scheme from working for the existing types.
> 
> Also, pmu type is 32bit, not 8bit.
> 
> So how about something like this?
> 
> ---
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 3f7f89ea5e51..074c7687d466 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -260,15 +260,16 @@ struct perf_event;
>   /**
>    * pmu::capabilities flags
>    */
> -#define PERF_PMU_CAP_NO_INTERRUPT		0x01
> -#define PERF_PMU_CAP_NO_NMI			0x02
> -#define PERF_PMU_CAP_AUX_NO_SG			0x04
> -#define PERF_PMU_CAP_EXTENDED_REGS		0x08
> -#define PERF_PMU_CAP_EXCLUSIVE			0x10
> -#define PERF_PMU_CAP_ITRACE			0x20
> -#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
> -#define PERF_PMU_CAP_NO_EXCLUDE			0x80
> -#define PERF_PMU_CAP_AUX_OUTPUT			0x100
> +#define PERF_PMU_CAP_NO_INTERRUPT		0x0001
> +#define PERF_PMU_CAP_NO_NMI			0x0002
> +#define PERF_PMU_CAP_AUX_NO_SG			0x0004
> +#define PERF_PMU_CAP_EXTENDED_REGS		0x0008
> +#define PERF_PMU_CAP_EXCLUSIVE			0x0010
> +#define PERF_PMU_CAP_ITRACE			0x0020
> +#define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x0040
> +#define PERF_PMU_CAP_NO_EXCLUDE			0x0080
> +#define PERF_PMU_CAP_AUX_OUTPUT			0x0100
> +#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0200
>   
>   struct perf_output_handle;
>   
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f07943183041..910a0666ebfe 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11113,14 +11113,21 @@ static struct pmu *perf_init_event(struct perf_event *event)
>   	 * are often aliases for PERF_TYPE_RAW.
>   	 */
>   	type = event->attr.type;
> -	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
> -		type = PERF_TYPE_RAW;
> +	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
> +		type = event->attr.config >> 32;
> +		if (!type)
> +			type = PERF_TYPE_RAW;
> +	}

For the old tool, the default PMU will be the big core. I think it's OK 
for X86.

Since only the low 32 bit of event->attr.config contains the 'real' 
config value, I think all the ARCHs will do event->attr.config &= 
0xffffffff. Maybe we should move it to the generic code.

+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
+		type = event->attr.config >> 32;
+		if (!type)
+			type = PERF_TYPE_RAW;
+		else
+			event->attr.config &= 0xffffffff;

> >   again:
>   	rcu_read_lock();
>   	pmu = idr_find(&pmu_idr, type);
>   	rcu_read_unlock();
>   	if (pmu) {
> +		if (event->attr.type != type && type != PERF_TYPE_RAW &&
> +		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
> +			goto fail;
> +
>   		ret = perf_try_init_event(pmu, event);
>   		if (ret == -ENOENT && event->attr.type != type) {
>   			type = event->attr.type;


I don't think we want to go through all available PMUs again if users 
already specify a PMU.

I update the patch a little bit. (Not test yet. I will do some tests then.)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3158cbc..4f5f9a9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2175,6 +2175,7 @@ static int __init init_hw_perf_events(void)
  			hybrid_pmu->pmu.type = -1;
  			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
  			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
+			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_EXTENDED_HW_TYPE;

  			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
  						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b832e09..391bfb7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -269,6 +269,7 @@ struct perf_event;
  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
  #define PERF_PMU_CAP_NO_EXCLUDE			0x80
  #define PERF_PMU_CAP_AUX_OUTPUT			0x100
+#define	PERF_PMU_CAP_EXTENDED_HW_TYPE		0x200

  struct perf_output_handle;

diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index ad15e40..7ec80ac9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -38,6 +38,20 @@ enum perf_type_id {
  };

  /*
+ * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ * PERF_TYPE_HARDWARE:			0xEE000000AA
+ *					AA: hardware event ID
+ *					EE: PMU type ID
+ * PERF_TYPE_HW_CACHE:			0xEE00DDCCBB
+ *					BB: hardware cache ID
+ *					CC: hardware cache op ID
+ *					DD: hardware cache op result ID
+ *					EE: PMU type ID
+ * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ */
+#define	PERF_HW_EVENT_MASK		0xffffffff
+
+/*
   * Generalized performance event event_id types, used by the
   * attr.event_id parameter of the sys_perf_event_open()
   * syscall:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f079431..9d9a792 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11093,6 +11093,8 @@ static int perf_try_init_event(struct pmu *pmu, 
struct perf_event *event)
  	return ret;
  }

+#define PERF_EXTENDED_HW_TYPE		(event->attr.config >> 32)
+
  static struct pmu *perf_init_event(struct perf_event *event)
  {
  	int idx, type, ret;
@@ -11113,16 +11115,25 @@ static struct pmu *perf_init_event(struct 
perf_event *event)
  	 * are often aliases for PERF_TYPE_RAW.
  	 */
  	type = event->attr.type;
-	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
-		type = PERF_TYPE_RAW;
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
+		type = PERF_EXTENDED_HW_TYPE;
+		if (!type)
+			type = PERF_TYPE_RAW;
+		else
+			event->attr.config &= PERF_HW_EVENT_MASK;
+	}

  again:
  	rcu_read_lock();
  	pmu = idr_find(&pmu_idr, type);
  	rcu_read_unlock();
  	if (pmu) {
+		if (event->attr.type != type && type != PERF_TYPE_RAW &&
+		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+			goto fail;
+
  		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type) {
+		if (ret == -ENOENT && event->attr.type != type && 
!PERF_EXTENDED_HW_TYPE) {
  			type = event->attr.type;
  			goto again;
  		}
@@ -11143,6 +11154,7 @@ static struct pmu *perf_init_event(struct 
perf_event *event)
  			goto unlock;
  		}
  	}
+fail:
  	pmu = ERR_PTR(-ENOENT);
  unlock:
  	srcu_read_unlock(&pmus_srcu, idx);

Thanks,
Kan
