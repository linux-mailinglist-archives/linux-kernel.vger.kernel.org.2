Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB343E4F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhHIWSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhHIWSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:18:39 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDD0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:18:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y9so3578949qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kSuSdOzpn2BC3hOOiKLl3g0gaz4argQkrrvlL062JE=;
        b=kr9pYlMuV9ECH5XIXkt+0asDJ+giRnj4+5OSL6oQgpR/pvLqhUJJIA7vco8MDpekpg
         JNiiBamDLModZJ3liyKJ5Z/cSkx8a67P7K7Q12+71TEeSlCraUlj5CKRm4h3KFF7i360
         35Eu0UmQtpvg4y7StN2DunBOonRSZiHz90auk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kSuSdOzpn2BC3hOOiKLl3g0gaz4argQkrrvlL062JE=;
        b=lyAg7WTvvtbbT+15Cvm0ZUT0JScr5uEzZUMFaQ4TETwl0+vPReBNZORFwCUWJs6+y4
         P+gmVKHRr82hp9uaugWbZaRLVCcPbZ9qi1bV22CqUiAQHk9Q0zjkYdoDb7lppMuYZ58U
         xfmuI64bRKPbGUIfk4naH2Vd+XCrIX+2imcdIHDEVKGs30AEWxTrcGmstqdzoUqyvp2E
         RlkEcoC7QxAgeKBMu7Iz+zozrsJmCRKTxb/oJovSmlPagL7Hq0pKolPwj5QkgO8YzJKZ
         msvxOSchgSvJ+HFAecWBQDAezCjaHM/NqYOcIyuq9Pmta/tZed/GoV3BWeKCYOi1l8QY
         YV9Q==
X-Gm-Message-State: AOAM5302io1687z9yoF5MYpekkAmqVl5uRTgPW0/3zhW1OS0oiM3LkJT
        psfl1lz47KHWhg1Uk2i2WTbwqXcRxSKEqQ==
X-Google-Smtp-Source: ABdhPJzbkteuRSFMZPEFkixf1eCctS2YURgXiyfLYjPeiQtRR34SpBFHWP9SZ9Civz56RNJ9E49Inw==
X-Received: by 2002:ac8:760a:: with SMTP id t10mr22429088qtq.174.1628547497473;
        Mon, 09 Aug 2021 15:18:17 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id p19sm6985165qtk.75.2021.08.09.15.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 15:18:15 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id m193so32439189ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:18:15 -0700 (PDT)
X-Received: by 2002:a25:b845:: with SMTP id b5mr33593609ybm.343.1628547495182;
 Mon, 09 Aug 2021 15:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210730212625.3071831-1-dianders@chromium.org> <YQmp3mGpLW+ELxAC@ravnborg.org>
In-Reply-To: <YQmp3mGpLW+ELxAC@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Aug 2021 15:18:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxOXJEgq7SiOVwSo2eWEbekQqutucFP=MmrrtmStXxog@mail.gmail.com>
Message-ID: <CAD=FV=XxOXJEgq7SiOVwSo2eWEbekQqutucFP=MmrrtmStXxog@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] eDP: Support probing eDP panels dynamically
 instead of hardcoding
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 3, 2021 at 1:41 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas,
>
> On Fri, Jul 30, 2021 at 02:26:19PM -0700, Douglas Anderson wrote:
> > The goal of this patch series is to move away from hardcoding exact
> > eDP panels in device tree files. As discussed in the various patches
> > in this series (I'm not repeating everything here), most eDP panels
> > are 99% probable and we can get that last 1% by allowing two "power
> > up" delays to be specified in the device tree file and then using the
> > panel ID (found in the EDID) to look up additional power sequencing
> > delays for the panel.
>
> Have you considered a new driver for edp panels?
> panel-edp.c?
>
> There will be some duplicate code from pnale-simple - but the same can
> be said by the other panel drivers too.
> In the end I think it is better to separate them so we end up with two
> less complex panel drivers rather than one do-it-all panel driver.
>
> I have not looked in detail how this would look like, but my first
> impression is that we should split it out.

I certainly could, but my argument against it is that really it's the
exact same set of eDP panels that would be supported by both drivers.
By definition the "simple" eDP panels are the ones that just have a
regulator/enable GPIO and some timings to turn them off. Those are the
exact same set of panels that can be probed if we just provide the
panel ID that's hardcoded in the EDID. As you can see from the
implementation patch I'm actually sharing the private data structures
(the ones containing the timing) for panels that are supported both as
"probable" and as hardcoded. If we split into two drivers we'd either
need to duplicate the timings for all panels supported by both drivers
or we'd have to somehow export them (maybe hard if things are in
modules). Also, since it's the same set of eDP panels we'd need to
exactly duplicate all the code handling delays / HPD. It just doesn't
feel right to me.


-Doug
