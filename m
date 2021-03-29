Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C034D466
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhC2P7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhC2P6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:58:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342AEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:58:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w70so13576138oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3qjU94W0m6oCH9pAstUGYT+pDFUIdoKlke6iELSfpY=;
        b=MDFfvvLK5Mx5KUuybyKzi3JYBXVAPMFnhownMqnpXnf9cddYVDT8Mz03muUdRBLo89
         uVbTmHZ8ghNE0VAFQJE+zzIJqs19cYYVum6SB0+TqEMF6sGQAUuwmCVy/5oleHnMdmOo
         x0j9UsokM8EVvQh7KoCTOMRR+duh6+xxvWv08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3qjU94W0m6oCH9pAstUGYT+pDFUIdoKlke6iELSfpY=;
        b=ZeFBvk13vVX8NebhLE5+NiLAB8+1Cv9pSbiyScEvjpbeD4zOkowdinl+IKJ5QSANbV
         dzEJtZVjG+Ss4x7bj94WEobwBiCsh4u1tvuJXwiCwTTZh4hLTcbJswy6iouRHQPUpVTR
         b7AyrHUP6OnqKJlonznwGlQ/bEtwEtEp5RBrquFX8t1RGDXz3MAUrg6rgKP/TrDoPgpu
         FpmhwGJJNINOrkJ3rJUiZUCVmrZhqZlj96HyXnrbfS2PGAvfn8IZx+PnrfBWciFUdwsB
         MU14cOv4LQhgTFYdrLRQF7USJPvgNvv+eHm/HvxaoxNzgsieM1AawXkTvWiobHkwn8RU
         ESTw==
X-Gm-Message-State: AOAM533XQyt4h1CXIbydpnLQI9seVYmamJPF3dPOxRsaQl2OjuldnIbl
        1S7vowZ5fVGlXYto/V1ODkJKGZOgUVweSQ==
X-Google-Smtp-Source: ABdhPJxMAnUduv3jtst6umag7+NwFCX458kEU6d8GNhAHo9PrLGs+DheAsOspOaj3cHaHYAaa+c3qQ==
X-Received: by 2002:a54:458b:: with SMTP id z11mr18803418oib.69.1617033531384;
        Mon, 29 Mar 2021 08:58:51 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id v1sm3840879ooh.3.2021.03.29.08.58.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:58:51 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso12739646otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:58:51 -0700 (PDT)
X-Received: by 2002:a25:4092:: with SMTP id n140mr29624662yba.276.1617033111899;
 Mon, 29 Mar 2021 08:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
 <YFKQaXOmOwYyeqvM@google.com> <CAF6AEGtu+GBwYfkH3x=UuPs5Ouj0TxqbVjpjFEtMKKWvd1-Gbg@mail.gmail.com>
 <YF3V8d4wB6i81fLN@orome.fritz.box> <CAF6AEGvS6Pnd-m-boqPEZdDY+VCkV5M8Ob9n6UiYWs_DxrPopQ@mail.gmail.com>
 <CAF6AEGvPN90RGP8hYXtAksJpGc4Sf5tRpNwNnV6=sxKei0Ms6A@mail.gmail.com> <CAL_JsqKk+c83GMRzpc11Naj7QDYSfHdrg-8ZnxRBBM4phemQxg@mail.gmail.com>
In-Reply-To: <CAL_JsqKk+c83GMRzpc11Naj7QDYSfHdrg-8ZnxRBBM4phemQxg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Mar 2021 08:51:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPdFzv0gTqOjJ4z9b8EKc+G4ikt0KmDOz+MA4DYvoyaw@mail.gmail.com>
Message-ID: <CAD=FV=VPdFzv0gTqOjJ4z9b8EKc+G4ikt0KmDOz+MA4DYvoyaw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: simple: Add the panel on sc7180-trogdor-pompom
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 26, 2021 at 12:48 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 9:20 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Fri, Mar 26, 2021 at 8:18 AM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > On Fri, Mar 26, 2021 at 5:38 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 17, 2021 at 06:53:04PM -0700, Rob Clark wrote:
> > > > > On Wed, Mar 17, 2021 at 4:27 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > >
> > > > > > On Tue, Mar 16, 2021 at 02:08:19PM -0700, Douglas Anderson wrote:
> > > > > > > The sc7180-trogdor-pompom board might be attached to any number of a
> > > > > > > pile of eDP panels. At the moment I'm told that the list might include:
> > > > > > > - KD KD116N21-30NV-A010
> > > > > > > - KD KD116N09-30NH-A016
> > > > > > > - Starry 2081116HHD028001-51D
> > > > > > > - Sharp LQ116M1JW10
> > > > > > >
> > > > > > > It should be noted that while the EDID programmed in the first 3
> > > > > > > panels indicates that they should run with exactly the same timing (to
> > > > > > > keep things simple), the 4th panel not only needs different timing but
> > > > > > > has a different resolution.
> > > > > > >
> > > > > > > As is true in general with eDP panels, we can figure out which panel
> > > > > > > we have and all the info needed to drive its pixel clock by reading
> > > > > > > the EDID. However, we can do this only after we've powered the panel
> > > > > > > on. Powering on the panels requires following the timing diagram in
> > > > > > > each panel's datasheet which specifies delays between certain
> > > > > > > actions. This means that, while we can be quite dynamic about handling
> > > > > > > things we can't just totally skip out on describing the panel like we
> > > > > > > could do if it was connected to an external-facing DP port.
> > > > > > >
> > > > > > > While the different panels have slightly different delays, it's
> > > > > > > possible to come up with a set of unified delays that will work on all
> > > > > > > the panels. From reading the datasheets:
> > > > > > > * KD KD116N21-30NV-A010 and KD KD116N09-30NH-A016
> > > > > > >   - HPD absent delay: 200 ms
> > > > > > >   - Unprepare delay: 150 ms (datasheet is confusing, might be 500 ms)
> > > > > > > * Starry 2081116HHD028001-51D
> > > > > > >   - HPD absent delay: 100 ms
> > > > > > >   - Enable delay: (link training done till enable BL): 200 ms
> > > > > > >   - Unprepare delay: 500 ms
> > > > > > > * Sharp LQ116M1JW10
> > > > > > >   - HPD absent delay: 200 ms
> > > > > > >   - Unprepare delay: 500 ms
> > > > > > >   - Prepare to enable delay (power on till backlight): 100 ms
> > > > > > >
> > > > > > > Unified:
> > > > > > > - HPD absent delay: 200 ms
> > > > > > > - Unprepare delay: 500 ms
> > > > > > > - Enable delay: 200 ms
> > > > > > >
> > > > > > > NOTE: in theory the only thing that we _really_ need unity on is the
> > > > > > > "HPD absent delay" since once the panel asserts HPD we can read the
> > > > > > > EDID and could make per-panel decisions if we wanted.
> > > > > > >
> > > > > > > Let's create a definition of "a panel that can be attached to pompom"
> > > > > > > as a panel that provides a valid EDID and can work with the standard
> > > > > > > pompom power sequencing. If more panels are later attached to pompom
> > > > > > > then it's fine as long as they work in a compatible way.
> > > > > > >
> > > > > > > One might ask why we can't just use a generic string here and provide
> > > > > > > the timings directly in the device tree file. As I understand it,
> > > > > > > trying to describe generic power sequencing in the device tree is
> > > > > > > frowned upon and the one instance (SD/MMC) is regarded as a mistake
> > > > > > > that shouldn't be repeated. Specifying a power sequence per board (or
> > > > > > > per board class) feels like a reasonable compromise. We're not trying
> > > > > > > to define fully generic power sequence bindings but we can also take
> > > > > > > advantage of the semi-probable properties of the attached device.
> > > > > > >
> > > > > > > NOTE: I believe that past instances of supporting this type of thing
> > > > > > > have used the "white lie" approach. One representative panel was
> > > > > > > listed in the device tree. The power sequencings of this
> > > > > > > representative panel were OK to use across all panels that might be
> > > > > > > attached and other differences were handled by EDID. This patch
> > > > > > > attempts to set a new precedent and avoid the need for the white lie.
> > > > > > >
> > > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > > > ---
> > > > > >
> > > > > > Sounds reasonable to me if DT maintainers can live with this abstract
> > > > > > hardware definition. It's clearer than the 'white lie' approach.
> > > > >
> > > > > Yeah, it is a weird grey area between "discoverable" and "not
> > > > > discoverable".. but I favor DT reflecting reality as much as
> > > > > possible/feasible, so I think this is definity cleaner than "white
> > > > > lies"
> > > >
> > > > This is practically no different than the "white lie". I suppose you
> > > > could perhaps call it "more honest", if you want.
> > > >
> > > > The point remains that unless we describe exactly which panel we're
> > > > dealing with, we ultimately have no way of properly quirking anything if
> > > > we ever have to. Also, once we allow this kind of wildcard we can
> > > > suddenly get into a situation where people might want to reuse this on
> > > > something that's not at all a google-pompom board because the same
> > > > particular power sequence happens to work on on some other board.
> > > >
> > > > Similarly I can imagine a situation where we could now have the same
> > > > panel supported by multiple different wildcard compatible strings. How
> > > > is that supposed to be any cleaner than what we have now?
> > > >
> > > > And I still keep wondering why bootloaders can't be taught about these
> > > > kinds of things. We have in the past discussed various solutions where
> > > > the bootloader could detect the type of panel connected and set the
> > > > proper compatible string.
> > >
> > > The bootloader cannot detect the panel without powering up the panel,
> > > which it normally does not do if you are not in dev-mode (it would add
> > > a significant amount of time to bootup, which is why we can't do this)
> >
> > what if we had a sort of multi-choice panel node:
> >
> >    panel: panel {
> >      compatible = "panel,one-of";
> >      compatible-one-of = "vendor1,panel-a", "vendor2,panel-b",
> > "vendor3,panel-c";
> >   };
> >
> > The kernel could construct power sequence timings that are the
> > superset of all the possible panels.  That seems about as explicit as
> > we could get in this sort of case.
>
> If we were to go this route, I'm inclined to say just shove all the
> possible panel compatibles into 'compatible'. That kind of breaks the
> notion of most specific to least specific. OTOH, it is saying the set
> of panels are somehow 'compatible' with each other.
>
> If there's not some level of compatibility between the panels, then
> it's still the bootloader's problem.

I guess I missed all the fun! OK, so I think the approach is:

1. List all the possible panels straight in the "compatible" string in
arbitrary order.


2. We'll change the interpretation of "compatible" but just for panels.

2a) Normal interpretation of "compatible" (from devicetree spec) is
most specific to least specific. We look at the first "compatible"
string. If we have a driver for that specific device, use it. If not
then move on to the next "compatible" and look for a driver for it.

2b) Interpretation of "compatible" for panels nodes: an unordered list
of possible panels that might be stuffed. In order to be listed like
this there must logically be a way to drive things in a way that would
be compatible with all possible panels here.


Presumably no existing panels are relying on the old interpretation?
Personally I like Rob Clark's "panel,one-of" a bit better just because
it doesn't require the redefinition of a standard property, but if
everyone likes the redefinition then I won't object.


-Doug
