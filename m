Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6983B3E5B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhHJN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbhHJN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:28:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843AC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:28:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n17so16250471lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txwmknRtly19dwG2TwLijdSUyS9aLwYWp1obTuXBfoc=;
        b=uZbA+1J935R3usprafc8LRUQw8doPbVfcapR1X2WEhOvM+EX7M63d5ZsO0VAvsVNZS
         xc3FivfT6ubgZbfMXKz52jSnsZIMXiSe+40kgwcbMhimzux+MtLWI03TsIxYPR8J+FXy
         Fg5ItgR5ZgUAVtjsevhX75vxMeq6H4bInYp3SkK3AbY468I630NCUa9R16uQJpzFZaVl
         wSQXu0x1FHzzpXqhzKbQ58q8eGA3P6T88AslMArgdP9Yv7k4KPId9rJKhKVQ0lnvZMgF
         JJiyC3XFKOXLI7k7TQbwnJZ6QDbjb2mbVHMVLbZcReEvjhfrU1stahisnFI79GDgAQW9
         +JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txwmknRtly19dwG2TwLijdSUyS9aLwYWp1obTuXBfoc=;
        b=MNMBqbuAz9bMoSNAQiVNXxo2eiBwIUHvPAlOox2CfXEP4+X+Pyzbujy3FWRYk3/zct
         GCfDLSxsu6OYfPjy80nDNYKF1IGyHec6oSF/Ll3zFwarEkMRYlD/7au7swVSvbe8wjSH
         B8uFuWL8tg7p+O5RA2LNK0P0GRUrzOOGiN1tbgKFKEz6dp6O/SbXbjhU9/sXMYbjJLIz
         L6Xz+GEFpOzX/OKRy1lFWMw97AFlqYVqLOlNt/CqeSgBsPt3XujbBJy4RkX3o6tzI73A
         U8G+ssDXJJcrozeSpM5zvXCGvpPp8kLcfkoaZ5clQ6eClNWbfFGuo6wJfEcKi8fQWjSn
         chDw==
X-Gm-Message-State: AOAM532dAm9uiyaTifcHwv5r4cggwdC+zyVSrRgbRnHxko/KWqHcI5zB
        ObMlGHXdSYqBzh/fcF8EabNsdNNT1yxZMGfICEUAgA==
X-Google-Smtp-Source: ABdhPJwobs4y7d/rU3nBa6u5h3FCXzTiFu5hBR5q/ktt76N9parIbFxpmpXXOJKBBwsROkKpvYnYcohfRvGFRZM7pmY=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr22073687lfd.529.1628602087498;
 Tue, 10 Aug 2021 06:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210723022543.4095-1-jiaxun.yang@flygoat.com> <20210723022543.4095-7-jiaxun.yang@flygoat.com>
In-Reply-To: <20210723022543.4095-7-jiaxun.yang@flygoat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Aug 2021 15:27:56 +0200
Message-ID: <CACRpkdYVcCW2yD_Xva+cog7i5C=YokMw+52i7iq0Nj2vVbWacA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] pinctrl: pistachio: Make it as an option
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 4:26 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:

> So it will be avilable for generic MIPS kernel.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> --
> v3: Depend on OF as well

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
