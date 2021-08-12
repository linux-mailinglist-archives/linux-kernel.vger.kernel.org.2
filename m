Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C43EA966
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhHLRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHLRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:23:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A75C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:23:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r72so9434950iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRwzKSay2n+yQfmhBPOFfDNxmLPMQg6PC0lXLvxAvL8=;
        b=Bh074U0YkS72TlAp7BoXqHTJFFM+Kpvlod9cHdGDbEvZxvD/WDOg3Uc8bwHw0XuXHR
         gR6QY2KTEoTvpqCgEQpyiOdXq/Y0PNq6zEbZywP4dsfckhwXLli67gfBLkr1fxY8sSCu
         ZZY3+cfWMnUPqp74qIF2TVpKDoMx3ryHreSAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRwzKSay2n+yQfmhBPOFfDNxmLPMQg6PC0lXLvxAvL8=;
        b=JWajenvFB6D6DnuGMXlfXlA0lT2wKOtufKOMoRKeqmAUIn6HQnkeQEpOIiFs81oDKj
         0xx0eGVL2D8epOHS7DySX0sGMCxID/QqIZeLlEhiqk4FYCxB37VZ8VMYGIDvm0GJIOgS
         MbsWEP6u5riS7kpaHjWKVcf46FbM3pVVZvBY4xmRF6IhzszlWxw2ZrQI+ZeJEHsnpPPP
         SIhLQpRXunzOYEy1PmaJxoZljR00/CIa48tbIJiT1YvjGdV+pbw2PZ0YkF+M/okRz7IN
         nxgcP+mLQyvjqwYd2VscHDDHorqW4pthq0ABBrccKLl+3omOSQ601YFf20af83hn2bCx
         84kA==
X-Gm-Message-State: AOAM532Y/JVQhfD/8Nf/qcIZit15MHJW4KJpk0z8NXveHCwpG1P0MYaW
        3CsuL/VIha+2T8dt2bJsH0w6mMnylOUT4Q==
X-Google-Smtp-Source: ABdhPJy8KBmql2gBaK8/sUsgMS4DyvmV/HjweeK0u3LEpOTJT4S3kncNFzQ/Gd5oUtkiRArERfbMlw==
X-Received: by 2002:a02:698b:: with SMTP id e133mr4680273jac.125.1628789008951;
        Thu, 12 Aug 2021 10:23:28 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id e1sm1850093ils.76.2021.08.12.10.23.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:23:27 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id i9so7772335ilk.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:23:27 -0700 (PDT)
X-Received: by 2002:a92:d84f:: with SMTP id h15mr3825806ilq.12.1628789006912;
 Thu, 12 Aug 2021 10:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210811235253.924867-1-robdclark@gmail.com> <20210811235253.924867-4-robdclark@gmail.com>
In-Reply-To: <20210811235253.924867-4-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Aug 2021 10:23:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U__Ge_6MkvxmcOQe49Q7NG94Bi3T2xNNiec-NF9J8tJg@mail.gmail.com>
Message-ID: <CAD=FV=U__Ge_6MkvxmcOQe49Q7NG94Bi3T2xNNiec-NF9J8tJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/bridge: ti-sn65dsi86: Implement bridge->mode_valid()
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 11, 2021 at 4:51 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> For the brave new world of bridges not creating their own connectors, we
> need to implement the max clock limitation via bridge->mode_valid()
> instead of connector->mode_valid().
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)

This looks good to me. I'll plan to land this together with the next
patch into drm-misc-next sometime next week unless someone beats me to
it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
