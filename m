Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024AD427321
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 23:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbhJHVkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJHVkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:40:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40563C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 14:38:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 5so12200300iov.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/00gewG7UHvLp0h/Ly/IXeN+qoVZwxiCoqxtVebbaI=;
        b=dQ0efTIPLYgHkP9U3dBEnvmvLY8za0lfnn/jylE/ulZ7zzSc1RBgqjCPWTJbCywGq6
         cpcZej1RcJAyZQ/UhxVaE7tvdYg7DQI/2Els9a0Xjzo6Si3dcWw3ltdvGFRVsCniX3+0
         LABaOfhs3fvNty6v0UECd4B4StXBRl+6QmoiwtXAfBPgIvUqenZJEs+NqDqIM9rGE9Rf
         QhXCblG3djveSWk5T98TPMRXSDvDnmaNIOsPKPZyXJKg4hjzaw+Cv1z4APTMPb1YMLy4
         A3X643heB80Rhlfhmo6o2AFNOf4UfJEKkndgWAky5btmvpHG/9hVh1G1AJGX9Cjolc2i
         WkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/00gewG7UHvLp0h/Ly/IXeN+qoVZwxiCoqxtVebbaI=;
        b=2ldaCLGlj+UqNex6izRoKHi1dydB0TGw3DD+0eG/Wxtmkjk4HA2eRys+HSIxsscv8P
         i2Y9TzWp373srYqlBOZLy6s7PbY8QG5rx3tMioIHr+FBzEp9pZJRjIqKJNHfSQWVdhRy
         CBwAqIu/SSU0R67AXTju/4XYfm4qy+xRxKkGfsJ3WLrtnF59tlceVpOF/i8gnHjJmv4B
         yIWtKssMSzPb54+yFCjre+dvk5TdhFu0uHvXoja0W/ew0wtJ2d6J/dXtJXfB9AdbJi42
         syHwrvKL7iup7bHCahaze4ErPLuYBct1ds0x4JkPPY8eYqru5z4qDdk46hquSsKEtDg5
         bS+w==
X-Gm-Message-State: AOAM532fH/CoQUVQL4gNlSag1X5Z/IJiMcYah3gddJXkUdxPlsSm4F8V
        +ycHooGhOgIMAuDHEdipbmBKrraBH4SJRUDE+Nax/Q==
X-Google-Smtp-Source: ABdhPJyTKjP0ROPI3lwiR64pOofPrdgty82JjDrOFyBtUPNFTt7D9ijmUlMj5dyBjrcq0P+6VIjSXFzDNz2EEnEXtzw=
X-Received: by 2002:a6b:f915:: with SMTP id j21mr9273745iog.98.1633729085509;
 Fri, 08 Oct 2021 14:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210930030557.1426-1-bjorn.andersson@linaro.org>
 <20210930030557.1426-3-bjorn.andersson@linaro.org> <YV5vIyhy+m+Nx/gQ@ripper>
In-Reply-To: <YV5vIyhy+m+Nx/gQ@ripper>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 8 Oct 2021 14:37:52 -0700
Message-ID: <CAD=FV=UZoZ6amH9KfJOMWy9AHfGOuEpCPJYDy5YCtks6WqVkLw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 6, 2021 at 8:51 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 29 Sep 20:05 PDT 2021, Bjorn Andersson wrote:
>
> > The SN65DSI86 provides the ability to supply a PWM signal on GPIO 4,
> > with the primary purpose of controlling the backlight of the attached
> > panel. Add an implementation that exposes this using the standard PWM
> > framework, to allow e.g. pwm-backlight to expose this to the user.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Any feedback on this?

I feel like Uwe and you have spent enough time on all the math and it
is clearly working well for you, so I continued to not dive deep into
it. However, in general I think this has been spun enough and it's
ready / beneficial to land.

It sounds like Robert has agreed to do the honors (assuming Uwe acks
patch #1) and that suits me fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
