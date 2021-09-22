Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23204414578
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhIVJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhIVJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:47:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:45:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bk29so7502807qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTthP8lbagoNgD4znkkkPcaT2q+h8fGmYWbFuWXoDrQ=;
        b=IWHUjcdXwzYzIZEw0LJMOVNcxFzxts7J5SwUd4EoNozkeV9qZ4BmaoI2p4SW6AVAIv
         pLx/v01w2QMqzU9DQegqZZ7VaYeBr8oN5Yj90pYLRrlIUouBY6EDACJVwIoTv/04mH6C
         dduy5DsXXdVgwah75k/WJzgJLoCbrGdPowzKhaLgT0eJtIMmAgEVoElmpvJqTB1GNrmh
         gMxbm6gGc1R2hNP/fQXCDqVBGrq3GM6kT+ccApCizLZL5rDuAAUaDmtmoY6mX0DWeIMX
         5z9Mps2n/SaMjCT/qYLVY0DFTLYpMBxO1yb76Z0FnotqC9ITeXUxvtjatVbqRKLZp2Bt
         QxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTthP8lbagoNgD4znkkkPcaT2q+h8fGmYWbFuWXoDrQ=;
        b=BnN8YyQa0mdqliBLd43Kiq/XazDQwWoglfMw9V4jem7Y7phWmi7BL3uX8dR2tHaWnC
         CrriB866hZKPbVkryY09hFDdnD8qlMlInwJq+6rBR/dYrRbq+KNCay4rgBAk6gyb5lq3
         K74gr07hEeWkAvXhmJpoZ12xwcnKOLJ2YHRFvdWE5Q5l2S1DM0WSzn0c05pjwF9BBIsi
         p3UJ9isunoA1UKIzc0M5QJUGcZrbkrT09c7E5WexSl2KW0J2+qvCBO0Kjn0VpUQkoQ/d
         Dt8ID5g+W/XYTy088dC7UFWm+4cPeQLmFDrsWzrZvXu6bmq3Aj18XARQ34ZWEssWX9Fn
         1BnA==
X-Gm-Message-State: AOAM531vUqw28bFYK1FQas4I4D+xczBKIC9HxyHdysnT2lI6PZVXy3xS
        w/Y5SGKSbvOw4EiIWp64rtiKbxoqbLFCmEQHiLNTtA==
X-Google-Smtp-Source: ABdhPJz1dWLmkTK19qnONV6Gew86lZTBWocxC61DECZPcAD2oPCv39vXAZxXVu5i/CJbZwh1QCWRFftDyNRigk96mqo=
X-Received: by 2002:a25:7146:: with SMTP id m67mr43663441ybc.353.1632303958187;
 Wed, 22 Sep 2021 02:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210913224926.1260726-1-heiko@sntech.de> <20210913224926.1260726-2-heiko@sntech.de>
In-Reply-To: <20210913224926.1260726-2-heiko@sntech.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 11:45:47 +0200
Message-ID: <CAMpxmJWHoEP923iJr8WxN+oQ6ffQgyCZj7bwNDcR=j9T_Ngb1g@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio/rockchip: extended debounce support is only
 available on v2
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:49 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
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
> ---

Queued for fixes. Thanks!

Bart
