Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA62427092
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbhJHSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbhJHSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:14:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A249C035446
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:10:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so42470026lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8+FegxBRVxRrgPWVVGMtq1wKrHppaacPkxALtOQRBY=;
        b=YOrwrfRfPyQO1ZBAi+3+DQkNbgBhBy6EKwbXvINEkq/aTPFW1og7L/fs9NpqbzN6z1
         5X6oQf/+B/Silb9FbQqmO3xRnDgCgkcvoNMUDxQJyhwX4y78gLOZALuLdIxQP01PPnv9
         PZE8oA0Tmwdh4ZQejjLfIe2InvfCi6/bINLzFjNKmly6EB5gGP2dARkT8c7Aw4e3y2jT
         fW7hTrVOq/PyN7QaFU3UIe7patsW97p6Kbw+79ue8O7EB0qh2Tkraw11fKO7Z55kqPLh
         YABx3ZHNFqLZ+vzYtrhA474WGAvNz2DkBJuL+Hb0SESrhgHIcjelLPzINb9gYfRYcC4B
         20BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8+FegxBRVxRrgPWVVGMtq1wKrHppaacPkxALtOQRBY=;
        b=cYpCoCKlrrvIpziPNsxH+cGz9p2m1K+k6QhOT7kn+AEbDZP5hHgtQg39/L9ul8TO+I
         u3rLIXg74yI8hxaVrGT8GDgboR661C7f+OBW1sQCuUQoY/tgDVdF5xFff2DV9Mg8UYj9
         sLUnkUlgG6CP6KIrFPx358hpvVHX/GXeRqA8DeQXYTQc2EqcQg5rZ3LPEj9x2nyHFY29
         d2w5eILyt96O02t/ZERJ0SnYjY3JimZaoH5yfIOWVWCD7+oBk7EwubL5PC1QV8wZzyLO
         HMwXg/j8G7vhuybgqO+ZpwvizZ24WIb8RgrbZehNKwyBK4MjazPNpu7C3HeCIKVrijdK
         Fb4A==
X-Gm-Message-State: AOAM532+bwg7R3Pq7blT6YvfQ/RHa2xLUT+43TDp4AQA6YZg8krGJESs
        aFRgt5gTy/XlLmrCuG0UQg3u2RcpFpd28k1CmollUQ==
X-Google-Smtp-Source: ABdhPJwu1Rpl3tvnFDgCiaoWQ3gS12YFEfzTq97WXsi7NA4DKXpDqKrjR0tv9fwX/2tcJ2jyOo6K+IRTwTdICIjJACw=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr11921727lfg.550.1633716599116;
 Fri, 08 Oct 2021 11:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <8900731fbc05fb8b0de18af7133a8fc07c3c53a1.1633712176.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8900731fbc05fb8b0de18af7133a8fc07c3c53a1.1633712176.git.christophe.leroy@csgroup.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Oct 2021 11:09:47 -0700
Message-ID: <CAKwvOdnWbKdBuSGtmu2DURy5dtVGUYWJ_mwxSL6N5OfbmjU3EA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Fix content of section containing lkdtm_rodata_do_nothing()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 9:59 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> On a kernel without CONFIG_STRICT_KERNEL_RWX, running EXEC_RODATA
> test leads to "Illegal instruction" failure.
>
> Looking at the content of rodata_objcopy.o, we see that the
> function content zeroes only:
>
>         Disassembly of section .rodata:
>
>         0000000000000000 <.lkdtm_rodata_do_nothing>:
>            0:   00 00 00 00     .long 0x0
>
> Add the contents flag in order to keep the content of the section
> while renaming it.
>
>         Disassembly of section .rodata:
>
>         0000000000000000 <.lkdtm_rodata_do_nothing>:
>            0:   4e 80 00 20     blr
>
> Fixes: e9e08a07385e ("lkdtm: support llvm-objcopy")

Thanks for the patch; sorry I broke this.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Cc: stable@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/misc/lkdtm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index aa12097668d3..e2984ce51fe4 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -20,7 +20,7 @@ CFLAGS_REMOVE_rodata.o                += $(CC_FLAGS_LTO)
>
>  OBJCOPYFLAGS :=
>  OBJCOPYFLAGS_rodata_objcopy.o  := \
> -                       --rename-section .noinstr.text=.rodata,alloc,readonly,load
> +                       --rename-section .noinstr.text=.rodata,alloc,readonly,load,contents
>  targets += rodata.o rodata_objcopy.o
>  $(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
>         $(call if_changed,objcopy)
> --
> 2.31.1
>


-- 
Thanks,
~Nick Desaulniers
