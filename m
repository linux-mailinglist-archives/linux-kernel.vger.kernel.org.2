Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93343DB864
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhG3MMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbhG3ML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:11:59 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF524C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:11:53 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a14so9176824ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oJIeZcOcOPJ/i4mLzpMBQLS6AE+13Y8avAKoNcxP1k=;
        b=b4hXRZsxrIvCyPKxJq3eohsD6mPpTgbVVsSl0RpV8nR1xxxbYJEKpZQ3dWayQpOsjA
         vpGWfxPgwdMrJik+8vPk1we4h/If4ZARe17ciIzx61mMB4BrieDoxBOIq+5d9lt18jPE
         ol/7Yy5zR0HV7uUPAwCLDNsgO1oVqqN4gXDNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oJIeZcOcOPJ/i4mLzpMBQLS6AE+13Y8avAKoNcxP1k=;
        b=m1ro/VWcFt2SbYtyWhIWSMoOfP013MueOz8KKY5Sy5YY7d7GEn5+TsoRe+L5+p8Qth
         K7K9TOYh4PrWDn3lkZSOOwgvBJVXCyriTNK5AgMcIv0M+54JaAQ+SdFX3qG43+HbXQv/
         OgF4PLaYUFbuJhCuodoERceVXPLFI9YfMXQ5JYa9FOm5dQxORnAJlPqNq6pvR+1/yYTP
         9szUjYRaEatSD3ifCNrlisBZMDZBJuXyV42tnh2EGEpFMCxbA+qtRU8qGsagb5YxuZ5S
         LrG9XlPRMbjLRIIzg913e8BtzDLodRimvxEZxvXZn2y0U62c34t5plaAqHSii6WGTLTz
         x71Q==
X-Gm-Message-State: AOAM531wp4fh5TZuyuSZmjYj+TzWN78oSdpHqxHCe5MhqsNhuQRZBXgA
        pBo0mQL0RKE1XURQFqXR++88ctZqECu3oAkAX20xoAELzCo=
X-Google-Smtp-Source: ABdhPJzdzY/EkBXtzNbk992cCacQT8oJznIwK+0lfo184G1dL4ZfQrzWixcBHtE9NkEBCuM0gHsmDH2Vwoch4Bq+ytI=
X-Received: by 2002:a92:d441:: with SMTP id r1mr1209740ilm.106.1627647113059;
 Fri, 30 Jul 2021 05:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210727110232.2503763-1-hsinyi@chromium.org> <20210727110232.2503763-3-hsinyi@chromium.org>
 <CAL_JsqJT1_TKc9QDxGKZ=WrK8_JGwke9MarMzjUvJJPJD8A5Jg@mail.gmail.com>
In-Reply-To: <CAL_JsqJT1_TKc9QDxGKZ=WrK8_JGwke9MarMzjUvJJPJD8A5Jg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 30 Jul 2021 20:11:27 +0800
Message-ID: <CAJMQK-jnPg5bzPVRsq=9LEMooUN6CerdMqiXhgY5rZVkuB5UjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mediatek: convert pinctrl to yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:17 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jul 27, 2021 at 5:02 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Convert mt65xx, mt6796, mt7622, mt8183 bindings to yaml.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
<snip>

thanks for reviewing. All comments addressed in v2.
