Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFA3444FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCVNJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhCVMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:55:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C425DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:55:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a198so21102010lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnA9oqrE8mMJYoCBDJE689jPEwqppMfcVdTwmK1Y6c4=;
        b=n1pVgCkpBLa1kMa1KiIgCjcDVkCR4X+ABv0SyuXhNa6CsGJe4PRjotxnGsIx1+Tkkp
         nZXsJim9146CFhsE3xX1UhYmVdts9rm2AE4ekDq2ayt7/ZAcFxIlg7fDImuKmdZEX1Ay
         +bu1cKnRyzzEQXZDDPNEk105wMb/MjbmyIb0DvCHARGmhuOY/O+Ea80NZTBw0uDl5eUx
         WKwCCtQ6EwskuTYXPQ4j34sLaMZAEit27wOsph9TkU4LAHoUa7kE7EDny1RzvnEj/Q5D
         ndVA9F3CGJeD2iDweki+djev7HqcnwB36d6UAyqdkHeYG+711PAfdTINgEb0snO0FGEV
         dEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnA9oqrE8mMJYoCBDJE689jPEwqppMfcVdTwmK1Y6c4=;
        b=pVgK644w0wvXhBHqfbIuuyWDMAp2/6vggfnMGpqq59KC2JiQr3JydrgPQNkG5yOHUW
         qIaI4OCs6QwbA5Hd23mt7lKWcXh2SyigFX/8q7I4beIThg3JsQnFrLjpVVmue3YAmG6y
         XFXqLoUXJ8tHF0+JJbcfT/SQ3rAt9zj1no1ZkgW5rsfHOlWLYfOEClATHu/oU9GZEzli
         HzX/w4WudyHEkdkkmluX7P7HRyJ+juk5K6BfyJthq/MRf1w5rD6Bi82olF7tEqFNdBlM
         TUOY04+tCRdrW9KoksyYJx71tvqrSOjuhkxw2Rph9nWc3IXDuEFFu/UI9tp8NZC7hPH7
         va6w==
X-Gm-Message-State: AOAM5311FhW72NZVxoJ2lhGu4Jk4FKu/HcrZjtC3lGV0rq2KNqwF/0b8
        9WQmO1ZU7Fl/AiAAzQDY3a86fDFeiMGPil4+++UmLQ==
X-Google-Smtp-Source: ABdhPJx3MFZzaOpjYIZ9eD4ths32f1hidLiCA7SjBnnrDvWS5qELc5wEBqHK0GqShtNiGcSCy6geo82WMHAJqaPQ7KI=
X-Received: by 2002:a19:548:: with SMTP id 69mr8998765lff.465.1616417705151;
 Mon, 22 Mar 2021 05:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210322104310.863029-1-jay.xu@rock-chips.com>
In-Reply-To: <20210322104310.863029-1-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 13:54:54 +0100
Message-ID: <CACRpkdaskju7vmfVaooPi6qkiF6dO-q_MB-NSTPHYS0GBO3KyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio-rockchip driver
To:     Jianqun Xu <jay.xu@rock-chips.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Tao Huang <huangtao@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianqun,

On Mon, Mar 22, 2021 at 11:43 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> Separate gpio driver from pinctrl driver.
>
> Jianqun Xu (3):
>   pinctrl/rockchip: separate struct rockchip_pin_bank to a head file
>   pinctrl/pinctrl-rockchip.h: add pinctrl device to gpio bank struct
>   gpio: separate gpio driver from pinctrl-rockchip driver
>
>  drivers/gpio/Kconfig               |   8 +
>  drivers/gpio/Makefile              |   1 +
>  drivers/gpio/gpio-rockchip.c       | 650 +++++++++++++++++++++
>  drivers/pinctrl/pinctrl-rockchip.c | 909 +----------------------------
>  drivers/pinctrl/pinctrl-rockchip.h | 246 ++++++++
>  5 files changed, 924 insertions(+), 890 deletions(-)

This is a very nice change (separation of concerns!)
I'm just pinging to include Bartosz on this patch set so
he knows a new GPIO driver may be appearing through
the pinctrl tree (and he may want to take a look).

Yours,
Linus Walleij
