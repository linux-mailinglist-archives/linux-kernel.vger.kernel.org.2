Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FB450364
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhKOL07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhKOL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:26:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840CC061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 03:23:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so70290325edz.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTWihlS7JMTvQaBGNGJD6t4n52toGFrv4uGcY9ggcM8=;
        b=mCx2UlhlZa5VElpVAh6Ze+4eSolv61qJqaXdv62Jf6tlyBvZM2Lt/L9UexMvAqRjr0
         9QgONMSdrfGQK3YYAJEuT0N9zPwHZ6jvjNUf3NkqLKaa5G5j/i0mgnJMyq0DUn5xDDSo
         wztVBaOLMTVDZ1HEopQHvZVg6LalRMnf+lSTafPlXyyJFyuvkeeu8IbJJLrLP4LLQGob
         2kT2KFt9Hg4gO2I90AaiYjyD4nhvwigwes8jJYWYGiLZJ8W/6WA+LMN8yd31CBegr7ux
         yQhn4dxF5DojWidnFx03NXqhYbtKS5wYS/u5gnpcdqpsfS2iT2s1Sd+cvHygCfRCoBBO
         JJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTWihlS7JMTvQaBGNGJD6t4n52toGFrv4uGcY9ggcM8=;
        b=ZsltHHaziletE3Djk3rVzQV9AcrvQptVRSgaB0bDHXtDrCxd6u9yeGw8EhdeCNTzNU
         Yf3jQSQYi1vIJY4egpK03tPjfavcdNSCHrNMZdHWwgmHy5O77XD5ra1J3oYTvuKB/Jqf
         pcriQnIarqMmqKpVKpJwmtONc3dVmE3lMsCvs0AzSqoLZToWYKY/aT4n+MwAUUVy3VWh
         fuRbO9jPLCIGKVqhWi2Bde4YCjVH+1xNoXRNb89CvcJpRthoFjhzcgYWmpeDRDZgX1QM
         uwFVHF5jMcKAOjNRu+srT1ScMpAk3lrnPnLbBSpK9hOdhhda2EKyz7wqH7PoQc/kgPEo
         U6IQ==
X-Gm-Message-State: AOAM5318Rv/04oSo4Y8FPYKxmLl9Bo98xGAg8yx0oaOfRznY65HqLcCP
        TE5nVzrvDOvzU3mMoEbgyNm0Ie7iZCqYGPQKJy43nQ==
X-Google-Smtp-Source: ABdhPJwplrH/h4uJ902U6lQCybbS4z5DM0zNOAijb05Miq8byRKi+/AfAW+yQX+JrrQBAS0KPQmwRgi1fkq6f6vT5s0=
X-Received: by 2002:a17:906:5343:: with SMTP id j3mr48564278ejo.538.1636975429136;
 Mon, 15 Nov 2021 03:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20211109161253.2202108-1-robh@kernel.org>
In-Reply-To: <20211109161253.2202108-1-robh@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 Nov 2021 12:23:38 +0100
Message-ID: <CAMRc=Mdv8-=WsizZ1W8p8+kLKh2QLfgfxSOQ0L=0rBDvO63HpQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: xlp: Remove Netlogic XLP variants
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:12 PM Rob Herring <robh@kernel.org> wrote:
>
> Netlogic XLP was removed in commit 95b8a5e0111a ("MIPS: Remove NETLOGIC
> support"). With those gone, the single platform left to support is
> Cavium ThunderX2. Remove all the Netlogic variants and DT support.
>
> For simplicity, the existing kconfig name is retained.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpio/Kconfig    |  10 ++-
>  drivers/gpio/gpio-xlp.c | 142 +++-------------------------------------
>  2 files changed, 13 insertions(+), 139 deletions(-)
>

Applied, thanks!

Bart
