Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6DC409F44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbhIMViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbhIMViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:38:09 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:36:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c6so23460854ybm.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFUspCFtV5DoOy2PmnKy+pTvRZ6jWPWQRYWdYuJIS7Q=;
        b=Cf6c4g5FVXo1iZP44CAwyVhWJwkqzK0uB6iKuy6uK2l1hbO3JzUsfRcvHLNTgzlVBB
         AG0HpLB6v0takN6e0dSpWLGzRTBZqEYmPW4xV4cC8TBzoTvkFy3Fqcov1k8Pe9MOOO/b
         o5OhtU2Za5uLyAwFg80ghBxSd14kwc6Q5nc80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFUspCFtV5DoOy2PmnKy+pTvRZ6jWPWQRYWdYuJIS7Q=;
        b=ZHXnDME9Ug/Drm0M68nzok3jMLM6nHvCOSLaWLAty+A8Nresm0XCbiifINGR7hQ+lW
         oxMqTDCVsZVbNaQPkzNm6hGJFcPKKBHqoHDrcXrFIPe4Is8YeEtb1c/n7Hjf255MuZa1
         vnqmxdZmhoswsP1aEqfBS0cnMdMGTE6/azzPitKT4wBfi+Zba02HZJAuiCJfSTbS5OHW
         dEiMdnwtmTNQyh0fD2b82zWut4cSBlSmUeywfQ5O4Fz5WFUuBQZF1P7cRsnkpRLQ5qqz
         Jf1niPy5X6ogvk8gz/tpb0iopmCrxt9J7K+He71ejs1ez0/0OqWgs791CWj/MKQHgY79
         jrFw==
X-Gm-Message-State: AOAM531YNQZXmW2KxTapzXvE1pQtOolPeAJoC1z7dxwJ/r1T7q5xcMWg
        l/tUtipNRDoTf5dGq5ksttnPma6mouAXvlDyfq5UAQ==
X-Google-Smtp-Source: ABdhPJzgvBImaSsmEWPjo6a41me/gWhYqfofAzZ+KFs9IC0CbzQFIWJfavjAxKM5qjfC2HrC9M7+9BTB6d/lDEyABOo=
X-Received: by 2002:a25:5982:: with SMTP id n124mr17377159ybb.57.1631569012770;
 Mon, 13 Sep 2021 14:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
 <CAE-0n52ia_Em6GYU-ketmzi4OQxcdux3uLjMGhzVTUJbC0Yz-Q@mail.gmail.com>
 <CA+cxXh=FJtvAzb0UeMXYs3PKxcdoR7hG23BJQ5Xtj_ywjLUQ_w@mail.gmail.com>
 <CAE-0n51GPe4aWqmbm4htArS716dKhYPPV2KbKtk-d6MsUe8UpA@mail.gmail.com>
 <CAD=FV=Uzy5vagh2G4pbqpSgVVjaGoswiH=udBH5RVZ96cNu=eQ@mail.gmail.com> <CAE-0n51i32v-GM2H81mT=aKCo0cp5zD8tFu4AHwzs6Zb9kHRqw@mail.gmail.com>
In-Reply-To: <CAE-0n51i32v-GM2H81mT=aKCo0cp5zD8tFu4AHwzs6Zb9kHRqw@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Mon, 13 Sep 2021 14:36:42 -0700
Message-ID: <CA+cxXh=8d=58nJUPstWvO5oEK1fw45s+d5UmKHyAErcSTB2o3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
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

On Thu, Sep 9, 2021 at 2:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2021-09-09 14:14:29)
> > On Thu, Sep 9, 2021 at 12:09 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > Oh does this have register pages? regmap has support for pages where you
> > > write some indirection register and then access the same i2c address for
> > > the next page. This looks different though and has a different i2c
> > > address for each page?
> >
> > I haven't looked in tons of detail, but I think the right solution
> > here is a separate regmap config per page.
>
> Yes. And then a different .max_register value for each config struct. A
> different .name might be useful to indicate which page it is too.

I see.
I posted v2 with the fix for this.
PTAL.
