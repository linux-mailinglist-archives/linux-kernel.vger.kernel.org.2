Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079BF426E05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbhJHPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243073AbhJHPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:48:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785AC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:46:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so3455945pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ctiMOgcKNZbwO+I+bqoe2efiKehJePIhv+cYstntJA=;
        b=wV8L3vXA4wnMlHP7d3ZvnoXIXRXMZHy83oyPI01WT63WO4HeMg59TXqtqkMjJ8Cq5f
         +ykidzi9ffxYunMNLRGqPC4miH6GYlkaGrEpgdF7V1RwvaxIjdOeCX+Qt1X7N1dKlBkg
         uRrLa8DMbtQ4uiAGXXGqM4aEynitnk4bVHeZokSjKJg63i8W4t7OOGwvtwWMGRUPudbE
         YfT+I3P9KPIZ2/rVaRgyhzwAB0M23xNbsaUzDbPcgHFlq0vWkZc01Db6SindT0urkgD6
         GInkOuzUuLk5G2Lc7Mv9KRcsUKtSVQbtVKX3GUMQ8Hpyu4OYLSQsIu3bgjJ1+VdYH2hL
         /4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ctiMOgcKNZbwO+I+bqoe2efiKehJePIhv+cYstntJA=;
        b=ctBcRf6T2H5TdsYgcH5sVchvdyQYMkGP++axS1pzz2hUS4MNj9a2NXxPM9xa7SHUsP
         zj17jF743T4aqxJJxZOdQ3AMWnzBYGtnOKIthviqDYOzpPI+sG8smOClDT0Y8tfsIB2O
         Lc9THLNxzvCeDvEnJc2CFeU3h0mxxVG956rLYRUhgFtUujZ1R8k4t/pR1aK5JlYKXpT0
         56o1frr7Rfx9OXP9qGK26WsJXAjJnhA4wWe4ESDfKTaeCKiuL9z9PUD6tSa/YPmOOBHR
         aq9SooQ4VQnAMfaoQmjbwHnvGQSXiRD5nk9ufKaIdJpaRA0NY9nqCdhPmvh/WXjm8Hjb
         /dcw==
X-Gm-Message-State: AOAM532DeWYmIkS/YBCXcKUzi7/N1A2vTk5+esf7/pTnfekrItyaNlNQ
        CtiLhT5bPG9U+nkMmmOhNBY8vFOUFbPsIspLx7aA3Q==
X-Google-Smtp-Source: ABdhPJxCIs63N1AEVoE9JLiVqD8Rt3LAnvm0WoiU5xo+0y+SBYvO324mUTInFk7lVWtwvrA/Z8x2JuqxPbscKJasGn8=
X-Received: by 2002:a63:3643:: with SMTP id d64mr5395570pga.110.1633708004080;
 Fri, 08 Oct 2021 08:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210930030557.1426-1-bjorn.andersson@linaro.org>
 <20210930030557.1426-3-bjorn.andersson@linaro.org> <YV5vIyhy+m+Nx/gQ@ripper>
In-Reply-To: <YV5vIyhy+m+Nx/gQ@ripper>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 8 Oct 2021 17:46:33 +0200
Message-ID: <CAG3jFyuP_QDKP6iUZmte3u4s=HbxBPx2iDTR8uh=Sc=24hguVA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>,
        Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 at 05:51, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
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

I think this series looks good, and passes all of the normal sanity
checks. So I'd like to merge it.

Uwe: Can I have your ack on patch 1?


Rob.
