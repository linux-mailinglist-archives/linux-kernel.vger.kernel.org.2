Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCA42364D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 05:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJFDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 23:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhJFDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 23:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633490990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Py+JZnh73iO8dfi3ucj0KCUA94S2WthHSRpjsAjnr5s=;
        b=OaCE1eXyLCO8zelaA+mlUXj0rTkl1ZVXsvYnh+p5Se1/t33An5+uK6QjfiDAm4M9mYqVpU
        Z3mPMfZj4UF1Wdq2WM9nn7vXU0OQ4mKJmUTlKye6usaCVokNCI6sb1bGumj8+8qHIuAZu4
        Kca/pI6NxmyZzQ3rtJn1OS9CHhiiWsk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-EbJjAFUbP7SgVCX4jnagPw-1; Tue, 05 Oct 2021 23:29:50 -0400
X-MC-Unique: EbJjAFUbP7SgVCX4jnagPw-1
Received: by mail-oo1-f69.google.com with SMTP id p1-20020a056820044100b002b67bf7e912so937241oou.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 20:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Py+JZnh73iO8dfi3ucj0KCUA94S2WthHSRpjsAjnr5s=;
        b=JOBdz+r4Z0MijlZ5Mq/xmQcWykjdNFmv4hkPmQJEg5kqpAyfe1NWtdVniOtS7FKYfh
         KQmOsWX1sX43vJowk3/hXHcMBom9POmDvYbgsNlSjBpwao/ngZjmkQxfSwKTOOYETaNB
         3hWQUtflibLGzMmF4yLpmAWy04r/kq26pG/T2G6hSBsInCutChzn66FwmLO/sQ/JsqoA
         ObXiB2NfXs/j3I2Q2lBGgtdwHZqdKs1lKi1AqjOYIsSIpYX+RiwUGUcyOlm9tPmVURNx
         axkS5qWJ9FQUIin/WMfXVLELi2cSG9bIE4xLaqM5b3yqprCwbBjUHrPQ/TUi/yYN1xBJ
         9mJw==
X-Gm-Message-State: AOAM531xzl1twnQlK/cCwTpcyyzqfnAPEsLJAub8L1pLRaoJ48Jmrqyv
        pt1+4m1urKEzMf73UPJSvt6nh7qLB6DntJ0aDGCAgqBSbEyx3oyLpRCaD91pi/qAMueTSx0aoQX
        1d7IL6iyNkjQJAOKCgxObacF6
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr17609236otp.143.1633490989299;
        Tue, 05 Oct 2021 20:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2vFAYge4anWPhwrb90uw13BuOS6xxF266F6ouThw1f6/Zl32C6XLGYYQ1vnCKVEYNl3IbZA==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr17609222otp.143.1633490989040;
        Tue, 05 Oct 2021 20:29:49 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bb39sm2950182oib.28.2021.10.05.20.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:29:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:29:45 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006032945.axlqh3vehgar6adr@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930180531.1190642-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler changes function references to point
> to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/ftrace.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 832e65f06754..67de28464aeb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
>  extern int ftrace_update_ftrace_func(ftrace_func_t func);
>  extern void ftrace_caller(void);
>  extern void ftrace_regs_caller(void);
> -extern void ftrace_call(void);
> -extern void ftrace_regs_call(void);
> -extern void mcount_call(void);
> +
> +DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
> +DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
> +DECLARE_ASM_FUNC_SYMBOL(mcount_call);

I'm thinking DECLARE_ASM_FUNC_SYMBOL needs a better name. It's not clear
from reading it why some asm symbols need the macro and others don't.

I guess it means "an asm text symbol which isn't callable from C code
(not including alternatives)"?

DECLARE_UNCALLED_SYMBOL() maybe?

-- 
Josh

