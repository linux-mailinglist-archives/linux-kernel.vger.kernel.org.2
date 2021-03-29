Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3689F34C4DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC2HZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2HZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:25:23 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 00:25:19 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id l13so5894054vst.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zdRzaWEuScCxUZNvADZ4Dib7S9ZHh3RpkYP8ExLQq8=;
        b=ShRf0xxq50mTHYGrh9xmu9l8UaDjOjMpAOpvWXq5Z2E9qGUk5HKG0yD/nroyUlIJ3L
         fvsEr7iBEq2uglhoZ7d4VauZu0hAxljU25kUDf5oJLFSE/I5KIdNZkOu24JZqMCxJOIA
         yE4Zr1MklDaBQFTN5GywoGecsAOU9tQsQcj825cZho9Nr5vkCMYLSfofe5blNBLbxepT
         0h6t4ztL/97Ulx7fzKiQLp5I/gny4ofI/X7yb35r47NLkKsuTej1AWli0dxwD/PeKvHv
         6GDpl22TUmbr2Bj67Tx1WexepjuQoaSb34MYPiuk4TEnWGpbQ+Ljr8pMNVNcfYA3IP5X
         eygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zdRzaWEuScCxUZNvADZ4Dib7S9ZHh3RpkYP8ExLQq8=;
        b=rMiRYVrELwW6zZsTLqx7w2GxRWSAlV1SXf/xDq3KdLRT40l9/MAQarAKWPpIyZTLpt
         qmiwBfeoQI1yyjd4sF6Rl4rVCBiLhXI0ucjMT8m23KQHDpBVe7MUXAKuEF2FSmoo7aTd
         /xV1hMm8zLQz4wGcALkGwsPFh39PUp5yEQw6wQabOzHgKKY9Fv9SgBNdzcM61CkfIV9t
         YH5awa1mdRBi73ajf21I9fn0/dDxGvuqH2cpxLMjKDowJ39VqDxJuIlrQUPbLKnwq0SJ
         BFCXMAF98BkP5ZOXmep8XYQoUWAvdhzK1FWTzSDuII2Gqh4SmvY+dAbNjI7sOXlU/cLC
         BhyQ==
X-Gm-Message-State: AOAM531c4JAGNL9swQAjfzxb6FiPCwNgLp330JYOO8mw7/fWfMBaNDCL
        dxrVPmlfZ9DAGjvcXhUUmlIq5qTdW2uM4FhtzkSzQw==
X-Google-Smtp-Source: ABdhPJymWMQk5svSmDMu6V2U4rABI7ob9eG2P1+8TQaRG+orYiJKy2lli1R8836VaypGo1zGwtisVj+htjpwsTuRDg0=
X-Received: by 2002:a67:b918:: with SMTP id q24mr10719649vsn.19.1617002718899;
 Mon, 29 Mar 2021 00:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210329165525.32d51a3a@canb.auug.org.au> <YGFwWq//sh6onrUH@kroah.com>
In-Reply-To: <YGFwWq//sh6onrUH@kroah.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 29 Mar 2021 10:25:06 +0300
Message-ID: <CAASAkoZgn1WJ377164yjp2UEvp4fMUezsf2=WsHs5wtRj1inMA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the staging tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 at 09:15, Greg KH <greg@kroah.com> wrote:
>
> On Mon, Mar 29, 2021 at 04:55:25PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the staging tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/iio/adc/ti-ads131e08.c: In function 'ads131e08_read_reg':
> > drivers/iio/adc/ti-ads131e08.c:180:5: error: 'struct spi_transfer' has no member named 'delay_usecs'
> >   180 |    .delay_usecs = st->sdecode_delay_us,
> >       |     ^~~~~~~~~~~
> > drivers/iio/adc/ti-ads131e08.c: In function 'ads131e08_write_reg':
> > drivers/iio/adc/ti-ads131e08.c:206:5: error: 'struct spi_transfer' has no member named 'delay_usecs'
> >   206 |    .delay_usecs = st->sdecode_delay_us,
> >       |     ^~~~~~~~~~~
> >
> > Caused by commit
> >
> >   d935eddd2799 ("iio: adc: Add driver for Texas Instruments ADS131E0x ADC family")
> >
> > interacting with commit
> >
> >   3ab1cce55337 ("spi: core: remove 'delay_usecs' field from spi_transfer")
> >
> > from the spi tree.
> >
> > I have applied the following merge fix patch.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 29 Mar 2021 16:51:22 +1100
> > Subject: [PATCH] iio: adc: merge fix for "spi: core: remove 'delay_usecs'
> >  field from spi_transfer"
> >

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/iio/adc/ti-ads131e08.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> > index 0060d5f0abb0..764dab087b41 100644
> > --- a/drivers/iio/adc/ti-ads131e08.c
> > +++ b/drivers/iio/adc/ti-ads131e08.c
> > @@ -177,7 +177,10 @@ static int ads131e08_read_reg(struct ads131e08_state *st, u8 reg)
> >               {
> >                       .tx_buf = &st->tx_buf,
> >                       .len = 2,
> > -                     .delay_usecs = st->sdecode_delay_us,
> > +                     .delay = {
> > +                             .value = st->sdecode_delay_us,
> > +                             .unit = SPI_DELAY_UNIT_USECS,
> > +                     },
> >               }, {
> >                       .rx_buf = &st->rx_buf,
> >                       .len = 1,
> > @@ -203,7 +206,10 @@ static int ads131e08_write_reg(struct ads131e08_state *st, u8 reg, u8 value)
> >               {
> >                       .tx_buf = &st->tx_buf,
> >                       .len = 3,
> > -                     .delay_usecs = st->sdecode_delay_us,
> > +                     .delay = {
> > +                             .value = st->sdecode_delay_us,
> > +                             .unit = SPI_DELAY_UNIT_USECS,
> > +                     },
> >               }
> >       };
> >
> > --
> > 2.30.0
> >
>
> Thanks for the fix, looks correct to me.
>
> greg k-h
