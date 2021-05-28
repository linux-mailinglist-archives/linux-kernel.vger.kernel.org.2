Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3E394436
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhE1Od1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhE1Od0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:33:26 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B99C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:31:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e10so5772492ybb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjefxB6K3pXyZRFBVuZ/s9GA0VXxwXxIMVMfs8uEQuE=;
        b=E5Itrw7sUfstT4XabpvlXTK+918yIoWEcnA/kt4W/xq+8610J7DjzDBEBKjYtuKR5g
         AFfqcXHRP9rI2sX4vVLkfftkFmncszZkr9cmDxLCJ/wFmtQYKv9Y5+yUXzjxHmerxN7a
         q0Tqc3e5BdCxyMNMJJlLM8ojX8Z6PBLtnFkEBOrGjRgvpJS2OJJ/qSSgFpWasyJXLAYp
         wGLTs5n6kVxLYSh6VjQjhfUFU1rT5ke9WCcvekweL0ZGfUKVcYmLDg8xafg07l6/LVXy
         blXJRsPXTNTYl9dSZjkpN1y8LyD6ziep6ePI/4Pu55EqU8zvCt7fc4LQazz7tkrmg5n7
         FhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjefxB6K3pXyZRFBVuZ/s9GA0VXxwXxIMVMfs8uEQuE=;
        b=IpD3cuBKWjpDFIafUxzIXcgoy0rXAtP3ZoU/hZnFpj3GV8fj89yO2WGDJazaIb5vgE
         gAWfqkcSe+q69pETpT8Ft+RKxnVoSX86Kk0fm6jWEPby9+/ISd7FZ7lG9jTWf9TS4GWX
         0wYKBJmP8zSI9z6pS3TTs/msBnXHV7HsBv4Z7FZqMcMU6NoASTrAEWMXP7yluzJdFWOv
         N+H/33PIZkFya4qqlxUpHa73txcc62AbXwQ4hN9pCIBgFGlBeehBm7LV5/OMDnBmLiJS
         8Eg0Pys3DDBAdluE9ETOBgDjTI02lEg4dH0UyQWROgupL0vIGy8U6J6swTS2Uh48Tgsh
         nZZA==
X-Gm-Message-State: AOAM5324pU32QC10wMlYJujozp7uSuELmSgfGhH7lVtpZwdvYj8H4dVO
        z4Q00n3+yVcsPaZ1xQTxUoK3j/qj1mNfBjtGaWuNkg==
X-Google-Smtp-Source: ABdhPJz4Xl6mqInmSc9JBcDMcCFvEvkpEskAwSgLA6HaE1rL/9lfRZ3yHG8pE1VEX4fLSM0b1Tvt+4nXV05OC7afXsI=
X-Received: by 2002:a25:287:: with SMTP id 129mr12603370ybc.312.1622212310080;
 Fri, 28 May 2021 07:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622008846.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdaSr_CV1pKS44Ru15AEJ0-1429+6E7Lei2sPHdaijr9iw@mail.gmail.com>
 <0c2a8ffab666ef31f5cee50b8b47767285dfe829.camel@fi.rohmeurope.com>
 <CACRpkdZ2GdrGr8-XnVvf59O4AVBueBjX0PHYGtOeOdGXi=iE4A@mail.gmail.com> <15d9e565021c115eec268c7fca810799eb503a90.camel@fi.rohmeurope.com>
In-Reply-To: <15d9e565021c115eec268c7fca810799eb503a90.camel@fi.rohmeurope.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 28 May 2021 16:31:39 +0200
Message-ID: <CAMpxmJVJAX8jPrYg3=jkG4JqEEnUfpexfn+cFKWJQYpdRJaRUA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] gpio: gpio-regmap: Support few custom operations
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 8:33 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>

[snip]

> >
> > What makes things easy for me to maintain is active and happy
> > driver maintainers, so it is paramount that the file looks to Michael
> > like something he wants to keep maintaining. This removes work
> > from me and Bartosz.
>
> I agree. When someone takes care of a driver, he should be happy with
> it. Period. And thanks to Michael for writing this driver and reviewing
> the patches. Reviewing is hard work.
>
> On the other hand, I don't enjoy writing code I am unhappy with either.
> And as this particular piece of code is not a paid task for me, I do
> this for fun. gpio-regmap is not mandatory for my drivers now. So, I'll
> just opt-out from this change. I'll happily use the gpio-regmap where
> it fits, when it fits.
>

I take it that path 2/3 is still good to go?

Bart

[snip]
