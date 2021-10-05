Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91A1423052
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhJESrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhJESrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:47:42 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA0C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:45:51 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so63332otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OHTvFeyJP3J+uo/9wz+ahOIzpwEg9uJmeumv+TyQfVM=;
        b=KlgpGE95LIxZlb/pXE9cZu9nugQIb8LshfOewuCbEuACzl+rQB1xWDjBU3mPOLrDcW
         j5C+gbD94hGL4uSgBoXfUM5rt42vBONs9pSviN0hEYnzNWeOvmPxCoa6eWbHPVH7pzq8
         9uUd3ccnAK2NsO+petzbwloyc4I76262QBVaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OHTvFeyJP3J+uo/9wz+ahOIzpwEg9uJmeumv+TyQfVM=;
        b=xAQuCed2edEG+zxNQIjCpEiREhAJwn5e9jHT0CBhfJ3qjgitWy8RURhNEBEtf3uboD
         QrxVa5fuoR0rgamArVEWQNSNFZDRp0zEHDKzQdWo2/9hVakNXEangmxK4TV0tp8Hhokc
         /nJ3kQp4/5bGdKtiG30sNVJsKOwWDVbdMlAF6QI5BhrK5YyyGf+K95CUMBYiKmBCsfQ9
         MHF1+Lii1u7yJtC5eJdqk0VBx8hLRQPr9UjD+Y4sbRavvPYLJjHq3pbys3oRwRSljdrn
         gavLFHNAl/8uEpPgnC2le8l7NdC3a316aRwgZZbHRCwyDOZPL74BZxN5UYzA+g9OQZf8
         8Bxw==
X-Gm-Message-State: AOAM530JRp2n23OcRhGMqcgIQv5UZTJmeZ0T2/h9XJdI0CyQhgmXAiyM
        zyYm056I8EGIGnhZbLIa/LE1EION3Rjc/Ff6y42PVw==
X-Google-Smtp-Source: ABdhPJzA4iPXbH8yz7UdLkbyMSd1FJG8yE9lKOiGiI04UiNVk5/3sbM0WRNEBTKxB3XmF+4HfBHW7j8fmcgm3mYJLEA=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr16240694otn.126.1633459551057;
 Tue, 05 Oct 2021 11:45:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Oct 2021 11:45:50 -0700
MIME-Version: 1.0
In-Reply-To: <20211005023750.2037631-1-bjorn.andersson@linaro.org>
References: <20211005023750.2037631-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 5 Oct 2021 11:45:50 -0700
Message-ID: <CAE-0n52wN1s=Ph4r4iLposxNPfa562Bv1mM81j1KvNmWOQS1-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Shorten SETUP timeout
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sankeerth Billakanti <sbillaka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-04 19:37:50)
> Found in the middle of a patch from Sankeerth was the reduction of the
> INIT_SETUP timeout from 10s to 100ms. Upon INIT_SETUP timeout the host
> is initalized and HPD interrupt start to be serviced, so in the case of
> eDP this reduction improves the user experience dramatically - i.e.
> removes 9.9s of bland screen time at boot.
>
> Suggested-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Any Fixes tag? BTW, the delay design is pretty convoluted. I had to go
re-read the code a couple times to understand that it's waiting 100ms
times the 'delay' number. Whaaaaat?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
