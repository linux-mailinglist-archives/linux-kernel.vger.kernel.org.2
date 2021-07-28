Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305DE3D9726
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhG1U5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhG1U5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:57:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49585C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:57:34 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a201so6165865ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTsvjRA7QJHz6Ut4194ILaAL+6Y4KjG9H2G1vntGX6w=;
        b=jYhXLyFxy+0LDnmQx3ShWVphRBj1/9hh+jLt56xwmBb9htxCdFO1rIETWEMLIJQmSw
         PktIHjmim14n8bmqOPZAe8UC39MQnNukydEq2ToJ/NqXgPWJ1Eu7cQxIpCchjDI+4oAO
         pEybwP5Fj8bS3I73oGgy7aQm079ZD35eH1lteS4gHwXvl1y+VGEZ+U7iCNzjrBkNKtE9
         sCNtxvla1OzOsktzEhyhkrSRHJ0fE2X6LZe65uBVMo7JuFT1sWxtuvvRUDgLTH7kbzEK
         4ZbJkf2oU+CuLmuZOTv5QJd/8YpUxXVtYNcXOOjn/LFYPSus6Vj75Upwnky2oB1EG/1l
         +oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTsvjRA7QJHz6Ut4194ILaAL+6Y4KjG9H2G1vntGX6w=;
        b=tRdDDybXt5duj9Zw6kNDlNbWHFBSUBRSrqrYNT7bCdDsBF6BO+zM+b0fr0YLBtlE5F
         lN6ey3iRa4Gv2XHY3aw0X9LKZOEB+r4llk7sxyRB8Ffanw1ZmHhcoAf12X9V/oBUt+nR
         ZPHFL43WbZqjraE3x9N+bvF2JL81n8sspE5V4F4cAYdjtZJiJWBNRJF8Ze88iI0Jy1DI
         T+EV6eBesL3yocUgzGSeln5/pL6nT/bJwbUBRrrx2IM3WZo71OF2ixbXjpZ/2qa6Iagv
         1/tc2kV+eKohCemN8pgLBkINdpbqNQcfkpjYLUv8jLV/+RzxxF1tLqZxgH994F1iycaJ
         3QGQ==
X-Gm-Message-State: AOAM530BltYCWteHex2MXW1ib8SpiZiyrVkbJfUmdHWCrQ5QMOsHMM23
        EI8OVNAPF0wWnO1Sm6fpwSF7++VxXlVuAPuIzaxW/g==
X-Google-Smtp-Source: ABdhPJyFZqPWvpfpjKjL58yBUX6jEHePEqtOYklIISdBW/qV3U0B6Y7KJoL/Z8EVeT1JSND+ndEBqx6IWveusANig1Q=
X-Received: by 2002:a25:ba44:: with SMTP id z4mr2130612ybj.476.1627505853191;
 Wed, 28 Jul 2021 13:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131853.GA18032@pswork> <20210727140618.19130-1-treasure4paddy@gmail.com>
In-Reply-To: <20210727140618.19130-1-treasure4paddy@gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 28 Jul 2021 13:57:21 -0700
Message-ID: <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
Subject: Re: [PATCH v2] kallsyms: strip ThinLTO postfix ".cfi_jt"
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 27, 2021 at 7:07 AM Padmanabha Srinivasaiah
<treasure4paddy@gmail.com> wrote:
>
> Clang ThinLTO adds a postfix ".cfi_jt" to a symbols of extern functions.

These symbols are added with CONFIG_CFI_CLANG no matter which LTO mode
is selected, so talking about ThinLTO here isn't quite correct.

> For example this breaks syscall tracer that doesn't expect such postfix,
> so strip out the postfix from the output.
>
> Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> ---
> Change in v2:
>   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
>     extern function name.
>   - Modified the commit message accordingly
>
>  kernel/kallsyms.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 0ba87982d017..e9148626ae6c 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -166,16 +166,20 @@ static unsigned long kallsyms_sym_address(int idx)
>
>  #if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
>  /*
> - * LLVM appends a hash to static function names when ThinLTO and CFI are
> - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> - * This causes confusion and potentially breaks user space tools, so we
> - * strip the suffix from expanded symbol names.
> + * LLVM appends a hash to static function names and just ".cfi_jt" postfix
> + * for non-static functions when both ThinLTO and CFI are enabled,

Functions aren't technically speaking renamed to add a .cfi_jt
postfix. Instead, these are separate symbols that point to the CFI
jump table. Perhaps the comment should just say that we want to strip
.cfi_jt from CFI jump table symbols?

> + * i.e. for example foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> + * This causes confusion and potentially breaks user space tools and
> + * built-in components, so we strip the suffix from expanded symbol names.
>   */
>  static inline bool cleanup_symbol_name(char *s)
>  {
>         char *res;
>
>         res = strrchr(s, '$');
> +       if (!res)
> +               res = strstr(s, ".cfi_jt");
> +
>         if (res)
>                 *res = '\0';

This looks otherwise fine to me, but it's going to conflict with
Nick's earlier patch:

https://lore.kernel.org/lkml/20210707181814.365496-1-ndesaulniers@google.com/

Could you please rebase this on top of that, and take into account
that we should do this when CONFIG_LTO_CLANG is enabled, not only with
LTO_CLANG_THIN?

Sami
