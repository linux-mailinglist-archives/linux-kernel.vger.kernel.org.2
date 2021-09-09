Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F185405EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbhIIVPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhIIVPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:15:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB0AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:14:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m11so4177630ioo.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLZSZYIwz1ps13bllE/o8ZftzcSljG2It1aK1Q5Nz8I=;
        b=HO9YtQ6MlJn7+IDzJn7EdvK39R44d47kXV2OtfDfuDavIeSBisnixpV/pJ5OUPA1Cw
         KuK2YPHieOQeeEM50Mitcyt3MN1e54I0TivXX6ogT9xokBZ8ER5jwGiuqw5RqAR+Vxtd
         oIW3N48LLG7r//8yaMeDC5lgT3fSeKsKF4h/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLZSZYIwz1ps13bllE/o8ZftzcSljG2It1aK1Q5Nz8I=;
        b=kVDK2mclB4m3wg8hmecOsxuaKRePi90NyOfvGBsTjf3ofDsVPnhpPKLkI8kmQZjLg0
         BdJcqgZSCyr3pSJz5OzILB5V0kfqeM5+ZxO2Of0lSKUTt0UAbrSS+oPnlLkCRZbFatzO
         bW6pb8HyvSOj5wMbnSte7AfJ52fhsQwFrYJKu5Pdneir9YufNpqZgknA3r5W3LXHmj/I
         jTkSkPtvKI2OYjVVIoPBaVVW+o1gKyRu7+NIYQdD74Zw+TnkYdP3vFDa2wx6XEx3ukDi
         f1rvuoZpXEhXR/Q0Q7fhx50ilcQlHCdtcR87KGgH+VhzXZi6+ipNkajZw9Xd8p0DGt5P
         TXug==
X-Gm-Message-State: AOAM531bc1lAiAcjHMBJZLwdkzk39TZ81vy2m8bI3XNXggcHSvfj10DG
        MrcLoaorssuPbdiMb6m9yfZf9ikG+FmRBg==
X-Google-Smtp-Source: ABdhPJzPTtLGWpbRSAz7YgkWYCXfE35qsFI0/UxFykuL/t+jm7L3npIPF9iBieFQVqWpoq9DxFK5mQ==
X-Received: by 2002:a02:3b1b:: with SMTP id c27mr1572745jaa.103.1631222082412;
        Thu, 09 Sep 2021 14:14:42 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id n2sm1131774ile.86.2021.09.09.14.14.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 14:14:41 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id a1so3418821ilj.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:14:41 -0700 (PDT)
X-Received: by 2002:a05:6e02:214e:: with SMTP id d14mr3552572ilv.142.1631222081152;
 Thu, 09 Sep 2021 14:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
 <CAE-0n52ia_Em6GYU-ketmzi4OQxcdux3uLjMGhzVTUJbC0Yz-Q@mail.gmail.com>
 <CA+cxXh=FJtvAzb0UeMXYs3PKxcdoR7hG23BJQ5Xtj_ywjLUQ_w@mail.gmail.com> <CAE-0n51GPe4aWqmbm4htArS716dKhYPPV2KbKtk-d6MsUe8UpA@mail.gmail.com>
In-Reply-To: <CAE-0n51GPe4aWqmbm4htArS716dKhYPPV2KbKtk-d6MsUe8UpA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Sep 2021 14:14:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzy5vagh2G4pbqpSgVVjaGoswiH=udBH5RVZ96cNu=eQ@mail.gmail.com>
Message-ID: <CAD=FV=Uzy5vagh2G4pbqpSgVVjaGoswiH=udBH5RVZ96cNu=eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Philip Chen <philipchen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi,

On Thu, Sep 9, 2021 at 12:09 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-09 11:29:19)
> > Hi,
> >
> > On Wed, Sep 8, 2021 at 2:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Philip Chen (2021-09-08 11:18:05)
> > > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > index 685e9c38b2db..a16725dbf912 100644
> > > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > @@ -64,12 +65,29 @@ struct ps8640 {
> > > >         struct drm_bridge *panel_bridge;
> > > >         struct mipi_dsi_device *dsi;
> > > >         struct i2c_client *page[MAX_DEVS];
> > > > +       struct regmap   *regmap[MAX_DEVS];
> > > >         struct regulator_bulk_data supplies[2];
> > > >         struct gpio_desc *gpio_reset;
> > > >         struct gpio_desc *gpio_powerdown;
> > > >         bool powered;
> > > >  };
> > > >
> > > > +static const struct regmap_range ps8640_volatile_ranges[] = {
> > > > +       { .range_min = 0, .range_max = 0xff },
> > >
> > > Is the plan to fill this out later or is 0xff the max register? If it's
> > > the latter then I think adding the max register to regmap_config is
> > > simpler.
> > It's the former.
> > The real accessible register range is different per page, E.g.:
> > - For page0, the register range is 0x00 - 0xbf.
> > - For page1, the register range is 0x00 - 0xff.
> > - For page2, the register range is 0x80 - 0xff.
>
> Oh does this have register pages? regmap has support for pages where you
> write some indirection register and then access the same i2c address for
> the next page. This looks different though and has a different i2c
> address for each page?

I haven't looked in tons of detail, but I think the right solution
here is a separate regmap config per page.

-Doug
