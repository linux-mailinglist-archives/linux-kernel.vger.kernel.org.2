Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54E3D221B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhGVJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhGVJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:48:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5DC061575;
        Thu, 22 Jul 2021 03:29:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o8so3906314plg.11;
        Thu, 22 Jul 2021 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/T2v25ISKwnv+JiEOMpEorfBjmX5RIS7o1WRWb9zSI=;
        b=giKvgL5mNpL7ZueglLsoIjxTM8iEkf/lQSwAd3w1o9qUSZuhxP6kcDyfFcH4a5u3jR
         hcNE0sTliFTt6qLb1MgTpVygPhH8RQjFLKJWCIh67QfqW/BkQVoDNAy2e/N8qcDzzWp0
         czN4xrEZsgFbsSVoZBOEQWOt4C3TrbCZGl6ETceKz9Bz2RB8oQsYQMVIv6E0qAh5JDNO
         5p2EHdXs6y1g12iXkJNkcEbiyNjKa+YRCPTCMtXsQ6k0da0Sj0xmDXiQ7KkbeBWSVi5n
         1y0jSm+XIXE/v7fpaXJfG3rETyb9hq5nHu7x+8iacyH66bmxy4B+wIc6yWhzE+9v73Z7
         yYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/T2v25ISKwnv+JiEOMpEorfBjmX5RIS7o1WRWb9zSI=;
        b=Dy4fW4P0AeiEUyq6I80X/WHVv8nlojnmjUaVD4zP/74nZZUL1mf33DtUqPLa8ATuNC
         Rokj6TraaOPWGH5FRh913SoTDYZn9L9UW1zJdKDx2q3JH9IMZaAa2ty0W8e/6mOBH+iW
         XeZ/j1YUmUIXY1iouMSp6uM3Q6to5rk+CgvUfpZehIAjFWmMcMoqHy6u2dGmLaj220QR
         xCKWnVY83yISeyWCccUmchSZidDgBC7KVEATfWLEbYhMQUvXFjJ7YFft8drbJSCj7r7n
         Aeh9YFIljrG+NuJU+kmSFbRZl1XKH+ZqvjASYKvFuEYOPuql/8cDd/Q9Dgj3h/KhlrAw
         JENA==
X-Gm-Message-State: AOAM5316T4ntT4mUpAZFfq4BEQv6AeQSV5J7GLCufUF3eT0wX8/c3kDd
        yrKPPkcjdOl+/0U0Vaq7LP/I83Hy326SNsc0d1Y=
X-Google-Smtp-Source: ABdhPJxoFCTp/NwlflZaAjqRTJvKvp0S635JhOGs61WECIltH+YXzHhAb9KefZ/ctEXb+XBhIbLUIbyfg78dqZ6hCc0=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr8455268pjq.129.1626949763784;
 Thu, 22 Jul 2021 03:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
 <mvmlf5z66l9.fsf@suse.de> <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
 <mvmh7gn649v.fsf@suse.de> <YPhT1APE8QweDCoP@smile.fi.intel.com> <mvmczra64yj.fsf@suse.de>
In-Reply-To: <mvmczra64yj.fsf@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jul 2021 13:28:43 +0300
Message-ID: <CAHp75VfY-_xtRJyfez_4voDuOUcfJAfFjtnAipCt2_UA4wqbQg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
To:     Andreas Schwab <schwab@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 1:03 PM Andreas Schwab <schwab@suse.de> wrote:
> On Jul 21 2021, Andy Shevchenko wrote:
>
> > Or problem is somewhere else?
>
> I don't know.  Why does the spi subsystem put "spi:mmc-spi-slot" into
> the modalias file, instead of "of:N(null)T(null)Cmmc-spi-slot" or
> similar?  The same problem exists with the other spi port on the board,
> which has a jedec,spi-nor instance attached, also not auto loading.

You see, there are two unrelated drivers that share the same issue
(the common denominator is that they are SPI devices). I believe the
issue is somewhere in the SPI core rather than here.

Compare the code of
https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L649
vs.
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L56

and

https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L139
vs.
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L361

The culprit is this one:
https://lore.kernel.org/lkml/20190618052644.32446-1-bjorn.andersson@linaro.org/

and in my humble opinion must be reverted.

-- 
With Best Regards,
Andy Shevchenko
