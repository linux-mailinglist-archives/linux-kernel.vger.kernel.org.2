Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1075444DA52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhKKQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 11:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhKKQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:28:41 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A6DC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:25:52 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id r8so7613741iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRqJqxxlJwIYS/ddfWmMHHNu+A1m8d9KAG8ft6WQNF0=;
        b=XqMsalAhGNfKo2UQ15NOwdV10LFRX/uoJ6VsXV+BlFHTzxtfrp+8eIku4RA5nHMVXx
         9jvaPrDxo/eWbMVFOawlms6+NaGXadnzwLg6FXzlSSlmL4UjUZRUAsI9kymDAMNy/K8a
         8g9ksjnXnM+dZWUP+yDsT+8fZzkaeNl0xqZEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRqJqxxlJwIYS/ddfWmMHHNu+A1m8d9KAG8ft6WQNF0=;
        b=wv9z/YkRMgzYNgR0Rp64cSkmVgnFRqspvoyrlqIuNIOBXmTkTJzr0pKS6QUf0l0dBO
         EZus2wKPjkQzQ/F/gfEW/8bqcAf2GrIHsA9T8cIECEVWkRB4o06MzQ2/N+4hYRWdlo6r
         JKnpqMtPXSd/L+57qNeF/JWydEcf3k3QQf/uj2k0T9XeFxEV+VGas/acxXhYJIJazxr3
         NyFE5dQ4HhCyMGa6HNIkc2w6iPVdlLMBKJXX8amMG+tTIJGfZzhXPfXxO5ITeLanztLH
         RhcUSDzPg6dE/d+D6avIQKEhHN+CsisJmBXmMkwu9rzqrqT4onhBaK5lkB0OyzKmi7CO
         X/xw==
X-Gm-Message-State: AOAM530EGhTkyy2Tnr3+DliWjKAEVjexjctxt+DyFfzFHMmHB3KwEVWR
        eK+b+DYfjF83cubaGWpgKDlHsG2MDf2lLA==
X-Google-Smtp-Source: ABdhPJzsfwLABH0noL5eiV01ZCcXd1vU3redIx6vTOtHyy3jUKtg3HsPm3Cfp7t+ZcCwEWla7TExHg==
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr5912023iow.112.1636647952012;
        Thu, 11 Nov 2021 08:25:52 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id i4sm2169496ilv.15.2021.11.11.08.25.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 08:25:51 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id c3so7629108iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 08:25:51 -0800 (PST)
X-Received: by 2002:a05:6602:2d84:: with SMTP id k4mr5635223iow.168.1636647950862;
 Thu, 11 Nov 2021 08:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20211028105754.v5.1.I828f5db745535fb7e36e8ffdd62d546f6d08b6d1@changeid>
 <CA+cxXh=VOkRnkgfxq8DVes=xCvR=691eY-ViQxME2fHMgt1q8Q@mail.gmail.com> <CAD=FV=Vm1X3xFFkffigKr9z_FuTeA0Z70+_0NVfWcSZy90J-Zw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vm1X3xFFkffigKr9z_FuTeA0Z70+_0NVfWcSZy90J-Zw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Nov 2021 08:25:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XCLczUhVV7ZqOjCvParO9KO3e=0a3xLBWoTXW5KZczsQ@mail.gmail.com>
Message-ID: <CAD=FV=XCLczUhVV7ZqOjCvParO9KO3e=0a3xLBWoTXW5KZczsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 28, 2021 at 12:39 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Oct 28, 2021 at 11:02 AM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Add "Sam Ravnborg <sam@ravnborg.org>" to cc list for vis.
> > Remove "Andrzej Hajda <a.hajda@samsung.com>" from cc list as the
> > address can't be found.
>
> Looking at <https://lore.kernel.org/all/b2fb88db-009e-4b38-dc3d-5ce9163257de@samsung.com/>,
> it should be Andrzej Hajda <andrzej.hajda@intel.com>. I've added.
>
>
> > On Thu, Oct 28, 2021 at 10:58 AM Philip Chen <philipchen@chromium.org> wrote:
> > >
> > > Fit ps8640 driver into runtime power management framework:
> > >
> > > First, break _poweron() to 3 parts: (1) turn on power and wait for
> > > ps8640's internal MCU to finish init (2) check panel HPD (which is
> > > proxied by GPIO9) (3) the other configs. As runtime_resume() can be
> > > called before panel is powered, we only add (1) to _resume() and leave
> > > (2)(3) to _pre_enable(). We also add (2) to _aux_transfer() as we want
> > > to ensure panel HPD is asserted before we start AUX CH transactions.
> > >
> > > Second, the original driver has a mysterious delay of 50 ms between (2)
> > > and (3). Since Parade's support can't explain what the delay is for,
> > > and we don't see removing the delay break any boards at hand, remove
> > > the delay to fit into this driver change.
> > >
> > > In addition, rename "powered" to "pre_enabled" and don't check for it
> > > in the pm_runtime calls. The pm_runtime calls are already refcounted
> > > so there's no reason to check there. The other user of "powered",
> > > _get_edid(), only cares if pre_enable() has already been called.
> > >
> > > Lastly, change some existing DRM_...() logging to dev_...() along the
> > > way, since DRM_...() seem to be deprecated in [1].
> > >
> > > [1] https://patchwork.freedesktop.org/patch/454760/
> > >
> > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > > In v3, I added pm_suspend_ignore_children() in ps8640_probe().
> > > Also, I moved the change of "put_sync_suspend" from patch 2/2 to here.
> > > But I forgot to mention both changes. So edit v3 change log retroactively.
> > >
> > > In v4, I moved the change of "ps8640_ensure_hpd" return data type
> > > from patch 2/2 to here. But I forgot to mention it. So edit v4 change log
> > > retroactively.
> > >
> > > Changes in v5:
> > > - Move the implementation of _runtime_disable() around to resolve merge
> > >   conflict when rebasing.
> > > - Improve the document for how autosuspend_delay is picked.
>
> The new text looks good to me, thanks!
>
> Since this is from @chromium.org and only reviewed-by @chromium.org
> people, I'll plan to give it a 2-week snooze to give others ample time
> to comment on these two patches. If 2 weeks pass w/ no comments then
> I'll land to drm-misc-next. If someone gives an Ack and/or Reviewed-by
> then I'll likely land sooner.

My 2-week snooze went off, so this is now pushed to drm-misc-next
fixing a small whitespace warning that the dim tool complained about.

e9d9f9582c3d drm/bridge: parade-ps8640: Populate devices on aux-bus
826cff3f7ebb drm/bridge: parade-ps8640: Enable runtime power management

-Doug
