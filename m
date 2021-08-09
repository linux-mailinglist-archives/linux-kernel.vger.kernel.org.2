Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21A93E4F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhHIWVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhHIWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:21:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E5C061798
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:20:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l3so5471967qtk.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Za9sG3xavNdXyC/5nel3LftkdoSVz3OXIotst/1d2UE=;
        b=mya59Hb2zQ0XRhqzkfHfC3tVam78Q1XZmhcb1qmWvSNp9iSBoZR9mpsmpXX05VjvY2
         3pTG8lDVTK22CyYEIUtEZ4Y/cJbBUTA7Yrq71gOAF3wzPmGUfEwL7GQTQao5TtZ16D20
         vXedsKNAiRkT8/ZNnGnE2ed4lR1IzuLIsCOns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Za9sG3xavNdXyC/5nel3LftkdoSVz3OXIotst/1d2UE=;
        b=UkhbOTcWBGA86qy+KXRnbkaNyL/WVVpsnrryOjY8uQYV7crEgKT+8Si45TzBIqQlny
         p0WVpJ05Yy6+1vd2BwFUhgBjBu/z4PLZJOLz0UTPOmnDdKvHRJzUhPui4xs+p+GdGZRD
         tkIOPDpU9UbtMHIP4PwMCIWXrCM0yg5R/9BrCVmgHWf9Vm5zxIqjUO+VSF2oKTFUE9pW
         auUB8kFPLcpHOPqGSsEz2PS25M6GMJ/8ctg8MkRALqcv/Nt3Ncb6scRuDTTge7VpT8OL
         4ZpMTRcqSm0iQ1xaILCNTlGLKR/wxj04g+tlvdsZAKNXhkyfPKn94vHiAE1iFm/V+Fn0
         3IzQ==
X-Gm-Message-State: AOAM533t1eA4qeETaXB8ce/8TsNNpoK2iONmyEgzGT983B3W+1bRHsjH
        4HzK2XKxB5s91QdLz8naSB1p6Xq1Pc64Sw==
X-Google-Smtp-Source: ABdhPJyV4ZElsfTMtnWJoJx4YSx0HihniQD3gqQPL9A/TTArmI93O/+u9au9nfW7rSFvQRfrmUJ1fA==
X-Received: by 2002:ac8:7207:: with SMTP id a7mr22320689qtp.32.1628547656000;
        Mon, 09 Aug 2021 15:20:56 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id y26sm187273qkm.65.2021.08.09.15.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 15:20:55 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id p145so32392520ybg.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:20:54 -0700 (PDT)
X-Received: by 2002:a25:81ce:: with SMTP id n14mr36257135ybm.32.1628547654476;
 Mon, 09 Aug 2021 15:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210730212625.3071831-1-dianders@chromium.org>
 <20210730142537.v2.1.I1116e79d34035338a45c1fc7cdd14a097909c8e0@changeid> <1627911583.050984.918758.nullmailer@robh.at.kernel.org>
In-Reply-To: <1627911583.050984.918758.nullmailer@robh.at.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Aug 2021 15:20:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U63qGf+RTOe=X+BYK06OuJM5N5Vy6zcA8+7ka1CFLwcg@mail.gmail.com>
Message-ID: <CAD=FV=U63qGf+RTOe=X+BYK06OuJM5N5Vy6zcA8+7ka1CFLwcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: drm/panel-simple: Introduce generic
 eDP panels
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Linus W <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 2, 2021 at 6:39 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 30 Jul 2021 14:26:20 -0700, Douglas Anderson wrote:
> > eDP panels generally contain almost everything needed to control them
> > in their EDID. This comes from their DP heritage were a computer needs
> > to be able to properly control pretty much any DP display that's
> > plugged into it.
> >
> > The one big issue with eDP panels and the reason that we need a panel
> > driver for them is that the power sequencing can be different per
> > panel.
> >
> > While it is true that eDP panel sequencing can be arbitrarily complex,
> > in practice it turns out that many eDP panels are compatible with just
> > some slightly different delays. See the contents of the bindings file
> > introduced in this patch for some details.
> >
> > The fact that eDP panels are 99% probable and that the power
> > sequencing (especially power up) can be compatible between many panels
> > means that there's a constant desire to plug multiple different panels
> > into the same board. This could be for second sourcing purposes or to
> > support multiple SKUs (maybe a 11" and a 13", for instance).
> >
> > As discussed [1], it should be OK to support this by adding two
> > properties to the device tree to specify the delays needed for
> > powering up the panel the first time. We'll create a new "edp-panel"
> > bindings file and define the two delays that might need to be
> > specified. NOTE: in the vast majority of the cases (HPD is hooked up
> > and isn't glitchy or is debounced) even these delays aren't needed.
> >
> > [1] https://lore.kernel.org/r/CAD=FV=VZYOMPwQZzWdhJGh5cjJWw_EcM-wQVEivZ-bdGXjPrEQ@mail.gmail.com
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - No longer allow fallback to panel-simple.
> > - Add "-ms" suffix to delays.
> >
> >  .../bindings/display/panel/panel-edp.yaml     | 188 ++++++++++++++++++
> >  1 file changed, 188 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/panel-edp.example.dt.yaml: bridge@2d: 'aux-bus' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> \ndoc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1511822
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.

I think it's a dependency problem. No hits here:

git grep aux-bus v5.14-rc5 -- Documentation/devicetree/bindings/

...but I get hits against "linuxnext". Rob: I'm hoping that this can
still be in your queue for review even with the bot warning. Thanks!
:-)

-Doug
