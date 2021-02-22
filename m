Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA736321566
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBVLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:48:16 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47450 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBVLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:47:45 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 11MBkeTB016598;
        Mon, 22 Feb 2021 20:46:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11MBkeTB016598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613994400;
        bh=OtISAtkJ9mbtgcPz90LjKAYDel3mXKzEg/nMsg1GTeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aND6dYBQYOzz87Qyydccf51cdx9Gqc9gViHf4kv4Uqw97Pd7c3OVecOpjmYg79dfW
         pd/mg2DL2yje/d2//LnKkIUpxgV9CKGeRAmPQM7R2WSCANhj4cyab0GxdmbvKtojc0
         soDN1JVE6zmeg6JDLWnDR3HvpFGoSOo2ortyvjFbBZmeOkM4Ak0t7VfBeVvDRQV940
         eG2P3h7RK/daru2JQm+wXar5afxqVqIQ8YRg21hSDH0UJvACHhxiMYwnUAdFItpLom
         c+0xdhD0bzhqW7AWyq3EhYKH2Bx0sWmWgTpZYSpzIsuviEzNQliXmrFHs5UDVkRLv4
         0Y9410srdEJ3w==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id e9so8872254pjj.0;
        Mon, 22 Feb 2021 03:46:40 -0800 (PST)
X-Gm-Message-State: AOAM530mPM0C83T7bLiALjvBH68BGrcyZ9oPWdHQQC+l9oyWupLVeUOl
        03j8kUTMOOZkmLzGSqUniLV3J02ZDfhoQwHQ8+8=
X-Google-Smtp-Source: ABdhPJxXjM3iaClmcPKGi6JvZex/D/Qp7gqlV13AP90Lg9gGgDLgn86FciVS5BjPsX6nAjS0+pf0VRninMdzmX8XNZQ=
X-Received: by 2002:a17:90a:609:: with SMTP id j9mr23494118pjj.198.1613994399749;
 Mon, 22 Feb 2021 03:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20210220142953.918608-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210220142953.918608-1-christophe.jaillet@wanadoo.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 22 Feb 2021 20:46:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQuuaZxKqcS5t7jW_P8jwFJ83jKEMcyQ0h9hw54gAfxDQ@mail.gmail.com>
Message-ID: <CAK7LNAQuuaZxKqcS5t7jW_P8jwFJ83jKEMcyQ0h9hw54gAfxDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: uniphier-sd: Fix a resource leak in the remove function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        kernel@esmil.dk, Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 11:31 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A 'tmio_mmc_host_free()' call is missing in the remove function, in order
> to balance a 'tmio_mmc_host_alloc()' call in the probe.
> This is done in the error handling path of the probe, but not in the remove
> function.
>
> Add the missing call.
>
> Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
>  drivers/mmc/host/uniphier-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 6f0f05466917..ccbf9885a52b 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -660,6 +660,7 @@ static int uniphier_sd_remove(struct platform_device *pdev)
>
>         tmio_mmc_host_remove(host);
>         uniphier_sd_clk_disable(host);
> +       tmio_mmc_host_free(host);
>
>         return 0;
>  }
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
