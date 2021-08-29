Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6743FAEA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhH2VK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbhH2VKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 17:10:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24581C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 14:09:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d16so22365982ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxGuGUCOWFryUZD+MaZ59To0anU+4+sFudo5C46Dub0=;
        b=nfV4aILK8Dhh0ahV+TeoNvDhnE+SFerHJVlQxUxDjik6lEG0UgGuflyvtwuZM3YQdm
         4qQpuazJBdWnkrpt4pxqeGR2ZFUjui1ttQiGi0NSY0EcDZ4jZ3R/AQRXWUCIgJP7OVwK
         O45bi3/RbDPtmOwEU4zDvmLxZdYW0R+TNFfnmNx1w2z0ehUmRJXYhtjzBs7s/KsczncH
         QkM250uLLIMG0o3c+ZFspIKI8WbWDbWAIYHmTNRLyNh6FDls+xLNU4mhI437adrXa7+e
         IlBSD8RjKAm0Uyce5YAKTJcXYTWGPHLc5TE08oh4vmz/ETInqZxez23f0cGw8+TXNDTo
         OS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxGuGUCOWFryUZD+MaZ59To0anU+4+sFudo5C46Dub0=;
        b=CcamU2+Q6kiDOUWRIBdDATcC33yfdCENfMfyygoT9q2xcGau4EURMGZZOHjSwVaylm
         lItxxeOeKpHhhubk4WQrLP8RsXbKINax3TNGUfpQZZ2z9IeGbDt2xid5tgz+eufxvBUV
         YKj0vj7mGAMAAzAgRxEv66ng/zwE+u+V8iyprAHOCZqjMXmetqoc5YxOD50962PLsAJs
         vyOJASAfhgwX810jA1GITIfpTwUJ7xcSYQPl/j7Atr5qrHcA+TIpGv6g4mDX8/7FkY90
         W8lre5qbS8O7+fexluwnTo2A8VpdVqwPhBohenqUJ2ct8LymwoBLz3a5q2rBXpXJACOT
         S9tg==
X-Gm-Message-State: AOAM532bB89GNCzs8c18s9DFSai2k5XXx2ZN1G6WZc85WNFU7lY9Uahd
        IjCAB/oZAXZd33XbKAixxfp2ZR+CI4B5yGrHUhL4NQ==
X-Google-Smtp-Source: ABdhPJyLBGZC3w/XZYPqVgq7E9XJqzge4fnt3b3JacxNwyWo1sRegJwGgEN+8tVF7EFU69+xMuu7WMDdF20ZdQXFkk0=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr17978352ljf.326.1630271370403;
 Sun, 29 Aug 2021 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
 <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
In-Reply-To: <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Aug 2021 23:09:19 +0200
Message-ID: <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>, Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Mon, Aug 23, 2021 at 3:06 AM Brad Larson <brad@pensando.io> wrote:

> The gpio pins being used for the Elba SoC SPI CS are dedicated to this
> function.  Are you recommending that the code in
> drivers/gpio/gpio-elba-spics.c be integrated into
> drivers/spi/spi-dw-mmio.c?

That makes most sense does it not?

Special purpose pins should be managed by that special purpose
hardware driver, DW SPI in this case.

The compatible string etc should be enough to determine that we
need some extra GPIO control here, possibly specify extra registers
for the SPI host etc.

The struct spi_master has a special callback .set_cs() and you
should make this behave special for your special hardware.
In the case of the DW driver it appears that even subdrivers can
pass a custom version of this call in struct dw_spi.

Yours,
Linus Walleij
