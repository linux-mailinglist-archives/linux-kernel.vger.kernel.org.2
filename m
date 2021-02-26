Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944B43262E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBZMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBZMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:48:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:48:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u125so7665993wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMdyoGpsUz60QnR0spjaWP1dFPFBzwuCMWnm1un/xsQ=;
        b=eEqgi9n7vxuk2yqcdRUd4PX6Qj+/MYB4oOjvk4RRX82nzyg6TmMSs+YV+2a00qFACG
         2u262/C+xHk2s4RaVNji6NzJwU++QP7GPlxG4e7THZ45d0L1zZ9uzVmDr7BjZ2v1bt5b
         fAbCnk9k/w/8RLdjCjtqO6UGTdJrCTS8fe/58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMdyoGpsUz60QnR0spjaWP1dFPFBzwuCMWnm1un/xsQ=;
        b=f8wrCwQCiZHzkrafOmzCLJ6j3v2C0dXlBDnjA/K9m0iGpnS5z5zLn91O7bWLTxym1T
         jqCJVb5Z8q6+3J0L8Qh80ck4XySzM+k9YnmMhondAwr50n/+RDOntLpJgkuHrzk9YUiX
         MwothMU4e3k5DtQTbGUZNycOcSlU+YTXx+01nsRCRSBQAT2a+cQPFOgWsaCGTG10C3mw
         LDg1k9HfM7xP5tXWnNuTQDq6B+lRUkUavCX4xsUttuoesezub66Gs2h7bkQYA739ax6x
         WzDNdt4LsUVJRnCAaJxroK82PerCI+rjsveVRC3As6Tp1EDXf7T4jnp9w29fneB8J2lG
         z7gw==
X-Gm-Message-State: AOAM531XvFLSHyVSqMUvOv+c+X9zOUOhGlzv0UfuWznHnQPoWN6JseHx
        jL7DLdk4DWgoxnB94YRIyi+t9g==
X-Google-Smtp-Source: ABdhPJywxeh7Tv35PnGaJd8kuTd9tEkf3oMPkGi2cb3V+dxoFjbIk+aaDAy6hop6xlcSBR8AJakrQQ==
X-Received: by 2002:a05:600c:3546:: with SMTP id i6mr2819459wmq.24.1614343678763;
        Fri, 26 Feb 2021 04:47:58 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:87b5])
        by smtp.gmail.com with ESMTPSA id y18sm12668754wrq.61.2021.02.26.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:47:58 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:47:58 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ia64: Depend on non-static printk for cmpxchg debug
Message-ID: <YDjt/lI82VzZcCgq@chrisdown.name>
References: <YCflN5zTvo5mxvKY@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCflN5zTvo5mxvKY@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ akpm, linux-mm

Hey folks,

Chris Down writes:
>With !CONFIG_PRINTK, printk() is static in the header, but ia64's
>cmpxchg.h with CONFIG_IA64_DEBUG_CMPXCHG doesn't take this into account
>before trying to use it as extern, resulting in a compiler error:
>
>    ./include/linux/printk.h:219:5: error: static declaration of 'printk' follows non-static declaration
>    219 | int printk(const char *s, ...)
>	|     ^~~~~~
>    ./arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of 'printk' was here
>    142 |   extern int printk(const char *fmt, ...);  \
>	|              ^~~~~~
>
>Make CONFIG_IA64_DEBUG_CMPXCHG dependent on CONFIG_PRINTK to avoid this.
>
>Signed-off-by: Chris Down <chris@chrisdown.name>
>Reported-by: kernel test robot <lkp@intel.com>
>Cc: Tony Luck <tony.luck@intel.com>
>Cc: Fenghua Yu <fenghua.yu@intel.com>
>Cc: linux-ia64@vger.kernel.org

I now see that last month ia64 was marked as orphaned, so I'm going to send 
this over to Andrew/-mm.

Andrew, any chance you can take this in your tree? It's causing spurious LKP 
noise for some recent work on printk and would be great to have in -next.

Thanks,

Chris

>---
> arch/ia64/Kconfig.debug | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/ia64/Kconfig.debug b/arch/ia64/Kconfig.debug
>index 40ca23bd228d..2ce008e2d164 100644
>--- a/arch/ia64/Kconfig.debug
>+++ b/arch/ia64/Kconfig.debug
>@@ -39,7 +39,7 @@ config DISABLE_VHPT
>
> config IA64_DEBUG_CMPXCHG
> 	bool "Turn on compare-and-exchange bug checking (slow!)"
>-	depends on DEBUG_KERNEL
>+	depends on DEBUG_KERNEL && PRINTK
> 	help
> 	  Selecting this option turns on bug checking for the IA-64
> 	  compare-and-exchange instructions.  This is slow!  Itaniums
>-- 
>2.30.1
>
