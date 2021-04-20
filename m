Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EADD365C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhDTPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:34:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47386 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:34:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYsOH-0006uF-4W; Tue, 20 Apr 2021 15:34:17 +0000
Subject: Re: [PATCH] perf/x86: Fix integer overflow when left shifting an
 integer more than 32 bits
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        George Dunlap <george.dunlap@eu.citrix.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210420142907.382417-1-colin.king@canonical.com>
 <YH7tJz6WnPH7s8yO@hirez.programming.kicks-ass.net>
 <YH7z5lv9CVQuiI7V@hirez.programming.kicks-ass.net>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <a86b81d8-c842-b72a-16d7-f894a469eb91@canonical.com>
Date:   Tue, 20 Apr 2021 16:34:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH7z5lv9CVQuiI7V@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 16:31, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 05:03:03PM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 20, 2021 at 03:29:07PM +0100, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
>>> bit-wise masked with the value (0x03 << i*4). However, the shifted value
>>> is evaluated using 32 bit arithmetic, so will overflow when i > 8.
>>> Fix this by making 0x03 a ULL so that the shift is performed using
>>> 64 bit arithmetic.
>>>
>>> Addresses-Coverity: ("Unintentional integer overflow")
>>
>> Strange tag that, also inaccurate, wide shifts are UB and don't behave
>> consistently.
>>
>> As is, we've not had hardware with that many fixed counters, but yes,
>> worth fixing I suppose.
> 
> Patch now reads:
> 
> ---
> Subject: perf/x86: Allow for 8<num_fixed_counters<16
> From: Colin Ian King <colin.king@canonical.com>
> Date: Tue, 20 Apr 2021 15:29:07 +0100
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
> bit-wise masked with the value (0x03 << i*4). However, the shifted value
> is evaluated using 32 bit arithmetic, so will UB when i > 8. Fix this
> by making 0x03 a ULL so that the shift is performed using 64 bit
> arithmetic.
> 
> This makes the arithmetic internally consistent and preparers for the
> day when hardware provides 8<num_fixed_counters<16.

Yep, that's good. Thanks.

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210420142907.382417-1-colin.king@canonical.com
> ---
>  arch/x86/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -261,7 +261,7 @@ static bool check_hw_exists(void)
>  		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
>  			if (fixed_counter_disabled(i))
>  				continue;
> -			if (val & (0x03 << i*4)) {
> +			if (val & (0x03ULL << i*4)) {
>  				bios_fail = 1;
>  				val_fail = val;
>  				reg_fail = reg;
> 

