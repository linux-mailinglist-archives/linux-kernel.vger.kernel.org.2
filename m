Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640934CDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhC2KTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhC2KTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:19:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:19:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m12so17592375lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtArsucS8n9bt3Hdp227Kn1y94pWHajU5/Cur8Og900=;
        b=SDmecpaoCDNLSzQHsUAVMti8ggfXK1pQp9KWpIoIyTjaFpMqOOI8bIhX1UDR5Wcm1v
         Ymu1hWRLYXytdQQcbLq8joBKxxNRVE5yarnsfaStEV89Nb6zmdP3VGgVGz+dhEK1z8wT
         4Jo1WkZR8+uTwZI2OoByMczdDJOFlWq+qodS8sVwaRZoerPjCvyPcWocTtFItgqOdIjh
         UB9Kk3ZgrPwaqudCjnvWco8sH82Ztb4h68dnhAQyltn5zrJBlq8upuO4/xjb7M/LZxYQ
         YZo7LVSs7DPkKMTzuDbS3879ZWpGqxTnSjLAPis1GPZN/9LsZj2ufk3WXDcjw/J/JTDE
         xmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtArsucS8n9bt3Hdp227Kn1y94pWHajU5/Cur8Og900=;
        b=nzclRvJ78cWcR9JZaZcwuF7wQn08q873ZcTap1W1bB2NrEdtXUE+5HIAIJ2a1wlQyQ
         Vkm7bNbMwlLOOxAbBOkxXbPh1QC2SZSaJPZmPFd8a2A+oovX1qa9ASlaXWYVDZyNQaKV
         hs9JxGyv5tnDs3GRXEXgy/s21Qh+Z6aNH6H65rI5v5afhcShg5PKttTly+KPpfv9MrnZ
         tzqzlt+EwwRLzpjXj3FrV6UyCa2zmh803eOoKuNsBoYGMHypzyJFFpHobaoF+6Xuxq3s
         /PV5PhfVmDcHDhisCsJ/ziKalk0KVbGwE+L56z3Db1e03taPLyt4ed8F0nUEDH0+9Pwv
         9PAQ==
X-Gm-Message-State: AOAM532mVG5D6ZquPc06i3tz5wLtYOEQnSfiqNkS2y5UFGsDfOwjpzho
        NrTfD735KQ9vUsRxOm0mvO070HDujm0uJfOYXOxTew==
X-Google-Smtp-Source: ABdhPJwlvnvUMrVGemIwCAWrik0185OOxhSbO9ZT0u7w8vVb6h1aw6MPR5V0HupYjDIaW4LJT7kgkbe6zKfpyUls29I=
X-Received: by 2002:a19:343:: with SMTP id 64mr15314665lfd.649.1617013175657;
 Mon, 29 Mar 2021 03:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210324081923.20379-1-noltari@gmail.com>
In-Reply-To: <20210324081923.20379-1-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Mar 2021 12:19:25 +0200
Message-ID: <CACRpkdZE55ixxSp6H1SKx19trGE_uVGgkLttzAVQuLzw4=Jutw@mail.gmail.com>
Subject: Re: [PATCH v9 00/22] pinctrl: add BCM63XX pincontrol support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 9:19 AM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> This patchset adds appropriate binding documentation and drivers for
> pin controller cores found in the BCM63XX MIPS SoCs currently supported.

I have applied and pushed the v9 patch series with all the ACKs
to the "devel" branch so the build servers can churn at it! Later
today I will integrate it into linux-next.

Any remaining issues can certainly be fixed in-tree.

Thanks for your perseverance in cleaning up these SoCs!!

Now, what about a patch set for the IRQ support? :)

Yours,
Linus Walleij
