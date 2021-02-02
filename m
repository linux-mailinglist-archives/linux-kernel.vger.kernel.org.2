Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9C30B420
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBBA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBBA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:28:31 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B5C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:27:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x81so18311313qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UGZKvaHFb3iDS8/ZSso0ZzQe1AcopNzi6dHcSpP2yM=;
        b=CuufbgPkddjEWWVVV/V3NZVBNOmyLbUtF8RcSt1Mga0OrI7WapMLmWqYwZeJe3rsGv
         uEFI05upNMWhBKhJBD2b7bxI0HUgQGNFmODaGysF4PFim8I5g15rl/FMniToWPXl1o68
         ZVsDdJjGHsu8q1knI5YjBmUNgGRu4I9tHeYsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UGZKvaHFb3iDS8/ZSso0ZzQe1AcopNzi6dHcSpP2yM=;
        b=oIVLF4MTOeam3+MnO5i2QdHZwq/OJm/yEJJ5vHO07WpOB1pBd/oiB4dD2SPT5zy48m
         /DNU9bL3D6SwGlMdUqEgw89b97CdpkGE4Wi47Z0uWJi2T0MrTeoqstX/CaYkR7hrd4Jy
         IgnXD3HKkJCc28z2m4m3xPoh5tELhtS7YxlUCOkN297gUCPGdyWVO7jrl6GeiGkEREwR
         /ku7any31bAsFjRIKIsiSjOeGXMKDkKxNQrp0NXj09f7iRtagWEUVQIJTUIsBYr4lZ93
         niLADFcIlwWu62TuOXeVQFVxctueCLIN7slPcFfuPrd7LolaQr+h4U4QfcBrputf6/vx
         c/QQ==
X-Gm-Message-State: AOAM531STf5cOUn6wI6jh79zTkehLYWAdTqMqEoAcR85xVk4DTCK4RRP
        QJm57GPnP8Ob4wu1r74Cr1VkkJhXssW+vQ==
X-Google-Smtp-Source: ABdhPJwR6g7JW1swUVprLakOyhNwwN7xbI5xZsnRi0STjYxCy3kPGx3zE+2Vyj1TdkCkYz/dSSGnCQ==
X-Received: by 2002:a37:dc43:: with SMTP id v64mr19720499qki.361.1612225670024;
        Mon, 01 Feb 2021 16:27:50 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k190sm16527945qke.10.2021.02.01.16.27.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 16:27:49 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id i71so5206617ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:27:48 -0800 (PST)
X-Received: by 2002:a25:56c5:: with SMTP id k188mr30912661ybb.476.1612225668476;
 Mon, 01 Feb 2021 16:27:48 -0800 (PST)
MIME-Version: 1.0
References: <1612005840-4342-1-git-send-email-stephenzhangzsd@gmail.com>
In-Reply-To: <1612005840-4342-1-git-send-email-stephenzhangzsd@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Feb 2021 16:27:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQ7iCQFf6Qb3agM4DCt_Df3c6BwV_T6tEMMxXArbY_5A@mail.gmail.com>
Message-ID: <CAD=FV=WQ7iCQFf6Qb3agM4DCt_Df3c6BwV_T6tEMMxXArbY_5A@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: kdb_support: Fix debugging information problem
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 30, 2021 at 3:24 AM Stephen Zhang <stephenzhangzsd@gmail.com> wrote:
>
>  int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
>  {
> -       if (KDB_DEBUG(AR))
> -               kdb_printf("kdbgetsymval: symname=%s, symtab=%px\n", symname,
> -                          symtab);
> +       kdb_dbg_printf(AR, "symname=%s, symtab=%px\n", symname, symtab);
>         memset(symtab, 0, sizeof(*symtab));
>         symtab->sym_start = kallsyms_lookup_name(symname);
>         if (symtab->sym_start) {
> -               if (KDB_DEBUG(AR))
> -                       kdb_printf("kdbgetsymval: returns 1, "
> -                                  "symtab->sym_start=0x%lx\n",
> -                                  symtab->sym_start);
> +               kdb_dbg_printf(AR, "returns 1,symtab->sym_start=0x%lx\n",

nit: There used to be a space after the "," and there no longer is.


> +                             symtab->sym_start);

nit: I think it was supposed to be indented 1 more space so it's under "AR".


>  EXPORT_SYMBOL(kdbgetsymval);
> @@ -87,15 +82,14 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>  #define knt1_size 128          /* must be >= kallsyms table size */
>         char *knt1 = NULL;
>
> -       if (KDB_DEBUG(AR))
> -               kdb_printf("kdbnearsym: addr=0x%lx, symtab=%px\n", addr, symtab);
> +       kdb_dbg_printf(AR, "addr=0x%lx, symtab=%px\n", addr, symtab);
>         memset(symtab, 0, sizeof(*symtab));
>
>         if (addr < 4096)
>                 goto out;
>         knt1 = debug_kmalloc(knt1_size, GFP_ATOMIC);
>         if (!knt1) {
> -               kdb_printf("kdbnearsym: addr=0x%lx cannot kmalloc knt1\n",
> +               kdb_func_printf("addr=0x%lx cannot kmalloc knt1\n",
>                            addr);

nit: "addr" used to be indented properly before your change and now
it's not.  It could also move up to the previous line.


> @@ -147,11 +141,10 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>
>         if (symtab->mod_name == NULL)
>                 symtab->mod_name = "kernel";
> -       if (KDB_DEBUG(AR))
> -               kdb_printf("kdbnearsym: returns %d symtab->sym_start=0x%lx, "
> -                  "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
> -                  symtab->sym_start, symtab->mod_name, symtab->sym_name,
> -                  symtab->sym_name);
> +       kdb_dbg_printf(AR, "returns %d symtab->sym_start=0x%lx, "
> +               "symtab->mod_name=%px, symtab->sym_name=%px (%s)\n", ret,
> +               symtab->sym_start, symtab->mod_name, symtab->sym_name,
> +               symtab->sym_name);

This indention doesn't line up, but it didn't before.  I guess I'd let
Daniel say if he likes this or would prefer different wrapping /
indentation.


> @@ -884,18 +876,17 @@ void debug_kusage(void)
>         if (!debug_kusage_one_time)
>                 goto out;
>         debug_kusage_one_time = 0;
> -       kdb_printf("%s: debug_kmalloc memory leak dah_first %d\n",
> -                  __func__, dah_first);
> +       kdb_func_printf("debug_kmalloc memory leak dah_first %d\n", dah_first);
>         if (dah_first) {
>                 h_used = (struct debug_alloc_header *)debug_alloc_pool;
> -               kdb_printf("%s: h_used %px size %d\n", __func__, h_used,
> +               kdb_func_printf("h_used %px size %d\n", h_used,
>                            h_used->size);

nit: "h_used->size" used to be indented properly before your change
and now it's not.  It could also move up to the previous line.

>         }
>         do {
>                 h_used = (struct debug_alloc_header *)
>                           ((char *)h_free + dah_overhead + h_free->size);
> -               kdb_printf("%s: h_used %px size %d caller %px\n",
> -                          __func__, h_used, h_used->size, h_used->caller);
> +               kdb_func_printf("h_used %px size %d caller %px\n",
> +                         h_used, h_used->size, h_used->caller);

nit: "h_used" used to be indented properly before your change and now it's not.


> @@ -903,8 +894,8 @@ void debug_kusage(void)
>                   ((char *)h_free + dah_overhead + h_free->size);
>         if ((char *)h_used - debug_alloc_pool !=
>             sizeof(debug_alloc_pool_aligned))
> -               kdb_printf("%s: h_used %px size %d caller %px\n",
> -                          __func__, h_used, h_used->size, h_used->caller);
> +               kdb_func_printf("h_used %px size %d caller %px\n",
> +                          h_used, h_used->size, h_used->caller);

nit: "h_used" used to be indented properly before your change and now it's not.


It's possible that Daniel would prefer to fix these word-wrapping and
indention things when he applies your change?

I know the above is all pretty nitty, but given that the whole point
of the change is to clean up the code it seems like it's fair game to
make sure the code touched is fully clean...

-Doug
