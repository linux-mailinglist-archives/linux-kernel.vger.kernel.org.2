Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0237419E81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhI0SpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbhI0SpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:45:08 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B24C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:43:30 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so25707216ota.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HADnuLjmEAtZ6Adqy4cLTMjazC/sJm6aQiFvmVyyZo4=;
        b=THiCwO7Zruhs5bQqv3BzUlc2PVXfItncfte4Dq3tvyVrPzlN4omD2HJN0zKWLQu7Gq
         2R5/2tJoY80gO09YsafkznMakjhV0PKeqTcfocK6lgX1f5Ak98bouzA6SLA8l+m2Fm87
         jL7k3dh+oKEedYtCK2//ERCD0Et5Oy2spD8tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HADnuLjmEAtZ6Adqy4cLTMjazC/sJm6aQiFvmVyyZo4=;
        b=CnhwYEZAcAZKIwMVI+qY6Azrj93cwNd/WNRHDPxTukV08aXGi2PCAvnCJlPdy7tUXc
         QbapyQtC+OgZXG5FC5lvSyQ467s7nUbsM7tQcWEPagBshgbTKNzk/alqhCua0l1qTB1f
         uFjU04n1edfhW55XB3l+V+VJ3uSfdLO8yS5pFvrzwtH7hZQrFm7KcSRc6Fxb/2/qGwSQ
         Glvk3YgWWrdNtwimgALBSFPlTXAmCxhuHyoO4GF4ecjBO9cWCk9Rz/bMnQoK+KYlGdcC
         9i7BgO+6ThCon9CcrKRDDjlt5FPw/caonrlnDvgfGd0eN/J0Xz2B8MuVu0lNg7Vn0xv7
         JEvg==
X-Gm-Message-State: AOAM533NpOgWWEkZRhc8LQQ5XwlQhMTiny3Az3RZOilIMZTg6ToEFhVs
        hGueXTDvc2G/7BMg1eoDbxFblb9H76yhmQ==
X-Google-Smtp-Source: ABdhPJyj1lioYpqbhue3qLJ3YTjiul4JKYQ07S8BqRkFseDh8r2AlhcxNkYegWBnSvaFM6wFEiGMeg==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr1294364otg.171.1632768209453;
        Mon, 27 Sep 2021 11:43:29 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id bf6sm4158868oib.0.2021.09.27.11.43.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:43:28 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so23635236ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:43:28 -0700 (PDT)
X-Received: by 2002:a05:6830:112:: with SMTP id i18mr1353439otp.186.1632768207428;
 Mon, 27 Sep 2021 11:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210924162321.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
 <CAGXv+5Ej=sDXOy1Hg9fQrdxN-OEmxpfUjE8PfxgfBkWu9dvOXQ@mail.gmail.com>
In-Reply-To: <CAGXv+5Ej=sDXOy1Hg9fQrdxN-OEmxpfUjE8PfxgfBkWu9dvOXQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 27 Sep 2021 11:43:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO4yGRDAH24YygC_utY3xBesLT1VapTibeiCYoH-xoH1Q@mail.gmail.com>
Message-ID: <CA+ASDXO4yGRDAH24YygC_utY3xBesLT1VapTibeiCYoH-xoH1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: hold pm-runtime across bind/unbind
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        aleksandr.o.makarov@gmail.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 12:10 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
> On Sat, Sep 25, 2021 at 7:24 AM Brian Norris <briannorris@chromium.org> wrote:
> > We should match the runtime PM to the lifetime of the bind()/unbind()
> > cycle.
>
> I'm not too familiar with MIPI DSI, but it seems that the subsystem expects
> the DSI link to be always available, and in LPM if power saving is required?
> If so then this change matches that expectation, though we might lose some
> power savings compared to the previous non-conforming behavior.

Yeah, I was a little torn on whether we should care about any possible
lost power savings here, because now we stay runtime-enabled even if
the display is not enable()d. But I'm not aware of a good hook for
handling this kind of a sequence, and I'm not convinced there is much
savings by disabling the power domain in that case.

> > Fixes: 59eb7193bef2 ("drm/rockchip: dsi: move all lane config except LCDC mux to bind()")
>
> This hash is from some stable branch. The mainline one is:
>
> 43c2de1002d2 drm/rockchip: dsi: move all lane config except LCDC mux to bind()

Oops, good catch. I've been doing too much debugging/development on
5.10.y stable. Fixed in v2.

> The bind function is missing an error cleanup path. We might end up with
> unbalanced runtime PM references. (And also possibly an enabled pllref clk.)
> This is a pre-existing issue though. The code changes here look correct.

In v2, I've performed cleanup for the runtime PM state in this patch,
and added an additional patch to fix the other existing issues you
noted. Thanks.

Brian
