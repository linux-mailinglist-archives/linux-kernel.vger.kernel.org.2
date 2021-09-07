Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3E402F2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbhIGTzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbhIGTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:55:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69545C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:54:37 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso630096otu.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=eNsppomO2keBxhHRJ7cqRlPWMOENEgbNhprLa49KjSM=;
        b=YWKQpuDTWMbaSnr4MYGCvvYX0uC0P8bk55rrQDQuuTxwbve1htEfv+rNldGQGBFijR
         lTuL+tWvTOIU9bogyI7lhadaIhzVw4LkeAxdmOmmTD235DXvZdEBHuyW31GWRjgrmPDq
         ClYW2lZJFPY0cRtQVL6Nr8IeQDQzPNs0EmE44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=eNsppomO2keBxhHRJ7cqRlPWMOENEgbNhprLa49KjSM=;
        b=DI5N804eot2GGJPcwxj3g+6wJiVt0PbUBvD346tRQX6eikQAvCo985nIsVRaaQIasY
         83CjHhaW18fJLbVBBCsRbhzx1rIaa4ZYvA177/yoHk7ZNO2i3sNRM33lOlPWkOi38lFJ
         pDOKHdjSY/XBwnf/7pCKclzgVPIG3CsPyOrSBW7Swz4ZwrUsTDREzzbcKjhqTxAPml5O
         Cne/iwDbrUQkKmqx/jfzZZ91b8t2qJk6Skkr9y5oXVeWr9MxUqJVm4llWDY/SoYyOpQ7
         8WOQ4zLyHQAXi/cTamNhISfHfkXG8Iekg08bowNgu0308W2K3AOkUXXv2hloC3LTBITB
         +vEg==
X-Gm-Message-State: AOAM5330tOSpnN8jT9V/0ZQUi/HPK3h8F5H0lE3oXn7CHgHujI7q36kD
        +KmhFid/GZMi0svxShWe4YrYpxfxiFEaufherzHsWg==
X-Google-Smtp-Source: ABdhPJyzr8qP5oUk1QZh/gt5W0hV8SHhW6pfNwmQGQwevcEdl4gAcrYQ1vaogwGyVNGWcD4XZl+Z04zpjOFAEiXA6aI=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr87159ots.77.1631044476816;
 Tue, 07 Sep 2021 12:54:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Sep 2021 19:54:36 +0000
MIME-Version: 1.0
In-Reply-To: <587ed6fd-0203-cb7d-338f-185185d88f76@codeaurora.org>
References: <20210903100153.9137-1-srivasam@codeaurora.org>
 <CAE-0n50=vL0MHHHkc22ahrqqD3DskFXZzFU8qjU8=EY1kZ+__Q@mail.gmail.com> <587ed6fd-0203-cb7d-338f-185185d88f76@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 7 Sep 2021 19:54:36 +0000
Message-ID: <CAE-0n52cvV3yqaU0Ea50MYXMQa6Ot2z1_0NfUpDeZj9_M=joiQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-platform: Reset irq clear reg post
 handling interrupts
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-09-06 06:35:46)
> Thanks for Your time Stephen!!
>
> On 9/4/2021 12:10 AM, Stephen Boyd wrote:
> > Quoting Srinivasa Rao Mandadapu (2021-09-03 03:01:53)
> >> Update interrupt clear register with reset value after addressing
> >> all interrupts. This is to fix playback or capture hanging issue in
> >> simultaneous playback and capture usecase.
> >>
> >> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> >> ---
> > Any Fixes tag?
> Actually it's incremental change. I will add base commit of this function.

Ok.

> >
> >>   sound/soc/qcom/lpass-platform.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> >> index f9df76d37858..1a0a4b0b1a03 100644
> >> --- a/sound/soc/qcom/lpass-platform.c
> >> +++ b/sound/soc/qcom/lpass-platform.c
> >> @@ -749,6 +749,12 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
> >>                  }
> >>          }
> >>
> >> +       rv = regmap_write(drvdata->lpaif_map, LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST), 0x0);
> >> +       if (rv) {
> >> +               pr_err("error writing to irqstat reg: %d\n", rv);
> >> +               return IRQ_NONE;
> > I was thinking we should return IRQ_HANDLED still, but then I guess
> > failing to clear the irq be treated as a spurious irq so that if we fail
> > enough times we'll shut off the irq at the irqchip. Things are going bad
> > if the write fails.
> Here bit confusing. Could You please suggest How to go ahead on this?

Sorry. I think it is fine as is.
