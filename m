Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247F140ECEE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhIPVxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIPVxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:53:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C46C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:52:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t10so18516920lfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRQoD6iZCn55Ja8F2Gn3cNarwgkK5+FsGdC92UFZD70=;
        b=eFGCxqeKd62Vy24KV//A6w7k7Nu7tPBzDq2PNTdL+T+OyMy0V2sQGIJdTgZvKOs2qe
         qyhUuDoy5QTFuubpZIPoiPMw98pWQUO14ZoVheus+4o5Fg/oVxfJrNmyf5eeT5TTd/H0
         V0hUXs0V6Xi5nYmult1ktJSWrvhn+c3o5aTDYZWSBdOd6yHRCbOgk1IMzNHuxe3ZAS6P
         Fvpt/06NuwZfdymMN8ultVfvktkqbssYuuMMNPYop7E+friZHcMgO2jhPEITq1dLlW5k
         8sehK7C5icHKoXuWAD2yq6SBZRLRRj88cuuzr8if4wQceky8k23cLQrH6DKdc321KkAM
         6ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRQoD6iZCn55Ja8F2Gn3cNarwgkK5+FsGdC92UFZD70=;
        b=B1tusQQNrOmcz0ALDXyg7DyD3FjhA0EZ4eU1i9gLWrdfT8NC2rA5KctWz0aIA6bcsV
         ks+4Vv2ZTJRGzIgwdVFwuftqSlQgC/IlGW4vW9pe64wgu4R0EgPqP9cCLZXKOkg9nIgy
         i/tmWybXmHNpq7xNsppEIJ7PdgFcUn84KpHysNqPLQ6491vGg9WNYwSe3ID4eS0puInO
         HHVLYo/shq5ogZkJuNC/HUoR6Cv/KxCfi8GHYlSv5YiYul/1Cy8FlAg4iiKX8xIA7ua+
         0Gs8vale5YPBAGP583y5q35kxvLc95w8qxkKAt85alp0TdMAD5F++Q0H1bT2I7Kze9Jz
         zuGQ==
X-Gm-Message-State: AOAM533PQAWsLdOFaXSUJ4Q1mCCVYJPaSjoeva8pdyLunuIezMPyhjoL
        Q/2y9jDvI9iA5pQBqyduA0rxI+eQ+CQUvpKmW3Ok/g==
X-Google-Smtp-Source: ABdhPJwg4R+gQoXcEfuVVtF22UR6eCaZATGlUqS1qzPkBlvz0xuK7xwfdHsD5LBTEn80MbmBWCaYTn91/IWi8bBNA18=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr6494178ljo.288.1631829149435;
 Thu, 16 Sep 2021 14:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com> <20210824164801.28896-11-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210824164801.28896-11-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Sep 2021 23:52:18 +0200
Message-ID: <CACRpkda5Y-Dxb4SkwyUcqKwsTd_c9Emgt0Z6OME5pQYz-WiC_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/20] tools: gpio: Add GPIO output generation user application
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Dipen Patel <dipenp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:

> From: Christopher Hall <christopher.s.hall@intel.com>
>
> Add GPIO user application - gpio_event_gen - to generate output using
> output methods added to GPIO lib. The output produced is 1 Hz clock
> aligned to the system clock using singly scheduled edges.
>
> gpio_event_gen accepts similar arguments to gpio-event-mon.
>
> Example output:
>         $ gpio-event-gen -n gpiochip0 -o 0 -c 3
>         Generating events on line 0 on gpiochip1
>         clock realtime : 1612453529996832765
>         GPIO EVENT TRIGGER: 1612453531000000000
>         clock realtime 2 2 : 1612453531500000000
>         GPIO EVENT TRIGGER: 1612453531500000000
>         clock realtime 2 2 : 1612453532000000000
>         GPIO EVENT TRIGGER: 1612453532000000000
>         clock realtime 2 2 : 1612453532500000000
>
> Produces 3 events of 1 Hz output on line 0 of chip/device 0.
>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> Co-developed-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>

To me this looks as very similar to what the PWM subsystem
is doing, just with a restricted number of periods.
Especially with that command line example.

Yours,
Linus Walleij
