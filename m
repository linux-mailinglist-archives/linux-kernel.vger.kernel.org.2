Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD345577A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbhKRI7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbhKRI6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:58:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7ECC061226
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:55:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w29so10012936wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dSP+w0ULKXB14fx0Qg6uZmQEgEDOZqwyyo7QWe1WeRA=;
        b=ydGmwL4bJDWdRowxUjZt8fkHicYan+sgcnHB3CDDWdrWIZ8SfGCvjnttvQl6Av5vlr
         s6PrLg6WG4iAClWRg4ABvIUY5CoPtZ1J8dPHr9UUowjjMD4oV4y3F/fStxNQWSI7JIhu
         Wl17LV+jYNskvi1g3OB4pI+WRDya+Ni66dYqqj1oORgx93UMAo4F6oQHfWVjY0kjzNOF
         b0a/2g4B9e0VFYvtAFTw52qfI+9oxP11ske5S/1xGpCj0YjTW5PflN3gXSTlO9I4Lhdl
         o5dbw2PJfgAiIgVp0fOOzgRhSj1XSewWVex+fR/7KOeHmaWcgDV5BBO2HSumFII0Xmav
         S53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dSP+w0ULKXB14fx0Qg6uZmQEgEDOZqwyyo7QWe1WeRA=;
        b=2hlkgk4QPXKh4dq8aqZICaxZvCBI3F5UEccpqn0aOkogaSWmcdI4d4wxyY1pZAVche
         K21NBeC7noitNmtgTlfzh7E9T8vAfH3fdwOIbM8nuu+nKSnNPcnQt83y58Lgkp4hFuI3
         wdPZ0WJhe9+XzYtQ/mBA8/m+/gZBpT8rXORzcVCkZvkd06SR+Ug6wHD38Fs05/sxKOVn
         nmOsChWEX8iJeGRB1U9sbEqHfzTAN+t4da8oH1J4qaeO/TZN9ZUkUZdMPww8JVSRrCEE
         d7eOpwIHpLNOfq3ZnHEkAItlBR80IZ+SPvjeqJr5Bdz7uxQAGHy7jIkEWkD4RfhlTLW2
         AovQ==
X-Gm-Message-State: AOAM530njzvQUYTtcsoda2Pz2y3bkVo7htXGCfNjeqEFDZxJM9G/xYQ1
        RXAMSYNmf82hPFqQQQmAHAp/IA==
X-Google-Smtp-Source: ABdhPJxCrYvy/KHbOLzaUjVIo3pWbsYkJIUI9dO/1fGCACLzErizkkHVQ37qGCEiCScVrzOKly2AKQ==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr30566144wrd.33.1637225717048;
        Thu, 18 Nov 2021 00:55:17 -0800 (PST)
Received: from google.com ([95.148.6.231])
        by smtp.gmail.com with ESMTPSA id n129sm2279008wmn.36.2021.11.18.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 00:55:16 -0800 (PST)
Date:   Thu, 18 Nov 2021 08:55:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>
Subject: Re: [PATCH RESEND 0/4] Drop ROHM BD70528 support
Message-ID: <YZYU8hzZyzcPHCTT@google.com>
References: <cover.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
 <CAHp75Ve_qS0Qc8XLHLwFnWEPzQtgNfEeVr8q9L4gK2m5a-By0A@mail.gmail.com>
 <50c260a1-c6d0-1a0b-45da-ab1a2d1379c3@gmail.com>
 <CAMRc=Mc-+ZR1PR9p=cXkfMWdKn1d1VCxmhBknSzNaDjepfpV-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc-+ZR1PR9p=cXkfMWdKn1d1VCxmhBknSzNaDjepfpV-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021, Bartosz Golaszewski wrote:

> On Tue, Nov 16, 2021 at 7:41 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> >
> > On 11/16/21 18:10, Andy Shevchenko wrote:
> > > On Tue, Nov 16, 2021 at 2:52 PM Matti Vaittinen
> > > <matti.vaittinen@fi.rohmeurope.com> wrote:
> > >>
> > >> Drop ROHM BD70528 support
> > >>
> > >> Unfortunately there has not been a big demand for ROHM BD70528
> > >> IC. The few users I know control PMIC from separate M4-core,
> > >> which is not running Linux. I am not aware of any users of this
> > >> Linux driver.
> > >>
> > >> While I did really like this IC and writing the drivers for it,
> > >> seems like these drivers are becoming useless burden. So, I see
> > >> no point in maintaining them. Let's just drop the drivers if
> > >> there is no objections to this series. :(
> > >>
> > >> The regulator, WDG and power-supply drivers were already dropped.
> > >>
> > >> The RTC and clk drivers remain in use by few other ROHM IC drivers.
> > >> Nevertheless, they are already converted to not depend the BD70528
> > >> defines during previous cycle.
> > >>
> > >> This series cleans the remaining pieces, GPIO, MFD, dt-bindings and
> > >> MAINTAINER entries. The GPIO code uses defines from MFD - but the GPIO
> > >> part is also depending on MFD KConfig entry - so there should be no
> > >> breakages even if the patches were applied to respective subsystem trees
> > >> and were not carried via single tree.
> > >
> > > FWIW, no objections from me.
> >
> > Thanks Andy!
> >
> > I see acks from Andu, Bartosz, Lee and Rob. It'd be nice to see ack from
> > Linus W too - but other than that - I guess this is good to go. Any
> > preferences regarding the tree(s) that could carry the patches? All via
> > MFD or each patch merged to the subsystem it fits the best?
> >
> > Best Regards
> >         Matti Vaittinen
> 
> Normally Lee takes MFD patches together with those touching relevant subsystems.

Yep, it's on the list.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
