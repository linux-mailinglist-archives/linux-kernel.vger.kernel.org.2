Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EC33359A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhCJFy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhCJFyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:54:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CAC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 21:54:08 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t26so10655315pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 21:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNEtVXt0RfVRQSwmfufZpZp3B8TMdZm9aigi4pizJ3M=;
        b=w0HDhik5H3fyLRd3IpjZ8C5QGxvN5icg0nYUJqOml/3VBkBDXnY1o51zmZ0+k2hT2/
         WNq/R2hUo5Pn76a9Du1sj6cGleRP4oM7brHxSmYyzKIfIMJEZ94+5TOPJygMbIbYrQ7d
         dq78fyVU6pBrzMaGKeGRdNj7Rc61qjVSXJ90TdG6S6bQcHOSfKsYCyu3RmSjrHKBmRV7
         eC6VFCHtl/3/kqPmCYkNHBt46SN5xQBvp12boUMmM8c6Fe1e6VY48cyvc9ib0KRRR+VF
         LmLondC6QLagVj0ddssSbaKyQRrEszXMsh9170vDPT/TDNyTGNj94oEFsKIHgRz0kEYu
         rj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNEtVXt0RfVRQSwmfufZpZp3B8TMdZm9aigi4pizJ3M=;
        b=DUzxNJID942Z02CsKfN2YyVQc2/9SZcpqlcpFS7OyOoy2wLdaYYatp/FfCTsvxDDgG
         IU6IVkUWdjpk1uFoeHq0d5RCAyPiwkppYQK5DuZXm4+QdCEEwGMIHXRUVKBysu96ekhf
         Z+M3XiKEDSxICue9mHdeXOezphDiEOZAvki+eu6sTRym4bXpdHcwK8CRvZrVil9UGK49
         7NuqRA84EJpzmYhQUAeCgn8mVebopW5GKpIbaFieLyNUsGQuJPGg15TWo2Qlv1Ep3619
         +5zF+nmzl8i3k58pVVRdGTj242BuP70/NhaOd1SWwyCykA8sN6IS9t0uvjPvMCj2IYpB
         EpGg==
X-Gm-Message-State: AOAM530XXwqPCWoy0XqKAE9KTaum+HKJkv5bniNwXeen1lRiEl6bKicQ
        e42hICRJxgC/3Z3XC6few1x9QIWUFAeoHJowx4n0eA==
X-Google-Smtp-Source: ABdhPJyCcLgmM5W12t5hpj5zmEzxffGBDqbKEAjzUJbivm2uiBGROc3xuvtASRvN6bF6dS5YCqX4AALc9T/P5m3V29M=
X-Received: by 2002:aa7:9e5b:0:b029:1f1:5ba4:57a2 with SMTP id
 z27-20020aa79e5b0000b02901f15ba457a2mr1602531pfq.59.1615355648459; Tue, 09
 Mar 2021 21:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20210310145514.3f3743fe@canb.auug.org.au>
In-Reply-To: <20210310145514.3f3743fe@canb.auug.org.au>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 10 Mar 2021 13:53:30 +0800
Message-ID: <CAMZfGtURAqAqzWgTmeGcDNeQVhcNLMngPJD2QkwkXqo3R8uF6w@mail.gmail.com>
Subject: Re: [External] linux-next: build failure after merge of the
 akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (sparc64
> defconfig) failed like this:
>
> arch/sparc/mm/init_64.c:2495:4: error: implicit declaration of function 'register_page_bootmem_info_node'; did you mean 'register_page_bootmem_info'? [-Werror=implicit-function-declaration]
>     register_page_bootmem_info_node(NODE_DATA(i));
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     register_page_bootmem_info
>
> Caused by commit
>
>   cd28b1a6791d ("mm: memory_hotplug: factor out bootmem core functions to bootmem_info.c")
>
> grep is your friend ...
>
> I have applied the following patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 10 Mar 2021 14:46:27 +1100
> Subject: [PATCH] fix for "mm: memory_hotplug: factor out bootmem core
>  functions to bootmem_info.c"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Sorry, it is my mistake. Thanks Stephen to fix this. This is the right fix.


> ---
>  arch/sparc/mm/init_64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 182bb7bdaa0a..c709b72e81bf 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -27,6 +27,7 @@
>  #include <linux/percpu.h>
>  #include <linux/mmzone.h>
>  #include <linux/gfp.h>
> +#include <linux/bootmem_info.h>
>
>  #include <asm/head.h>
>  #include <asm/page.h>
> --
> 2.30.0
>
> --
> Cheers,
> Stephen Rothwell
