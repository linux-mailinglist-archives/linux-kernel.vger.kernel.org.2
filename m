Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68843D2CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhGVSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhGVSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:53:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:33:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t143so7785805oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6sZ7huFu4QsNFxnrBDafBDlbHlNytaLnm0nq8FswDwU=;
        b=WymYdktUlRBmMKQLtjkvozdpaU5i/01Ctu/IIM4hIiKk7uvJhsJPUu24DoxwIWa0So
         0gqburhQ2PKtCgdQEfnB239f1zQZIHbA0RY6AUJNrI4cXXHMnTB1rINT9SSQ7pb3XMWP
         dUMxTtzSoIoVYaLSrWkEi7gBmIhEBfuQ5v4bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6sZ7huFu4QsNFxnrBDafBDlbHlNytaLnm0nq8FswDwU=;
        b=fkEqWHI1JsRFVaHlt/ak2MrzrZzIBSmCwv3nWuYSClVbl1eODb1tVgV+sgwF3yKiAV
         cYTjNyFjrj9xT7UblUKNUYqE5N0T20qgU2JADM4alG7OEQlicaua+bsLmdD2ctiSqOEK
         H8xDw+BneXuRg6+cs1aF7xg+YVwD+/m3hhf7K6LuaNSuRInDjaOi66QfC0exuqZBvYIA
         KC1D1UbTXqqqOuNTsxXb7ziofzfyoVvzfoEfgycFhiPRdsvubGKbnnkvKt1gnuFPaRrj
         pBZHzh7x+N4LRzDu4YcN8kiQGSbgi8t5jEjEmUn6Fy9LZE6fX6Q4YxKsAwgfdwEM2nXP
         8bTg==
X-Gm-Message-State: AOAM532adEB+v3eADjUY17UAjnaTd3zcLQCsNb/WTusBWtfOGJsSzXKQ
        ZWOee9tzZJyw+YUeGbJCStymHHEut4ZY6UnK5p+ebg==
X-Google-Smtp-Source: ABdhPJwqiAw4oHcAYrmnpJwwnDQOY2aWE8FH1iTkin5KHAN8tJqKjH1PqHmOGxwIdHQS6uWixabWA+4VT4Apg9rNolM=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr1094329oiu.19.1626982419605;
 Thu, 22 Jul 2021 12:33:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jul 2021 19:33:39 +0000
MIME-Version: 1.0
In-Reply-To: <20210722024227.3313096-2-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org> <20210722024227.3313096-2-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 22 Jul 2021 19:33:39 +0000
Message-ID: <CAE-0n52g4rxdcLbLBSOqoFywUJUYw6MRtBLv_41MtZSo8AGHnw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: msm/dp: Change reg definition
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-21 19:42:23)
> reg was defined as one region covering the entire DP block, but the
> memory map is actually split in 4 regions and obviously the size of
> these regions differs between platforms.
>
> Switch the reg to require that all four regions are specified instead.
> It is expected that the implementation will handle existing DTBs, even
> though the schema defines the new layout.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
