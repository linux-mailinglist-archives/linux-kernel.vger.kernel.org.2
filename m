Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBD412B07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbhIUCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhIUBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:49:21 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A493EC077D3A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:42:23 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a20so20368933ilq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4wFITo/SSU6l99h8D31QzjvTinZuABM6hsuvIBIt0E=;
        b=TnVdqX4dU4BNSs1W4ynCtvk+BVtm8j0Qx2FtJwNVrJwQ9fXP1ogw7QUphAS5Z6+ADC
         BAS2RcjjVEGZo6FvXnCDkpMUTCKyG8XApGssOtkJGkvZ5kyNgq4+0kpQNtn3fU8Op0X+
         MqGdtdBo6zHFW9g90F7fIeDr0TO1SgZZ0nHoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4wFITo/SSU6l99h8D31QzjvTinZuABM6hsuvIBIt0E=;
        b=KQOCWK8YQsZQSrVLu8YB923CMuf+Bk9b5KwLWrbW1AlhDoUMtHtRcN+DE+vb3BdBag
         EUrhhe/zvGqDfIyS8tnj7J1gZyS0WRSWUu60fGrtuPSkMz4F/vsMC6rurg7XwQ+y6tCY
         4KI6/H7VWQhPvkOu7W+9mycFOM3UGvbPmuovFlRznnKGXhTg16rfprCCW8wMkiyJzicP
         HvvelXJYO1pjXrFcaGlJ8Fpr2evnslpyxuLB43+5ZOH9WvWMk5u1g/1687YWzCOsaXzi
         KVre1t+7rmVbcm64bTSYFG0Ml5/H9iTuXcRLWEcuqNruXEdyUET4VDc6u5VrstACh+TQ
         hsKg==
X-Gm-Message-State: AOAM533QTeJ32lHBOHxIUwTcpp/+e4YlKldFZzwozb78+m19HtpHccIy
        4Oy2xvf6HD/hDrXdtEhq+PH8eIbg6SmR6A==
X-Google-Smtp-Source: ABdhPJzjXP5spZ1fIpTX25pIoYEhXvhyj2tPqSuNAR4aYy2rBIfdnBpHrkSCJfTFEf+sybEuEA9gCA==
X-Received: by 2002:a05:6e02:1b03:: with SMTP id i3mr512639ilv.251.1632174142780;
        Mon, 20 Sep 2021 14:42:22 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id a25sm8953615ioq.46.2021.09.20.14.42.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 14:42:22 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id 134so590616iou.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:42:22 -0700 (PDT)
X-Received: by 2002:a6b:3f02:: with SMTP id m2mr19822413ioa.136.1632174141824;
 Mon, 20 Sep 2021 14:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210918102058.v5.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
 <20210918102058.v5.2.Ifcb5df5de5b1cead7c99e0f37b044ef5cfc69eda@changeid> <YUZMNIYbT7KL3qJR@ravnborg.org>
In-Reply-To: <YUZMNIYbT7KL3qJR@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Sep 2021 14:42:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXSdaTn1K+qCYPpyo-fP8FHQOjrKn17yd8hrZzf65zHg@mail.gmail.com>
Message-ID: <CAD=FV=WXSdaTn1K+qCYPpyo-fP8FHQOjrKn17yd8hrZzf65zHg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Philip Chen <philipchen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Sat, Sep 18, 2021 at 1:29 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Philip,
> On Sat, Sep 18, 2021 at 10:21:17AM -0700, Philip Chen wrote:
> > Implement the first version of AUX support, which will be useful as
> > we expand the driver to support varied use cases.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
>
> Patch is:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I'm curious: did you mean "Signed-off-by" or "Acked-by" here?

-Doug
