Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB964149A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhIVMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhIVMvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:51:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F846C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:50:18 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 72so9081655qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HndHJ7ZUEW+xisuoTw70puWbLmjsMn7XD42T3lfhJeA=;
        b=5ZeAMwUCt0ve0hDwYkIUvwCnhz/Gl9TGdTKCjpoZqDQpIvi5WGyVoZabBgdRCrUCP6
         QgfvEUIrnEQhybPkp7uerSQzcwEdY3ILVWHzm6WFJtSImwJ+zV31ZHsgjhG43G35rQKK
         BGrbs+gROzLtW+mpFjBw7ts0zkx3vPl3qD9gI4xANVXJTfWvELo6YewiNFbA0ESAQAOW
         CV+LdO9KZXaJbmNhg/PSiBCPUrZHfHT1mRHfEM4tNmgKXLargI36mgRgw5l9Ry/4GBuP
         Q0JY5PPyoTNaeNOANoAz3PJJdbNzbCXj8mt3MAsyKA1SVo4rKGO0/AopD8wenhSGtSon
         Gw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HndHJ7ZUEW+xisuoTw70puWbLmjsMn7XD42T3lfhJeA=;
        b=y6/yKpjc1d2C6kIM9bhr8wLZQQX/n6LP7bjo3Iuo6DfJT0v8nw1UmYXsJzF3KVt9IJ
         8CxsOLz1bGqSteef7I7bHgeI6MX9I0bZHFK8M2yKRFS1yc+sjJPpGpTEHEzME5hVaSPT
         SDCe2GEQJitHCfHarWwGm6U76Haqhuwp//HqUyI1cn2G2KgqgxZKYfPegUy4bJiLJwuf
         csb1lBwy9rDe3PWUZ3xTFk7YF0a4SEJBxXak2pNuCQuaBkhUE4wUm4IFZFMfSuDSSU5g
         PMWU+VlNZA8IFjHzsm3RtzFTfxbvDOI0AItLhxZve2CSn3xQwkzdWB0aXj0mZRcG+iBw
         lv4Q==
X-Gm-Message-State: AOAM533QSAkjKLK1vwDk32p8jjVS1v0RamyBkstQA8w9iDF2a5sVc0KW
        pv1IeZDrkhN5iFrjR5y6dFYLQe7OObuKGzwToN3Skg==
X-Google-Smtp-Source: ABdhPJxUFVjiblcTCC3jDe1LZWVRPuDRtn1tONvxJnHGP+NBYcE7+e8ypUKHjLNNSF4K1K/9XsQ3iVtcmdJ5U6C8VME=
X-Received: by 2002:a5b:783:: with SMTP id b3mr41042313ybq.328.1632315017572;
 Wed, 22 Sep 2021 05:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210717045627.1739959-1-daniel@0x0f.com> <CACRpkdbE+_DJFhBCmtz5JwJupf7QkkWZhXrgf1KG_3rPqvEm0w@mail.gmail.com>
 <CAFr9PXmFHanrx4Frg3hQwo-RbAY-UXxC=FOAj++cshSHa99z3g@mail.gmail.com>
 <CAMpxmJUoG7qPhy2CxapCn1M=w_AssOQsEmyvXO18OpedM6hBjw@mail.gmail.com> <CAHp75VdU52rwKY3AA0Nxt3VGOFr71XtjCDqZbSxR4GNczSqihQ@mail.gmail.com>
In-Reply-To: <CAHp75VdU52rwKY3AA0Nxt3VGOFr71XtjCDqZbSxR4GNczSqihQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 14:50:06 +0200
Message-ID: <CAMpxmJUSvBSa=T1a1Bq_YhAGib9BcXf4xYMSOfyprHbG0t_QWw@mail.gmail.com>
Subject: Re: [PATCH 00/10] gpio: msc313: Add gpio support for ssd20xd
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 22, 2021 at 1:21 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > On Wed, Aug 25, 2021 at 1:50 PM Daniel Palmer <daniel@0x0f.com> wrote:
> > > Hi Linus, Bartosz,
>
> ...
>
> > > I just noticed I hadn't to'd Bartosz about these. Is there anything I
> > > need to do for the first patches?
> >
> > I only have a part of this series in my inbox and patchwork doesn't
> > have it at all - can you resend it with me in Cc?
>
> Have you tried to use the `b4` tool? It is capable of getting
> everything from the lore archive.
>

I haven't tried it because I have never heard of it. :) Thanks for the heads-up.

At the same time - is it too much to ask of people to just use
scripts/get_maintainer.pl? It's so much easier to just actually get
the patches in my inbox than to have to look for them manually.

Bartosz
