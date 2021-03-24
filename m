Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD30347E40
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhCXQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236656AbhCXQwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:52:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CB1961A0E;
        Wed, 24 Mar 2021 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616604765;
        bh=2RAeW9bcOox75IhY932ZgrIfd3SYhUfnOlwv0IAh788=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwKhfvRJs21r70XcIDwbVnaxi0YfdTx1uMXJyu1qvBXyg3uu8ZDvnBbCB1aI5sPoc
         9Qb1G3vaxJidF5vQl5Ot6A+ysXsy+1B2QO94FnipFdJAKVdou2fVog3IywNLk2wXYh
         6i5cxMUu3u0ee2MXSVQmfkPhCqx6ohCF98PrDmxSEaVQpNcvxikpjn08krFyhuBxYb
         +avQtlxwX+5wzuNz7BUt5YUS5Cxecdr8fJPj6snilRaH+Yvz0/sQj6V7PKuLY/o7WP
         is6++GViGt3x1P8hQXNunyFEbYyen3rMGOCghKgYTrnE5J6YtXTq6vuiONhuqUtm1B
         5n3kzFGY9+oJQ==
Received: by mail-ed1-f53.google.com with SMTP id bx7so28413327edb.12;
        Wed, 24 Mar 2021 09:52:44 -0700 (PDT)
X-Gm-Message-State: AOAM5320eWWScYXE18N0j558j6yv/CdegD3aMPbDLbTYf+KCQ5kn8+C8
        I0XGIsSMVQYpNR5er6/wKZd0Wm09LOceUPUtVg==
X-Google-Smtp-Source: ABdhPJxxIOCz/2gYbCvfBzS7StJMrjtlADxPoYmAXqfnAHcp9HhCZpm/hq38nfp26uFxTJTeqzm8E5rywirn4wpgNkA=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr4358269edb.373.1616604763688;
 Wed, 24 Mar 2021 09:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210324150425.20688-1-changbin.du@gmail.com>
In-Reply-To: <20210324150425.20688-1-changbin.du@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Mar 2021 10:52:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0hyZ25jSudh3EW1Fipwbp0AzMAKXG565ZrQxn-_kBKg@mail.gmail.com>
Message-ID: <CAL_JsqJ0hyZ25jSudh3EW1Fipwbp0AzMAKXG565ZrQxn-_kBKg@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Check dtb pointer first in unflatten_device_tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 9:04 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> The setup_arch() would invoke unflatten_device_tree() even no
> valid fdt found. So we'd better check it first and return early.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  drivers/of/fdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dcc1dd96911a..05d439d63bc5 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1225,6 +1225,11 @@ bool __init early_init_dt_scan(void *params)
>   */
>  void __init unflatten_device_tree(void)
>  {
> +       if (!initial_boot_params) {
> +               pr_warn("No valid device tree found, continuing without\n");

How are you going to see this message if you have no DT?

> +               return;

And the arch is supposed to just continue on oblivious that it has no DT?

> +       }
> +
>         __unflatten_device_tree(initial_boot_params, NULL, &of_root,
>                                 early_init_dt_alloc_memory_arch, false);

Soon as you get here with a NULL initial_boot_params, you'll get a
backtrace and halt.

>
> --
> 2.30.2
>
