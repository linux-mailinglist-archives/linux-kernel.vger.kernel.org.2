Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B35438C51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhJXWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJXWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:21:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEF9C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:18:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c28so3964810lfv.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rT5yPPhtsf2H9kbaBzLopKs7NqQW6eFfjhGcFaAkilI=;
        b=mBhb5XqfyzJJeLZBSo2AOD8ZqoyMHQQ/Ogm8FCUCJjVhsEtfPFvTbtSe/p24Yj7KMr
         HIvjhNzkKbDknCsbEtXoNtHdKDVf7boh3po/KztOCrJg4+n84wUcIdqHFdBJw/mswNin
         3K6/qhMqnhzBuNlktG75MyStamynDPnF8EYOqKEOuwy1OjAPH3Xw/QryeheTTrvY4Vey
         kWgyjY8dVnJf+u1ag39pISzSWVUdBWd8XsR09B8OsqllkSyIjW7e8zSvISv332vAot0G
         P6DALJz69msGBpx3N3jcx3NnXji/M33QJef4GuvzM5ohTTsnn9vK0GKQCu7EQQ50KTUN
         wrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rT5yPPhtsf2H9kbaBzLopKs7NqQW6eFfjhGcFaAkilI=;
        b=riNkecaGSfcxIY/OE1ZMCBei/UO/spweyqv7uK/EVRaGEX6TnM5rPs2GiENjfCg9U9
         A7P3lgD7f0EqzvdGPBL+TOWHM1xFLDeoBhBhKALGWr1MuIeCeplyBGJ4kXVp/j6Zt4Np
         hzz7f4gyV1cuoO0ByKvaE+hSqoWbZrR/RGK1W7VH4RDUvZhQMbATI7r1mga16ii9+MtW
         NyK/1RxaHqXC2Yi2oCED+cNcdL5f84Y2vBJJ7uQHOjLHbt3uMHfJaEzNWkZzuaCRJSVN
         BmFmh6p3qscsJC98G2VBLNBVaeCOi2UA+vIn7UChwa053S3lCoHua4XnL/nwot1sXhnd
         JnPg==
X-Gm-Message-State: AOAM532PiSLg3PY2cnTNyNoWv1sFhzuX3JagDsMVrhNXbl5GtFOzN1Ne
        9ov5xI9fEqB6olrS+fRUUD9wCn4jrngxFKd7bcQ7kA==
X-Google-Smtp-Source: ABdhPJyN9surB4BZXaAyD7DjPnt147mbw4CGPXtFR9WxL1+InQUqdKJlAQI8DKcLR8B/rT5XjsDs5wDvcuRHBUHHZcQ=
X-Received: by 2002:a19:f106:: with SMTP id p6mr3461469lfh.72.1635113933615;
 Sun, 24 Oct 2021 15:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210325122832.119147-1-sandberg@mailfence.com>
 <20211019200831.3817-1-maukka@ext.kapsi.fi> <20211019200831.3817-2-maukka@ext.kapsi.fi>
In-Reply-To: <20211019200831.3817-2-maukka@ext.kapsi.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 00:18:42 +0200
Message-ID: <CACRpkdZf74=DJHEVp9RhX-m0RKpuqU8hhDu5j3vLAoj5WAZJFQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: gpio-cascade: add documentation
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     Mauri Sandberg <sandberg@mailfence.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:10 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:

> Add documentation for a general GPIO cascade. It allows building
> one-to-many cascades of GPIO lines using multiplexer to choose
> the cascaded line.
>
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
