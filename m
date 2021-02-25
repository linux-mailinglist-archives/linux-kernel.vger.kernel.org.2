Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02832573E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhBYUDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhBYUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:03:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E2C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:02:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id h4so4502976pgf.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LVMYBgKGd958d/iMPLHmMnrCcZl3qNsJjm0FQKo+4A8=;
        b=bNflY5pod7RiRpbDP9rLxG6gbfGoCiH28u0XczC3Ygxb45JF8qUxEjdjW0t+MsrUPu
         sJAmkoHvlssJPV6NG9nAvMchs+qOPWzgnnpRLVp3wlnl57AsgguY9G7ceD3TRNOx9GbB
         ugMPkLJ/TsacjW87kp4RRhOvg3pjy77Tjq1UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVMYBgKGd958d/iMPLHmMnrCcZl3qNsJjm0FQKo+4A8=;
        b=jXYR0AICJeEiE1cW7wp5oDsVL2zSRFPPCgHE7Lo3EDZ9TaLhDTyBzw2UmI2G6gmOeV
         PeVOboV1zMv4u58Fq7j43JJjK2e7FxjCLhHvyhtsmzsTZsBi+P07YjaO7JveB4J43/W1
         fspXE/1friFDJB/vx+7xYm4NX8fsfIpVNzHDQh2GIyHPiPSOunp7wHxTu1Toi5yhm78D
         scv3cFApp5XJESWy6MAjwhf196L9xAiodNuPuTS5bDbLWOgXbeo1jTxdomqLKX2s9rRQ
         bliCU5cG2h7Ayro7dVnNAcTUvfE3qebhEmu2iuT5I8LMsZArQZ7Xpjc/llv/B4Std+5S
         g6tQ==
X-Gm-Message-State: AOAM530BOAHNAwXuSth3m8lZE5lB3yD+NYekLMbdsXlWUgMhtYlHacj0
        wNsBIw8TSJXPmWPWHedmdphxXQ==
X-Google-Smtp-Source: ABdhPJyQGxSFB5eIUxsc76+xMlFrnOwN1pun2oUYPQmeZSwhZ8dK6kftc3nkUHYW0ZwlFqOV8GqHJA==
X-Received: by 2002:a65:4083:: with SMTP id t3mr4523429pgp.150.1614283373710;
        Thu, 25 Feb 2021 12:02:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v16sm6522310pfu.76.2021.02.25.12.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:02:53 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:02:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: remove .thinlto-cache by 'make clean'
Message-ID: <202102251201.F444E4E2@keescook>
References: <20210225193912.3303604-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193912.3303604-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 04:39:12AM +0900, Masahiro Yamada wrote:
> 'make clean' should remove build artifacts unneeded by external module
> builds. Obviously, you do not need to keep this directory.

As in, it should exist in the "clean" target, rather than "distclean"?

> 
> Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

That works for me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b18dbc634690..8601a86ebe38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1501,7 +1501,7 @@ endif # CONFIG_MODULES
>  # Directories & files removed with 'make clean'
>  CLEAN_FILES += include/ksym vmlinux.symvers \
>  	       modules.builtin modules.builtin.modinfo modules.nsdeps \
> -	       compile_commands.json
> +	       compile_commands.json .thinlto-cache
>  
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES += include/config include/generated          \
> @@ -1515,7 +1515,7 @@ MRPROPER_FILES += include/config include/generated          \
>  		  *.spec
>  
>  # Directories & files removed with 'make distclean'
> -DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS .thinlto-cache
> +DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
>  
>  # clean - Delete most, but leave enough to build external modules
>  #
> -- 
> 2.27.0
> 

-- 
Kees Cook
