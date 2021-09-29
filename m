Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9C41BCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhI2CaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbhI2CaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:30:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7551C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:28:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so4264427lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzNXCj84D1g4PbD9Z2/a7WAfkTzxrDKROcDc/hzpBWc=;
        b=UFBbRLUsdxkCVsyDBTZelri1sE1uBJFhlXVFzOQ00BYD/vd027QrYNGqzaxNahSk5t
         p6RkaJek68Zp/n/NESHX4OhAOqTF0Ns7OTCXh7/7WouElvWnEJzoUqEO5tfPylzKLTcJ
         4mmlTm0nReyACi0Ttcsrq2osd9UWg42lgdAnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzNXCj84D1g4PbD9Z2/a7WAfkTzxrDKROcDc/hzpBWc=;
        b=Wl7yHDn0oopZNVuCU8UEToGzR2EovpXyYoBu/4Rl2Ts8ldo/N9TtLz3Z371Tj73w2Q
         AXLNiqPH7yVd9Gwukw0t3U7SVroXbNP5+BenM3pXSqR+1QcnBuzhfiG7lHMETNtTMzeG
         HKM4WXT1GM8wQwVqie3S92S/ibUzHvE7R6TqBZtymY+O6fmimyU/8V6b596tdAH9RFLl
         KUJ/5bPuyCZyG1xACdqHhMmagS2yo5PkKlM+/trJU4ldtqyE0pC8ogTz0ZAY2qMK2G7q
         /Ne/nkZOnXrO50tqHYc2LZf1ugF10NsVlY8BLSheVyrgWWXusTzZYBAJ2fB1rvhwyoyt
         8I5g==
X-Gm-Message-State: AOAM532w7/3rm9Z/nXYIBY8Hnt3dvY0vgsZ6Dw12q7HU50fbQn4EVtB/
        HRU2vsruLDTJ8HwiQn20OzfmKfcmAcYQypbc/OSmmA==
X-Google-Smtp-Source: ABdhPJyNUZV2MQMbi62ec77cW4ABFydIvPmDIM3cOMvSI1YRYR4lewd8Ni0ge/QhfE1OeZiNo6sOeIu/PGqaRs29+uo=
X-Received: by 2002:a2e:b80f:: with SMTP id u15mr3549500ljo.414.1632882506299;
 Tue, 28 Sep 2021 19:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210928213552.1001939-1-briannorris@chromium.org> <20210928143413.v3.2.I4e9d93aadb00b1ffc7d506e3186a25492bf0b732@changeid>
In-Reply-To: <20210928143413.v3.2.I4e9d93aadb00b1ffc7d506e3186a25492bf0b732@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 29 Sep 2021 10:28:15 +0800
Message-ID: <CAGXv+5GiQrxrcwCt0A6Dxxodd8JTqUvEJtZdzB=SUKJuWD_RVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/rockchip: dsi: Reconfigure hardware on resume()
To:     Brian Norris <briannorris@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Thomas Hebb <tommyhebb@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 5:36 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Since commit 43c2de1002d2, we perform most HW configuration in the
> bind() function. This configuration may be lost on suspend/resume, so we
> need to call it again. That may lead to errors like this after system
> suspend/resume:
>
>   dw-mipi-dsi-rockchip ff968000.mipi: failed to write command FIFO
>   panel-kingdisplay-kd097d04 ff960000.mipi.0: failed write init cmds: -110
>
> Tested on Acer Chromebook Tab 10 (RK3399 Gru-Scarlet).
>
> Note that early mailing list versions of this driver borrowed Rockchip's
> downstream/BSP solution, to do HW configuration in mode_set() (which
> *is* called at the appropriate pre-enable() times), but that was
> discarded along the way. I've avoided that still, because mode_set()
> documentation doesn't suggest this kind of purpose as far as I can tell.
>
> Fixes: 43c2de1002d2 ("drm/rockchip: dsi: move all lane config except LCDC mux to bind()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
