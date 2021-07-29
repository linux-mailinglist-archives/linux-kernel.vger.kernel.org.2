Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DBB3DAE18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhG2VTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2VTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 17:19:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCEC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 14:19:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t18so4971299qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hI5gfLyD1Tzqc9HNbOUWHN5K+jDpUpe1OJ1d5jQQrt0=;
        b=PS5qQxOVGyVqgHrT4neWt8aUIyQ4OcaRSh3jgNavcE96MgC4OTRNgy+ykmimuMCCMj
         BEUrUvwzxDaWp94PgIisXpFJiI8jiWqdGY7JkkzOdJ2n8AD7HacClwU0tDD9ouhFHR9p
         ImZ5RVfunFsymGWcWNjeSM7OKB8lzdLtQDAHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hI5gfLyD1Tzqc9HNbOUWHN5K+jDpUpe1OJ1d5jQQrt0=;
        b=Du7+Or/fLh6TvQ8VU8NlvB41Tlgy7N6btx/nxwvplxIgOS4mQ4BwqG99ncvNt0CmWv
         EB64GE8JmQ2bobdUBdibe+GVenhBBqb3DXlYK0LZ5pF6vbsnc5pAWT/hhQyERrhT5Cxp
         7PU/UUtZpOMpUL9ygAc0xsD1+SBi4M/PdfZvzG9yb5xE7aJqdcJ/16v8l5AbLD+ljsPe
         TdLr41D8/hditkNv7dItnIfAgDOFllxWzzPWxvJb6Pr8XJfkmoR7FoKlUXBm5JYECJs9
         ghvGoCdI0HgyYTyA+H4//YOTBVo331kcATKdLMVCHwkwr9LHT9H1o5etm9ZavH30UPZv
         u07g==
X-Gm-Message-State: AOAM530ttvnE0R9WcUdmaAY7b2NuB5oOMS8zzvweb6ToAPgSkJRYbVk7
        6sHoRMwWlEteq8maUxRhOMXsv8L+5WewQw==
X-Google-Smtp-Source: ABdhPJwKHOvf0aFgicv0TOCYzXwystZyH5Q/vcEjbUU+2vMjM3QiXqH2NFATkjHGXXW8rcrbq+I8pg==
X-Received: by 2002:ac8:7769:: with SMTP id h9mr5924480qtu.388.1627593576588;
        Thu, 29 Jul 2021 14:19:36 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i62sm2445643qke.110.2021.07.29.14.19.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 14:19:35 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id k65so12343611yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 14:19:35 -0700 (PDT)
X-Received: by 2002:a25:2904:: with SMTP id p4mr9170962ybp.276.1627593575191;
 Thu, 29 Jul 2021 14:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210723002146.1962910-1-dianders@chromium.org>
 <20210722172104.RFC.1.I1116e79d34035338a45c1fc7cdd14a097909c8e0@changeid> <YQMPOxfQw7zx6evp@robh.at.kernel.org>
In-Reply-To: <YQMPOxfQw7zx6evp@robh.at.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jul 2021 14:19:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYfQkuPseBq32rf2qiiv4fn2uf2wWv7FT3pjkRF9ugdA@mail.gmail.com>
Message-ID: <CAD=FV=XYfQkuPseBq32rf2qiiv4fn2uf2wWv7FT3pjkRF9ugdA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] dt-bindings: drm/panel-simple: Introduce generic
 eDP panels
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus W <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 1:27 PM Rob Herring <robh@kernel.org> wrote:
>
> IMO, you should move any applicable compatibles to the edp-panel schema.
> Also, I don't think you should add 'edp-panel' to them. If they can work
> better with the generic eDP driver, then that should be an internal
> kernel change without a DT change. Also, if 2 different drivers match on
> compatible, it's a roll of the dice which driver binds.

So overall what I was going for is this:

1. I want to be able to specify _just_ "edp-panel" for new boards.
We'll make sure this is how it looks on devices that go through the
factory and thus we can make sure that the driver can recognize all
panels that get shipped.

2. For existing boards, I'd like to be able to move them to use
"edp-panel" but I'm less confident that I can really say exactly what
panels are out there in the field. Even though our device tree has
always listed only one panel, in truth boards have shipped with more
than one and they've just been "compatible enough" with each other
(this "white lie" is what I'm trying to fix). If somehow the generic
"edp-panel" doesn't recognize a panel then I wanted to be able to use
the old timings we'd always had before as a "fallback". That means
that logically I wanted "edp-panel" to be first and only fallback to
the old compatible string if we didn't recognize the panel ID that
came from the EDID. In truth, both compatible strings are handled by
the same driver the driver patch I submitted tried to be smart.

Perhaps that above is over ambitious and it'd be better to just drop
the whole "fallback" concept. If a board manufacturer wants to start
using the "edp-panel" concept then maybe the right idea is to force
them to bump the "board id" and then we can pick a new device tree
revision. Then we can make sure all boards that come out of the
factory with that new "board id" can be identified properly in the
EDID. This will also get rid of some of the complexity in the driver
patch, which is nice. I'll plan on doing this and address your other
feedback for a v2.


-Doug
