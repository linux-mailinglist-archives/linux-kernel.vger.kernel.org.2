Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6838E56D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhEXL1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:27:55 -0400
Received: from foss.arm.com ([217.140.110.172]:41220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232547AbhEXL1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:27:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13AC131B;
        Mon, 24 May 2021 04:26:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923073F719;
        Mon, 24 May 2021 04:26:20 -0700 (PDT)
Date:   Mon, 24 May 2021 12:26:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        rafael.j.wysocki@intel.com, rostedt@goodmis.org, npiggin@gmail.com,
        yejunedeng@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqflags: Remove the CONFIG_TRACE_IRQFLAGS
Message-ID: <20210524112617.GF1040@C02TD0UTHF1T.local>
References: <1621824679-29258-1-git-send-email-yejunedeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621824679-29258-1-git-send-email-yejunedeng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:51:19AM +0800, Yejune Deng wrote:
> trace_hardirqs_on() and trace_hardirqs_off() had include the
> CONFIG_TRACE_IRQFLAGS, so remove the redundant CONFIG_TRACE_IRQFLAGS.
> 
> Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
> ---
>  include/linux/irqflags.h | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 600c10d..b5edd7b 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -189,12 +189,6 @@ extern void warn_bogus_irq_restore(void);
>  #define raw_irqs_disabled()		(arch_irqs_disabled())
>  #define raw_safe_halt()			arch_safe_halt()
>  
> -/*
> - * The local_irq_*() APIs are equal to the raw_local_irq*()
> - * if !TRACE_IRQFLAGS.
> - */
> -#ifdef CONFIG_TRACE_IRQFLAGS
> -
>  #define local_irq_enable()				\
>  	do {						\
>  		trace_hardirqs_on();			\
> @@ -230,16 +224,6 @@ extern void warn_bogus_irq_restore(void);
>  	} while (0)
>  
>  
> -#else /* !CONFIG_TRACE_IRQFLAGS */
> -
> -#define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
> -#define local_irq_disable()	do { raw_local_irq_disable(); } while (0)

The implementation we're left with is:

| #define local_irq_disable()                             \
|         do {                                            \
|                 bool was_disabled = raw_irqs_disabled();\
|                 raw_local_irq_disable();                \
|                 if (!was_disabled)                      \
|                         trace_hardirqs_off();           \
|         } while (0)

... where the compiler almost certainly won't be able to optimize away
the call to raw_irqs_disabled(), which wraps arch_irqs_disabled(). Note
that arch_irqs_disabled() is typically implemented with a volatile asm
block to save the processor flags.

We could special-case local_irq_disable() to prevent this, or we could
leave it as-is. I'd err towards the latter.

Thanks,
Mark.

> -#define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
> -#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
> -#define safe_halt()		do { raw_safe_halt(); } while (0)
> -
> -#endif /* CONFIG_TRACE_IRQFLAGS */
> -
>  #define local_save_flags(flags)	raw_local_save_flags(flags)
>  
>  /*
> -- 
> 2.7.4
> 
