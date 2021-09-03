Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1AE3FFBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbhICIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348283AbhICIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:19:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52325C061575;
        Fri,  3 Sep 2021 01:18:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j2so2871908pll.1;
        Fri, 03 Sep 2021 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Phy4y+hK8VUG7m5ozeRhmhn2qn7hHWlVNnFuLnJTpjc=;
        b=gn1LEqFm5OmaNC3OgzH7jznj34Dikd547FTlAL9TVFOAYlYNHJPfhekk0eQk2Znxs5
         uocl0YFazDRkIFKdYErCaJjcR9vmP/H0TUon3uc+OsyKZCbuJBZHYRcIlwIkoXl2+THw
         R8hfIrWbdRc5th9rjyA1lHcLWd/Sl6XlKt7ET3Z7ujJDROG6UA1RvQwAZWNITFmAxand
         SIayzdGpAtmLJM+6KSnHENivuL7g1CPNhLugr+GoPRzmI03HNG4Y2KWT2o24vKq8UVgb
         Hxdbtb7A4TAFGSLGWXEZKGPHPZTD/yfwV9ob+lru6nrVqra51xGzyRTfSQ7WeuWmu6ow
         uSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Phy4y+hK8VUG7m5ozeRhmhn2qn7hHWlVNnFuLnJTpjc=;
        b=pvp9obvfTcpciCH1U9KjiUB+dUhpY4PzpteIc7sYjUna9Yd+GJL/QMcG1oOdbea9WC
         4LsJMtCWBRKR7IQA63txU8NRMCOlpErFAuuw4jPSrDGhl+8vul8ffhxEjmljWKMXCly4
         bKbjn+a/BpqAe+MowJ8jBkqjQllCfwugIhTP5pOUP2IA6eQaifOfwWjcx+dpaXy/8vXG
         nlriLaBqqTgwDrEhuics7thjZd6QjT6xAV/WwCP3euCgHGYOyPy5W2Uk68DN1IXtAuFf
         1a6uyLYLKD+Mcici0Dkv7lO/EdGp4+/NlOHBvbPFFwVIsmx+MJTCsIlu4nGaVLwQrC9d
         LUpA==
X-Gm-Message-State: AOAM5324MMtbLWv0da7PAHQChaBV9EUtH7OidoRMmy4aHfim3WkGO5Qs
        d4VnowTJNaxdwsjlUp2EyREGYN2rxajGV07jp1c=
X-Google-Smtp-Source: ABdhPJzjcz+T/rpM2xV4DX89iiUWYDC/IW9iTMT4R5z5HfU9u+eFFYZ/UnNTm5DTP0q6HUPwup3yQ4pjf3XiPYLlZwk=
X-Received: by 2002:a17:90a:6502:: with SMTP id i2mr8685279pjj.129.1630657130779;
 Fri, 03 Sep 2021 01:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630632805.git.atafalla@dnyon.com> <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
In-Reply-To: <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Sep 2021 11:18:14 +0300
Message-ID: <CAHp75VeD8sbxcu==BF97yY4ZGtLbNAQSiTxq2cDvBSdCpXxsyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: max98927: Handle reset gpio when probing i2c
To:     Alejandro <atafalla@dnyon.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 4:51 AM Alejandro <atafalla@dnyon.com> wrote:
>
> From: Alejandro Tafalla <atafalla@dnyon.com>
>
> Drive the reset gpio if defined in the DTS node.

...

> +       reset_gpio
> +               = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(reset_gpio)) {
> +               ret = PTR_ERR(reset_gpio);
> +               return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");

Not sure why my comments have been ignored here.

> +       }

--
With Best Regards,
Andy Shevchenko
