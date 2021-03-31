Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0534FAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhCaHol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhCaHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:44:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0512C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:44:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j2so20205653ybj.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOIub7zSDEO9y3Tk79djblRNVs7ujr2nFJ28h5tSuwQ=;
        b=EblwNNAQO70nhkXNvYGBXkz3u5hkHDN2WOOKohtlnsNvLhTu+Rtrndp9CeVVMk+xBg
         ScWeg54aZ35IQHp3ZTkTYrOkz8mxoXnin32Q8SEPCNnPn2WXmAU2XSiT5e+pkku3YW6g
         Sgsd467/4dNsO/KEf3SJR0ZppXJtl1kfOC+XBiYVimqPXnZIoYKvJYY06/cpFVG/f1va
         eWQD4Bts7QVBORSoCzSBmnjAKr4nKrRL/hEXc2uXyRgmVJfPN8SlZApgbzNeiQRL/x6B
         SpGpocU7Gi5I0gnHDn9rgDRoe5xFU7SdqkEZT+l9am+NpZjz0dK/T2/kpl8PA/uWDn+D
         ZNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOIub7zSDEO9y3Tk79djblRNVs7ujr2nFJ28h5tSuwQ=;
        b=ADyruAp7tS82uZwCj3eRIP+dZgCqUrdQxJfCmYyvVtQNRjbdmvrc9Uo67bkq14uPk7
         qOEmdQoDdCmAuRlxqZacTd6nK7a2PD00S9ExWVL+NCsRIUtdGxZW9NXHpIJs5p9Ice6G
         yJaZ37ccXiFfLAVQhGqio3WLyeNmAWL6zm4HGD2f9i9R/UhZw5JgP81sJZ80JCdI6IW1
         iGzK0Id2zeZ/bZrwEOk8j9Z1wwVhVoMsCfVpkCwy3pU+U8aPxY0Icd7FQQ4kKFvBypEr
         67DD9ShZVJG5ORoBmzly/kJ/gcKuT+MM+3djud+D/P/LCmDYGSMb3ZGNscoKNM30wzan
         B8jA==
X-Gm-Message-State: AOAM532O6jCHo0KKm5nlRtbnYQk2slJuhwKxGqN9h+mLPCW+Nhw3394n
        tzM3dCzg/OyAIlx4IdJGeZM9SyKj0g8VXzQzZVZA6g==
X-Google-Smtp-Source: ABdhPJwbHMZniQwRae4TUtkz47WD9WJwmCgxh0PTA7XlOpnGNfc39O0//KTOjxh3AJ1jgFjbrVZ4t3mWTaf7oG738i4=
X-Received: by 2002:a25:768c:: with SMTP id r134mr3069800ybc.366.1617176652325;
 Wed, 31 Mar 2021 00:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210329111648.7969-1-ada@thorsis.com> <20210329111648.7969-2-ada@thorsis.com>
In-Reply-To: <20210329111648.7969-2-ada@thorsis.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 31 Mar 2021 09:44:01 +0200
Message-ID: <CAMpxmJUrOZ6irBv2vuV1Qbh-L5XyqkzTUAwsUKPm5ZD7eTEweA@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: gpio: mockup: Fix parameter name
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 1:17 PM Alexander Dahl <ada@thorsis.com> wrote:
>
> Module probing with the parameter documented yielded this in kernel log:
>
>         gpio_mockup: unknown parameter 'gpio_named_lines' ignored
>
> The parameter documented did not match the parameter actually
> implemented with commit 8a68ea00a62e ("gpio: mockup: implement naming
> the lines") long before introducing the documentation.
>
> Fixes: commit 2fd1abe99e5f ("Documentation: gpio: add documentation for gpio-mockup")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  Documentation/admin-guide/gpio/gpio-mockup.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
> index 9fa1618b3adc..e3cafb4451aa 100644
> --- a/Documentation/admin-guide/gpio/gpio-mockup.rst
> +++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
> @@ -27,7 +27,7 @@ module.
>          the second 16 and the third 4. The base GPIO for the third chip is set
>          to 405 while for two first chips it will be assigned automatically.
>
> -    gpio_named_lines
> +    gpio_mockup_named_lines
>
>          This parameter doesn't take any arguments. It lets the driver know that
>          GPIO lines exposed by it should be named.
> --
> 2.20.1
>

This was already fixed by Andy.

Bartosz
