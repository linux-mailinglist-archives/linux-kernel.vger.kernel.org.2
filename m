Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53C409F38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbhIMVgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245192AbhIMVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:36:41 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A176FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:35:25 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s11so23339370yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WU4RoFg6VLiOFaJk3K/XGgOlD1ESkFInWzo0IbGN3kU=;
        b=i3Z0HOIgpurMHd0P76FaxIh1P5hgM75ND5dd9STSAh0z9OlcVhLjPEgL+DGCBv8B0Z
         udwgE4i724dtIieRLRVBW1C73UKb+34IT3LK8m8G6oLPQn4MhhG/OY+yrrAkljZWikGQ
         YD5c4lMTZeWTRf0b1eaJcmEfWHBiXsjqEGfCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WU4RoFg6VLiOFaJk3K/XGgOlD1ESkFInWzo0IbGN3kU=;
        b=yhdzSMj7NsU6ittbWkJA34rGpXka6CNIaNg9Sg0Yz8nSN8TUDexzdEwVK1BImKJHgJ
         0GI5sqg/gqjsDeCKSpyFhVmjTmpEcONEP95lrk+iSd8ZmuTc93FJnxOHYQdCt04ae9JC
         6nl6+Jv0V2+0kW7C5tIMHp2ilfrps0tRcFmPiy3ug3V4PekoZ6DL/++56yBWRwaWC/MG
         GkzBq31mXbTu9kJXXHRuPjzWUBJQZFyCCaPySRyScxvOpZf4hqNkb6GEI9au/7AKw8w9
         H9IF9e7wMR0xiRiyCypeuaM+MAQQ/ct/8KDATt5IIBhzHcoqo2dIclHfRpyg85yDUPSl
         zz9A==
X-Gm-Message-State: AOAM531ab++IgqtU7T/NPbfFlUJjGGoxLhx6mvkSllmKHmp/uiG2eU/8
        lSUq6fZf1+Z21g3wdMXd0lLcAU1U7AAiD60WGW0hEg==
X-Google-Smtp-Source: ABdhPJzrSE7OvTRSnfAVhlv8p0e4jgQ3WUKAFfsLEAMYdX8ZfK6ClcfX8j/VfRFvlWlGf1HJLOYWvtIG6RLTfRcA6t0=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr18356737ybv.388.1631568924984;
 Mon, 13 Sep 2021 14:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
 <20210908111500.2.Iac57921273b27d7f7d65e12ff7be169657f4c1eb@changeid>
 <CAE-0n50mp5F79iJ+zVrbt4ZP7V+UUOcVQe9H3TwEcFFyZWMoNA@mail.gmail.com>
 <CA+cxXhnPd1Z_HVjgM8b0wskASF-ZGuvYDh0quiVMwKFhKVx-JA@mail.gmail.com> <CAE-0n51s2MmOthCUSm0+KNBnWmNV=Zzf6eWhYJBme4LpMUUcAQ@mail.gmail.com>
In-Reply-To: <CAE-0n51s2MmOthCUSm0+KNBnWmNV=Zzf6eWhYJBme4LpMUUcAQ@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Mon, 13 Sep 2021 14:35:14 -0700
Message-ID: <CA+cxXhme8OPMxtQqEn5yotx+EDpTBFyBuQxCcofsXUKO7gR0Sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 12:07 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-09 11:15:27)
> > On Wed, Sep 8, 2021 at 3:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Philip Chen (2021-09-08 11:18:06)
> > >
> > > > +
> > > > +       data = (len - 1) & AUX_LENGTH_MASK;
> > > > +       regmap_write(map, PAGE0_AUX_LENGTH, data);
> > > > +
> > > > +       if (request == DP_AUX_NATIVE_WRITE || request == DP_AUX_I2C_WRITE) {
> > > > +               ret = regmap_noinc_write(map, PAGE0_AUX_WDATA, buf, len);
> > > > +               if (ret < 0) {
> > > > +                       DRM_ERROR("failed to write PAGE0_AUX_WDATA");
> > >
> > > Needs a newline.
> > Adding an empty line here doesn't look like a common Linux style?
> > Could you point me to any similar instances in the Linux codebase?
>
> Sorry. I meant on the DRM_ERROR message itself. Add a newline.

Fixed in v2. PTAL.
