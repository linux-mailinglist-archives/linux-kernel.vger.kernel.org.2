Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65444101D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhIQXjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhIQXjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:39:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A87C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:38:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p29so38491872lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeHzeB7io94eA/ZJSHL1lXdfmPLUOLShSlChdwb/4UM=;
        b=dy9OzlFOrhnl1DS8/X+L7nE1kMFKgnlxfciOEhe+x+cltD1TM7SnASV0vjMxXR/urJ
         kIkBxfeK5sxCQgMft8Yyfukwk5oiWkXaZVJzhT0fhd4TdKGiDkPn/M7WUZkjn8dIH2cK
         sCGAXski8FM3PPJ0AsCsv7dSz8+bad5pHjO2gPuYTY8kwb6dAvj6HRvj1Z3HWi7eN9u+
         C5aOzaMx7T9W6JVKIifyQEGb8tHMb2R2Y5aGafrOp4Biu6oWNeZTAxtLM2fdWh5kx2l1
         bUd1fQfkYn7tmjFQWZ4gp3ARCgd7YoLuubNMaNgsjcTE8KD3mEneFcX4pktxKupTJ9FZ
         d0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeHzeB7io94eA/ZJSHL1lXdfmPLUOLShSlChdwb/4UM=;
        b=Wn8bMs5WpPJqNMH305rpfaAOykz0xH9cIdLaVXFCeFsSmFA+kj0/NIn9S4T4sD/TrC
         gdASXU5kh1Wtf5sisy5l949GfGDOR2uNkMT4dvX4Ed9EZRIKimqgvmq5r53y50E3ZetF
         kocx8AFfzXpwznY+4ohyVqZemDJGvqvUqoElRAWlTm8L4zzYnbM2aX6l/FC2X3WZmxTi
         szXvwTA01KX2og+Vd+XI2+ZwvkTDAiLZfN/4nuVHIAwUHO7QeHN4yYI1+yB4sw2YxYGc
         leNHuBdkEhQcRgNyskQkffGqwox3pVZZVVbmDTUJy0mQDdLO35sFjcUGp6yczxHuDGQY
         sT4w==
X-Gm-Message-State: AOAM531Y48rDRRwY7ktNMi5o2yK+PloqegUPpq7ohVTL+/xFQkPu/II3
        D5bqkAykfpOFZEhVcUirNdwdFZyTP0HORUddN0MWew==
X-Google-Smtp-Source: ABdhPJw4EoEAssdj+o8H6LXsDHc8O7NrGufrLKeqnpYTgwFQ5ZKpgVAqKHY0OKYZbCBYW1+1Ss4+AJAaLD2tWKh8CwU=
X-Received: by 2002:a2e:b5a7:: with SMTP id f7mr11859236ljn.19.1631921899350;
 Fri, 17 Sep 2021 16:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210913224926.1260726-1-heiko@sntech.de> <20210913224926.1260726-5-heiko@sntech.de>
In-Reply-To: <20210913224926.1260726-5-heiko@sntech.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Sep 2021 01:38:08 +0200
Message-ID: <CACRpkda2Hc6E27LK=vH_qKkTayG3qP=BGdqBKyLR2dMhekyWTw@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio/rockchip: fetch deferred output settings on probe
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

> Fetch the output settings the pinctrl driver may have created
> for pinctrl hogs and set the relevant pins as requested.
>
> Fixes: 9ce9a02039de ("pinctrl/rockchip: drop the gpio related codes")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Since this patch depends on patch 4/4 I applied this to the pinctrl
tree as well.

I still think this looks a bit kludgy but can't think of anything better
right now and we need a fix for the problem so this goes in.

But we need to think of something better,

Yours,
Linus Walleij
