Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB539D782
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhFGIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFGIh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:37:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 881EC61168;
        Mon,  7 Jun 2021 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623054966;
        bh=+zpft5AvcXKHe9fOwi2skebaDDUqkpkOm19ZzHH053Y=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=GZbpZm9TbLHT/N2VX0Son6t/vyD7AMhsahjBFCqzWfSUhiinh2pOyNJcTOc3CZhFz
         HNY/0R07HDwHvIkJ05lEC2uDiwSWaSSkJM4MoT9CEZtZTLEG21wZ67pvlNYYdl0n+X
         z5jIoi7RbbG1lEN5NA0wB/M37Ln0NgHyA5unbZ7x03fa1Ui6rissdWxa4snkjdmkkp
         mSumNC3IsVj5SmEcCocVCx26/ofvtHi0BCCzcVkC/C+MmTXpKl58epozHrVb5PEprq
         D9Coh7tg2rJVKgOOm7uiu70Q+zl8ERIlJr8xgRkKjZIUoxEveLWclbbiPPlk+2Wa0s
         QV9ROzmR6qjKw==
Received: by mail-lj1-f173.google.com with SMTP id z22so5099154ljh.8;
        Mon, 07 Jun 2021 01:36:06 -0700 (PDT)
X-Gm-Message-State: AOAM531+3otKkwVpgY+J64KoB9EuL6HPt0zMw0lzSBj3WXrrvV2Q760Q
        Lh6wIciEj6J9qAvscD8oFbJpkH4W00Qw7HIFFQ8=
X-Google-Smtp-Source: ABdhPJxAWVbhKrIgk446onDnt6rqEUbqOsWVjFiGYF0zOH8zTdIr+uV/CiL6ktAGj4s/g0uj4/lONmcUhchrh4NyA6E=
X-Received: by 2002:a05:651c:1501:: with SMTP id e1mr14575535ljf.74.1623054964950;
 Mon, 07 Jun 2021 01:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210607081727.4723-1-cnsztl@gmail.com>
In-Reply-To: <20210607081727.4723-1-cnsztl@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 7 Jun 2021 16:35:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v66GAOtF40o5XoK_K3bWPa2L8jGxH=R-YK8060TGeAKreQ@mail.gmail.com>
Message-ID: <CAGb2v66GAOtF40o5XoK_K3bWPa2L8jGxH=R-YK8060TGeAKreQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 7, 2021 at 4:19 PM Tianling Shen <cnsztl@gmail.com> wrote:
>
> NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> stores the MAC address.
>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> index cef4d18b599d..4a82f50a07c5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> @@ -68,6 +68,15 @@
>         status = "disabled";
>  };
>
> +&i2c2 {
> +       eeprom@51 {
> +               compatible = "microchip,24c02", "atmel,24c02";

The actual part number is Microchip 24AA025E48, but I don't think
the way this device splits its storage area is easy to support
without additional modifications to the driver.

> +               reg = <0x51>;
> +               pagesize = <16>;
> +               read-only; /* This holds our MAC */

Please also add the size, as well as a cell defining the offset
and length to the MAC address. The gmac node can then reference
this with:

    nvmem-cells = <&mac_address>;
    nvmem-cells-names = "mac-address";

which will actually pick up the MAC address.


Regards
ChenYu

> +       };
> +};
> +
>  &i2c4 {
>         status = "disabled";
>  };
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
