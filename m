Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2D44B3BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhKIUKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbhKIUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:10:42 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909A3C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:07:56 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso404192otv.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jay4bvn1CHVbECfZlQ8rRUGomUTSbkN+CtKVdn6fLuw=;
        b=UjmZ16XdSJmMTk1B1Q+5+jygX0AQnxVwiZ8nHytzix8JWJdKkHA1DfCyxpMIn+LvEH
         8oizt36qlO9lPjxYa3z2hdYSazQstIsTha8sWrMq1ruzMdEPbGL3u5PuxcO4nDQuLaUq
         pyPzmwEP8ypf51mZzOYgHlTUGmWAcNvmbj4GcHgW1Le9W2SMDQpIoZkZurFoTaWpkMxJ
         KQz5SeJ7AjGA+PDdbqbJvFDXxQh0CLR4VQuTMWpxCcQ3rpPXPUIZctwdhI5NK9/3E07a
         B+zKCrYOIohAOeNfqN7g2oTnYVPNaqsaqUv23gFcCRUKzyRNzVLCPBqc2W48WHrcvU7O
         WOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jay4bvn1CHVbECfZlQ8rRUGomUTSbkN+CtKVdn6fLuw=;
        b=KAbQSWWUPKWa+eZrH9/trGlFAx5g19uRsT+erIFkfcMe1/ZgWtRIpCXWiqp2QMjNaw
         My5YL3vnwxdcnRDtJ+H0h4JugFje2GUIEFPjey5TuZydNZqxQocM/OF+MMAYaqHf8Im0
         /W2eXOZtuJ6FbpebwY9L/UV2zkzgM5y7lZpqWjZtCHtEmZutzJ4HV5zQko+0auZ/Xi/Q
         pyeV6Fer4w3TgU+V3PE8Mt6kd9IjxZuP408D4Vh8mNoBRdqTkBRoefsrCID3Z3zTgAch
         vFAGWOkNc0hp+uhMHOIvCnl8tS8pUnm7zMzoUEDkTyhFH3EDXbrZRAAbzgQ0I+mv3Jv0
         Cz2Q==
X-Gm-Message-State: AOAM532jg7pA3XXNLOl8X7mKmM8ZjgmDHzZdo7mze03QIfHY1fBDeM+K
        psspXZTs16K/dbVgtoosQjH4KFrSld09Yx17xyEiCKYkJdc=
X-Google-Smtp-Source: ABdhPJxNipPZr7+vmyXXCN9McHMGmga6b23qum9RT+SVZQNWx6aLiAtMH8PkORDzg0FIgBHPXVE6XphIIe1qjYrStiM=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr8389289otk.179.1636488475884;
 Tue, 09 Nov 2021 12:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20211105130338.241100-1-arnd@kernel.org> <20211105130338.241100-3-arnd@kernel.org>
In-Reply-To: <20211105130338.241100-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 21:07:44 +0100
Message-ID: <CACRpkdYdrm_YnwvxjqLBrJfOF07_nDyu1g0xggRMJ9_x2S+LJA@mail.gmail.com>
Subject: Re: [RFC 3/3] gpiolib: coldfire: remove custom asm/gpio.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        gerg@linux-m68k.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        dalias@libc.org, ysato@users.sourceforge.jp,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 2:05 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Now that coldfire is the only user of a custom asm/gpio.h, it seems
> better to remove this as well, and have the same interface everywhere.
>
> For the gpio_get_value()/gpio_set_value()/gpio_to_irq(), gpio_cansleep()
> functions, the custom version is only a micro-optimization to inline the
> function for constant GPIO numbers. However, in the coldfire defconfigs,
> I was unable to find a single instance where this micro-optimization
> was even used, so to my best knowledge removing this has no downsides.
>
> The custom gpio_request_one() function is even less useful, as it is
> guarded by an #ifdef that is never true.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
