Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539EE43D68A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJ0W2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0W2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:28:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A69C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:25:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a6so10139017ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28Z1ip487G+5WNboKkQXwtJTmNJWpIkaerZw8He295s=;
        b=L2OI6mJpBFc2DBF3E3qwcgZkQJn5h+M8WbN+DgySTIa4e5rQcCUG8mQlCyIvPlTRKd
         lbLM0MLLm+OAWOpkGgHDRnqiy4JOmtwUIsknZMKznD2CO1HhiQERxOnqxrO5l26ZEwDQ
         UOEaupcd/MFtE/paXmhk+NNFFZpf7Jq6UpQ9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28Z1ip487G+5WNboKkQXwtJTmNJWpIkaerZw8He295s=;
        b=TLTAkPE29gQ/84dpCgtIQ+o8qD2DUl3J/qUa0kDMrt7WO+a5xoeE2spyoWtMTC/75Z
         +9GhPdPS5pT4/WOPi/4n8sk1BAcNosUwfGbGTdteupobgma0i9QH+kwjJu+r3mtia7Ov
         SQqy4s5qhKzyLxO0kaZhBLbtlTY/03hCNtooAK0xEcZ5jIi6XcM2vBe9OEnhvCXI5k8X
         sjKyfrEk6dbMemI00NonrBkqzyA4huMt9j10sWLqM+HrzRylh1Tf2i0RHvffTbUIKVrD
         BCkoe7C9OGhu9ipiXbRStBrj3ib2W3siqDhtEdxJWMW88XOs4W4x8Ldffzy+zyqmkJKh
         cr4Q==
X-Gm-Message-State: AOAM532rRLp+WJiow4CIEbpBrWz9Rry3LcfyoCvGDat0/BJ9fpBNUrTO
        Nx6aHbC8K07WKViQ7fZs9n9WYJpXSozKhfQMynMm1fYkP2c=
X-Google-Smtp-Source: ABdhPJwIOsNI24n/ZGqqvjt3SK2CMqFxEG/4NgrdffKeK88P6V4tOPE8YLaGoKaZUod5VhbYU2QWrCS8EGHExGhXd/U=
X-Received: by 2002:a25:cf07:: with SMTP id f7mr499513ybg.100.1635373554560;
 Wed, 27 Oct 2021 15:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211026145622.v4.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <20211026145622.v4.2.I09899dea340f11feab97d719cb4b62bef3179e4b@changeid> <CAD=FV=XLVf1yA_o+7wSmsybivBmcYDk96kTCOnVSx9myw4i_kQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XLVf1yA_o+7wSmsybivBmcYDk96kTCOnVSx9myw4i_kQ@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Wed, 27 Oct 2021 15:25:43 -0700
Message-ID: <CA+cxXhns12w=EiswKE-MgV2ehzPk6gBV-mL73GrvW0VirV011A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/bridge: parade-ps8640: Populate devices on aux-bus
To:     Doug Anderson <dianders@chromium.org>
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

Hi Doug

On Wed, Oct 27, 2021 at 3:13 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Oct 26, 2021 at 2:56 PM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Conventionally, panel is listed under the root of the device tree.
> > When userland asks for display mode, ps8640 bridge is responsible
> > for returning EDID when ps8640_bridge_get_edid() is called.
> >
> > Now enable a new option of listing panel under "aux-bus" of ps8640
> > bridge node in the device tree. In this case, panel driver can retrieve
> > EDID by triggering AUX transactions, without ps8640_bridge_get_edid()
> > calls at all.
> >
> > To prevent the "old" and "new" options from interfering with each
> > other's logic flow, disable DRM_BRIDGE_OP_EDID when the new option
> > is taken.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - Fix when to call of_node_put() in ps8640_of_panel_on_aux_bus()
> >
> > Changes in v2:
> > - Add of_node_put() calls in ps8640_of_panel_on_aux_bus()
> > - Select DRM_DP_AUX_BUS for PS8640 driver in Kconfig
> > - Replace _put_sync() with _put_sync_suspend() in ps8640_post_disable()
>
> Not that it terribly matters, but I don't think the "put_sync" vs.
> "put_sync_suspend" was in patch #2/2. It was in #1/2.
Oops, sorry, I did a terrible job separating the changes between patch
#1/2 and #2/2.
Will retroactively fix v2 change log when I post v5.

>
>
> >  drivers/gpu/drm/bridge/Kconfig         |  1 +
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 51 ++++++++++++++++++++------
> >  2 files changed, 40 insertions(+), 12 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
