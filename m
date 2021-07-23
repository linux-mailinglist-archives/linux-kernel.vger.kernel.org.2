Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130333D38E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhGWJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhGWJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:58:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:38:49 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so1258227lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HS+KrbKWpPg6959vVc+gifN5TSsSydBGp7pXF+iv/30=;
        b=r7GcSBDAig/jsK+TLYxnlKfMPCesIsg38LoZQ/cBD/7LvqMsrhj+tZe3Qw6svxGLOw
         Wt3NwG3HAiFV0qp/87JXs52adhE4XdaYITwmey+cnGK4kcL0eiMES5ltYd+dRcVN5SQE
         FTKr6IVugqJhwmMiwnYeJIkkJftbjQUB5iqmcxkFZkSuKq3UN6oVZyOBx5xFpP/p4SPh
         5HQQMgtnaWTLWI2AK62Wzd1Q47J5FtjnItdrPqw4Hqyh55pz3nQ4ey2soMMEdxq0jkWt
         3GteKPHdXTdgRcg2OS/y/X1B4N1/ydkgPjG3IVWfuHJSKlGgZugZ/CPDE2fpcZ0swCK2
         8tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HS+KrbKWpPg6959vVc+gifN5TSsSydBGp7pXF+iv/30=;
        b=CDFIt1H5nhSBQYOsol7Kfp/XgcoZxlY7jLfQHP40wWGhQBQTJSKJ4ZIC3rVV4aGpDR
         ztr8xvD2H+Kir9RgjDcQvozyMgYKpUtzZYKynSSpGUSXIb15MxI4iJ4cPhNYXE12WpbI
         YW7bF4ZZ12LSEq3ZFZZXs6D4X0KHt73aLe4euQnFJNpOyl7+CeZTzA3KLO5NS8jDkyUE
         msOwPKnFkH5qXdoPJQL6QskA4TvH2sgmHW06siGz8gpHJ3NEa1imOo5ia3cUAHbXWaYQ
         DfOjXIk2l+bDVpFl7N677++6jvJgwHpEscg5AURe5T+GiUKEXgHKcTZZO8izTmILNkma
         RyTA==
X-Gm-Message-State: AOAM530MEYXoNchwBnHxldC+yL/vunpbBau5+XF/RWJAjeNzaJ/nvbW0
        Ob4cn7DSgo3wJmM0HNVcQoKLc2dAIeHqzrULHzbE0w==
X-Google-Smtp-Source: ABdhPJxxCneK7uZOaNmZ8Jex91S2cTh3oIpLs58Y0lNCNcMJLcBcz7Xikn7o1GTvucpbIkZVQYf5jYjUbdCC4MQJNYI=
X-Received: by 2002:a05:6512:3696:: with SMTP id d22mr2724599lfs.586.1627036728197;
 Fri, 23 Jul 2021 03:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210618205533.1527384-1-clabbe@baylibre.com> <20210618205533.1527384-6-clabbe@baylibre.com>
 <20210712201125.GA2401230@robh.at.kernel.org>
In-Reply-To: <20210712201125.GA2401230@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 12:38:36 +0200
Message-ID: <CACRpkdb_jpK77w5O-SW1PcDU-SYyrXCFaMgDhMaKa1MiL5HOEA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: gemini: add device tree for ssi1328
To:     Rob Herring <robh@kernel.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob,

I fixed some issues while applying.

On Mon, Jul 12, 2021 at 10:11 PM Rob Herring <robh@kernel.org> wrote:

> > +     model = "SSI 1328";
> > +     compatible = "ssi,1328", "cortina,gemini";
>
> Where's ssi,1328 documented?

I'll take a sweep and add all of the new machines.

> > +     chosen {
> > +             bootargs = "console=ttyS0,19200n8 initrd=0x900000,9M";
> > +             stdout-path = &uart0;
>
> Don't need both 'console' and stdout-path. (console should be removed)

How does one specify a default baudrate using that method?

Yours,
Linus Walleij
