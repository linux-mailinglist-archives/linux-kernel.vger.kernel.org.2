Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E028426FAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhJHRld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:41:33 -0400
Received: from foss.arm.com ([217.140.110.172]:38432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhJHRl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:41:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5E881063;
        Fri,  8 Oct 2021 10:39:33 -0700 (PDT)
Received: from [10.1.196.26] (eglon.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A7103F766;
        Fri,  8 Oct 2021 10:39:33 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_sdei: pass sdei_api_event_register right
 parameters
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210910040117.98736-1-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3fb354d1-bdc1-8aa2-aa90-4fd92e9a2e9a@arm.com>
Date:   Fri, 8 Oct 2021 18:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210910040117.98736-1-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

(sorry for the delayed response)

On 10/09/2021 05:01, Liguang Zhang wrote:
> Function _local_event_enable is used for private sdei event
> registeration called by sdei_event_register. We should pass

(registration)

> sdei_api_event_register right flag and mpidr parameters, otherwise atf
> may trigger assert errors.

> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a7e762c352f9..0736752dadde 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -558,14 +558,16 @@ static int sdei_api_event_register(u32 event_num, unsigned long entry_point,
>  static void _local_event_register(void *data)
>  {
>  	int err;
> +	u64 mpidr;
>  	struct sdei_registered_event *reg;
>  	struct sdei_crosscall_args *arg = data;
>  
>  	WARN_ON(preemptible());
>  
> +	mpidr = read_cpuid_mpidr();
>  	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
>  	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
> -				      reg, 0, 0);
> +				      reg, SDEI_EVENT_REGISTER_RM_PE, mpidr);

Hmmm, this looks like a bug in TFA.

5.1.2.2 "Parameters" of DEN 0054B has:
| Routing mode is valid only for a shared event. For a private event, the routing mode is
| ignored.

Worse, the mpidr field has:
| Currently the format is defined only when the selected routing mode is RM_PE.


Over in trusted firmware land:

https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/services/std_svc/sdei/sdei_main.c?h=v2.5#n361

| static int64_t sdei_event_register(int ev_num,
| 				uint64_t ep,
| 				uint64_t arg,
| 				uint64_t flags,
|				uint64_t mpidr)
| {

|	/* Private events always target the PE */
|	if (is_event_private(map))
|		flags = SDEI_REGF_RM_PE;

It looks like this re-uses the 'caller specified the routing' code, but didn't update the
mpidr.


You mention TFA takes an assert failure, I assume that brings the machine down.
(Presumably you don't have a CPU with an affinity of zero.)

Does this mean no-one relies on this, and we can fix the firmware?
(I'll go report this to the relevant folk)


Thanks!

James


>  
>  	sdei_cross_call_return(arg, err);
>  }
> 

