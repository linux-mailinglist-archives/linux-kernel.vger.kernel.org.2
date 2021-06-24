Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3233B329D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhFXPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:34:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C95C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:32:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d16so10981155lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04JLKQO/fFyUkOGcPqBL7gujdp8kkZAbX0MtPTll5vk=;
        b=JArqNkSlZaSXwPoifYE4gZ1v0dG7zlhwLa8GNdYgG+9JRwcLa1pU5tNBwDuwJmzQWt
         D9u5zRUOEIPiVOX640qgnHBqK+HGjwyX44j3FIceBSs4RuYZ+JIwjdhlyxBfTbqFXjmX
         mGDOmzAQUXO8Q4IPRfejKbSV4RYj3lZkLY9nxn9BdwYwAC5Y4A/XPZGL/Gt4vaOBsBtq
         EBQbsz76PUgzhqjQ2VcfwHHjcaS4nv3kN8OQDUcdbVW4ItIjpAuqkLuDOgu4IRp7R9wY
         dP63H3Y4ug8hi+z/mP0t/OzKfXenKK0Kqx00dJkzTgY7KylvnMTKTUh00JQOV6KzRyz+
         TFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04JLKQO/fFyUkOGcPqBL7gujdp8kkZAbX0MtPTll5vk=;
        b=Zwz22ZpSRcXSA2BoHzrC4/r7WwpIKwekI1yzx45ikYyO75WkymfQ3o7CKJRE2KKgJ6
         2tIEjxLlhmPT8wFOWAxUMzHW6NxSHT8SoYB2ONDaOTmkwCMZTHZqWsUY8L3BDMONBIdl
         lULReDhRDiiWZrQwiKO6DuWVQgfO2TSs4d3PM7N9Y6XhodLiDeE2HsVRYLgmF2vMcnHA
         TmHb+WaDl7A3xUPQIql1s79iOj5MeZczss0qDFzO9LV5yPSb8oT6WBZHmVJ1r5/+jhL/
         NdW0e1D5BM3GDYmEMZtiU/C9uBNQWjczdMgDvp3em6NsYfhxbZUVJmTVlsaRaPK/AvpA
         iYvQ==
X-Gm-Message-State: AOAM532zmqFs2SdSlK2teMDFAAXWnUmQdrRNmFgEgpQTYwofMnZqUZOD
        ROWBc0zkhnbutecJpIxYEhxBV3gLPPbVA7l0klDgaw==
X-Google-Smtp-Source: ABdhPJxs7rnOO/BgTWo9qd7jVgTTntGtpEBOuLOjuElmlZzwGEGI4e1z1SM7AgDZqF2e7uG2v5GyqhsTn1JVO9E0HUg=
X-Received: by 2002:a19:6e44:: with SMTP id q4mr4362200lfk.586.1624548735768;
 Thu, 24 Jun 2021 08:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210502014146.85642-1-caleb@connolly.tech> <20210502014146.85642-3-caleb@connolly.tech>
In-Reply-To: <20210502014146.85642-3-caleb@connolly.tech>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Jun 2021 17:32:04 +0200
Message-ID: <CACRpkdb8tduLtQAmQWT3L3cwi470kuvhHKnzNs4VqGOCbWAxbA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm: panel: sofef00: remove reset GPIO handling
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        phone-devel@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 2, 2021 at 3:43 AM Caleb Connolly <caleb@connolly.tech> wrote:

> Resetting the panel on fajita causes it to never come back, we aren't
> quite sure why this is so for now lets remove reset handling as it is
> effectively broken. It is also not needed on enchilada.

Where are the device trees for these platforms?

Are there schematics so we/someone with access to the schematics
can figure it out?

It's not something trivial like forgotten to put GPIO_ACTIVE_LOW
on the gpio phandle?

> -static void sofef00_panel_reset(struct sofef00_panel *ctx)
> -{
> -       gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> -       usleep_range(5000, 6000);
> -       gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> -       usleep_range(2000, 3000);
> -       gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> -       usleep_range(12000, 13000);
> -}

This code looks a bit weird to begin with, I don't see the point
with the first setting the gpiod low, either it was low already or
high already neither matters, driving it asserted will assert it
either way.

No big deal though.

> -       ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

As Bjorn says: just use *_optional and comment the line out in the
device tree if there is a problem.

Yours,
Linus Walleij
