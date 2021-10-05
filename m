Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD0422F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhJERuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:50:51 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:38457 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhJERul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:50:41 -0400
Received: by mail-ua1-f48.google.com with SMTP id y3so10074756uar.5;
        Tue, 05 Oct 2021 10:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=knPNhU6TGHSpaIW4FMVFzxPZT1aU7QZlnO0dpjVPljQ=;
        b=jXSv8vv+Rp5zFIA41ygAAJT/L+MjQL+mklcAYKMyRzjImD7k87K+TNEu5N6DezYmm2
         Jf71Vq7m0z4EkRlcZi44cl/lN0BoDhOLIgwkI/VY4DgrXYdotCBWWKE0UWt0YaBwYzBL
         ks7JR4BUK1TXox4/Bc/Os0OhFaa1Vl2/0GNNjBBQELORSWo7UwXm00107iAAcTkstTKa
         crCot3HUshp1zoepu8IRLv1nGcZlShcSpGNSfJEKZEz9QHtd/uWVF5jqm4j+ZI3zx4Jm
         OmYQeygXTlYUTluuISzULVsOGioOQfW9gWl9Jk7x+ZbhQ9YtYjKFGSbZ0lAvXRsoyl6u
         xJMg==
X-Gm-Message-State: AOAM531z4jDWUu1xwttOWDaUTXR3Z5PJH1ClFpZIKAahEAPSmkGQI42t
        p9X6wjo2/AM7V2DF5xOmdaaIwC39t0epeQ==
X-Google-Smtp-Source: ABdhPJwfFo+XyCVUoxc8Ey3DdVRblMl367PX58YlXDhkJwzURj4Leij3p5GBA8+4AByiBt2mEjiGEg==
X-Received: by 2002:a05:6130:40d:: with SMTP id ba13mr14837438uab.124.1633456130422;
        Tue, 05 Oct 2021 10:48:50 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id p8sm3296614vke.11.2021.10.05.10.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:48:50 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id 188so174474vsv.0;
        Tue, 05 Oct 2021 10:48:49 -0700 (PDT)
X-Received: by 2002:a05:6102:448:: with SMTP id e8mr8269328vsq.49.1633456129199;
 Tue, 05 Oct 2021 10:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211001145036.18129-1-amadeus@jmu.edu.cn>
In-Reply-To: <20211001145036.18129-1-amadeus@jmu.edu.cn>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Oct 2021 01:48:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v64r-OvoUQOHyTbJ9e==ZFASO54MW56Lw654nhwWM-bj7A@mail.gmail.com>
Message-ID: <CAGb2v64r-OvoUQOHyTbJ9e==ZFASO54MW56Lw654nhwWM-bj7A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: NanoPi R1S H5: use the correct
 compatible for the eeprom
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 1, 2021 at 10:51 PM Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> The 'microchip,24c02' compatible does not match the at24 driver, so
> replace it with 'atmel,24c02'. In addition, because the mac address
> is stored on this eeprom, set it to read-only mode.
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> index 55bcdf8d1a07..4f01c17c49e0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> @@ -142,9 +142,10 @@
>         status = "okay";
>
>         eeprom@51 {
> -               compatible = "microchip,24c02";
> -               reg = <0x51>;
> +               compatible = "atmel,24c02";

You should add the atmel compatible as a fallback one, not replace the
microchip one.

Also FTR 24c02 is not the correct part number. It is 24aa025e48.


>                 pagesize = <16>;
> +               reg = <0x51>;

Please don't move the reg property. It should follow the compatible.

> +               read-only; /* This holds our MAC */

Please also add a cell representing the MAC address, and hook it up
to the GMAC. You can find an example here [1].

Regards
ChenYu

[1] https://lore.kernel.org/linux-rockchip/20210622034505.18824-1-cnsztl@gmail.com/

>         };
>  };
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
