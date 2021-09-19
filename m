Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7714410C0D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhISOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbhISOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 10:49:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CFC061757
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 07:47:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so56221182lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lmDmi4ftibwcwvQEbdJqNW7006uN+Sn0ovT9xUpowbg=;
        b=n7L0J9pPStqtmw9pJSM4IYMMGi2K9h8R0s8soWPd7QUE6OYVsQlwZZkeR6yHOQO8OC
         8TSo0XugMgqobFzoL0iQo19lJm7TBB+dZZym756y/Nb0pX0/ftTfpPnVaDudGWQWhWof
         D8WrVCCXydGQXup/Z/u3tB3sMrAaKAJv6kqh2ka5aFrJ0xBsvfgD3APBhlRPirqbVVAo
         XZEJNarW8ldkljJ4349eSFvKfU28GIjx/PghKlXYOu+ID5HycZahCTd0kHog3QQAHu1C
         u6FjRpVxKY8yacZ0CdaaghgJrM3c420Ct/h9QEEK0gjaEpTayKiTRg1Ce6An73C4vS4j
         Uz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmDmi4ftibwcwvQEbdJqNW7006uN+Sn0ovT9xUpowbg=;
        b=uASFc+IbTAJa/9+a1zFnihflKrR/42rz7f9gnkppsGihd1SyIDPZQ3iYzY61s3rexh
         COMIVVjEAHveYFKozDKRwVzPko+4EySxkBvkZt4Mu4NHfrq6wq7GE6NtV5sp+aH755Ra
         DKQF9JChfIlrXPU7Hw8eoXISsaQFDxfV5/xQ1xcwT8WMmmlN4LhFFV5jhKrK5NLhLJ8e
         FQoo+aQzJ7SQZDmVcCbiXQP9F2gckLGAQg5U9FYwrPXkFFwb1M8aE9yDLLeOJVpoexKt
         sSZL5B4DFxb3Pavv/PiYOunvHdZmmWzuNNwNmIOrnikm3UoNUasoQ8/69/1j2K34nnty
         F8Xw==
X-Gm-Message-State: AOAM5316ezG7HV86wwgs/ABKsv0pGwIPrVVqz15uAi94dhwHYNZYKdc1
        QWZ/nUoykXWCoE8ECZ4emEmFiASIlpuNKD+r4ZztVw==
X-Google-Smtp-Source: ABdhPJwXnTjXl0i8JlJQlNjJu8tA3ja58MlRNxYCL22486ltOyGOxvhIR5XFzp5T4vRuXB22kODXEPpoqdt/anIjpJ0=
X-Received: by 2002:a05:6512:3c92:: with SMTP id h18mr15315667lfv.656.1632062852495;
 Sun, 19 Sep 2021 07:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210913224926.1260726-1-heiko@sntech.de> <20210913224926.1260726-5-heiko@sntech.de>
 <CACRpkda2Hc6E27LK=vH_qKkTayG3qP=BGdqBKyLR2dMhekyWTw@mail.gmail.com> <1992229.jx4eJSTThl@diego>
In-Reply-To: <1992229.jx4eJSTThl@diego>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Sep 2021 16:47:21 +0200
Message-ID: <CACRpkdYmfYmQpc6+bnpqaiQGrgH7gcBK-fgZ7VjTHGwPHULyCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio/rockchip: fetch deferred output settings on probe
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 2:00 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> The issue is that the pinconf part for PIN_CONFIG_OUTPUT is actually
> using the gpio controller to realize this setting. So when this ends up
> in a pinctrl-hog, stuff explodes while probing the first pinctrl part.

The Nomadik driver has something similar, I came up with a solution
ages ago which isn't elegant either, so it's not like I'm any better :/

commit ab4a936247561cd998913bab5f15e3d3eaed1f9e
"pinctrl: nomadik: assure GPIO chips are populated"

> Thinking about this, the component framework may be one option?
> And then adding a pinctr-register / init+enable variant where the
> pinctrl hogs can be aquired separately, not as part of pinctrl_enable?

Check out my commit, but the component framework is what we
should ideally use (IMO) when drivers depend on each other
so I think you are right.

Yours,
Linus Walleij
