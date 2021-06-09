Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9309A3A1209
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhFILIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:08:15 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35626 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhFILIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:08:14 -0400
Received: by mail-lj1-f182.google.com with SMTP id n17so13982816ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VePCktjSiUwy7zF0X3i1kiD5uKEWitdsZcvT2ZeLJmk=;
        b=lCebyaKzT4o+/UcvZ1XICOmUN7/NHBX1soF6VpaCp/TCvgmk56jULiWBAvNk3i6Loj
         z5wJnqwqEEUANW+u3ygdh5BEaWLy9N8xhJu5CTPM9oqJnYdl30CwZZWEux+H+KOeGDDI
         ZwxIVZKMULaK7VsCRoihYTZ7UtCWnM65PGo6NHphuP4WS/bf4zw9cd5uz3z8exwr9+E+
         E0IPZfYfPD1onxv89/78rZD4LBFvbPBKfdvrtQUSz1tXKO9FIUkI8KHkdhFzDrpC0hZk
         00RJQFVtqyf2oOP2/m8/mM9pqWN6bbJzWLMo5fac27BiLh4WA2TgtZvcRfZEggy9XQoF
         IdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VePCktjSiUwy7zF0X3i1kiD5uKEWitdsZcvT2ZeLJmk=;
        b=QugmC3P4VDJPi64fbEJ/cbglpDeU49Q6TF/6dPnTHLUL5ReLzTByoscz6tQedsWkZl
         kYdRKE+nTzOIAI/mV6/7ym3yy2j+UijIrMpVN1IQCFgC7XJgHbhAk7QIiYxd9AE4v4Qr
         oWmCvTxOrK9YjcBpIGf5snLc3G26z0QxTC2l7n45jwgLUPxYmu+nD08AkR911kFxPFoI
         Qyp0+9qae5B7L9/M8T5zzIGtqKPRUN7QTJmx5XRYjW4+ywQ4a2ei9epBjKAy3Ta+biQ3
         g15sWM/Td7+md/TsxvabP/+PRSPRevyWtIPtdfoEuzmTYsh/RX6cRx39IEFZ40WhstDJ
         Eutw==
X-Gm-Message-State: AOAM532Dvl9YHEgJFW2IqodWaTcxy0Cc45d0l+btgxPaXwQVJMCw/YT4
        1C7oLORRmm82pjC6P0tjEv0Td2CzN2QNGtOprNgCWQ==
X-Google-Smtp-Source: ABdhPJybvThxOzTqKAq2tM0a2YQzhSX2mOBRONdPJcNN5UbQix2w4ogjAjPGxmyqXPR5egn25taCVXJw2O2j5xJPZ+4=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr21901557lji.326.1623236719658;
 Wed, 09 Jun 2021 04:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210607170555.4006050-1-dianders@chromium.org> <20210607100234.v9.2.Id3c048d22e72a9f90084a543b5b4e3f43bc9ab62@changeid>
In-Reply-To: <20210607100234.v9.2.Id3c048d22e72a9f90084a543b5b4e3f43bc9ab62@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:05:08 +0200
Message-ID: <CACRpkdaitO6VJGfmKchj5hLz43WNA6BR-mn=bo4_EPEh6fyLiw@mail.gmail.com>
Subject: Re: [PATCH v9 02/11] dt-bindings: drm: Introduce the DP AUX bus
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 7:06 PM Douglas Anderson <dianders@chromium.org> wrote:

> We want to be able to list an eDP panel as a child of an eDP
> controller node to represent the fact that the panel is connected to
> the controller's DP AUX bus. Though the panel and the controller are
> connected in several ways, the DP AUX bus is the primary control
> interface between the two and thus makes the most sense to model in
> device tree hierarchy.
>
> Listing a panel in this way makes it possible for the panel driver to
> easily get access to the DP AUX bus that it resides on, which can be
> useful to help in auto-detecting the panel and for turning on various
> bits.
>
> NOTE: historically eDP panels were _not_ listed under their controller
> but were listed at the top level of the device tree. This will still
> be supported for backward compatibility (and while DP controller
> drivers are adapted to support the new DT syntax) but should be
> considered deprecated since there is no downside to listing the panel
> under the controller.
>
> For now, the DP AUX bus bindings will only support an eDP panel
> underneath. It's possible it could be extended to allow having a DP
> connector under it in the future.
>
> NOTE: there is no "Example" in this bindings file. Yikes! This avoids
> duplicating the same example lots of places. See users of the aux bus
> (like ti-sn65dsi86) for examples.
>
> The idea for this bus's design was hashed out over IRC [1].
>
> [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2021-05-11
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

I overall like this approach a lot:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
