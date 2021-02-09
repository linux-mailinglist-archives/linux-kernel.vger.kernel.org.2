Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B41315BED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhBJBKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234429AbhBIW1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:27:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CD7764E7E;
        Tue,  9 Feb 2021 22:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612909557;
        bh=nw/ggB5jzR4hpWOSjGu1T6DGUn4f/TcXu5vrKIAECdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CkRLsGOlFRPALIbg9/QTofurAP7gdziEAZNjlF4+9qYK9AZfVJ6LH17Y1uajqGAGa
         292m7F97yZocwCj6yK9Z5Nj7JEiFa5Sm7q9aMNpwmQWtbwSOYXQ1RXJkwUtGjtZ66u
         H4LJXF+vmX4QnCPmrhPwsZQBUHgLjGBLFvtqVXTjPLF6zEaRzhoDA3Q9A4gFrRTH/g
         wkCdKQ30/e12eWoAwVoCcqqTFfcgkbbPFR6OWqAhb2UkCKP/geRjTc54zBtizWPk8K
         rUbkL8YUeQS+dr/wluoyyXy7HnTNQBu4jO/e7D293KJ2nWcBAMfxkjo172iHv7phAI
         my1k0yqoZnVWw==
Received: by mail-oi1-f182.google.com with SMTP id h6so21210505oie.5;
        Tue, 09 Feb 2021 14:25:57 -0800 (PST)
X-Gm-Message-State: AOAM53202Y77G0mTdmM0dLFPBKjT7w7vOYW9pt93YnC56/1kMm+R5BZK
        7N+fmT1G7KjJdrxR+ZrLeMTiNxV6Z5quiJrH940=
X-Google-Smtp-Source: ABdhPJyxeWPTUKO8K39WOQhnrdR+Po94kCeKWyZcS8GtPy5M8duSmhG7JaCwy+7Lj5TeJCM/XahicK3lCqxRz+WzUAQ=
X-Received: by 2002:aca:d908:: with SMTP id q8mr3778046oig.67.1612909556361;
 Tue, 09 Feb 2021 14:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20210118155242.7172-1-jbx6244@gmail.com> <20210118155242.7172-2-jbx6244@gmail.com>
In-Reply-To: <20210118155242.7172-2-jbx6244@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 9 Feb 2021 23:25:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_uO23Y0tyfdh26tmCVcyp6XM+ur0WUd4khGUoBb32Hw@mail.gmail.com>
Message-ID: <CAK8P3a3_uO23Y0tyfdh26tmCVcyp6XM+ur0WUd4khGUoBb32Hw@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: dts: rockchip: assign a fixed index to mmc
 devices on rv1108 boards
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 4:52 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Recently introduced async probe on mmc devices can shuffle block IDs.
> Pin them to fixed values to ease booting in environments where UUIDs are
> not practical. Use newly introduced aliases for mmcblk devices from [1].
> The sort order is based on reg address.
>
> [1] https://patchwork.kernel.org/patch/11747669/

I just saw this in the pull request:

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/rv1108.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index bec47e0be..a754851f4 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -19,6 +19,9 @@
>                 i2c1 = &i2c1;
>                 i2c2 = &i2c2;
>                 i2c3 = &i2c3;
> +               mmc0 = &emmc;
> +               mmc1 = &sdio;
> +               mmc2 = &sdmmc;
>                 serial0 = &uart0;
>                 serial1 = &uart1;
>                 serial2 = &uart2;

Please don't put these aliases into a .dtsi file, as not every board
will provide each instance. The entire point of the aliases is to
have sane enumeration, so you should start at index 0 for the
first one that is actually present and count up from there.

I would suggest you move these aliases into the .dts files for
the existing boards for the next cycle, and then make sure
only the ones that are present have an alias.

It might actually be a good idea to have a warning in dtc when
there is an alias pointing to a status="disabled" device, but I
suspect there would be a lot of fallout from that.

      Arnd
