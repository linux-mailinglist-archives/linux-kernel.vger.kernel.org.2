Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917753958D2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhEaKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhEaKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:18:43 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E89C061760
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:17:03 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x8so1037978vso.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwvxx69c5I2Xyj4W+OI1HkZT6qMIIrqbfX9qTV0ZMOM=;
        b=q3Wa8TXl84khkBvB8WkMOfD5LRTmVWOQtmPAWbrduQZSWm6cQ+fFdnMoZzeJF7FvQr
         BIJgXU4FpgzRYM2CGu22W0S0LGR6EeErrH0OD1akpD9woevYKz6aPJrFmw76G81dLVe+
         2pIGG6CcpV0eFE3p9iZ+AgP6TVQQF9WGI8eeLYOFSlKG8Dv/b4QIoDDFdHZVKzsJxfEG
         FZQbf8PdbqwIDRc7p8kTgm1P6x+6su+uxdM0KP8l1dOFq5tkc6Zr8o0EYv+UThcD/CUJ
         sRuKagi5ZWKefNWnaQwnuYMOd6B24LmS1KZ9jYsk368by680eMUtzv2iDI6tOgicGsS6
         PJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwvxx69c5I2Xyj4W+OI1HkZT6qMIIrqbfX9qTV0ZMOM=;
        b=LYUwyOfhXuGvjE+cqBmQiuIpPwjb3zuTV/80TwQ72azXpqoT8OV2JOFqffRLE7CRBJ
         A6GepN8yDSfVM2eNFGDX2TYcEqgLiS9dBio5Le6mnN3UOF4DAqHRQaOncGuks4YCCBGV
         sIaaXd7z2LWxonvz1dzdlAXK3q/T3d+dYHh20ddhgCBonP/GN2ol/XM43/ZEWnsE91Cl
         o7EBRXhjHWNAr7pMyz3QXraWKGKRMr5Knl0EhnfkNsiv7Zsu3kRjgZ5Ny2un0uP4srb0
         GbmxbpLTDux9dQhV9YgnIc7BKohG470JeIiLFlnvAoFBWt+Ob8aqK8X5Phx7YUraq7RG
         4WOA==
X-Gm-Message-State: AOAM533OXzo3FbD9Z6vVtf2Y4MsS7sL+x5xwfiI1/eJUF0BRfJNYTRYr
        uQjKyUt5adGKMvv5MD4W1UupT5tx+Dg0Gb2itcfLvQ==
X-Google-Smtp-Source: ABdhPJwIGI5VbRGX8PTwoO3Df5my/ZNCNNhiHEbA+RW80GxhxeEpq1hkdwtpCmIGG0fSsFuOuYzUaVBiPCw1QlU5dws=
X-Received: by 2002:a05:6102:74d:: with SMTP id v13mr869097vsg.55.1622456222315;
 Mon, 31 May 2021 03:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527194226.1705607-1-geert@linux-m68k.org>
In-Reply-To: <20210527194226.1705607-1-geert@linux-m68k.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 12:16:25 +0200
Message-ID: <CAPDyKFrpyXVpFpDvor5C3B-39m2-jE_f_xz6dGW4-KRbE7bBvg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: Remove unused <linux/clk.h>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Addy Ke <addy.ke@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 21:42, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> As of commit 4cdc2ec1da322776 ("mmc: dw_mmc: move rockchip related code
> to a separate file"), dw_mmc-pltfm.c no longer uses the clock API.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 73731cd3ba2315e3..9901208be7973f67 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -17,7 +17,6 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> -#include <linux/clk.h>
>
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> --
> 2.25.1
>
