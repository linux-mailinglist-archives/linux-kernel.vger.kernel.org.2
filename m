Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654A13B4B64
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFYX4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFYX4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:56:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BFC061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:54:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j2so19061122lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b02+MQS+K/2ylHUHsg/KpB4uE2GVIVGma+PmBOheS/A=;
        b=AVEmQBfjU5ZUxZePdyPtiXWRVilsLPxAJLayjfsbdbyHz1DblFJ6Tp7ohyXY2u2Zp8
         emfZJh3lE0JPvmZMYL28V2WTt7j2o7kf7epNP3DSCShbqipZkEqNclXkAH+U3u9wbhYb
         bclJ+QFiNecqz/QGkVLl5d9hKW2vJrxIwI84AXKLlAcSwzIkYInvfKXpUxkb3eVtKmk5
         eeTaSJOktEHW++XRcj/dFJn/t6EIqeLC5gFruDRXVTLUP6cz2PvtTzzcZQQce7nHAzqV
         7XCG5kajX/woXMj1jvn74ztVk3tSQXF+lWIENbI5Y2Ue4jeULe6jdhzOmeIJEYRC7fCP
         ZjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b02+MQS+K/2ylHUHsg/KpB4uE2GVIVGma+PmBOheS/A=;
        b=icl7XbheexB9RanNafPDGCrsMsU7n3C30cusDQLoHibXigpkb4iIDYwoq6WtLHJ4CO
         mUOFa+RUU9yCxs7V/vXzeU1RTwsRzFVIm2Ei6ak2Co5JLv0r/BRFc7ZIGVNIFpvcKfv6
         Z2HYTwpZz1ZRDLtJQH0NKYEN0OnxJaFGzDIGMGSBWsPfYDtSwoxYtVds8895CLSYABsd
         OmmxH8yONRdeDxzETYTHnks9oYEOhE+YO+FUOmBqtNERDBm52uitnA1q5z+0SmMrhZ3g
         saPesWqhg3Xlq+yDPkKu/Eia5I2LcQ3/aodIPKip7Cm73fcDG/eQNc1w1r4rsFKTIizD
         3+cg==
X-Gm-Message-State: AOAM530znWHEKqywqUzRgzFgv+qNpvHEfMVX+CGcfMHnqbE918BdJPsC
        NuUPW6nUt+dKnC/QMn6V5MPtTgdCBRJukeegHsIyPA==
X-Google-Smtp-Source: ABdhPJyHtENVDOxhMvPBYXGHJTHQZYmleVXRR6DQgQo2NmaMqGvMXTEd23T6XvjSTCwCc1CSM77tuw4mj6tKVJ+GKtk=
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr7698391lfk.291.1624665239810;
 Fri, 25 Jun 2021 16:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210617144602.2557619-1-fabien.dessenne@foss.st.com>
In-Reply-To: <20210617144602.2557619-1-fabien.dessenne@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jun 2021 01:53:48 +0200
Message-ID: <CACRpkdYOk8TgrQbEOMb-ZgZ8a6ZOYPgkfyWDr-Li6w0mfFO7KQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: check for IRQ MUX validity during alloc()
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 4:46 PM Fabien Dessenne
<fabien.dessenne@foss.st.com> wrote:

> Considering the following irq_domain_ops call chain:
> - .alloc() is called when a clients calls platform_get_irq() or
>   gpiod_to_irq()
> - .activate() is called next, when the clients calls
>   request_threaded_irq()
> Check for the IRQ MUX conflict during the first stage (alloc instead of
> activate). This avoids to provide the client with an IRQ that can't be
> used.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Patch applied!

Yours,
Linus Walleij
