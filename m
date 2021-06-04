Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86739BD90
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFDQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFDQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:49:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D2C061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 09:48:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y11so192720pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+tuHAocWcuJzWvdGVhmtAZ0L2xQ0dgC0EsdO1uJTuM=;
        b=SIVwRFswGc3aP5BmxCJ9AJkwql7geJWoxL/UsCiOtJXDElaoaJWjeqrWbx6yJ9HpPM
         dZNdy17ufEhVvcggpv4j/W9KWphcJ2l+8cnlLN7rkolTsqWNWyoi/KuIko664ng3KsKV
         yvMHnTbmzBA2izsnK60sgOfus+dXfWn9hMc+1N+0bT4YnO7YXM2ZeHCnUj2UFXqt8P0e
         flYw1BBbY+H74McenLyNRs4KpaT+Tym8BpTbhhWmyE/roHEb6s9unFp1KusVs5c3zEI1
         a9wXPi3Zve+Vq3yDOWXCxJbk1n3araRoz38eCV7mdjPER9ZxoeGPIiRChZVfWtOZpKxP
         Zf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m+tuHAocWcuJzWvdGVhmtAZ0L2xQ0dgC0EsdO1uJTuM=;
        b=gEP2ZZ4FTNYs0idriFBvYvvo7OWXvPBHtBdaGBnfRZz6GkDR63QezqltAydv5hHpFM
         bW2gH0fpXg1Ti+1mFzRcDV1RUh22m130yADGpw5V0HPwkXYz3BhQUxi15g6ZWcFwyhs4
         ugQ0PpELFgU5uci8eABY5coPoBLwrUI2C5CD9KVvpRp8yg3ALnuotRZhC0OJ6b/atzeu
         Nc6GH5gQoqFoYGCxjXIFhjb8FfOpYOc53FqZzlSngoy5Fmhmz/sV9oXIMHDuk1RehqI6
         kWEkURLCGo7ngRbCNBv8oh1uuksxJb/bjyObGDgjrDJR85tLBp7M8Qov11ShIT/uUOl2
         QnVg==
X-Gm-Message-State: AOAM532A8Apdq8ncV+L2TJxxjAcrV8VC/2imLPSDzF3OquBourTJyq+Z
        3TWBYeopqfijrqI5aZ7+TFJbJw==
X-Google-Smtp-Source: ABdhPJwS+NF5wOICqnE9LegS9iGp0BzPSMBdNC32VA/zsnCuucM35oC7HboBdGOjqD0wqutybRuElA==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr6075538pgp.84.1622825284222;
        Fri, 04 Jun 2021 09:48:04 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id n6sm2520661pgm.79.2021.06.04.09.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:48:03 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:48:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Cody Yao-oc <CodyYao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/perf: Fixed obtaining address error about
 performance monitor MSR on old Inel CPU.
Message-ID: <YLpZQCyZWjnD/1ZP@google.com>
References: <20210604055438.17705-1-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604055438.17705-1-CodyYao-oc@zhaoxin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021, Cody Yao-oc wrote:
> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> 
> Fix "obtain wrong msr address" bug in function nmi_perfctr_msr_to_bit
> and nmi_eventsel_msr_to_bit. In X86_VENDOR_INTEL switch branch, if all
> of the check conditions are not met, code flow will slip to
> X86_VENDOR_ZHAOXIN branch which may lead to incorrect information.
> 
> Therefore, "fallthrough" should be changed to "break" to avoid it.

This should explicitly state that using fallthrough instead of break was
completely unintentional, assuming that's indeed the case.

Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")

> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/perfctr-watchdog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
> index 3ef5868ac588..7aecb2fc3186 100644
> --- a/arch/x86/kernel/cpu/perfctr-watchdog.c
> +++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
> @@ -63,7 +63,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
>  		case 15:
>  			return msr - MSR_P4_BPU_PERFCTR0;
>  		}
> -		fallthrough;
> +		break;
>  	case X86_VENDOR_ZHAOXIN:
>  	case X86_VENDOR_CENTAUR:
>  		return msr - MSR_ARCH_PERFMON_PERFCTR0;
> @@ -96,7 +96,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
>  		case 15:
>  			return msr - MSR_P4_BSU_ESCR0;
>  		}
> -		fallthrough;
> +		break;
>  	case X86_VENDOR_ZHAOXIN:
>  	case X86_VENDOR_CENTAUR:
>  		return msr - MSR_ARCH_PERFMON_EVENTSEL0;
> -- 
> 2.17.1
> 
