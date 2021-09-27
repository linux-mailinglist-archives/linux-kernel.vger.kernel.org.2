Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22CA4197E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhI0P3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhI0P3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:29:03 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6049CC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:27:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id w19so22130048ybs.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smT979GOjWN0QuT4Bcu80SU2z7cVHs3jq1N6AUdkY3Q=;
        b=iSp90bUF+jZ2KUNc/9Sg1ELN5S1MhSa0HGrTgdjcft7IAabaxmsXbeJOmYAcYmKECy
         jUkq7mJjYki7QXT73FehiNftHygS1qxm85rkLEXOM1s9QO2HEX4QZexMMaEhxCIAU7up
         ESvd0BpYjPlb5KPQwm9pr4vS/NMQVCSQBUzBYoPPMJvb0CF9rA1Yf3EcraGbCArRQDJ9
         ShATS3ohHpLrTJFmJ2qO1Ky6BcdnZsQjFjq9QfNmsOt1dn1l7CPXgxwAG4TPJufXmh76
         ClmS3dWe1u7ySKYQWzDQftpKTsNoUIXlf4CNgfo/XAXN3znGGxKUh+ukWkc7O3upVfGu
         ukxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smT979GOjWN0QuT4Bcu80SU2z7cVHs3jq1N6AUdkY3Q=;
        b=gIUxAbFjXv5vW8b9+gfVGKf9/CUmYqptL4JaF7+srja7oGXIlYpwIYLCfnSqgKD/ms
         MHQ9Fxcn0+aeYovvD48gv1v9vuT9NSnlK6IajysLrSWqFyw+s297wf89n0rsXOgqXJSR
         r/DutXXdW+L/sIPyCgI5yWDoo9soi6WBl6f92WWOlLEhfJAXKkSxloEymyXYpou8TrZd
         bFcGQpW/PoOOznVI4rp2zqnkuigIs3n4FllXvzroiIQsp/WDsAQ5j5I0YAefjATYocoH
         PgUfdgV5HjQglk0XP79NFQ7B6j683g6e+PkPXOKWfTXo2iBIVtHrXT4dxmuciWB1Rrtr
         8nuw==
X-Gm-Message-State: AOAM531C3vr0fjU+sruw7pk7+Ie5c3Gh6Ggko7KxSosietaen31NZLzp
        dVqD58mO2TjbpfIGQCaaFKtBBu80thoeiVvX7niGKw==
X-Google-Smtp-Source: ABdhPJzDwdixMqUjQHo6CBP/yz/D/ubY6GzfsquRV+edDikFEkyhNiwBTOmkC0RtFMpbO26uIw/zJ1Z1FhJTwYw10MA=
X-Received: by 2002:a25:5b45:: with SMTP id p66mr426810ybb.273.1632756444397;
 Mon, 27 Sep 2021 08:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210927121541.939745-1-arnd@kernel.org>
In-Reply-To: <20210927121541.939745-1-arnd@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 27 Sep 2021 08:27:16 -0700
Message-ID: <CABCJKucOoov6aWzP3bcTwewNHFRbQn=nFvtkcZQ34hSm+K8+iw@mail.gmail.com>
Subject: Re: [PATCH] module: fix clang CFI with MODULE_UNLOAD=n
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Sep 27, 2021 at 5:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_MODULE_UNLOAD is disabled, the module->exit member
> is not defined, causing a build failure:
>
> kernel/module.c:4493:8: error: no member named 'exit' in 'struct module'
>                 mod->exit = *exit;
>
> add an #ifdef block around this.
>
> Fixes: cf68fffb66d6 ("add support for Clang CFI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/module.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 40ec9a030eec..5c26a76e800b 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4489,8 +4489,10 @@ static void cfi_init(struct module *mod)
>         /* Fix init/exit functions to point to the CFI jump table */
>         if (init)
>                 mod->init = *init;
> +#ifdef CONFIG_MODULE_UNLOAD
>         if (exit)
>                 mod->exit = *exit;
> +#endif
>
>         cfi_module_add(mod, module_addr_min);
>  #endif

Thanks for the fix!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
