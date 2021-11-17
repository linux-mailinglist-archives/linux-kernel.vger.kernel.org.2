Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3B454B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhKQQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhKQQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:43:56 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E43C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:40:57 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v64so9314643ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYlBsPKAPVXTMCSSRYpxvxa312Osfwo6gnshzLQC9yc=;
        b=Xh9gnW8FLSerztZnfVAUkGclmjUKWvuCoh2whMWxIc8E9WBIFIE87JFx1fAVNqHSIZ
         70TUmoTS7U/eo6T2/3KUotOntzcQgGBdYt3OAMRy8mBCsvXDF2phPsVHMOXdG2nXiz2q
         0k6rs/arLTscrBuLNW+IQSC1a9RdPi8NXG+C2uKiDu+Tubl248BqzKzkc6xFaE/+BGTP
         HCgOK2QqOyGbCSdnslSYlbo/EfbZSyKTIb5La0YvxMAIlPhkMbPVUVbfAFSvdWlVITOF
         zbf61Z+/51kKQkuCWP0cV/Q6U8J8Dyd3CP4Gd8sphjsyGY2bJqYhriacBeREan9DYayG
         YUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYlBsPKAPVXTMCSSRYpxvxa312Osfwo6gnshzLQC9yc=;
        b=YHQTCVnBtBV8O5eKeizHnV5cg3aquzutqr4LP9R+lcZU6HaxN7OHBKq0o8F2YUL8KI
         xXWu6azhQlC231To0g8XYrU869Py0dE9YqcTq/4hZnUHaXcJ2EzOGYcXN0z76IQYw34T
         7TXrDTtoW/CwhGs4cFuY6iW1ugqFZjvHZ8czihqcwDWnwy3xEpVlgSqjKY1LfaIlqf6K
         e+V8LeT2jnviQI1Z3XqofYwDRt3oMTBEb8/GhLpAvC/2ADsuwvn3xRDydt0T9wXE7e/u
         JzDQx6uS4TDc7uTFtZWhQBHoBxrZjUcB80wFgJlvKcPGSO1/qkrJBJc0GQ63k2K5paFM
         iaQg==
X-Gm-Message-State: AOAM531S9f+lpoGwL4UUtrZssjbu21do+rht+8COP9YIUpDkWLDDb/Jp
        dugPfmRlUWrh0VEoMH40j/cK/R4RDaznQroMLVX8ag==
X-Google-Smtp-Source: ABdhPJwaS+UKQMzGWKVRqtVydCW6VlVne8hctqcgFWdTtobB/CBbAvE6GQ3cnONw1umcyKYspr8Brg9i5yW6giVTGR8=
X-Received: by 2002:a25:69cc:: with SMTP id e195mr19784770ybc.456.1637167256692;
 Wed, 17 Nov 2021 08:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20211117113532.3895208-1-maz@kernel.org>
In-Reply-To: <20211117113532.3895208-1-maz@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 17 Nov 2021 08:40:45 -0800
Message-ID: <CABCJKucEkjnYf4aEXccoc8Yk=dm07HfqiPBBmw_tFsnbHM5vSA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Force inlining of erratum_set_next_event_generic()
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 3:35 AM Marc Zyngier <maz@kernel.org> wrote:
>
> With some specific kernel configuration and Clang, the kernel fails
> to like with something like:
>
> ld.lld: error: undefined symbol: __compiletime_assert_200
> >>> referenced by arch_timer.h:156 (./arch/arm64/include/asm/arch_timer.h:156)
> >>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a
>
> ld.lld: error: undefined symbol: __compiletime_assert_197
> >>> referenced by arch_timer.h:133 (./arch/arm64/include/asm/arch_timer.h:133)
> >>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a
> make: *** [Makefile:1161: vmlinux] Error 1
>
> These are due to the BUILD_BUG() macros contained in the low-level
> accessors (arch_timer_reg_{write,read}_cp15) being emitted, as the
> access type wasn't known at compile time.
>
> Fix this by making erratum_set_next_event_generic() __force_inline,
> resulting in the 'access' parameter to be resolved at compile time,
> similarly to what is already done for set_next_event().
>
> Fixes: 4775bc63f880 ("Add build-time guards for unhandled register accesses")
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Thanks, Marc. I can confirm that this fixes the build issue for me.

Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
