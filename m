Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8512441FE4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhKASVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhKASVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 14:21:43 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0FC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 11:10:23 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q124so26102887oig.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RTpcjCaKMjk8wOfkGg+XhDUUHXGzz0r5LuC/nlABn74=;
        b=Hms4n8EsBYjDqEWRwfdorGPR19Sl0b3GXGDHqXv7432wT6aufk+qulIlNLvHRxWc7Y
         6GqpCN/WAvrnAbLSSgUR8ItaRk4yqFg2tqM2BQjivbc736Aqte31NKEF7KwCFIxJWVEp
         h49MfXiHYM8ZfKMRwLGJRHnF18Z+2mV7PY2yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RTpcjCaKMjk8wOfkGg+XhDUUHXGzz0r5LuC/nlABn74=;
        b=iW0VBvH359X/3jLH4zw4lWn/RWsok+htQlD4UUtVRGuus01cIw/VeUMbnL+emLC4Uh
         ILWQxE80e+pDtiIPj0fsb/I/9XdAoc7exKmaMR6QkX3pnk+JeTWTRxZe+IUbhpZGp2/T
         xRJgU5fY8PTLslzx1CaQG47KjlfQd/Bt0bE8mUP02W5LdIQMJ/YhXnOZarTxFKjHeyRT
         P300u5RQQpHrdPpEZLVaxFuJzuHI4vF37mDSZbGSLXbilDgHUKuQTnb6vOw0Ifxk9MBB
         CosigeI3qsGXGznpvkMpETddMDLJGh8N2S6dV6XJxDJQ3unFZJ373BuVzRrCEX18WFfj
         3IIA==
X-Gm-Message-State: AOAM5309lHs8fZGSir7ygWZo+ipVNaD4iPxNtI61uysHP9UwH1RmuqDc
        dtqPLYdVwo21hG/9H4Oe0negIpZdEvVQ56/8i2vsbc8Ey44=
X-Google-Smtp-Source: ABdhPJzgFmKoi4uMfFK3RymVte6R4WSjg8lMx4INzmZ1qraDiHERExAQVxP6DSOAOu0WpWxcuwqOAr8FQwmKA+sd1BU=
X-Received: by 2002:a05:6808:2307:: with SMTP id bn7mr519321oib.32.1635790222358;
 Mon, 01 Nov 2021 11:10:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Nov 2021 11:10:21 -0700
MIME-Version: 1.0
In-Reply-To: <20211030100812.1.I6cd9af36b723fed277d34539d3b2ba4ca233ad2d@changeid>
References: <20211030100812.1.I6cd9af36b723fed277d34539d3b2ba4ca233ad2d@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 1 Nov 2021 11:10:21 -0700
Message-ID: <CAE-0n529Nfp7rOA4a4dtvh83rPxjVQ2VK0uDORgzOWmSsDa6rA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: set default num_data_lanes
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, robdclark@chromium.org,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bernard Zhao <bernard@vivo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-10-30 10:08:50)
> If "data_lanes" property of the dsi output endpoint is missing in
> the DT, num_data_lanes would be 0 by default, which could cause
> dsi_host_attach() to fail if dsi->lanes is set to a non-zero value
> by the bridge driver.
>
> According to the binding document of msm dsi controller, the
> input/output endpoint of the controller is expected to have 4 lanes.
> So let's set num_data_lanes to 4 by default.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
