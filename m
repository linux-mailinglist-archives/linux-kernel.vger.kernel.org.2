Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC93D1ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhGVGkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGVGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:40:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:21:17 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r80so5578133oie.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLFUlGMbAMX7RQ4HAnfk9BR/JId92NZautuPh7uZY4c=;
        b=XTsAN9XdFIMQTHX7QVw1elS+XQUFKXgdqLgEBd9EMIF574oAN+nKr2DgWucmOGfNZC
         8fwOUuO4LeGmY02aJ7bsOQXFapxqmf46VkihS4dWCcJzSSZZMs1cND6/dsz+t9rwc6Wd
         oK0bp82bEa+1fTv6c9NDnR+ZMwv0+HaPa03q8FR9zAke7158w2XHuDk96YOMtcbg3P3j
         vZUQlLEXf6tHAYvovw2rdWQc2D5zm1SawU+ECyOe+EZ3YZVpEWYqbdhwytX15rd1f+Zs
         xhqy0wNhen4/l1JmhgZWMl7qPX+eK4EUQucd1dCQVbKH0iCc5mYt7EygjUeBz5rLuoZT
         2l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLFUlGMbAMX7RQ4HAnfk9BR/JId92NZautuPh7uZY4c=;
        b=mDQW9bc6qdBc6Q0BqD2meT057jYZQyM9Sz0BgSOl0U6sue+oytHS/Yv1/BIVmA+80k
         DmCQEkIUfMLTHpALckV2OibrHnaZ5NEE2eBcLvZV7mPc0IAFZXGUTtQv7+yrTO9KquT0
         cFwr6begdkUA8eUvk4+lz3rqK/Uidw4TmEzBfmwDw7z3+qAbZb0nyi93rz82bAxpq2wZ
         Pctm0klD7t6KxbGNUZX7Z5SEWHKCvp6jc6Q6fjtUaMP/HGpHSTW3GfNmpzPF7RWfwFvf
         rFjr7YUXWQWU1lIxm6xwbXcYKtMj+75ctR1evxyX0nAOcgfiN41//U2jUTNflinix1go
         NOOg==
X-Gm-Message-State: AOAM532P9zuv8A2oC6LfsbCFi3tiINKKoY6AKGkBnF0/Q3PN44ORobYi
        dIdyGxLZRmDiq8lHboBqegoYjoyKMNBAgP2g5tvCng==
X-Google-Smtp-Source: ABdhPJy+WE6LjM5oC8TvMQsBWOaalgBWboC+grEtFpkbQe6z13yPFe7pQ0WNJxyvwzhDzIK84WAAa1MAODiVB+jyffs=
X-Received: by 2002:aca:fd44:: with SMTP id b65mr27021265oii.172.1626938476525;
 Thu, 22 Jul 2021 00:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210721155813.17082-1-mark.rutland@arm.com>
In-Reply-To: <20210721155813.17082-1-mark.rutland@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 22 Jul 2021 09:21:04 +0200
Message-ID: <CANpmjNN4bph4LuRXraNhz1d7kWzaehD+PBfeJS=bs0NbPs28Uw@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: simplify non-atomic wrappers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 at 17:58, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Since the non-atomic arch_*() bitops use plain accesses, they are
> implicitly instrumnted by the compiler, and we work around this in the
> instrumented wrappers to avoid double instrumentation.
>
> It's simpler to avoid the wrappers entirely, and use the preprocessor to
> alias the arch_*() bitops to their regular versions, removing the need
> for checks in the instrumented wrappers.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  .../asm-generic/bitops/instrumented-non-atomic.h    | 21 +++++++--------------
>  include/asm-generic/bitops/non-atomic.h             | 16 +++++++---------
>  2 files changed, 14 insertions(+), 23 deletions(-)
>
> Hi Peter,
>
> Are you happy to take this atop your queue/locking/core branch?
>
> This was suggested by Marco in [1], and also sidesteps some particularly bad
> stack spills as in [2].
>
> [1] https://lore.kernel.org/r/CANpmjNNVn4UxBCMg1ke9xaQNv52OMuQjr17GxUXojZKwiAFzzg@mail.gmail.com
> [2] https://lore.kernel.org/r/20210719100719.GB12806@C02TD0UTHF1T.local/
>
> Thanks,
> Mark.
>
> diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
> index e6c1540965d6..37363d570b9b 100644
> --- a/include/asm-generic/bitops/instrumented-non-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-non-atomic.h
> @@ -24,8 +24,7 @@
>   */
>  static inline void __set_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch___set_bit_uses_plain_access))
> -               instrument_write(addr + BIT_WORD(nr), sizeof(long));
> +       instrument_write(addr + BIT_WORD(nr), sizeof(long));
>         arch___set_bit(nr, addr);
>  }
>
> @@ -40,8 +39,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline void __clear_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch___clear_bit_uses_plain_access))
> -               instrument_write(addr + BIT_WORD(nr), sizeof(long));
> +       instrument_write(addr + BIT_WORD(nr), sizeof(long));
>         arch___clear_bit(nr, addr);
>  }
>
> @@ -56,8 +54,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline void __change_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch___change_bit_uses_plain_access))
> -               instrument_write(addr + BIT_WORD(nr), sizeof(long));
> +       instrument_write(addr + BIT_WORD(nr), sizeof(long));
>         arch___change_bit(nr, addr);
>  }
>
> @@ -95,8 +92,7 @@ static inline void __instrument_read_write_bitop(long nr, volatile unsigned long
>   */
>  static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch___test_and_set_bit_uses_plain_access))
> -               __instrument_read_write_bitop(nr, addr);
> +       __instrument_read_write_bitop(nr, addr);
>         return arch___test_and_set_bit(nr, addr);
>  }
>
> @@ -110,8 +106,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch___test_and_clear_bit_uses_plain_access))
> -               __instrument_read_write_bitop(nr, addr);
> +       __instrument_read_write_bitop(nr, addr);
>         return arch___test_and_clear_bit(nr, addr);
>  }
>
> @@ -125,8 +120,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch___test_and_change_bit_uses_plain_access))
> -               __instrument_read_write_bitop(nr, addr);
> +       __instrument_read_write_bitop(nr, addr);
>         return arch___test_and_change_bit(nr, addr);
>  }
>
> @@ -137,8 +131,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool test_bit(long nr, const volatile unsigned long *addr)
>  {
> -       if (!__is_defined(arch_test_bit_uses_plain_access))
> -               instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
> +       instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
>         return arch_test_bit(nr, addr);
>  }
>
> diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
> index c8149cd52730..365377fb104b 100644
> --- a/include/asm-generic/bitops/non-atomic.h
> +++ b/include/asm-generic/bitops/non-atomic.h
> @@ -21,7 +21,7 @@ arch___set_bit(int nr, volatile unsigned long *addr)
>
>         *p  |= mask;
>  }
> -#define arch___set_bit_uses_plain_access
> +#define __set_bit arch___set_bit
>
>  static __always_inline void
>  arch___clear_bit(int nr, volatile unsigned long *addr)
> @@ -31,7 +31,7 @@ arch___clear_bit(int nr, volatile unsigned long *addr)
>
>         *p &= ~mask;
>  }
> -#define arch___clear_bit_uses_plain_access
> +#define __clear_bit arch___clear_bit
>
>  /**
>   * arch___change_bit - Toggle a bit in memory
> @@ -50,7 +50,7 @@ void arch___change_bit(int nr, volatile unsigned long *addr)
>
>         *p ^= mask;
>  }
> -#define arch___change_bit_uses_plain_access
> +#define __change_bit arch___change_bit
>
>  /**
>   * arch___test_and_set_bit - Set a bit and return its old value
> @@ -71,7 +71,7 @@ arch___test_and_set_bit(int nr, volatile unsigned long *addr)
>         *p = old | mask;
>         return (old & mask) != 0;
>  }
> -#define arch___test_and_set_bit_uses_plain_access
> +#define __test_and_set_bit arch___test_and_set_bit
>
>  /**
>   * arch___test_and_clear_bit - Clear a bit and return its old value
> @@ -92,7 +92,7 @@ arch___test_and_clear_bit(int nr, volatile unsigned long *addr)
>         *p = old & ~mask;
>         return (old & mask) != 0;
>  }
> -#define arch___test_and_clear_bit_uses_plain_access
> +#define __test_and_clear_bit arch___test_and_clear_bit
>
>  /* WARNING: non atomic and it can be reordered! */
>  static __always_inline int
> @@ -105,7 +105,7 @@ arch___test_and_change_bit(int nr, volatile unsigned long *addr)
>         *p = old ^ mask;
>         return (old & mask) != 0;
>  }
> -#define arch___test_and_change_bit_uses_plain_access
> +#define __test_and_change_bit arch___test_and_change_bit
>
>  /**
>   * arch_test_bit - Determine whether a bit is set
> @@ -117,8 +117,6 @@ arch_test_bit(int nr, const volatile unsigned long *addr)
>  {
>         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
>  }
> -#define arch_test_bit_uses_plain_access
> -
> -#include <asm-generic/bitops/instrumented-non-atomic.h>
> +#define test_bit arch_test_bit
>
>  #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
> --
> 2.11.0
>
