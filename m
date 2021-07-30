Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736C53DB701
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbhG3KMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbhG3KMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:12:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92552C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:12:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r26so16916599lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsLkR/HJFOyd8pJoENYFHYMDBN3NZwnHjc6YfxQ3dl8=;
        b=ufYOgMEhc1ClDU5ltnOjlo1fbyMTvyLpxFyvjbI9XtsIHVAZHCdbhp0d+9DS4+8f55
         i8BlPirCwoIhJVvr0ykIjapnTlTga7LQDfmsiy8V6V/j0V+nMeSUvOLU1sztX3HZP4jg
         xKMhIyx1MQ/JXcU9BoWL7n4TVRvhilF1W/kB5/ZGn8Wb0Pl6ZxdBjEpMN6HMAVIzAacr
         oxUcF1lO+N6pPm2OgLQKNSn/Zxbsi1RVx5DylobncgX0k+nQZhw3icIaT82YqrMawXQb
         bi7390Fet4KRv4C4Cj8VPXpc4JTZWjHqdOzS5SO1/4LwYZNRgZdmmAzF7QHSBYWhP7Zi
         LaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsLkR/HJFOyd8pJoENYFHYMDBN3NZwnHjc6YfxQ3dl8=;
        b=agnt6yClwlyuLE4gjNxWyg+ka27XScY19iE6cbNFBtL+Uwu9S21CStmxkH6xhlMwW8
         elfzWdUGbPBca8obngEkl8v4UMHcpYh1UCSLK1d6slgu+JjyA1hhjUk5yANr/Psi1kfm
         6oGnVN4GJoTpKr3wa9Dcz/XtLFoGWWjmLgLOJu/VHbAQsHiydMNGEv5XMxD3N3rawavQ
         y3PvLKjIZ/2OKc3HcdYmCd+14/z5qhn+U/3/Likxr3tBXzGGV7HnpMmtY1fXhUFm2l32
         Ld99K8TO55wZzLnpHp96Rsyam2QTNi64DJkY3tqrKsBePn3iUWCt6i5oozDR/FHJyUt4
         4Mnw==
X-Gm-Message-State: AOAM530qpegEvzUH9Yufh3Feo2o+ES7o79FLEhOpfoaDFTOOk1ykjL3Z
        9RjHLOFRdinp/4hLohHrnavMWL4OiY75keOMQ8EzlQ==
X-Google-Smtp-Source: ABdhPJypPfA3Px4jtbDVZYY7wb0UeRHMt02OLb/ww/GLw1XchMeZyH86gddeb+fVz5pKilqK3LE9PJ1U8EOkFaDyLzQ=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr638110lff.465.1627639966985;
 Fri, 30 Jul 2021 03:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210717045627.1739959-1-daniel@0x0f.com>
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 12:12:36 +0200
Message-ID: <CACRpkdbE+_DJFhBCmtz5JwJupf7QkkWZhXrgf1KG_3rPqvEm0w@mail.gmail.com>
Subject: Re: [PATCH 00/10] gpio: msc313: Add gpio support for ssd20xd
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
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

On Sat, Jul 17, 2021 at 6:56 AM Daniel Palmer <daniel@0x0f.com> wrote:

> This is a little series to add a compatible string for the Sigmastar
> SSD201 and SSD202D to the msc313 gpio driver, add the specific offsets
> for the pins on these chips, and then a bunch of DT wiring stuff so
> that the LEDs on the M5 stack unitv2 work and it can control the
> power switch for the USB connected.
>
> Daniel Palmer (10):
>   dt-bindings: gpio: msc313: Add compatible for ssd20xd
>   dt-bindings: gpio: msc313: Add offsets for ssd20xd
>   gpio: msc313: Code clean ups
>   gpio: msc313: Add support for SSD201 and SSD202D

I suppose Bartosz can just merge the 4 first patches into the
GPIO tree and you can take the rest into the SoC tree?

Yours,
Linus Walleij
