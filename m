Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC43CB667
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhGPKzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhGPKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:55:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E93C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:52:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so525281wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U2NCqWjt87MNU4nxzxCZt1K3eL4zVJKa7IH9f/zj9D4=;
        b=JDzBrC4VbA0e13B4t87vijoRgyIMdhFzm9hVohdjhwO8fimFh+R5un3ZZ2Ch5H4ktf
         ZsCVw2sV1HMAKP8KxP3p3aGJUagob36cCbN7G7TghrAfmwegH4VWJKx8aCPzwRnhC7Ay
         L25MvNvecY9QDuLXN4zFfFtbMgXdTdTN+5347Dv6ICXezjHwxSKSwXIBNczQdPmQp+lF
         7UlpzxIb2qTkJpVWHRyw6c3GoMgYT+LO+CeVPgZBmyHd+YqaOkAQjV/Ms++1bZTUi+nZ
         FGqKTiGboAvsJwsW6A7ZyRmymlKoI+GZZuq68Iuvn4m7Sf0JIoANU6CU71uQGzEYUpRc
         sh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2NCqWjt87MNU4nxzxCZt1K3eL4zVJKa7IH9f/zj9D4=;
        b=Ue0C7poeKdsc0HoXgFdWkdz41xcrF2EKk5mZOS+Tm0WEYgtUew8k9X15Sekle1GIub
         nrs0T0I6viIaMjQLhOaE2WkDZCkd2/H8kBbpziI9uVXf/XsXXGGRohG23lgZrT0Vhh2S
         Wq2kQmjOW/bV5bVqueRX2rb9HGYhreP8sE2AnzNrSfAepMtb0Fi7fA2O2/WZNHQ3K3+s
         8QYlsM3G8iJEaDO+TrJjOvPtwQlZBMsvd8/Q22fFNlbw3otsKlvAfK4WCB6cYdJFTHa6
         40SSwnlImUaLHL6iZKkRBFMphZCjtR0Qd60qdeqc42sIFSgec523QJhrL6Z6pdxbr2BO
         BGWA==
X-Gm-Message-State: AOAM533MOP2SIpItjgElV/+7VYn6GYISr3+byKLSqmtg+/LPOfZjxKPc
        /oDgsKi/8wWIIhlv37lSFPifug==
X-Google-Smtp-Source: ABdhPJwjE8SjBgycw2i8fOh3iAZu4BR+jNUe3DvOTPvUr6zttmOGjDL2DfmAD7bSoYMMn0rpzJYpYw==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr15983851wmc.1.1626432722856;
        Fri, 16 Jul 2021 03:52:02 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:fb3b:45b4:a42a:5668])
        by smtp.gmail.com with ESMTPSA id e15sm9351154wrp.29.2021.07.16.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:52:02 -0700 (PDT)
Date:   Fri, 16 Jul 2021 12:51:56 +0200
From:   Marco Elver <elver@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/5] locking/atomic: add generic arch_*() bitops
Message-ID: <YPFkzNvUFUfc1vVp@elver.google.com>
References: <20210713105253.7615-1-mark.rutland@arm.com>
 <20210713105253.7615-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713105253.7615-6-mark.rutland@arm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:52AM +0100, Mark Rutland wrote:
[...] 
> As the generic non-atomic bitops use plain accesses, these will be
> implicitly instrumented unless they are inlined into noinstr functions
> (which is similar to arch_atomic*_read() when based on READ_ONCE()).
> The wrappers are modified so that where the underlying arch_*() function
> uses a plain access, no explicit instrumentation is added, as this is
> redundant and could result in confusing reports.
[...]
> diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
> index 37363d570b9b..e6c1540965d6 100644
> --- a/include/asm-generic/bitops/instrumented-non-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-non-atomic.h
[...]
> @@ -131,7 +137,8 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool test_bit(long nr, const volatile unsigned long *addr)
>  {
> -	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
> +	if (!__is_defined(arch_test_bit_uses_plain_access))
> +		instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
>  	return arch_test_bit(nr, addr);
>  }
[...]
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> index 7e10c4b50c5d..c8149cd52730 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -5,7 +5,7 @@
>  #include <asm/types.h>
[...] 
>  /**
> - * test_bit - Determine whether a bit is set
> + * arch_test_bit - Determine whether a bit is set
>   * @nr: bit number to test
>   * @addr: Address to start counting from
>   */
> -static inline int test_bit(int nr, const volatile unsigned long *addr)
> +static __always_inline int
> +arch_test_bit(int nr, const volatile unsigned long *addr)
>  {
>  	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
> +#define arch_test_bit_uses_plain_access
> +
> +#include <asm-generic/bitops/instrumented-non-atomic.h>

Why not just:

	#define test_bit arch_test_bit

and similar for the ones that use plain accesses?

And not include instrumented-non-atomic.h here nor do the
__is_defined(*_uses_plain_access) change to the instrumented header,
which seems to overcomplicate things as it effectively just aliases the
non-arch_ name to the arch_ name if *_uses_plain_access is defined.

Thanks,
-- Marco
