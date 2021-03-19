Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC134219E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCSQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:18:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:17:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616170667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4+7BP5Jn9Zh7f3fP6qSXOm3O/gvgBiCQ7MolzFIOC8=;
        b=1/TyAH/F40r+fdKA/Or+KVrmr38OCCWHIwDK8c89iI+oukSjhvn+UrLbdvd/B/XjlPjV7P
        DmtOGvjb6wKYb6XpFX/iua10yZXtFezH8COUAedq9UqUlxgsPcg2aoQ6e+9N8zpUqIAvLQ
        xckWiM/NZvMU98afnydzP84d0vfFUYWS6GPYqzp8oLsAfH8Lod6Ua9AzRhjYwJKsR/mEp3
        TQOOn4yU5UOwum+5c81uUpqHcpAvM0AckTVU9Vg0NXJ1H3N6OOwJiivmvUxdesYilQVlp/
        6AxzvbGGWUikM7QzKKbUVGk3Y+UuvA1bVxdNfzAAwQ6KynVixpcx9S4V1/6vlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616170667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4+7BP5Jn9Zh7f3fP6qSXOm3O/gvgBiCQ7MolzFIOC8=;
        b=eUrJYje3sIbtlB1JmWp0KqBcoJu4dgI82Ad4FoGW/4COnSnKdahwWw2ug1oNDbmJGGUP4I
        cZqYgzOaVWf2sgAA==
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 7/9] kentry: Add debugging checks for proper kentry API usage
In-Reply-To: <df38bc3aa82dc122c88bf902f6922ab7c22bf783.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org> <df38bc3aa82dc122c88bf902f6922ab7c22bf783.1616004689.git.luto@kernel.org>
Date:   Fri, 19 Mar 2021 17:17:47 +0100
Message-ID: <87pmzv5d90.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 11:12, Andy Lutomirski wrote:
> +
> +#define DEBUG_ENTRY_WARN_ONCE(condition, format...) do {} while (0)

So we have a stub for !DEBUG

> +static __always_inline void kentry_cpu_depth_add(unsigned int n) {}
> +static void kentry_cpu_depth_check(unsigned int n) {}
> +static __always_inline void kentry_cpu_depth_sub(unsigned int n) {}
> +
> +#endif
> +
>  /* See comment for enter_from_user_mode() in entry-common.h */
>  static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>  {
> +	kentry_cpu_depth_add(1);
>  	arch_check_user_regs(regs);
>  	lockdep_hardirqs_off(CALLER_ADDR0);
>  
> @@ -22,6 +78,14 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>  
>  	instrumentation_begin();
>  	trace_hardirqs_off_finish();
> +
> +#ifdef CONFIG_DEBUG_ENTRY

Why do we need that #ifdeffery all over the place?

> +	DEBUG_ENTRY_WARN_ONCE(
> +		this_cpu_read(kentry_cpu_depth) != 1,
> +		"kentry: __enter_from_user_mode() called while kentry thought the CPU was in the kernel (%u)",
> +		this_cpu_read(kentry_cpu_depth));

Thanks,

        tglx
