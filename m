Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684FE4101B5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhIQXb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhIQXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:31:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:30:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i25so39727224lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpnSJMR29KAOxGqlXqlxDiInk1Lq6rehAogLugRUoe8=;
        b=J5VPAEh1xGS3X/v/0MYXeaLoKImveKzwMsHGOu8nHDMw7OjmFS9Hou2DcQqHis3bJR
         yeTxXrd2Yct2FZWJCtE/OJyzjAS7gOjNaJ1UfrT8m/IKfIR6Ha/pRB3ns7pjoh3ffDGW
         6Q9a//cKO492bBwb6zzZLKHO3x2SuphfCZ9u5nxYZhNdpp86UwyCIR1Ee2QEwZ3Nyg6a
         mAoQ37zUuuOTzNHmvZaRH76EnvVXZW6hjBMaA80gH0WQOraP8EPskOPfoiLmDdY8GrdA
         5DT3P22RheTshOqWiZJnCGjltGh7klLb/bfCxIAFjrxFAjY9Zfs3oLwOr6k/m4B+mC+m
         4BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpnSJMR29KAOxGqlXqlxDiInk1Lq6rehAogLugRUoe8=;
        b=OyRKYfxJny1qvGCJuURnZZf36SYUqPfi5ClKn7EkIqpa50ikBXzvzKt/EFb58el0/J
         ylMwGeTmDreVLOdecat0ElF+WannUhXtzAfGc3XoFpvLIMqlkV1TRVnS5+BtNXiuFk59
         G5r0w/RCpgclThUNR5EOggW2ytc0Gaqd5h/oSbGt1vya3KMApDQilsR91wLwzV6UexlR
         TmmUL1rMD4yHeOrnXoW6x+nnvZETrsGpTDZIMs4I21eytM0fu7MrY/wuPrjCjnpYLl+5
         kxGso7YMax1qgl6K97hAmmL0HAfw8B/N8XDyxXINJbLsfUzw7ev0Ky5yJ9keHBiKDtVV
         OJ2w==
X-Gm-Message-State: AOAM532efEW1eBIpVsOlwKdUAECxig9MywyEGxxJFNvxo8lo4oFpnFvK
        Ob/jXrqxP4PBxhSfnbLd8ZIOlLF0j63cmgGM0IRLvA==
X-Google-Smtp-Source: ABdhPJyz8i7tHc9BbXGhfKFUhzwRCGvX190zW4oQ4YvwUaz8bQwCLLvxh0LMZ/w9bzt9ovtFB9KZDI98BNQ3BoIYc9E=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr11406831ljo.288.1631921432572;
 Fri, 17 Sep 2021 16:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210913224926.1260726-1-heiko@sntech.de> <20210913224926.1260726-3-heiko@sntech.de>
In-Reply-To: <20210913224926.1260726-3-heiko@sntech.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Sep 2021 01:30:21 +0200
Message-ID: <CACRpkdbcHi0+pe3jC6AkdBfZZv=EhA1prV1XAXfQKfi4fMtg+A@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio/rockchip: fix get_direction value handling
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

> The function uses the newly introduced rockchip_gpio_readl_bit()
> which directly returns the actual value of the requeste bit.
> So using the existing bit-wise check for the bit inside the value
> will always return 0.
>
> Fix this by dropping the bit manipulation on the result.
>
> Fixes: 3bcbd1a85b68 ("gpio/rockchip: support next version gpio controller")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
