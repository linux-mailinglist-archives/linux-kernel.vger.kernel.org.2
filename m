Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445473E1CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbhHETb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhHETbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:31:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDCCC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:31:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z128so10839764ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fL8fo3oMGGdyhjep5qev4L9S+lO3A55pCdtFOtBwaxs=;
        b=susPQoo7vDrRfrwzXtBy22f4mKDn99gxcKYS3WdgIv0Ttkg+CxyTBlKqI73LsdPEx4
         DR0rXmw+2M9BrAFs+9Cyc5jmMnJlNuJwJwd/e9fsd3mQP/AroV8yein4SlqXHcgcFtod
         qnviLaCCI41xrhhJrrSSknBzTEd333w3q5ltYQJ3BpPfKI2XnTn3a0SfPAOk4feNEWmi
         b7Z9sNYTlbZX6rp+EmlakSpUCymwol4dLhPbUwiRnKsVI9X8fBtcFt/b6P/P25LFEYj+
         FtKPbw9seF6TpGIB1zr1EyQLxjIF2xewalSu+FUe6bizmrcG+kN9OtKY3sCGdWke66ps
         GODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fL8fo3oMGGdyhjep5qev4L9S+lO3A55pCdtFOtBwaxs=;
        b=mpTc3zAB5Cb8FtJWd/mFG0InW4lOTG+S1b9fxv4wDerOMv/u+DQzHs3opPI4sak3zT
         GwWsfkXJyKodD3SuMK7x94CerFDqN6C49V+dnZ6OF4vTxZdRuQoUFhzxVXdzdPzPuONg
         zDFfuIlhrdAzsc2NbIs/eUUihiPrX2kWy65QOYEgSg30upGj93/aBY7E1HGB50Xhyi3W
         8CvQUrMAZldmjnKHzirHdPaufM86lIFYWAKPYgkbSJ11npPQ2k+ou8NIHTw/h+52gy0t
         D+5TXbak0QsAM/fLf05LxSPopWlyK5bPzJ60HeZZruG+Czo495l1Bc6EMUAs9m0EiNlh
         rmHA==
X-Gm-Message-State: AOAM532EXO2Wl0rCw8oGwpiVX8ddjwgCDNQHVwYzJcN1kEFn2r5ulr0o
        RHwLG1MPYK5ftBgXfmbiiUTOzsl32BYJ6I6dEObFbQ==
X-Google-Smtp-Source: ABdhPJwCu69IUV8/73ADKF8rJAeJL2gGGYFSxKuIudS+v8IePJBtkREFBqch3JyZnL622pPLRF9YZCwdVFS53Bk5er8=
X-Received: by 2002:a25:bc2:: with SMTP id 185mr7963251ybl.23.1628191868491;
 Thu, 05 Aug 2021 12:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpxmJWZm_N3yPKa2+32PNOyCUuSbjqWiDBSO3WHjKekZj8Fzg@mail.gmail.com>
 <1626670001-22832-1-git-send-email-akhilrajeev@nvidia.com>
In-Reply-To: <1626670001-22832-1-git-send-email-akhilrajeev@nvidia.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Aug 2021 21:30:57 +0200
Message-ID: <CAMpxmJWDX8GifOWcAgnn0BMPhyRpLSkWEcAsr=F4rZ-1OhUqUw@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: tegra186: Add ACPI support
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, kyarlagadda@nvidia.com,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>, mperttunen@nvidia.com,
        smangipudi@nvidia.com, Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 6:47 AM Akhil R <akhilrajeev@nvidia.com> wrote:
>
> Add ACPI module ID to probe the driver from the ACPI based bootloader
> firmware.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> v6 changes:
>         * Rebased on top of v5.14-rc1
>
>  drivers/gpio/gpio-tegra186.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>

Applied, thanks!

Bartosz
