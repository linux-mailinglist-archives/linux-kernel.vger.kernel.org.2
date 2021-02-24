Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0B32478E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 00:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBXXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 18:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhBXXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:33:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 15:32:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o38so2539026pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g5Gy0p/FQq9jX447dEvvCmbDqR5vUzjHm6T2Y74f/1I=;
        b=QFkVgQNTiu+/N75DJ6Z59aF8QOPIoxiX6qncyFFy4xTBds6g3WqzTlBjfdpPLRXISu
         iL89TgGf1xUQeRrY/5A2kdhWaGsYPaq3X7FaK8prs4/0BZ6aNr2Jqg1gfyp705qAqTRL
         OPlGqFU6exNaqMHv4QmNzz20egGMt7rHAhEPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5Gy0p/FQq9jX447dEvvCmbDqR5vUzjHm6T2Y74f/1I=;
        b=WkvCv3cFGotryx/5eVmuR3wXAJKhagGBeCx6Fuy8zVlp8nyrJm0Xgpyy2fJuVJuntG
         t713wItt/kCrG7uV1WmQtAz6N/OesPX88nopa2oi/vNg48t73E687loefRKgZJWOhzL5
         DDDJgs7jnQ/QWk06Sb0tJoSrkcHG/YEg3NSuYfukjZa8UN9LVtq1dlc/Pw61H5L90ICg
         6FIFxBwQcYkZwDtVgnmglre5Z0/gz6CwlNYrNptJKJNEPtU4Pqji+jzljgGKPwKIHmYO
         4v1tNmJt6AGo935mHCmoMOjNOkWT85DSx81+Y2WggjlMVTWgP94rS3gSbnAvQjLDcjvP
         MwJQ==
X-Gm-Message-State: AOAM532sJNi5vUm7CBdFLZajcbBqdDZ9WxaUUkwwjrAE8JnriXOXvRQk
        w4u0vteaer9SdJnAv/A86pwT3A==
X-Google-Smtp-Source: ABdhPJyEOHGWDGnSX+oJgmdx37VbyypUjZW+35RnUDRvzjr6jKfJ4VQJNyRorCN9sLTIUKVtbYHrFg==
X-Received: by 2002:a63:e42:: with SMTP id 2mr335730pgo.100.1614209540694;
        Wed, 24 Feb 2021 15:32:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o18sm3956468pjq.44.2021.02.24.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 15:32:20 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:32:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parisc: select
 FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Message-ID: <202102241508.A10EB51C8@keescook>
References: <20210224225706.2726050-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224225706.2726050-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 02:57:06PM -0800, Sami Tolvanen wrote:
> parisc uses -fpatchable-function-entry with dynamic ftrace, which means we
> don't need recordmcount. Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> to tell that to the build system.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 3b15cdc15956 ("tracing: move function tracer options to Kconfig")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Cross-build tested for defconfig, allmodconfig, allyesconfig:

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/parisc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index ecef9aff9d72..f56c67bbe495 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -61,6 +61,7 @@ config PARISC
>  	select HAVE_KRETPROBES
>  	select HAVE_DYNAMIC_FTRACE if $(cc-option,-fpatchable-function-entry=1,1)
>  	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
> +	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select SET_FS
> 
> base-commit: 062c84fccc4444805738d76a2699c4d3c95184ec
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 

-- 
Kees Cook
