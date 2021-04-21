Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7A366D43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhDUNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbhDUNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:54:29 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243B8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:53:56 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k73so40985459ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdMOzuAoKxixfYpfTCctOntChT3rj2anNj427Z+V4fI=;
        b=e60I8oGyg1eKKDX/emsMxMSiUCKJmDxAmHy+66zYAcJWGj2XX29f3qTi9We4lmkGug
         UFumw8VwdHrERSfCHRYt/FvSh/ymtT9LOenDcgnMm47EFe2asQ95PHBaIBlrCy8+CjRj
         PZZ0fP0fJSl312uEr1dICQzv8azoSUG3J00rWUqveaosdk5XxiPd8cVLLbOMkpxzk5r2
         31wUcCtswKYl4xq5HoJkDTe72SIuzUoY3QfxUkEOJolBgA7syct8xm46ZAjx/oaGsmty
         TG+qlmmi2Eaj98y5rNl0Ac1ETOCnDCh4ig4rdNbTGZOP9wOSKjXQ3DFa9lhb9Oue9oiB
         Kl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdMOzuAoKxixfYpfTCctOntChT3rj2anNj427Z+V4fI=;
        b=MATr+wYQ8xNq2sK3xl17n1jZkRwbxsk7ibkvcpDD1TeaTIIGcLzJupbV3wQvC9vWeP
         80Ypm0BzHFkJ1x2Ew6IWmKYAQP8MnjmCXG3uccvq/WFBwP3GADGeKgdrmbzbakIJyV85
         3ZmI3sXU2m2kOnE27/edceQkBIEL+8OZBL+9LT+C7FCG39OVCbPXZZVjR6jBocEvmhsN
         3wD7zaIvLD2QilALkxZd0Np9sncAjdqy+/TGXNTE2wMsqJNaG3ubvccV9kqVTq3huQQa
         q8fjUWu7W+FBuR4RIzrM5BsM8fyPFhjRK2UJWJ72iVvnnRfzRPZAHDK5dXXEHeCXFKU7
         d4WA==
X-Gm-Message-State: AOAM5306xUgaPzrW1VWA7h0pjj13fLjhqL6rWB2yGxPIXx0UK7iBpyg2
        TrSzo87o3i322GM2xSDBP1GG3mx+GxBj60ZxgOiz5y28cxa8yQ==
X-Google-Smtp-Source: ABdhPJxM1Tz/eZXdZzFK+62m9JjOcooFXllsYAgWS43J+TrFjHDeu3+OkfRoq9kpfWycA2e77xl+Ixo1i6BngPOBDLo=
X-Received: by 2002:a5b:ed1:: with SMTP id a17mr31897569ybs.157.1619013235441;
 Wed, 21 Apr 2021 06:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-112-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-112-gregkh@linuxfoundation.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 21 Apr 2021 15:53:44 +0200
Message-ID: <CAMpxmJXn9E7PfRKok7ZyTx0Y+P_q3buArg8YR7wV=+A9Sid2_Q@mail.gmail.com>
Subject: Re: [PATCH 111/190] Revert "gpio: aspeed: fix a potential NULL
 pointer dereference"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 3:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit 6cf4511e9729c00a7306cf94085f9cc3c52ee723.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index b966f5e28ebf..91d0fdf8469d 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1231,8 +1231,6 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>
>         gpio->offset_timer =
>                 devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
> -       if (!gpio->offset_timer)
> -               return -ENOMEM;
>
>         rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
>         if (rc < 0)
> --
> 2.31.1
>

Hi Greg,

I'm sorry you need to waste your time on this cr*p.

This patch wasn't wrong though, so I'd recommend it's left in the tree.

Best regards,
Bartosz Golaszewski
