Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDFE405EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346551AbhIIV2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbhIIV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:28:36 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:27:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y128so4440863oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Oh0PrsGCeSfOgOX5+3rr99J+ELkTBImIMOvzGUX/BXQ=;
        b=jZntIy9m9vUA0OyRmYw3aYdCO31jMyIjnlPtYAMuACobukHKL5T8CCZDK0IijqATca
         qeyfK2RTUA+Uif5Hv2ehDYpvpi6L4z9C7KsQGd+IZjyfHM+xRdZIOPlLCxBdufoR+Kfp
         NJZ2tukQmX5NBpxsgVhbh5ixup5Y+MjZHc3gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Oh0PrsGCeSfOgOX5+3rr99J+ELkTBImIMOvzGUX/BXQ=;
        b=Xm/EfZtUnPaBE9CEjFUOw18Ie+C+VwSH/+GYt2WvkgIqAthyksgOsuP3Xv06wzLjB5
         LD0jS2uCz0PeXXjG4toWAOoLl57KmnNdI6z4+ssea1wd2nw6FutuBfTlu/BR9ejzdxA0
         fmq5XKv+c/4Y74GwqtqcJiwgjRq5mv/GDXRlE80SAyCx1dviDqyPRMhfBVDyThd4Xkw0
         +nBPHhiENRPA5FIYxNAw9yvP4FAQs3Jf2Jb/yw+ObWpZYCrxDpz8mMV+jejNmOuqliOk
         z7fQnoFwo7hKuskLk9qVZwC4NZW2rMSdu8icmSqYkelhFVp1QNNKPrJdvSz7wZTR7UR5
         9O9Q==
X-Gm-Message-State: AOAM530lXxFKpiYZ38MXmqYFE1JMd5yjzFyAnyhI3vrsOfNSP1RW5+be
        NqWOxPKB4nhswN+cdlRoLJYZ0yErJJgSr5Y7i8wxeQ==
X-Google-Smtp-Source: ABdhPJx9WwQShlI9W7TevmsFcHWi0PaDY64KM9xWOqqmnXD6wOlguN6oJuT3F7znRXfBhzDTAY4IJOUXpSgetybD3ok=
X-Received: by 2002:a54:4419:: with SMTP id k25mr1673988oiw.32.1631222846293;
 Thu, 09 Sep 2021 14:27:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Sep 2021 17:27:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Uzy5vagh2G4pbqpSgVVjaGoswiH=udBH5RVZ96cNu=eQ@mail.gmail.com>
References: <20210908111500.1.I9f6dac462da830fa0a8ccccbe977ca918bf14e4a@changeid>
 <CAE-0n52ia_Em6GYU-ketmzi4OQxcdux3uLjMGhzVTUJbC0Yz-Q@mail.gmail.com>
 <CA+cxXh=FJtvAzb0UeMXYs3PKxcdoR7hG23BJQ5Xtj_ywjLUQ_w@mail.gmail.com>
 <CAE-0n51GPe4aWqmbm4htArS716dKhYPPV2KbKtk-d6MsUe8UpA@mail.gmail.com> <CAD=FV=Uzy5vagh2G4pbqpSgVVjaGoswiH=udBH5RVZ96cNu=eQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 9 Sep 2021 17:27:25 -0400
Message-ID: <CAE-0n51i32v-GM2H81mT=aKCo0cp5zD8tFu4AHwzs6Zb9kHRqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     Doug Anderson <dianders@chromium.org>
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

Quoting Doug Anderson (2021-09-09 14:14:29)
> On Thu, Sep 9, 2021 at 12:09 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >
> > Oh does this have register pages? regmap has support for pages where you
> > write some indirection register and then access the same i2c address for
> > the next page. This looks different though and has a different i2c
> > address for each page?
>
> I haven't looked in tons of detail, but I think the right solution
> here is a separate regmap config per page.

Yes. And then a different .max_register value for each config struct. A
different .name might be useful to indicate which page it is too.
