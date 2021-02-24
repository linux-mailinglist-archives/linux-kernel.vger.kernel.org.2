Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFBD324765
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 00:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhBXXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 18:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhBXXMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:12:34 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B054C061574;
        Wed, 24 Feb 2021 15:11:54 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d9so3869259ote.12;
        Wed, 24 Feb 2021 15:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGCpl6JCFdhTjBwlRYB+TBuuzz1bXs8uoX9BzO9G/m8=;
        b=F1ssa3J1gJdqXQw/5G5pyX3NbGNl5UqYfS9vzyDOgq35DlKPuuZeDq2hltQwrtQ5wS
         cq7+QtEaOZwT1rKWG/rPJBflIZGQu+lgg3rQUQpcOTHEoTJPmzeTPsvD/w3AkLn/R4pB
         l4akOkR0fhPZt6L+pHvhGDHxtSYFxUkfxV46LTs9ZL2Z+tM0gQikyh1I+atBR4D6vNaR
         f2PqMAcaa3Z6YdiAFa7h9NKl53ZLZnWutwqe7P/t6ChFS9tX5+OUET5iFVMGiMyOVb+i
         +fWjXXI6MStw9Oc7jP8pegLQPEfUBd5uPlIKK4TYXA4ksOo9t8QQs4F1wjJqRdqHZPzl
         Sw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGCpl6JCFdhTjBwlRYB+TBuuzz1bXs8uoX9BzO9G/m8=;
        b=R6HwJ12/MMwdWaPF+d/+0DSpXwlWOQU6KvbxDr26shtLU1DtqUX5LRenIZXopNt5oq
         p66xlLw7uvdiqCrHBzWlMSLawNzNvn538C79VqU4USOmE2t7I0zA/VdpdeDxaHh483C+
         KmfQA2Dh48/OSo9taGXFb1JYAB9asnqUv//HNr9ewmuagrztHMYtzFG5PzGvfPBZ7oqZ
         DCudJC+qLJgqL68DCCCJeqIM1Jjcc+I7EPGw/+nNsq7oLdyJ9qaAmOoMl2iycdlkjfX2
         0Q/Hv+BPe2UK7gAmkAiLcxZx32UTuEsd+Xpl+8OHEhSXnHRJYbFrW5vB00FcIVAuVoEG
         UGQA==
X-Gm-Message-State: AOAM5336z/ZnbzQAvX65fi3nQoY8Uqu+A1Be16NKXKAtIfv5SmF0h8AB
        hSajV0V+EG2L2oxFBtjLCl8=
X-Google-Smtp-Source: ABdhPJyZwRrXioEBN2DZ7eXTrPJ7B8RfHPgaghnqxaDol8B02fjKSVNo7SdPpeXriRgsPrGz64HKDw==
X-Received: by 2002:a05:6830:1557:: with SMTP id l23mr26635317otp.181.1614208313933;
        Wed, 24 Feb 2021 15:11:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12sm707867oon.12.2021.02.24.15.11.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Feb 2021 15:11:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 24 Feb 2021 15:11:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parisc: select
 FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Message-ID: <20210224231151.GA222480@roeck-us.net>
References: <20210224225706.2726050-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224225706.2726050-1-samitolvanen@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

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
