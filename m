Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC6422C39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhJEPWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhJEPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:22:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E434C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:20:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i84so46342185ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6U3A2TkKi5u+zlp1bWUocfIN/kiEDVADM7cYHhDKH6Y=;
        b=eJfEToxllcMDKYkRz5XmfBYFWtUufSPRxIkRc0G3EqqeQz+rMrMSKeNNSmZNs9XyOA
         lPxl5yo30pjEhGgxLaN4fOv4Yea59SH9vSmi6ZugnCX0zJzSVHOjY3lD8UkOq+vvNJ41
         cSqKBq0e0CMhutTpR6Xl+IoqBUndWfbEGN/aWJab0ZnD/8tHDGTMpcVp9THPMrZd/RXN
         c31AD1wONPCBJ9sz/QALIlueDa9jhMVq4xt6eg38hhhN47+hO2211RIUtACfmAdmmpfg
         nPuH5B4YvMNj5sKwlnVyhQokK+2ogeE+2zj4R1i9H6P94oSHBcqEjLEiZiKQlBvGK505
         BCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6U3A2TkKi5u+zlp1bWUocfIN/kiEDVADM7cYHhDKH6Y=;
        b=FsfRN56RsFMjrXn9iUe7GZIjNhZFkbNYXvxuzv2/U7ryR6J4+aPnIR2o/S6YJ2SPb/
         ODnlilvKC5ENhikc++0iTiO7VBj68PG2zB+F6ocgYCStM+xz64Ke1wbdGqK3rXT/v3Bz
         Y9VfyeuaLujWaNvDJpxz4K+no9dEMbQt9Y2uJwMnayQnYxUuIze+bmJoQuRdhFdlDLBi
         A8La3wn6YKP6Ku4W7ycQ4LTTQ+98KTwzFazlmy8sgLc7USltiQWSVxST8lygvEuKxLzH
         K3kziEm3JLjjxXLlhx0BsYV2sQyrYvwsSZaj/Rp7lRAdX3jWTPtTmekRVBkERnPi9ZyM
         PW9w==
X-Gm-Message-State: AOAM531snW1+RpIaAlKdDoaiy1ppz3d5tRnO/iQfQcNzG2HARKlTQkO+
        9WOMJ2KeS+6vI4qM5+rd086ZvfPvGZQsKlNdA6OvGw==
X-Google-Smtp-Source: ABdhPJw50Kehp0YzYo8ni/ZcFuH0xfJPfEwkq0tDG/rca4iUXWkwwLZ8rjn4afptZgPUf2AmMQoAZXXl0rJ2NgOaWug=
X-Received: by 2002:a25:cf8f:: with SMTP id f137mr24344842ybg.338.1633447214002;
 Tue, 05 Oct 2021 08:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211005123645.2766258-1-sumit.garg@linaro.org>
In-Reply-To: <20211005123645.2766258-1-sumit.garg@linaro.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 5 Oct 2021 08:20:02 -0700
Message-ID: <CABCJKuesYcGdKLi1YqHP3PU5n6vf-3Q-A+UNyCLzsoJ+0oiKmw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: ftrace: use function_nocfi for _mcount as well
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, ben.dai@unisoc.com,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        daniel.thompson@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Tue, Oct 5, 2021 at 5:37 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
> only fixed address of ftrace_call but address of _mcount needs to be
> fixed as well. Use function_nocfi() to get the actual address of _mcount
> function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
> with jump table addresses which breaks dynamic ftrace as the address of
> _mcount is replaced with the address of _mcount.cfi_jt.
>
> This problem won't apply where the toolchain implements
> -fpatchable-function-entry as we'll use that in preference to regular -pg,
> i.e. this won't show up with recent versions of clang.
>
> Fixes: 9186ad8e66bab6a1 ("arm64: allow CONFIG_CFI_CLANG to be selected")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>
> Changes in v2:
> - Added fixes tag.
> - Extended commit description.
> - Picked up Mark's ack.
>
>  arch/arm64/include/asm/ftrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 91fa4baa1a93..347b0cc68f07 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -15,7 +15,7 @@
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
>  #else
> -#define MCOUNT_ADDR            ((unsigned long)_mcount)
> +#define MCOUNT_ADDR            ((unsigned long)function_nocfi(_mcount))
>  #endif
>
>  /* The BL at the callsite's adjusted rec->ip */
> --
> 2.17.1
>

Clang >= 10 supports -fpatchable-function-entry and CFI requires Clang
12, so I assume this is only an issue if
CONFIG_DYNAMIC_FTRACE_WITH_REGS is explicitly disabled?

Nevertheless, the patch looks good to me.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
