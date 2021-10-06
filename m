Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0530A424952
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhJFWAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJFWAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:00:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05171C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 14:58:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so15961278lfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDe/CCgzbVL8cdlihpSKcZ9kkAIpNWk3w42F2ZBCbZg=;
        b=DpDarEaj1O5yO8x4BdIM2Z/QGnUEayQsIHKYbYRjnyzgH1esE022dwFqrhXwc6O5fb
         JOSG4NCOh4lBDQG6UOc7cvFWeA+sj0AzYTEr5cClzf3a4p3Y8LB8oqaZqBjiauJr5xg1
         8ESjgwjYcEbeS9PfhXdSQvk9oMdgLTik5/iZ4V2CY+r2yFgBbUSdTXI9yjXFPtgJEb7V
         HiCutC1fb4tudyIy8/s+qObuEJFapRCQJNeYJyQ1ywTjoFE7Q9b+HFci138yJTYwwokH
         z2w9tMdPXLiJSuSsAdZT7xIXmA9tEjdSrm4bRyzkEn2vaaR7N8RIYBh5M4vHHJi/EQaS
         cLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDe/CCgzbVL8cdlihpSKcZ9kkAIpNWk3w42F2ZBCbZg=;
        b=ZoKn7vnT0S3Bj5vmALEKgN3x2GWqzoYXoQVckf+61fulooYQuU6dBD+Cs1UClg+uES
         ZmrutkCuyty8ETVrgQXNW5yy0IutX7vihBGZLPLWyYWiDROgIk1hK3NkMrj36H+utJ4a
         ULmT1krbqQmVMwbjxOf8mXS5/PMB/JUkYkJ3rDrQdkutZIeF8C55Qmdbv7RBHTNXY7DX
         ei9vWV4fwlpR1hiyXCOdrkDd7YQA5CoGXBsZhPdPo75v9tZ5+6YNZUKOTQt2PwPGFwdF
         xyCW6nfDtKDLrX/jQstwKFn6poS7H9qt8QcFeP2FpWJcb9+E6pmmMEZVk8a0faGWl6I+
         H+ig==
X-Gm-Message-State: AOAM532DWUjgu7Evjg6PN+lCTtt20mng714IaZMYWrfJfdxs6NshdCxi
        oJ9FRrzmZIsg6NAHHYnpv5TB7/bb18dIb8w8b7NSeA==
X-Google-Smtp-Source: ABdhPJw6/4P9YojbZ4+TF/BbAh9j+NIH0UVeOWkFJsuSEGRFBhFgpeb3nv6DA7bKovrjbGLFVHAi7Nh6gnC/VpLE9m8=
X-Received: by 2002:a05:651c:b20:: with SMTP id b32mr578167ljr.62.1633557528140;
 Wed, 06 Oct 2021 14:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211006082209.417-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211006082209.417-1-lukas.bulwahn@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Oct 2021 14:58:36 -0700
Message-ID: <CAKwvOd=X-ZFPraS2EL24ps1aKdT3bWhtASA0vUjXdzo655XGiQ@mail.gmail.com>
Subject: Re: [PATCH] elfcore: correct reference to CONFIG_UML
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Catalin who just sent a very similar patch after Lukas:
https://lore.kernel.org/lkml/20211006181119.2851441-1-catalin.marinas@arm.com/
EOM

On Wed, Oct 6, 2021 at 1:22 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 6e7b64b9dd6d ("elfcore: fix building with clang") introduces
> special handling for two architectures, ia64 and User Mode Linux.
> However, the wrong name, i.e., CONFIG_UM, for the intended Kconfig symbol
> for User-Mode Linux was used.
>
> Although the directory for User Mode Linux is ./arch/um; the Kconfig
> symbol for this architecture is called CONFIG_UML.
>
> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
>
> UM
> Referencing files: include/linux/elfcore.h
> Similar symbols: UML, NUMA
>
> Correct the name of the config to the intended one.
>
> Fixes: 6e7b64b9dd6d ("elfcore: fix building with clang")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20211005
>
> Arnd, please ack.
> Andrew, please pick this fix.
>
>  include/linux/elfcore.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index 2aaa15779d50..127716b58235 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -109,7 +109,7 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
>  #endif
>  }
>
> -#if defined(CONFIG_UM) || defined(CONFIG_IA64)
> +#if defined(CONFIG_UML) || defined(CONFIG_IA64)
>  /*
>   * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
>   * extra segments containing the gate DSO contents.  Dumping its
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
