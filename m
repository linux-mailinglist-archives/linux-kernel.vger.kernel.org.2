Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95E401E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbhIFQ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbhIFQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:28:34 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E37C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:27:29 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id s15so5986246vst.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v7i8HiyO/1Ym8mqrztY8OP2nXDvUjYMU9SPvvdR5iI=;
        b=KeHclL15otyM8f+dOzQIGQr7RAW+HW31nUm+fsJMd5ukKGOzcIIoebv4l1rxxXdtow
         2fLv4nH55dwxD6gWWBmA140rbu234m3x5wf0LDpPh4sAK0NohP5zfd6vUKchNaYgOGiA
         HL7C76TFHjncsA/UknFYGkUCsGfGwNvcBjRl5b9pqn7T8e3GeSmQeE2JviKh+hTXPiH8
         W3BLdUlb6j6hZMp6lyDcAHGq2rNF5/ZzxpvNboC+KUURUxc2GOwJ+tpmmR73RePzER5F
         xgX63er1eENm88yda0CY34Qf6EDq5VLW6gBxZ6qPPjiD1bt3kIioC5S7Sq5kOXmX7nKi
         JUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v7i8HiyO/1Ym8mqrztY8OP2nXDvUjYMU9SPvvdR5iI=;
        b=iE2k2PBnPJdj2eMkRZikzA5B/IknTJNOZEHWZUnO49DMOAlDUrR0h/QKpromZIq1T9
         j5bxm+OlaYK1WqYONG92S0aGLyeHK+1wAey6u5UKmFbtmyBhiQ9oGZqq3D4Cc3Z94Mld
         9Tl0QLlY24YfJGTP2a1OYHgD0ch6FF6awTNlo3UvfMzOKMxBWNwhUn0v1aC/59C/p2ZN
         77KJroWyGouHzO2RessITBtYwi22Nsm+GwaZiJcL7GBCiI28DeH9+E94HswCpbXUXq5t
         rQama9MX2oT1jsX6/io2n7mjIT24/AUKM51VDXmGcq6m3s14apf/MFJcsXoVJqcoPGxY
         2zWQ==
X-Gm-Message-State: AOAM533do0nMcZNgamPiiExuMd5D4iw+C9uRRaq8wLVG4rKWWrENvvYQ
        ORRwVnvb9VuNt8jqq5AliOYMo4o6ue5nqKAy8A+iaA==
X-Google-Smtp-Source: ABdhPJx42jYyWvN/Qn4VgmviI0/F3R5RsPLT5EvzkWi6iwNer+i/tY/TKP2zG7TW4SPXjMUt+ScleFoLjPAzV0zGCcs=
X-Received: by 2002:a67:d387:: with SMTP id b7mr6860162vsj.55.1630945648771;
 Mon, 06 Sep 2021 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210811114827.27322-1-semen.protsenko@linaro.org>
 <20210811114827.27322-4-semen.protsenko@linaro.org> <YRwodjUxlZmvrvSC@robh.at.kernel.org>
In-Reply-To: <YRwodjUxlZmvrvSC@robh.at.kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 6 Sep 2021 19:27:17 +0300
Message-ID: <CAPLW+4kvty3PQmSki8eM+WSgcA+zFfyD+--e6KBpird0-gOhMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: serial: samsung: Add Exynos850 doc
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Gall <tom.gall@linaro.org>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 at 00:22, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 11 Aug 2021 14:48:23 +0300, Sam Protsenko wrote:
> > Add compatible string for Exynos850 SoC.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v3:
> >   - None
> >
> > Changes in v2:
> >   - None
> >
> >  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Hi guys,

Can we please merge this one? I can see that corresponding driver
changes were pulled in already into malinline, but this one seems to
be missed.

Thanks!
