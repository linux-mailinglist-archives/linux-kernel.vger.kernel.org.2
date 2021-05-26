Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB63910E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhEZGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhEZGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:51:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10033C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:50:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 16so46166wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cPLEYZmDO5XwUzN79SjixZzrfphY30xy0/qeLOTN9Ek=;
        b=kdzcAq5PnjAwY+htbKkfCl+ZxHMyve5FELa8mqqsZuGuGzvAj60FInEARHsIPPWUjH
         SkUYmrMCI2Y977DhOHICWXe7lKDA6nai4Z6aK6WYO6P/d2dI+eiYVq/F+q1XBZQrrTZM
         fye5kjahs50UV6ncKLFp4zUpDzVpnvzK0+PvrEPnXQY1n8+Jnps93z7yJFvtoW638ioh
         MUrA6zDBcIQ/M6GGfNXAjW58bjZ505E6OTvj17G1TJVAD4iBR3KBsIiPT5mxYUzB4Chf
         4zJgzNvq8ktRsgXbMKuCITR5+5YhpN+axbLDiSHvfMT5n84sEcpA/fHoB0mFpMWkZA6Y
         ThNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=cPLEYZmDO5XwUzN79SjixZzrfphY30xy0/qeLOTN9Ek=;
        b=LqEx6y3f0/S6ofKSfNEouJYnNdmvgI8uO/8sOmoIXN+iuAq3N1BIFEPYdRszdJgm9w
         jFAV3+flP5bERse3q6NYhfw2CVooQPjx1k33jB7dZ8ksCg8OxP3IPhn8wQh71AZL113s
         ekk2HZgfPMZIE+r3IWcA4gB/SFqBazvXW7WsFu2X8gOziepTPXqQSTi6+aIUEhdSAf4i
         5VPcnObgCD1vjTGi92qzdDG0H1vf6olaXXuf9w1BqCaUQnEcytfrUgc4waI19R/4KMwe
         XsSVLR6SntzRG/ZR618fUhqa7C8JNa+Bg7ju7VlbamoLwbOjWx2Xkzz0Xd6o1+K6a9/S
         K7HA==
X-Gm-Message-State: AOAM530FV5aHHCd12JilZzN2DpJ06JwZF1HZCHhX1X7qZjY6nkbp/niM
        mSQYhojwCMPMINyfAc4xzUc=
X-Google-Smtp-Source: ABdhPJwaAmPke/FV5fWbBtJUq+5AYOF5xdBFGV5bgY+b3muskdE15XYgaaba6QiXCKVJ1V2DaLq7mQ==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr1802935wmc.159.1622011822654;
        Tue, 25 May 2021 23:50:22 -0700 (PDT)
Received: from gmail.com (0526ECF1.unconfigured.pool.telekom.hu. [5.38.236.241])
        by smtp.gmail.com with ESMTPSA id q27sm18828702wrz.79.2021.05.25.23.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 23:50:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 26 May 2021 08:50:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] x86: fixmap: use CONFIG_NR_CPUS instead of NR_CPUS
Message-ID: <YK3vrIB7cWop+UIW@gmail.com>
References: <20210521195918.2183-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521195918.2183-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> Use CONFIG_NR_CPUS instead of NR_CPUS for an enum entry item.
> (Alternatively, #include <linux/threads.h> unconditionally instead of
> conditionally.)
> 
> This fixes 100+ build errors like so:
> 
> In file included from ../include/asm-generic/early_ioremap.h:6:0,
>                  from ./arch/x86/include/generated/asm/early_ioremap.h:1,
>                  from ../arch/x86/include/asm/io.h:44,
>                  from ../include/linux/io.h:13,
>                  from ../mm/early_ioremap.c:13:
> ../arch/x86/include/asm/fixmap.h:103:48: error: ‘NR_CPUS’ undeclared here (not in a function); did you mean ‘NR_OPEN’?
>   FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
> 
> Fixes: e972c2511967 ("mm/early_ioremap: add prototype for early_memremap_pgprot_adjust")

I believe this patch is in the -mm tree, not the x86 tree.

> @@ -100,7 +100,7 @@ enum fixed_addresses {
>  #endif
>  #ifdef CONFIG_KMAP_LOCAL
>  	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
> -	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
> +	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * CONFIG_NR_CPUS) - 1,
>  #ifdef CONFIG_PCI_MMCONFIG
>  	FIX_PCIE_MCFG,
>  #endif

Please resolve this bug properly:

 - Don't sprinkle low level headers with random CONFIG_NR_CPUS conversions.

 - <asm/io.h> currently includes <asm/early_ioremap.h>, but this seems 
   unjustified.

 - Once early_ioremap.h is gone from io.h, it's potentially possible to 
   include <linux/threads.h>. More work to resolve dependencies might be 
   needed though.

Frankly, I'd prefer if such a low level header dependencies change came in 
via the x86 tree so we can properly review it, test it, and keep it 
working. Right now I can only guess what is needed here...

Thanks,

	Ingo
