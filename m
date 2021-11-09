Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E331444AA5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbhKIJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhKIJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:16:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C36C061766;
        Tue,  9 Nov 2021 01:13:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j21so73717680edt.11;
        Tue, 09 Nov 2021 01:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fvpt7bkP+uxAmgEvC006y7WNF/VjJWaX7lBZ4rVieU=;
        b=l07gsYTHDpcXom+Mpz+0McxPAljXjZ+IuiwP2OKDg5gkCPo95DDtQXoAJ0g7KwDEFM
         +edW6xxEv8NLF3jZ/ZNYIDOln6HSWQDw6wPwZh/vlSkpL7gAO3m41kWdPqCu9AeEW6AP
         AxdbOCepi9Fjzeft7Mr8UaAaRXhsUvIEG2fn1KPyK5AIB3pa03srUPmxcxspysYh7WSy
         QU+Zgc4Kbnqtaij1YeI2Ov6XfUfosihc4CrP7bqJVwqMaCWPP4OIKEzy52JuYMJOHZjn
         93tkn8JPK9h6AIH2tOoqg83l8GEB0bVZhDjjZl8YIQ6+5B5tbaeyq+CgBBv+Fk0zG1Ae
         SbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fvpt7bkP+uxAmgEvC006y7WNF/VjJWaX7lBZ4rVieU=;
        b=e5uEpV6JU7ZYs4M5bej608IFxADhu3UxDSVV06k9i1G8dMLtx94kG7UzsOfqHm6ljn
         bqrzm/6+fDp+ZoZ4JrIHwRpVfViTai8+jsEQPhA2vEh90+HK62kwFpeVTBz3WVygdQBl
         1Scx/H6ndFxrVKpU6tJA0gdYtW1Ywo4fL6Ig/3R+PhkkiJ9mZq0KBB2tY+POcbT3Tf0L
         d1oN9fDOME7/28Z8E/nW5B0jP8qJCu7L3D1Su86nh23cOOVn9j+mumaSEQS7qgoGN9ky
         dGtbgXnbqH6tc3nQDnox9sL4FX2TMB7Zc/jEoJCj6tPOZuDpcOiC+RGwulWK+BtQgxke
         hKPA==
X-Gm-Message-State: AOAM531Nb01rTickS9Dc2DGMqF5pScE3c9uxV4mXfAp30cGdN0DGG3h/
        pwyrh0J4oKpw1guBVUOgCepZ3Eyu2CLbEFUVEoY=
X-Google-Smtp-Source: ABdhPJy2NG9TqRFnNV3SUetYoAPoeDCVudyp7SZz0z8KaYicVA4Fj0EI+TiAbUWUYAQGjbpPquMr3e13w0rq5hje9lI=
X-Received: by 2002:a05:6402:207c:: with SMTP id bd28mr8154843edb.240.1636449199301;
 Tue, 09 Nov 2021 01:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20211109081125.41410-1-nakato@nakato.io> <20211109081125.41410-2-nakato@nakato.io>
In-Reply-To: <20211109081125.41410-2-nakato@nakato.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Nov 2021 11:12:34 +0200
Message-ID: <CAHp75Vcw-ARNZCRRJGzbQ7xc3ZB=98eFCuEFc4cj5W3vAj5EZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/surface: surfacepro3_button: don't load on
 amd variant
To:     Sachi King <nakato@nakato.io>
Cc:     Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 10:11 AM Sachi King <nakato@nakato.io> wrote:
>
> The AMD variant of the Surface Laptop report 0 for their OEM platform
> revision.  The Surface devices that require the surfacepro3_button
> driver do not have the _DSM that gets the OEM platform revision.  If the
> method does not exist, load surfacepro3_button.

...

>   * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
>   * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
> - * device by checking for the _DSM method and OEM Platform Revision.
> + * device by checking for the _DSM method and OEM Platform Revision DSM
> + * function.

Not sure what this change means (not a native speaker).

...

> -       dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);

I think this is useful to have.

What about leaving it as is for debugging purposes and just replacing
the last test?

...

> +       // make sure that OEM platform revision DSM call does not exist

Please, fix the comment style while at it.

-- 
With Best Regards,
Andy Shevchenko
