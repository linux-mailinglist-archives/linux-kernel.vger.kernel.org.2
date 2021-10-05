Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C1423482
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhJEXh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhJEXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:37:24 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 16:35:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a3so1512252oid.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 16:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=56IzYsCngcQCBJWMD0JhwTzUl1q8pi+qZeXw6ytKK8A=;
        b=eRRinxuy/37yDFfXp6IVii9vjLkGuva0q1QVDD23ceHuI1Ku2gowQTk8r+Mi+XdmxX
         U2Wsp25IqyOlImWDr9V+UWMcKRvFJHL99YIhUVDVBQRG8DuQ01Lpl0DLnXurNPz2/fDy
         7wW6jiSD1tcTXxwfxdEqh52XidJdgW83YrpTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=56IzYsCngcQCBJWMD0JhwTzUl1q8pi+qZeXw6ytKK8A=;
        b=M8rw6e3x8Z+le2L/u8lkG+rB1J7am7g9+QkkZUSxrn5VOjSV6W+C5l0dO+TQ0MUAZj
         jhnjfDzQqm2zPBnC3cZpbmmTZl+bzDb9tpIUV7syVKs5RRsqGfcjEQuCxMadVH9Y9Wan
         Fa8g34hNadtd/h7r6NW7rdhO+/X9hirffbbOXNf6HUUP1davlVa91+XWYQ7bpLo8gWvb
         oafzvtawFcorS/aOx4VthEEWF+wbG0qpDwPJ3FuKGmjH6jCubQpYAC/Qb/r2CZZOr9v0
         3KodjSYgZchD9rvF929Ms0quJ7P34/fiV4MwhFNxuz8VgguBTGzM8Hd2V0KtcAqcP4Pd
         4pSw==
X-Gm-Message-State: AOAM531jaL8UNpBU6rgHUMYVuf0hiIMS8Ghc+CqZPXmp1RZ5+9b3NPAI
        ZP2F2iTr9Cm4bSMV1Y9dk1w9UftvmgcAaLTIJkFjkQ==
X-Google-Smtp-Source: ABdhPJz8EZyQff1TxdzuJVG8JQE9jeLRASYoOxoi7ECsw4XqrqgsNEazNQpnBxnQIQovikbvFIHbcAQ/6pYFY/+7Tqw=
X-Received: by 2002:a05:6808:f8f:: with SMTP id o15mr4789420oiw.164.1633476932903;
 Tue, 05 Oct 2021 16:35:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 16:35:32 -0700
MIME-Version: 1.0
In-Reply-To: <a4a4980e586a70e3b7de989bc61a3e33@codeaurora.org>
References: <20211005023750.2037631-1-bjorn.andersson@linaro.org>
 <CAE-0n52wN1s=Ph4r4iLposxNPfa562Bv1mM81j1KvNmWOQS1-Q@mail.gmail.com>
 <YVzGVmJXEDH0HfIL@ripper> <CAE-0n53FC7JCCJoye_uKeqaLKrZeHXLtvObxWFedaUzjirmBaA@mail.gmail.com>
 <a4a4980e586a70e3b7de989bc61a3e33@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 16:35:32 -0700
Message-ID: <CAE-0n507Nci+7MCJWSqxU=MPjrZLn5VMJq1BdceFmvp2AN6F=A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Shorten SETUP timeout
To:     khsieh@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sankeerth Billakanti <sbillaka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-10-05 16:04:40)
> On 2021-10-05 15:36, Stephen Boyd wrote:
> > Quoting Bjorn Andersson (2021-10-05 14:40:38)
> >> On Tue 05 Oct 11:45 PDT 2021, Stephen Boyd wrote:
> >>
> >> > Quoting Bjorn Andersson (2021-10-04 19:37:50)
> >> > > Found in the middle of a patch from Sankeerth was the reduction of the
> >> > > INIT_SETUP timeout from 10s to 100ms. Upon INIT_SETUP timeout the host
> >> > > is initalized and HPD interrupt start to be serviced, so in the case of
> >> > > eDP this reduction improves the user experience dramatically - i.e.
> >> > > removes 9.9s of bland screen time at boot.
> >> > >
> >> > > Suggested-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> >> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> > > ---
> >> >
> >> > Any Fixes tag? BTW, the delay design is pretty convoluted. I had to go
> >> > re-read the code a couple times to understand that it's waiting 100ms
> >> > times the 'delay' number. Whaaaaat?
> >> >
> >>
> >> I assume you're happy with the current 10s delay on the current
> >> devices, so I don't think we should push for this to be backported.
> >> I have no need for it to be backported on my side at least.
> >>
> >
> > Sure. Fixes tag != backported to stable trees but it is close.
> >
> >> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >>
>    dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 1); <== to 100ms
>
> This patch will prevent usb3 from working due to dp driver initialize
> phy earlier than usb3 which cause timeout error at power up usb3 phy
> when both edp and dp are enabled.

That sounds pretty bad.

> I had prepared a patch (drm/msm/dp: do not initialize combo phy until
> plugin interrupt) to fix this problem.

Great! When were you planning to report this problem on the list?

> Unfortunately, my patch is depend on Bjorn's patch (PATCH v3 3/5]
> drm/msm/dp: Support up to 3 DP controllers).
> I will submit my patch for review once Bjorn's patches merged in.
> Therefore I would think this patch should go after both Bjorn's patches
> and my patch.
>

Why can't you send it now? Point to the other patch series as a
dependency.
