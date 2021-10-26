Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6969043B5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhJZPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbhJZPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:43:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F30C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o26so20788580ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuAeUf9uZkiKUJDSGobKdOnKcJ1uapOPXzgjXviYDro=;
        b=muMlBrRY3/QCQrarET+Xe5M31Y3VLic0gR0j41gMQ8eAYF2HxZCDUd70WvE/Bjnei1
         3trPRvzaln8YUcRy/jJuZHGB6oLaj8+pGuquEVE9DTSkynGZh7xu7wmSHE4+7HppLKC4
         vCVkTDeOxXwWvOw8qLTsHnT17A8koWmSw+oMKXawstQD4FxN/Cz6elLurwvZr8bPPKP2
         odkXmLs/l8g0ppbEwBN11TGIKFIzR3sHgzAiBL0nCGTSeuy4RI/HW5Hs3vKJcmbb3C9Q
         gFONbN8eIhLX/VvQGoQnXN1ZalnTFHjt+eaLd7bzOA6cqN44tyLJ+vCdtfyK+TEyeYuh
         W8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuAeUf9uZkiKUJDSGobKdOnKcJ1uapOPXzgjXviYDro=;
        b=shqJbdVi264ViIH1GebsIroOi0GJHXrumare+GuyvYpWP8z1Z4w+whERlx989qYkhL
         3GL/Kb77nJKIwYuEuQokGJDFcINpkKsuoIKe+jjGCGOy6GO0YYW+QyACJrQEfFgU5egS
         cgVVX+Wc9Vdtay1NYWnHTwG5x9mHdFbGhq6lwKj9kHSfoibWJb30OlyU/4LIpUF0Pco9
         sI3fjtdW9zNlZs056RznUGRJoKzl0NdoNHtcGuQHF8po+/Hcd2nSGfp7Z5nfbuTtDfNf
         zQNPZftDFJKQUBPZv3PUCi6Pbog9+8jHyosC6QazQxK/mHPw3ZCIqM8mRuP3XxV0OCFc
         fi3w==
X-Gm-Message-State: AOAM5327v9ou3GlDqEKPGpm53874MH4o/q/pIzzu4uK+JFxyatw3BWKJ
        B6TnluqiNbkZtdBICVBOYcd5rxJ85BDf7SVzUlRPWQ==
X-Google-Smtp-Source: ABdhPJwJxayy3+qErnJw+sJ9TklHlWV26/nGoMVeRjTBnpEsMJAPY+suHEdAsQ4L/4uK7Ul8VoW5H9CPVhbKCZWsnjk=
X-Received: by 2002:a2e:874d:: with SMTP id q13mr27385797ljj.16.1635262836382;
 Tue, 26 Oct 2021 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 17:39:59 +0200
Message-ID: <CAPDyKFqt9a+WhoRiyyQWSsJugSqbzoWniba0xL=w_0Rw3Xn0hQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop obsolete file pattern in SDHCI DRIVER section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 at 07:47, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 5c67aa59bd8f ("mmc: sdhci-pci: Remove dead code (struct
> sdhci_pci_data et al)") removes ./include/linux/mmc/sdhci-pci-data.h;
> so, there is no further file that matches 'include/linux/mmc/sdhci*'.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches    F:    include/linux/mmc/sdhci*
>
> Drop this obsolete file pattern in SECURE DIGITAL HOST CONTROLLER
> INTERFACE (SDHCI) DRIVER.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> applies cleanly on next-20211021
>
> Ulf, please pick this minor non-urgent cleanup patch on top of the
> commit above.
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44c590b762d1..c47ac3e938b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17024,7 +17024,6 @@ M:      Adrian Hunter <adrian.hunter@intel.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci*
> -F:     include/linux/mmc/sdhci*
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>  M:     Eugen Hristev <eugen.hristev@microchip.com>
> --
> 2.26.2
>
