Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012F7389860
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhESVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhESVHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:07:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EEBC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:06:29 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so13000053otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrV0j7YUVvQ9ro0u0QUGjNvrEZGZrHvU5ryrt5YfeRs=;
        b=U1IFwZKjSALWLmQnkWT+FZ6THaCzRnuvs9LNdLOH1gdUwrJcSljJp2mdbv0j0f67Hp
         GGdvJkHB5QAc8gaH+BnQ61h+VgY4bkBdafPs/9u0BfMU7hzI8Ot6rMCdrAdfNeTZVI21
         wip7kua1Tq13mnLBds/XBerje9kPZExpHBe5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrV0j7YUVvQ9ro0u0QUGjNvrEZGZrHvU5ryrt5YfeRs=;
        b=VSO1jvSws2LZkKC3diqefMJDQISLSGL7l7U0n4L+kcFzpGxGYvUQAebMKIB9hrb+zr
         50i+HsDTL8mGictRXEOhpALtQ/yZtz14onRFonmLwdKmOiQOgSrhojeClD9gGad/H66D
         OwTFnSUskBQr4QJRVCZUZcpk1MYXYEEbFf41Zgi07Xjf6sfHNLIb+9XYjExniwrfBM30
         nRX4uQ8xaYBprznh3dtaKHCbNL/FHemesAemZWaI6jm9rNGc6F68V3tPwiBMLyp46zBn
         VL2ZwDk92/E29avSuhY8PqFJWZTsHvG/2F44JUcfzZIpvJvUDJmDx0SnmfXAFk8pHM2Y
         hynA==
X-Gm-Message-State: AOAM533kYBtdMrxyDPFzbj7DlgbfaHb8E4Bqcr6s+MFyttfSLE8CcxoS
        tbkoI1W++XKxKy3y//6kW7VEUThhuYJdzg==
X-Google-Smtp-Source: ABdhPJzzBdb25XtuO4ZBkd3UVnudV8IdQW+O9+DPK7YL9HMrj0I78n8VkaQHso2Fo7VQQEyafTvflA==
X-Received: by 2002:a05:6830:1e3b:: with SMTP id t27mr1209546otr.243.1621458388147;
        Wed, 19 May 2021 14:06:28 -0700 (PDT)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id w66sm107221ooa.37.2021.05.19.14.06.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 14:06:28 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id f22-20020a4aeb160000b029021135f0f404so258653ooj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:06:28 -0700 (PDT)
X-Received: by 2002:a25:734e:: with SMTP id o75mr2168098ybc.405.1621458376733;
 Wed, 19 May 2021 14:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210517200907.1459182-1-dianders@chromium.org>
 <20210517130450.v7.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid> <20210519200156.GA3535665@robh.at.kernel.org>
In-Reply-To: <20210519200156.GA3535665@robh.at.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 May 2021 14:06:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNaB8fVvwwHPgo8wPmG3EmJ68u_3o8qpPXn4YobNokAA@mail.gmail.com>
Message-ID: <CAD=FV=XNaB8fVvwwHPgo8wPmG3EmJ68u_3o8qpPXn4YobNokAA@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] dt-bindings: drm/bridge: ti-sn65dsi86: Add
 aux-bus child
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus W <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 19, 2021 at 1:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 17, 2021 at 01:09:00PM -0700, Douglas Anderson wrote:
> > We want to be able to list an eDP panel as a child of a ti-sn65dsi86
> > node to represent the fact that the panel is connected to the bridge's
> > DP AUX bus. Though the panel and the bridge chip are connected in
> > several ways, the DP AUX bus is the primary control interface between
> > the two and thus makes the most sense to model in device tree
> > hierarchy.
> >
> > Listing a panel in this way makes it possible for the panel driver to
> > easily get access to the DP AUX bus that it resides on, which can be
> > useful to help in auto-detecting the panel and for turning on various
> > bits.
> >
> > NOTE: it's still possible to continue using the bridge chip and point
> > to a panel that _isn't_ listed as a child of the bridge chip (since
> > it's worked that way previously), but that should be deprecated since
> > there is no downside to listing the panel under the bridge chip.
> >
> > The idea for this bus's design was hashed out over IRC [1].
> >
> > [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2021-05-11
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Possibly we might want something fancier that could be included by
> > other eDP controller bindings. If we want to do this, I'd love to be
> > pointed at a good example to follow.
> >
> > Changes in v7:
> > - ti-sn65dsi86: Add aux-bus child patch new for v7.
> >
> >  .../bindings/display/bridge/ti,sn65dsi86.yaml | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > index 26932d2e86ab..51f5a29e216c 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > @@ -70,6 +70,11 @@ properties:
> >      const: 1
> >      description: See ../../pwm/pwm.yaml for description of the cell formats.
> >
> > +  aux-bus:
>
> As this is a node:
>
> type: object
>
> > +    description:
> > +      It is recommended that you place your panel under the aux-bus node
> > +      here to represent the control hierarchy.
> > +
> >    ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >
> > @@ -201,11 +206,26 @@ examples:
> >
> >            port@1 {
> >              reg = <1>;
> > -            endpoint {
> > +            sn65dsi86_out: endpoint {
> >                remote-endpoint = <&panel_in_edp>;
> >              };
> >            };
> >          };
> > +
> > +        aux-bus {
> > +          panel {
>
> We should perhaps have a separate aux-bus schema.

Yeah. Before spending lots of time digging into how to do this I
wanted to see if anyone was going to give me a big-old NAK on the
whole approach. ;-)

I guess I'd make a file called "dp-aux-bus.yaml" (maybe right under
bindings/display?) and then I'd include it like this:

aux-bus:
  $ref: "../dp-aux-bus.yaml#"


> Something should
> define the child node is 'panel' and nothing else.

At the moment the code also requires that the node name is 'aux-bus'.
Any objections to that?


> Though perhaps
> connectors are valid too?

They might be. We could always add it later?
