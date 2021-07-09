Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7803C28E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhGISQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGISQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:16:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100DC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 11:14:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l26so6753850eda.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2W72u91t/gOHTIhrhyvg2LOLCXCndVPac0V2gbKNoEU=;
        b=nSKgGdauo1TReviAdCxOFT5jBwm98es/d/rsn6sw7dVmAg6DTtFu88JZc0+EGQWLoQ
         NJNMQsSLdZTJm7fd4w4fnduhrIRpfVyOadao4kZrZceImDTlRdJxhXuHNYfwXTqPO5Ya
         TdByYxb1DuCR4XPHriswR96/OvAATEtq+qOsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2W72u91t/gOHTIhrhyvg2LOLCXCndVPac0V2gbKNoEU=;
        b=jMvubcII05tv+X66VaUo9h4PkBc/rZ2aFL6WO24kQZPuCMnVl1CoWQN/Qnf7bSojIs
         xuWAMJpcgWKIeVEUMP/TDoRwfyEJemhYOzvRPVZagzgadI5I+cNAfA1DL0OX585Vz/yF
         l8c/u3iWbWoXnvWdjkiMtOzdb6J/BIEItC2a+O6r0KPRpueCtNlsPXLWuVIRxEaNcpxf
         YTJ3YMT/c4x0b/H4C6x5EpNtYky5Mew9HWZT3aPgaPWFEbrWrb19KkgwUUNJTW0mSyt6
         198XnVbCWaXmKgYBxjuygZU73ZgOqEZNHta1u6zwfN1wear00zD2ExoVgkWmV4lfIu8U
         0tkQ==
X-Gm-Message-State: AOAM530i4veNx6s6bqTvXIYXC6iOXsJbxmBsFX5PjMt4UWcZPsoj3Y55
        hSH3y5HK8wn5JTUO8eAQmJjEz6/tpBmB02tz722w2A==
X-Google-Smtp-Source: ABdhPJxSjqPSO+u8ZSmuCvyTztoIUAplxlphSZUQ0oIv57NlT+Rf0RQCX/5vpgr5w8x7SL37yAR0Ff5/uDeu36I6Wp8=
X-Received: by 2002:a05:6402:4408:: with SMTP id y8mr49155151eda.55.1625854444453;
 Fri, 09 Jul 2021 11:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210524184226.3064621-1-jagan@amarulasolutions.com> <CAMty3ZDt8L70xHH5pMy0M-3ATt9jAXAy3VVeRV_iMkcoebn99w@mail.gmail.com>
In-Reply-To: <CAMty3ZDt8L70xHH5pMy0M-3ATt9jAXAy3VVeRV_iMkcoebn99w@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 9 Jul 2021 23:43:53 +0530
Message-ID: <CAMty3ZCm4rguiEba69EyZ6xaBROkTfWvsc6vvrJL7X7KusCGBA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: panel-simple: Fix proper bpc for ytc700tlag_05_201c
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 10:58 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Sam and Thierry,
>
> On Tue, May 25, 2021 at 12:12 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > ytc700tlag_05_201c panel support 8 bpc not 6 bpc as per
> > recent testing in i.MX8MM platform.
> >
> > Fix it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 9be050ab372f..6f4151729fb7 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -4164,7 +4164,7 @@ static const struct drm_display_mode yes_optoelectronics_ytc700tlag_05_201c_mode
> >  static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
> >         .modes = &yes_optoelectronics_ytc700tlag_05_201c_mode,
> >         .num_modes = 1,
> > -       .bpc = 6,
> > +       .bpc = 8,
>
> Can you pick this, if all okay.

Gentle Ping!
