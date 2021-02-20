Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69B53206A2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 19:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBTS3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 13:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:29:11 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE1C061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:28:31 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z68so7501090pgz.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RjkOkIQ4H50D5nfZE/7c1OGqspZr6SZ/5yZfAB+3COw=;
        b=b4fh1A59ioeDsmCACwiyS9ttlR06kwwPf1pF/gF7JJbOVTVSxqrqevai2LxhBujys2
         9MjT5vBsqrD3aDlDyNajoRDAlrnaE+r2gMwLd/qX1Ti4fLX5VfbM7miSgtYYew8b49kk
         VSf1oIS8dNcPzN9GeZV6lfIvLkrg751k17JwRwVW1zBhwluTAyVZxm3uhMoToqe/83MF
         bq7B3lsI36QhZj40FSMMvZpPAiDuTutcGMEz+NCQZ8j9lJNCKJCffce7mQk3NbexwXxk
         dbGrFqJ/Il8Bi9ahjiWtMrOQPD+2f/TMuhtuTRWXaHEmm76Yuue30ygvmNwBmHYa4NBN
         AJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RjkOkIQ4H50D5nfZE/7c1OGqspZr6SZ/5yZfAB+3COw=;
        b=d/JP5iZbc4vrrZWzz+CXjKggE23R308unNX1uQVHKEX6nwvxkQHi6hKfC0Z3n4tq+w
         xBr52eKSpaCu0yaJphSoCh5A+Naca5OlwQz48oBNchEWPCOxQlzLitQ2WQMmMnJJBbb0
         0gvpFUmpYT1C1q/A6vgHz/cPRmHV+vS34L+9O9Q9ghvbtjNUiHJU4GQpTtpZ5/xJPL6b
         D8rL/nxx6ciLVbXddjtGhJlFQoj7NwTpWSi6zQvqUIvt0aReOg8kRIG3AwfbXXLRVaoM
         TfMqKV0xoqRMlezjCpKpSSttCf45ddpNbalpK00kGwvi76zE0A5OMklOuwKGrIEM5Hb6
         1dzw==
X-Gm-Message-State: AOAM533EVAyFS43ABlbsFrppbtrIDq2vbOrCi2r7Jxk+wRYweyvNtv5z
        1abBDMhXJnayfrrdXi4TzOyHpw==
X-Google-Smtp-Source: ABdhPJzXQ/OmFJ49pFEQQcpj8Zxw6A0s3gYF3Ep+ztrWy7LGzp77vJsdW5RZPee1HaiDh9eHJm83MQ==
X-Received: by 2002:a62:3805:0:b029:1ec:f57c:8189 with SMTP id f5-20020a6238050000b02901ecf57c8189mr14757805pfa.37.1613845710491;
        Sat, 20 Feb 2021 10:28:30 -0800 (PST)
Received: from x1 ([2601:1c0:4701:ae70:3902:ca9d:7b75:1d0c])
        by smtp.gmail.com with ESMTPSA id n1sm13998596pfd.212.2021.02.20.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 10:28:29 -0800 (PST)
Date:   Sat, 20 Feb 2021 10:28:27 -0800
From:   Drew Fustini <drew@beagleboard.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] pinctrl: pinmux: Add pinmux-select debugfs file
Message-ID: <20210220182827.GA70861@x1>
References: <20210217221457.1827266-1-drew@beagleboard.org>
 <20210217221457.1827266-3-drew@beagleboard.org>
 <CAMuHMdXNz8ZbFXRgYCGuAd1+Cz8xTvMc-rkwXXiE-E-Fb5XXNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXNz8ZbFXRgYCGuAd1+Cz8xTvMc-rkwXXiE-E-Fb5XXNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 10:06:51AM +0100, Geert Uytterhoeven wrote:
> Hi Drew,
> 
> On Wed, Feb 17, 2021 at 11:15 PM Drew Fustini <drew@beagleboard.org> wrote:
> > Add "pinmux-select" to debugfs which will activate a function and group:
> >
> >   echo "<function-name group-name>" > pinmux-select
> >
> > The write operation pinmux_select() handles this by checking that the
> > names map to valid selectors and then calling ops->set_mux().
> >
> > The existing "pinmux-functions" debugfs file lists the pin functions
> > registered for the pin controller. For example:
> >
> >   function: pinmux-uart0, groups = [ pinmux-uart0-pins ]
> >   function: pinmux-mmc0, groups = [ pinmux-mmc0-pins ]
> >   function: pinmux-mmc1, groups = [ pinmux-mmc1-pins ]
> >   function: pinmux-i2c0, groups = [ pinmux-i2c0-pins ]
> >   function: pinmux-i2c1, groups = [ pinmux-i2c1-pins ]
> >   function: pinmux-spi1, groups = [ pinmux-spi1-pins ]
> >
> > To activate function pinmux-i2c1 and group pinmux-i2c1-pins:
> >
> >   echo "pinmux-i2c1 pinmux-i2c1-pins" > pinmux-select
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Drew Fustini <drew@beagleboard.org>
> 
> Thanks for your patch!
> 
> On R-Car M2-W, which does not use pinctrl-single, I have:
> 
>     # cat pinmux-functions
>     ...
>     function 14: i2c2, groups = [ i2c2 i2c2_b i2c2_c i2c2_d ]
>     ...
>     function 51: ssi, groups = [ ssi0_data ssi0_data_b ssi0129_ctrl
> ssi0129_ctrl_b ssi1_data ssi1_data_b ssi1_ctrl ssi1_ctrl_b ssi2_data
> ssi2_ctrl ssi3_data ssi34_ctrl ssi4_data ssi4_ctrl ssi5_data ssi5_ctrl
> ssi6_data ssi6_ctrl ssi7_data ssi7_data_b ssi78_ctrl ssi78_ctrl_b
> ssi8_data ssi8_data_b ssi9_data ssi9_data_b ssi9_ctrl ssi9_ctrl_b ]
>     ...
> 
> On the Koelsch board:
> 
>     # cd /sys/kernel/debug/pinctrl/e6060000.pinctrl-sh-pfc/
>     # echo ssi ssi2_ctrl > pinmux-select # Configure i2c2 pins for ssi
>     # i2cdetect -y -a 2                  # Fails
>     # echo i2c2 i2c2 > pinmux-select     # Restore i2c2
>     # i2cdetect -y -a 2                  # Works again
> 
> The order of the 2 parameters looks a bit odd to me, as the operation
> configures the pins from "group" to be used for "function".
> See also arch/arm/boot/dts/r8a7791-koelsch.dts
> For the i2c2 example it's not that obvious, but for ssi it is.
> Might feel different for pinctrl-single, and perhaps I just need to get
> used to it ;-)

Thank you for comments and testing.

Regarding the order of "<function-name> <group-name>", I can change it
to "<group-name function-name>" if that seems more natural.

pinctrl-single does not actually use the group selector in pcs_set_mux()
so it essentially does not matter for pinctrl-single.

-Drew

> 
> Anyway:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
