Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9C33695D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCKBCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCKBBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:01:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F8C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:01:52 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b130so18999079qkc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gz//qG4UKWaU4eBFBftxHoN1DTt9WFPAtbEDzRcy4ZI=;
        b=m20bJdO+CkdIH+TFxZdxXfjbq+tuRI61Mw/BzmynatBY61+Ak29sP5beKDkKUZNZwC
         kqV9Ko6EmZR9VIu2a2KuYW3TxCBTTp/lS1kewoCeMfxG2qqC0dvono4Boa6Mg9qJwxze
         6noxSfHWyh5vm+O3q+7qxcyxBT0nJMXwvqC8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gz//qG4UKWaU4eBFBftxHoN1DTt9WFPAtbEDzRcy4ZI=;
        b=L18S/oYkxmCvtL0onFhN9mZbUN1GMyVEbMKgz+iF2HReRdjMfDbh+SoOPFrCcWvGXd
         6aMdeJGlN6S2XI0ZtU0hEJMNU0Yef9n+lC+FGV8eAw/aFveqsxX2pNuGP2kmmZGkIky8
         rhjRsgxyHX9xyAy2IEvPPgA5XPCRfGQgdfLph+cVtrgq0Q6BrYjzPE/gpvfI4zJpwYqc
         bPxmrs49Wb0o8IoBSgu5PxPV8+IWU4XivGSe3loN3nIIbG/qXiF/jRRD8cFNN8KE83Vm
         BxMDI4kafJo8E/REgYf30I8JiD3vZOFCuXyRXQiRf9XvVGhbeaS/BhAY7fXXMZzC1NuO
         x83g==
X-Gm-Message-State: AOAM530gOqh+umJIua1+iEOY8sPTwW+kn2LiG3wkz6uQuG0cEqes+N3f
        OM2wkZoPbItBseOOIUHoANgJKxcJojnA5g==
X-Google-Smtp-Source: ABdhPJwYxXA/wEMT+WFAGU1ALNUtuXfmYHn4n9sCIwYBqFX2upyB89I0LNonzJ5LKZPACMNFiG8qiA==
X-Received: by 2002:a37:a353:: with SMTP id m80mr5527286qke.14.1615424511912;
        Wed, 10 Mar 2021 17:01:51 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z196sm834845qka.70.2021.03.10.17.01.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 17:01:50 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id m9so19946001ybk.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:01:50 -0800 (PST)
X-Received: by 2002:a25:aa43:: with SMTP id s61mr8713736ybi.32.1615424510011;
 Wed, 10 Mar 2021 17:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
 <CACRpkdYUs2W3b_u8YrmYwq_kcUCf0DhZ-o2o6O2EmU5rdtv=BA@mail.gmail.com>
 <CAD=FV=WDVAj+OcVXaTJRUu8tvdDzySW0KOfiGqZHi5YvP42BTA@mail.gmail.com> <CACRpkda1Ast1cqNfVJ_u6zs8610DWSQGykPt4yBw+mFZFrUPSg@mail.gmail.com>
In-Reply-To: <CACRpkda1Ast1cqNfVJ_u6zs8610DWSQGykPt4yBw+mFZFrUPSg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Mar 2021 17:01:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vj-6Y0X667o5vH0EL7hXi6sU4ZWs_a41B6h0D1s05_Hw@mail.gmail.com>
Message-ID: <CAD=FV=Vj-6Y0X667o5vH0EL7hXi6sU4ZWs_a41B6h0D1s05_Hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 10, 2021 at 4:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Mar 11, 2021 at 12:47 AM Doug Anderson <dianders@chromium.org> wrote:
>
> > I guess what I'd say in summary is:
> >
> > * If you object to the retries in simple panel, I still hope the rest
> > of the series can land.
> >
> > * If somehow this panel gets out into real users hands and we find
> > that the retries are necessary and people still don't want the retries
> > in simple panel, I can fork a special panel driver just for it then.
>
> I'm fine with the retries, if it is needed outside of the "simple" (hm)
> panel driver then we can certainly factor it out as a helper or
> library.
>
> I looked at the patches at lore.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> I see also Stephen has reviewed some patches.
>
> Tell me if you need me to also apply them to drm-misc.
> (I guess yes?)

Yes please. I was giving Sam time to do it but I haven't heard from
him for a while. Right before you responded I poked Thierry to see if
he was available but if you're willing/able to do it then I'm sure it
would save him the trouble.

If you'd like me to re-post the patches (CCing you) I can. Please let me know.

If you happen to feel in an applying mood one other patch to
simple-panel I think is OK to land is at:

https://lore.kernel.org/r/20210222081716.1.I1a45aece5d2ac6a2e73bbec50da2086e43e0862b@changeid

-Doug
