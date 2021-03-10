Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA873333FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCJDxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhCJDxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:53:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:53:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so25392763edx.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V85TNfWqFZ1YWa4+0GmlbK4ntqljyBS3Rdg24ykQOq8=;
        b=T8WNl3ye+lgMOr3Hf7sVPy7jQOGqPpwD9/Jt8gsoFhzRrcvWM62VXcGTl47x2GnQkF
         CFwacwingV3+q1IbKsKuyuNfcEGRf0Ty3T14iZATP6JfeNfPlVlYa7CuuimjxHHfsSIi
         opLIGbAKyuXFTAmfxA41bk3cXk/xy1w2rk4+3SqRFMx/Ngj003h4ewfssX3ZHmw9lnde
         Znk/TrU4AuthDorMF34LO58IV18yCB+OuLOEd+WQgbnmZrUZp6MiyLTf8dL1D67Vl69g
         eW24XhNgo9w39ZjUqGYpyVmfu3C1r7XCYS213qniCd7nzkoGWu9CUs1l77guT1o83qOA
         z1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V85TNfWqFZ1YWa4+0GmlbK4ntqljyBS3Rdg24ykQOq8=;
        b=Q0Lll8tkMsQurZO8srLxKLxPfYaSS/+eGyNu5XZttzH6rfXHwoFMhMgU1Ke5Yxl3hu
         6dOm6c9ho+KopkzYWefCLgEzr8wZITxRINicRqomAyGaBlmkFCXHwL5zNso6FBfuY17m
         9kG0Z5OVxcudh3gkR/8HUNUxPbej4W5liEpOxZ4nyvVbytDKSzvA/dus1uf0NnjgLFk8
         3XKrHTFVYDN/fjNR0cb3VlxPtPPD6li9GOs90HqggLBsjgRLwP9nPV87z+YlG6p3wwch
         Es67QX8rXGrgvfu9+FsGnKJ2xrRAtpqe8U1/I79lNGRbr6NaCFWnWlI07zbFgaUXxbZY
         ZR8A==
X-Gm-Message-State: AOAM530HJqloBDAYXD8hXDRWPtD8OEL/d+X07NwTB5fmpxMGT3zUafz+
        ebVjinyjhuo3elkUwxCNTZ4wT5asYVCvooANf0O+0A==
X-Google-Smtp-Source: ABdhPJzB8cRnMmkiPZTcmJvX4c2OtzugP+mbvj2rl8DsysINHwrol+RNZBcMO6TXO06YDz3jiaOXzCAzsTSfru8WhXM=
X-Received: by 2002:aa7:c496:: with SMTP id m22mr935303edq.292.1615348385484;
 Tue, 09 Mar 2021 19:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-4-brad@pensando.io>
 <CACRpkdbqkmUXTPyX8OFxBRJahEL-vdxR0wP=rMAWud34bq7tcQ@mail.gmail.com>
In-Reply-To: <CACRpkdbqkmUXTPyX8OFxBRJahEL-vdxR0wP=rMAWud34bq7tcQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 9 Mar 2021 19:52:54 -0800
Message-ID: <CAK9rFnyqkPSvSAJP12ORkSC4J0OGuYeQPNFSgbokor9HpbUh+A@mail.gmail.com>
Subject: Re: [PATCH 3/8] spi: dw: Add support for Pensando Elba SoC SPI
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 12:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:
>
> > The Pensando Elba SoC uses a GPIO based chip select
> > for two DW SPI busses with each bus having two
> > chip selects.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
>
> I agree with Serge's comments here: the existing cs callback should
> work for your SoC, you should only need the new compatible string.
>
> I see why you need the special GPIO driver for this now, as that
> is obviously driven by totally different hardware.
>
> Yours,
> Linus Walleij

Thanks Serge and Linus for the review.

In the SPI driver, the reason we need our own set_cs function is that
our DW SPI controller only supports intrinsic 2 chip-select pins.

This is the standard DW set_cs function:

void dw_spi_set_cs(struct spi_device *spi, bool enable)
{
        struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
        bool cs_high = !!(spi->mode & SPI_CS_HIGH);

        /*
         * DW SPI controller demands any native CS being set in order to
         * proceed with data transfer. So in order to activate the SPI
         * communications we must set a corresponding bit in the Slave
         * Enable register no matter whether the SPI core is configured to
         * support active-high or active-low CS level.
         */
        if (cs_high == enable)
                dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
        else
                dw_writel(dws, DW_SPI_SER, 0);
}

The dw_writel function argument DW_SPI_SER, BIT(spi->chip_select)
works for chip-select 0 & 1, but not for 2 & 3, as the IP only
implements bits [1:0] in the DW_SPI_SER register.  In the Elba SoC we
require GPIO-style chip-selects, our own set_cs function, and we
always use bit 0 of DW_SPI_SER to start the serial machine, not as a
chip-select control.  In the dw_spi_set_cs() function the below else
clause is never taken and leads to confusion.

             } else {
                        /*
                         * Using the intrinsic DW chip-select; set the
                         * appropriate CS.
                         */
                        dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
                }

This else clause will be removed in patch set V2.  I tried the generic
dw_spi_set_cs() thinking it would just start the serial machine while
the Elba spics drives the gpio chip select, that didn't work.  I will
take another look at it as I work on V2 of the patchset to see exactly
what breaks during spi init.

Best,
Brad
