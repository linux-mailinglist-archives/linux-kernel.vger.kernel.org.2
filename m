Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410E0359E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhDIL70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:59:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A699C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 04:59:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so2837036wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JxLGtNxnOp44Fk3GR4yu3/dSaD+2VjIuaHuj9l1KiQ=;
        b=nMGELfkFKUlyq1MbWUKQSzrWlQcNqbav3ngNWkPz7v/ypHRgI5TAgc71uyUfqA6GYq
         9t/E6YNdsgGllOqJl0WsUjFupq+dNbxdi67u5SrsmwTI3qaX2fgl6B8sgPfWF7kkR0vP
         +cCQrsq4QL3e1bl8kIgc5P4rXKQwMrxNM/Jwpe9E+w3X6slHXBi9UP17swan1UcA/8Je
         a9RCgH4JO8mVuQZctGq0Ft/ngtEfn9HLyUWrdp1OZiUSKRRR11gEKvfwKdCK6BaG96ZM
         5sM8IbS4bNUcMtya/q05yRK3Q9CeXkMa6Dm732oluQ0UtsLSDBZUgUykMoHp8imSWGRc
         sV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JxLGtNxnOp44Fk3GR4yu3/dSaD+2VjIuaHuj9l1KiQ=;
        b=HCAerKDtNDulGiZTkOeTC1rPaPAnwlFEWbwlK4PGMOR5X1YdC2LUE5uoat+l53U+5Q
         0MyapsAKWbVM2P+OTiaXUEWJ7jnNkiekLSvB6mQlUhK1TDlwOvaDHG8z2tZaq75uEHDN
         7/RDUlrJ6cSg4ST5hWVz/KkCMm6rXa1tQ9z7SVo4kYmsEUYWD6yb8ydgWZyDbjC2u2V7
         QlOJGkwj2c9Ava8RP4lKsdTQ/RcVt+ab2a8q3jz9svALXr3cOJwG3IY3vXsB9isWauEG
         65/dFFVpKW5my9/cWfX+Cc+HRDMiYnNGABZg1foveM4RPN+s8fDoKXP2UGmgYxchM93N
         5/aw==
X-Gm-Message-State: AOAM532cMglQfAmK5lovuoouBhpH3UMk70q0UWqxhDx34UELUDiaAF2H
        WXqywwmLFiUSP5y9ejjruw7yj6iOaHh1UzcZmCxlQ/xMjJXScQ==
X-Google-Smtp-Source: ABdhPJw+h9YP0xI/t8HB8HQXIT3HtxhdzO19Cb0l3tmB5+0Y9WuDgFa5h1a3TR4Umpd2g2+C2cpqPS3XRZJ4xfEUxWo=
X-Received: by 2002:a7b:c003:: with SMTP id c3mr13360369wmb.59.1617969550800;
 Fri, 09 Apr 2021 04:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <1617957240-53633-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1617957240-53633-1-git-send-email-tiantao6@hisilicon.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 9 Apr 2021 07:58:59 -0400
Message-ID: <CAGngYiVfattJKO7npMHTagxNfzU-B=rP3FoZ89_yzy-c=Zw2RQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: simplify devm_anybuss_host_common_probe
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tian, thank you for the contribution. See below.

On Fri, Apr 9, 2021 at 4:33 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/staging/fieldbus/anybuss/host.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
> index 549cb7d5..2924e68 100644
> --- a/drivers/staging/fieldbus/anybuss/host.c
> +++ b/drivers/staging/fieldbus/anybuss/host.c
> @@ -1406,7 +1406,7 @@ void anybuss_host_common_remove(struct anybuss_host *host)
>  }
>  EXPORT_SYMBOL_GPL(anybuss_host_common_remove);
>
> -static void host_release(struct device *dev, void *res)
> +static void host_release(void *res)
>  {
>         struct anybuss_host **dr = res;

You're expecting a double pointer as the argument here...

>
> @@ -1417,21 +1417,17 @@ struct anybuss_host * __must_check
>  devm_anybuss_host_common_probe(struct device *dev,
>                                const struct anybuss_ops *ops)
>  {
> -       struct anybuss_host **dr;
>         struct anybuss_host *host;
> -
> -       dr = devres_alloc(host_release, sizeof(struct anybuss_host *),
> -                         GFP_KERNEL);
> -       if (!dr)
> -               return ERR_PTR(-ENOMEM);
> +       int ret;
>
>         host = anybuss_host_common_probe(dev, ops);
> -       if (IS_ERR(host)) {
> -               devres_free(dr);
> +       if (IS_ERR(host))
>                 return host;
> -       }
> -       *dr = host;
> -       devres_add(dev, dr);
> +
> +       ret = devm_add_action_or_reset(dev, host_release, host);

... yet you pass in a single pointer here. Is that going to work?

> +       if (ret)
> +               return ERR_PTR(ret);
> +
>         return host;
>  }
>  EXPORT_SYMBOL_GPL(devm_anybuss_host_common_probe);
> --
> 2.7.4
>
