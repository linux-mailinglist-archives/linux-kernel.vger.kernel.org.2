Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51574373DB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhEEObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhEEObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:31:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75BDC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 07:30:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h7so1201523plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zEv8nAixPgL46JSR4uQPKjAUuyl9jKFKOraavjZjV7Y=;
        b=c4xPmkDnMx04sfqNIX2jDCykqc0WM7f7BBuIbvIBVqAOCuBzQr8ApRcT+61JmjqM17
         wHs+u5T2PLWq1YG0sFrl47YthOxPCewsZJ24uPu0WQRhuZYvuXhH03SNwcckh+fLAukP
         VbNIxT6JDSJ+WIvNCblB/btc4TUCAlkgeS1MnD2TsmKBV+OgoMEEDkGb8TaSNGFpvSoO
         dOw3UPmfvGmG7qYM/MJfvC97nPl0LzBCl6ZnlGyVirAwROwPGNGoxMsjGwl6TVK4i/U4
         twUs122WDx4NpIhUeFDjw2C09REIkWjLLQ3OTpnF+OEM4y6vBb/z5AeCCK4myrfNoMoF
         IV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zEv8nAixPgL46JSR4uQPKjAUuyl9jKFKOraavjZjV7Y=;
        b=K4HWThqDsEImY+hrHQ7fmNp1LAK6k9yjXxO0fI1FBYrGpiys4fBX9YYFweQ305A75L
         KHSZNvNuFlbMieGBQaAucppmiFazyspLqhkzXmLNBpn5WZ4g9EE/4gBpvuiPDI2q3j3B
         aY+ZQoAm4N1If6iUbukd00vUNCe/2NqL6YK36ADUHael6emXHPoc/kiqA7ZsRQ0d0FfB
         TL9a86sN6G/rwku/LH7SG512y1QK3+yf1dqd8g8WuIiy1aojWN1EG2PJn5dElGNDLs9j
         yFCEzDb36JcKGfVWqGyFo1uCvI3C0xKnTiju8xFXa503t1j3dW7AocuLyi5OCBEM3ZPA
         2Ntg==
X-Gm-Message-State: AOAM532Jthm9jKAnqmdyN5LR5xMSc1VAUIBvwEVcYJnwyM8O/GxOM/yy
        hl99yB+yXrMsck1zb244nYizEWlC1hqFrDoq7D8xPA==
X-Google-Smtp-Source: ABdhPJxZ1jFoxt2V7it6GVWCrH28jNJyganmzPP9tTaS6Fmd8tmjNaWi4T6fg+Bk1e218hElevMDhgtt8YN3Q42142k=
X-Received: by 2002:a17:90b:3504:: with SMTP id ls4mr11322599pjb.222.1620225048480;
 Wed, 05 May 2021 07:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210504220207.4004511-1-adrien.grassein@gmail.com> <CAG3jFyu-aWLoiJ01h1DebVz66qtmt_T8adROKNBGBOzqbJvZvQ@mail.gmail.com>
In-Reply-To: <CAG3jFyu-aWLoiJ01h1DebVz66qtmt_T8adROKNBGBOzqbJvZvQ@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 5 May 2021 16:30:36 +0200
Message-ID: <CAG3jFyuf+-iknRuQbN-nPDc0f4MV-Hke3EQ9AyZzpaFbCPD57A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix LONTIUM_LT8912B dependencies
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     msuchanek@suse.de, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next

On Wed, 5 May 2021 at 16:28, Robert Foss <robert.foss@linaro.org> wrote:
>
> Hi Adrien,
>
> Thanks for the quick fix.
>
> On Wed, 5 May 2021 at 00:02, Adrien Grassein <adrien.grassein@gmail.com> =
wrote:
> >
> > LONTIUM_LT8912B uses "drm_display_mode_to_videomode" from
> > DRM framework that needs VIDEOMODE_HELPERS to be enabled.
> >
> > Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge"=
)
> > Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index 400193e38d29..70bcceaae9bf 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -68,6 +68,7 @@ config DRM_LONTIUM_LT8912B
> >         select DRM_KMS_HELPER
> >         select DRM_MIPI_DSI
> >         select REGMAP_I2C
> > +       select VIDEOMODE_HELPERS
> >         help
> >           Driver for Lontium LT8912B DSI to HDMI bridge
> >           chip driver.
> >
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
