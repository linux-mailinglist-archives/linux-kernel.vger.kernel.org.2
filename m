Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80141B97A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbhI1Vlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhI1Vli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:41:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974ACC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:39:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ba1so541449edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDh9+EkJ1XaioXG706gkM4MC/zvXOsIVOcJCDT0kPlA=;
        b=By1oZKn5ZK9lpmbNq9hmZ9zb4Q5xi6mybeF9MwvF2f8trWsWis+vN0IT+3VXJSeKXg
         +R2RtWPiXDlLjsZdkcekT6ysH7JpyHG94Tb6k2xKDjnRIaKq+kjoKO5tAoU2tc+19nam
         +7xiU8S3OSUHHeCLbkbYDUPPTslbhFrmnmT6mxCIaOMOiEHurXSexF/D7Esh5QgCbea9
         ErtdN+oWwQhRV4WmBJpeylpvRpPKQoE2BJfE+GA8sJyXrJhZvt26Pftiwbdi/Unzm16Q
         PM4yejiUuDuVmAfug58LWDePo2zbeT9FpSmz2FFInlZVP67VbX06bMLh63VA5F+Xtbw8
         PZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDh9+EkJ1XaioXG706gkM4MC/zvXOsIVOcJCDT0kPlA=;
        b=EwrltK8f3zolrKUyPfOx42UPxdtd/+qxtyCkc600mD19jX1mdBstAzn+RUc8+DGxbK
         NGmWiypCXA8vKKDfjw4KGIwM99ZuVhLQk7QpVIoCNIoIdAxt8ITymtB57VhafyS8tAmK
         KynY7nC6vZiv/VViEpTBInalJ6WEJvsWXxA3MArCdxl6vrLOCZ1SVaLPsxGBQu/YmPu5
         4mtfW8TnsNtpxMM/noMtEue7VDtsOXEk7Mr0doQfXtNFRUCGgYVZE+dxo0mYWUNoEnuT
         P7aB19qHOsrT4aAal/u8MPoBkw9emSwOfcDbt8sk9yjA9mvLZolZRcw66B9EKW6da4e3
         imnw==
X-Gm-Message-State: AOAM530S7gWVGd6khUh/zBNFYXdK32lnxOgz+7x92W2OmnsJEe3zlkeq
        z4XJJoK7M40N96dKgR0H24eoy4vVgsxSOFhFwfXkFw==
X-Google-Smtp-Source: ABdhPJxNM3CwYb0naketQjkRI2A0IGPc/ibk6F55WPHNr5CZpsGwvlMmC4LJjLEfkXKKOmGc0AXr+WUGMOXXH44mSV4=
X-Received: by 2002:a17:906:8618:: with SMTP id o24mr6777111ejx.189.1632865197080;
 Tue, 28 Sep 2021 14:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-4-arnd@kernel.org>
In-Reply-To: <20210928154143.2106903-4-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 23:39:46 +0200
Message-ID: <CACRpkdZYJogU_SN3H9oeVq=zJkRgRT1gDz3xp59gdqWXxw-B=w@mail.gmail.com>
Subject: Re: [PATCH 03/14] ARM: remove duplicate memcpy() definition
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Both the decompressor code and the kasan logic try to override
> the memcpy() and memmove()  definitions, which leading to a clash
> in a KASAN-enabled kernel with XZ decompression:
>
> arch/arm/boot/compressed/decompress.c:50:9: error: 'memmove' macro redefined [-Werror,-Wmacro-redefined]
>  #define memmove memmove
>         ^
> arch/arm/include/asm/string.h:59:9: note: previous definition is here
>  #define memmove(dst, src, len) __memmove(dst, src, len)
>         ^
> arch/arm/boot/compressed/decompress.c:51:9: error: 'memcpy' macro redefined [-Werror,-Wmacro-redefined]
>  #define memcpy memcpy
>         ^
> arch/arm/include/asm/string.h:58:9: note: previous definition is here
>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
>         ^
>
> Here we want the set of functions from the decompressor, so undefine
> the other macros before the override.
>
> Fixes: d6d51a96c7d6 ("ARM: 9014/2: Replace string mem* functions for KASan")
> Fixes: a7f464f3db93 ("ARM: 7001/2: Wire up support for the XZ decompressor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Solves this, right?
https://lore.kernel.org/lkml/202105091112.F5rmd4By-lkp@intel.com/

Can you put in a reported-by and Link: to this so we got it tracked?

>  #ifdef CONFIG_KERNEL_XZ
> +#undef memmove
>  #define memmove memmove
> +#undef memcpy
>  #define memcpy memcpy
>  #include "../../../../lib/decompress_unxz.c"
>  #endif

That's clever, maybe drop a small comment in the code why we do this
pretty unintuitive looking thing and how this works?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
