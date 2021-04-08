Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D831C358FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhDHWOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhDHWOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:14:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E03C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 15:14:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y1so4097473ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZYFt0LVceFfcAprXRqy7FjMz5TZMkhneNJXsWawHjA=;
        b=jh/m8+mpPAxdKJ0faiWMDsB8ThJ/bVJJ9pnV2DdOmRS9/0Oups3cMyWdWzW18R9i8j
         gbunTrdTzXj61KzAnIHGuLvJ9nkft7x+MraDzr7gFF1yaBGUjtjTTdMiYQ+PunQrg6Mq
         AHGDRg72C/ydMvv4dEfdxZRPqzyRfYLL/pSvqU735sU8zij4s5RgqNN1PZ4wS+Wdi6Ka
         AZRfpoyBNCCwQ3y+fFkFyztWzGjIj4Wpf0KA1axvxXHsmaTEVk+z8NE0++4kRHkHMHFm
         aPIVCbs0pKTV4iffO/p2kmB53EhxBPUETOwOLcv2vlxxWltOmJLjG8b2F2EkOAbgrmI2
         7blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZYFt0LVceFfcAprXRqy7FjMz5TZMkhneNJXsWawHjA=;
        b=Pj6FycWjpghqBFU1SreLhb/Twv7lo2yVuuDN1ywI0eD4seKj6EHgjFDiFTXRlxO4AR
         WYSGcVrXgaVSyHD443KOFWzalWPFkv4pRn0eDLf8y67XXKhWd9yhnGLF0RKTP7B4piJ+
         E5sJsotSiN65Nss2Tqp+6yxcRBKC5NgG0nyFJMbLd+fCp9oYE6z1z8RlA1IpsyetSE56
         qWzMnsRXVQUdhrStK8PfooqyKSjqWRO4AlMP3b7VdkOFXZTb/ull5T8vTbeulHKMI85D
         Lq0GsWZ/yLAwAwVCozkIFTgGBincHAA6jW3+vpI+/l1QHcTvXVe8HzWCaQbWNBKzj9uc
         tXew==
X-Gm-Message-State: AOAM531s6WyYAEEyhXgJtEzcyZd1St7PatNshqIxqCf1SCBzFvijHkno
        icuPRgLWuWBY9rUz7Ao/+MMOQTd1/G5jod+w/Qva3A==
X-Google-Smtp-Source: ABdhPJzWty7OkE/zjpcMz5z53ansy9SUNQ01JxDM7F1AxOx5za4NUdfe6x0onlsn7zmcaLaN2CQvWeG2UAY2qDU8U9A=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr7305898ljj.467.1617920077290;
 Thu, 08 Apr 2021 15:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <bdb18e9f-fcd7-1e31-2224-19c0e5090706@marcan.st>
In-Reply-To: <bdb18e9f-fcd7-1e31-2224-19c0e5090706@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Apr 2021 00:14:26 +0200
Message-ID: <CACRpkdaijbDoV2rSQsgO3XKnj_Hde8CU9JQ+V9gGePYjvCWJhA@mail.gmail.com>
Subject: Re: [GIT PULL] Apple M1 SoC platform bring-up for 5.13
To:     Hector Martin <marcan@marcan.st>
Cc:     SoC Team <soc@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 5:55 PM Hector Martin <marcan@marcan.st> wrote:

> Hi Arnd and all,
>
> Here's the final version of the M1 SoC bring-up series, based on
> v4 which was reviewed here:
>
> https://lore.kernel.org/linux-arm-kernel/20210402090542.131194-1-marcan@marcan.st/T/#u

Excellent work on this series Hector, thanks for working so hard on this!

Yours,
Linus Walleij
