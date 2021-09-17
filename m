Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC1410157
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbhIQWgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhIQWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:36:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:34:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b15so20466724lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXiGALIBXJHuI6xmyac3EY3aPT5ycKco2OHFCbsywNE=;
        b=Iwi25YMops4Fmva5SMYK9N2ZZvpq0vTvGG1mOZDPShDLAFmJRwvjUmyaBQq3xdy+Ed
         1axjrbdlsU4TPN4zRNWSwKzClPgzmpxOySjix+X7njTv1p2vGVdAIuUxBkZELPvUCRhD
         Op5+FAJaOrkDYCdgzARHqnv915gqxYvX0MglO9xagVl+g53HWeySaVg1ZKyClwZIe2pl
         gqZCRDHOmWDMcgYvF+rC9QExMKqwvK6zg39zyRii/jrl0os7/wBPiWRw3780/IPgqvsA
         Kp0FCnhzX9XIWRmgrJop9dNDUklKFVEHgoifa8C4VSLjeGr3VgeSxfON95nPxaKXgUUS
         hmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXiGALIBXJHuI6xmyac3EY3aPT5ycKco2OHFCbsywNE=;
        b=hHIp9tmb3bC6OWchdi6+BiyHUrSiqDK43fZKSwZ+Yr6VbhbNshWS2+sXgXCqfYzGof
         JRHR2q25RWHlyxfublXYPmqdUKnTvhy+AUZ8Oh0D6D3yH8d9CE6VKH51wrE5BtfgLjLE
         KV43S860UrKl42Bc/+EGqHXDR/jQxtAebogvxf01tW4uaaSS7JWT8HghOLo+roF/S1W8
         aarEoaikmDmCQ44aWWPDEdFJkb65W19ej3MSNoUTZRuW4XcHwouaxiYB+fE+0PFkzQFI
         dSf+hXecmikc/BREBYYbgZXeRkWzWNhEZQM3F8u/KThuqJOiVN6XJghSZ5dMR+S4WBD0
         S2rw==
X-Gm-Message-State: AOAM531WXsfgAFe2aK0V99EcnwoWpCZvYXkHlMs0KNLhGGZZGI9fo/NG
        BLN4S+AJU1TkO1VzLgEXFpanO2QIv/F47wjIVV5lSw==
X-Google-Smtp-Source: ABdhPJxnXIcJHvzJCDEfKvO96DDVOnEjALfnFCxyXo3w5ywzjEWk7+CQHA5Fv2Q0E9JnPHkLVI9VUW6ZkRl9/aMEDjg=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr11241326ljo.288.1631918096195;
 Fri, 17 Sep 2021 15:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210913224926.1260726-1-heiko@sntech.de> <20210913224926.1260726-2-heiko@sntech.de>
In-Reply-To: <20210913224926.1260726-2-heiko@sntech.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Sep 2021 00:34:45 +0200
Message-ID: <CACRpkdZQLxpk5XYOnD3p5s6xAsNbUjTJ4PsMq1bvxVjdMepf+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio/rockchip: extended debounce support is only
 available on v2
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:49 AM Heiko Stuebner <heiko@sntech.de> wrote:

> The gpio driver runs into issues on v1 gpio blocks, as the db_clk
> and the whole extended debounce support is only ever defined on v2.
> So checking for the IS_ERR on the db_clk is not enough, as it will
> be NULL on v1.
>
> Fix this by adding the needed condition for v2 first before checking
> the existence of the db_clk.
>
> This caused my rk3288-veyron-pinky to enter a reboot loop when it
> tried to enable the power-key as adc-key device.
>
> Fixes: 3bcbd1a85b68 ("gpio/rockchip: support next version gpio controller")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
This can be applied by Bartosz to the GPIO subsystem.

Yours,
Linus Walleij
