Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577B1325882
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhBYVRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhBYVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:17:31 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:16:51 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id m11so7293921lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Q5jeV0/eI5MVanjQDC59pyS/bWWpJw2xxtG8W1c7H4=;
        b=lSDsTa8+1W/LrXlNbDCet5BRX7EP5F6fAfIS4wDDgeQxu1IDh/qbnAteagqoVU/4kt
         0hUW0AMRMdI5mL1PWlNAlkFWnXHFNW+JMVbA1ApVnBUrA1lkPZSqxHpIG3CDDRHc4exv
         WpzZ5/9965fNkK5SJ2SjZR9aCd3KqnbYIaFF8CBANIB0L+enAl72WgK7bJi1wVsdpQna
         irU4+WZ2ROO7Z80oUaV8Vv84aUTnMF6bQ0CX/x/IZ/OGnB8AGcJO7o5D04R1RdtokRx+
         exfZd2Jn12m7Z7EpFkp59f2TNUutRHx4aaA4GiBTXT6sJ9mabLs6TgFUzdH5PmkM81k3
         2XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Q5jeV0/eI5MVanjQDC59pyS/bWWpJw2xxtG8W1c7H4=;
        b=dcIxvt84oUtcuyS4hxaFNpcyiVClbMNItzHI5P2tBjNGdLdcBRZtWtAc0uSzzlATtB
         Cw5OAz2qXd1Bi8XZHP73T82Uw3CzZEpSA8o+NwHUG3apTgvrn6y0CZPwLvcO7Pfq/XDe
         0OVl/6uw34pW+zIdFOjBJsVWx10dn75kr2zZZ5qAYOdOhMaz4KM9N1ic01+6PRKnAicW
         d7Vl5z5gD0NKI5yIRuKdsD/r8idYidY6iFLMTytIaFXuL2rG8S5gGG/SuO5LfLaZj+gq
         fWW7yCUgrcD3zpRCEfJKseZRN38oMpwcbgpDSGpiLuCsogQael90V4rZpgzqXw481JCg
         rKrg==
X-Gm-Message-State: AOAM530oJfRNDuK+ieUyZei+pVPy3zSzylewIJBaI6sCOpepmHy+uHHj
        GLm0xSOxY7h6UqeDL1nYHZ3eV8ioKmbpaqBgVKo8vg==
X-Google-Smtp-Source: ABdhPJyoukkJIzbnUCTDgEc8ErCmiFKnaC//5UEi7GGwOSyywu4N1VzA/uVndHYzTf2iwxBHw4DsoQHM4/1tXrcLxow=
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr2535739ljp.495.1614287809489;
 Thu, 25 Feb 2021 13:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20210225125541.1808719-1-arnd@kernel.org>
In-Reply-To: <20210225125541.1808719-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:16:38 -0800
Message-ID: <CAKwvOdkcR=8Ay+VaOym6y4ySC-x+=dfTjN_HDLs-281KdUhojA@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-spi@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 4:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
>
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
>
> Use BUG() instead of unreachable() to avoid the undefined behavior
> if it does happen.

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 936ef54e0903..972beac1169a 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -521,7 +521,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
>                  * ctlr->bits_per_word_mask, so this shouldn't
>                  * happen
>                  */
> -               unreachable();
> +               BUG();
>         }
>
>         if (use_dma) {
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
