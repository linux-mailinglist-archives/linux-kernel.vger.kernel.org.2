Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF99423394
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhJEWih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhJEWif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:38:35 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB59EC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:36:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso774425ota.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Ft48Hk1n68Pbbbv8PEM8uaK94jbB+3DvpTmrUODshWs=;
        b=fuO8D1HZqE0QRC5GpyS800L44yJkv8eq3KoFfIz9YbzMy8gLkKwMt3ak48h8SgP/6a
         MQeVZSrXVzFGIZXzKkPlnHuvR/smgI79Gp9ry26Wtn83BDr+9N+s5hf0vtcSiqIJXkCr
         dCVLzMRfCGWeT4zL/RhFyyGcPZALadT1LfwAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Ft48Hk1n68Pbbbv8PEM8uaK94jbB+3DvpTmrUODshWs=;
        b=3ok4DT3CSycyqHzNel0Em2uhsOaQvnU+QbHMEsPbjNAuMcsZZXIZpyCIzkGTe9r/Sr
         sKz/BGndi81gMZB5TyLGOMYaXj/tC2wJcHpznB4aVFowTb6RbBUIH2ZVU1QUFd2h4uAj
         W4sl6+40Iv1+gl8XkCuxJaVrVR323WQ/TH8R7H9SbJSyUh9Q2ZnH258dPNCxg0vHxJ7t
         t54gZwUulsGxjLoQbdxpsuw53nVtqMENYGiRapXPdOKM/AyTT+wNWRuY4bKy4ryYjQth
         0LzInLYHil1d352ZjLQck9SiOKtR8lFHRwMWs37yZ2QqLpMMjla/OnEkzZCjCLHCrvRv
         5Upg==
X-Gm-Message-State: AOAM530ZuZdnvb3y5yXI5/ro+SX8s/XdKuJFOH0Um1x1biacNaOwYOdn
        rLJlHR1FPeTrDNI+VyfUw6MVFPdiDemgrLS/L2zMpQ==
X-Google-Smtp-Source: ABdhPJwXTb3iHipqtroSzM7KoB3GtcUPf2KB8S66ztGQmawIKW5iKloHtwS37bzAg5v7wipOcEhtT5hf+0xu3KA/PDA=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr17124450otn.126.1633473404179;
 Tue, 05 Oct 2021 15:36:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 15:36:43 -0700
MIME-Version: 1.0
In-Reply-To: <YVzGVmJXEDH0HfIL@ripper>
References: <20211005023750.2037631-1-bjorn.andersson@linaro.org>
 <CAE-0n52wN1s=Ph4r4iLposxNPfa562Bv1mM81j1KvNmWOQS1-Q@mail.gmail.com> <YVzGVmJXEDH0HfIL@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 15:36:43 -0700
Message-ID: <CAE-0n53FC7JCCJoye_uKeqaLKrZeHXLtvObxWFedaUzjirmBaA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Shorten SETUP timeout
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sankeerth Billakanti <sbillaka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-05 14:40:38)
> On Tue 05 Oct 11:45 PDT 2021, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2021-10-04 19:37:50)
> > > Found in the middle of a patch from Sankeerth was the reduction of the
> > > INIT_SETUP timeout from 10s to 100ms. Upon INIT_SETUP timeout the host
> > > is initalized and HPD interrupt start to be serviced, so in the case of
> > > eDP this reduction improves the user experience dramatically - i.e.
> > > removes 9.9s of bland screen time at boot.
> > >
> > > Suggested-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> >
> > Any Fixes tag? BTW, the delay design is pretty convoluted. I had to go
> > re-read the code a couple times to understand that it's waiting 100ms
> > times the 'delay' number. Whaaaaat?
> >
>
> I assume you're happy with the current 10s delay on the current
> devices, so I don't think we should push for this to be backported.
> I have no need for it to be backported on my side at least.
>

Sure. Fixes tag != backported to stable trees but it is close.

> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
