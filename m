Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB141F6DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355313AbhJAVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJAVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:25:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04662C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 14:23:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y201so13072848oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQO+lMXU6VmqpbbuMNNIj4s/iSRqxxtzgzbizBnbLmk=;
        b=iSh459FN5Z6Hqy9OYQZTytx3xm7vgeROeRrUA3KkjbSpJr6gHBeJtPg+IG1UktWtKi
         j0nWzggnhcvpJsq6Oc90kySnuaUsE8mLUC3eHw503Ya41vqpbvJSsWuEN9YKwUQQAQ2f
         ku+ZlpxCosstDPHAfe22bGGCKuGlOe0VgHbA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQO+lMXU6VmqpbbuMNNIj4s/iSRqxxtzgzbizBnbLmk=;
        b=R/Nzw/uT/h1Pk6uOKoWjKo0z6uWKNvvTGqkP67Zdutclmux/l/+k8APBxsfWexzEHW
         nd+e0smqUksVaLqAKGYrGMh+lfpuhTlXXu5u82PaYbFmkIGida5isdklbxZaGPZIIR7u
         PuGlO5wbyrpWbJHc0rgYldVMn+K19KEgCmN0Wor886UUl+JVqP07hlWcnTXHu2eZpAcw
         0QrhzfhaMMG9gr4wpMxu3GXDQ7Y32W7bIwRm8YZS1jSu9Cs4UIH2BcVZyWzi2Lo1IBtd
         9GNKRNMCeGbSLcMv3ErkA/w69LwTJwk935BwQMOb/0dy/dkNLVAWQv/Latvg5w3bKSGz
         tObw==
X-Gm-Message-State: AOAM53279aX51HkPmPw2Il8jIcgldn17hoOyGq/zfy73FlJ0d/n1zhf4
        5qk4Bi87b1iUTPXBKW+7B0idMf1YfT2vqw==
X-Google-Smtp-Source: ABdhPJzoXKSD7GnXNwekmzN1vF9nzp5Fn7gk8Yq+LNe5IsdT/t4pXeUpEgtwGBRsTSQxfyqgLKjNlg==
X-Received: by 2002:aca:d988:: with SMTP id q130mr5423773oig.148.1633123421883;
        Fri, 01 Oct 2021 14:23:41 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id w2sm1370690oof.23.2021.10.01.14.23.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 14:23:41 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so13121511otb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:23:41 -0700 (PDT)
X-Received: by 2002:a05:6830:112:: with SMTP id i18mr82821otp.186.1633123420525;
 Fri, 01 Oct 2021 14:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144010.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
 <20211001203722.GZ2515@art_vandelay>
In-Reply-To: <20211001203722.GZ2515@art_vandelay>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 1 Oct 2021 14:23:29 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNqwGWLHV5sPeUebd1AzPzLJva5hWm-385A+5vgQYMvVQ@mail.gmail.com>
Message-ID: <CA+ASDXNqwGWLHV5sPeUebd1AzPzLJva5hWm-385A+5vgQYMvVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/brdige: analogix_dp: Grab runtime PM reference for DP-AUX
To:     Sean Paul <sean@poorly.run>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        stable <stable@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 1:37 PM Sean Paul <sean@poorly.run> wrote:
> On Wed, Sep 29, 2021 at 02:41:03PM -0700, Brian Norris wrote:
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -1632,8 +1632,23 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
> >                                      struct drm_dp_aux_msg *msg)
> >  {
> >       struct analogix_dp_device *dp = to_dp(aux);
> > +     int ret, ret2;
> >
> > -     return analogix_dp_transfer(dp, msg);
> > +     ret = analogix_dp_prepare_panel(dp, true, false);
> > +     if (ret) {
> > +             DRM_DEV_ERROR(dp->dev, "Failed to prepare panel (%d)\n", ret);
>
> s/DRM_DEV_ERROR/drm_err/

Sure. Now that I'm looking a second time, I see the header recommends this.

> > +             return ret;
> > +     }
> > +
> > +     pm_runtime_get_sync(dp->dev);
> > +     ret = analogix_dp_transfer(dp, msg);
> > +     pm_runtime_put(dp->dev);
> > +
> > +     ret2 = analogix_dp_prepare_panel(dp, false, false);
> > +     if (ret2)
> > +             DRM_DEV_ERROR(dp->dev, "Failed to unprepare panel (%d)\n", ret2);
>
> What's the reasoning for not propagating unprepare failures? I feel like that
> should be fair game.

I suppose the underlying reason is laziness, sorry. But a related
reason is the we probably should prefer propagating the
analogix_dp_transfer() error, if it's non-zero, rather than the
unprepare error. That's not too hard to do though, even if it's
slightly more awkward.

> > +
> > +     return ret;
> >  }
> >
> >  struct analogix_dp_device *

v2 coming.

Regards,
Brian
