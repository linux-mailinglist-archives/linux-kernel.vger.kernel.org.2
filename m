Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617AD326906
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBZVAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBZU77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:59:59 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96713C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:59:19 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d12so4522845pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E9OhPeZv8H8l4JzZvthxgzZUD/w6z54EOYcyVm1rrW0=;
        b=aa5aqPlXyhDLecFMTCRqyuUQfmG+lxSgKd17sNeS/uE2H5yEbSLaUImk4jIGSLxei5
         8XQHD2WM7AR2mbq/Xvwqp7b+qRvp6+d5Rn8Az7SyybbQ38O/4seAcwkKSQkxjvRlEhYo
         poM9On0S83+38WxLIDFqxhvkQ+7cVdW7mizsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9OhPeZv8H8l4JzZvthxgzZUD/w6z54EOYcyVm1rrW0=;
        b=Os/nkhAzdJEtjkTrBoufhu8yFu6xLmTcPi55SorJTHW/Ape4kK9juS6IC1cSao5AYE
         ZHi4zDFgFGlS9EAB5R/R2xGHDYUIDtVPk3pL8FfLIFFaH3XI3P1E3NbwIhTbAXxQX/xi
         mnmuWtrsOMxMsIuoe04xH8WU6tZM7nwhLE5pUMBLxGdwnI9/yQKrxm8LScYUGzKwY3Ck
         mysOC+FfAvjbx6JyOugSRKUh9IEol0YLnvXEmgKdTo+9wkIr+GK2rn09ebALyrWsj413
         oBiFhKXdGeHd4SeJ/vSRNtkWK3IhV1HOU7FpeYoKdtNDUu60dDMk02g1LaQNzQAM54jo
         M5dQ==
X-Gm-Message-State: AOAM533oSUqvI7m4v0ccxjG8GVGW6Q4ALWbBQ3MN3yHnhEYbM92zGRWD
        MdbreJy1RrOqcO/3db48Wun+BA==
X-Google-Smtp-Source: ABdhPJx/pWtXYYf37/ZE7cjY2XJ0WMrufaOvdsv3WL6SjGATF3YAnG7fog9qk9sHLxvxR9MPfgM+6g==
X-Received: by 2002:aa7:9246:0:b029:1ed:cfa4:f1a8 with SMTP id 6-20020aa792460000b02901edcfa4f1a8mr5058315pfp.73.1614373159094;
        Fri, 26 Feb 2021 12:59:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s138sm11291923pfc.135.2021.02.26.12.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:59:18 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:59:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
Message-ID: <202102261256.AF256702@keescook>
References: <20210226140352.3477860-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226140352.3477860-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 03:03:39PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> I sometimes see an assertion
> 
>  ld.lld: error: Entry trampoline text too big

Heh, "too big" seems a weird report for having it discarded. :)

Any idea on this Fangrui?

( I see this is https://github.com/ClangBuiltLinux/linux/issues/1311 )

> 
> This happens when any reference to the trampoline is discarded at link
> time. Marking the section as KEEP() avoids the assertion, but I have
> not figured out whether this is the correct solution for the underlying
> problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

As a work-around, it seems fine to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 926cdb597a45..c5ee9d5842db 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -96,7 +96,7 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT					\
>  	. = ALIGN(PAGE_SIZE);				\
>  	__entry_tramp_text_start = .;			\
> -	*(.entry.tramp.text)				\
> +	KEEP(*(.entry.tramp.text))			\
>  	. = ALIGN(PAGE_SIZE);				\
>  	__entry_tramp_text_end = .;
>  #else
> -- 
> 2.29.2
> 

-- 
Kees Cook
