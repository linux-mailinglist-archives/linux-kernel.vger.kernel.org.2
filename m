Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546E343E90C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJ1ToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1ToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:44:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200CBC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:41:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h81so827968iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4Eqbd0UGLUUWxA5kDPAWucE9MGTHM6kKCDv9lFpQAo=;
        b=ZBV7ZhlI78dRC+bco4/ReoNhTGvlsH3dlmb4b8tkYmoQR40VtpGyl3rO9lLluT08/3
         I1+iRYehy8hPfBvpRdXw/kUxwNcDxpWQpJJr3FhaaOYYcDF66H1RC0COvhTzh0+DG+8J
         mR12svkECRLtify/O0UOombQMN3VaHR6aoM0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4Eqbd0UGLUUWxA5kDPAWucE9MGTHM6kKCDv9lFpQAo=;
        b=rTzRjTVPC/9WJ5ZS791B/A3nwIQK/+Hg8dGMEIZmgf3LuEVaDIv8TyT7+zvhvSdwTs
         QGin4V7Vd/fmPm3c8J2rLWPqqyO1tdHSMuCME6T7dQ0Pduh1Jly6gkTh2ZrsBcpEamYl
         zNHXdoDSW8ZpZLch5HGhr+rr2+iPV2RqyhByduhEk8/9FVCA/BHAn6gDNBxqesXhdloM
         Ox7bTdI1Yo5jzAhNNN1ZnYuAUnhI3tc0eK/qNgiijxdqZIfbPIwO4SlRLSgQ2DTEoTD8
         w7HiK+f7nRmSxTkdlEvgY0svVaDwuP35F4R7uG/8UY5O1nZUG3W+TsWT3Wtg5OYQE5H8
         UQaQ==
X-Gm-Message-State: AOAM532l49jfJOr5gSNVwCFBW/nKrERXjUF5q5vz0AKnSjV3d4AVjZmg
        HwP35GOGTR7Ri3paLZttMBYKDM6zEXgZ7Q==
X-Google-Smtp-Source: ABdhPJxqxxK7pRuiP8CLUb8ceH6MHBNE2h3T5wOgzP5S5Bi5i3xbfUSArwmK2I9oSjlH8a59kgXrjw==
X-Received: by 2002:a5e:8805:: with SMTP id l5mr3370781ioj.150.1635450095372;
        Thu, 28 Oct 2021 12:41:35 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id m10sm2138468ila.13.2021.10.28.12.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 12:41:34 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id d63so9666272iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:41:33 -0700 (PDT)
X-Received: by 2002:a6b:e50f:: with SMTP id y15mr4362167ioc.177.1635450093365;
 Thu, 28 Oct 2021 12:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211028105754.v5.1.I828f5db745535fb7e36e8ffdd62d546f6d08b6d1@changeid>
 <20211028105754.v5.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid>
In-Reply-To: <20211028105754.v5.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Oct 2021 12:41:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VdybQftD90sZK36nFevkK2Et70KhTT96swi9WY0S-CEw@mail.gmail.com>
Message-ID: <CAD=FV=VdybQftD90sZK36nFevkK2Et70KhTT96swi9WY0S-CEw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 10:58 AM Philip Chen <philipchen@chromium.org> wrote:
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
> In v4, I factored out the "ps8640_ensure_hpd" change and added it to patch 1/2
> in this patch series. But I forgot to mention it in v4 change log. Edit v4
> change log retroactively.
>
> In v3, I factored out the "put_sync_suspend" change and added it to patch 1/2
> in this patch series. But I forgot to mention it in v3 change log. Edit v3
> change log retroactively.
>
> (no changes since v4)
>
> Changes in v4:
> - Move the change of "ps8640_ensure_hpd" to patch 1/2 in this patch series.
>
> Changes in v3:
> - Fix when to call of_node_put() in ps8640_of_panel_on_aux_bus()
> - Move the change of "put_sync_suspend" to patch 1/2 in this patch series.
>
> Changes in v2:
> - Add of_node_put() calls in ps8640_of_panel_on_aux_bus()
> - Select DRM_DP_AUX_BUS for PS8640 driver in Kconfig
>
>  drivers/gpu/drm/bridge/Kconfig         |  1 +
>  drivers/gpu/drm/bridge/parade-ps8640.c | 51 ++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 12 deletions(-)

Should have carried my tag from v4, but here it is again:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
