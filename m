Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08A843D65E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ0WPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhJ0WPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:15:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18770C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:13:07 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i26so4575946ila.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyCg7DiL988tpgR9pZu+L02w+APdAgTFVBDFz0gDAgw=;
        b=i+0qsvuAqhfM+m9wIh07yUq5Hr/REgcloxgOucORITFVq7b3BGWhHtzu2Y4U9zjDcb
         va+jlyOMZWhp1ohOcL33fMOlthu8T2HfRrfii2ToHajqftEeVC1Ryrrw0/RaLjhBY1fF
         zhmU94L2XVbNxtZ3SA9bQEr3IfCr7czPzZmCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyCg7DiL988tpgR9pZu+L02w+APdAgTFVBDFz0gDAgw=;
        b=Qwi5RgtlZhfC46XvtWwGZ+zv990vJul5YjqTwfKi4FV1mCRHCdz9HsSym3EtC8FkEF
         HnQokrUB+VBEmq88tDzmoJEGgqaEfJAlrPg98r4k5WE6TtFKaT4y73M74EtiK607AlgD
         4VUBYbvBMMjlNB9c/gR8FHSteapPyMBVp8y3+R4VTSbNDosDp9ZgPpefbTsBaVg/M4/P
         e4XjPtZV+8KkzzjFP0pkRAZ2fQgUg6A8JQSUQO57QjQuq5S8T6E1Exk2FGnoP8XuaSOa
         a7IwhcU+w8+jmdgldi8TpJL8bDRAv/2W5wXEWKszSmjMJF9XIFzC0eVax11MAf5+ETMQ
         dbXg==
X-Gm-Message-State: AOAM530HwTAHj2CbKNeaFoK3RxM+3t7wd6m5bjqfQ7eYEZSWDdq/vmBy
        Eqi2+a4mXStRx8ykbOUg5SvHT0MtHtFbCQ==
X-Google-Smtp-Source: ABdhPJzZTg4hbjjagLqK6e5k2lA67DWof8cXox0v1a1zwxNtmN0GzRRUf/wKIrGB0ftKqr8pfxaIlQ==
X-Received: by 2002:a05:6e02:1d99:: with SMTP id h25mr361727ila.29.1635372786329;
        Wed, 27 Oct 2021 15:13:06 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id n17sm571811ile.76.2021.10.27.15.13.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 15:13:05 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id l13so4644538ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:13:05 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr355037ilv.142.1635372785377;
 Wed, 27 Oct 2021 15:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211026145622.v4.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <20211026145622.v4.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid>
In-Reply-To: <20211026145622.v4.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Oct 2021 15:12:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLVf1yA_o+7wSmsybivBmcYDk96kTCOnVSx9myw4i_kQ@mail.gmail.com>
Message-ID: <CAD=FV=XLVf1yA_o+7wSmsybivBmcYDk96kTCOnVSx9myw4i_kQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

Hi,

On Tue, Oct 26, 2021 at 2:56 PM Philip Chen <philipchen@chromium.org> wrote:
>
> Conventionally, panel is listed under the root of the device tree.
> When userland asks for display mode, ps8640 bridge is responsible
> for returning EDID when ps8640_bridge_get_edid() is called.
>
> Now enable a new option of listing panel under "aux-bus" of ps8640
> bridge node in the device tree. In this case, panel driver can retrieve
> EDID by triggering AUX transactions, without ps8640_bridge_get_edid()
> calls at all.
>
> To prevent the "old" and "new" options from interfering with each
> other's logic flow, disable DRM_BRIDGE_OP_EDID when the new option
> is taken.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Fix when to call of_node_put() in ps8640_of_panel_on_aux_bus()
>
> Changes in v2:
> - Add of_node_put() calls in ps8640_of_panel_on_aux_bus()
> - Select DRM_DP_AUX_BUS for PS8640 driver in Kconfig
> - Replace _put_sync() with _put_sync_suspend() in ps8640_post_disable()

Not that it terribly matters, but I don't think the "put_sync" vs.
"put_sync_suspend" was in patch #2/2. It was in #1/2.


>  drivers/gpu/drm/bridge/Kconfig         |  1 +
>  drivers/gpu/drm/bridge/parade-ps8640.c | 51 ++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
