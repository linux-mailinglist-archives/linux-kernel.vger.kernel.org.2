Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF63F4308
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhHWB0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHWB03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:26:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E87C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:25:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d11so33400851eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqpWK2NpNMam+FVrnd5Qq4UQdG4vZMylCROkJYXdu6w=;
        b=mtHYLDxx+doZhDcK8JqpU0r2bgFOmLiQYIGB6kkMOuslrKGLPdnXfhACq0msmAHHqV
         wUSGl/V1rpTV5MzKxsKUzcrWv90OZg2d6Aq43ZEbaM8j9WbxaUhk5Cg/HfMf0OjgUaTk
         RPcOo7irbUFOg9p/PFpYoxcXZI2xfBc0qYsU+Rs8jtG6wsktBqgyfJFiKtstXvDcXvGl
         6BryYhWCifc74SPcD/Xrl5U0CwwvfWaze1TRdwesoE2CjUli9pDLPvhrD03LgyIrobpk
         myi2pB7Bv5gkYlxhrXSia6dWyqf/PfYY76vmH16/gcxECjrohJ+cUinGWq4XUNZbUs87
         oquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqpWK2NpNMam+FVrnd5Qq4UQdG4vZMylCROkJYXdu6w=;
        b=JnfWkO7w3Zyg5dpX8hhaAs5DF3bFmbvrG1JABrraKWi7+MZomSEbB/zW5fFQkF0UNC
         EoWErWGK6NUQjttRWVlwSbd79lRLF5C3gYe9EeHFIOHzJ9K0ldC3fI3gOPYMKhbQ/yDM
         g4RP7ryxWdS8j+RxrSkJcRx5tFfr/c8OKPDAaNQEA4mA9JIDbRiyMbLF3EEWSJVjZudZ
         9IvVkj6T5uD1qImVZi0ln+DdOnuAQifa71xO/Zbgm7I6rG/jqktR88f99hXz3AeFTX3t
         lhgFNWDz22xWNH0lzQ0b1qpngnqcMkNlWoe6nn3ZzIInC0+4BOqHiEsh2qU4tB4FaOl+
         hIsw==
X-Gm-Message-State: AOAM532Hq9rloS5xPfCZCzDd3er6/Tg5RiIaNCW1X8HR1P13JS9enBMb
        7UdKXaM9M8XEgoEiuKRWGvDsAbytSKZcaRs2CWy50Q==
X-Google-Smtp-Source: ABdhPJy/0sXtHHmKiUqDX9OM8jGFwko/lR4cRRRmI4r2eEOY/cer4itLJuSzsZZTroiumuKovs5s5IlI725zYJ9AWMo=
X-Received: by 2002:a17:906:b25a:: with SMTP id ce26mr1436524ejb.174.1629681946141;
 Sun, 22 Aug 2021 18:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-4-brad@pensando.io>
 <CAHp75VfmSKVRB+Rm+sWDjZaJwdX4qt56Qj6aehe4YnA5d6+a6Q@mail.gmail.com>
In-Reply-To: <CAHp75VfmSKVRB+Rm+sWDjZaJwdX4qt56Qj6aehe4YnA5d6+a6Q@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:25:35 -0700
Message-ID: <CAK9rFnzdPpVBZu8uxHU04pak9OxPMjFqAt_qnPQY2qK2WK4rTQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Mar 29, 2021 at 3:43 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
> >
> > The Pensando Elba SoC uses a GPIO based chip select
> > for two DW SPI busses with each bus having two
> > chip selects.
...
> > +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +       struct dw_spi *dws = spi_master_get_devdata(spi->master);
> > +
> > +       if (!enable) {
>
> Can you use positive conditional?

This function has been re-written to use the existing dw_spi_set_cs().
This is what I currently plan for the v3 patchset.

static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
{
        spi->chip_select = 0;
        dw_spi_set_cs(spi, enable);
}

Regards,
Brad
