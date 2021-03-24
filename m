Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52A9347FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhCXRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhCXRuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:50:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43FAC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=i6ejqDzcPMeYivIRYGe0EGru88RfcJegOhLgzvC21HY=; b=tletaZiNy3sb+KFcyuPn6ZkLNo
        MzozQhKkKtrVQjFFTUjy6J3+HeOl3hY/NHQDB+K9X8rNsnkUIWczzHX/XtSPORypR/xj6G5441U/r
        C4xkW6hxjO+10UWrD46BsH45HuJVZfrn4MGCJlQwwr/9jQp9uoryiB5mXclSGoYBgowrg91R8WSG6
        ceuuruzpAQYWqxZAyykzjXCVliwQ/KyzX5oycIUvWv1VASgYurqZhW16Q+PTH+hFTYd2WTsQeVeQY
        3lOI4LOiMlAZnFrCyG5oh5pEWjaWsOR9ef57d8YXiAjqA7B9pw0CBSDhQgYJp53bTadR6iKya7KxQ
        usXA/uKQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP7dH-00BeO6-3M; Wed, 24 Mar 2021 17:49:32 +0000
Subject: Re: [PATCH] x86/apic: Rudimentary typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dwmw@amazon.co.uk, luto@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20210324134149.30445-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1474439f-d865-d78b-b170-be0f44073d12@infradead.org>
Date:   Wed, 24 Mar 2021 10:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324134149.30445-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 6:41 AM, Bhaskar Chowdhury wrote:
> 
> s/preferrable/preferable/
> s/serivced/serviced/
> s/distributon/distribution/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/x86/kernel/apic/apic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index bda4f2a36868..e26ee6e67f47 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -619,7 +619,7 @@ static void setup_APIC_timer(void)
> 
>  	if (this_cpu_has(X86_FEATURE_ARAT)) {
>  		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_C3STOP;
> -		/* Make LAPIC timer preferrable over percpu HPET */
> +		/* Make LAPIC timer preferable over percpu HPET */
>  		lapic_clockevent.rating = 150;
>  	}
> 
> @@ -1532,7 +1532,7 @@ static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
>   * Most probably by now the CPU has serviced that pending interrupt and it
>   * might not have done the ack_APIC_irq() because it thought, interrupt
>   * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
> - * the ISR bit and cpu thinks it has already serivced the interrupt. Hence
> + * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
>   * a vector might get locked. It was noticed for timer irq (vector
>   * 0x31). Issue an extra EOI to clear ISR.
>   *
> @@ -1657,7 +1657,7 @@ static void setup_local_APIC(void)
>  	 */
>  	/*
>  	 * Actually disabling the focus CPU check just makes the hang less
> -	 * frequent as it makes the interrupt distributon model be more
> +	 * frequent as it makes the interrupt distribution model be more
>  	 * like LRU than MRU (the short-term load is more even across CPUs).
>  	 */
> 
> --


-- 
~Randy

