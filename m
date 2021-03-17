Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1AC33FBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCQX1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCQX1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:27:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 16:27:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id o11so220066pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODgJlo11thr3abRRn5H88pJeZKbcK7WUWOM8GS7dn/E=;
        b=ka7O4tt5b/1Dj+gDV75rnKYCFDViijs6tPrSecl/kL4FE/l3HAn8wK2w7DCA/GvLMz
         vzLzimLuFdKdgF8qD04l6Hl6ELjSIJ2DmchyQZq+HAFFv7uXuz0J+WyWzxCsFodfyJMD
         JqVKZ2cm3qQs9iPt7qK9kDLHA527OLYf70mSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODgJlo11thr3abRRn5H88pJeZKbcK7WUWOM8GS7dn/E=;
        b=mlE5+5NQXd0RrapgU+S8IZq9xw8dNR3+iQrF8C0eJJrqITA/b0EIVGarZhybqmwDEw
         sR7q12ofC7LjcdtLU2Eeb5Xca2C3kKc+8YDdOwD2QZRgnUao1ldVF6LaOD4acL68HxvU
         a2xXM6U0gWEydtDtAxnxMuK/wefWwcamJ1edV9YFuEpKKg/fxw3jsbiUbgCCi0MIY6Ln
         RfCK13TwRWmyyo4smooixxWfwxTzta23SxFz96ppeYg69/1Xg/axQI3t4IayOCyEvUPz
         vD5I4rZSbHXkvMxQdZrSgXFH/4U7cNLSfo7PjQDaxakp7yhx1EqtKUje9MriRY3crb8m
         E2IQ==
X-Gm-Message-State: AOAM532qLe78FN/bkJ5ZP/+gtxTq4TwmkxGxeaHMAIJgqxOBUNR8GNd7
        q1/XMocJG4uPyNdfjvE3pOQYwg==
X-Google-Smtp-Source: ABdhPJzeS30ixDkVh9yP6I/NanMrQ/pjkgpILrw4pj9P0Ogh+/lOMqEh56QvyTw5PcFj2orL9mcEJA==
X-Received: by 2002:aa7:8a58:0:b029:1fb:8ab:866e with SMTP id n24-20020aa78a580000b02901fb08ab866emr1339585pfa.0.1616023660024;
        Wed, 17 Mar 2021 16:27:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3cf8:6a09:780b:f65d])
        by smtp.gmail.com with UTF8SMTPSA id x186sm166239pfc.65.2021.03.17.16.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 16:27:39 -0700 (PDT)
Date:   Wed, 17 Mar 2021 16:27:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, robdclark@chromium.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        eballetbo@gmail.com, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        drinkcat@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: simple: Add the panel on
 sc7180-trogdor-pompom
Message-ID: <YFKQaXOmOwYyeqvM@google.com>
References: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:08:19PM -0700, Douglas Anderson wrote:
> The sc7180-trogdor-pompom board might be attached to any number of a
> pile of eDP panels. At the moment I'm told that the list might include:
> - KD KD116N21-30NV-A010
> - KD KD116N09-30NH-A016
> - Starry 2081116HHD028001-51D
> - Sharp LQ116M1JW10
> 
> It should be noted that while the EDID programmed in the first 3
> panels indicates that they should run with exactly the same timing (to
> keep things simple), the 4th panel not only needs different timing but
> has a different resolution.
> 
> As is true in general with eDP panels, we can figure out which panel
> we have and all the info needed to drive its pixel clock by reading
> the EDID. However, we can do this only after we've powered the panel
> on. Powering on the panels requires following the timing diagram in
> each panel's datasheet which specifies delays between certain
> actions. This means that, while we can be quite dynamic about handling
> things we can't just totally skip out on describing the panel like we
> could do if it was connected to an external-facing DP port.
> 
> While the different panels have slightly different delays, it's
> possible to come up with a set of unified delays that will work on all
> the panels. From reading the datasheets:
> * KD KD116N21-30NV-A010 and KD KD116N09-30NH-A016
>   - HPD absent delay: 200 ms
>   - Unprepare delay: 150 ms (datasheet is confusing, might be 500 ms)
> * Starry 2081116HHD028001-51D
>   - HPD absent delay: 100 ms
>   - Enable delay: (link training done till enable BL): 200 ms
>   - Unprepare delay: 500 ms
> * Sharp LQ116M1JW10
>   - HPD absent delay: 200 ms
>   - Unprepare delay: 500 ms
>   - Prepare to enable delay (power on till backlight): 100 ms
> 
> Unified:
> - HPD absent delay: 200 ms
> - Unprepare delay: 500 ms
> - Enable delay: 200 ms
> 
> NOTE: in theory the only thing that we _really_ need unity on is the
> "HPD absent delay" since once the panel asserts HPD we can read the
> EDID and could make per-panel decisions if we wanted.
> 
> Let's create a definition of "a panel that can be attached to pompom"
> as a panel that provides a valid EDID and can work with the standard
> pompom power sequencing. If more panels are later attached to pompom
> then it's fine as long as they work in a compatible way.
> 
> One might ask why we can't just use a generic string here and provide
> the timings directly in the device tree file. As I understand it,
> trying to describe generic power sequencing in the device tree is
> frowned upon and the one instance (SD/MMC) is regarded as a mistake
> that shouldn't be repeated. Specifying a power sequence per board (or
> per board class) feels like a reasonable compromise. We're not trying
> to define fully generic power sequence bindings but we can also take
> advantage of the semi-probable properties of the attached device.
> 
> NOTE: I believe that past instances of supporting this type of thing
> have used the "white lie" approach. One representative panel was
> listed in the device tree. The power sequencings of this
> representative panel were OK to use across all panels that might be
> attached and other differences were handled by EDID. This patch
> attempts to set a new precedent and avoid the need for the white lie.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Sounds reasonable to me if DT maintainers can live with this abstract
hardware definition. It's clearer than the 'white lie' approach.

It's then up to the vendor/manufacturer to ensure to only ship devices
with panels that have compatible timings.

>  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 62b0d54d87b7..9807dbc1cceb 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -140,6 +140,10 @@ properties:
>        - giantplus,gpg48273qs5
>          # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
>        - giantplus,gpm940b0
> +        # A panel connected to a google,pompom board. Panel is guaranteed to
> +        # confirm to google,pompom-panel power sequencing requirements and then

s/confirm/conform/ ?

> +        # the specific panel will be probed via EDID.
> +      - google,pompom-panel
>          # HannStar Display Corp. HSD070PWW1 7.0" WXGA TFT LCD panel
>        - hannstar,hsd070pww1
>          # HannStar Display Corp. HSD100PXN1 10.1" XGA LVDS panel

FWIW:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
