Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1936340CEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhIOVT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhIOVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:19:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9943C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:18:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y16so8612286ybm.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3veXBIZnvUKtnHxWTaozM/HSbOfDNjRTmGu3zb3EfU=;
        b=T2gxgE71iotL62qHgp9HhDUB18cqI7roSzz75Zt/y2U4xEJ+gNBwoTRJK6fDzLIAIX
         RMSQFGJ+pxrFbdf9ZY3FitomLZY9LNLGE8yn2O8bcOc0yghhvE2HbrS/zOxY95Gj44+L
         JtvaBq94TiQEVvSbsqv7I3jo4DXW9p2+ZwYUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3veXBIZnvUKtnHxWTaozM/HSbOfDNjRTmGu3zb3EfU=;
        b=Kdli6YCeAITKm4ke8DV0Cs1Bl/tYT7B6fQfITTRNUBNhhbs1W2aj54wit/qvEGAPXz
         zT5WJ8EOC0gCXE/MzwPcmHPmgyR3jFI+SBerBfDYbdcf6hW6Ukgu08g+PELln62qrc6X
         rIrCBNa2nHc5GaAboMYpupZ8jF4ZuO14UqLCkbTfVn2le028xqjAmuTbMhc5juDFXRkc
         +eV/pUWvAWabI0ek1RrcIEp2fK5Rmn+hNQaVEMBz9F7blBUiHt53KrJrHC7nPNnM13vE
         RpeMyJImxkxF5QYYLmOLoRXVc/R/7HNuYU13FP25RrJEB8b7MAGOohSUuiMLnzCTKjOr
         /Zxw==
X-Gm-Message-State: AOAM530Arq8bIJb2DoLFtsOCsU92oLV6LUIeuUMKipoq+b1314hcUHFq
        gbF9/rsMxmvkt5wAqnQcBmCxC0068dHFIVeJ2Nzfyg==
X-Google-Smtp-Source: ABdhPJwafmtANzZaofILn25DpwsrttNeT0o2NtqIHVBfMTOg9T5WN29WNXyWHOoiaGfXzSK3F5p308f7zEAXADaSQCo=
X-Received: by 2002:a25:b94:: with SMTP id 142mr2619354ybl.508.1631740718136;
 Wed, 15 Sep 2021 14:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210914162825.v3.1.I85e46da154e3fa570442b496a0363250fff0e44e@changeid>
 <20210914162825.v3.3.Ibf9b125434e3806b35f9079f6d8125578d76f138@changeid>
 <CAE-0n51JFM_yYdOsCQyvdMw5xXJ7REcbOJC6qi=6nfiNcdvnWw@mail.gmail.com>
 <CA+cxXhn-gLt37oyEq3wSh3qf=UkY=H6fY3ahC=gyhKhGwu_dXw@mail.gmail.com> <CAOMZO5B_J29npC+yu2freuwNLjKAmwas7gVaB6qRabAmVWy2KQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B_J29npC+yu2freuwNLjKAmwas7gVaB6qRabAmVWy2KQ@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Wed, 15 Sep 2021 14:18:26 -0700
Message-ID: <CA+cxXhnA5LV=E_rcaE=V=GerC=b53tMXHvq-pdtPm8JyEmvxzA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On Wed, Sep 15, 2021 at 2:00 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Sep 15, 2021 at 5:41 PM Philip Chen <philipchen@chromium.org> wrote:
>
> > As regmap_read() should always read 1 byte at a time, should I just do:
> > regmap_read(map, PAGE0_SWAUX_RDATA, (unsigned int*)(buf + i))
>
> There is also regmap_bulk_read() if you need to read more data.

Thanks for the review.
PAGE0_SWAUX_RDATA is a single-byte FIFO buffer.
So I'll need to read one byte at a time cyclically.
