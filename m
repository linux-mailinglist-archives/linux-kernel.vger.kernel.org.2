Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCC387A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349728AbhERN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbhERN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:59:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:58:40 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s19so9828936oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0rcuf59hk8zzhGYb9mHFLDEmB+phP4Kth6slEOIZYA=;
        b=lFI0AHcModwrEa18qX2uKnk2Wac55m5AiPLM2cv6lnVwkVH8JDjqEIw0gazCaElftB
         cHNLRg0l98UfE8vp/8XiQGbD96CtVJc0fhLv9d7phtdY+1C1sgwhDT1cCrwNauVQRMVj
         zr3eFfPWbISXhR8fSSHBrFosPT42cHLgNrX+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0rcuf59hk8zzhGYb9mHFLDEmB+phP4Kth6slEOIZYA=;
        b=lvsJyNewAghgfd431E2u+qS+6cwbSHGFyNVhLaSNrpcu0xHB5ACBKw6B+hIoUTLSTx
         wA3wetD5vODkxJTTDoKt22C9eFyae+hB5z+cJXpmIJ870oDQnZpESyhz87EkzT/qgUeJ
         1eyyq4RS25ijcUVftXiHK4incrEege4s0BTDZrjQVVB3Q5UI6b8z4arQwXKtLSQGP3r7
         hE2oNVGm5SoAZO8zE/K4hBfhqyGP3Co+3Odwux6ZLeazYv3qZDlVk/4LN/RT+NtrTv+z
         iGMXBsF2WhgQKIvygVrpvXwkI7CriXORNJDTn0EhFu+pP+9s8hyVD1emUzfSUHGNGOkL
         yCCw==
X-Gm-Message-State: AOAM5336ZdAyrS2ZtyxS4HinlD8heZeT2wH303fRbcs25S9vzGfbc6f2
        s1wWLb8W+6exOIsV2FJFnAgMnOVG5kH66w==
X-Google-Smtp-Source: ABdhPJxw36qQNl4x0l0w/Pk71hm4A0hu5iUoiOXA2zlCw1DNMzB2HjJ5MvJbl00bNC4TtpPI/7dnkQ==
X-Received: by 2002:a05:6808:1401:: with SMTP id w1mr4003911oiv.52.1621346319959;
        Tue, 18 May 2021 06:58:39 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id v9sm3853465otn.44.2021.05.18.06.58.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 06:58:39 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so8677274otp.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:58:39 -0700 (PDT)
X-Received: by 2002:a25:aad4:: with SMTP id t78mr7268437ybi.343.1621346308916;
 Tue, 18 May 2021 06:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210517200907.1459182-1-dianders@chromium.org>
 <20210517130450.v7.2.Ieb731d23680db4700cc41fe51ccc73ba0b785fb7@changeid> <CAL_JsqLMs10Luj7fKkNVu-BUZhpqAGJMZyUxz76N3b9Xa7EByg@mail.gmail.com>
In-Reply-To: <CAL_JsqLMs10Luj7fKkNVu-BUZhpqAGJMZyUxz76N3b9Xa7EByg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 May 2021 06:58:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xsc1noo7ZBK4_+Cty6KO5vc7Ex7G7BCg38rRu3s=fvUg@mail.gmail.com>
Message-ID: <CAD=FV=Xsc1noo7ZBK4_+Cty6KO5vc7Ex7G7BCg38rRu3s=fvUg@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] dt-bindings: display: simple: List hpd
 properties in panel-simple
To:     Rob Herring <robh+dt@kernel.org>
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
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 5:42 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, May 17, 2021 at 3:09 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > These are described in panel-common.yaml but if I don't list them in
> > panel-simple then I get yells when running 'dt_binding_check' in a
> > future patch. List them along with other properties that seem to be
> > listed in panel-simple for similar reasons.
>
> If you have HPD, is it still a simple panel? I don't see this as an
> omission because the use of these properties for simple panels was
> never documented IIRC.

I would say so. It is currently supported by panel-simple in Linux. Of
course, you could make the argument that panel-simple is no longer
really "simple" because of things like this...

I guess I'd say this: I believe that the HPD properties eventually
belong in the generic "edp-panel" that I'm still planning to post (and
which will be based on this series). I justified that previously [1]
by talking about the fact that there's a single timing diagram that
(as far as I've been able to tell) is fairly universal in panel specs.
It's a complicated timing diagram showing some two dozen timings (and
includes HPD!), but if you support all the timings then you've
supported pretty much all panels. IMO the original intent of
"simple-panel" was to specify a panel that's just like all the other
panels w/ a few parameters.

NOTE: I'd also say that for nearly all eDP panels HPD is important,
but in many designs HPD is handled "magically" and not specified in
the device tree. This is because it goes to a dedicated location on
the eDP controller / bridge chip. I added the HPD GPIO support (and
no-hpd) to simple-panel because my bridge chip has a fairly useless
HPD line and we don't use it. Even though the fact that we need the
HPD specified like this is a function of our bridge chip, back in the
day I was told that the property belonged in the panel and so that's
where it lives.


> Not saying we can't add them, but justify it as an addition, not just
> fixing a warning.

Sure, I'll beef up the commit message.


> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I didn't spend tons of time digging to see if there was supposed to be
> > a better way of doing this. If there is, feel free to yell.
>
> That's the right way to do it unless you want to allow all common
> properties, then we'd use unevaluatedProperties instead of
> additionalProperties.

Ah, perfect. Thanks!

[1] https://lore.kernel.org/r/CAD=FV=VZYOMPwQZzWdhJGh5cjJWw_EcM-wQVEivZ-bdGXjPrEQ@mail.gmail.com/


-Doug
