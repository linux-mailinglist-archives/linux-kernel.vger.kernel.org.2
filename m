Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2C3DD396
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhHBKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhHBKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:23:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA62C0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 03:23:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so10676463wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2Tqr4YkxH0iHn9cWJXFM1JhnDDfk7PRNn3Xbif3DymU=;
        b=yTL74JI0Tsf/7l4CflqlYsb2R386So4zX/KeZfekDjaWWZWudIajn8E4yHa9oQ/Nob
         SaUZ1sXmoEXWD7alo0V0x9j33cFK1vVOvjTXc9cmCGYN1VrM8DQrueEueOaqrGsggpar
         1kMMj6Fwo9YH6agTUTQal5zKPuh8rAmDbN0KP6MV0P1nU/35heXTIuBA+Tu3+bQmGQFR
         fakLfXh6qb1czfN81g2YSEHoYCTYJ6wYOepYsdTV8zuG4fen4aHs9/e8NfF+JQ0de6uW
         Nqp7wBHcRF78x+gabgYnN6Qxm56IDp7tLpHnQN2K8j0DnueCRz7EvOkEerPzl48GaU3j
         Z7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2Tqr4YkxH0iHn9cWJXFM1JhnDDfk7PRNn3Xbif3DymU=;
        b=j2c6vWrmBFwMn7TCxZ3tZgcbXMW0I8yq1KqeVqyJ1PcfHhlODZwM6fVZC3QWFLmQrn
         fLzm/6iA2VF1RK40mrd+JQRi8oEZP7fDeEfQIQBgLqJKullnsnvq5+OP4l4JN4s7gpFF
         +qFjsJwkM1GUcPpLghPjU+HbYEQiVrI/kqPNuTMQJZIXzmHyU44awPSQHvGXdgSNRdEm
         f2BKLr2vG1+6GxWes8ns7UEOUUeiVmpG/4D0lGQn4MgirfD8bGutabXy2QnvuVbG4ua8
         L2eWZcamEkX0ASWKjsopYJAgGqpkxE8vDWkxsCxbu4iuTZoA4JbSZWFR/51wAMgQlier
         v5XQ==
X-Gm-Message-State: AOAM532nnrKDSlbXBoVkwhielkAskEAGuIlSq09lhF45Jj9RedNhRV+J
        ANtu+Y3a/Cv0mAoIK0pBdYCqUg==
X-Google-Smtp-Source: ABdhPJyU7oC2nzExKDLEK5XpQNdvMbmcafIPLxE7GaQ/U+AI5XH3bTzqaB6q2k/O6kfKT4Vkg5Qs7Q==
X-Received: by 2002:a05:600c:3595:: with SMTP id p21mr10776040wmq.43.1627899808765;
        Mon, 02 Aug 2021 03:23:28 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id y24sm9238416wmo.12.2021.08.02.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 03:23:28 -0700 (PDT)
Date:   Mon, 2 Aug 2021 11:23:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
Message-ID: <YQfHnlwDbkI1J130@google.com>
References: <20210708115804.212-1-alistair@alistair23.me>
 <YPbjZdu7T9wFcvNz@google.com>
 <CAKmqyKO_MEFy-TWy2+3o3+pomQaSQ5WeAcE3Zy-iquas09RfRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKO_MEFy-TWy2+3o3+pomQaSQ5WeAcE3Zy-iquas09RfRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021, Alistair Francis wrote:

> On Wed, Jul 21, 2021 at 12:53 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 08 Jul 2021, Alistair Francis wrote:
> >
> > > Initial support for the Silergy SY7636A Power Management chip.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  drivers/mfd/Kconfig         |  9 +++++
> > >  drivers/mfd/Makefile        |  1 +
> > >  drivers/mfd/sy7636a.c       | 81 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/sy7636a.h | 47 +++++++++++++++++++++
> > >  4 files changed, 138 insertions(+)
> > >  create mode 100644 drivers/mfd/sy7636a.c
> > >  create mode 100644 include/linux/mfd/sy7636a.h

[...]

> > > +struct sy7636a {
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct gpio_desc *pgood_gpio;
> >
> > This looks unused?
> 
> It is used in the syy636a-regulator

If it's only used in one driver, please declare it there.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
