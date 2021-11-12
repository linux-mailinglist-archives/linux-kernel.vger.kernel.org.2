Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772F744E92E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhKLOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhKLOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:51:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40933C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:48:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f4so38597607edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liCIQ0fS9RC7PAp1JXFa7fSdczN2ri6zbG8n42TR698=;
        b=2d38TNhNK2cNhtiA0+1oHekR01L0p4voHKIlXJMPEYWP9lQBKLbuptj3seDiN2+mGE
         esruC5cRcsMBE83MAsKK9tLyMOAXSWnMcCpmTC+ddIoFMbiO1EH5h1RP0CWyVnfmgFXc
         JCop+Mapt+WwyqbeAtX7Q6nITLVv+Z7QTWoi7x29Bfews3hM9GPzMyjT1Ba7s3g7px3Y
         xbYeR6MFxwV2WL9zUm6ntNa5gIQZZ9vRSoSHBY/oGBJy03Qq6ebvoGh6aXD+2Glk7Dh9
         pSLtyZqRcqsVSaRw4Q2l589V8WV2EAPyNaLOm9QQ6ciRsp+rUIOIoLPyMfEXbIoy5t2w
         t8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liCIQ0fS9RC7PAp1JXFa7fSdczN2ri6zbG8n42TR698=;
        b=TK1Tl77X7qIhJwr/k0Q0SJit+Dp8EJFEN7j1uucHGhZy5nm/xTz8Ns7Xry5a187f/Y
         s3FcLJh3NCX8nWqpkHyj96qMqx09IVwqQtmAbGdMn4REDDAUClCUycd/DKRwz8zcz6Kj
         gh7sDe9u7Tc9eUJhEQK67wE/8f9XgxCY96xMA0C9HfUbXURLT4Vc16Ov2jiIcR0DuPnI
         aePgmBE81zGB40lym4lxoAGquYN07a1fxzEhGulvb1J/iByRNjDn2joXTS5ScBJGgRMz
         ECTqE2mOhMlnsJD0igiOktDK3cMDV+B2gx/TncMSK1lwMQgWZp8nvC97rFl0Uq1uTBmW
         BeRg==
X-Gm-Message-State: AOAM530VKosEfyzmOY58pTTZmGwDy2o6Eh3J75L801ABMShtagpstA+M
        GJTkZtbCiMoVZbhK41tdGX2pqTCFXQPHhDbWa/l8uQ==
X-Google-Smtp-Source: ABdhPJzc44VifLa2rYLGlj3oXKnMb9qqwgqk4m8d/p+GHYSsjU2862hljMkjoNQFEFNAMXKeIt4lmytpw57S6DWqarY=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr20705808ejc.77.1636728524826;
 Fri, 12 Nov 2021 06:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20211111202506.19459-1-brgl@bgdev.pl> <20211111202506.19459-2-brgl@bgdev.pl>
 <CAHp75Vdbgk-SVe_eFHUdnNUF65ZSRPHVZXExus13Q6j2CHFy=g@mail.gmail.com>
In-Reply-To: <CAHp75Vdbgk-SVe_eFHUdnNUF65ZSRPHVZXExus13Q6j2CHFy=g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Nov 2021 15:48:34 +0100
Message-ID: <CAMRc=MdtuDVnBMWHuTYUC7e65s8GsYrPnRv0zcmWGJwEQfmuSw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 9:47 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 11, 2021 at 10:26 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > Several drivers read the 'ngpios' device property on their own, but
> > since it's defined as a standard GPIO property in the device tree bindings
> > anyway, it's a good candidate for generalization. If the driver didn't
> > set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> > device's firmware node before bailing out.
>
> Thanks!
>
> ...
>
> > +               ret = fwnode_property_read_u32(gdev->dev.fwnode, "ngpios",
> > +                                              &ngpios);
>
> I'm wondering if there is any obstacle to call
>
>                ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
>
> ?
>
> Rationale (the main one) is to avoid direct dereference of fwnode from
> struct device (it might be changed in the future). I really prefer API
> calls here.
>
> > +               if (ret == 0) {
> > +                       gc->ngpio = ngpios;
> > +               } else {
> > +                       chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> > +                       ret = -EINVAL;
> > +                       goto err_free_descs;
> > +               }
>
> I would prefer the other way around and without 'else' being involved.
>
> >         }
>
>
> --
> With Best Regards,
> Andy Shevchenko

Will do. Just a note: some drivers that parse the ngpios property will
need to continue doing it themselves as they have additional
requirements from the value (limited max value, needs to be multiple
of 8, etc.) on the read value. For those that are obvious, we can
start converting them after this patch lands.

Bart
