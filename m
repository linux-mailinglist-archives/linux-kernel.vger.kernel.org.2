Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC234DE61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhC3C2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhC3C20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:28:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE3C061765
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:28:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so22467932ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=as6TC2k6xEEVIuVX9cZ9mNSha9Pgs1VOeqieHwq2ZAk=;
        b=0/Hcptk+lGf7RA7QeLI8de294bHY+a6+K92ctHUL8ogRG3PRJi/RvJGGeRNOVzBZ6Y
         Cug7wcbQjiIeazHgGQ4vY9/DrdQ7aLvEjhZq1YapIeA0UPEcsZfp9NbpBfl6HT/5g9o0
         aqmC7ovktIlGdSVnLxllh5zgTglmUD5sCzQW1wRApjaK3i2NGFrZszCzgp/bD468XxID
         UECyTZMdRNYozflEzmeZkUXjklvH21iraJm7mCNoaRLpuQq/grxfpcjSo8ZnodelOoIP
         xc3Yh9CKjzz6wy2jtyPdtDuSibDTYKHT313SllBRLqt0iNYx47SubGDemTVLxHWd6dBV
         8h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=as6TC2k6xEEVIuVX9cZ9mNSha9Pgs1VOeqieHwq2ZAk=;
        b=pHzK12NNZYzyOW+YdNldCUx4Po1lWJXaVRAg45elROJmNdKQnP4uCET5d+goZBbSi+
         184f/7AfTn4rt9ka6g02VhJOuBfbHqx8oVgA6UH3f+GYNRwJWfotWKcAV8ritMk0Acwy
         Y9XvlMc4U3KB/LN/DZ0+VnmyUqk0a+NqslhNWqAENvGH7PmUSRvIeYzoDJuQoKdQ8R0O
         NBHHUS2Q7Io8fpPc9gTL7xrmPMhiNeDSWc47nbrMNX1o8kn4xaD+kX47NF1OwgYWjIcN
         AK8bYOASYYE4yeMGg9r4yL5V+Fvn41tbfMqMyjBPen27ftxsqip3tUxOGNU99j7i0OL9
         pweA==
X-Gm-Message-State: AOAM531VerwLBU0i4Tehs5iUO2RTl0UYhG/JcASkqNhkknovD7X+ZRD1
        zJFb6/hC59P0P6tOn4ga8RX70c4FGEKGXRA9b85gAA==
X-Google-Smtp-Source: ABdhPJxrtj444vLfa7by3n/VVs+in8qeM1zAKOJDHyFcmwzb3ptLOzZ9Ug2uMihG+7mETsyFGgfEz+SqnKrX+SstUUA=
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr30819105ejb.444.1617071304549;
 Mon, 29 Mar 2021 19:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-4-brad@pensando.io>
 <20210329155843.GD5166@sirena.org.uk>
In-Reply-To: <20210329155843.GD5166@sirena.org.uk>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 19:28:14 -0700
Message-ID: <CAK9rFny3RZSP8=RnekcLNz0KrBfko8jkc4pyXpfiEyF2TUmr4w@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Mar 28, 2021 at 06:59:28PM -0700, Brad Larson wrote:
>
> > @@ -56,7 +56,7 @@ struct dw_spi_mscc {
> >  /*
> >   * The Designware SPI controller (referred to as master in the documentation)
> >   * automatically deasserts chip select when the tx fifo is empty. The chip
> > - * selects then needs to be either driven as GPIOs or, for the first 4 using the
> > + * selects then needs to be either driven as GPIOs or, for the first 4 using
> >   * the SPI boot controller registers. the final chip select is an OR gate
> >   * between the Designware SPI controller and the SPI boot controller.
> >   */
>
> This is an unrelated fix, please send as a separate patch as covered in
> submitting-patches.rst.

I'll remove this.  Belongs in a trivial patch set.

> > @@ -237,6 +237,31 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
> >       return 0;
> >  }
> >
> > +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +     struct dw_spi *dws = spi_master_get_devdata(spi->master);
> > +
> > +     if (!enable) {
> > +             /*
> > +              * Using a GPIO-based chip-select, the DW SPI
> > +              * controller still needs its own CS bit selected
> > +              * to start the serial engine.  On Elba the specific
> > +              * CS doesn't matter to start the serial engine,
> > +              * so using CS0.
> > +              */
>
> Why does this comment only apply to one branch of the conditional?

It doesn't, I'll move it outside the conditional.
