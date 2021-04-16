Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4087F362BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhDPXDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhDPXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:03:25 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:03:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d23so18510887qko.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2TYM+wdp6+vDu4GYyPIj8WsiphUkb2AvhRdqqeeoy0=;
        b=Jrf5W3Bx2YFA/wzMJQ4naBpogVfH2bAOaRDsvRP+wQCyW65LnEFXDogl9l/5ok/Y+d
         HKuhWhsbxsOZ3HbwY6lDvjJuo+jYbjpbbe/Bqt6o3yHBZPTrgvTmnqrZkXu7zDf4Ocx9
         AXFe6MfdwJicBmuEKIBtdvCrHkcK8pWB9JXJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2TYM+wdp6+vDu4GYyPIj8WsiphUkb2AvhRdqqeeoy0=;
        b=mtWWg2FEWLm4x81gN995gzyO9YFuAdgeeZvZCsZ9uCva85KwBsQtEwusgQtMpbOcWY
         BKKOTLg/rETVSe86OApqVRscBvfIZ8PAvjg1672SEfEhx8FP8NFqQUsFfPnJQGTwnW9t
         WHKbahwINg7ooS8H05maPJOpe3JIi7ddmxFvtMsQA1QHZceoKWxlX4OLT1vCCC6TytyI
         lNHJ4C8A57P77W8HZ0ASnQcVNOmQke6SGd2H5rha0hSAL26OxraZ/KRWUieXGgNRMZBU
         AfZ2gt+JLqn2otCpzA9kp+93g4DUQVDd3HbBYXiOMcHjHTpA7+XMlwIVp63IVU+jdpiK
         mIxA==
X-Gm-Message-State: AOAM530Hm0RSvFk7gulPZxfjtk4dzrn4zR0bt6Zo5rx4vtL8RcGWbA0M
        YuGeN7QQVKg+vqA4g1uzXHqpFU2Mx5SGUg==
X-Google-Smtp-Source: ABdhPJxhbehAL0E6hqdcggjHna81zE+gzXlAQfifzUzXVUl5Q38yJqJG8lUZnL2GyViW0c9ibq4VMA==
X-Received: by 2002:a37:a854:: with SMTP id r81mr519922qke.350.1618614176108;
        Fri, 16 Apr 2021 16:02:56 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l16sm5163970qkg.91.2021.04.16.16.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 16:02:55 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id o10so31833143ybb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:02:55 -0700 (PDT)
X-Received: by 2002:a25:244d:: with SMTP id k74mr2023484ybk.79.1618614174530;
 Fri, 16 Apr 2021 16:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <1618418390-15055-1-git-send-email-rajeevny@codeaurora.org>
In-Reply-To: <1618418390-15055-1-git-send-email-rajeevny@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Apr 2021 16:02:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSjRhNk_VT9vXEpzO=7pKi3VJG+SB7wnZnKZjeD+UsZg@mail.gmail.com>
Message-ID: <CAD=FV=WSjRhNk_VT9vXEpzO=7pKi3VJG+SB7wnZnKZjeD+UsZg@mail.gmail.com>
Subject: Re: [v1 0/3] drm: Add support for backlight control of eDP panel on
 ti-sn65dsi86 bridge
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, mkrishn@codeaurora.org,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 14, 2021 at 9:41 AM Rajeev Nandan <rajeevny@codeaurora.org> wrote:
>
> The backlight level of an eDP panel can be controlled through the AUX
> channel using DPCD registers of the panel.
>
> The capability for the Source device to adjust backlight characteristics
> within the panel, using the Sink device DPCD registers is indicated by
> the TCON_BACKLIGHT_ADJUSTMENT_CAPABLE bit in the EDP_GENERAL_CAPABILITY_1
> register (DPCD Address 701h, bit0). In this configuration, the eDP TCON
> receives the backlight level information from the host, through the AUX
> channel.
>
> The changes in this patch series do the following:
> - Add drm_dp_aux_backlight_ APIs to support backlight control using DPCD
>   registers on the DisplayPort AUX channel.
>   The current version only supports backlight brightness control by the
>   EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB registers (DPCD Addresses 722h-723h).
> - Add support for backlight control of the eDP panel connected to the
>   ti-sn65dsi86 bridge.
>
> Rajeev Nandan (3):
>   drm/dp: Add DisplayPort aux backlight control support
>   dt-bindings: drm/bridge: ti-sn65dsi86: Document use-aux-backlight
>   drm/bridge: ti-sn65dsi86: Add DisplayPort aux backlight support
>
>  .../bindings/display/bridge/ti,sn65dsi86.yaml      |   8 +
>  drivers/gpu/drm/Kconfig                            |   8 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/bridge/Kconfig                     |   1 +
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  26 +++
>  drivers/gpu/drm/drm_dp_aux_backlight.c             | 191 +++++++++++++++++++++
>  include/drm/drm_dp_aux_backlight.h                 |  29 ++++
>  7 files changed, 264 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_dp_aux_backlight.c
>  create mode 100644 include/drm/drm_dp_aux_backlight.h

So I haven't looked in massive detail at this patch series, but the
fact that it's touching "ti-sn65dsi86.c" is a red flag. I know in
out-of-band communications you said you weren't sure how to do better.
...but, perhaps, if folks don't hate my recent series [1] there may be
a way forward.

I wonder if perhaps now that the AUX channel can be registered early
if it gets around the circular dependency problems and now you can put
your code in some combination of the panel code and (maybe?) a new
backlight driver if it's generic enough.

It's possible that you might need to add some code to be able to look
up a "struct drm_dp_aux *" from a device tree node and you might need
to add a new device tree property like "ddc-aux-bus" in order to do
this, but I don't _think_ that would be controversial?

[1] https://lore.kernel.org/r/20210416223950.3586967-1-dianders@chromium.org

-Doug
