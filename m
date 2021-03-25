Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55A3493A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCYOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCYOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:05:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFBDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:05:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o19so2571169edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rX//Uhpuk8en/W5znqrGRfTGBgMGuB8Bz5tQH5NTtjY=;
        b=Ke5pbsg3S83cZVxueHYhsSWsAkyRWGbSfn3ua0smoXTJhDVSfjR4g/OrYyR8AZjjdL
         cMAwBISi3S2UcIYw31DtbddDU4MQ8/N5K2wSEJfHY+lce0snCQn0e3VJ4e6JnWuT2JFN
         MovoFjawftKT5yqrSgyCJYtLw5IcYQzEpMKmBMfutMbepJf2ihVhhEj/kHamqcbli7PH
         A+5Lv7XC6uaOLZHWcUjb5vSzaAyVtEsVsepf1rFqu/AAkZ2Dj1JhQejXUhfO/4exi9TD
         KaiykHYERPfJ3tnjgqH80EchXt8jcZOxjimAkTR/NHtebcQRU3zm6YUcs5rD90hl8qri
         WmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rX//Uhpuk8en/W5znqrGRfTGBgMGuB8Bz5tQH5NTtjY=;
        b=U+I0Ee2hm2YJl7bKAUwlNBuS+sF+HXORY8iI2Rxd2KeyfmPcbtVSRw49DuPLZ4jx0v
         6SBS1IcBU9suhBiTf5fD74v12Ql5aW8rlJfBWjeqH8RUUdWa0Xl/VeTQoUMePT8XdIRP
         mzIXYTZg+riwnbpO5nGP5IbcwaWpxdCuxvxcz11AVbksiz1enzkBJAlm6yhaeYlbWFol
         Bj+B1xwaNW4qx5p4EmaLohz5/8O638d5rAZeGIi573F9lwXMcTy7YjvCrvfPF1Fd4BgW
         RtLPXZsQeLyv+GP3c01+rM2XxAkEdZqSghPqNKctQFx1/vRc1TuSOCaUVVZf3mJ0Fwko
         DN7A==
X-Gm-Message-State: AOAM531IEGnP07LKkmZDFXPC3vAPRhHfrSVhFrm6AZJC1KDwCY8c/Yk4
        iFieZ6A3ll0gJsxgX6u2J/E=
X-Google-Smtp-Source: ABdhPJwNMwu6BnKM1FLOlHciYyThwzUmtmx8/MmZpCGMdWZMeYH9qJBvym6uIe8OHEtOoyFcuzqTjA==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr9384904edb.306.1616681143331;
        Thu, 25 Mar 2021 07:05:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r5sm2795891eds.49.2021.03.25.07.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:05:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 25 Mar 2021 15:05:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dwmw@amazon.co.uk, luto@kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] x86/apic: Rudimentary typo fixes
Message-ID: <20210325140534.GA4167881@gmail.com>
References: <20210324134149.30445-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324134149.30445-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> s/preferrable/preferable/
> s/serivced/serviced/
> s/distributon/distribution/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
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

This and many more comment typos are already fixed in the latest x86 
tree, which you can find at:

  git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

Thanks,

	Ingo
