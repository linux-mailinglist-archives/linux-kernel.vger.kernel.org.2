Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81573DB5B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhG3JN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhG3JNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:13:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A6C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:13:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g13so16504941lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgTIDw70Niyned/UivIxn0PZ0VEJvs1sW/WkqiL8H8M=;
        b=bF7NUYLwxdeJtaWOqQR2Z4vA+K5YtMt18gwe6FpidDFvJRq4nU2iZ+QWisCiAL915D
         K0wT4IljFnFmW0IuNHLPCPqMYBFpeY16F+EsxWIFaIla1AWXnKzPm2S229qUxEEaM6MC
         uq6x9eSzQrQY8mOlgKvMx7Uv3tNCloV3aIN2AatipDT8yfLSsnkGFCel+fObhiqBQfqh
         acDmgK5C2Yi7+TRjVlLGKWpIQsSktcA1l+xP8Xt8CCTcMXWu8SEVOwZ63GxlC0YQXod5
         RZHlB/YtEhh35KMljbhnvLnyd0JKys0+Akho3cAAHMWeiO59MxIlvgXYFY/ReSR9NwES
         Dydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgTIDw70Niyned/UivIxn0PZ0VEJvs1sW/WkqiL8H8M=;
        b=OFekZPqC/neFiVErDqlx9Q5XGIiACs7bjFyWzffyVaVLNqzGUVMjG4OuNFbA+43+Aj
         74cgV9EgOpdDu7y2NhpNJeTNGKfIIhVOJkpKAGQ84+IYtN3Zc+vaK/ZFWDwmyr17sy/E
         /Rd+wYxi0CNGR2cfgRHUSuJECfkb61q5+RoAWa0Ew6Gu2E6hK3OpGgut2lvSMYrl36QR
         s43HQdRmqtdE/noTioXEI4tRVFVlYKLpk/zfXOJMuZOv/KF6S/dHkznZpJmReGZM71Qg
         riIX9ibHVMkGAzJYvKfYcXIztODFOVyeGOwZl8wx8pN9bmpkKQZuFs40CqjYfVDeOqTr
         /PpA==
X-Gm-Message-State: AOAM532SejMx8B94gfiI13S0ach5bYfy7IykGPitjIpAg3pYOYGXog3i
        tw4kRmFA5OoBIK2rAeT5PuSBJ715KZhsOAfWA/hXrw==
X-Google-Smtp-Source: ABdhPJw50cRX8dVUdsvnUo20MaZWEMiOKDDikxukTABn+21hZBBOQc5j6uiOO01exgTSS2/qWWQ10RQ4Eye5kRwkxXs=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr480601lff.465.1627636425019;
 Fri, 30 Jul 2021 02:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210716162724.26047-1-lakshmi.sowjanya.d@intel.com> <20210716162724.26047-3-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210716162724.26047-3-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 11:13:34 +0200
Message-ID: <CACRpkdbv77hjJ91h3fuLSYbpT+Yxd4X8_S7F+NsUw+QsKXN3Ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: Add Intel Keem Bay pinctrl driver
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

On Fri, Jul 16, 2021 at 6:27 PM <lakshmi.sowjanya.d@intel.com> wrote:

> +       /*
> +        * Each Interrupt line can be shared by up to 4 GPIO pins. Enable bit
> +        * and input values were checked to identify the source of the
> +        * Interrupt. The checked enable bit positions are 7, 15, 23 and 31.
> +        */
> +       for_each_set_clump8(bit, clump, &reg, BITS_PER_TYPE(typeof(reg))) {
> +               pin = clump & ~KEEMBAY_GPIO_IRQ_ENABLE;
> +               val = keembay_read_pin(kpc->base0 + KEEMBAY_GPIO_DATA_IN, pin);
> +               kmb_irq = irq_linear_revmap(gc->irq.domain, pin);
> +
> +               /* Checks if the interrupt is enabled */
> +               if (val && (clump & KEEMBAY_GPIO_IRQ_ENABLE))
> +                       generic_handle_irq(kmb_irq);
> +       }

Aha there it is. "Half-hierarchical" with one IRQ handling 4 lines.

OK we can't do any better than this so this and the bindings
look fine.

I need to know how Andy think about merging, and then there is
an uninitialized ret in the mail from Dan Carpenter look into that
too.

In any case with minor nits fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
