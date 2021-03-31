Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F63234FD94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhCaJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhCaJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:57:55 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:57:55 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id r8so5945273ual.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/4w0xGXQr4V8hv1TMOj1rdT2uYQ2Zn3yahGktko5LI=;
        b=vD3f51suI/hibKgnCzDplaC1Wvjkiv5pk95Q9OkjBAaHm6iC+YfDF75mnhUauRatMQ
         WCjT8JWpjTeJnFmVWCVWsP473ipIJesrrJsJkdfasTxn9LelBGG7oCxQ+nx0ZD4frr1J
         8zJ2PYVfPc9xnj6iLip+AzAifdgxJek0WZTAvZ9/4bwhF0GAl1qE4UXCcxssTkqepRa4
         eNK9EZOrUqoOrvqL3h65gpcbthp1NrH+jXAa3hkcF/rNCEvdFhWPf4BxCWectRABbEVg
         kUf06pB489TJ7WbwvtQGdXt32+n05V7CDyVsK60RMpFJtvyWE4xFJZDgatbsJ+Ul4sGo
         igmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/4w0xGXQr4V8hv1TMOj1rdT2uYQ2Zn3yahGktko5LI=;
        b=cbF6bVltJ+biKW3h3FaHsaLeSqchFLde1pLDlSvHFQBGSrqLL470R33KjqV5bCpjme
         JEbD+12vP/Pk7nW1an8/YtLaZPBufZqHYSweQfLKRzPAkjZFax82Xp+9W9QptycTxZ8P
         paQOhn8XdPmO53gkq5fNTgwsEwODzOHWK3iTXZQY8Xb4zhRqdHH6ZHEr/MOIqi27WKrA
         OvG/OxIIcaOm6Kf+RyaTCWYsMvNhgc+CWuIJSPyC9iXpAPPITrHdIncq1cWnzkgFJR5J
         x2j5F8myW0ttk7xg9EB9gY+O9B8pa8HpIsYT6b1P7QKoqDZQd5jSmH7TIaQMo+XVUOuX
         kh1g==
X-Gm-Message-State: AOAM533Mu09SkxRPZ2ODWCVsPeghTB8KY7YEniUK1yvevOGmAswl/bPL
        klXX4so0VIG3NHzlsLVNEn8+rKRHgRqSS9st9Lw39g==
X-Google-Smtp-Source: ABdhPJw8gZ+V1rBvQ6SEQxKGUiFOg2MD21AiJcNu0AmvI9RthPJOKf7uTIaGd0U0J2P909HggPn33jJHoaA5yNa+r3k=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr832849uar.100.1617184674669;
 Wed, 31 Mar 2021 02:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
In-Reply-To: <20210225170352.76872-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:57:18 +0200
Message-ID: <CAPDyKFp0+jBDcJnxbvdkZWo6jmSa-CdT6RNbH2hmrWnXEqU0=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: core: Preparations to support SD UHS-II cards
To:     Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Renius Chen <reniuschengl@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        greg.tu@genesyslogic.com.tw,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben, Renius,

On Thu, 25 Feb 2021 at 18:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> A series [1] that has been collaborative worked upon by Takahiro Akashi
> (Linaro) and Ben Chuang (Genesys Logic) is targeting to add SD UHS-II support
> to the mmc subsystem.
>
> Throughout the reviews, we realized that the changes affecting the mmc core to
> support the UHS-II interface/protocol might not be entirely straightforward to
> implement. Especially, I expressed some concerns about the code that manages
> power on/off, initialization and power management of a SD UHS-II card.
>
> Therefore, I have posted this small series to try to help to put some of the
> foundation in the mmc core in place. Hopefully this can provide some guidance
> and an overall structure, of how I think the code could evolve.
>
> More details are available in the commit messages and through comments in the
> code, for each path.
>
> Kind regards
> Uffe

I just wanted to get an update from your side. Did $subject series
help to move things forward?

If there is anything else I can help with, then please ping me.

Kind regards
Uffe

>
> [1]
> https://lkml.org/lkml/2020/11/5/1472
>
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
>  drivers/mmc/core/Makefile    |   2 +-
>  drivers/mmc/core/bus.c       |  38 +++--
>  drivers/mmc/core/core.c      |  17 ++-
>  drivers/mmc/core/core.h      |   1 +
>  drivers/mmc/core/host.h      |   5 +
>  drivers/mmc/core/regulator.c |  34 +++++
>  drivers/mmc/core/sd_uhs2.c   | 289 +++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h     |   6 +
>  include/linux/mmc/host.h     |  30 ++++
>  9 files changed, 404 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>
> --
> 2.25.1
>
