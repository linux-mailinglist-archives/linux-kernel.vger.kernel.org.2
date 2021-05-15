Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC113818AC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEOMKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 08:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhEOMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 08:10:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E11C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 05:09:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 22so1245653pfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 05:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XITU93CUfLuScWI1J4CVyiEqYuy3HJ2zRJqQJpcp+0Q=;
        b=rKfa/I9HZMht9ama673flisK0Sd1gicgX+2fEGQUKabSVeYCZkp8rd3tEJ1JRX5IBQ
         JVe/PIKlkcobhuDtveeSc59EIIcm1V0pyupxaos2BMSUqF02Wjwf5mtbP5oXbVjPTK+4
         m1wp+Jj5TMF9oKlPYfB4W8swL5shliw/xeXBEpPwczoYp6V5l6DjmGBTQ6DSD1CMdOmm
         JpRXGnJp3llL5AfLPX5zZTgdcfbZwwroro3NSCfbh+JkD5rIApq76cekxek9PvqgjtbU
         rVtDYObEK/r6mgaOhWaoaJvT7xbrI0NUCGTr3KTH04v99zoLfNhSN9dVnOPcXMo682wJ
         26FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XITU93CUfLuScWI1J4CVyiEqYuy3HJ2zRJqQJpcp+0Q=;
        b=quwHsEHG0Y5xfTMG8+cVYxEQzD1oRC7bbGzcXQM/tRxwI1y3HRVDspiTrNvlJwi0hX
         pXkUuL3tvibZ+HkASj493NxtFqeETvDg144LkU/3O7mNvdkMS3OJxy1FPdaQ+JzviHny
         MNb1gSU8jfJs+Fom02p5xbovc9K64p+VXcfPdnij/Iq/lxqJ5VoyuTib+UDls7GZVq/J
         vBiZ4yrTCXInBWwT+YMZycHYELYAR07WRTli5rGSV8XJJNfvJ9hE4DF5FPEc2p4E9yb8
         K07vvnYVk4z1KQIltaTzrTusbTgGnuAcVxK3IDB2SUUH8aIGVNCS1rab9816qLvTnz26
         Yf4g==
X-Gm-Message-State: AOAM530cvwE+fwWAuGsjEfCRjKceAA9LRFXm2vrkENjex1Tz0/oIG3th
        ecq7O3o+HUoxpA2DASH0jEI8/SMucxMNG397mnhZJw==
X-Google-Smtp-Source: ABdhPJxujAOhUS3DW+tsTK6wGoUmluZyCTIncjYhi0+CWwfEoIA9MNcHFepen4W9lrQ1iv6ryQdtPywt/l7Y9KlJoXA=
X-Received: by 2002:a63:ea0b:: with SMTP id c11mr51424837pgi.120.1621080552868;
 Sat, 15 May 2021 05:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210419090124.153560-1-robert.foss@linaro.org>
 <1627725d-1c7e-109f-f995-e761bb022ccc@infradead.org> <d295f001-575d-f14c-b0c1-1444dd29a03e@infradead.org>
 <75b35f2f-72bb-522a-afd8-6c26cd553588@infradead.org>
In-Reply-To: <75b35f2f-72bb-522a-afd8-6c26cd553588@infradead.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Sat, 15 May 2021 14:09:01 +0200
Message-ID: <CAG3jFyv5gBSG-xkQFDkQMhpqWa4-_e7GTb4pr4dJjZcNLW4ZQw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge/sii8620: fix dependency on extcon
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, cw00.choi@samsung.com,
        m.purski@samsung.com, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Randy,

I missed sending out a notification, but this patch was merged into
drm-misc-next.

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=08319adbdde15ef7cee1970336f63461254baa2a

On Sat, 15 May 2021 at 07:35, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/19/21 10:54 AM, Randy Dunlap wrote:
> > On 4/19/21 10:10 AM, Randy Dunlap wrote:
> >> On 4/19/21 2:01 AM, Robert Foss wrote:
> >>> The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
> >>> on EXTCON, which causes issues when sii8620 is built
> >>> as a builtin and EXTCON is built as a module.
> >>>
> >>> The symptoms are 'undefined reference' errors caused
> >>> by the symbols in EXTCON not being available
> >>> to the sii8620 driver.
> >>>
> >>> Fixes: 688838442147 ("drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL")
> >>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> ---
> >>>
> >>> LKP reported issue:
> >>> https://lore.kernel.org/lkml/202104040604.SSTe2Cxf-lkp@intel.com/
> >>>
> >>>
> >>> Changes since v1:
> >>>  - Fix typo on comment
> >>>
> >>> Changes since v2:
> >>>  - Randy: Changed from `depends` to `select`
> >>
> >> I don't know why my name is on that. I didn't
> >> suggest any change -- I just reported that v2
> >> had a problem.
> >>
> >>
> >>>
> >>>
> >>>  drivers/gpu/drm/bridge/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >>> index 22a467abd3e9..70402da5cc70 100644
> >>> --- a/drivers/gpu/drm/bridge/Kconfig
> >>> +++ b/drivers/gpu/drm/bridge/Kconfig
> >>> @@ -169,7 +169,7 @@ config DRM_SIL_SII8620
> >>>     tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >>>     depends on OF
> >>>     select DRM_KMS_HELPER
> >>> -   imply EXTCON
> >>> +   select EXTCON
> >>>     depends on RC_CORE || !RC_CORE
> >>>     help
> >>>       Silicon Image SII8620 HDMI/MHL bridge chip driver.
> >>
> >>
> >> Thanks. Works For Me.
> >>
> >> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> >
> > Actually I can upgrade that to:
> >
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> Hi,
> Is anyone merging this patch?
>
> thanks.
> --
> ~Randy
>
